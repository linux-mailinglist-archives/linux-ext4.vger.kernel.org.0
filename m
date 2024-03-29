Return-Path: <linux-ext4+bounces-1779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DB5891497
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 08:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC14287800
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Mar 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C240BF2;
	Fri, 29 Mar 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hi9PrpEa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6AC2EAF9;
	Fri, 29 Mar 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698751; cv=none; b=XzyXanEGF4d6vmZ4k8xosboMGr5HnSp/BY+OZotofka7jBwqFjwPt2ny5LY/wmWJaoglBvFKXT/DFpFt++28Plk0Dlrt/CuCJQudy4NmagpLwfWC9ejr/WT9THWXNZNH8w2fTYkTVBP/2utldgpDtAY1H8k9GmXOMZD26/RZ31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698751; c=relaxed/simple;
	bh=DP0txUzbQyK/PqLwVMgW1WySUT6g1lZEa7gy7+IFFNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f9WDF8MryRdowczkGG0o001r0opQ4WxeixRyGvlk7hCbmqSXHbCuuN3rd5JXIpaGr+Ug7TYdr09CHJ6eZ1E2OSm+RXl7z34a3BP9C56s3Rn5yCyDKTGRXAESwNuOPH+RBY9R9IkIwDmnrXPJu0nWPqpv/sp3VO4vWXyFzTXFRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hi9PrpEa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42T7baIF018670;
	Fri, 29 Mar 2024 07:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=c9uLL3Nz015u/tWWf9Y1TexpOcWRcE20CZEZwSdzBZs=;
 b=hi9PrpEaiH5mLKCMgI5+Xn5vE9oshlxRycwVKRy2sC5m3PcDZu+xEMw6hRSBh2ZofFlF
 vh6UAYIJ7G4wWaOnqnc9odxnmlXHqKOl4Y5wtShrau8EQwERQbPuNo7r5qpHo44QUoJP
 KtcRgtmbtzXhi6q//Pfy4LDqjUPdWNKnz/z1jsNOfUgWW/RDyrQGWsvWx/uIweUtsylK
 t5y5JF7M9cZ3868lbNWaJCeut/B09LVv9W8wi82kgh9K8+im1eDj9v/a/i+BhgnXH+GJ
 uiK0zbG0h858b1HXuE5hx3laKbPmwKw1SmvUl5UTkWJaGu9+I1u+zPPQfXah0P1bSTof WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5sdp80ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:52:18 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42T7qIGe010152;
	Fri, 29 Mar 2024 07:52:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x5sdp80t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:52:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42T5om2w028675;
	Fri, 29 Mar 2024 07:52:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adpts9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 07:52:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42T7qCKJ43975152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 07:52:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD14B2006A;
	Fri, 29 Mar 2024 07:52:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0759C2004F;
	Fri, 29 Mar 2024 07:52:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.115.153])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 29 Mar 2024 07:52:10 +0000 (GMT)
Date: Fri, 29 Mar 2024 13:22:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz, ritesh.list@gmail.com
Subject: Re: [PATCH 1/5] ext4: keep "prefetch_grp" and "nr" consistent
Message-ID: <ZgZzKILKOki1CCml@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-2-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326213823.528302-2-shikemeng@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hnDzXkGczGIxLjcxUVqZRvXPa4OOlc0d
X-Proofpoint-ORIG-GUID: RjRud5sOD-5ALraTjwBcSLh-0IwSQd43
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_06,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290066

On Wed, Mar 27, 2024 at 05:38:19AM +0800, Kemeng Shi wrote:
> Keep "prefetch_grp" and "nr" consistent to avoid to call
> ext4_mb_prefetch_fini with non-prefetched groups.
> When we step into next criteria, "prefetch_grp" is set to prefetch start
> of new criteria while "nr" is number of the prefetched group in previous
> criteria. If previous criteria and next criteria are both inexpensive
> (< CR_GOAL_LEN_SLOW) and prefetch_ios reachs sbi->s_mb_prefetch_limit
> in previous criteria, "prefetch_grp" and "nr" will be inconsistent and
> may introduce unexpected cost to do ext4_mb_init_group for non-prefetched
> groups.
> Reset "nr" to 0 when we reset "prefetch_grp" to start of prefech in next
> criteria to ensure "prefetch_grp" and "nr" are consistent.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 12b3f196010b..a61fc52956b2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2856,6 +2856,7 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  		group = ac->ac_g_ex.fe_group;
>  		ac->ac_groups_linear_remaining = sbi->s_mb_max_linear_groups;
>  		prefetch_grp = group;
> +		nr = 0;

Looks good, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

To add some thoughts, I think the way we depend on group and nr being in
sync for prefetch and prefetch_fini to work is very fragile and I've
seen some issues there in the past as well. I believe a better approach
would be to use some kind of list which is populated with group nos by
prefetch() and then looked up by prefetch_fini() to initialize the buddy
and other data structures.

As the comment on ext4_mb_prefetch_fini() suggests, we can also look
into eliminating this function completely by using a bg worker queue
kick off when prefetch of the bitmap is complete although we'll also
need to take care of the other caller of these functions ie the 
lazy initialization thread that prefetches block bitmaps in BG
(ext4_lazyinit_thread())

Regards,
ojaswin

>  
>  		for (i = 0, new_cr = cr; i < ngroups; i++,
>  		     ext4_mb_choose_next_group(ac, &new_cr, &group, ngroups)) {
> -- 
> 2.30.0
> 

