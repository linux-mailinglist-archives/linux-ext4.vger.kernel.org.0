Return-Path: <linux-ext4+bounces-8953-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6188CB02B4C
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A29B176564
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8836288CB4;
	Sat, 12 Jul 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U5L4cUF2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B1A27F19B;
	Sat, 12 Jul 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329609; cv=none; b=Il5+LU1seoqX9GzvgK1l8suMPiqkZtxrHMufbC12jDrJsQSJLEqlP53wKLCW8N++hqJSVNy0GjKBYD5zmgbi+rrEElPeLRw5m2BXSFQaFVDqK/xFl+DZX7QcQhW0MJtWZLtWjGQVxVSG6eQEnWflNiBnFgBP2EqRCTC7B6pB+9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329609; c=relaxed/simple;
	bh=qfTNrVszUJrJ9X5OWWdIiNeQVrPCrDeBfKMcJnCHPrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiBA8jl7JMFx8jTODohN8OrBZ7XUBvCKIONv4L8Kjhj2md/lZKWH/hUarPIaRu4BSrUkTy6rOLxY8d6NlROExgNWKePTn6K3ch0VdoGTTudXabihjRWTFgcxtG65gX2uf24csmMXFSRvlEgzoqsTiVajXermLPurlw7hPkzYbv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U5L4cUF2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C8i00h028787;
	Sat, 12 Jul 2025 14:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jnPUZ5Gvv3upS+qTq
	KyPnVTG8IdhzTg0fV6sfLAbL/4=; b=U5L4cUF2H0ffhGibTyfbiluxMXmRBNKr2
	cmUgqxZxyZQMbMLE0LBwVi6C7Xi4e9JtHnjADi2O2NSyJjeQs72AsRM1Y3vQprvV
	qlKeUVf/VHEuFaxHrWYZzZARh6xj6RvtvhW7Kip7mbDKI63uZuQHXQ3E5UWRVrGy
	GfTpiWNctBKgltlItiAQkfbnIDaHM1xkUCyRiJXWcz7vWewcnLqKbiQJwM7i5aqm
	164Nzd2jyWAAmvOQbhBR0JaxBBim4/UrHpMUBRPmaajAKQS3AxqMj279VAOICbIT
	iWoCABjp4oFg/e7+kp/H1xvMeNFemuZhp28EZ4KNYhID+d75a1XjQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:20 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDKUS008828;
	Sat, 12 Jul 2025 14:13:20 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CB0DgD002888;
	Sat, 12 Jul 2025 14:13:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfvmy96h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDHfP50594128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 953DA20043;
	Sat, 12 Jul 2025 14:13:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4685320040;
	Sat, 12 Jul 2025 14:13:15 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:15 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 07/13] generic/1228: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Sat, 12 Jul 2025 19:42:49 +0530
Message-ID: <ae247b8d0a9b1309a2e4887f8dd30c1d6e479848.1752329098.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1752329098.git.ojaswin@linux.ibm.com>
References: <cover.1752329098.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68726d81 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=gLbHiHCgn5DP7liA1jIA:9
X-Proofpoint-GUID: F6qj_X1kYoVpbdHmmJO4E2QYVEfRETtR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX7zPPLAUMXZc6 oSHwu1lad0XqCRZQKY1xJRJTPFN+pkHjW5eCXDEJ9cgY4SrzSoxbld7hflVX28VdEQHyXjfmy5+ q9PFGIEvXwdyj589A7OyqYng8xbLL2vroBZTBolv0h+eZ9xNs2h50OiOxQRfHM2G7sXZtyyKZfx
 kZeGUF423+k2mzXLRydJp06rHWRko4ki7379NzF1YUATDooZ2ml0EeRLxt5y9RkBzUlJ/67adCX Fq7Ur4Baeb3bmc8fQC0sh3jb1tQA+t8+JlAeHndRewMmlsYodFXPD124qaglqmahAz2t1e13wfj h9IrW5v4qZauAYTdJdz9bN/5epbT4TWBwvMj21D8QlbHxvWXhmP0ut4A6AQ8Ofn+TIVJ8n4mwq7
 p9RInQ/M2MVeOwuBme7afqBOGqe1GH5zF2LQfIy+FsgsPAIoRLTCi/Et10bcxeCNvIq2VwHT
X-Proofpoint-ORIG-GUID: 9f9BEVOGHkrhG0L7XQpWn_B8L0EQ-6aL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

This adds various atomic write multi-fsblock stresst tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1228     | 139 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1228.out |   2 +
 2 files changed, 141 insertions(+)
 create mode 100755 tests/generic/1228
 create mode 100644 tests/generic/1228.out

diff --git a/tests/generic/1228 b/tests/generic/1228
new file mode 100755
index 00000000..3f9a6af1
--- /dev/null
+++ b/tests/generic/1228
@@ -0,0 +1,139 @@
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
+	if [[ "$1" == "shutdown" ]]
+	then
+		local do_shutdown=1
+	fi
+
+	test $bytes_written -eq $awu_max || _fail "atomic write len=$awu_max assertion failed"
+
+	if [[ $do_shutdown -eq "1" ]]
+	then
+		echo "Shutting down filesystem" >> $seqres.full
+		_scratch_shutdown >> $seqres.full
+		_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
+	fi
+
+	check_data_integrity
+}
+
+mixed_mapping_test() {
+	prep_mixed_mapping
+
+	echo "+ + Performing O_DSYNC atomic write from 0 to $awu_max" >> $seqres.full
+	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
+		        grep wrote | awk -F'[/ ]' '{print $2}')
+
+	verify_atomic_write $1
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
+bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
+                grep wrote | awk -F'[/ ]' '{print $2}')
+verify_atomic_write "shutdown"
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


