Return-Path: <linux-ext4+bounces-1777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8DA89140E
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 08:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F725289002
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF98A3FBBC;
	Fri, 29 Mar 2024 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iksif7ri"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335D93FB8C;
	Fri, 29 Mar 2024 07:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711696592; cv=none; b=r4Bg52aMAcAx6FgWHSKkzr46znvdJrNieDBSoFmtH6u+iGLHFbVQeJavTcpQ7KYQLi2g1QuImCm95w99Tr2C8Y3qxZQGzQ1L3QwrA+6HDWqDpuZ/DLy1Pd/+hIH7ZCzenfpYk8PgD4RV/JpopSdHtJGLQJpBbFpUiS71CE/gadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711696592; c=relaxed/simple;
	bh=Ev98fKmh39oX3GTREoTUTFF4eGgbYjmzC28MTusAFPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4D3Lx2ejVa2/KXTbpYoMl8DoevEb1dG9J9fTqy0xzp4kY9cdgiyFToxnqoZ6AW+d9GZ2qdaVFj5M8GNgQ993HewbijHEc0BXE+qSxh/iyUkcU52NXX/Qd3lTP02O2UMkYsextfkz4xKiOZdlWxc/KToXieVsosPZJS8eKx6hcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iksif7ri; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T73UBi006567;
	Fri, 29 Mar 2024 07:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=2CYgJP3ojhBQiLW0Of7Q2BULE3M0/2ey8CU7au28ncs=;
 b=iksif7riljXLMSTt8QcJdasM6guPku1YJdaVYKKbPOUvaxQsw6RGo7PWEQUAHvfkV8Lm
 bQTqlpBz+8CfwRUg6ipKVw8TVP3IE0vw1derFmIRSzjHj4m7dhOL7o/wKkQiBcEtsxTn
 LYcCZ6Bt/slzMkmDUZPmNVsu5wQxTWVWBeZ+HbAOSdDHYExFvixIxgbiM7XFa1AwZjSJ
 td/eVl1Fd6Atn+dg5u/01JCchCvqMK03D7o8lXliNXsltB2nUY7QY4zeyQaep6ORJ0og
 Ftl7p6klw94K7ek/s1ZVhqNyFj+aBAhlcKNHSx5UcWThBjBeZkgyWM+PyWjOTw88qDAF tw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5rw880t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:16:19 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42T7GIkB026855;
	Fri, 29 Mar 2024 07:16:18 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5rw880sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:16:18 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42T5UEi1016605;
	Fri, 29 Mar 2024 07:16:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dujxsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:16:06 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42T7G2VW49086788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 07:16:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B13D20040;
	Fri, 29 Mar 2024 07:16:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4D8320043;
	Fri, 29 Mar 2024 07:16:00 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.115.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 07:16:00 +0000 (GMT)
Date: Fri, 29 Mar 2024 12:45:58 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, ritesh.list@gmail.com
Subject: Re: [PATCH 4/5] ext4: use correct criteria name instead stale
 integer number in comment
Message-ID: <ZgZqrhinpCfwd2ub@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-5-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-5-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Bl-tQONuqMiGmvyE7YhDkAf6TAoBfqFZ
X-Proofpoint-GUID: -bYbZpkKX7zPc2DSlEq2cuohaYKqDWVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403290061

On Wed, Mar 27, 2024 at 05:38:22AM +0800, Kemeng Shi wrote:
> Use correct criteria name instead stale integer number in comment
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/ext4.h    | 15 ++++++++++++---
>  fs/ext4/mballoc.c | 14 ++++++++------
>  fs/ext4/mballoc.h |  4 ++--
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 

Thanks for the cleanup! Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 023571f8dd1b..9b90013c59a3 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -213,11 +213,20 @@ enum criteria {
>  #define EXT4_MB_USE_RESERVED		0x2000
>  /* Do strict check for free blocks while retrying block allocation */
>  #define EXT4_MB_STRICT_CHECK		0x4000
> -/* Large fragment size list lookup succeeded at least once for cr = 0 */
> +/*
> + * Large fragment size list lookup succeeded at least once for cr =
> + * CR_POWER2_ALIGNED
> + */
>  #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
> +/*
> + * Avg fragment size rb tree lookup succeeded at least once for cr =
> + * CR_GOAL_LEN_FAST
> + */
>  #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
> +/*
> + * Avg fragment size rb tree lookup succeeded at least once for cr =
> + * CR_BEST_AVAIL_LEN
> + */
>  #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
>  
>  struct ext4_allocation_request {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 62d468379722..0f8a34513bf6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>  	} else {
>  		/*
> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
> -		 * bb_free. But until that happens, we should never come here.
> +		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
> +		 * rb tree sorted by bb_free. But until that happens, we should
> +		 * never come here.
>  		 */
>  		WARN_ON(1);
>  	}
> @@ -3444,10 +3445,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	}
>  	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
>  		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
> -	/* now many real IOs to prefetch within a single allocation at cr=0
> -	 * given cr=0 is an CPU-related optimization we shouldn't try to
> -	 * load too many groups, at some point we should start to use what
> -	 * we've got in memory.
> +	/*
> +	 * now many real IOs to prefetch within a single allocation at
> +	 * cr=CR_POWER2_ALIGNED. Given cr=CR_POWER2_ALIGNED is an CPU-related
> +	 * optimization we shouldn't try to load too many groups, at some point
> +	 * we should start to use what we've got in memory.
>  	 * with an average random access time 5ms, it'd take a second to get
>  	 * 200 groups (* N with flex_bg), so let's make this limit 4
>  	 */
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index 56938532b4ce..042437d8860f 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -187,8 +187,8 @@ struct ext4_allocation_context {
>  	struct ext4_free_extent ac_f_ex;
>  
>  	/*
> -	 * goal len can change in CR1.5, so save the original len. This is
> -	 * used while adjusting the PA window and for accounting.
> +	 * goal len can change in CR_BEST_AVAIL_LEN, so save the original len.
> +	 * This is used while adjusting the PA window and for accounting.
>  	 */
>  	ext4_grpblk_t	ac_orig_goal_len;
>  
> -- 
> 2.30.0
> 

