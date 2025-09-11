Return-Path: <linux-ext4+bounces-9935-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCD9B53A2A
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB5167263
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0423705A0;
	Thu, 11 Sep 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iZqR/7iD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678936CDFC;
	Thu, 11 Sep 2025 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610885; cv=none; b=DBkNfSgc2ldhBjRdYOLDpBd1D1W1CgROP4GpiCMiDr2q6Xgum6RvXfzeAllTGc2Q1MZaosNUxLFskFgBAaX9+JAgfKgeAf5vf5ENOuAbSckoWWLyPmnoP2vuP0tgd7RL7nuMsp7Eg87v5hnq+IBWhgXCST/c16VYVnbhk3ADZnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610885; c=relaxed/simple;
	bh=AbuoGFdbt5Nlsepwq1pcM/3iTAcG8d6i8S+4mWjlAYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vl+9a1XwCH5lWBiSq+bwlbG/UcXS3ZuWKkytG/IxNi5ED+XjjzmOsPTtWSfibZ0wII5VslImnv+SMvxzPI/VXxmW4R6zJDJ00rgwSAA25cOjZszAHw4pwsuiXyz+Qau/jB0WhyuKcUK9l/BUj2h5E4yi5AcNij+k2QAFbTVsnaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iZqR/7iD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEforI003430;
	Thu, 11 Sep 2025 17:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DTRxxUzb0Dsn0/GBD
	P5OgVL94Y67Y6ZSK7VjxTYr85w=; b=iZqR/7iDKPkJEJ7Web7O3q6vLniaEQbtm
	qdtX/r7+8K+4LA+RBQtLudi4KAggoiag5Lt42sZqMFLl9jiRtj6M2vTvieuY1v+f
	6X9GBRszNQOCkGiRM2v2FJpBHPEqPn8Q6UHzSo6RA3NZbjCTdsv6VqrP5PDAo4va
	Ob1k7SKg+/f1a8dceAiRhy6fshBFLJXFpEUVlXL07QeJCUYRKC4A9gtEflAOS1Dr
	zAaMvTWfzY/m5HDQ9zfB/5CWw/A24hCVLaEk1Zgvri/AHkPB3Y4iWMXNg1IGCE9K
	3dpFmIUvlAkrHtzeCt9U3CL3tl64/6fsgutPjdVhvMxojTtONYQtQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffp7b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:35 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BHEZZI031056;
	Thu, 11 Sep 2025 17:14:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffp7ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEhF9B001156;
	Thu, 11 Sep 2025 17:14:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 491203pmp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHEW4l44761526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ED5A2004B;
	Thu, 11 Sep 2025 17:14:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 789B920043;
	Thu, 11 Sep 2025 17:14:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 11/12] ext4: Test atomic writes allocation and write codepaths with bigalloc
Date: Thu, 11 Sep 2025 22:43:42 +0530
Message-ID: <aae180c1e022c3f5dadcd20d8c203b38a1df39a3.1757610403.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lUrgXj86GvGn1UaRciA1pKtiElJu-Ta2
X-Proofpoint-GUID: ReZgfDIdaIhecAkleHkjx9gqQIW1E2Gv
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c3037b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=o-vKpyFH2n2aPF30nXYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX3PybK4tbqx44
 vblzkjFqHSndGt9ZPfao9Qie8cvXnjITt6SVxvq/gC3daywTvZ4Gde6zrVfW3g90KHVaWNyf0bS
 XOeY4i1NJMwmlnykjezuJbdUdjGM1hlAVWzoEA0idp7A7Z0m3xpwsQsc0hcuprCh50qB8dVpjiC
 qo44nRnwdHvoVUmSC8a56DHwd7LIV2xAvovtlQRKfo7oL1y2UVSWPUXrMG1GznF9ozOnUVIeRLm
 7llCyNdczqSWm0N3ItUJwA2xdghYepmRpRDA89e1g19nIH+OEm1AXQe0aTNCiWSRzmitjh2y2dD
 VkIqG+yp5Ma13rBs3BrL4jsglC0JgUv8YWk6Mdc2gL/sBW/bp6ogJlSvSW5O9g+DXa1PqizkAxQ
 Zs7Kp3QK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

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
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 203 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 205 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..05cce696
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
+_require_fio_atomic_writes
+_require_aiodio
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
+	_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || return
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


