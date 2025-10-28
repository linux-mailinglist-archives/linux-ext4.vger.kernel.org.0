Return-Path: <linux-ext4+bounces-11109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219C4C13E33
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 10:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54499188EE28
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 09:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91ED2EAB83;
	Tue, 28 Oct 2025 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxc9L8bf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFF91DE8B5;
	Tue, 28 Oct 2025 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644583; cv=none; b=N6eyPvs1TCcKnKRaFuDWf35NvACPQws1BFSDj8vb3IaUF2tBe2R1heHAuoq2+nxRppyGilk42oWSmBrOE+Apv9VHMyK10JtQQFtpkik8JrSBM2nSsw01aIS9qDGWAbrjr7p4AwTdaZj7gfmlmQWyipUZaXfjtCPUZTR3JXpeErI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644583; c=relaxed/simple;
	bh=yYCbpw7rw0zXfdbPsXkdq9oUAHa+PqvUURtYtXcjCEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo7sMUm5AaVeka5eJN+VZnCDhBfH9tTsbM/f4t+kA2DRuDU4gHaE/u9RChcgsQWqGFDWjt9tCRdXao0v+mdPvGCRW25CquL/kWLuwwmH39EfLV/io5ff9Hwd5cXtj94eLgXiJbbS8VwLHmV4tEbl6s2PvDEWUeUMflSkNikcFcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxc9L8bf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RKYWVL027578;
	Tue, 28 Oct 2025 09:42:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9tUBTYDcqQzpWW/bGrGEUKCuJSzJSn
	CEUDb+PoGr0HI=; b=hxc9L8bfqXVowklXYI9K2d1j47tpFmhKlo7hQNOwd0S3Fe
	/T5Jv3w5y4IjeHOiNRTNMw3eDEORvj4y1RMvKDNk8DZD/g0qHNGy6RDJCuPEGYUe
	56usgmW8EMuIB71Ce5mdMwD4kzJkmihbO2gB4ZCnqfs+pACnIdCeCurFQI31BhAw
	cVaxiSYgoQTtp+50KEdVfpGCIxCkKx63y1+eSMw6jtY3ncRKvpq54nMtUPvOe9Nj
	k99sSDYDA/tUpMQxkgIkgbXbtmO4e6cVeEx3j+3oYqduOImi8oBu6VhkLZ8uMvgw
	JZMVJ9GO0AJnTFB6K0DDw1mwM9ffUgQYW6EDAkJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p2935qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:42:53 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59S9gq0i018888;
	Tue, 28 Oct 2025 09:42:52 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p2935qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:42:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59S7bAEv022886;
	Tue, 28 Oct 2025 09:42:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xj313-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Oct 2025 09:42:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59S9gnh554722852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 09:42:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4739520043;
	Tue, 28 Oct 2025 09:42:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5283D20040;
	Tue, 28 Oct 2025 09:42:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Oct 2025 09:42:47 +0000 (GMT)
Date: Tue, 28 Oct 2025 15:12:44 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 05/12] generic: Add atomic write test using fio crc
 check verifier
Message-ID: <aQCQFOtjhyzohgnA@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <3c034b2fb5b81b3a043f1851f3905ce6a41c827a.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c034b2fb5b81b3a043f1851f3905ce6a41c827a.1758264169.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX1NlRESG26HxE
 E9/QZyQllKhw6rZzxTVQp3NguqFwhp1lvOY8wQBeaueLxWgvdmHzLG0RS+BqSwT0Gt2G+w4UtJp
 VR0FGI9laE0rYoWymKNImBcp7TD1ttaFF9KVrL2QIezuhlIoJOs+hg2+m1v+3xpY0gnyerNdDUW
 coqnmVQYi/i4aB6t+4MiIdfNOywqxz1IgWpuuO3SfRNUWlC0ADxYUxZP5sM3ykpW2Dyr58Eymbx
 b0hkn1QEmPzxzjx33xRD1WMhy1zYN4gdZbpM8zpk8E4ex4Zu06Z0o23HujxZ5P4waG2BqCI2rE8
 hW4i3wP7WFkn+Y70MYS1dL58wWUK6OxZ2PqpqRJBf/MmQDktJBunlRtR/af3v/ToXmf+2eJZp8r
 QCfe5NwLrMUu/1aT0wC29+VqrWGLJQ==
X-Proofpoint-GUID: Ynzz4YjIwNYkvSLjz6NDtqR9R3scYAnj
X-Authority-Analysis: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=6900901d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=VnNF1IyMAAAA:8
 a=SCWEXSD_nzHFeBQ-3JkA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: PQGpeh3F1XewoKmTeIudnCG2mYe1P4vD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250019

On Fri, Sep 19, 2025 at 12:17:58PM +0530, Ojaswin Mujoo wrote:
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc header for each data block, which is verified later to
> ensure there is no data corruption or torn write.
> 
> This test essentially does a lot of parallel RWF_ATOMIC IO on a
> preallocated file to stress the write and end-io unwritten conversion
> code paths. The idea is to increase code coverage to ensure RWF_ATOMIC
> hasn't introduced any issues.
> 
> Avoid doing overlapping parallel atomic writes because it might give
> unexpected results. Use offset_increment=, size= fio options to achieve
> this behavior.
> 
> Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/1226     | 108 +++++++++++++++++++++++++++++++++++++++++
>  tests/generic/1226.out |   2 +
>  2 files changed, 110 insertions(+)
>  create mode 100755 tests/generic/1226
>  create mode 100644 tests/generic/1226.out
> 
> diff --git a/tests/generic/1226 b/tests/generic/1226
> new file mode 100755
> index 00000000..7ad74554
> --- /dev/null
> +++ b/tests/generic/1226
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 1226

Hey Zorro,

Thanks for picking these in for-next. I just noticed that the test
number for this test has become 773, but we missed changing:

 # FS QA Test 1226

 to

 # FS QA Test 773


Commit: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=for-next&id=1499d4ff2365803e97af3279ba3312bba2cc9a80

Regards,
Ojaswin

> +#
> +# Validate FS atomic write using fio crc check verifier.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic
> +_require_odirect
> +_require_aio
> +_require_fio_atomic_writes
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +_require_xfs_io_command "falloc"
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +
> +blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
> +threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
> +filesize=$((blocksize * threads * 100))
> +depth=$threads
> +io_size=$((filesize / threads))
> +io_inc=$io_size
> +testfile=$SCRATCH_MNT/test-file
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +fio_aw_config=$tmp.aw.fio
> +fio_verify_config=$tmp.verify.fio
> +
> +function create_fio_configs()
> +{
> +	create_fio_aw_config
> +	create_fio_verify_config
> +}
> +
> +function create_fio_verify_config()
> +{
> +cat >$fio_verify_config <<EOF
> +	[verify-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=read
> +	bs=$blocksize
> +	filename=$testfile
> +	size=$filesize
> +	iodepth=$depth
> +	group_reporting=1
> +
> +	verify_only=1
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_state_save=0
> +	verify_write_sequence=0
> +EOF
> +}
> +
> +function create_fio_aw_config()
> +{
> +cat >$fio_aw_config <<EOF
> +	[atomicwrite-job]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$blocksize
> +	filename=$testfile
> +	size=$io_inc
> +	offset_increment=$io_inc
> +	iodepth=$depth
> +	numjobs=$threads
> +	group_reporting=1
> +	atomic=1
> +
> +	verify_state_save=0
> +	verify=crc32c
> +	do_verify=0
> +EOF
> +}
> +
> +create_fio_configs
> +_require_fio $fio_aw_config
> +
> +cat $fio_aw_config >> $seqres.full
> +cat $fio_verify_config >> $seqres.full
> +
> +$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
> +
> +$FIO_PROG $fio_aw_config >> $seqres.full
> +ret1=$?
> +$FIO_PROG $fio_verify_config >> $seqres.full
> +ret2=$?
> +
> +[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/1226.out b/tests/generic/1226.out
> new file mode 100644
> index 00000000..6dce0ea5
> --- /dev/null
> +++ b/tests/generic/1226.out
> @@ -0,0 +1,2 @@
> +QA output created by 1226
> +Silence is golden
> -- 
> 2.49.0
> 

