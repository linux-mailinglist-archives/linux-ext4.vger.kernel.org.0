Return-Path: <linux-ext4+bounces-3785-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04C3957E18
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 08:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CB61F2416E
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 06:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C016B723;
	Tue, 20 Aug 2024 06:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pc3pyLFa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EF616B748;
	Tue, 20 Aug 2024 06:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135403; cv=none; b=iJEzxWlWm9Vf2xHqvFdZ7YtkjOh4FEMxz30Z+W5MDhZryRrQN/8OV3DJ7cjYgSb+LmkOOoZZ3YPl8K5mAgdaFitjjN15w8oxwt/R1Mp7qv0tB50CURfbBs0Y05sq2q20JrPueXy3DIi9CNS4MjnrEKIYHAS07+YrVn/UewrG3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135403; c=relaxed/simple;
	bh=B/4+o3L3XjIwt53Qu9qfxioBvLdQf1AnQvTj8yn7nD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE6UnjUGRXPxlweTPxTwJb3Owpmc+/38Qeg7nQaqGE9jfu1juRwk0LgGpO4g1qvZVjpUPVHSoyZLhU7XFazpEwZ/H6ygZ3Ob87gaAGW/a/nDI7KgU5LZ1OL4dwq89/YkoMM1KKNkaTMX94KgS/6qc35dOKdnfzfQRKC7emdCyjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pc3pyLFa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K20KpT030606;
	Tue, 20 Aug 2024 06:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ko7IKVJnMdRer7K+YhLLXetw3Qk
	eCTM/CSlxXsZPniQ=; b=pc3pyLFaDPPWQuoJAjo3XQ0+jlQ4PYEKyKucqJKxPUf
	LxUK3KPAmIoKvvWunqbN64XcO1cgXAYqOBVoC8e0LjvEKguaL01LJ/2CnRXw2n9a
	tu8KOa7wYx/AOgANAmcI4J0Zro+CwSTrX0AXcjnTptqFhUmXZpJzp5szlY7o5vGT
	6zoC/eF7xC7MvrJcHVEb6pWnYmsmzKlz0DXodymmmqSoX7U5Fu3u9sjJrqu2oPlc
	OAsg/EdE9QEtufql4Eam5wgHMKnxTZfprtptmOg4NGHyWa2V8/H3kmfUfGHuAEsD
	HyORh+2KhArxR9ZSxG9HBcA1O5yk8R8ryk6iVaN9ggQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04bdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:29:47 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6TleS026029;
	Tue, 20 Aug 2024 06:29:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma04bd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:29:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K6Jsh8002215;
	Tue, 20 Aug 2024 06:29:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4136k0hr9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:29:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6TgdK55771614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:29:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A6382004E;
	Tue, 20 Aug 2024 06:29:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 235C520040;
	Tue, 20 Aug 2024 06:29:41 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.42.135])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Aug 2024 06:29:40 +0000 (GMT)
Date: Tue, 20 Aug 2024 11:59:38 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to
 EXT4_NUM_B2C
Message-ID: <ZsQ30gFzp0IB/AGD@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
 <02e5b5139294897985f2b99729c5f3da3dd4f6f9.1723794770.git.ojaswin@linux.ibm.com>
 <94377e74-3159-8130-df96-7955b55755c2@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94377e74-3159-8130-df96-7955b55755c2@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GPNBcPITBe0TWom52mb27A5DOizSQ7F3
X-Proofpoint-ORIG-GUID: mUjohnY823Vddvv-1YBm0DsJv9pyt6Wt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200044

On Mon, Aug 19, 2024 at 08:51:58PM +0800, Kemeng Shi wrote:
> 
> 
> on 8/16/2024 3:57 PM, Ojaswin Mujoo wrote:
> > Although we have checks to make sure s_stripe is a multiple of cluster
> > size, in case we accidentally end up with a scenario where this is not
> > the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> > cases where EXT4_B2C(stripe) becomes 0.
> > 
> > Also make the is_stripe_aligned check in regular_allocator a bit more
> > robust while we are at it. This should ideally have no functional change
> > unless we have a bug somewhere causing (stripe % cluster_size != 0)
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>> ---
> >  fs/ext4/mballoc.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index 9dda9cd68ab2..b2e836a4bd18 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2553,7 +2553,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
> >  	do_div(a, sbi->s_stripe);
> >  	i = (a * sbi->s_stripe) - first_group_block;
> >  
> > -	stripe = EXT4_B2C(sbi, sbi->s_stripe);
> > +	stripe = EXT4_NUM_B2C(sbi, sbi->s_stripe);
> >  	i = EXT4_B2C(sbi, i);
> >  	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
> >  		if (!mb_test_bit(i, bitmap)) {
> > @@ -2929,8 +2929,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >  				ext4_mb_simple_scan_group(ac, &e4b);
> >  			else {
> >  				bool is_stripe_aligned = sbi->s_stripe &&
> > +					sbi->s_stripe >= sbi->s_cluster_ratio &&
> sbi->s_cluster_ratio is >= 1, so sbi->s_stripe >= sbi->s_cluster_ratio could
> cover the case that sbi->s_stripe is non-zero. Non-zero check of sbi->s_stripe
> seems not needed.

That makes sense Kemeng, I'll send a v2 with this change.

Thanks,
ojaswin

> >  					!(ac->ac_g_ex.fe_len %
> > -					  EXT4_B2C(sbi, sbi->s_stripe));
> > +					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
> >  
> >  				if ((cr == CR_GOAL_LEN_FAST ||
> >  				     cr == CR_BEST_AVAIL_LEN) &&
> > @@ -3707,7 +3708,7 @@ int ext4_mb_init(struct super_block *sb)
> >  	 */
> >  	if (sbi->s_stripe > 1) {
> >  		sbi->s_mb_group_prealloc = roundup(
> > -			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
> > +			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
> >  	}
> >  
> >  	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
> > 
> 

