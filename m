Return-Path: <linux-ext4+bounces-9490-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F063B2F2A2
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 10:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12977188BCE0
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181B2EB5B8;
	Thu, 21 Aug 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qg9/7gZg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCE62EB5A6;
	Thu, 21 Aug 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765744; cv=none; b=sfPidjCxmgfBxxQJc//RVdJcKYIVK1bNb1UQpWWuSqOEin6yPHzrirdkTxxXO0yWHx66W3+PwwqcBc9yG8vXyuQ3ndyMTjlaxPnKrB9NV21UoDLgKdESkJ/aL8GJjDMAM6E4qKBDTjhFNAvGaBMZL9EclkfFliSDed7pmBblHO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765744; c=relaxed/simple;
	bh=U7o8rwfHF81UoPKsuLzzM0LgeQ+gMhkKcYm92kLcf6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD+mQMJkTfACDSPp8gLky5bTR6WvnZaotoELelbF8BjuGC8oEQRDHuLFjtl98ba9rxm1g7UGsmrQm6gq2p+OkN9WkTY9vF42PV4C1Wwowgo2whUviPIlouh+uNSXkPcdiKd8Sr6NFNIGDf+nBmr7/MekVra7D2nCh+AOLeek1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qg9/7gZg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KLgXw1008282;
	Thu, 21 Aug 2025 08:42:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DoH6jjMOVVQqjC8hJd1SZQxhWKPQqR
	XJy/DUtMTNNHU=; b=Qg9/7gZgKbPmpjC4j1OrNKrqkx33/7qNMIYhUYSH0m7dpZ
	FsNH20JtK5fvFk+C/kFL6gnNtxULaF5dKLhgdzXQaeochKGrqR+91i6zErpG7PMi
	Q5enUUE7qSlCEI+9hzAKf+Y3BU7Q/N7RVbWQozQ5rkAFxLvZ0zUPffEYByDgEdzD
	2G3VZrdgFHHB90un+UgEi3vtbsaA9TTJA5KyO5Mc878htdEhY0KoUibo5GGcqhWl
	rGA0PtBgX2akBLvsjMnT6XbTtQ3W6vcl9B2GS/8Q/7C877GqXBC47Odi23lYMyBq
	YIzUoekq4nXTm/v1KkC/9lz20enuOVz/6M/o/ILg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vygsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:42:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57L8bfRq026627;
	Thu, 21 Aug 2025 08:42:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vygs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:42:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L6lutU008742;
	Thu, 21 Aug 2025 08:42:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my427f11-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 08:42:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L8g5QD54985010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 08:42:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B8120040;
	Thu, 21 Aug 2025 08:42:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C97522004B;
	Thu, 21 Aug 2025 08:42:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 21 Aug 2025 08:42:03 +0000 (GMT)
Date: Thu, 21 Aug 2025 14:12:01 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 04/11] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <aKbb2XhcsMMhBlgb@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
 <f9ae3870-f6c5-4ab0-924e-261f4ec3b5cc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ae3870-f6c5-4ab0-924e-261f4ec3b5cc@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qImmq9QxMRzvUnKkpVYxbq5R5CaNQg06
X-Proofpoint-GUID: w-yAqVCg8Bi8Rjz58-GbpZglv8YwQ9lm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXzVCsz1aGOlsv
 w/J+WZ+gsoHrq4L/5muSp48Mb3RZ8CtnLXsTLACZ0wtYCbCgMQZOr3EYFH5ttyBaApuD9Aff0ZA
 BsTSCg3J1paDseayzyWABldGxPSneTwksUrDbLDNEGq1giU15F9PXspwqhQoS6GeUjDYtuUaKkZ
 utjgRTN5ZULrMyB0x+DRBZkb7h/s85Xsm5OGfPN2JRbKgqxA0yvuRKxLnm5zWG0mfDAytPgBjuo
 PpOZ1dOSQRgZV55+Lj0WFJezYpgxFeEwKIPZVVrTHVuyElfMvu3RepI6ZsgrYlVEBPgCwXC/hFf
 HhBIKiaXQ5YMgv6lREweEjc+XP7qm1jQqrAT5i4HAKOX4DJzCOxork5g8p4h1FCaPmq1ZkOWpxi
 T+G38ChOgzjhh4Y14rVlrZV7vsZTKQ==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a6dbe1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=KAgCPwNrzRmOdRwMPFMA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

On Wed, Aug 13, 2025 at 02:39:40PM +0100, John Garry wrote:
> On 10/08/2025 14:41, Ojaswin Mujoo wrote:
> > This adds atomic write test using fio based on it's crc check verifier.
> > fio adds a crc for each data block. If the underlying device supports
> > atomic write then it is guaranteed that we will never have a mix data from
> > two threads writing on the same physical block.
> > 
> > Avoid doing overlapping parallel atomic writes because it might give
> > unexpected results. Use offset_increment=, size= fio options to achieve
> > this behavior.
> > 
> 
> You are not really describing what the test does.
> 
> In the first paragraph, you state what fio verify function does and then
> describe what RWF_ATOMIC means when we only use HW support, i.e. serialises.
> In the second you mention that we guarantee no inter-thread overlapping
> writes.

Got it John, I will add better commit messages for the fio tests.
> 
> From a glance at the code below, in this test each thread writes to a
> separate part of the file and then verifies no crc corruption. But even with
> atomic=0, I would expect no corruption here.

Right, this is mostly a stress test that is ensuring that all the new
atomic write code paths are not causing anything to break or
introducing any regressions. This should pass with both atomic or non
atomic writes but by using RWF_ATOMIC we excercise the atomic specific
code paths, improving the code coverage.

Regards,
ojaswin
> 
> Thanks,
> John
> 
> > Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   tests/generic/1226     | 107 +++++++++++++++++++++++++++++++++++++++++
> >   tests/generic/1226.out |   2 +
> >   2 files changed, 109 insertions(+)
> >   create mode 100755 tests/generic/1226
> >   create mode 100644 tests/generic/1226.out
> > 
> > diff --git a/tests/generic/1226 b/tests/generic/1226
> > new file mode 100755
> > index 00000000..efc360e1
> > --- /dev/null
> > +++ b/tests/generic/1226
> > @@ -0,0 +1,107 @@
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
> > +_require_xfs_io_command "falloc"
> > +
> > +touch "$SCRATCH_MNT/f1"
> > +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> > +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> > +
> > +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> > +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> > +filesize=$((blocksize * threads * 100))
> > +depth=$threads
> > +io_size=$((filesize / threads))
> > +io_inc=$io_size
> > +testfile=$SCRATCH_MNT/test-file
> > +
> > +fio_config=$tmp.fio
> > +fio_out=$tmp.fio.out
> > +
> > +fio_aw_config=$tmp.aw.fio
> > +fio_verify_config=$tmp.verify.fio
> > +
> > +function create_fio_configs()
> > +{
> > +	create_fio_aw_config
> > +	create_fio_verify_config
> > +}
> > +
> > +function create_fio_verify_config()
> > +{
> > +cat >$fio_verify_config <<EOF
> > +	[verify-job]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=read
> > +	bs=$blocksize
> > +	filename=$testfile
> > +	size=$filesize
> > +	iodepth=$depth
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
> > +	filename=$testfile
> > +	size=$io_inc
> > +	offset_increment=$io_inc
> > +	iodepth=$depth
> > +	numjobs=$threads
> > +	group_reporting=1
> > +	atomic=1
> > +
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	do_verify=0
> > +EOF
> > +}
> > +
> > +create_fio_configs
> > +_require_fio $fio_aw_config
> > +
> > +cat $fio_aw_config >> $seqres.full
> > +cat $fio_verify_config >> $seqres.full
> > +
> > +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
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

