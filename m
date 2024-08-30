Return-Path: <linux-ext4+bounces-3973-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAED49656A5
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88279283E65
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC3714A0B6;
	Fri, 30 Aug 2024 05:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aJz/mZOe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABD07406D;
	Fri, 30 Aug 2024 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994257; cv=none; b=Fj7Hv9FWbMQNbng3Mu1UbzGpSjWI+Ht5jLfuOm4bfa+zfdBlHXKRlI0vSRk+xfsAUDUfnCAWHqtIbwgqVYSKu/oa/DJliFds/YrDQgV7V05F02PH9ymYqUMVbqt3ftQAqdvC5+1mIcN3/eOXF8SdnNoxVe32k6iwGH0OPVqkreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994257; c=relaxed/simple;
	bh=XQbPEx9IodwMMxF9pHSSgsxGQWOXQ+aMJWPrwJMY0rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiUtkkXQgRj5l43N7pRI5yRNF13JRnBnVdVhByZWB7AfZZWCn754bazYWUiNgMTz8JxQ8Xthxt16EHPJvVN7rE8X+/a+9ypgkslnQ+uv7YkZOrbALonLeyBFR+uAHH1s3f+bVL+9A8SM3c7k9UnhNvM5Lmx9HPxv16e/7FWggiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aJz/mZOe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3Bpfw003658;
	Fri, 30 Aug 2024 05:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=ZcnGbgnkHa9f6r+1q722qq+XhF+
	9ZoNJ9z/gkgiN9VE=; b=aJz/mZOeNDeV6AsAD0NzmiuVRaPZfd/oIbQmSBy/Gfp
	CjMDt0idPdsNLwuJHFT6BlOri+ORbUZYQmYvDSn/z0ChpdLzrLekqPCAdYpLK8TI
	KvHaCCLT65RPmtFrgeaafKrm7KczPplWlEOhQ4pczwvnxfqEgFxuN+wQxnxUpOV4
	haiQHzHubt8+O0UMViesSQQwyvByaJABd16IGln12Ho30kvWb0UoRj/L2+dpfIvd
	o4DArUsUGtyIpJzvypJpXsFL7FEFs8invXzBmJuSrBIWbFP2HusA/HfFIElqi7Hg
	dIleafoPYZ9HWzVpmILN3ofowkMaEjvzigJnRfzgZfw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qcfeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:03:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47U5372f023314;
	Fri, 30 Aug 2024 05:03:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8qcfe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:03:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3C6KH028267;
	Fri, 30 Aug 2024 05:03:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 417ubnh923-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:03:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47U534OW55247326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 05:03:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C107C20040;
	Fri, 30 Aug 2024 05:03:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CE6A20043;
	Fri, 30 Aug 2024 05:03:03 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.118])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 30 Aug 2024 05:03:03 +0000 (GMT)
Date: Fri, 30 Aug 2024 10:33:01 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>,
        syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/2] ext4: Check stripe size compatibility on remount
 as well
Message-ID: <ZtFShfK/bj9WOShI@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
 <87v7zlq9e4.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7zlq9e4.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: emwPVDkxhJAGzIAgpMKEWDcMycrouSSc
X-Proofpoint-ORIG-GUID: VpobLNx7Lwod6J3-mObKMRoi7dItPjM3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300035

On Wed, Aug 28, 2024 at 03:03:39PM +0530, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > We disable stripe size in __ext4_fill_super if it is not a multiple of
> > the cluster ratio however this check is missed when trying to remount.
> > This can leave us with cases where stripe < cluster_ratio after
> > remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
> > unforeseen bugs like divide by 0.
> >
> > Fix that by adding the check in remount path as well.
> >
> > Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> > Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> > Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/super.c | 29 ++++++++++++++++++++++-------
> >  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> Minor nits below, but otherwise looks good to me.
> 
> Please feel free to add - 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks for the review Ritesh, I'll fix these in next revision

> 
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
> 
> s/simpfy/simplify
> 
> > + * stripe aligned allocation which will rarely successes.
> 
> s/successes/succeed
> 
> -ritesh

