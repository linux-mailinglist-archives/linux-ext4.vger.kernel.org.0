Return-Path: <linux-ext4+bounces-9558-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5AB31130
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7836AE266C
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DB2ECD28;
	Fri, 22 Aug 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GyLEeS1c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD62C327C;
	Fri, 22 Aug 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849763; cv=none; b=tK2w+n9yxhQyw7bOKJXe7GyRuwfG1YpcPkuvzpk+GGBmULwRoEuorqPgOR5JW5lDBG6aGuEKcmEC0w12Yam8ZTZNfzPoP/bART7MBaxVSZve99Gr/w/W5JFcF9TvL5VHX2T8FPHxw41htWA2ohVSBkIo0SmHP5XX0nTM/Bm5pso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849763; c=relaxed/simple;
	bh=8CMIXGQU36RgTOG94vHlD8QeoCxA0yHAB4Z5AiKWrAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipC7FPmhe6rRThs0tCxvKXe7p7BnvmYD09EPXL4fO/LWMMDnSwiqoUIQrSmPn84uoDAmldNLkpcSZFZTaEVXDqWtxMz2trkLaOaRIiTp50TGbtPEsMvYW6OeCprGR/YVOx1Sc8Ml9aOPeVlKed9KB1h4CIFnIu2A4LzyVd6oxGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GyLEeS1c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7sieW012030;
	Fri, 22 Aug 2025 08:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cQvp/JuP9aF8QNkil
	Z43A0YrULZxNlobH9EraofDX70=; b=GyLEeS1cV7wZLXaa/dSHNPeoTrUksrnTs
	+nrwEMxLyct5ILwocCQ9bofGldVJ5jV97rUw7TGZaEt4Aw3TgYK9nOX9y9W5NgKC
	kBR3sum9JnFe5vkdplW/NEgSyNvgjyiBL5jnb8lMx0vEMiP/aM/WzPIVxrwHpWfi
	nN/6zzil4TJTgY16+/tC3pPDbAmseU8kEZtFRshlQGOp4NpnsbizUanGcw8f7XgG
	amXKmYialDnaGQBLa/IqMnZbfy0Bhm0XjCaA0newQjBBQX4j71R5gKJ4Eu8u0nQQ
	IB3kRrSu4S210J7dLiVZsPR8xskcB/Eb9XxH0aXK35g0ziGCG5eJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M7rf4Z005362;
	Fri, 22 Aug 2025 08:02:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw4df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M4KUCp008726;
	Fri, 22 Aug 2025 08:02:33 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my42caej-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82VvY46334360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6243220040;
	Fri, 22 Aug 2025 08:02:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58CC2004B;
	Fri, 22 Aug 2025 08:02:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 06/12] generic: Add atomic write test using fio verify on file mixed mappings
Date: Fri, 22 Aug 2025 13:32:05 +0530
Message-ID: <7c508d4ecfa8ff1be5c031d1675e0b378c581028.1755849134.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755849134.git.ojaswin@linux.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX1qRvB1ZeUMhk
 cfXYovvDCMrPg1/fvLoNXUr9mfHjWOYqIfyISnYxrzbluHHPbuC52xa+4ne7YBiiwkUI3p7xsZK
 SK8G9NHP6nwt/09CqgePD3ChfON44xv3n28rgR/zbQ1ecMe722b2o28wHnJMAhB7HRhbigYr8PU
 krDiv4LH00Ymx/N+UthvtcUtGhKgXHypsoY1kt3b9VodG3HYBU+VCTktt6QbFUs0Ly6AfkoVRPu
 yoQUQe0VzBkBc0U9oyx6WrpxQT5aOSknWr1hG0WQmvv9m6ZnMdqoZV8hYUTfRVFmrnU+aMvKodB
 SLLEt4Qxs4Gbk91BkHUZyXVXzNoebk777UpiwTgZ2wW9M3aJTwhIUPlMrorE5hG6iFfLpAOqz+a
 KcRFUOiXXvFNgqXPpNcDqo5+PLOlWw==
X-Proofpoint-ORIG-GUID: UVXTeVZnlpsZD66Iv7JYZTXG1qhGTbWD
X-Authority-Analysis: v=2.4 cv=T9nVj/KQ c=1 sm=1 tr=0 ts=68a8241a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qMsZUPF6o8un45dIlBUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0kFVMbE8BDgVBdpmILCNjPixcoR2XesK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

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
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1227     | 132 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1227.out |   2 +
 2 files changed, 134 insertions(+)
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out

diff --git a/tests/generic/1227 b/tests/generic/1227
new file mode 100755
index 00000000..a5ff9fca
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
+_require_fio_version "3.38+"
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


