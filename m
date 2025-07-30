Return-Path: <linux-ext4+bounces-9237-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6698EB1620D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 15:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5683B8B51
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CEF2D8DDB;
	Wed, 30 Jul 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Dzp2lXYJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5632D837C;
	Wed, 30 Jul 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883841; cv=none; b=W59cKU28UOJXnFOr2x62h+NRqCBoSSvV7Kimq+bKRKu2nBsuDr4RwLxN0wkMAvCphJd+AmaQh7gmEc4qb0dhBpnEz/+yXBZTNM0AVBlLe29LMWfogDeQ6GKhXGqz2nxigkh3Fl6zPrdsgt2qjw1KSvo1TDHiS2jN5+/LPa7RI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883841; c=relaxed/simple;
	bh=uTKm1J8rEtmvFtQCNldLlp3O0lL0uZAdKboSSqJcXcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlhMQ+O9a2e3omsvXgCrLFS7NCx+IpwO8IPx9O/yD6NK1HUXgRsZQo4WGtZBRXGw+EFSKEMJ5QAdMzna/GhDFWWvUCEJnf5KF4bQ8bTNTR7E2ox20X5EwS5w7Sg2FnIY7CQHk/4e4O2RgExJoAI0/BlUuc3FR9yqPYxesBSd6vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Dzp2lXYJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UDk3ZF026939;
	Wed, 30 Jul 2025 13:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hfsOsz3sRwsVDPs98ijvi9ZftQcXqN
	HcPJ4zWRyxHBo=; b=Dzp2lXYJLDqec3TOq12BnAvEUuJ2AFTQUvFTJvqO0+iYS6
	AvNqgGTYwEiEdHxvdF+p2/fLHVcrbYCF+Vcd28Z4it13hwL4XwI0YCSqaqAIVWXQ
	yz0TyOsOdR/FNiZhICrkgWdksoGhacliM2J2fHmKCZwUgRHp5Iy0VD63qLPVXjYD
	ErLczJA3JH4y8eVfHyTvrIe3H91pFUUjKeUBW9fms/XvKsrFd7WqPCsgH6FXo7mD
	2SVVGpgbqNuG7FYh+5ohYrhhdtt6xZRremBLNod0lNrRrUzASzJRxl66M7h6ixrS
	TH9Bq68AUEzOGeh3nW3b4taZMvnmpndvMHxLIyxQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu02mwp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 13:57:11 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 56UDvAsh024280;
	Wed, 30 Jul 2025 13:57:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 487bu02mw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 13:57:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56UBowxw028755;
	Wed, 30 Jul 2025 13:57:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 485c22qe35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 13:57:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56UDv8rc10158428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Jul 2025 13:57:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E06E20043;
	Wed, 30 Jul 2025 13:57:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00CE220040;
	Wed, 30 Jul 2025 13:57:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.212.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 30 Jul 2025 13:57:05 +0000 (GMT)
Date: Wed, 30 Jul 2025 19:26:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, john.g.garry@oracle.com,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3 10/13] ext4/061: Atomic writes stress test for
 bigalloc using fio crc verifier
Message-ID: <aIokiNnO3ibUf3G5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
 <9b59eb50b171dece1a15bc7c1b6cadff438586d6.1752329098.git.ojaswin@linux.ibm.com>
 <20250729194708.GV2672039@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729194708.GV2672039@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZNPXmW7b c=1 sm=1 tr=0 ts=688a24b7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=tNZppZpgaXu3iRLsUOsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Mvwg9T4RVpNXo1XJvWpcOGJQsXpme1_w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA5OSBTYWx0ZWRfXw+9uqAK8cG9D
 ndiQcRBUVqSND+zrAtHaPWqg6EhzmphigC+zJUP57SDu8bRFoan5KgxmUrl/J+UBCPz9yjpRoq0
 HwC3h1LlOdiDjCp7myggVc9MJqlqpBrJgilVg8ojZuPZZjNMjetoliNOOef9UFoj3/1YGK6BqGe
 WfUNfM0zx+DBGaKIcyrFErA7WXwV5mtOxL8saCbmOBYLFSpWXr4fv9v+yYX2aRQB9NrPmw6OdSe
 kzAyc5VVRuUaNOQ9fqKEx+fNe5+1MA4GU0nk4qVY+Bddb5FvXHkNUZZoQ2WRZGyqQBuUd+nP6wt
 kADejJE1276Yf1KBIXoOQzaFNJhsOJtUdfAMz++rr734iQkjUgdVr8QhMuKKnQEu/D+Lq/nZIG5
 D3FQAgjT9V9cB5eI2jUwqpfusfQcoPCywd7wBYqcrCpX2OrS/P1gNTRnJttKZzUO8jIEo8Zu
X-Proofpoint-GUID: s9Z2vjYPd4xMhPtsjjRT72yXmOX6nPH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 mlxlogscore=941 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300099

On Tue, Jul 29, 2025 at 12:47:08PM -0700, Darrick J. Wong wrote:
> On Sat, Jul 12, 2025 at 07:42:52PM +0530, Ojaswin Mujoo wrote:
> > From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> > 
> > We brute force all possible blocksize & clustersize combinations on
> > a bigalloc filesystem for stressing atomic write using fio data crc
> > verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
> > a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> > that we never see the mix of data contents from different threads on
> > a given bsrange.

Hi Darrick, thanks for the reviews.

> 
> Err, how does this differ from the next patch?  It looks like this one
> creates one IO thread, whereas the next one creates 8?  If so, what does
> this test add over ext4/062?

Yes these 2 tests are similar however this one uses fallocate=native +
_scratch_mkfs_ext4 to test whether atomic writes on preallocated file
via multiple threads works correctly.

The other one uses fallocate=truncate + _scratch_mkfs_sized 360MB +
'multiple jobs each writing to a different file' to ensure we are
extensively stressing the allocation logic in low space scenarios.

> 
> (and now that I look at it, ext4/062 says "FS QA Test 061"...)

Ahh I missed it somehow, thanks I'll fix it.

Regards,
ojaswin

> 
> --D
> 
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/ext4/061.out |   2 +
> >  2 files changed, 132 insertions(+)
> >  create mode 100755 tests/ext4/061
> >  create mode 100644 tests/ext4/061.out
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
> > -- 
> > 2.49.0
> > 
> > 

