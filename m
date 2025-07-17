Return-Path: <linux-ext4+bounces-9041-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7856EB08E8F
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A22624E5E5B
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8402F6FBC;
	Thu, 17 Jul 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mIaXM0/U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD662F6F89;
	Thu, 17 Jul 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760373; cv=none; b=fJcrXNClCoz6NJ8k9ENDvkdZKL8zkkbgogGn/U2WJ8+pgvM31NWQom6uecyqUsTXP98YfbKoB65EgKaZpSNEGgNCx/+uX5JbB1WY6lJFoONY6ubBkyj34oaHnNlrmMPkk9H34eCLGQffKmF+8OA6ThMzLlE69mRFSkpS9AkY29A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760373; c=relaxed/simple;
	bh=2eZn8xHfXPwPI2+A7Sd6OfC2bQ0TMDbwQVlbLxdD+KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQoJplXj335ZYGfi8s6bQZ4CwAcKOurt09RebPTJdGIO4mLx+/SH/SSFDQEy2330tVzm9MlUSb58Ws4fN3HEnZEyWPKiE5DrxaBDPeND8xAu6id3tcKygcIgVH+Ax4vEd7M1qJ0u+93TgVloISAScqhWKRICPJJURiMF14CXD7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mIaXM0/U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56H7edjO019577;
	Thu, 17 Jul 2025 13:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DxS9QfMBl1Opj2uN+GRtroKPSwbb/y
	PAcQveAUe1GHQ=; b=mIaXM0/UEVhXIZoIrSts/Cy04ZrXIvBautxQNoDuSODl3d
	gpbNmknrl7OO65EW7IFDe6PiGkKccmLSJzSpRGatTBjUJu7gLk/J2xeSyV3rnkux
	eK1fruUApb+lsqf4fCUOwUWNNAknofLAE0+ZpCuOpEhM+Q+xSsijZbbxHFbzU369
	nMXe0qwN+TRvatue/U6Y0Q/4MrR9GmU+0m/m4qY0ZIdfzr3ZmmKm0C2NlMJ3RyIq
	g1yfef5afhT3gu135qUn/TY5a9OmK9PkQr8l5CdoYQn+txb8QXJTvxRTnmBVrJT/
	X+WZZ5K+K3KOQAtU3z8YFBaF09SjLLzprCbEv5Nw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh904gas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 13:52:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56HDA0K9014356;
	Thu, 17 Jul 2025 13:52:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47xh904gap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 13:52:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56HAU0cR021890;
	Thu, 17 Jul 2025 13:52:43 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v4r3c4gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Jul 2025 13:52:42 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56HDqfkY43778444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 13:52:41 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 420F820043;
	Thu, 17 Jul 2025 13:52:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CBEE20040;
	Thu, 17 Jul 2025 13:52:39 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.40])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Jul 2025 13:52:38 +0000 (GMT)
Date: Thu, 17 Jul 2025 19:22:36 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 05/13] generic/1226: Add atomic write test using fio
 crc check verifier
Message-ID: <aHkAJJkvaWYJu7gC@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
 <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5211dff7-579b-48ea-8180-72d8c6083400@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yovsRqNDpwkcMNak87dR7wSKGXSSdNU_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEyMSBTYWx0ZWRfX8/Xqgcje5yd3 TO2EtaANWuDi0mtoTcfqOEmhdi8bafvneKusBtowoek0dBp9mbzzWdY2NmkJ3Abh5V3k58XZLI3 FpKJ/V8O+f8yVTgkgqt4wk28sfSRKED7p+vftgXKtHuMClWUrNAr7VgZV4gGIEGBNMTubJDa6X7
 pnCpKO5XWR06cUK6OXi3bWGdaEy/QUHh9nt0y4Evu2lqTlT4+Rps5/XcaoO8hGhYzVoGpHW5YnE xmnorlMQ4f3mzaHHFatLhz3WGtHa01ZNlNvESO+k/2vAe5jxKWShn9JNwkFZyU5cFDkT6X5nyni LvZ56UuT8VoIKNA7ocOAUQeFxsSqyIv9OR7qEZQHKmGXdM/ts5REdRf+nxciZsA5clPqp2dRERT
 OD8arZ5jzM7A9tSi4E1aIna0l9UW/m28gCTBQGN2iWbvG4nFMZecS2IiwY3d2mvEOM3W9CYM
X-Proofpoint-GUID: aiXms0qTG6fyyJ9VXCi0kLBcoEqVkfo0
X-Authority-Analysis: v=2.4 cv=C43pyRP+ c=1 sm=1 tr=0 ts=6879002c cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=J-4IIHuIGGDucG2yejQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170121

On Thu, Jul 17, 2025 at 02:00:18PM +0100, John Garry wrote:
> On 12/07/2025 15:12, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc for each data block. If the underlying device supports atomic
> > write then it is guaranteed that we will never have a mix data from two
> > threads writing on the same physical block.
> 
> I think that you should mention that 2-phase approach.

Sure I can add a comment and update the commit message with this.

> 
> Is there something which ensures that we have fio which supports RWF_ATOMIC?
> fio for some time supported the "atomic" cmdline param, but did not do
> anything until recently

We do have _require_fio which ensures the options passed are supported
by the current fio. If you are saying some versions of fio have --atomic
valid but dont do an RWF_ATOMIC then I'm not really sure if that can be
caught though.

> 
> > 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   tests/generic/1226     | 101 +++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/1226.out |   2 +
> 
> Was this tested with xfs?

Yes, I've tested with XFS with software fallback as well. Also, tested
xfs while keeping io size as 16kb so we stress the hw paths too. Both
seem to be passing as expected.
> 
> >   2 files changed, 103 insertions(+)
> >   create mode 100755 tests/generic/1226
> >   create mode 100644 tests/generic/1226.out
> > 
> > diff --git a/tests/generic/1226 b/tests/generic/1226
> > new file mode 100755
> > index 00000000..455fc55f
> > --- /dev/null
> > +++ b/tests/generic/1226
> > @@ -0,0 +1,101 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 1226
> > +#
> > +# Validate FS atomic write using fio crc check verifier.
> > +#
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto aio rw atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_odirect
> > +_require_aio
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +
> > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> > +SIZE=$((100 * 1024 * 1024))
> > +
> > +function create_fio_configs()
> > +{
> > +	create_fio_aw_config
> 
> it's strange ordering in this file, since create_fio_aw_config is declared
> below here
> 
> > +	create_fio_verify_config
> 
> same

That works in bash.
> 
> > +}
> > +
> > +function create_fio_verify_config()
> > +{
> > +cat >$fio_verify_config <<EOF
> > +	[verify-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> 
> is this really required? Maybe it is. I would use read if something was
> required for this param

Usually the fio verfiy phase internally converts writes to reads so
rw=write and rw=read doesnt matter much. I can make the change tho,
should be fine.

Thanks,
ojaswin

> 
> > +	bs=$blocksize
> > +	fallocate=native
> > +	filename=$SCRATCH_MNT/test-file
> > +	size=$SIZE
> > +	iodepth=$FIO_LOAD
> > +	group_reporting=1
> > +
> > +	verify_only=1
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_state_save=0
> > +	verify_write_sequence=0
> > +EOF
> > +}
> > +
> > +function create_fio_aw_config()
> > +{
> > +cat >$fio_aw_config <<EOF
> > +	[atomicwrite-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> > +	bs=$blocksize
> > +	fallocate=native
> > +	filename=$SCRATCH_MNT/test-file
> > +	size=$SIZE
> > +	iodepth=$FIO_LOAD
> > +	numjobs=$FIO_LOAD
> > +	group_reporting=1
> > +	atomic=1
> > +
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	do_verify=0
> > +EOF
> > +}
> > +
> > +fio_aw_config=$tmp.aw.fio
> > +fio_verify_config=$tmp.verify.fio
> > +
> > +create_fio_configs
> > +_require_fio $fio_aw_config
> > +
> > +cat $fio_aw_config >> $seqres.full
> > +cat $fio_verify_config >> $seqres.full
> > +
> > +$FIO_PROG $fio_aw_config >> $seqres.full
> > +ret1=$?
> > +$FIO_PROG $fio_verify_config >> $seqres.full
> > +ret2=$?
> > +
> > +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> > new file mode 100644
> > index 00000000..6dce0ea5
> > --- /dev/null
> > +++ b/tests/generic/1226.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 1226
> > +Silence is golden
> 

