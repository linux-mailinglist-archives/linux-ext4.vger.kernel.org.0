Return-Path: <linux-ext4+bounces-10260-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFFFB880BB
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0A31896217
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63A2D3EFB;
	Fri, 19 Sep 2025 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mgUCr252"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A32D2499;
	Fri, 19 Sep 2025 06:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264530; cv=none; b=UW/JJE6GHW6CxeSsy/h978zRYmHrw/5HOiQ6JN3itzXH/CKtGM/WuVdRzUi3o/95fhYCWJPLw8lQDChS8zlG2J6SUHQN8EkkvwhTZuzkCDGW6j8sIOFnHb38VsOWIsPWxsRkvZe3l3LKqzozHTtEKto9OdQ3XL3VqghH9dHmEFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264530; c=relaxed/simple;
	bh=+Q/vBM7008NAemI0PvMW6eBWXjGySS3eWBUZ6ZGCzi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbYz1qwI5PoI/TV4ihT6UmbXQfP2XnlZtTv+x8ApzQfe2l/04q1MSxJO3FN9AldHqAUWO390KnmHZp2NxW/XAabxg2i/u6g9UXNol6zp4iolFnVspQeFGlIWAUCks9iEKJguyWfZkK+q8svpJdaNULX+RZBgrE/fJXJPWVaaLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mgUCr252; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2WLt8000352;
	Fri, 19 Sep 2025 06:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Qi50oiRdPA4zdEsWw
	o82Eki8KnW/N3w2AfOe2CPDP0U=; b=mgUCr2521B7r3sBU1CC0sGijpR6T2ndpO
	kIaoKqXri7wOWDljgmFoqQApY8+D2NcafZ3+42RfVRx6r27m5fagqMixNApkA+A9
	A/mxGjFSdhG6xKWaDju1SoIXMoinp0sqWSE6loPOxOA11kpyqry8YuQPrMGDyiB1
	8VrFq8tckknjdL/l/KKbjYgFyjsXzJYEsJ+jf/hqKXtSkDV+0v1xx5NXGGV8JEgo
	+/oPB4DMPmrvSDR8g6/dWLLWIZrwG9LjszubWUaBA+1Xx1zfiHC5a/VMSl/IQVN2
	0/i9J5NWJIXfIY9j/Ngzwnx+IWFOu0cw9JLTjFhVBf59TOQxinV7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxwem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:41 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6XAcG008034;
	Fri, 19 Sep 2025 06:48:41 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxwed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5PEuq022316;
	Fri, 19 Sep 2025 06:48:40 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq2nwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:40 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mcol50463100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1232F20043;
	Fri, 19 Sep 2025 06:48:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AB7820040;
	Fri, 19 Sep 2025 06:48:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 07/12] generic: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Fri, 19 Sep 2025 12:18:00 +0530
Message-ID: <3e255a7b60838df5442a6beb971827853eb9f999.1758264169.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1758264169.git.ojaswin@linux.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1fRzuiRpwZl3ZUlcREDrCffCsTnqR8b2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfXytga5XznK4tT
 MqWskT6rxy1/p0jtPLP3bFTdgA/w+yXYQ/TicTox83kf6fJ8L5+BduiG9YvnfKRxc/Cjbogjoec
 yoSQOLXwe9Bj+YkIFH1PXf1kwxrMBn+rp9UIOli+c2ncmhNpCKp99JiLFvUQEBPKqDw/UMZ32DK
 DSafbJ1Zf5Ey10vxaIMpUaCzKCDXnGQfPYHakFKHNFRgyqVq5WD0uKq/UxG9HVGitA4h/giVsDJ
 Sbr1nAf6M9q4Tx5ddCFNzO9XlEDZl1qs+t631U1YzYvZDtrTXtizkfjpBM/q+oKAMTY36EjZXDq
 7nYwSV7KbkkB7HVQG/XsiDUicznhYPETox7BjINNyADy9WpYhxsB53F6BjJ6HnVzyRARczWOuol
 qP3f+Glc
X-Proofpoint-GUID: psEjK8g7Cgm96cQ_3TXdx-ZlE9BlAud4
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ccfcc9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=udGWdZ-Mnbz566dSa5EA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

This adds various atomic write multi-fsblock stress tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1228     | 138 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1228.out |   2 +
 2 files changed, 140 insertions(+)
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out

diff --git a/tests/generic/1228 b/tests/generic/1228
new file mode 100755
index 00000000..730bf91e
--- /dev/null
+++ b/tests/generic/1228
@@ -0,0 +1,138 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1228
+#
+# Atomic write multi-fsblock data integrity tests with mixed mappings
+# and O_SYNC
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto quick rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+_require_scratch_shutdown
+_require_xfs_io_command "truncate"
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+check_data_integrity() {
+	actual=$(_hexdump $testfile)
+	if [[ "$expected" != "$actual" ]]
+	then
+		echo "Integrity check failed"
+		echo "Integrity check failed" >> $seqres.full
+		echo "# Expected file contents:" >> $seqres.full
+		echo "$expected" >> $seqres.full
+		echo "# Actual file contents:" >> $seqres.full
+		echo "$actual" >> $seqres.full
+
+		_fail "Data integrity check failed. The atomic write was torn."
+	fi
+}
+
+prep_mixed_mapping() {
+	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
+	local off=0
+	local mapping=""
+
+	local operations=("W" "H" "U")
+	local num_blocks=$((awu_max / blksz))
+	for ((i=0; i<num_blocks; i++)); do
+		local index=$((RANDOM % ${#operations[@]}))
+		local map="${operations[$index]}"
+		local mapping="${mapping}${map}"
+
+		case "$map" in
+			"W")
+				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
+				;;
+			"H")
+				# No operation needed for hole
+				;;
+			"U")
+				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
+				;;
+		esac
+		off=$((off + blksz))
+	done
+
+	echo "+ + Mixed mapping prep done. Full mapping pattern: $mapping" >> $seqres.full
+
+	sync $testfile
+}
+
+verify_atomic_write() {
+	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
+	check_data_integrity
+}
+
+mixed_mapping_test() {
+	prep_mixed_mapping
+
+	echo -"+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
+	if [[ "$1" == "shutdown" ]]
+	then
+		bytes_written=$($XFS_IO_PROG -x -dc \
+				"pwrite -DA -V1 -b $awu_max 0 $awu_max" \
+				-c "shutdown" $testfile | grep wrote | \
+				awk -F'[/ ]' '{print $2}')
+		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
+	else
+		bytes_written=$($XFS_IO_PROG -dc \
+				"pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
+				grep wrote | awk -F'[/ ]' '{print $2}')
+	fi
+
+	verify_atomic_write
+}
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+
+# Create an expected pattern to compare with
+$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
+expected=$(_hexdump $testfile)
+echo "# Expected file contents:" >> $seqres.full
+echo "$expected" >> $seqres.full
+echo >> $seqres.full
+
+echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping:" >> $seqres.full
+echo >> $seqres.full
+
+iterations=10
+for ((i=1; i<=$iterations; i++)); do
+	echo "=== Mixed Mapping Test Iteration $i ===" >> $seqres.full
+
+	echo "+ Testing without shutdown..." >> $seqres.full
+	mixed_mapping_test
+	echo "Passed!" >> $seqres.full
+
+	echo "+ Testing with sudden shutdown..." >> $seqres.full
+	mixed_mapping_test "shutdown"
+	echo "Passed!" >> $seqres.full
+
+	echo "Iteration $i completed: OK" >> $seqres.full
+	echo >> $seqres.full
+done
+echo "# Test 1: Do O_SYNC atomic write on random mixed mapping ($iterations iterations): OK" >> $seqres.full
+
+
+echo >> $seqres.full
+echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
+bytes_written=$($XFS_IO_PROG -x -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" \
+		-c "shutdown" $testfile | grep wrote | awk -F'[/ ]' '{print $2}')
+_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed"
+verify_atomic_write
+echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1228.out b/tests/generic/1228.out
new file mode 100644
index 00000000..1baffa91
--- /dev/null
+++ b/tests/generic/1228.out
@@ -0,0 +1,2 @@
+QA output created by 1228
+Silence is golden
-- 
2.49.0


