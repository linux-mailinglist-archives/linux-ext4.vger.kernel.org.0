Return-Path: <linux-ext4+bounces-3786-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47EE957E47
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 08:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC0F1C239BF
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 06:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF31AE855;
	Tue, 20 Aug 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sl+FcqZq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF116B391;
	Tue, 20 Aug 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724135479; cv=none; b=IcUjahGZSX94Z5bi17oGVWtXQgFLRJq978CQANXGgNWFN+ofBeSM8Zhz3t/cYdffYlBG14LoWUL0TLIpM7d3M0D4AVa8Hx2x6tr2EB4F04fK5Ko+/+SWV6O9igMfXBiQu05s1jocCNfLs3FE4nhezCdmKO/5XspAUdSy4d4iYkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724135479; c=relaxed/simple;
	bh=MGMSv63RgBSwL0d2+w0KmKdyp7OpMErP/z85PgKoX4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5rWxG7C1JIryMuE5rn34UdA/eJHoCe3QH2WqVPGgriJBvIavP9vwXhrZaz+JDS4EY6lHAPlFPdDV/wklIyIVat3mplRAgSnuMleDgbB152kVYj4wgNK17Pq9E4mXFEsvpCco4RW1g+8dp91rVNwc4oRYNuoIYJwqEvm7sjr4Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sl+FcqZq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JHT8XT031020;
	Tue, 20 Aug 2024 06:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=BvVgybZp3Aak/RqXX2r4Y0PJ+/P
	n2S/9BT+Ml05IGJQ=; b=Sl+FcqZqeC5DWahxjkEQF4pYUnHI7XUMFN6clhbBKRI
	45MA7rjO+PykZ1nUktpKkRFE9hN3pRWctFfkuRBJpX95Hh6xwUN+W1hFmAlF2RGP
	9+rHM0TauUsJM5nx18KGGlSjt0KUGMykAlSc70OJah+vLVoot8sbDTy9DDKtk7hO
	d8iblXnXwtil9mpVJmWU4bQBVNO88nWLE7I0wPqhEjJ+UUVmu6boa4vNXLW+tyY3
	r0ElVDZS1a9zWpX8p2zgo6j7SGMJ6pzNrDrvSZIRPgxqpjJ/Pvwtmj9301mOW6oF
	p7pOEZfLYrfzbgsFCGuH1B7Y4X/XcDx8RMZccZYa6kQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5ma12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:31:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K6V45O014836;
	Tue, 20 Aug 2024 06:31:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412mb5ma10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:31:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K318lQ029237;
	Tue, 20 Aug 2024 06:31:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138dm9d64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 06:31:03 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K6V0xa22544726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 06:31:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 350B120043;
	Tue, 20 Aug 2024 06:31:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E42B220040;
	Tue, 20 Aug 2024 06:30:58 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.42.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 Aug 2024 06:30:58 +0000 (GMT)
Date: Tue, 20 Aug 2024 12:00:56 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] ext4: Check stripe size compatibility on remount as
 well
Message-ID: <ZsQ4IA84NCRcVJg5@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
 <2475f15a-d332-bef1-4ea6-70461f7ef3bb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2475f15a-d332-bef1-4ea6-70461f7ef3bb@huaweicloud.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g2NJtrWAmfKf5Lfy8fIMjOKA3kvLTqE6
X-Proofpoint-GUID: AxBb7LLMrtlu3lIQ0vM1QHbOIEDxiAnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200044

On Mon, Aug 19, 2024 at 08:31:26PM +0800, Kemeng Shi wrote:
> 
> 
> on 8/16/2024 3:57 PM, Ojaswin Mujoo wrote:
> > We disable stripe size in __ext4_fill_super if it is not a multiple of
> > the cluster ratio however this check is missed when trying to remount.
> > This can leave us with cases where stripe < cluster_ratio after
> > remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
> > unforeseen bugs like divide by 0.
> > 
> > Fix that by adding the check in remount path as well.
> > 
> > Additionally, change the users of EXT4_B2C(sbi->s_stripe) to
> > EXT4_NUM_B2C() so that if we ever accidentally hit this again, we can
> > avoid the value becoming 0. This should not change existing functionality.
> It's better to mention this change is in following patch or simply remove
> it from this patch.

Oh yes you are right, I accidentally left it here. I'll fix it.
> 
> Other than that, looks good to me. Feel free to add:
> 
> Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>

Thanks for the review!

Regards,
Ojaswin
> > 
> > Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> > Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> > Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/super.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index e72145c4ae5a..9d495d78d262 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5165,6 +5165,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * It's hard to get stripe aligned blocks if stripe is not aligned with
> > + * cluster, just disable stripe and alert user to simpfy code and avoid
> > + * stripe aligned allocation which will rarely successes.
> > + */
> > +static bool ext4_is_stripe_incompatible(struct super_block *sb, unsigned long stripe)
> > +{
> > +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +	return (stripe > 0 && sbi->s_cluster_ratio > 1 &&
> > +		stripe % sbi->s_cluster_ratio != 0);
> > +}
> > +
> >  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  {
> >  	struct ext4_super_block *es = NULL;
> > @@ -5272,13 +5284,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> >  		goto failed_mount3;
> >  
> >  	sbi->s_stripe = ext4_get_stripe_size(sbi);
> > -	/*
> > -	 * It's hard to get stripe aligned blocks if stripe is not aligned with
> > -	 * cluster, just disable stripe and alert user to simpfy code and avoid
> > -	 * stripe aligned allocation which will rarely successes.
> > -	 */
> > -	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
> > -	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
> > +	if (ext4_is_stripe_incompatible(sb, sbi->s_stripe)) {
> >  		ext4_msg(sb, KERN_WARNING,
> >  			 "stripe (%lu) is not aligned with cluster size (%u), "
> >  			 "stripe is disabled",
> > @@ -6441,6 +6447,15 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
> >  
> >  	}
> >  
> > +	if ((ctx->spec & EXT4_SPEC_s_stripe) &&
> > +	    ext4_is_stripe_incompatible(sb, ctx->s_stripe)) {
> > +		ext4_msg(sb, KERN_WARNING,
> > +			 "stripe (%lu) is not aligned with cluster size (%u), "
> > +			 "stripe is disabled",
> > +			 ctx->s_stripe, sbi->s_cluster_ratio);
> > +		ctx->s_stripe = 0;
> > +	}
> > +
> >  	/*
> >  	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
> >  	 * two calls to ext4_should_dioread_nolock() to return inconsistent
> > 
> 

