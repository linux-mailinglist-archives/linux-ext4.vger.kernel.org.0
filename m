Return-Path: <linux-ext4+bounces-9314-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B17B1FA37
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579597A6752
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01D7272E54;
	Sun, 10 Aug 2025 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EkZSWOdR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13983270EC3;
	Sun, 10 Aug 2025 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833354; cv=none; b=sQnoGEe/A10Y1qkpRSPNGHPN6i+AZolE7lJcrdn0sg2SooDr5JwNcdvaCfpsEJ7GsMe1lFaU3Qi4fp6ckh75WAJ5SJwz+18VWy6+v5YAn4tRSpBtXVWXowE+eW1MblcmtuXGGaKs9dgTLTZ9wZQUY4mcmFUwIZcJ6WXR/qaZ/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833354; c=relaxed/simple;
	bh=sytgdqcLbEYSb1CR1JneiuQwbBB4t3W8xsdq/VdKKMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ORs3FeLtk8D8bvngQkRhxqpYa4i4u+IqanlLwevFi8tFCqTvn4dQWKUHpUU/Ga9Jh1PpODeHdHHN87wyJOfanIySTCPAsobEbZlgAJGRlOiMA8dnm7vCwOsqGZXluoU9nMs+Pcl5XeKKveIH7YMpGNJZhHBz3q4RTFE/TMY+TDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EkZSWOdR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ABbDaG019717;
	Sun, 10 Aug 2025 13:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M9+Rq+m14A0N34e0u
	DjaBhsdDMEAWYACoan5D5g/ylM=; b=EkZSWOdRPP2XtDyophCeA7aQ/L9zrGq+X
	8DpLeZJsWfd++0FL9OMV8o6ZqzPIejTkhPui5XlZN/E4g9Nckw/HYssSOCGiANmj
	6RjURSBdK6YvC/lkufRDqylDg2fo8T7rQgWCf8JNPH2gJPEixGnT8m9udVZ+1/aY
	jc/NLj1KbLIhWWjzxu0aD9wS6AlfZEDJ5vS9gYh8aRsF/FRF2mW0BDJoxWK5CqBR
	xiPSUdgnMfc2pWH83b6CYxqc/c4Jr6iC2Qg8lWnudoTWjN1D4zPRV54umtM6ZKl+
	cG7MuueOFrGik45+i2b8hTvfYL5pnEmfX52gtf0WrNuoTEvRP+4eA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cnb4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADcl4I005415;
	Sun, 10 Aug 2025 13:42:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cnb4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A97jn7017588;
	Sun, 10 Aug 2025 13:42:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc39nes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgMUh22479118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3EB620043;
	Sun, 10 Aug 2025 13:42:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5BCA20040;
	Sun, 10 Aug 2025 13:42:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:19 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 06/11] generic: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Sun, 10 Aug 2025 19:11:57 +0530
Message-ID: <af97ff125953e4e29abc42d1726c632398652d67.1754833177.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754833177.git.ojaswin@linux.ibm.com>
References: <cover.1754833177.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfX6BB6ZWWthyeM
 +OZOSZmi3JaYvFoXbUlPbtxEMThn91Uch92rglGERe0NZCIKlbPAq2vybvFGGuOqoyw5/oZ9JWm
 W2V2JkVF3PsgZQ8F+W894mo9XZCSjuMwpDfc+WPTAi3kHrX973lsE1ktm9xqq1WJRKTLA+kv1nX
 09ShwrGPvv+8bB9zSpK/i70cIfVgwtZOkXVIdG348q3tcdsDRnRiYXCs7Nr8/Muxba3bB9sbgbz
 HIjhv+ey5csbirFLpc3YLi1Ic1XPLCFZKzk6T+/I6YDXTf1VjlvaP0bUVTqU7ZcVU7bYaSaKxb1
 zj9FZiaWrhA7qTMh6Q1J5OCxQ1sY/7hrzUYN2fQvJqqNFZj5g+C7Bj9xzHy8LBHhUzRtzUzLICV
 Du4of5fTxzs8bLLx1ypeeS4q16LUhFsbPXCpRH5nnr9Ku93ysxEjEF+zza9joBdWUEQdJuqW
X-Proofpoint-GUID: Eb6OzDRH6xBFOwUPqBEwwO8w2pFIfNt7
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=6898a1c1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=udGWdZ-Mnbz566dSa5EA:9
X-Proofpoint-ORIG-GUID: vDqJRWPpH4v_bOdZmyqv2HqQI1NdnjVa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100097

This adds various atomic write multi-fsblock stresst tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1228     | 137 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1228.out |   2 +
 2 files changed, 139 insertions(+)
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out

diff --git a/tests/generic/1228 b/tests/generic/1228
new file mode 100755
index 00000000..888599ce
--- /dev/null
+++ b/tests/generic/1228
@@ -0,0 +1,137 @@
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
+for ((iteration=1; iteration<=10; iteration++)); do
+	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
+
+	echo "+ Testing without shutdown..." >> $seqres.full
+	mixed_mapping_test
+	echo "Passed!" >> $seqres.full
+
+	echo "+ Testing with sudden shutdown..." >> $seqres.full
+	mixed_mapping_test "shutdown"
+	echo "Passed!" >> $seqres.full
+
+	echo "Iteration $iteration completed: OK" >> $seqres.full
+	echo >> $seqres.full
+done
+echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
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
+
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


