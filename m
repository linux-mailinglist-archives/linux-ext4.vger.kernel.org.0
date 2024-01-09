Return-Path: <linux-ext4+bounces-752-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F7F82836F
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 10:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157BC1C24E17
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 09:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BFA3526E;
	Tue,  9 Jan 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sDbA/5To"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C30BA45;
	Tue,  9 Jan 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4098bL5c001344;
	Tue, 9 Jan 2024 09:44:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=26z/r7QxDnFtFAUCTROyBwwWOvN7pyqyOM2zc9V1Dj0=;
 b=sDbA/5To12520VCHEHJOxXdzy6phnqROMSo29BOHVJ6Aup9wb83q9m/9IYiPshzoWtMk
 4z0ohV4OKIMbeyeUCEo2EOni8tJWuZmcYf0WgKOX360HMYmOef7EvXP1QOUz+RNGqgsy
 EjDPa2nTmrHqK+8RdNTJe3bDSwR2zJdIvJQmjVhLXktYxq22dqG8U5ZXu3JShMcmBnAK
 E41ca8ePAV40OvVAYeS+mL0ptEovtFvX6e+szA6DoV+HSxTFmBRzR8bq3TOWm2Q409LI
 3P8Ffn+K4PgvlaY1n3VUwXYJTmdXeF4kCnaquPoj2JubQHiJqfUnnTeFwKbnnZs9bQZf 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh2sp9jax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:44:58 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 409908US013177;
	Tue, 9 Jan 2024 09:44:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vh2sp9hpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:44:56 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4097rtWZ004407;
	Tue, 9 Jan 2024 09:41:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vfjpknktx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 09:41:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4099expC39977436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 09:40:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644D120043;
	Tue,  9 Jan 2024 09:40:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBCB320040;
	Tue,  9 Jan 2024 09:40:57 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Jan 2024 09:40:57 +0000 (GMT)
Date: Tue, 9 Jan 2024 15:10:54 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        glandvador@yahoo.com, bugzilla@eyal.emu.id.au
Subject: Re: [PATCH 1/1] ext4: fallback to complex scan if aligned scan
 doesn't work
Message-ID: <ZZ0Upv7ZLwf0BMOC@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
 <ee033f6dfa0a7f2934437008a909c3788233950f.1702455010.git.ojaswin@linux.ibm.com>
 <20240104152717.rj7mmmij77q3mbiu@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104152717.rj7mmmij77q3mbiu@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oLGtudBlBM9LqGTjhP0iLbSK-4_HD4Ui
X-Proofpoint-GUID: cw738cPN1tciPvm7lGAuk0sFFT7SHZGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_03,2024-01-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401090077

On Thu, Jan 04, 2024 at 04:27:17PM +0100, Jan Kara wrote:
> On Fri 15-12-23 16:49:50, Ojaswin Mujoo wrote:
> > Currently in case the goal length is a multiple of stripe size we use
> > ext4_mb_scan_aligned() to find the stripe size aligned physical blocks.
> > In case we are not able to find any, we again go back to calling
> > ext4_mb_choose_next_group() to search for a different suitable block
> > group. However, since the linear search always begins from the start,
> > most of the times we end up with the same BG and the cycle continues.
> > 
> > With large fliesystems, the CPU can be stuck in this loop for hours
> > which can slow down the whole system. Hence, until we figure out a
> > better way to continue the search (rather than starting from beginning)
> > in ext4_mb_choose_next_group(), lets just fallback to
> > ext4_mb_complex_scan_group() in case aligned scan fails, as it is much
> > more likely to find the needed blocks.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> If I understand the difference right, the problem is that while
> ext4_mb_choose_next_group() guarantees large enough free space extent for
> the CR_GOAL_LEN_FAST or CR_BEST_AVAIL_LEN passes, it does not guaranteed
> large enough *aligned* free space extent. Thus for non-aligned allocations
> we can fail only due to a race with another allocating process but with
> aligned allocations we can consistently fail in ext4_mb_scan_aligned() and
> thus livelock in the allocation loop.
> 
> If my understanding is correct, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Hey Jan,

Yes you are correct, thanks for the review.

As you said, it's theoretically possible to livelock during non stripe
scenarios as well, but the probability of getting stuck for any
significant amount of time is really really less. I'm not sure if that
is enough to justify adding some logic to optimize the search for such
scenarios as that might need more involved code changes.

Regards,
ojaswin
> 
> 
> 
> > ---
> >  fs/ext4/mballoc.c | 21 +++++++++++++--------
> >  1 file changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index d72b5e3c92ec..63f12ec02485 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -2895,14 +2895,19 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
> >  			ac->ac_groups_scanned++;
> >  			if (cr == CR_POWER2_ALIGNED)
> >  				ext4_mb_simple_scan_group(ac, &e4b);
> > -			else if ((cr == CR_GOAL_LEN_FAST ||
> > -				 cr == CR_BEST_AVAIL_LEN) &&
> > -				 sbi->s_stripe &&
> > -				 !(ac->ac_g_ex.fe_len %
> > -				 EXT4_B2C(sbi, sbi->s_stripe)))
> > -				ext4_mb_scan_aligned(ac, &e4b);
> > -			else
> > -				ext4_mb_complex_scan_group(ac, &e4b);
> > +			else {
> > +				bool is_stripe_aligned = sbi->s_stripe &&
> > +					!(ac->ac_g_ex.fe_len %
> > +					  EXT4_B2C(sbi, sbi->s_stripe));
> > +
> > +				if ((cr == CR_GOAL_LEN_FAST ||
> > +				     cr == CR_BEST_AVAIL_LEN) &&
> > +				    is_stripe_aligned)
> > +					ext4_mb_scan_aligned(ac, &e4b);
> > +
> > +				if (ac->ac_status == AC_STATUS_CONTINUE)
> > +					ext4_mb_complex_scan_group(ac, &e4b);
> > +			}
> >  
> >  			ext4_unlock_group(sb, group);
> >  			ext4_mb_unload_buddy(&e4b);
> > -- 
> > 2.39.3
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

