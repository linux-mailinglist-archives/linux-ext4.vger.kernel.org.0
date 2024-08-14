Return-Path: <linux-ext4+bounces-3726-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266689513AC
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79AE1F256D7
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 04:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B43762D2;
	Wed, 14 Aug 2024 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HQpYApMw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F374BE1;
	Wed, 14 Aug 2024 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611434; cv=none; b=hBBq8pkEPwVktZAcODiPZ6XQmvWm9PnpytRZ2Tb249u32AV2H2fJtE2uiE25a8lgP64QjoVuk947tAEf5KEQsn2Z/deRIGsRXIyDbSag0deNrFvOU8HoVuNhCWSy6Py6x+A0mOgv6ODFcPpfGAYq11B9VziRVEvf/FmV48doUjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611434; c=relaxed/simple;
	bh=6jDXZ2bF490Pr0zfc9p0rCYdE9kR6Ghz/8LE0YiANDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mmshK3LHbBivHwRfyUAv1+g/l4C3/yujoILyx1xtfadRQb6PfUhxMuYDHFSNXfO3Q0tXaeOljn2eiPoq6fu2nIkzo0EsqfwztCuTQUUnMVAWy236LlV4ViaDVCqIASVEY7w3z8zOamemdMfAf6BGPKTL8dUL3UH+VEObLCYlS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HQpYApMw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47E4qYOB011526;
	Wed, 14 Aug 2024 04:56:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=pp1; bh=Ddhcg/3r2KwKetNnTZFyvvMas9+
	S1rsiqHoUfB828h0=; b=HQpYApMwLvNUmQzJsGjbUFJSuh1XEB/+se6HtXTOLmD
	QkxPRqtCmQsKL1Ib6QE8PY4iUvdDBijZDoLxOI6U38+k271+k/HGpo3jViqYR8Vd
	mFc9ChycFwvNu3kW6SVw7Z5Wr82BJDhH3bbOUQcJqJzoiqJMczpTVJZ3LBOD7n1/
	gaamEP4Alwd2+kGepPfyPE0UnJnrwiCn4XH0M8skDscR/Ir1q5Q+PfQsUoZnEzf/
	zR7LuIh4NHECD5/OaGU47Y+pc+BPYQIeNzxfAiLG7ekasJMO1mZYgNSb5lrVTMow
	GBbvCL922R9HKHuqR8Izc9H3iwZxXGGXoszKmUK7MoA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410nxeg0j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 04:56:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47E4uujG018731;
	Wed, 14 Aug 2024 04:56:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 410nxeg0j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 04:56:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47E2krt2030516;
	Wed, 14 Aug 2024 04:56:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmfffn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Aug 2024 04:56:55 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47E4upRM54133206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 04:56:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D78D2004B;
	Wed, 14 Aug 2024 04:56:51 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C91DD2004D;
	Wed, 14 Aug 2024 04:56:49 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.36.223])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 14 Aug 2024 04:56:49 +0000 (GMT)
Date: Wed, 14 Aug 2024 10:26:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [PATCH] ext4: fix divide error in ext4_mb_regular_allocator
Message-ID: <Zrw4/N7a/XrjOgtS@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <000000000000b1b164061f96213d@google.com>
 <tencent_42D9D2CB066909BF6EDDAEDB8C8067F3C606@qq.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_42D9D2CB066909BF6EDDAEDB8C8067F3C606@qq.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FKGcC0358tlXSmTVQ9VNL_M7yrw0FvH2
X-Proofpoint-GUID: hnYDDOOa8yCrvJGkyopyjLRWbTy61Uht
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_03,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408140029

On Wed, Aug 14, 2024 at 10:12:00AM +0800, Edward Adam Davis wrote:
> Before determining that the goal length is a multiple of the stripe size,
> check CR_GOAL_LEN_FAST and CR_BEST_AVAIL_LEN first.
> 
> Fixes: 1f6bc02f1848 ("ext4: fallback to complex scan if aligned scan doesn't work")
> Reported-and-tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1ad8bac5af24d01e2cbd
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  fs/ext4/mballoc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9dda9cd68ab2..451f92cde461 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2928,13 +2928,12 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>       if (cr == CR_POWER2_ALIGNED)
>         ext4_mb_simple_scan_group(ac, &e4b);
>       else {
> -       bool is_stripe_aligned = sbi->s_stripe &&
> +       bool is_stripe_aligned = (cr == CR_GOAL_LEN_FAST ||
> +         cr == CR_BEST_AVAIL_LEN) && sbi->s_stripe &&
>           !(ac->ac_g_ex.fe_len %
>             EXT4_B2C(sbi, sbi->s_stripe));

Hi Edward, 

Thanks for the patch. So I didn't get a chance to look at syszcaller
report but assuming that EXT4_B2C(sbi, sbi->s_stripe) is becoming 0,
I'm not understanding how is this patch fixing the bug?

It just seems to short circuit the actual bug but we might still hit it
right? 

As for EXT4_B2C(stripe) becoming zero, I have 2 observations:

1. We should definitely be using EXT4_NUM_B2C() here to make sure we
   don't get 0 if stripe is less than cluster size.

2. That being saidIm not sure if it's even possible for this to become zero
   because we do check that stripe size is a multiple of cluster size in
   ext4_fill_super, else we disable it:

  /*
   * It's hard to get stripe aligned blocks if stripe is not aligned with
   * cluster, just disable stripe and alert user to simpfy code and avoid
   * stripe aligned allocation which will rarely successes.
   */
  if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
      sbi->s_stripe % sbi->s_cluster_ratio != 0) {
    ext4_msg(sb, KERN_WARNING,
       "stripe (%lu) is not aligned with cluster size (%u), "
       "stripe is disabled",
       sbi->s_stripe, sbi->s_cluster_ratio);
    sbi->s_stripe = 0;
  }

I'll try to look into this a bit more and get back. Do let me know
if I missed anything.

Regards,
Ojaswin

>  
> -       if ((cr == CR_GOAL_LEN_FAST ||
> -            cr == CR_BEST_AVAIL_LEN) &&
> -           is_stripe_aligned)
> +       if (is_stripe_aligned)
>           ext4_mb_scan_aligned(ac, &e4b);
>  
>         if (ac->ac_status == AC_STATUS_CONTINUE)
> -- 
> 2.43.0
> 


