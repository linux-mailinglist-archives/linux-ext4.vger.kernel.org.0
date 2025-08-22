Return-Path: <linux-ext4+bounces-9563-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71152B3113C
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C72AE60F6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2EC2EF671;
	Fri, 22 Aug 2025 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IMZCTaXr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D952EE615;
	Fri, 22 Aug 2025 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849778; cv=none; b=H3w7VLeZKahWl+NeQHNYGUJFrXyJqkGTLsxpasguxc2oKmk33FtoIUeZOOC/9oLvJCPzmaU1iF36pkal1BSXsR4vL3kL3Wa3HeZJXB+IhPXOHcHIMWbs/u1Px6eWmCW4zX8QHDdePyY7zE+q2i8F7HqufcBCa6nLAzno0PLHPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849778; c=relaxed/simple;
	bh=2wdVnJkwYeXW7x3GQfVg5pByW22kDKehXKlG4uwt6M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjORSV7Xm/HSoACPT8kLKAi9b4Kby3dGF8douoKBxLM8K8OndzeEjheblkx3XQq7vTBg4zVURqYFD7Kg83XbOw5rQjqXzrvpYT49oFcIsPWL+PTh2tp3PhFbAK+LcQHfyZ+BqDhyvejkPeLjLKNNgbUHTzxc8ZvVDKUL8eeAhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IMZCTaXr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7SdRe016626;
	Fri, 22 Aug 2025 08:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yNbSQIv91voq6nVLy
	j5r+K1DTIwAWE6KyJ4qtnZes4g=; b=IMZCTaXr8tlzfqgaAyqIk8a7LQ11qzQFe
	F2shbRA+CFrBTwlJxmgDlMU4g7uPiiUZP5bCKb5JEHN8GBKGyUQOq0GvLZ983fAt
	y7E5HweiFQ2BveG9OysrJy0nGhhKltJWCdcF4xDf0aOsui4zyGzsvWphHZRNuYgn
	7YsEBUfFOjT1n4sldVb6SB70s+R4GIVcOeRCiThZ5Ytl5n3v3qffZemn/4/25R9r
	wkaa2k5quW17X+Wd/MeTPfCpkclCtEUggWtyR3ccl3KaRHsuee/6K/C/vjjjhJG6
	1Jrrds3uIknA+JPENKkmjFK0EDNH993PmTXN86LdqYkhhqHpelCJQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw9f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:48 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82maC006425;
	Fri, 22 Aug 2025 08:02:48 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw9f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M82c3V031905;
	Fri, 22 Aug 2025 08:02:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my5ycajb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82jlm41681250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52A7420043;
	Fri, 22 Aug 2025 08:02:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F78B20040;
	Fri, 22 Aug 2025 08:02:43 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:42 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 11/12] ext4: Test atomic writes allocation and write codepaths with bigalloc
Date: Fri, 22 Aug 2025 13:32:10 +0530
Message-ID: <a223c31b43ce3a2c7a3534efbc0477651f1fc2bb.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: YuBsMEhNRXzZxdML_JkVPj5SR83duF2C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXw1yTeOAwBnj6
 rWSbvtLB1hz7wDCM7tCX6euWis+rwHeU8O4ZrJ5Or5AR5uIdYpnHHr63sBoiK62zxuURMI7HZaE
 K58PF2CjIR2+DmtwNp9asuz34r8ZnKyfOS2BmT4kyukY8eDmD+8aUrUz8LY6qcACdPnTPNrGK7G
 SmMUiYXln8TMNkueVZBKsVbzpSsSJRbvpoeeI3fDhPantHsup3BvgYm46eI7OD9HmeXCygpykfV
 a1QwA6JjNO/0kE+JAFHwuDDVIBrhr5B6GfKEmgpCQa9uDIFj1al8cg9oAAlW3BI+rouTsbTEX2x
 9doHAMswaANtGrMO+I8RT3RKD8BJ79N61dYFUAzFmeb7yZLEyzVn0y6U4P5lY1dTeAO8Sf5p0xH
 qn060AgIFynF8XNmTFetwueZywaE3A==
X-Proofpoint-GUID: CJnYrdIPhsgyGEpVeLwu9H36y2Qrlyns
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a82428 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=o-vKpyFH2n2aPF30nXYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This test does a parallel RWF_ATOMIC IO on a multiple truncated files in
a small FS. The idea is to stress ext4 allocator to ensure we are able
to handle low space scenarios correctly with atomic writes. We brute
force this for different blocksize and clustersizes and after each
iteration we ensure the data was not torn or corrupted using fio crc
verification.

Note that in this test we use overlapping atomic writes of same io size.
Although serializing racing writes is not guaranteed for RWF_ATOMIC,
NVMe and SCSI provide this guarantee as an inseparable feature to
power-fail atomicity. Keeping the iosize as same also ensures that ext4
doesn't tear the write due to racing ioend unwritten conversion.

The value of this test is that we make sure the RWF_ATOMIC is handled
correctly by ext4 as well as test that the block layer doesn't split or
only generate multiple bios for an atomic write.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 203 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 205 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..d48f69d3
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,203 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 062
+#
+# This test does a parallel RWF_ATOMIC IO on a multiple truncated files in a
+# small FS. The idea is to stress ext4 allocator to ensure we are able to
+# handle low space scenarios correctly with atomic writes.. We brute force this
+# for all possible blocksize and clustersizes and after each iteration we
+# ensure the data was not torn or corrupted using fio crc verification.
+#
+# Note that in this test we use overlapping atomic writes of same io size.
+# Although serializing racing writes is not guaranteed for RWF_ATOMIC, NVMe and
+# SCSI provide this guarantee as an inseparable feature to power-fail
+# atomicity. Keeping the iosize as same also ensures that ext4 doesn't tear the
+# write due to racing ioend unwritten conversion.
+#
+# The value of this test is that we make sure the RWF_ATOMIC is handled
+# correctly by ext4 as well as test that the block layer doesn't split or only
+# generate multiple bios for an atomic write.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+_require_fio_version "3.38+"
+
+FSSIZE=$((360*1024*1024))
+FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
+
+# Calculate bs as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+bs=$(_max 4096 "$bdev_awu_min")
+
+function create_fio_configs()
+{
+	local bsize=$1
+	create_fio_aw_config $bsize
+	create_fio_verify_config $bsize
+}
+
+function create_fio_verify_config()
+{
+	local bsize=$1
+cat >$fio_verify_config <<EOF
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=read
+	bs=$bsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_only=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_write_sequence=0
+
+	[verify-job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[verify-job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[verify-job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[verify-job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[verify-job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[verify-job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[verify-job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[verify-job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+function create_fio_aw_config()
+{
+	local bsize=$1
+cat >$fio_aw_config <<EOF
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$bsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_state_save=0
+	verify=crc32c
+	do_verify=0
+
+	[write-job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[write-job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[write-job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[write-job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[write-job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[write-job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[write-job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[write-job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+run_test_one() {
+	local bs=$1
+	local cs=$2
+	local iosize=$3
+
+	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
+	_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
+	if _try_scratch_mount >> $seqres.full 2>&1; then
+		echo "Testing: bs=$bs cs=$cs iosize=$iosize" >> $seqres.full
+
+		touch $SCRATCH_MNT/f1
+		create_fio_configs $iosize
+
+		cat $fio_aw_config >> $seqres.full
+		cat $fio_verify_config >> $seqres.full
+
+		$FIO_PROG $fio_aw_config >> $seqres.full
+		ret1=$?
+
+		$FIO_PROG $fio_verify_config  >> $seqres.full
+		ret2=$?
+
+		_scratch_unmount
+
+		[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
+	fi
+}
+
+run_test() {
+	local bs=$1
+
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size
+	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
+
+	# Fuzz for combinations of blocksize, clustersize and
+	# iosize that cover most of the cases
+	run_test_one $bs $bs $bs
+	run_test_one $bs $max_cs $bs
+	run_test_one $bs $max_cs $max_cs
+	run_test_one $bs $max_cs $(_max "$((max_cs/2))" $bs)
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+create_fio_configs $bs
+_require_fio $fio_aw_config
+
+for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
+	run_test $bs $cs $iosize
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/062.out b/tests/ext4/062.out
new file mode 100644
index 00000000..a1578f48
--- /dev/null
+++ b/tests/ext4/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
-- 
2.49.0


