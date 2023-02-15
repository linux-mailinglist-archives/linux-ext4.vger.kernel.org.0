Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5569787B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Feb 2023 09:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBOIv2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Feb 2023 03:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBOIv1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Feb 2023 03:51:27 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF32E0E3
        for <linux-ext4@vger.kernel.org>; Wed, 15 Feb 2023 00:51:26 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PGsBS4sPLzJr8J;
        Wed, 15 Feb 2023 16:46:40 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 15 Feb 2023 16:51:24 +0800
Message-ID: <a666524b-e811-c35e-3f2b-f2d63622f674@huawei.com>
Date:   Wed, 15 Feb 2023 16:51:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 1/2] ext4: fix inode tree inconsistency caused by
 ENOMEM in ext4_split_extent_at
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <20230213040522.3339406-1-zhanchengbin1@huawei.com>
 <20230213040522.3339406-2-zhanchengbin1@huawei.com>
 <20230214114835.hpjr4zgofrcp7hyy@quack3>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230214114835.hpjr4zgofrcp7hyy@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500025.china.huawei.com (7.185.36.35) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/2/14 19:48, Jan Kara wrote:
> On Mon 13-02-23 12:05:21, zhanchengbin wrote:
>> If ENOMEM fails when the extent is splitting, we need to restore the length
>> of the split extent.
>> In the call stack of the ext4_split_extent_at function, only in
>> ext4_ext_create_new_leaf will it alloc memory and change the shape of the
>> extent tree,even if an ENOMEM is returned at this time, the extent tree is
>> still self-consistent, Just restore the split extent lens in the function
>> ext4_split_extent_at.
>>
>> ext4_split_extent_at
>>   ext4_ext_insert_extent
>>    ext4_ext_create_new_leaf
>>     1)ext4_ext_split
>>       ext4_find_extent
>>     2)ext4_ext_grow_indepth
>>       ext4_find_extent
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 9de1c9d1a13d..0f95e857089e 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>>   
>>   		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
>>   		if (IS_ERR(bh)) {
>> +			EXT4_ERROR_INODE(inode, "IO error reading extent block");
> 
> Why have you added this? Usually we don't log any additional errors for IO
> errors because the storage layer already reports it... Furthermore this
> would potentialy panic the system / remount the fs RO which we also usually
> don't do in case of IO errors, only in case of FS corruption.
> 
> 								Honza

Because failure of read_extent_tree_block indirectly leads to filesystem
inconsistency in ext4_split_extent_at, I want the filesystem to become
read-only after failure.

  - bin.

> 
>>   			ret = PTR_ERR(bh);
>>   			goto err;
>>   		}
>> @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>   		ext4_ext_mark_unwritten(ex2);
>>   
>>   	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>> -	if (err != -ENOSPC && err != -EDQUOT)
>> +	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>>   		goto out;
>>   
>>   	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>> -- 
>> 2.31.1
>>
