Return-Path: <linux-ext4+bounces-9930-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF2CB53A1A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0BDA3AF7C7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C33369993;
	Thu, 11 Sep 2025 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UANVipZF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B4362092;
	Thu, 11 Sep 2025 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610862; cv=none; b=lRoKyLvxLGuyJB2AqCYF1GyuknsGAvSpcUuorvg2P/taZ42mqbZfN0SwSnOcacv5kGV7fMJVn/SeLhtu4eKtiBDAJKQmQZNXZHrejUkbk/+oBMoDriAe29KWVZTWfpIx1piRYyI8+L5hjQdBBBIPca8ldr8VzF20WIBp10A27ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610862; c=relaxed/simple;
	bh=U2+DFjhyIqPMB1ayIZuWmHVDK4O9xd4a2D0R+RU4N6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nF6cqJX1Dkex1DuKzrA5xN8DcGicgcK/qrXTdo0zeLWPZrxNFuMppF3cKV3v9uIUYGNoFamfuCvz0PJQF6A6agm6TzeBW9eulHBBsRBYBJEUQyDOs1D+gkFFke5c4PZZ8aAZa5KFhoczh+ctRmPdRiddtNfHbESR3BsqBsBghy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UANVipZF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BG15T2011307;
	Thu, 11 Sep 2025 17:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5rUBmHsTxULczha7j
	OsuDxqz5QJHjQC/dMqlzcYVYyA=; b=UANVipZFu3sv3eSNo1RjGHFb4lzPW/3WM
	TlQZRByIFDVIwtt7/FyzJ9wwPso7gMxmiN8X5ZJViwOWj1Mli9/07y8sI8mJ68ds
	QXMu6ZJT53/mtPPPKbPR3DkJbAU/OPpJXzxntrScyj9Y7raZ4Y3+AUFmrlwLURZH
	YHtUO8tWNW5RR14EBDKtvJQ4TR2sxcRoEy5H/f0uD4i3yzLNy0zsCCatpie7iBpH
	8eVqK6uJqXceh3IM4mGMMvmeTiQg4wc/bED1RjJdbYvnVJXo1hMhiioFCIW8DOlU
	Dd1fBHSOu3goZyztymWWLgn7KPYGRlKWjZ2rupZp4VV5rt26xovng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct5e5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BHEE81032340;
	Thu, 11 Sep 2025 17:14:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bct5e56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH3c1w007929;
	Thu, 11 Sep 2025 17:14:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pxvx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHEBrj52494704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 957FA2004F;
	Thu, 11 Sep 2025 17:14:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56E4120040;
	Thu, 11 Sep 2025 17:14:08 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:08 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 06/12] generic: Add atomic write test using fio verify on file mixed mappings
Date: Thu, 11 Sep 2025 22:43:37 +0530
Message-ID: <1fba284833eb435bdc8b20910fd49f3bf1e1b504.1757610403.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1757610403.git.ojaswin@linux.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfX8+QTGC1SsPNV
 RSvLnNPw0y9VMeW4xFkwsOGwx106tKcdS0Vvu4of7Dz8WrjGH8yf6OdxF8upXlMMh2uFSaEf/Nm
 IF71wq8bccBKRBey3eXFg8esXWkNTwItFqrmHL8ZodmWIwW+I27UZpNFMoFa576aeVWUT9SO3CE
 7ozo8RyHy9Q76oKb17DD9QBLX0NoZsTfrfROjo3BDcEcSBTnl6fKYiXn5xsLyq7wQIQhhwccjeb
 A5jTjMXaZyMO9PBPx1ghPZoP5SW9cWNzbnRM+cuhmbTg/v/OxArWfFpp2okKSMwXuAWs/Izezhe
 UOmSWKXBlrC/HPXUIqKq3/parMSMXMfdmNad7rgYQi5v0vQKzwqmc+6FaumFMzeuy5C2zNcegsO
 4a/R2kJh
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c30366 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=qMsZUPF6o8un45dIlBUA:9
X-Proofpoint-GUID: fNwlUYfHe66fUQP6vZWUHGnccZ-LdSuJ
X-Proofpoint-ORIG-GUID: mPMr_YVTD9BrGoSCqUggHp_vQYZCl6S6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

This test uses fio to first create a file with mixed mappings. Then it
does atomic writes using aio dio with parallel jobs to the same file
with mixed mappings. Finally, we perform a fio verify step to ensure
there is no data corruption or torn write.

The aim is to stress the FS block allocation and extent handling logic
to ensure it handles mixed mappings with RWF_ATOMIC correctly without
tearing or losing data.

Avoid doing overlapping parallel atomic writes because it might give
unexpected results. Use offset_increment=, size= fio options to achieve
this behavior.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1227     | 132 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1227.out |   2 +
 2 files changed, 134 insertions(+)
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out

diff --git a/tests/generic/1227 b/tests/generic/1227
new file mode 100755
index 00000000..26177508
--- /dev/null
+++ b/tests/generic/1227
@@ -0,0 +1,132 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1227
+#
+# Validate FS atomic write using fio crc check verifier on mixed mappings
+# of a file.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_odirect
+_require_aio
+_require_fio_atomic_writes
+_require_xfs_io_command "truncate"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+
+aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+
+threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
+filesize=$((aw_bsize * threads * 100))
+depth=$threads
+aw_io_size=$((filesize / threads))
+aw_io_inc=$aw_io_size
+testfile=$SCRATCH_MNT/test-file
+
+fio_prep_config=$tmp.prep.fio
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+cat >$fio_prep_config <<EOF
+# prep file to have mixed mappings
+[global]
+ioengine=libaio
+filename=$testfile
+size=$filesize
+bs=$fsbsize
+direct=1
+iodepth=$depth
+group_reporting=1
+
+# Create written extents
+[prep_written_blocks]
+ioengine=libaio
+rw=randwrite
+io_size=$((filesize/3))
+random_generator=lfsr
+
+# Create unwritten extents
+[prep_unwritten_blocks]
+ioengine=falloc
+rw=randwrite
+io_size=$((filesize/3))
+random_generator=lfsr
+EOF
+
+cat >$fio_aw_config <<EOF
+# atomic write to mixed mappings of written/unwritten/holes
+[atomic_write_job]
+ioengine=libaio
+rw=randwrite
+direct=1
+atomic=1
+random_generator=lfsr
+group_reporting=1
+
+filename=$testfile
+bs=$aw_bsize
+size=$aw_io_size
+offset_increment=$aw_io_inc
+iodepth=$depth
+numjobs=$threads
+
+verify_state_save=0
+verify=crc32c
+do_verify=0
+EOF
+
+cat >$fio_verify_config <<EOF
+# verify atomic writes done by previous job
+[verify_job]
+ioengine=libaio
+rw=read
+random_generator=lfsr
+group_reporting=1
+
+filename=$testfile
+size=$filesize
+bs=$aw_bsize
+iodepth=$depth
+
+verify_state_save=0
+verify_only=1
+verify=crc32c
+verify_fatal=1
+verify_write_sequence=0
+EOF
+
+_require_fio $fio_aw_config
+_require_fio $fio_verify_config
+
+cat $fio_prep_config >> $seqres.full
+cat $fio_aw_config >> $seqres.full
+cat $fio_verify_config >> $seqres.full
+
+$XFS_IO_PROG -fc "truncate $filesize" $testfile >> $seqres.full
+
+#prepare file with mixed mappings
+$FIO_PROG $fio_prep_config >> $seqres.full
+
+# do atomic writes without verifying
+$FIO_PROG $fio_aw_config >> $seqres.full
+
+# verify data is not torn
+$FIO_PROG $fio_verify_config >> $seqres.full
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1227.out b/tests/generic/1227.out
new file mode 100644
index 00000000..2605d062
--- /dev/null
+++ b/tests/generic/1227.out
@@ -0,0 +1,2 @@
+QA output created by 1227
+Silence is golden
-- 
2.49.0


