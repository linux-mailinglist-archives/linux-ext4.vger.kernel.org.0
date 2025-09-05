Return-Path: <linux-ext4+bounces-9834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7DB45FB7
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 19:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A503B8D32
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 17:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2FE30B523;
	Fri,  5 Sep 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pEVfPemG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B7A2F7AA4;
	Fri,  5 Sep 2025 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092247; cv=none; b=qV0GWzp+wTxgTntxyBTljxq9rPsSmZqjZYmYg9n1Ht8bYg84majMV/hTQie7YgcHu9fdyCSN0wiRnTH6WxvLXqDV7fLhsZnKn5aKBYlgtpOZuR9iKa9aNQhe6qESFYyyaqIcZPP1OZ/ibiCpUJYzGIJz1cMbP4uNCwh8f4o9V4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092247; c=relaxed/simple;
	bh=Vv8ki8sI8KtDdrSfEGAJEtcXf6zHXkwXdhPayYAPtXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz3/IXt9lWFoXut2PSXKjjRqso4v8tMDO30mXMmnNtTKhdKvPrXyp6uLKagVt+49tkmucbg/mD8Ti/aPaY5mXnsEwno2rh9/4YsX6qqKXkl4VvSTWRYc2lgWaGTUuHt84K14IXvwKGXRLnPsVP7gYjFzaXatFNYznMpzwNZSgOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pEVfPemG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Dpniq005146;
	Fri, 5 Sep 2025 17:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=R7h1xqlKGn5HU9xCSIKYQei+O9wytS
	gN3k1XoIrayhE=; b=pEVfPemGHw2zjwVmi377N+v0sw4twUMdqd3yVpgsNXsv6P
	zt1Tu3V5dmlG4Ig+GNaOzXLJc75iCwZkRIZAbU56xW9gSqBOJ6Av8XneRhmf2He+
	lWaYaf62jciwG14kwmWIaSBpV4FZuDouGFNXcT7C0s5Z+uDgNjB7a7ftojMdqRPr
	Kzodyizkyh+xCFdEZJ64dsHRfmZ8yK4Z9nKRvplQxBaL2bWbNmzRdQjWxXsv6FSx
	eDAMjWUNqJHbqltvTzDlGdNrFi/XZ9ASeaXaFj9Y5EBTJRz0j2vtg89VE1j7Tdi6
	yOnhk/xuBmtuVpv49FU/NJVOBauold2SSp9HMGYw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3j161-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:10:27 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 585HARPl001218;
	Fri, 5 Sep 2025 17:10:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3j15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:10:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 585DvDvG014145;
	Fri, 5 Sep 2025 17:10:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3t723-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 17:10:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 585HAO4Q51052878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 17:10:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F94620040;
	Fri,  5 Sep 2025 17:10:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7096220043;
	Fri,  5 Sep 2025 17:10:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.13])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  5 Sep 2025 17:10:22 +0000 (GMT)
Date: Fri, 5 Sep 2025 22:40:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v5 11/12] ext4: Test atomic writes allocation and write
 codepaths with bigalloc
Message-ID: <aLsZe0czym9X9Lo4@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
 <a223c31b43ce3a2c7a3534efbc0477651f1fc2bb.1755849134.git.ojaswin@linux.ibm.com>
 <001c5111-84c8-4bb0-951a-cc51587479be@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c5111-84c8-4bb0-951a-cc51587479be@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6g0HyMVHZ7sS99tObwvvkxUL7ZknZlfS
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68bb1984 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Bvp6HHX3gaFx4hf-IG0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ycTFs8xoXygiXj1gbPKt8XsWaW07WkXc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX0/7w4wP4U984
 jU9CbEMEypj9fzxVaiZI0OR7AxoD6o8sjHwqx1h20WgbR8lbpo+RhHWjZaZxAf5ohRY78NDchbG
 SBTESH8BNEAMwvnvbX4YvK3ey8nXWSPRB110JCOC5j5aAdmHKJS0+/6NzI+PdfZhLrxsh2j2l/m
 27Gyn1WZ3df2hHCuPcyJCzPF7ccl1N3GruQryT/XSMcOZZ+JB06ZAEhV8zXkQtiQJkeV1lxANMY
 4xC5fe9yEnRvaWJr5CT8jxe4WAXwKF33Ums/a5jDzrAQEyo7j1s6iST1GWwxLK90p55mC6FBjjl
 7jN5qSdrsKBogVmOgJQjaINHNbYK8s/UhZeb6tYiPO1BLenKpeEPfYigxT7QxajHYuUUFnjc5Wf
 kqAyBKFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, Sep 02, 2025 at 04:54:48PM +0100, John Garry wrote:
> On 22/08/2025 09:02, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > This test does a parallel RWF_ATOMIC IO on a multiple truncated files in
> > a small FS. The idea is to stress ext4 allocator to ensure we are able
> > to handle low space scenarios correctly with atomic writes. We brute
> > force this for different blocksize and clustersizes and after each
> > iteration we ensure the data was not torn or corrupted using fio crc
> > verification.
> > 
> > Note that in this test we use overlapping atomic writes of same io size.
> > Although serializing racing writes is not guaranteed for RWF_ATOMIC,
> > NVMe and SCSI provide this guarantee as an inseparable feature to
> > power-fail atomicity. Keeping the iosize as same also ensures that ext4
> > doesn't tear the write due to racing ioend unwritten conversion.
> > 
> > The value of this test is that we make sure the RWF_ATOMIC is handled
> > correctly by ext4 as well as test that the block layer doesn't split or
> > only generate multiple bios for an atomic write.
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   tests/ext4/062     | 203 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/ext4/062.out |   2 +
> >   2 files changed, 205 insertions(+)
> >   create mode 100755 tests/ext4/062
> >   create mode 100644 tests/ext4/062.out
> > 
> > diff --git a/tests/ext4/062 b/tests/ext4/062
> > new file mode 100755
> > index 00000000..d48f69d3
> > --- /dev/null
> > +++ b/tests/ext4/062
> > @@ -0,0 +1,203 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 062
> > +#
> > +# This test does a parallel RWF_ATOMIC IO on a multiple truncated files in a
> > +# small FS. The idea is to stress ext4 allocator to ensure we are able to
> > +# handle low space scenarios correctly with atomic writes.. We brute force this
> > +# for all possible blocksize and clustersizes and after each iteration we
> > +# ensure the data was not torn or corrupted using fio crc verification.
> > +#
> > +# Note that in this test we use overlapping atomic writes of same io size.
> > +# Although serializing racing writes is not guaranteed for RWF_ATOMIC, NVMe and
> > +# SCSI provide this guarantee as an inseparable feature to power-fail
> > +# atomicity. Keeping the iosize as same also ensures that ext4 doesn't tear the
> > +# write due to racing ioend unwritten conversion.
> > +#
> > +# The value of this test is that we make sure the RWF_ATOMIC is handled
> > +# correctly by ext4 as well as test that the block layer doesn't split or only
> > +# generate multiple bios for an atomic write.
> > +#
> > +
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto rw stress atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_aiodio
> > +_require_fio_version "3.38+"
> > +
> > +FSSIZE=$((360*1024*1024))
> > +FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
> > +
> > +# Calculate bs as per bdev atomic write units.
> > +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > +bs=$(_max 4096 "$bdev_awu_min")
> > +
> > +function create_fio_configs()
> > +{
> > +	local bsize=$1
> > +	create_fio_aw_config $bsize
> > +	create_fio_verify_config $bsize
> > +}
> > +
> > +function create_fio_verify_config()
> > +{
> > +	local bsize=$1
> > +cat >$fio_verify_config <<EOF
> > +	[global]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=read
> > +	bs=$bsize
> > +	fallocate=truncate
> > +	size=$((FSSIZE / 12))
> > +	iodepth=$FIO_LOAD
> > +	numjobs=$FIO_LOAD
> > +	group_reporting=1
> > +	atomic=1
> > +
> > +	verify_only=1
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_write_sequence=0
> > +
> > +	[verify-job1]
> > +	filename=$SCRATCH_MNT/testfile-job1
> > +
> > +	[verify-job2]
> > +	filename=$SCRATCH_MNT/testfile-job2
> > +
> > +	[verify-job3]
> > +	filename=$SCRATCH_MNT/testfile-job3
> > +
> > +	[verify-job4]
> > +	filename=$SCRATCH_MNT/testfile-job4
> > +
> > +	[verify-job5]
> > +	filename=$SCRATCH_MNT/testfile-job5
> > +
> > +	[verify-job6]
> > +	filename=$SCRATCH_MNT/testfile-job6
> > +
> > +	[verify-job7]
> > +	filename=$SCRATCH_MNT/testfile-job7
> > +
> > +	[verify-job8]
> > +	filename=$SCRATCH_MNT/testfile-job8
> 
> do you really need multiple jobs for verify?

Yes since we want each job to verify it's own file.
> 
> 

