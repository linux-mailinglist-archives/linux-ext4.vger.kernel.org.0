Return-Path: <linux-ext4+bounces-9110-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BEB0AD5E
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 03:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321481C2626D
	for <lists+linux-ext4@lfdr.de>; Sat, 19 Jul 2025 01:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A518D643;
	Sat, 19 Jul 2025 01:37:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0706311CA0;
	Sat, 19 Jul 2025 01:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752889050; cv=none; b=a796FUbb0/J0sW59Z3Td2a9q/HxQAYStA6d0UISytbtP/H3POpg129uXrRES+8Md+Wp2xiw9xMEk+Rb2gdrX/DhoEjf7C3p4l1KikooYxhBNSWLGW0lAJT5JmJNpxVMwuETSdIxXStvsLb94pA9zv/n+covujDul4X9YSvFz8CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752889050; c=relaxed/simple;
	bh=qUWcvyRchuCny4BQeqUugOJr2SgYl3yTQxte0+P8zJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ewUUhU7Kjj1eSMlsD+NCQm2MXrE/878Qt8UdsSXc45vcKY29O8ya5U/NkyRoehmbL9h4mNQjLT0tf5xA+RCsLp+vYuNJjYxp0NQjcbZRdB8uf2NDllVJvnimNRlWUBS+J10bCyblzUdoM6nGbh+9tsHEPUbIGdZ8GPlp9ra/Hmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bkTjX0fXbz2gKf1;
	Sat, 19 Jul 2025 09:34:40 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id A04E1140295;
	Sat, 19 Jul 2025 09:37:18 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Jul
 2025 09:37:17 +0800
Message-ID: <ac2d830d-8839-4924-834d-0fcb5b1f3fd0@huawei.com>
Date: Sat, 19 Jul 2025 09:37:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] ext4: separate stream goal hits from s_bal_goals
 for better tracking
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, <julia.lawall@inria.fr>,
	<yi.zhang@huawei.com>, <yangerkun@huawei.com>, <libaokun@huaweicloud.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-3-libaokun1@huawei.com>
 <aHjQmHgSYmjwI6g8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <aHjQmHgSYmjwI6g8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025/7/17 18:29, Ojaswin Mujoo wrote:
> On Mon, Jul 14, 2025 at 09:03:12PM +0800, Baokun Li wrote:
>> In ext4_mb_regular_allocator(), after the call to ext4_mb_find_by_goal()
>> fails to achieve the inode goal, allocation continues with the stream
>> allocation global goal. Currently, hits for both are combined in
>> sbi->s_bal_goals, hindering accurate optimization.
>>
>> This commit separates global goal hits into sbi->s_bal_stream_goals. Since
>> stream allocation doesn't use ac->ac_g_ex.fe_start, set fe_start to -1.
>> This prevents stream allocations from being counted in s_bal_goals. Also
>> clear EXT4_MB_HINT_TRY_GOAL to avoid calling ext4_mb_find_by_goal again.
>>
>> After adding `stream_goal_hits`, `/proc/fs/ext4/sdx/mb_stats` will show:
>>
>> mballoc:
>> 	reqs: 840347
>> 	success: 750992
>> 	groups_scanned: 1230506
>> 	cr_p2_aligned_stats:
>> 		hits: 21531
>> 		groups_considered: 411664
>> 		extents_scanned: 21531
>> 		useless_loops: 0
>> 		bad_suggestions: 6
>> 	cr_goal_fast_stats:
>> 		hits: 111222
>> 		groups_considered: 1806728
>> 		extents_scanned: 467908
>> 		useless_loops: 0
>> 		bad_suggestions: 13
>> 	cr_best_avail_stats:
>> 		hits: 36267
>> 		groups_considered: 1817631
>> 		extents_scanned: 156143
>> 		useless_loops: 0
>> 		bad_suggestions: 204
>> 	cr_goal_slow_stats:
>> 		hits: 106396
>> 		groups_considered: 5671710
>> 		extents_scanned: 22540056
>> 		useless_loops: 123747
>> 	cr_any_free_stats:
>> 		hits: 138071
>> 		groups_considered: 724692
>> 		extents_scanned: 23615593
>> 		useless_loops: 585
>> 	extents_scanned: 46804261
>> 		goal_hits: 1307
>> 		stream_goal_hits: 236317
>> 		len_goal_hits: 155549
>> 		2^n_hits: 21531
>> 		breaks: 225096
>> 		lost: 35062
>> 	buddies_generated: 40/40
>> 	buddies_time_used: 48004
>> 	preallocated: 5962467
>> 	discarded: 4847560
>>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/ext4.h    |  1 +
>>   fs/ext4/mballoc.c | 11 +++++++++--
>>   2 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 9df74123e7e6..8750ace12935 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -1646,6 +1646,7 @@ struct ext4_sb_info {
>>   	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
>>   	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
>>   	atomic_t s_bal_goals;	/* goal hits */
>> +	atomic_t s_bal_stream_goals;	/* stream allocation global goal hits */
>>   	atomic_t s_bal_len_goals;	/* len goal hits */
>>   	atomic_t s_bal_breaks;	/* too long searches */
>>   	atomic_t s_bal_2orders;	/* 2^order hits */
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 336d65c4f6a2..f56ac477c464 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2849,8 +2849,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>>   		/* TBD: may be hot point */
>>   		spin_lock(&sbi->s_md_lock);
>>   		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
>> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
>>   		spin_unlock(&sbi->s_md_lock);
>> +		ac->ac_g_ex.fe_start = -1;
>> +		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
> Hey Baokun, I was a bit late to review this in v2 so I'll add the
> comment here:
>
> So this is mostly to account for retires right? Maybe rather than
> disabling goal allocation a better way to do this is resetting the
> original goal group and goal start in the retry logic of
> ext4_mb_new_blocks()? Since we drop preallocations before retrying, this
> way we might actually find our goal during the retry. Its a slim chance
> though but still feels like the right way to do it.
>
> Thoughts?

It's true that successfully acquiring the goal on retry is possible, but
the probability is too low; I think attempting the inode goal on retry is
not very meaningful. The lack of trylock logic in ext4_mb_find_by_goal()
also introduces some performance overhead.

Additionally, since preallocations might be dropped before retrying, the
inode's preallocation could also be discarded. Therefore, pa overlap needs
to be re-adjusted.

For data block allocation, we should call ext4_mb_normalize_request() to
regenerate a new ac_g_ex instead of directly resetting the original goal.
ext4_mb_normalize_request() will also determine whether to reset
EXT4_MB_HINT_TRY_GOAL.

For metadata block allocation, EXT4_MB_STREAM_ALLOC is not set, so there's
no need to worry about EXT4_MB_HINT_TRY_GOAL being cleared.

Clearing EXT4_MB_HINT_TRY_GOAL here is only to avoid inode goal allocation
with -1. If you insist that we should attempt the inode goal on retry,
I will send a separate patch to address that.


Cheers,
Baokun


