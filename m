Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A5E4F7934
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Apr 2022 10:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiDGIQ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Apr 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiDGIQ1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Apr 2022 04:16:27 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935281C42DA
        for <linux-ext4@vger.kernel.org>; Thu,  7 Apr 2022 01:14:26 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYvJ80rq8zgYH5;
        Thu,  7 Apr 2022 16:12:40 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Apr 2022 16:14:24 +0800
Subject: Re: [RFC PATCH] ext4: convert symlink external data block mapping to
 bdev
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>,
        <yebin10@huawei.com>
References: <20220406084503.1961686-1-yi.zhang@huawei.com>
 <20220406171715.35euuzocoe4ljepe@quack3.lan>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <806b63ff-975d-123d-5925-587aa026ce94@huawei.com>
Date:   Thu, 7 Apr 2022 16:14:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220406171715.35euuzocoe4ljepe@quack3.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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



On 2022/4/7 1:17, Jan Kara wrote:
> On Wed 06-04-22 16:45:03, Zhang Yi wrote:
>> Symlink's external data block is one kind of metadata block, and now
>> that almost all ext4 metadata block's page cache (e.g. directory blocks,
>> quota blocks...) belongs to bdev backing inode except the symlink. It
>> is essentially worked in data=journal mode like other regular file's
>> data block because probably in order to make it simple for generic VFS
>> code handling symlinks or some other historical reasons, but the logic
>> of creating external data block in ext4_symlink() is complicated. and it
>> also make things confused if user do not want to let the filesystem
>> worked in data=journal mode. This patch convert the final exceptional
>> case and make things clean, move the mapping of the symlink's external
>> data block to bdev like any other metadata block does.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>> This RFC patch follow the talking of whether if we could unify the
>> journal mode of ext4 metadata blocks[1], it stop using the data=journal
>> mode for the final exception case of symlink's external data block. Any
>> comments are welcome, thanks.
>>
>> [1]. https://lore.kernel.org/linux-ext4/20220321151141.hypnhr6o4vng2sa6@quack3.lan/T/#m84b942a6bb838ba60ae8afd906ebbb987a577488
>>
>>  fs/ext4/inode.c   |   9 +---
>>  fs/ext4/namei.c   | 123 +++++++++++++++++++++-------------------------
>>  fs/ext4/symlink.c |  44 ++++++++++++++---
>>  3 files changed, 93 insertions(+), 83 deletions(-)
> 
> Hum, we don't save on code but I'd say the result is somewhat more
> standard. So I guess this makes some sense. Let's see what Ted thinks...
> 
> Otherwise I've found just one small bug below.
> 
>> @@ -3270,26 +3296,8 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
>>  	if (err)
>>  		return err;
>>  
>> -	if ((disk_link.len > EXT4_N_BLOCKS * 4)) {
>> -		/*
>> -		 * For non-fast symlinks, we just allocate inode and put it on
>> -		 * orphan list in the first transaction => we need bitmap,
>> -		 * group descriptor, sb, inode block, quota blocks, and
>> -		 * possibly selinux xattr blocks.
>> -		 */
>> -		credits = 4 + EXT4_MAXQUOTAS_INIT_BLOCKS(dir->i_sb) +
>> -			  EXT4_XATTR_TRANS_BLOCKS;
>> -	} else {
>> -		/*
>> -		 * Fast symlink. We have to add entry to directory
>> -		 * (EXT4_DATA_TRANS_BLOCKS + EXT4_INDEX_EXTRA_TRANS_BLOCKS),
>> -		 * allocate new inode (bitmap, group descriptor, inode block,
>> -		 * quota blocks, sb is already counted in previous macros).
>> -		 */
>> -		credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
>> -			  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
>> -	}
>> -
>> +	credits = EXT4_DATA_TRANS_BLOCKS(dir->i_sb) +
>> +		  EXT4_INDEX_EXTRA_TRANS_BLOCKS + 3;
> 
> This does not seem like enough credits - we may need to allocate inode, add
> entry to directory, allocate & initialize symlink block. So I think you
> need to add 4 for block allocation + init in case of non-fast symlink. And
> please keep the comment explaining what is actually counted in the number
> of credits...
> 

Thanks for pointing this out, and ext4_mkdir() seems has the same problem too
because we also need to allocate one more block to store '.' and '..' entries
for a new created empty directory.

BTW, look the credits calculation in depth, the definition of
EXT4_DATA_TRANS_BLOCKS is weird, the '-2' subtraction looks wrong.

> #define EXT4_DATA_TRANS_BLOCKS(sb)	(EXT4_SINGLEDATA_TRANS_BLOCKS(sb) + \
> 					 EXT4_XATTR_TRANS_BLOCKS - 2 + \
> 					 EXT4_MAXQUOTAS_TRANS_BLOCKS(sb))

I see the history log, before commit[1], the '-2' subtract the 2 more duplicate
counted super block in '3 * EXT3_SINGLEDATA_TRANS_BLOCKS', but after this commit,
it seems buggy because we have only count the super block once. It's a long time
ago, I'm not sure am I missing something?

[1]. https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=2df2c24aa6d2cd56777570d96494b921568b4405

Thanks,
Yi.
