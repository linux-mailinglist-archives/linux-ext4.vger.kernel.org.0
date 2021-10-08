Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157C842621C
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 03:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhJHBkb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 21:40:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:24175 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhJHBka (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 21:40:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HQW5D3Yj7z1DHdZ;
        Fri,  8 Oct 2021 09:37:04 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 09:38:32 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 09:38:32 +0800
Message-ID: <2627cb7a-b552-4cf3-fabe-3600535329ff@huawei.com>
Date:   Fri, 8 Oct 2021 09:38:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 2/2] ext4: check magic even the extent block bh is
 verified
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
 <20210904044946.2102404-3-yangerkun@huawei.com>
 <20211001091833.GB28799@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
In-Reply-To: <20211001091833.GB28799@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/10/1 17:18, Jan Kara 写道:
> On Sat 04-09-21 12:49:46, yangerkun wrote:
>> Our stress testing with IO error can trigger follow OOB with a very low
>> probability.
>>
>> [59898.282466] BUG: KASAN: slab-out-of-bounds in ext4_find_extent+0x2e4/0x480
>> ...
>> [59898.287162] Call Trace:
>> [59898.287575]  dump_stack+0x8b/0xb9
>> [59898.288070]  print_address_description+0x73/0x280
>> [59898.289903]  ext4_find_extent+0x2e4/0x480
>> [59898.290553]  ext4_ext_map_blocks+0x125/0x1470
>> [59898.295481]  ext4_map_blocks+0x5ee/0x940
>> [59898.315984]  ext4_mpage_readpages+0x63c/0xdb0
>> [59898.320231]  read_pages+0xe6/0x370
>> [59898.321589]  __do_page_cache_readahead+0x233/0x2a0
>> [59898.321594]  ondemand_readahead+0x157/0x450
>> [59898.321598]  generic_file_read_iter+0xcb2/0x1550
>> [59898.328828]  __vfs_read+0x233/0x360
>> [59898.328840]  vfs_read+0xa5/0x190
>> [59898.330126]  ksys_read+0xa5/0x150
>> [59898.331405]  do_syscall_64+0x6d/0x1f0
>> [59898.331418]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Digging deep and we found it's actually a xattr block which can happened
>> with follow steps:
>>
>> 1. extent update for file1 and will remove a leaf extent block(block A)
>> 2. we need update the idx extent block too
>> 3. block A has been allocated as a xattr block and will set verified
>> 3. io error happened for this idx block and will the buffer has been
>>     released late
>> 4. extent find for file1 will read the idx block and see block A again
>> 5. since the buffer of block A is already verified, we will use it
>>     directly, which can lead the upper OOB
>>
>> Same as __ext4_xattr_check_block, we can check magic even the buffer is
>> verified to fix the problem.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> Honestly, I'm not sure if this is worth it. What you suggest will work if
> the magic is overwritten but if we reallocate the block for something else
> but the magic happens to stay intact, we have a problem. The filesystem is
> corrupted at that point with metadata blocks being multiply claimed and
> that's very difficult to deal with. Maybe we should start ignoring
> buffer_verified() bit once the fs is known to have errors and recheck the
> buffer contents on each access? Sure it will be slow but I have little
> sympathy towards people running filesystems with errors... What do people
> think?

What you means was that something like a extent block for inode A has
been reallocate as a extent block for inode B? Ignoring buffer_verified
seems useless for this case since extent check will pass. Maybe we
should first try to prevent the OOB...


> 
> 								Honza
> 
>> ---
>>   fs/ext4/extents.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 8559e288472f..d2e2ae90bc4a 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -506,6 +506,14 @@ __read_extent_tree_block(const char *function, unsigned int line,
>>   			goto errout;
>>   	}
>>   	if (buffer_verified(bh)) {
>> +		if (unlikely(ext_block_hdr(bh)->eh_magic != EXT4_EXT_MAGIC)) {
>> +			err = -EFSCORRUPTED;
>> +			ext4_error_inode(inode, function, line, 0,
>> +				"invalid magic for verified extent block %llu",
>> +				(unsigned long long)bh->b_blocknr);
>> +			goto errout;
>> +		}
>> +
>>   		if (!(flags & EXT4_EX_FORCE_CACHE))
>>   			return bh;
>>   	} else {
>> -- 
>> 2.31.1
>>
