Return-Path: <linux-ext4+bounces-8208-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87F9AC6C7B
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE317AE3E0
	for <lists+linux-ext4@lfdr.de>; Wed, 28 May 2025 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8937C28B7E0;
	Wed, 28 May 2025 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pf8E2xyy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7602928853F;
	Wed, 28 May 2025 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748444791; cv=none; b=QFp9ZjfD9Sa5Pbz81X6Lb5ckQpvrRxzuCdJlBSQPz9HWamMOGpNMGgcOjyWd/DNmkR6+7J5PvaNRhkTEQpnJDusFVoz/OXSj4wk+EJ8Vke9q/Km+FJwFf3WvCgEUKBhYNUMv6yP4Kbf9wD9905WLRHVrrh1gTqR+H2R6yJNIaVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748444791; c=relaxed/simple;
	bh=ODpsIO7RVzW6JdyJy6lN6uKemRVcL4gaELLz0FE4nJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2SjzynFi2mw72YRCBdnSyfBF56K2l8b8EYtcR+g/dq8ov7zESaT3ZA5IGqZUltKdoW6DmoLSfWw36O3QDC6y+EyJiLrM53QI2SRln2MEq3A8/1C+2nB225nxZd85LnfT/MATHVaJMqMsiWy9cSb3CUupBgpvP61Z/p7Wvb7lM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pf8E2xyy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9Pwb017540;
	Wed, 28 May 2025 15:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TYJDbql5sldxAJx2938C31EJDleJ/2
	lSl1d6fN/5hkw=; b=pf8E2xyyWPtFBnim+PaCPxlybuAjSL5c1vdZ7FWWw7mLf1
	7OrVdclUcQtjPSYDrko9vqOE/Qzyk3fuW4IFtqZTaUHepsrI/57k3X/EZPbl/Z2Y
	H+mcAdPCguWsvxxPuWCLAus4ZbV4f/b6K0ACT9JWBfkRAFDjT3VqitfM7NCoC5vX
	vo0Up0udYyPI/qGhUEQJVghhx2B+3SsAPwUxWr6B9WkP2YDjP7O6QxKEvPXA4nv8
	YltWrk4BHMz8X7EsTszsDjkrvxC63C2mqPq5RLA2mJgGg6ouGVcrsFe2atKq5fEI
	5XN/9APCpuwUqXCzlriuEgph5bxQbmWDbCTWGSGA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40ggbpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:06:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SF2wwd016178;
	Wed, 28 May 2025 15:06:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46uru0r508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 15:06:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54SF60LX19988938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 May 2025 15:06:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C2E42004F;
	Wed, 28 May 2025 15:06:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ACFB20040;
	Wed, 28 May 2025 15:05:50 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.84])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 28 May 2025 15:05:47 +0000 (GMT)
Date: Wed, 28 May 2025 20:35:41 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH 1/4] ext4: add ext4_try_lock_group() to skip busy groups
Message-ID: <aDcmRdOrWatcBJWc@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250523085821.1329392-1-libaokun@huaweicloud.com>
 <20250523085821.1329392-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523085821.1329392-2-libaokun@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=avmyCTZV c=1 sm=1 tr=0 ts=6837265b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=ujIZDTJbDLGYv8oHIywA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDEzMCBTYWx0ZWRfX3cHOzmOZL3Kr t8Jkok2JVH95F2nXHT6azSs/+qIWbgZ6LYzSC1ippmCfSv4XuAhK6Gp4q4evGL5D9arGS+xkD+S fONR7AnNwQ4+AMl+teaKpoY8WrWXr06OTWdS3VGaD3IX03OA+yyCH7Hlk+1kiRZKWIe1iJoSs1K
 NifSnZ6GvIc7O3ydW2CLRVUCLeC28+n1VU9D5WC5Uyq8rpam/SanzijCkom7JS5cFRhP/5kd2l6 tmoGJbOaKInbPP6QgwQqjaTP/RlAdwegos+a+wcw7mC7ORNDRDsO9Dr2tyfRHh0O6hD2dmwMX53 o3NNBlY2ab9xDvhr+FRy5/fI1wqpQlGyTSZTWh30+lIpcbVdydnIvIndy7xSaG9hKJYzcqiaG7h
 yuzJBU3+4pmoDHIManzBFfOshoBB9uriO1x/HkGSSxilN29FS+l9or75/Qq+vWcy/SkqIwfx
X-Proofpoint-GUID: QEXMatXWVlw4NIvsaetoyfMYcivQrApA
X-Proofpoint-ORIG-GUID: QEXMatXWVlw4NIvsaetoyfMYcivQrApA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_07,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280130

On Fri, May 23, 2025 at 04:58:18PM +0800, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> When ext4 allocates blocks, we used to just go through the block groups
> one by one to find a good one. But when there are tons of block groups
> (like hundreds of thousands or even millions) and not many have free space
> (meaning they're mostly full), it takes a really long time to check them
> all, and performance gets bad. So, we added the "mb_optimize_scan" mount
> option (which is on by default now). It keeps track of some group lists,
> so when we need a free block, we can just grab a likely group from the
> right list. This saves time and makes block allocation much faster.
> 
> But when multiple processes or containers are doing similar things, like
> constantly allocating 8k blocks, they all try to use the same block group
> in the same list. Even just two processes doing this can cut the IOPS in
> half. For example, one container might do 300,000 IOPS, but if you run two
> at the same time, the total is only 150,000.
> 
> Since we can already look at block groups in a non-linear way, the first
> and last groups in the same list are basically the same for finding a block
> right now. Therefore, add an ext4_try_lock_group() helper function to skip
> the current group when it is locked by another process, thereby avoiding
> contention with other processes. This helps ext4 make better use of having
> multiple block groups.
> 
> Also, to make sure we don't skip all the groups that have free space
> when allocating blocks, we won't try to skip busy groups anymore when
> ac_criteria is CR_ANY_FREE.
> 
> Performance test data follows:
> 
> CPU: HUAWEI Kunpeng 920
> Memory: 480GB
> Disk: 480GB SSD SATA 3.2
> Test: Running will-it-scale/fallocate2 on 64 CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
>                       base    patched
> mb_optimize_scan=0    3588    6755 (+88.2%)
> mb_optimize_scan=1    3588    4302 (+19.8%)

The patch looks mostly good. Same observations about mb_optimize_scan=1
improving less. We can continue this discussion in my reply to the cover
letter. That being said, I have some minor suggestions:

> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/ext4.h    | 23 ++++++++++++++---------
>  fs/ext4/mballoc.c | 14 +++++++++++---
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..9c665a620a46 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3494,23 +3494,28 @@ static inline int ext4_fs_is_busy(struct ext4_sb_info *sbi)
>  	return (atomic_read(&sbi->s_lock_busy) > EXT4_CONTENTION_THRESHOLD);
>  }
>  
> +static inline bool ext4_try_lock_group(struct super_block *sb, ext4_group_t group)
> +{
> +	if (!spin_trylock(ext4_group_lock_ptr(sb, group)))
> +		return false;
> +	/*
> +	 * We're able to grab the lock right away, so drop the lock
> +	 * contention counter.
> +	 */
> +	atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
> +	return true;
> +}
> +
>  static inline void ext4_lock_group(struct super_block *sb, ext4_group_t group)
>  {
> -	spinlock_t *lock = ext4_group_lock_ptr(sb, group);
> -	if (spin_trylock(lock))
> -		/*
> -		 * We're able to grab the lock right away, so drop the
> -		 * lock contention counter.
> -		 */
> -		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, -1, 0);
> -	else {
> +	if (!ext4_try_lock_group(sb, group)) {
>  		/*
>  		 * The lock is busy, so bump the contention counter,
>  		 * and then wait on the spin lock.
>  		 */
>  		atomic_add_unless(&EXT4_SB(sb)->s_lock_busy, 1,
>  				  EXT4_MAX_CONTENTION);
> -		spin_lock(lock);
> +		spin_lock(ext4_group_lock_ptr(sb, group));
>  	}
>  }
>  
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1e98c5be4e0a..5c13d9f8a1cc 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -896,7 +896,8 @@ static void ext4_mb_choose_next_group_p2_aligned(struct ext4_allocation_context
>  				    bb_largest_free_order_node) {
>  			if (sbi->s_mb_stats)
>  				atomic64_inc(&sbi->s_bal_cX_groups_considered[CR_POWER2_ALIGNED]);
> -			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED))) {
> +			if (likely(ext4_mb_good_group(ac, iter->bb_group, CR_POWER2_ALIGNED)) &&
> +			    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {

Maybe reversing the && order to be (!spin_is_locked() && ext4_mb_good_group()) would be better?

>  				*group = iter->bb_group;
>  				ac->ac_flags |= EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED;
>  				read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> @@ -932,7 +933,8 @@ ext4_mb_find_good_group_avg_frag_lists(struct ext4_allocation_context *ac, int o
>  	list_for_each_entry(iter, frag_list, bb_avg_fragment_size_node) {
>  		if (sbi->s_mb_stats)
>  			atomic64_inc(&sbi->s_bal_cX_groups_considered[cr]);
> -		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr))) {
> +		if (likely(ext4_mb_good_group(ac, iter->bb_group, cr)) &&
> +		    !spin_is_locked(ext4_group_lock_ptr(ac->ac_sb, iter->bb_group))) {

same as above
 
>  			grp = iter;
>  			break;
>  		}
> @@ -2911,7 +2913,13 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			if (err)
>  				goto out;
>  
> -			ext4_lock_group(sb, group);
> +			/* skip busy group */
> +			if (cr >= CR_ANY_FREE) {
> +				ext4_lock_group(sb, group);
> +			} else if (!ext4_try_lock_group(sb, group)) {
> +				ext4_mb_unload_buddy(&e4b);
> +				continue;
> +			}

This in itself looks good. I am just thinking that now that we are
deciding to skip locked groups, in the code above this one, shall we do
something like:

      
      if (spin_is_locked(group_lock))
        continue;
      
      err = ext4_mb_load_buddy(sb, group, &e4b);
      if (err)
        goto out;

      /* skip busy group */
      if (cr >= CR_ANY_FREE) {
        ext4_lock_group(sb, group);
      } else if (!ext4_try_lock_group(sb, group)) {
        ext4_mb_unload_buddy(&e4b);
        continue;
      }

With this we can even avoid loading the folio as well.

Regards,
ojaswin
>  
>  			/*
>  			 * We need to check again after locking the
> -- 
> 2.46.1
> 

