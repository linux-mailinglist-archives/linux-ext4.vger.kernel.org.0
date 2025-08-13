Return-Path: <linux-ext4+bounces-9351-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D13B24230
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 09:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E957AD46A
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1732D46B3;
	Wed, 13 Aug 2025 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzrbQXYw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB11D5CD4;
	Wed, 13 Aug 2025 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755068902; cv=none; b=oZbCH3HM9k8CAN2rxlCRJQ0R0Qo9VJeDjMMfzs+e9kDsbm0rkGAm1WPTcfFex0y1bM/H3TNUbq6vr3wo4ENtZWy6Nismml3jvO5onMnfy6FIhsl0TgcvUhTm5sjSC/p2yav9/+3NIo75DVUNpfYFZyTflBntN0ZAenTlSGFfFPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755068902; c=relaxed/simple;
	bh=upX+jZ6RmPTTcxxHc6wA542NNEKB5fgoEbeojoHxwhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCh9GScyzmFFtcG3ZAb8ysxy1GqJ5fyvn9LpujGbiPVrmEP3bNKffWnzdCY4wUcO73fFvT4mKwHW4MQTtvI03lSnJj8sKc5lYHC6p/7pfii4ZU0JpofbchyXB6hYJ59Uke0PeRq6U9zvp79Ph/rTclGwoEddQdFBTA1jR4GIGJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzrbQXYw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQOKb025676;
	Wed, 13 Aug 2025 07:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6Ic2K93WGmWPe8MeUiDeO0y0bFKmr6
	B290RLLUMxbbA=; b=WzrbQXYwHmiobHBqv3UVPEEJp+riPv6WFTRTWKefkoaEwU
	aQKs7YfkVU+GG4j3w66U6qSgJ5zkXAbbK/EtVvTnue5IKAQ20lHjUewR9/lQZepL
	yjbCArZtV8H+WtTWzsInmIsyfyio+g1pe8YPS7s8lGrihZ8Qc4T0mpw9+zVo+P8L
	sZB0Sm2yXCCWOxsVWxbktFMuC7F8gBqW+t9DzcLapKLwFhO+DyUYy3UGDd6Nv3IK
	7zPcCJPRgoVbfq1iJ7vGTK+7WBT+xF3kTUZJZQXqcT2nimME5ZPp/2yWIm9Ih+/W
	FPMu8iFKfSdwKsesglFP1reXvF5cyeqNlc7sL1zg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa79h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:08:12 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D70Yqo008024;
	Wed, 13 Aug 2025 07:08:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaa79h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:08:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D63CwV010621;
	Wed, 13 Aug 2025 07:08:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnupcc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 07:08:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D789SI62849284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 07:08:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EE2D20043;
	Wed, 13 Aug 2025 07:08:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46E320040;
	Wed, 13 Aug 2025 07:08:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.214.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Aug 2025 07:08:06 +0000 (GMT)
Date: Wed, 13 Aug 2025 12:38:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 09/11] ext4: Atomic writes stress test for bigalloc
 using fio crc verifier
Message-ID: <aJw51DcgwQc3yfSj@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
 <210979d189d43165fa792101cf2f4eb8ef02bc98.1754833177.git.ojaswin@linux.ibm.com>
 <62ae0bd7-51f2-454d-a005-9a3673059d1b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ae0bd7-51f2-454d-a005-9a3673059d1b@oracle.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689c39dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=NKi2vMn_l3ipVb6-kZMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: gCIURS3MDvC9wK4fGbHziMrL89Yprv_a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfXxIttcUPbrpv3
 4hxRHX65MAtcMSyEwbsOv+ZLOCJ6CRkYCOTdFLKdhfr7PmKV9bsxVV7sNJIUkLal0p1ou2zhzqn
 vbDWp1ZkXeHVXFl1yroT/uBYSh1sJhLM07evB2shE8iFEh5jyi1WbCF7n0e554GrQJ9N4ArDwA7
 +vq3ek4HTJh7NvJCherqhTg3CRTmAToh29X3X927u06iw9O2HSyS7glfA0mYpga8YhpkIbB2WLn
 aCQJZF1yIjxgxxonee2GkypgFrJxwjnngvjdFMk2rS9Syo73W86SLdHYYCmnndIXOFdQ3AVXzwn
 4GGa3gKPGFYgMJPRt/GVoK9GAiA6RJzfMgwMtRS4NZyvWxCr3BC23W7j0OwVTcESOGGT0QwRchH
 SNwRTE5a
X-Proofpoint-GUID: 9Z0BYl-nbgKHP34OsiXi5Laera5pZXux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

On Tue, Aug 12, 2025 at 09:08:59AM +0100, John Garry wrote:
> On 10/08/2025 14:42, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > We brute force all possible blocksize & clustersize combinations on
> > a bigalloc filesystem for stressing atomic write using fio data crc
> > verifier.
> 
> you seem to run mkfs per block size. Why not just mkfs for largest blocksize
> once, which will support all block sizes?

We are just stressing all the possible combinations to shake out any
bugs. This is marked as stress so I feel the extra loops should be okay.

> 
> > We run nproc * $LOAD_FACTOR threads in parallel writing to
> > a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> > that we never see the mix of data contents from different threads on
> > a given bsrange.
> > 
> > This test might do overlapping atomic writes but that should be okay
> > since overlapping parallel hardware atomic writes don't cause tearing as
> > long as io size is the same for all writes.
> 
> Please mention that serializing racing writes is not guaranteed for
> RWF_ATOMIC, and that NVMe and SCSI provide this guarantee as an inseparable
> feature to power-fail atomicity.
> 
> Please also mention that the value is that we test that we split no bios or
> only generate a single bio per write syscall.

Got it, will do.
> 
> > 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >   tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/ext4/061.out |   2 +
> >   2 files changed, 132 insertions(+)
> >   create mode 100755 tests/ext4/061
> >   create mode 100644 tests/ext4/061.out
> > 
> > diff --git a/tests/ext4/061 b/tests/ext4/061
> > new file mode 100755
> > index 00000000..a0e49249
> > --- /dev/null
> > +++ b/tests/ext4/061
> > @@ -0,0 +1,130 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> > +#
> > +# FS QA Test 061
> > +#
> > +# Brute force all possible blocksize clustersize combination on a bigalloc
> > +# filesystem for stressing atomic write using fio data crc verifier. We run
> > +# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
> > +# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
> > +# we should never see the mix of data contents from different threads for any
> > +# given fio blocksize.
> > +#
> > +
> > +. ./common/preamble
> > +. ./common/atomicwrites
> > +
> > +_begin_fstest auto rw stress atomicwrites
> > +
> > +_require_scratch_write_atomic
> > +_require_aiodio
> 
> do you require fio with a certain version somewhere?

Oh right you mentioned that atomic=1 was broken on some older fios.
Would you happen to know which version fixed it?

> 
> > +
> > +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> > +SIZE=$((100*1024*1024))
> > +fiobsize=4096
> > +
> > +# Calculate fsblocksize as per bdev atomic write units.
> > +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> > +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> > +fsblocksize=$(_max 4096 "$bdev_awu_min")
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
> > +	[aio-dio-aw-verify]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> 
> it prob makes sense to just have read, but I guess with verify_only=1 that
> this makes no difference

Right, but I can change it in the next revision.

> 
> > +	bs=$fiobsize
> > +	fallocate=native
> > +	filename=$SCRATCH_MNT/test-file
> > +	size=$SIZE
> > +	iodepth=$FIO_LOAD
> > +	numjobs=$FIO_LOAD
> > +	atomic=1
> > +	group_reporting=1
> > +
> > +	verify_only=1
> > +	verify_state_save=0
> > +	verify=crc32c
> > +	verify_fatal=1
> > +	verify_write_sequence=0
> > +EOF
> > +}
> > +
> > +function create_fio_aw_config()
> > +{
> > +cat >$fio_aw_config <<EOF
> > +	[aio-dio-aw]
> > +	direct=1
> > +	ioengine=libaio
> > +	rw=randwrite
> > +	bs=$fiobsize
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
> > +
> > +EOF
> > +}
> > +
> > +# Let's create a sample fio config to check whether fio supports all options.
> > +fio_aw_config=$tmp.aw.fio
> > +fio_verify_config=$tmp.verify.fio
> > +fio_out=$tmp.fio.out
> > +
> > +create_fio_configs
> > +_require_fio $fio_aw_config
> > +
> > +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> > +	# cluster sizes above 16 x blocksize are experimental so avoid them
> > +	# Also, cap cluster size at 128kb to keep it reasonable for large
> > +	# blocks size
> > +	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
> > +
> > +	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
> > +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> > +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> 
> this is quite heavy indentation. Maybe the below steps can be put into a
> separate routine (to make the code more readable).

Got it.

> 
> 
> > +			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
> > +			if _try_scratch_mount >> $seqres.full 2>&1; then
> > +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> > +
> > +				touch $SCRATCH_MNT/f1
> > +				create_fio_configs
> > +
> > +				cat $fio_aw_config >> $seqres.full
> > +				echo >> $seqres.full
> > +				cat $fio_verify_config >> $seqres.full
> > +
> > +				$FIO_PROG $fio_aw_config >> $seqres.full
> > +				ret1=$?
> > +
> > +				$FIO_PROG $fio_verify_config >> $seqres.full
> > +				ret2=$?
> > +
> > +				_scratch_unmount
> > +
> > +				[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> > +			fi
> > +		done
> > +	done
> > +done
> > +
> > +# success, all done
> > +echo Silence is golden
> > +status=0
> > +exit
> > diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> > new file mode 100644
> > index 00000000..273be9e0
> > --- /dev/null
> > +++ b/tests/ext4/061.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 061
> > +Silence is golden
> 

