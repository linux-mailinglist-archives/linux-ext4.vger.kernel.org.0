Return-Path: <linux-ext4+bounces-8702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C794AAED5C2
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14CD1677D5
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 07:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B38221DB4;
	Mon, 30 Jun 2025 07:34:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876751FBC8E;
	Mon, 30 Jun 2025 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268877; cv=none; b=qHvteiW/xsiFrTU94R4EMQA0j7UkliMU+LEDKGddld9B/ckYufFr50fHSbIzl6dT1sUTmVGHf1OQc9bnGajTSkKzkczRlncwdaaoAi3V59AK+p7ModPUPvZ5k8ezunn//NE93alhTop2VorvKVUYQyusv1AHExui5sNcsHdlndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268877; c=relaxed/simple;
	bh=iDFC2uzeH1O6YJJ+KNWE7uV0iY8CLCu4IrCkwx9Smio=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g5GzTeoizmrz+DVDFcXkSYH0+IQEzMXuICyRcU96Gxhulr+hjVrfEYaiD0ML7bgu/LgfkHN1sd6gwUnHvg/sqPH9qud/s/k0juhZ11P165LWsdoPc1G3yYqsZkTNkycbIk1I6Lei/Fg0RzV6FJzY28Z+cKIpuJF8rW12CbHDV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bVyVV2D2szCsGj;
	Mon, 30 Jun 2025 15:30:10 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA7E180486;
	Mon, 30 Jun 2025 15:34:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 30 Jun
 2025 15:34:31 +0800
Message-ID: <5bf464c0-5cfe-4e29-8138-4fb85c83f5bb@huawei.com>
Date: Mon, 30 Jun 2025 15:34:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] ext4: fix largest free orders lists corruption
 on mb_optimize_scan switch
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<ojaswin@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <stable@vger.kernel.org>,
	Baokun Li <libaokun1@huawei.com>
References: <20250623073304.3275702-1-libaokun1@huawei.com>
 <20250623073304.3275702-11-libaokun1@huawei.com>
 <a4rctz75l4c6vejweqq67ptzojs276eicqp6kqegpxinirk32n@dnhg6h4pbvdr>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <a4rctz75l4c6vejweqq67ptzojs276eicqp6kqegpxinirk32n@dnhg6h4pbvdr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/6/28 3:34, Jan Kara wrote:
> On Mon 23-06-25 15:32:58, Baokun Li wrote:
>> The grp->bb_largest_free_order is updated regardless of whether
>> mb_optimize_scan is enabled. This can lead to inconsistencies between
>> grp->bb_largest_free_order and the actual s_mb_largest_free_orders list
>> index when mb_optimize_scan is repeatedly enabled and disabled via remount.
>>
>> For example, if mb_optimize_scan is initially enabled, largest free
>> order is 3, and the group is in s_mb_largest_free_orders[3]. Then,
>> mb_optimize_scan is disabled via remount, block allocations occur,
>> updating largest free order to 2. Finally, mb_optimize_scan is re-enabled
>> via remount, more block allocations update largest free order to 1.
>>
>> At this point, the group would be removed from s_mb_largest_free_orders[3]
>> under the protection of s_mb_largest_free_orders_locks[2]. This lock
>> mismatch can lead to list corruption.
>>
>> To fix this, a new field bb_largest_free_order_idx is added to struct
>> ext4_group_info to explicitly track the list index. Then still update
>> bb_largest_free_order unconditionally, but only update
>> bb_largest_free_order_idx when mb_optimize_scan is enabled. so that there
>> is no inconsistency between the lock and the data to be protected.
>>
>> Fixes: 196e402adf2e ("ext4: improve cr 0 / cr 1 group scanning")
>> CC: stable@vger.kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Hum, rather than duplicating index like this, couldn't we add to
> mb_set_largest_free_order():
>
> 	/* Did mb_optimize_scan setting change? */
> 	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) &&
> 	    !list_empty(&grp->bb_largest_free_order_node)) {
> 		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
> 		list_del_init(&grp->bb_largest_free_order_node);
> 		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
> 	}
>
> Also arguably we should reinit bb lists when mb_optimize_scan gets
> reenabled because otherwise inconsistent lists could lead to suboptimal
> results... But that's less important to fix I guess.
>
> 								Honza

Yeah, this looks good. We just need to remove groups modified when
mb_optimize_scan=0 from the list. Groups that remain in the list after
mb_optimize_scan is re-enabled can be used normally.

As for the groups that were removed, they will be re-added to their
corresponding lists during block freeing or block allocation when
cr >= CR_GOAL_LEN_SLOW. So, I agree that we don't need to explicitly
reinit them.



Cheers,
Baokun

>> ---
>>   fs/ext4/ext4.h    |  1 +
>>   fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
>>   2 files changed, 17 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 003b8d3726e8..0e574378c6a3 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -3476,6 +3476,7 @@ struct ext4_group_info {
>>   	int		bb_avg_fragment_size_order;	/* order of average
>>   							   fragment in BG */
>>   	ext4_grpblk_t	bb_largest_free_order;/* order of largest frag in BG */
>> +	ext4_grpblk_t	bb_largest_free_order_idx; /* index of largest frag */
>>   	ext4_group_t	bb_group;	/* Group number */
>>   	struct          list_head bb_prealloc_list;
>>   #ifdef DOUBLE_CHECK
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e6d6c2da3c6e..dc82124f0905 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1152,33 +1152,29 @@ static void
>>   mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info *grp)
>>   {
>>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>> -	int i;
>> +	int new, old = grp->bb_largest_free_order_idx;
>>   
>> -	for (i = MB_NUM_ORDERS(sb) - 1; i >= 0; i--)
>> -		if (grp->bb_counters[i] > 0)
>> +	for (new = MB_NUM_ORDERS(sb) - 1; new >= 0; new--)
>> +		if (grp->bb_counters[new] > 0)
>>   			break;
>> +
>> +	grp->bb_largest_free_order = new;
>>   	/* No need to move between order lists? */
>> -	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) ||
>> -	    i == grp->bb_largest_free_order) {
>> -		grp->bb_largest_free_order = i;
>> +	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || new == old)
>>   		return;
>> -	}
>>   
>> -	if (grp->bb_largest_free_order >= 0) {
>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>> -					      grp->bb_largest_free_order]);
>> +	if (old >= 0) {
>> +		write_lock(&sbi->s_mb_largest_free_orders_locks[old]);
>>   		list_del_init(&grp->bb_largest_free_order_node);
>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> -					      grp->bb_largest_free_order]);
>> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[old]);
>>   	}
>> -	grp->bb_largest_free_order = i;
>> -	if (grp->bb_largest_free_order >= 0 && grp->bb_free) {
>> -		write_lock(&sbi->s_mb_largest_free_orders_locks[
>> -					      grp->bb_largest_free_order]);
>> +
>> +	grp->bb_largest_free_order_idx = new;
>> +	if (new >= 0 && grp->bb_free) {
>> +		write_lock(&sbi->s_mb_largest_free_orders_locks[new]);
>>   		list_add_tail(&grp->bb_largest_free_order_node,
>> -		      &sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
>> -		write_unlock(&sbi->s_mb_largest_free_orders_locks[
>> -					      grp->bb_largest_free_order]);
>> +			      &sbi->s_mb_largest_free_orders[new]);
>> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[new]);
>>   	}
>>   }
>>   
>> @@ -3391,6 +3387,7 @@ int ext4_mb_add_groupinfo(struct super_block *sb, ext4_group_t group,
>>   	INIT_LIST_HEAD(&meta_group_info[i]->bb_avg_fragment_size_node);
>>   	meta_group_info[i]->bb_largest_free_order = -1;  /* uninit */
>>   	meta_group_info[i]->bb_avg_fragment_size_order = -1;  /* uninit */
>> +	meta_group_info[i]->bb_largest_free_order_idx = -1;  /* uninit */
>>   	meta_group_info[i]->bb_group = group;
>>   
>>   	mb_group_bb_bitmap_alloc(sb, meta_group_info[i], group);
>> -- 
>> 2.46.1
>>


