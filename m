Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301BF4F5E0E
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiDFMev (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 08:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbiDFMdS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Apr 2022 08:33:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B92DCC87;
        Wed,  6 Apr 2022 01:31:48 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYHjz45tKzDqMd;
        Wed,  6 Apr 2022 16:29:27 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:31:46 +0800
Subject: Re: [PATCH -next] ext4: Fix symlink file size not match to file
 content
To:     Jan Kara <jack@suse.cz>
CC:     Ye Bin <yebin10@huawei.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lczerner@redhat.com>
References: <20220321113408.4112428-1-yebin10@huawei.com>
 <20220321113703.cibgeac5ipslg3df@quack3.lan>
 <5b3e0bb7-370b-a950-1d2f-b0e31357cc01@huawei.com>
 <20220321151141.hypnhr6o4vng2sa6@quack3.lan>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <75227a4a-2e32-463a-ade7-57c37a3fbf4b@huawei.com>
Date:   Wed, 6 Apr 2022 16:31:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220321151141.hypnhr6o4vng2sa6@quack3.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/3/21 23:11, Jan Kara wrote:
> Hello Yi!
> 
> On Mon 21-03-22 22:38:49, Zhang Yi wrote:
>> On 2022/3/21 19:37, Jan Kara wrote:
>>> On Mon 21-03-22 19:34:08, Ye Bin wrote:
>>>> We got issue as follows:
>>>> [home]# fsck.ext4  -fn  ram0yb
>>>> e2fsck 1.45.6 (20-Mar-2020)
>>>> Pass 1: Checking inodes, blocks, and sizes
>>>> Pass 2: Checking directory structure
>>>> Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
>>>> Clear? no
>>>> Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
>>>> Fix? no
>>>>
>>>> As symlink file size not match to file content. If symlink data block
>>>> writback failed, will call ext4_finish_bio to end io. In this path don't
>>>> mark buffer error. When umount do checkpoint can't detect buffer error,
>>>> then will cleanup jounral. Actually, correct data maybe in journal area.
>>>> To solve this issue, mark buffer error when detect bio error in
>>>> ext4_finish_bio.
>>>
>>> Thanks for the patch! Let me rephrase the text a bit:
>>>
>>> As the symlink file size does not match the file content. If the writeback
>>> of the symlink data block failed, ext4_finish_bio() handles the end of IO.
>>> However this function fails to mark the buffer with BH_write_io_error and
>>> so when unmount does journal checkpoint it cannot detect the writeback
>>> error and will cleanup the journal. Thus we've lost the correct data in the
>>> journal area. To solve this issue, mark the buffer as BH_write_io_error in
>>> ext4_finish_bio().
>>>
>>
>> Thinking about this issue in depth, the symlink data block is one kind of
>> metadata, but the page mapping of such block is belongs to the ext4 inode,
>> it's not coordinate to other metadata blocks, e.g. directory block and extents
>> block. This is why we have already fix the same issue of other metadata blocks
>> in commit fcf37549ae19e9 "jbd2: ensure abort the journal if detect IO error
>> when writing original buffer back" but missing the case of symlink data block.
>> So, after Ye Bin's fix, I think it's worth to unify the symlink data block
>> mapping to bdev, any suggestions?
> 
> Well, symlink with external block is essentially a case of data=journal
> data block. So even if we would handle symlinks, we would still need to
> deal with other inodes with journalled data. Also we need to keep the> symlink contents in the page cache to make it simple for generic VFS code
> handling symlinks. So I don't see how we could substantially unify
> things...
> 

Yeah, this fix is still needed for other regular file's journalled data when we
mounted filesystem with data=jouranl mode. But if we just consider whether if we
could unify the journal mode of ext4's metadata blocks, it seems that using
data=journal mode for symlink's external data block is also complicated and
confused in the creating procedure. Instead, if we use ext4_bread(), it make
things clear, and it seems also has no side effect of reading symlinks. I write
a RFC patch to do this, please take a look at my latest mail "[RFC PATCH] ext4:
convert symlink external data block mapping to bdev".

Thanks,
Yi.
