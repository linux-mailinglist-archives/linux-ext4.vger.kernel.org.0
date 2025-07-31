Return-Path: <linux-ext4+bounces-9242-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C254EB16B1F
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 06:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D345A807B
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Jul 2025 04:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A623C8CE;
	Thu, 31 Jul 2025 04:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYCpVP/r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC03595A;
	Thu, 31 Jul 2025 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935556; cv=none; b=i9fcnPJsvWpWCymQLt+7cMyclWNHIyU//OrVe/nyjT65uQo7CxBSCV+TA/TEe9HNI2LpvYRH4EH52AM9Qb814Ncsk8qLc7eU77GsRHZFZE7NxLSGtRWz7yCi1VUfk3dmKRluytv022tCuwN2mDe46qCXkkyHlYe/CE8/Az092Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935556; c=relaxed/simple;
	bh=ZobzzWDPHAD9iDOxIRA8aGYpMqwZmAtJ7mpGWwmVqUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyyBpene8CAzG5uNe1rlDgywqAzGWltD7yriIYUiQlmhXOv4VK5Z/kl4Cd059rqC5JTD1SIobYqm9YxfN/hCOwslAJB0f0Y3VvJsKNpF/bPK215cH0LJ/D9zEk3vWp11+aHnFZYu2UbfAzu5AsIDEf2iyZfm+ma+A0pZBEymPOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYCpVP/r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UKaon8002269;
	Thu, 31 Jul 2025 04:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=24saaRAd20Rcx3NGxaTql+x92yY5ct
	ngtm1W4oKLSFk=; b=UYCpVP/rPwRFYLUF22vCcyJeAZ2MzkkRMZjdbU8rBtHbJ3
	gp2mafmQvxKVvhhv6AeomLj3tVi8tmHUk50SQsp/zB/IV345DDiO6cUop+B27VF7
	LBbxoUoBcyfD479merkaldgPcK+ld+0J+lpt2kviOo8dXcjOmz68/amGqpjkTuPL
	vSsfU/BQLyhZTo7lZmTPLazWVX+Gd6cFci7SkutyfObDEjOrZZBqAhJ+6n+fFcGS
	BhM9kka4T+ynW++tStTRbTIL0C5X2Eic9kHBYDGF2TJebYpG0Odw2WulG8mUW+Yv
	4SEkig666L9+JGyqTf1nfxe9cNYNLu5R2hCXsW3w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hxgjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 04:19:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56V48Eh9007887;
	Thu, 31 Jul 2025 04:19:06 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 486c6hxgj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 04:19:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2TJx3017282;
	Thu, 31 Jul 2025 04:19:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4859r0autp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Jul 2025 04:19:05 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56V4J32820316596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 04:19:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E4A420043;
	Thu, 31 Jul 2025 04:19:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61AA120040;
	Thu, 31 Jul 2025 04:19:01 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 31 Jul 2025 04:19:01 +0000 (GMT)
Date: Thu, 31 Jul 2025 09:48:39 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, Zorro Lang <zlang@redhat.com>,
        fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aIrun9794W0eZA8d@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <aIDozETJ8aLparYV@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <9b9ed959-bda5-4a92-90c7-a621ffe58240@oracle.com>
 <aIMjrunlU04jI2lF@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <0af205d9-6093-4931-abe9-f236acae8d44@oracle.com>
 <aIccCgrCuQ4Wf1OH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <2ae4bb04-fbf7-4a53-b498-ea6361cdab3e@oracle.com>
 <aId8oZGXSg5DW48X@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <3a4854ac-75ad-4783-acbd-048fe7c7fdb0@oracle.com>
 <aIhmG-l4nWOAzz2I@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250729144526.GB2672049@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729144526.GB2672049@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4PWYWbVGZxeDrCpgxLYz3gJ80VRDsaat
X-Authority-Analysis: v=2.4 cv=Mbtsu4/f c=1 sm=1 tr=0 ts=688aeebb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=qJOP-70rnzrkdBoURO8A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: G6s53CesWX-etCc6c8gPHuLjdTYWa7Rk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAyNyBTYWx0ZWRfX0//iNkX16i25
 jT8xMwUzbl7tYYABaBpm2mQseSYmrkRRz2h65bs0GxvJRkW4v94Xi5Q/zJihuC2oZ29ru3pR1lx
 YYzAfAcQ0PP4sU149hctWPx8coik6JQ/dvBTxeoRFzY/fIK8t69rtM+npvrWQCOqp/o7U9MQ2av
 SCs1d4uuJJFmKfqQ/x7w9ePBohoBH7RPk+5fz4B4mA1bIqxb5ipTlwj+alaUo/QMsrsSv9nDpwt
 8CluOvumim6GueFJSUtLsya1+6pp+ycUN9IcYSKjgxTR+Eg6RF2lCyXupf2lNvw18BDC201OyNA
 ogbwDgmAogDwFKXIRpR2WgPF0/kld6CxNYAd7CWvZQsAJ/PaZMBVISmX5aYw2SHvg6mzm1d2Swl
 Nhg8gSQqfPW81CCF/jaJaeCFRluo2OZ7pfDWHctwY9hlpGeUy1YcytcszcxY2swj5t/wJoXs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507310027

On Tue, Jul 29, 2025 at 07:45:26AM -0700, Darrick J. Wong wrote:
> On Tue, Jul 29, 2025 at 11:41:39AM +0530, Ojaswin Mujoo wrote:
> > On Mon, Jul 28, 2025 at 03:00:40PM +0100, John Garry wrote:
> > > On 28/07/2025 14:35, Ojaswin Mujoo wrote:
> > > > > We guarantee that the write is committed all-or-nothing, but do rely on
> > > > > userspace not issuing racing atomic writes or racing regular writes.
> > > > > 
> > > > > I can easily change this, as I mentioned, but I am not convinced that it is
> > > > > a must.
> > > > Purely from a design point of view, I feel we are breaking atomicity and
> > > > hence we should serialize or just stop userspace from doing this (which
> > > > is a bit extreme).
> > > 
> > > If you check the man page description of RWF_ATOMIC, it does not mention
> > > serialization. The user should conclude that usual direct IO rules apply,
> > > i.e. userspace is responsible for serializing.
> > 
> > My mental model of serialization in context of atomic writes is that if
> > user does 64k atomic write A followed by a parallel overlapping 64kb
> > atomic write B then the user might see complete A or complete B (we
> > don't guarantee) but not a mix of A and B.
> 
> Heh, here comes that feature naming confusing again.  This is my
> definition:
> 
> RWF_ATOMIC means the system won't introduce new tearing when persisting
> file writes.  The application is allowed to introduce tearing by writing
> to overlapping ranges at the same time.  The system does not isolate
> overlapping reads from writes.
> 
> --D

Hey Darrick, John,

So seems like my expectations of RWF_ATOMIC were a bit misplaced. I
understand now that we don't really guarantee much when there are
overlapping parallel writes going on. Even 2 overlapping RWF_ATOMIC
writes can get torn. Seems like there are some edge cases where this
might happen with hardware atomic writes as well.

In that sense, if this fio test is doing overlapped atomic io and
expecting them to be untorn, I don't think that's the correct way to
test it since that is beyond what RWF_ATOMIC guarantees. 

I'll try to check if we can modify the tests to write on non-overlapping
ranges in a file.

Thanks and sorry for the confusion :)
Ojaswin

> 
> > > 
> > > > 
> > > > I know userspace should ideally not do overwriting atomic writes but if
> > > > it is something we are allowing (which we do) then it is
> > > > kernel's responsibility to ensure atomicity. Sure we can penalize them
> > > > by serializing the writes but not by tearing it.
> > > > 
> > > > With that reasoning, I don't think the test should accomodate for this
> > > > particular scenario.
> > > 
> > > I can send a patch to the community for xfs (to provide serialization), like
> > > I showed earlier, to get opinion.
> > 
> > Thanks, that would be great.
> > 
> > Regards,
> > John
> > > 
> > > Thanks,
> > > John
> > > 
> > 

