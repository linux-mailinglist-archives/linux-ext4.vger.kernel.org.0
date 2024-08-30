Return-Path: <linux-ext4+bounces-3972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18799656A0
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92CD31F24640
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 05:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EBF14B097;
	Fri, 30 Aug 2024 05:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Yr0dSM04"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850E71BDDB;
	Fri, 30 Aug 2024 05:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994148; cv=none; b=JGwK8E5hZjG9wqh4aihyOKDghYFODdkCxkF8+SXxaNZ7rg6F8YY4k8nzWfDDK7JD5FCVa+zLWEBPHYJZqcAWEOQpgILIN6oRvUIfrDOJO3K5ZSNlQpSu+4L+rqjEMjwY4u2qs27cNgaA/NZv8Aioob/zY4J6k0qjMB0R5KlvZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994148; c=relaxed/simple;
	bh=REHpMRoorI3i1+ndplF6RVxB9m6VfOHXB09j+ECAEnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y5bXunPz2Z4f85h8DU5s0bWZ4jm5wgROpIYU2QPjsF2QNempNyHSfhsNkAKEf1HR6RWO3SsFaiFQMsYmXrYIpPtQiDgsPpVLVMyH8juFDXjOYSA/K4mmmth5+xbly7ZIfJznNcpkg5E6KlZIGUY1Qrz9ZB6afi3Jd5UvKYmi6RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Yr0dSM04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3ImIw030957;
	Fri, 30 Aug 2024 05:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=0rkE1zrz/FVtaD4A/mxjSUnxtMO
	Z9szEvqbY7Ut5qbw=; b=Yr0dSM04bfCv/cQ9lYLx0LBttIFJznSXISj8zmbdNwA
	FFEcVckCukeux48YA46ef4pAonfl8mMFME6UgjYsancMwFa11zoxXsgs919GspnX
	VNU1p5laHqeNsZHMlREpUAEvAzIAY27adQLgMuk9bRGuYg7ZgLDhwhzreFJMzYZC
	fHQ8X8OOkDnAvI99NSR4ItouMjFeKoQGnkqg2gF/k3EjXqp5QXU3aNRXK/FkKbIB
	RwOKmjoNnJ9utZ1bL8BhbzjV/X7uiajplB5udjQf8cR/RK/OqHhlwB7sxbTpNTJJ
	Esw1yRln9Y1HB3XGBwRlmI23mKcmt8jl/z29SLmpPbQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r4dan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:02:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47U52BI6005291;
	Fri, 30 Aug 2024 05:02:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r4dak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:02:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3tVEx024692;
	Fri, 30 Aug 2024 05:02:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3s1q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 05:02:10 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47U528Ka45744618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 05:02:08 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F5D2004B;
	Fri, 30 Aug 2024 05:02:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 940BA20040;
	Fri, 30 Aug 2024 05:02:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.195.46.118])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 30 Aug 2024 05:02:07 +0000 (GMT)
Date: Fri, 30 Aug 2024 10:32:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        linux-kernel@vger.kernel.org, Kemeng Shi <shikemeng@huaweicloud.com>
Subject: Re: [PATCH v2 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to
 EXT4_NUM_B2C
Message-ID: <ZtFSTBf3uCVMd1v/@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
 <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
 <87wmk1q9n6.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmk1q9n6.fsf@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fezNA9TIqcFHdGX4dFYPitjJD-o_4XDF
X-Proofpoint-ORIG-GUID: C8-IlNLzWIx-QkoY7_VDUPNAnb3CkcmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300031

On Wed, Aug 28, 2024 at 02:58:13PM +0530, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> 
> > Although we have checks to make sure s_stripe is a multiple of cluster
> > size, in case we accidentally end up with a scenario where this is not
> > the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
> > cases where EXT4_B2C(stripe) becomes 0.
> 
> man page of strip=n mount options says...
>        stripe=n
>               Number of file system blocks that mballoc will try to use
>               for allocation size and alignment. For RAID5/6 systems
>               this should be the number of data disks * RAID chunk size
>               in file system blocks.
> 
> ... So stripe is anyways the no. of filesystem blocks. Making it
> EXT4_NUM_B2C() make sense to me.
> 
> However, there is one more user that remains in ext4_mb_find_by_goal(),
> right?

Oh right, I'll fix that in v3. Thanks! 

> 
> -ritesh
> 
> >
> > Also make the is_stripe_aligned check in regular_allocator a bit more
> > robust while we are at it. This should ideally have no functional change
> > unless we have a bug somewhere causing (stripe % cluster_size != 0)
> >
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/mballoc.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)

