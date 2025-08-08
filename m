Return-Path: <linux-ext4+bounces-9282-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656A9B1E1E4
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 08:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B011890F5E
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Aug 2025 06:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBCA21FF53;
	Fri,  8 Aug 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sBu3xAsZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B9021FF39;
	Fri,  8 Aug 2025 06:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754632865; cv=none; b=Gq06FGn6jkYyXwof89OzQ2puIq2JwjlFbacT97iHoVk5NpELpyEtGNpG6HCX5i+LFQR+X7yBISKMsvm6aHLIuDPov4y5U4LUqExvmScbU0KlK4LUuLjSGCLU0sJwJXqNussYUIoiuzH5ZX/R36vL557czRbIBQZieqUqjVZRRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754632865; c=relaxed/simple;
	bh=MjI/zU8qCooN8dLbMdIOUGEjfZaj8l6X7GnTu/rSb7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ywz/GORT7VZ6lsHfqqmjGweLcx76mtBXAGocYEJqEiySxWzPhCe7GlXZkBQJ9OXORi7DuSqoDIFSA7AroZ10tlii962Z26JmtS6KXzb0bT4bssYIA1ss+cVsd55ON4wgPqdHKf+b6gQwmmjvOBG0Oll/bPBg+DwsrZGlnSIdLwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sBu3xAsZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57812HTf021221;
	Fri, 8 Aug 2025 06:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TqVIlPEXdBGYYQWx6dmdE3sRD5TRo5
	cHpU0SRXejBZA=; b=sBu3xAsZI374rXJLKfb4vbLkuNRecfU4GcKiDV8QoWBel8
	ydy0hzp4qfd2rDnfmfYjggaqBjIM62KK5EyX+j5UalE2CkDnkb1d3uiDWBAvuXs3
	ZRtZT5FduQ7zjr1uGPcg9N+seBKed7ZwA/5Eyj/WbslQJGgLTmE/pYPGhnuHyy55
	WMtN4yuVvNBnCUEPsqomX6vqID/LEuDrinTsgeMGa7GAogM9VZhpWea1WTbQtqqP
	YbJKVXDfIxEsdDO9NYnOBTLp67Gzojwm8by2Ud1YItqJb+nvymB4Lh/1Uh3fg6aw
	z3Su7r1hyb+k1FhUpfZ2DaBnGHA7E7srvaQhnE2g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63eavw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 06:00:34 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5785wsTU005698;
	Fri, 8 Aug 2025 06:00:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63eavr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 06:00:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5781LJnl001586;
	Fri, 8 Aug 2025 06:00:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwr4agf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 06:00:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57860Vfc45548022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Aug 2025 06:00:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BA4D20043;
	Fri,  8 Aug 2025 06:00:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A68EA2004F;
	Fri,  8 Aug 2025 06:00:29 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.239])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Aug 2025 06:00:29 +0000 (GMT)
Date: Fri, 8 Aug 2025 11:30:27 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aJWRoCMhKj91T1z8@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
 <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <22ccfefc-1be8-4942-ac27-c01706ef843e@oracle.com>
 <aIxhsV8heTrSH537@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <76974111-88f6-4de8-96bc-9806c6317d19@oracle.com>
 <aI205U8Afi7tALyr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <83e05a05-e517-4d41-96ff-da4d49482471@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83e05a05-e517-4d41-96ff-da4d49482471@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=68959282 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=6yZzKTUn8j-8rjHs7NAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: foxn4ZVbnOOoYxzRqC7YB18yaBdp0tDq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA0NyBTYWx0ZWRfX9j8mCvcfTgLh
 4R3reE0El8Kl+pm+mN1datibZYmgg/CQVkC+bi9yi3HgnMK7TsXlJwC0gvv1peuaCI4nSUCS4yJ
 t6zUCqNmion/7XfZ9fc+Rf8M8u6WuP/MsY4E/td4rUmM2LfsqLDHky9uox5Rpm41Kdc6GTosS7q
 4qjqukTzRSN0RtX/AViPXmDsGBxhGsXd+2ufqkRyWWRaoCmKuey94k9LuRmg2VAch4fTvzohRMi
 wUNkzJ5VV6hIwvBVIHri+2S1cIgbMtR51NU67xVh3cE6FAc7eSpYJv1Kq8rX37LBar5JN65RdtI
 ExM0znN7qC0xkxZ5aYaqUuDoMAE2J9fjH+qWAYG2OpzLWJo8XxsNbrPQAkTfgIFkf0pNrUUZo3A
 JJXp/qDXdJoYhkRKG829Kivmd7mdSZ71JTf+t+YcfnqV+N7QIub3j76zqjKcGs9cEIWFBGto
X-Proofpoint-ORIG-GUID: jTyKt8jTh_GQvseQDQMGqDEJC0yPUJtQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508080047

On Mon, Aug 04, 2025 at 08:12:00AM +0100, John Garry wrote:
> On 02/08/2025 07:49, Ojaswin Mujoo wrote:
> > On Fri, Aug 01, 2025 at 09:23:46AM +0100, John Garry wrote:
> > > On 01/08/2025 07:41, Ojaswin Mujoo wrote:
> > > > Got it, I think I can make this test work for ext4 only but then it might
> > > > be more appropriate to run the fio tests directly on atomic blkdev and
> > > > skip the FS, since we anyways want to focus on the storage stack.
> > > > 
> > > testing on ext4 will prove also that the FS and iomap behave correctly in
> > > that they generate a single bio per atomic write (as well as testing the
> > > block stack and below).
> > Okay, I think we are already testing those in the ext4/061 ext4/062
> > tests of this patchset. Just thought blkdev test might be useful to keep
> > in generic. Do you see a value in that or shall I just drop the generic
> > overlapping write tests?
> 
> If you want to just test fio on the blkdev, then I think that is fine.
> Indeed, maybe such tests are useful in blktests also.

Okay, I think it is better suited for blktests, so I'll add it there.

> 
> > 
> > Also, just for the records, ext4 passes the fio tests ONLY because we use
> > the same io size for all threads. If we happen to start overlapping
> > RWF_ATOMIC writes with different sizes that can get torn due to racing
> > unwritten conversion.
> 
> I'd keep the same io size for all threads in the tests.

Yep

Thanks,
Ojaswin
> 
> Thanks,
> John

