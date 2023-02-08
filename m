Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A1F68E8B6
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Feb 2023 08:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjBHHKl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Feb 2023 02:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHHKk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Feb 2023 02:10:40 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DD219F11
        for <linux-ext4@vger.kernel.org>; Tue,  7 Feb 2023 23:10:37 -0800 (PST)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PBWNW10dwzrRt7;
        Wed,  8 Feb 2023 15:10:19 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 8 Feb 2023 15:10:35 +0800
Message-ID: <c7a79489-c0d7-968b-4fa5-c698ceb63bf9@huawei.com>
Date:   Wed, 8 Feb 2023 15:10:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/2] ext4: restore len when ext4_ext_insert_extent
 failed
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <jack@suse.com>, <linux-ext4@vger.kernel.org>,
        <yi.zhang@huawei.com>, <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
References: <20230207070931.2189663-1-zhanchengbin1@huawei.com>
 <20230207070931.2189663-3-zhanchengbin1@huawei.com>
 <20230207142356.frf4zzpqlh7mlwft@quack3>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230207142356.frf4zzpqlh7mlwft@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml100014.china.huawei.com (7.185.36.96) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for your comments.
I've analyzed this situation, If a failure occurs at a certain layer, the
start of the upper and lower logical blocks is different, this's same as
ext4_ext_rm_idx.
If this happens data is not flushed to disks so data on disks is
consistent, but data on the memory is inconsistent (have journal). In my
opinion, we just need to ensure that we don't use the wrong data and flush
to disk. Look code we can know if ext4_ext_get_access and ext4_ext_dirty
faild, the verified flag of bh will be cleared, if read this bad inode
again, read_extent_tree_block will check verified flag and goto
__ext4_ext_check, finally, return error in the ext4_valid_extent_entries
function if the logical block start is incorrect, So does not change the
consistency of data on the disk. (Emmmmmm, I misunderstand the judgment in
ext4_valid_extent_entries. Later, I will clear the verified flag from the
modified bh when ext4_valid_extent_entries fails.)
If no journal, the data on the disk is inconsistent, too. Can use fsck to
fix it.
What do you think?

  - bin.

On 2023/2/7 22:23, Jan Kara wrote:
> On Tue 07-02-23 15:09:31, zhanchengbin wrote:
>> Inside the ext4_ext_insert_extent function, every error returned will
>> not destroy the consistency of the tree. Even if it fails after changing
>> half of the tree, can also ensure that the tree is self-consistent, like
>> function ext4_ext_create_new_leaf.
> 
> Hum, but e.g. if ext4_ext_correct_indexes() fails, we *will* end up with
> corrupted extent tree pretty much without a chance for recovery, won't we?
> 
> 								Honza
> 
>> After ext4_ext_insert_extent fails, update extent status tree depends on
>> the incoming split_flag. So restore the len of extent to be split when
>> ext4_ext_insert_extent return failed in ext4_split_extent_at.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>   fs/ext4/extents.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 3559ea6b0781..b926fef73de4 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -935,6 +935,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
>>   
>>   		bh = read_extent_tree_block(inode, path[ppos].p_idx, --i, flags);
>>   		if (IS_ERR(bh)) {
>> +			EXT4_ERROR_INODE(inode, "IO error reading extent block");
>>   			ret = PTR_ERR(bh);
>>   			goto err;
>>   		}
>> @@ -3251,7 +3252,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>   		ext4_ext_mark_unwritten(ex2);
>>   
>>   	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>> -	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>> +	if (!err)
>>   		goto out;
>>   
>>   	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>> -- 
>> 2.31.1
>>
