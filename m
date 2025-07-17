Return-Path: <linux-ext4+bounces-9040-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F0DB08E60
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50521C24343
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 13:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801592EBDD9;
	Thu, 17 Jul 2025 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k4XZkrNW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680852EBBAE;
	Thu, 17 Jul 2025 13:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752759419; cv=none; b=ItM0dX1lyun+hGQ64CQpXbTrTbPr3n1DLDQ7B4pOsSzUFSpWx6158QMClBzYe3NX3gwNKORGBHjso072Ycw9iYs3MCfPozxgRXoBSrClPtfA3EQCGqSl2pANh1dYgTuuoRuzVCluMK1YCrHgieikr6lzxl1xg3P3C1klWrf4amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752759419; c=relaxed/simple;
	bh=/ldtFck+Be6UouYIfgbMIxzjxt/Ajol9hGW/9g3Sig0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=md+VkknK8rIePnFYu8Ey44/o0oDT1+ve9PSMzUJqfY9PmBD44blwvqYji04v/Ju9t6cIiQ1DozN7/mFmpYLSugtilQA5ysvNoia6vWIX3Y+hUE/Cd6jO5MxWWlNqv27pwnObKo2ai9XRwBG23VAxLtFi3e0oiN8MB5y7w1rgGUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k4XZkrNW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H8B5YF019585;
	Thu, 17 Jul 2025 13:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cJw1j6QVlLwuBEjmoNQAKkPo+HBShx
	qbCWTcgAYg3EY=; b=k4XZkrNWEc6Nc3f0hGl1HjmIo7j0Igxkzm9WYQT8Z9qZqf
	6eMdQIpzfRYt/cYCl/GsLF2qY09NhA4eaxbKsKUaVylSghEL9jPYXDluiIBwT5Lh
	s1o4t+RZnKs4F3h7ONqOL3Qqmm2hy3aOL1LgN0UC7j7evPmbKtNv4Jh01l1AXR85
	aBtIsetYgasHP6TgBygbZXLG8VJr6Vk/pDLfeveCQXC3yw9aOUYuCKVsMnBIApMp
	/V1CWn2ZUksxW2ji1RvLpg3qtYVLFA8EnQhITv9iLUy+i2jgMdAzPOPfYwUwcVKe
	d4ZYCU4pf1hVV8AIPe/ZCApKg6SDMlZMb6d9qZTA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh904df9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 13:36:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC10Pb031918;
	Thu, 17 Jul 2025 13:36:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21ucm3g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 13:36:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HDaV1753281114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 13:36:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FF5220040;
	Thu, 17 Jul 2025 13:36:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039252004B;
	Thu, 17 Jul 2025 13:36:29 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Jul 2025 13:36:28 +0000 (GMT)
Date: Thu, 17 Jul 2025 19:06:26 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
        yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 04/17] ext4: remove unnecessary s_md_lock on update
 s_mb_last_group
Message-ID: <aHj8WmfJvB3h6lOZ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-5-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YsGTF0nbc8O18EQ-I-q93N206vsrFPvs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExNyBTYWx0ZWRfXwhjqmzBC3o17 rucd5QEvUDx4BqM9MTq8dT57VdfXyKb7BSZwK4k4PeDwRxartI24V6NtxUd71ZfLSgCB4cikBbe 1myHAFvQLzetNs6izwb/p9aMQ0n2EB8jMGNPLD3c+1DRZDbXIwtSFwl69pejmRU+l72t95Wayxo
 RhVYs3R7gkSKcqGcFHWwCaOODNC/Hv6N62iLU6q6Ey4D+s8IKc60pgJy5wCVgzxnqDBNnkS6EuR 7uxsjrlP+v9acDvy+/xVsllUdQL/xe/qCRpnw/pCONxmID01/Ys09H5lqbrNEpaBnm0Cb5/d8wE +QfGRE/2Nxzd+ZXmSl2bp9sEcIQSGWXFUIGzlZd53JtyLXE9WVSCCZENYeFT4K3JJIFmEETQKfh
 nAVBzGRYZU9hWZPaoAjZO71jW/Jt2WlvcEirfXNx5QR5+QJLDFFwXRATVsbTphzwAw+Ys+eP
X-Proofpoint-GUID: YsGTF0nbc8O18EQ-I-q93N206vsrFPvs
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=6878fc62 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=i0EeH86SAAAA:8 a=sE3mw-GcHDnqjceNmLYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170117

On Mon, Jul 14, 2025 at 09:03:14PM +0800, Baokun Li wrote:
> After we optimized the block group lock, we found another lock
> contention issue when running will-it-scale/fallocate2 with multiple
> processes. The fallocate's block allocation and the truncate's block
> release were fighting over the s_md_lock. The problem is, this lock
> protects totally different things in those two processes: the list of
> freed data blocks (s_freed_data_list) when releasing, and where to start
> looking for new blocks (mb_last_group) when allocating.
> 
> Now we only need to track s_mb_last_group and no longer need to track
> s_mb_last_start, so we don't need the s_md_lock lock to ensure that the
> two are consistent. Since s_mb_last_group is merely a hint and doesn't
> require strong synchronization, READ_ONCE/WRITE_ONCE is sufficient.

Hi Baokun,

So i just got curious of the difference between smp_load_acquire vs
READ_ONCE on PowerPC, another weak memory ordering arch.
Interestingly, I didn't see that big of a single threaded drop.

The number are as follows (mb_opt_scan=1):

100 threads 
w/ smp_load_acquire    1668 MB/s 
w/ READ_ONCE           1599 MB/s

1 thread pinned to 1 cpu
w/ smp_load_acquire    292 MB/s
w/ READ_ONCE           296 MB/s

Either ways, this is much better than the base which is around 500MB/s
but just thought I'd share it here

Feel free to add:
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin
> 
> Besides, the s_mb_last_group data type only requires ext4_group_t
> (i.e., unsigned int), rendering unsigned long superfluous.
> 
> Performance test data follows:
> 
> Test: Running will-it-scale/fallocate2 on CPU-bound containers.
> Observation: Average fallocate operations per container per second.
> 
> |CPU: Kunpeng 920   |          P80           |            P1           |
> |Memory: 512GB      |------------------------|-------------------------|
> |960GB SSD (0.5GB/s)| base  |    patched     | base   |    patched     |
> |-------------------|-------|----------------|--------|----------------|
> |mb_optimize_scan=0 | 4821  | 9636  (+99.8%) | 314065 | 337597 (+7.4%) |
> |mb_optimize_scan=1 | 4784  | 4834  (+1.04%) | 316344 | 341440 (+7.9%) |
> 
> |CPU: AMD 9654 * 2  |          P96           |             P1          |
> |Memory: 1536GB     |------------------------|-------------------------|
> |960GB SSD (1GB/s)  | base  |    patched     | base   |    patched     |
> |-------------------|-------|----------------|--------|----------------|
> |mb_optimize_scan=0 | 15371 | 22341 (+45.3%) | 205851 | 219707 (+6.7%) |
> |mb_optimize_scan=1 | 6101  | 9177  (+50.4%) | 207373 | 215732 (+4.0%) |
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/ext4.h    |  2 +-
>  fs/ext4/mballoc.c | 12 +++---------
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index b83095541c98..7f5c070de0fb 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1630,7 +1630,7 @@ struct ext4_sb_info {
>  	unsigned int s_mb_group_prealloc;
>  	unsigned int s_max_dir_size_kb;
>  	/* where last allocation was done - for stream allocation */
> -	unsigned long s_mb_last_group;
> +	ext4_group_t s_mb_last_group;
>  	unsigned int s_mb_prefetch;
>  	unsigned int s_mb_prefetch_limit;
>  	unsigned int s_mb_best_avail_max_trim_order;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e3a5103e1620..025b759ca643 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2168,11 +2168,8 @@ static void ext4_mb_use_best_found(struct ext4_allocation_context *ac,
>  	ac->ac_buddy_folio = e4b->bd_buddy_folio;
>  	folio_get(ac->ac_buddy_folio);
>  	/* store last allocated for subsequent stream allocation */
> -	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		spin_lock(&sbi->s_md_lock);
> -		sbi->s_mb_last_group = ac->ac_f_ex.fe_group;
> -		spin_unlock(&sbi->s_md_lock);
> -	}
> +	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC)
> +		WRITE_ONCE(sbi->s_mb_last_group, ac->ac_f_ex.fe_group);
>  	/*
>  	 * As we've just preallocated more space than
>  	 * user requested originally, we store allocated
> @@ -2845,10 +2842,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  
>  	/* if stream allocation is enabled, use global goal */
>  	if (ac->ac_flags & EXT4_MB_STREAM_ALLOC) {
> -		/* TBD: may be hot point */
> -		spin_lock(&sbi->s_md_lock);
> -		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> -		spin_unlock(&sbi->s_md_lock);
> +		ac->ac_g_ex.fe_group = READ_ONCE(sbi->s_mb_last_group);
>  		ac->ac_g_ex.fe_start = -1;
>  		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;
>  	}
> -- 
> 2.46.1
> 

