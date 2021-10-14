Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A63442D374
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Oct 2021 09:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhJNHXn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Oct 2021 03:23:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:25184 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNHXm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Oct 2021 03:23:42 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HVLQg16CNz8tfZ;
        Thu, 14 Oct 2021 15:20:27 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 15:21:28 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Thu, 14 Oct 2021 15:21:28 +0800
Message-ID: <91ba3949-3ee3-e661-aad5-61e6ddc1b9d1@huawei.com>
Date:   Thu, 14 Oct 2021 15:21:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] ext4: check magic even the extent block bh is
 verified
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
 <20210904044946.2102404-3-yangerkun@huawei.com>
 <20211001091833.GB28799@quack2.suse.cz> <YVcWh6KqzJQytiSJ@mit.edu>
From:   yangerkun <yangerkun@huawei.com>
In-Reply-To: <YVcWh6KqzJQytiSJ@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


在 2021/10/1 22:09, Theodore Ts'o 写道:
> On Fri, Oct 01, 2021 at 11:18:33AM +0200, Jan Kara wrote:
>>>
>>> Digging deep and we found it's actually a xattr block which can happened
>>> with follow steps:
>>>
>>> 1. extent update for file1 and will remove a leaf extent block(block A)
>>> 2. we need update the idx extent block too
>>> 3. block A has been allocated as a xattr block and will set verified
>>> 3. io error happened for this idx block and will the buffer has been
>>>     released late
>>> 4. extent find for file1 will read the idx block and see block A again
>>> 5. since the buffer of block A is already verified, we will use it
>>>     directly, which can lead the upper OOB
>>>
>>> Same as __ext4_xattr_check_block, we can check magic even the buffer is
>>> verified to fix the problem.
>>>
>>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>>
>> Honestly, I'm not sure if this is worth it. What you suggest will work if
>> the magic is overwritten but if we reallocate the block for something else
>> but the magic happens to stay intact, we have a problem. The filesystem is
>> corrupted at that point with metadata blocks being multiply claimed and
>> that's very difficult to deal with. Maybe we should start ignoring
>> buffer_verified() bit once the fs is known to have errors and recheck the
>> buffer contents on each access? Sure it will be slow but I have little
>> sympathy towards people running filesystems with errors... What do people
>> think?
> 
> At some point, if we transition away from using buffer_heads for the
> jbd2 layer, and use our own ext4_metadata_buf structure which
> incorporates the journal_head and buffer_head fields, this will allow
> us to control our own writeback, and allow us to have our own error
> callbacks so we can do things like declare an inode to be bad and not
> to be referenced again.  This would allow us to have a metadata type
> field, so we could know that a buffer had been verified as an inode
> table block, or bitmap block, or an xattr block.
> 
> However, I think the bigger issue is that even if we had a metadata
> type field in the buffer_head (or ext4_metadata_buf), we should be
> using the metadata validation, and buffer_verified bit, as a backup.
> It should not be the primary line of defense.
> 
> So what I would suggest doing is preventing the out of bounds
> reference in ext4_find_extent() in the first place.  I note we're not
> sanity checking the values of EXT4_{FIRST,LAST}_{EXTENT,INDEX} used in
> ext4_ext_binsearch() and ext4_ext_binsearch_idx(), and that's probably
> how we triggered the out of bounds read in the first place.  The cost
> of making sure that pointers returned by
> EXT4_{FIRST,LAST}_{EXTENT,INDEX} don't exceed the bounds of the extent
> tree node would be minimal, and it would be an additional cross check
> which would protect us against the buffer getting corrupted while in
> memory (bit flips, or wild pointer dereferences).

Sorry for the latter replay.

This can prevent a corrupt extent block buffer(maybe a xattr block for 
another file) with verified trigger the OOB. But once corrupt data in 
extent block buffer won't trigger OOB. We pass the check and will use a 
xattr block's data as a extent block. This may trigger other 
unpredictable result...

The patch I send check the magic to ensure the block is really a extent 
block which prevent this case. But for the case a extent block been 
reallocated as another file's extent block. This seems useless and will 
lead to some problem too. But we may first stop the unpredictable result 
like the OOB or other error.

> 
> Cheers,
> 
> 						- Ted
> .
> 
