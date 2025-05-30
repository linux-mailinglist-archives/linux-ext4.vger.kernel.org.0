Return-Path: <linux-ext4+bounces-8249-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BECAC8AF0
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 11:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A27DC7AFECF
	for <lists+linux-ext4@lfdr.de>; Fri, 30 May 2025 09:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F022B8AF;
	Fri, 30 May 2025 09:32:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D58222578;
	Fri, 30 May 2025 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597526; cv=none; b=mZdzxBgGVaguqIEpYZK2GxTx4gAT0pyhWgMxlq/Xs1qcDALiz5QYyxxvr8yLt530o1pvMigaKqoXl60u0lxwMJFOU/Enf01M9pOqEeQpEebqtc9xnyie3oiHD6A5L+Ej/VavcVlYBF3C/l0vboDdiFO5QU5D6yiiS0XfBv3YLMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597526; c=relaxed/simple;
	bh=r3EQ7kD0QYtBm/wVC83vp9ptG9VHOOzuguqUtvBO63U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DAaRP8bGhEOJ5m2o9uJgUrGh12GDM1JoNISKwv2K2nxIUV/lF61Z43l1gV/7KT3tPNn0GI++SkDIWoMcT3Ei4XHwpLUpNgD2uZtK+u4MDwRIy+rzZrDUnuhlvBWYjLPQClldvb67byZTKu8J8je/171nYoUy//9VjejOYeistfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4b7yb13zDqz2CfQD;
	Fri, 30 May 2025 17:28:13 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 696321A016C;
	Fri, 30 May 2025 17:31:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 30 May
 2025 17:31:58 +0800
Message-ID: <6200e067-0ad1-4dc4-9694-05ee1e977f4c@huawei.com>
Date: Fri, 30 May 2025 17:31:48 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] ext4: move mb_last_[group|start] to ext4_inode_info
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <libaokun@huaweicloud.com>, Baokun Li
	<libaokun1@huawei.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-3-libaokun@huaweicloud.com>
 <afjkyrm4y5mp5p72ew3ddqma7v4gkmjqdkcloeaidcj55ruami@zfkn6dzgqfwh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <afjkyrm4y5mp5p72ew3ddqma7v4gkmjqdkcloeaidcj55ruami@zfkn6dzgqfwh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hello Honza,

Thank you for you review!

On 2025/5/29 20:56, Jan Kara wrote:
> On Fri 23-05-25 16:58:19, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> After we optimized the block group lock, we found another lock
>> contention issue when running will-it-scale/fallocate2 with multiple
>> processes. The fallocate's block allocation and the truncate's block
>> release were fighting over the s_md_lock. The problem is, this lock
>> protects totally different things in those two processes: the list of
>> freed data blocks (s_freed_data_list) when releasing, and where to start
>> looking for new blocks (mb_last_[group|start]) when allocating.
>>
>> Moreover, when allocating data blocks, if the first try (goal allocation)
>> fails and stream allocation is on, it tries a global goal starting from
>> the last group we used (s_mb_last_group). This can make things faster by
>> writing blocks close together on the disk. But when many processes are
>> allocating, they all fight over s_md_lock and might even try to use the
>> same group. This makes it harder to merge extents and can make files more
>> fragmented. If different processes allocate chunks of very different sizes,
>> the free space on the disk can also get fragmented. A small allocation
>> might fit in a partially full group, but a big allocation might have
>> skipped it, leading to the small IO ending up in a more empty group.
>>
>> So, we're changing stream allocation to work per inode. First, it tries
>> the goal, then the last group where that inode successfully allocated a
>> block. This keeps an inode's data closer together. Plus, after moving
>> mb_last_[group|start] to ext4_inode_info, we don't need s_md_lock during
>> block allocation anymore because we already have the write lock on
>> i_data_sem. This gets rid of the contention between allocating and
>> releasing blocks, which gives a huge performance boost to fallocate2.
>>
>> Performance test data follows:
>>
>> CPU: HUAWEI Kunpeng 920
>> Memory: 480GB
>> Disk: 480GB SSD SATA 3.2
>> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
>> Observation: Average fallocate operations per container per second.
>>
>>                        base     patched
>> mb_optimize_scan=0    6755     23280 (+244.6%)
>> mb_optimize_scan=1    4302     10430 (+142.4%)
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Good spotting with the s_md_lock contention here. But your changes don't
> quite make sense to me. The idea of streaming allocation in mballoc is to
> have an area of filesystem for large files to reduce fragmentation.  When
> you switch to per-inode, this effect of packing large files together goes
> away. Futhermore for each inode either all allocations will be very likely
> streaming or not streaming (the logic uses file size) so either your
> per-inode target will be unused or just another constantly used copy of
> goal value.
Sorry, I didn't intend to  break streaming allocation's semantics.
A precise definition of streaming allocation is not found in the
existing code, documentation, or historical records. Consequently,
my previous understanding of it was somewhat inaccurate.

I previously thought it was used to optimize the efficiency of linear
traversal. For instance, if 500 inodes are created in group 0 and each
file is sequentially filled to 1GB, each file's goal, being empty, would
be group 1 (the second group in the inode's flex_bg).

Without a global goal and in the absence of non-linear traversal,
after the first inode is filled, the second inode would need to traverse
groups 1 through 8 to find its first free block.

This inefficiency escalates, eventually requiring the 500th inode to
potentially traverse almost 4000 block groups to find its first available
block.

I initially believed it could be split to the inode level to reduce
traversal time and file fragmentation. However, as you pointed out,
its purpose is to cluster large files, not data blocks within a file.
Given this, splitting it to the inode level no longer makes sense.
> So I can see two sensible solutions here:
> a) Drop streaming allocations support altogether.
As mentioned above, it can also greatly improve the efficiency of linear
traversal, so we can't simply remove it.
>
> b) Enhance streaming allocation support to avoid contention between
> processes allocating in parallel and freeing. Frankly, there's no strong
> reason why reads & writes of streaming allocation goal need to use a
> spinlock AFAICS.
Yes, since it's just a hint, we don't need a lock at all, not even
fe_start, we just need the last fe_group.
> We could just store a physical block number and use
> atomic64 accessors for it? Also having single goal value is just causing
> more contention on group locks for parallel writers that end up using it
> (that's the problem I suspect you were hitting the most).
Spot on! We did try a single, lockless atomic64 variable, and just as
you pointed out, all processes started traversing from the very same
group, which just cranked up the contention, dropping OPS to just 6745.
>   So perhaps we
> can keep multiple streaming goal slots in the superblock (scale the count
> based on CPU count & filesystem group count) and just pick the slot based
> on inode number hash to reduce contention?
>
> 								Honza
That's a brilliant idea, actually!

Since most containers are CPU-pinned, this would naturally cluster a single
container's data blocks together. I believe we can also apply this to inode
allocation, so a container's inodes and data are all in a single region,
significantly reducing interference between containers.

My gratitude for your valuable suggestion!
I'm going to try out the CPU bucketing approach.

Regards,
Baokun


>> ---
>>   fs/ext4/ext4.h    |  7 ++++---
>>   fs/ext4/mballoc.c | 20 +++++++++-----------
>>   fs/ext4/super.c   |  2 ++
>>   3 files changed, 15 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 9c665a620a46..16c14dd09df6 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1171,6 +1171,10 @@ struct ext4_inode_info {
>>   	__u32 i_csum_seed;
>>   
>>   	kprojid_t i_projid;
>> +
>> +	/* where last allocation was done - for stream allocation */
>> +	ext4_group_t i_mb_last_group;
>> +	ext4_grpblk_t i_mb_last_start;
>>   };
>>   
>>   /*
>> @@ -1603,9 +1607,6 @@ struct ext4_sb_info {
>>   	unsigned int s_mb_order2_reqs;
>>   	unsigned int s_mb_group_prealloc;
>>   	unsigned int s_max_dir_size_kb;
>> -	/* where last allocation was done - for stream allocation */
>> -	unsigned long s_mb_last_group;
>> -	unsigned long s_mb_last_start;
>>   	unsigned int s_mb_prefetch;
>>   	unsigned int s_mb_prefetch_limit;
>>   	unsigned int s_mb_best_avail_max_trim_order;
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5c13d9f8a1cc..ee9696f9bac8 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2138,7 +2138,6 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>>   static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>   					struct ext4_buddy *e4b)
>>   {
>> -	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
>>   	int ret;
>>   
>>   	BUG_ON(ac->ac_b_ex.fe_group != e4b->bd_group);
>> @@ -2169,10 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>>   	folio_get(ac->ac_buddy_folio);
>>   	/* store last allocated for subsequent stream allocation */
>>   	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		spin_lock(&sbi->s_md_lock);
>> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
>> -		sbi->s_mb_last_start = ac->ac_f_ex.fe_start;
>> -		spin_unlock(&sbi->s_md_lock);
>> +		EXT4_I(ac->ac_inode)->i_mb_last_group = ac->ac_f_ex.fe_group;
>> +		EXT4_I(ac->ac_inode)->i_mb_last_start = ac->ac_f_ex.fe_start;
>>   	}
>>   	/*
>>   	 * As we've just preallocated more space than
>> @@ -2844,13 +2841,14 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   							   MB_NUM_ORDERS(sb));
>>   	}
>>   
>> -	/* if stream allocation is enabled, use global goal */
>> +	/* if stream allocation is enabled, use last goal */
>>   	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
>> -		/* TBD: may be hot point */
>> -		spin_lock(&sbi->s_md_lock);
>> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
>> -		spin_unlock(&sbi->s_md_lock);
>> +		struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
>> +
>> +		if (ei->i_mb_last_group || ei->i_mb_last_start) {
>> +			ac->ac_g_ex.fe_group = ei->i_mb_last_group;
>> +			ac->ac_g_ex.fe_start = ei->i_mb_last_start;
>> +		}
>>   	}
>>   
>>   	/*
>> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
>> index 181934499624..6c49c43bb2cb 100644
>> --- a/fs/ext4/super.c
>> +++ b/fs/ext4/super.c
>> @@ -1416,6 +1416,8 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
>>   	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>>   	ext4_fc_init_inode(&ei->vfs_inode);
>>   	mutex_init(&ei->i_fc_lock);
>> +	ei->i_mb_last_group = 0;
>> +	ei->i_mb_last_start = 0;
>>   	return &ei->vfs_inode;
>>   }
>>   
>> -- 
>> 2.46.1
>>


