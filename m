Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE8C62BF2C
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Nov 2022 14:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiKPNO2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Nov 2022 08:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiKPNOU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Nov 2022 08:14:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20D3E08C;
        Wed, 16 Nov 2022 05:14:18 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NC3Qp2gT1zmW2H;
        Wed, 16 Nov 2022 21:13:54 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 21:14:16 +0800
Message-ID: <85db0e08-2413-5b6e-1477-47e369cb9f8a@huawei.com>
Date:   Wed, 16 Nov 2022 21:14:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/3] ext4: fix corrupt backup group descriptors after
 online resize
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>, Baokun Li <libaokun1@huawei.com>
References: <20221116072802.526990-1-libaokun1@huawei.com>
 <20221116072802.526990-3-libaokun1@huawei.com>
 <20221116114929.wmawudyczia55gpe@quack3>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20221116114929.wmawudyczia55gpe@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2022/11/16 19:49, Jan Kara wrote:
> On Wed 16-11-22 15:28:01, Baokun Li wrote:
>> In commit 9a8c5b0d0615 ("ext4: update the backup superblock's at the end
>> of the online resize"), it is assumed that update_backups() only updates
>> backup superblocks, so each b_data is treated as a backupsuper block to
>> update its s_block_group_nr and s_checksum. However, update_backups()
>> also updates the backup group descriptors, which causes the backup group
>> descriptors to be corrupted.
>>
>> The above commit fixes the problem of invalid checksum of the backup
>> superblock. The root cause of this problem is that the checksum of
>> ext4_update_super() is not set correctly. This problem has been fixed
>> in the previous patch ("ext4: fix bad checksum after online resize").
>> Therefore, roll back some modifications in the above commit.
>>
>> Fixes: 9a8c5b0d0615 ("ext4: update the backup superblock's at the end of the online resize")
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> So I agree commit 9a8c5b0d0615 is broken and does corrupt group
> descriptors. However I don't see how PATCH 1/3 in this series would fix all
> the problems commit 9a8c5b0d0615 is trying to fix. In particular checksums
> on backup superblocks will not be properly set by the resize code AFAICT.
>
> 								Honza
I didn't find these two issues to be the same until I researched the 
problem in
PATCH 3/3 and found that commit 9a8c5b0d0615 introduced a similar problem.
Then, it is found that the backup superblock is directly copied from the 
primary
superblock. If the backup superblock is faulty, the primary superblock 
must be
faulty. In this case, patch 1 that fixes the primary superblock problem 
is thought
of. So by rolling back commit 9a8c5b0d0615 to verify, I found that patch 
1 did
fix the problem.

Only ext4_flex_group_add() and ext4_group_extend_no_check() call
update_backups() to update the backup superblock. Both of these functions
correctly set the checksum of the primary superblock. The backup superblocks
that are copied from them are also correct.

In ext4_flex_group_add(), we only update the backup superblock if there 
are no
previous errors, indicating that we must have updated the checksum in
ext4_update_super() before executing update_backups(). The previous problem
was that after we updated the checksum in ext4_update_super(), we modified
s_overhead_clusters, so the checksums for both the primary and backup 
superblocks
were incorrect. This problem has been fixed in PATCH 1/3, so checksum is set
correctly in ext4_flex_group_add().

The same is true in ext4_group_extend_no_check(), we only update the backup
superblock if there are no errors, and we execute ext4_superblock_csum_set()
to update the checksum before updating the backup superblock. Therefore,
checksum is correctly set in ext4_group_extend_no_check().

I think we only need to ensure that the checksum is set correctly when 
the buffer
lock of sbi->s_sbh is unlocked. Therefore, the checksum should be 
correct before
update_backups() holds the buffer lock. Also, in update_backups() we 
copy the
entire superblock completely, and the checksum is unchanged, so we don't 
need
to reset it.
>> ---
>>   fs/ext4/resize.c | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
>> index cb99b410c9fa..32fbfc173571 100644
>> --- a/fs/ext4/resize.c
>> +++ b/fs/ext4/resize.c
>> @@ -1158,7 +1158,6 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>>   	while (group < sbi->s_groups_count) {
>>   		struct buffer_head *bh;
>>   		ext4_fsblk_t backup_block;
>> -		struct ext4_super_block *es;
>>   
>>   		/* Out of journal space, and can't get more - abort - so sad */
>>   		err = ext4_resize_ensure_credits_batch(handle, 1);
>> @@ -1187,10 +1186,6 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
>>   		memcpy(bh->b_data, data, size);
>>   		if (rest)
>>   			memset(bh->b_data + size, 0, rest);
>> -		es = (struct ext4_super_block *) bh->b_data;
>> -		es->s_block_group_nr = cpu_to_le16(group);
>> -		if (ext4_has_metadata_csum(sb))
>> -			es->s_checksum = ext4_superblock_csum(sb, es);
>>   		set_buffer_uptodate(bh);
>>   		unlock_buffer(bh);
>>   		err = ext4_handle_dirty_metadata(handle, NULL, bh);
>> -- 
>> 2.31.1
>>
Thank you for your review!
-- 
With Best Regards,
Baokun Li

