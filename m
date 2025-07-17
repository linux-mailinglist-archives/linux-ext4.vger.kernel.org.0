Return-Path: <linux-ext4+bounces-9036-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2892EB08A8A
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CB64A1B68
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 10:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CF5299957;
	Thu, 17 Jul 2025 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="igu40ym/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0DD299A8E;
	Thu, 17 Jul 2025 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752748214; cv=none; b=CsYPDLM0l52jcG1d7FLpPpsPRDTiCGXlTPROPGRtJRVOmf5febm1rHpDuQTb1T568/8EtpJ3Ou8R84A9hCfyYdY3SN5n4g5LGlEBPU57APDmgfDVPEqhcKByCh5zEUz1Vn7CBZ7iHofEvxGqWllQQz0/EzJP84s2VtsX8tzXC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752748214; c=relaxed/simple;
	bh=PF8hynOMolcglnafslbmqSGN5JRS9OFzi3kNiS4aNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI9samLgqTSUCqmDHeBIRgh32Sk/im/pGgSTPD8w/V/EYdw0qhLbMC3VaZL8oVTUvDSsDVjdnKPut2PaS/tC5/Q4R38BnQOiEEF+ttQIy4oVwW0FKSj8nf98lMqWmdeiUpw5mm7B2y5f1ubL6e48YqD8PS5rveNbf5aiNdipsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=igu40ym/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H26K2I031328;
	Thu, 17 Jul 2025 10:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xuCiFHTfULOxLAhaq2IdmuafyFyXtP
	zi/TpTO2v1iBo=; b=igu40ym/2BCsW5Z1VOD778cW7QF6RkKasaH06a1ZkNRNAw
	jPWpgUIYqm3SaSZk2iTAhBLSQ24kpleCmOMayeMgmACwilRkTDwmgTQN6yWYr6Z2
	t57WgGFqnE1jiXeIJMUVVG72+Phn2Z64hjQQj/PfSKGQe36ZzpazvN0Dzy9I9uNB
	CylJsudc9IjhmzotUH2ydvZsI5fwQUmZQq0thlcBOje9UouoCkrJRynpGKti9TFT
	9o52ZECrBcxMPsHJdWM/+IfKl6nKBTI8o6pIuH+BKcB0hLuTE9eDzVcT0nSbmHFg
	M+XlwtEhQak3TipiowXrOXKiMfso0x9tS5q84w1w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47uf7dadhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:29:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HA1J3S000722;
	Thu, 17 Jul 2025 10:29:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48mbg14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 10:29:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HATnEZ53019048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 10:29:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDFC2004E;
	Thu, 17 Jul 2025 10:29:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2F152004B;
	Thu, 17 Jul 2025 10:29:46 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Jul 2025 10:29:46 +0000 (GMT)
Date: Thu, 17 Jul 2025 15:59:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        jack@suse.cz, linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
        yi.zhang@huawei.com, yangerkun@huawei.com, libaokun@huaweicloud.com
Subject: Re: [PATCH v3 02/17] ext4: separate stream goal hits from
 s_bal_goals for better tracking
Message-ID: <aHjQmHgSYmjwI6g8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20250714130327.1830534-1-libaokun1@huawei.com>
 <20250714130327.1830534-3-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714130327.1830534-3-libaokun1@huawei.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mmxE7gUjD-dt3QDqSV-AJ4iu_gS0kIoK
X-Authority-Analysis: v=2.4 cv=LoGSymdc c=1 sm=1 tr=0 ts=6878d0a0 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=zWkni7x_GnGFfIkcl88A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: mmxE7gUjD-dt3QDqSV-AJ4iu_gS0kIoK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDA5MCBTYWx0ZWRfX270mT3gPKqzF 2Orjb4kkjDkMscnkcWrj8s0ozExjp7d521u94cQgosNsSMe2mf6EzXSUOIy0BlP92US4pTRIpPa cao9sfa6EhqFZaeGIcjF/VhtZiaQiHqbknRwZ1Rsq5HBBDXtpFLuABXjOY0rHscSRC80a7X5Xpa
 +1m3J+z93o6ZMrPyM+mJKw9j1C5Sn9y3gLwDj2PQZjoRqiPhiRVSL8nYZ+ggOEIzGBM7Ayrr106 H/nnH2/LHgLP+7f5xUe2povv+FWu6dEi6m25o/gSNA2GBXrJa52+uipxHYlRhBRcaOsTp86d40c 6ziUf7jJnSY30sYYENkj7cSqpsbJltgJmvu1a4Err8PkgJy8lDPc6jkTNBATWJW8PMDMp1D/YVj
 l2J93IrhFcU4EbbPAT65bU7I5zV4qsC1RZB31z4zzYNhlskZKDbTqsSdh5TACxDTpQZJktBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 mlxscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507170090

On Mon, Jul 14, 2025 at 09:03:12PM +0800, Baokun Li wrote:
> In ext4_mb_regular_allocator(), after the call to ext4_mb_find_by_goal()
> fails to achieve the inode goal, allocation continues with the stream
> allocation global goal. Currently, hits for both are combined in
> sbi->s_bal_goals, hindering accurate optimization.
> 
> This commit separates global goal hits into sbi->s_bal_stream_goals. Since
> stream allocation doesn't use ac->ac_g_ex.fe_start, set fe_start to -1.
> This prevents stream allocations from being counted in s_bal_goals. Also
> clear EXT4_MB_HINT_TRY_GOAL to avoid calling ext4_mb_find_by_goal again.
> 
> After adding `stream_goal_hits`, `/proc/fs/ext4/sdx/mb_stats` will show:
> 
> mballoc:
> 	reqs: 840347
> 	success: 750992
> 	groups_scanned: 1230506
> 	cr_p2_aligned_stats:
> 		hits: 21531
> 		groups_considered: 411664
> 		extents_scanned: 21531
> 		useless_loops: 0
> 		bad_suggestions: 6
> 	cr_goal_fast_stats:
> 		hits: 111222
> 		groups_considered: 1806728
> 		extents_scanned: 467908
> 		useless_loops: 0
> 		bad_suggestions: 13
> 	cr_best_avail_stats:
> 		hits: 36267
> 		groups_considered: 1817631
> 		extents_scanned: 156143
> 		useless_loops: 0
> 		bad_suggestions: 204
> 	cr_goal_slow_stats:
> 		hits: 106396
> 		groups_considered: 5671710
> 		extents_scanned: 22540056
> 		useless_loops: 123747
> 	cr_any_free_stats:
> 		hits: 138071
> 		groups_considered: 724692
> 		extents_scanned: 23615593
> 		useless_loops: 585
> 	extents_scanned: 46804261
> 		goal_hits: 1307
> 		stream_goal_hits: 236317
> 		len_goal_hits: 155549
> 		2^n_hits: 21531
> 		breaks: 225096
> 		lost: 35062
> 	buddies_generated: 40/40
> 	buddies_time_used: 48004
> 	preallocated: 5962467
> 	discarded: 4847560
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/ext4.h    |  1 +
>  fs/ext4/mballoc.c | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 9df74123e7e6..8750ace12935 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1646,6 +1646,7 @@ struct ext4_sb_info {
>  	atomic_t s_bal_cX_ex_scanned[EXT4_MB_NUM_CRS];	/* total extents scanned */
>  	atomic_t s_bal_groups_scanned;	/* number of groups scanned */
>  	atomic_t s_bal_goals;	/* goal hits */
> +	atomic_t s_bal_stream_goals;	/* stream allocation global goal hits */
>  	atomic_t s_bal_len_goals;	/* len goal hits */
>  	atomic_t s_bal_breaks;	/* too long searches */
>  	atomic_t s_bal_2orders;	/* 2^order hits */
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 336d65c4f6a2..f56ac477c464 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2849,8 +2849,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		/* TBD: may be hot point */
>  		spin_lock(&sbi->s_md_lock);
>  		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
> -		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
>  		spin_unlock(&sbi->s_md_lock);
> +		ac->ac_g_ex.fe_start = -1;
> +		ac->ac_flags &= ~EXT4_MB_HINT_TRY_GOAL;

Hey Baokun, I was a bit late to review this in v2 so I'll add the
comment here:

So this is mostly to account for retires right? Maybe rather than
disabling goal allocation a better way to do this is resetting the
original goal group and goal start in the retry logic of
ext4_mb_new_blocks()? Since we drop preallocations before retrying, this
way we might actually find our goal during the retry. Its a slim chance
though but still feels like the right way to do it.

Thoughts?

Regards,
ojaswin

>  	}
>  
>  	/*
> @@ -3000,8 +3001,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		}
>  	}
>  
> -	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND)
> +	if (sbi->s_mb_stats && ac->ac_status == AC_STATUS_FOUND) {
>  		atomic64_inc(&sbi->s_bal_cX_hits[ac->ac_criteria]);
> +		if (ac->ac_flags & EXT4_MB_STREAM_ALLOC &&
> +		    ac->ac_b_ex.fe_group == ac->ac_g_ex.fe_group)
> +			atomic_inc(&sbi->s_bal_stream_goals);
> +	}
>  out:
>  	if (!err && ac->ac_status != AC_STATUS_FOUND && first_err)
>  		err = first_err;
> @@ -3194,6 +3199,8 @@ int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset)
>  	seq_printf(seq, "\textents_scanned: %u\n",
>  		   atomic_read(&sbi->s_bal_ex_scanned));
>  	seq_printf(seq, "\t\tgoal_hits: %u\n", atomic_read(&sbi->s_bal_goals));
> +	seq_printf(seq, "\t\tstream_goal_hits: %u\n",
> +		   atomic_read(&sbi->s_bal_stream_goals));
>  	seq_printf(seq, "\t\tlen_goal_hits: %u\n",
>  		   atomic_read(&sbi->s_bal_len_goals));
>  	seq_printf(seq, "\t\t2^n_hits: %u\n", atomic_read(&sbi->s_bal_2orders));
> -- 
> 2.46.1
> 

