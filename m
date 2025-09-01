Return-Path: <linux-ext4+bounces-9776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 932EFB3E1D7
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 13:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AA6D3A4F18
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Sep 2025 11:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6DE31DDA0;
	Mon,  1 Sep 2025 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U/z6vuSG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84112313E1D;
	Mon,  1 Sep 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756726820; cv=none; b=mtyIMQ5fjEcaKTjhnOTSEG75dEkEMNyGWkTnAOca/Uv0Q9JFizRwKkeP0VHg4ex3oyYw/mjsQYtN085BJT+D/jFuycEa1yCcr9hdJBbQPWEwDdVgKfvpVrVOU30AouFuliUOuHQG/F2WWAC1JfDeAdSQU9UFGwMlx1CTO0KMbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756726820; c=relaxed/simple;
	bh=6QQ7yvHUr29Mmw45xnYQHNiFS5i+CymQw2R3o36VIVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZJd6OHYPt6Xg7nKJ9LyYub7dEkM/eTagcopMcC9csgztZ5D2LsJq19HrClIBPI+BIebBN5K8CCFyyH/7Ghct8em9G/bOiMq7rg6qFUvsGORMtd3gzJ9xTlc+Uc/oRLe9hUi0QmbbABIU7fpw/FRhu+5xYhKua4mUiREjyuV7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U/z6vuSG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5819N0XL028857;
	Mon, 1 Sep 2025 11:40:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7SG8YQsJdVCHctuBxHbMpBDzL9Z54Y
	j0p7wbxhGOKnM=; b=U/z6vuSGOgHby4ZjLGDIbYXbpDS1s/CI6amVLWVwDoV6MQ
	qYFaPdUqFE+jq+etdUYkjgW7lV8Qa5Bvgytr1v9ik1f9MJVOVmTnzyk67T9fkAsY
	gND1Y8Pqm9lwWfFeFDzlIyqKO+g0Cstu6mBfIwiT2ozkUPNtOiZiOXdziclS+Fd4
	/kfTkwbkaBlaywXSgrgdFypKxwXU4Eq+GLbqGOY6BpikqMhCncZmzRfFv9lv0C9F
	q5AC4DV7EAkuRTF/BIZRaLNnWnIwGAfF3W42tN9ZpnFwjoL/0a/eOp9RbnAGjGhu
	ZK5/Dzr/J/PIIEpbSAGVycSk3IRv5xj4uazNf8lQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqrr21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 11:40:09 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 581BSsc6011397;
	Mon, 1 Sep 2025 11:40:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usuqrr1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 11:40:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 581AFdAf009015;
	Mon, 1 Sep 2025 11:40:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdum5gwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 11:40:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 581Be6YT60031432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 11:40:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3954E20043;
	Mon,  1 Sep 2025 11:40:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F2B20040;
	Mon,  1 Sep 2025 11:40:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.217.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  1 Sep 2025 11:40:03 +0000 (GMT)
Date: Mon, 1 Sep 2025 17:10:01 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Message-ID: <aLWGEVZTPT4e7FAh@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
 <20250825160801.ffktqauw2o6l5ql3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aK8hUqdee-JFcFHn@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250828150905.GB8092@frogsfrogsfrogs>
 <aLHcgyWtwqMTX-Mz@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250830170907.htlqcmafntjwkjf4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830170907.htlqcmafntjwkjf4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXxvgDPjUE8X2p
 P30MSbKl1tMyVaZXJlhdDmLClGV46dxLPPaMrmy5INEkBCqnC07K5B1ep1/5wRDv6xZCnIFPEEt
 urBpclxZevLxMFYH+QtGA3C1p7XE2ki6FtSvjA+TWZ6eu1x6SaTK5Ap/7UAi/h7pbahoSGv79DF
 zH4N2nzGy85uDFooUF6ZtCiY3fBrLwhdhzu1gmPdq9xgbDo+jxgpD+2twEP9oumPKSqAt6Yx9t9
 YGbZZHX6eVwRrUXSSRWijHICWaEtgnwv6fvPBkKIT2170EY1reYP/YXFpZ1nllLxx57fW1gwxd5
 GLPU6mSy/JdwRIBI+PKbFYI11XKuL9q3Mo8wpb5JtoPM2TT+qICQXVBerKEqW9QNG9clieAsaES
 UdroYlh+
X-Proofpoint-GUID: qHVhoSIPHlXlYHtqrZI_nWEOO7SLmxPW
X-Proofpoint-ORIG-GUID: MZR2MfkCTcQgrh9298faLRzAZgtkiwt4
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b58619 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=IA3YRga8fJDV80yC77oA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

On Sun, Aug 31, 2025 at 01:09:07AM +0800, Zorro Lang wrote:
> On Fri, Aug 29, 2025 at 10:29:47PM +0530, Ojaswin Mujoo wrote:
> > On Thu, Aug 28, 2025 at 08:09:05AM -0700, Darrick J. Wong wrote:
> > > On Wed, Aug 27, 2025 at 08:46:34PM +0530, Ojaswin Mujoo wrote:
> > > > On Tue, Aug 26, 2025 at 12:08:01AM +0800, Zorro Lang wrote:
> > > > > On Fri, Aug 22, 2025 at 01:32:01PM +0530, Ojaswin Mujoo wrote:
> > > > > > The main motivation of adding this function on top of _require_fio is
> > > > > > that there has been a case in fio where atomic= option was added but
> > > > > > later it was changed to noop since kernel didn't yet have support for
> > > > > > atomic writes. It was then again utilized to do atomic writes in a later
> > > > > > version, once kernel got the support. Due to this there is a point in
> > > > > > fio where _require_fio w/ atomic=1 will succeed even though it would
> > > > > > not be doing atomic writes.
> > > > > > 
> > > > > > Hence, add an explicit helper to ensure tests to require specific
> > > > > > versions of fio to work past such issues.
> > > > > 
> > > > > Actually I'm wondering if fstests really needs to care about this. This's
> > > > > just a temporary issue of fio, not kernel or any fs usespace program. Do
> > > > > we need to add a seperated helper only for a temporary fio issue? If fio
> > > > > doesn't break fstests running, let it run. Just the testers install proper
> > > > > fio (maybe latest) they need. What do you and others think?
> > > 
> > > Are there obvious failures if you try to run these new atomic write
> > > tests on a system with the weird versions of fio that have the no-op
> > > atomic= functionality?  I'm concerned that some QA person is going to do
> > > that unwittingly and report that everything is ok when in reality they
> > > didn't actually test anything.
> > 
> > I think John has a bit more background but afaict, RWF_ATOMIC support
> > was added (fio commit: d01612f3ae25) but then removed (commit:
> > a25ba6c64fe1) since the feature didn't make it to kernel in time.
> > However the option seemed to be kept in place. Later, commit 40f1fc11d
> > added the support back in a later version of fio. 
> > 
> > So yes, I think there are some version where fio will accept atomic=1
> > but not act upon it and the tests may start failing with no apparent
> > reason.
> 
> The concern from Darrick might be a problem. May I ask which fio commit
> brought in this issue, and which fio commit fixed it? If this issue be
> brought in and fixed within a fio release, it might be better. But if it
> crosses fio release, that might be bad, then we might be better to have
> this helper.

Hi Zorro, yes it does seem to cross version boundaries. The
functionality was removed in fio v3.33 and added back in v3.38.  I
confirmed this by running generic/1226 with both (for v3.33 run i
commented out a few fio options that were added later but kept
atomic=1):

Command: sudo perf record -e iomap:iomap_dio_rw_begin ./check generic/1226

perf script sample with fio v3.33:

fio    6626 [000]   777.668017: iomap:iomap_dio_rw_begin: <.sniip.> flags DIRECT|WRITE|AIO_RW dio_flags  aio 1

perf script sample with fio v3.39:

fio    9830 [000]   895.042747: iomap:iomap_dio_rw_begin: <.snip> flags ATOMIC|DIRECT|WRITE|AIO_RW dio_flags  aio 1

So as we can see, even though the test passes with atomic=1, fio is not
sending the RWF_ATOMIC flag in the older version.

In which case I believe it should be okay to keep the helper, right?

Thanks,
Ojaswin

> 
> Thanks,
> Zorro
> 
> > 
> > Regards,
> > ojaswin
> > > 
> > > --D
> > > 
> > > > > Thanks,
> > > > > Zorro

