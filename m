Return-Path: <linux-ext4+bounces-9146-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D17B0D4EF
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 10:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82BFF1C22762
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Jul 2025 08:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257192D949E;
	Tue, 22 Jul 2025 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="db9MJRWp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B528A3E2;
	Tue, 22 Jul 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753174062; cv=none; b=pUEnLxpNZYZ+0qJ/COHACE5Wv80ZlBDWqTVtGaB+xzMFF9cuous/Nn7Y3BMa6CzpT8kpLajSlV6SLjExjQFhbRBJtiPML04EofD32hxDmRsO3Uj2uRbyt1i/VjKuTrWG7A/nJ/Z95nKtmwJZabBEMCt7UqRilwSczqaYSuBUon0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753174062; c=relaxed/simple;
	bh=o4ITgAzkFAbQTkygTxs+hGAZKG+lRrwfSadsb29Xvis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WerPedtOPq8hi7RaEd8GrfybJaCf5Er6TlCPrO6OQute555zkC4v0KxezF6V5EviLBl90xBjXrVllbFr+EDmyYMlR+cJqfKXu0a77vinyFW3ywAFCi1IJL3aSYFzO59BzLg2vnp75AeBboyTDVmD8BCeou+hgC+yU0QKMwNHT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=db9MJRWp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M2VYd1027323;
	Tue, 22 Jul 2025 08:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=+w2y0K65jhToR49D5iq9NrD5o0Ku8I
	TXpDRw/BW1X94=; b=db9MJRWpmUGEcTlBlVx/R8AP7UbMuTV+0aV56YFQfYAzU9
	dAtNSnC60+6tDDPReC80kGmtZVcJB42DgCWpNz9WxbRD99xupd0DUXW9R9n0p1dU
	kEyTBVHox1BMnFX0e0pw8kuaKa1JLsCkqYoAtAE6jzy3RBwfRhIb7naZRHuCzK2r
	iQd/N4pv3k/Fk8WQiPAdV95JA/moGfE6wPrc+ucVsIIYi6tAn46O/c05tzfXTQnS
	4XfdByvNyukr14+FzfoTq7UIkkx/DcIpXOBqLP+G1WcVLnJNLvID6sMz/C2+LzCQ
	JQcZJhhuw2bFTImwa7OMcdkF8cGO3IWbvCI9Vb4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqwacn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:47:33 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56M8lWee024513;
	Tue, 22 Jul 2025 08:47:32 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4805uqwacj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:47:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56M6AFgX004727;
	Tue, 22 Jul 2025 08:47:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fs7jj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Jul 2025 08:47:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56M8lUIE24380126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 08:47:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 084C62004B;
	Tue, 22 Jul 2025 08:47:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A366820040;
	Tue, 22 Jul 2025 08:47:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.18.185])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Jul 2025 08:47:27 +0000 (GMT)
Date: Tue, 22 Jul 2025 14:17:24 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aH9PwFm06n9KQ0mE@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
 <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b270bb66-721e-4433-adaf-fe5ae100ca6e@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SQFbqDHPjYj27IoY55UmaGyQPvNXYcnJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA3MSBTYWx0ZWRfXwzlFntubH1e2
 aCZdIxxLr0w4OnPgPqap2muy1NrQxTQNAUDArssN/8hh7hF8Y7xqqInmqJzD7nFIZgk8eqVZmHc
 NoeKSL0h6iwZeta8akkoDO6rFdOLhwpeZbmRTDiAWcBVlc2qDDiyfEsNiSY32S+FOHR5b1WVbVR
 fDfEz5kKfYJgS5LXdF2u3X+EuA+thwaKkhSvSMx8s22olVOb/w6TeUfQXPsbYCTLCO3TmnVJd3d
 wxIvcDYaJwzTMLHMz8MhPrGdAkpAva8dfnhB67bg2BLixUB9/C8THGj8/9e6ZtvU/KFeTZHUR7p
 bLur77/qyZ4e8BBE2J6geML1IIUZGvzyDTmJ92CUuDFXXPo6OHnRNUb+HUOln7wE9Gv8UT+0V6I
 scgahz9KMVXSbFER0td7dRVA8W+o+Wopoc9t/VUPUWQIEpL58N23jgQF5kL7Q8geCt7ozWE/
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=687f5025 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=9kuFc5caclUvU4WTlC0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: u0iMYmm1INaOaeqJ-op82qMK-WTPtMYa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_01,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=851 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220071

On Thu, Jul 17, 2025 at 03:06:01PM +0100, John Garry wrote:
> On 17/07/2025 14:52, Ojaswin Mujoo wrote:
> > On Thu, Jul 17, 2025 at 02:00:18PM +0100, John Garry wrote:
> > > On 12/07/2025 15:12, Ojaswin Mujoo wrote:
> > > > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > > > 
> > > > This adds atomic write test using fio based on it's crc check verifier.
> > > > fio adds a crc for each data block. If the underlying device supports atomic
> > > > write then it is guaranteed that we will never have a mix data from two
> > > > threads writing on the same physical block.
> > > 
> > > I think that you should mention that 2-phase approach.
> > 
> > Sure I can add a comment and update the commit message with this.
> > 
> > > 
> > > Is there something which ensures that we have fio which supports RWF_ATOMIC?
> > > fio for some time supported the "atomic" cmdline param, but did not do
> > > anything until recently
> > 
> > We do have _require_fio which ensures the options passed are supported
> > by the current fio. If you are saying some versions of fio have --atomic
> > valid but dont do an RWF_ATOMIC then I'm not really sure if that can be
> > caught though.
> 
> Can you check the fio version?

We don't have a helper but yes I think that should be possible
> 
> > 
> > > 
> > > > 
> > > > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > ---
> > > >    tests/generic/1226     | 101 +++++++++++++++++++++++++++++++++++++++++
> > > >    tests/generic/1226.out |   2 +
> > > 
> > > Was this tested with xfs?
> > 
> > Yes, I've tested with XFS with software fallback as well. Also, tested
> > xfs while keeping io size as 16kb so we stress the hw paths too.
> 
> so is that requirement implemented with the _require_scratch_write_atomic
> check?

No, its just something i hardcoded for that particular run. This patch
doesn't enforce hardware only atomic writes 

Regards,
ojaswin
> 
> > Both
> > seem to be passing as expected.
> > > 
> 
> 

