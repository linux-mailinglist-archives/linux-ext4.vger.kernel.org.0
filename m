Return-Path: <linux-ext4+bounces-684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92D382416F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 13:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 595F22831D5
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5159A2137E;
	Thu,  4 Jan 2024 12:14:52 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362921352;
	Thu,  4 Jan 2024 12:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4T5QVg3rS9z1Q6yM;
	Thu,  4 Jan 2024 20:14:03 +0800 (CST)
Received: from dggpeml500021.china.huawei.com (unknown [7.185.36.21])
	by mail.maildlp.com (Postfix) with ESMTPS id 2196F18001C;
	Thu,  4 Jan 2024 20:14:40 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 20:14:39 +0800
Message-ID: <eccf08c1-12c8-068c-71e0-ed237ae26953@huawei.com>
Date: Thu, 4 Jan 2024 20:14:39 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 8/8] ext4: mark the group block bitmap as corrupted
 before reporting an error
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <yukuai3@huawei.com>, Baokun
 Li <libaokun1@huawei.com>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-9-libaokun1@huawei.com>
 <20240104105151.3c2yrg3f3efiajgv@quack3>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240104105151.3c2yrg3f3efiajgv@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)

On 2024/1/4 18:51, Jan Kara wrote:
> On Thu 21-12-23 23:05:58, Baokun Li wrote:
>> Otherwise unlocking the group in ext4_grp_locked_error may allow other
>> processes to modify the core block bitmap that is known to be corrupt.
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> I'm not opposed but I don't think this matters much.
> ext4_grp_locked_error() unlocks the group only in errors=remount-ro case
> these days and in that case we abort the journal so none of the changes
> should make it to disk anyway. Anyway, in the name of defensive programming
> feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> :)
>
> 								Honza
Thank you very much for your review!

Yes, the unlock gap here does not cause corrupted data to be written
to disk, which is why no issues have been reported here before.

My concern is that core block bitmap corruption may cause kernel
crash in some corners. That's why inode bitmap corruption is not a
concern here, since there is no core inode bitmap.

We encounter all sorts of hard-to-replicate kernel problems every
day, and hopefully by fixing these trivial little issues, we can reduce
the number of difficult problems that arise from all sorts of
coincidental stacking.

Cheers!😊
>> ---
>>   fs/ext4/mballoc.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index b862ca2750fd..c43eefebdaa3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -564,14 +564,14 @@ static void mb_free_blocks_double(struct inode *inode, struct ext4_buddy *e4b,
>>   
>>   			blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>>   			blocknr += EXT4_C2B(EXT4_SB(sb), first + i);
>> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			ext4_grp_locked_error(sb, e4b->bd_group,
>>   					      inode ? inode->i_ino : 0,
>>   					      blocknr,
>>   					      "freeing block already freed "
>>   					      "(bit %u)",
>>   					      first + i);
>> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   		}
>>   		mb_clear_bit(first + i, e4b->bd_info->bb_bitmap);
>>   	}
>> @@ -1926,14 +1926,13 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>>   		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
>>   		blocknr += EXT4_C2B(sbi, block);
>>   		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
>> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			ext4_grp_locked_error(sb, e4b->bd_group,
>>   					      inode ? inode->i_ino : 0,
>>   					      blocknr,
>>   					      "freeing already freed block (bit %u); block bitmap corrupt.",
>>   					      block);
>> -			ext4_mark_group_bitmap_corrupted(
>> -				sb, e4b->bd_group,
>> -				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   		} else {
>>   			mb_regenerate_buddy(e4b);
>>   			goto check;
>> @@ -2410,12 +2409,12 @@ void ext4_mb_simple_scan_group(struct ext4_allocation_context *ac,
>>   
>>   		k = mb_find_next_zero_bit(buddy, max, 0);
>>   		if (k >= max) {
>> +			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
>> +					e4b->bd_group,
>> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			ext4_grp_locked_error(ac->ac_sb, e4b->bd_group, 0, 0,
>>   				"%d free clusters of order %d. But found 0",
>>   				grp->bb_counters[i], i);
>> -			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
>> -					 e4b->bd_group,
>> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			break;
>>   		}
>>   		ac->ac_found++;
>> @@ -2466,12 +2465,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>>   			 * free blocks even though group info says we
>>   			 * have free blocks
>>   			 */
>> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
>>   					"%d free clusters as per "
>>   					"group info. But bitmap says 0",
>>   					free);
>> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			break;
>>   		}
>>   
>> @@ -2497,12 +2496,12 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
>>   		if (WARN_ON(ex.fe_len <= 0))
>>   			break;
>>   		if (free < ex.fe_len) {
>> +			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> +					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			ext4_grp_locked_error(sb, e4b->bd_group, 0, 0,
>>   					"%d free clusters as per "
>>   					"group info. But got %d blocks",
>>   					free, ex.fe_len);
>> -			ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
>> -					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
>>   			/*
>>   			 * The number of free blocks differs. This mostly
>>   			 * indicate that the bitmap is corrupt. So exit
>> -- 
>> 2.31.1
>>
>>
Thanks!
-- 
With Best Regards,
Baokun Li
.

