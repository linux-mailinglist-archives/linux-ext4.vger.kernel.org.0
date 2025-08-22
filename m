Return-Path: <linux-ext4+bounces-9559-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D18F7B31134
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CA071D012C4
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E63D2ECEA6;
	Fri, 22 Aug 2025 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YjfIHH1s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F64D2ECD35;
	Fri, 22 Aug 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849767; cv=none; b=IwZGrVQUtb5kXlMLjLbY6ynl8aUsCYqxfEGjvY2YKgpgRcTJs10A1JJXHoWoOzzyN26s0OMxO5QIdcLOuHppKkiVTaSFOrsqxa8kPaI6jBhVrT1Q9rZPMR7GGgyFzNBTXIgyXQZCLnDPuOc2Nb2RQAf6foKxsDhu28qzcRfH7Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849767; c=relaxed/simple;
	bh=duzUlj0n0K27jnqJHj3/3MK0/1qL/ma7YHwUL9HIQgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbKLZHH+J4NNlLMTCQNuQ596TrZ0qO3eNF8tpezSasSO44+omDGJSks+NVuLMKvSpXOMp3+mWlh1VYfeJKDs37rSqSZUlfpA32kUbMot3wJp7ORHbRhlWULg49sljWxWBt+fr5p/bzBWQ/RfugCb3nmQu9MlSLW41XQ76XW87/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YjfIHH1s; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIuaRb007983;
	Fri, 22 Aug 2025 08:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sMpg0a048nM/v8MIy
	ZOuHjJkc8vOd5G56C4gl3yrYJQ=; b=YjfIHH1shKzMfDuI6ueL2hibOuPpxlX9m
	IkH+WvDFZVl1wR/yQ8RzjlauDtRpngbxWeby2sCOJiNsRj1pHvafpU1VXRFbQj87
	bleWXVWXIb1219A6oMkwameZg65+svBf1Gzn2ECbLoC3Yjm9e3ATzwjKDe8Sux00
	JBIiRh3c/Hgwi8qJO5iBe6Drr15lxSMz8Xo5W15Tb3iexSiUXdd3DXZO8K/iJ+YH
	MAE4oCIRAqmQL8o2bKuLwuNl6bXkROmMPnvrcyuXxOhypNh0UD7L97wsyVFxWgOW
	L/yRyCK8gAMDfph15uZFaGDY0Ke12CmCzvrC/f1FYC3GVdJYv47+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w5419-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M81Bff014547;
	Fri, 22 Aug 2025 08:02:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w540y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M473Lw024299;
	Fri, 22 Aug 2025 08:02:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43vahs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82Yik47579618
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27ECF2004B;
	Fri, 22 Aug 2025 08:02:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDB2F20040;
	Fri, 22 Aug 2025 08:02:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 07/12] generic: Add atomic write multi-fsblock O_[D]SYNC tests
Date: Fri, 22 Aug 2025 13:32:06 +0530
Message-ID: <55583acdfb6cb69bcea84a56cbc20754e1d2f4f4.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: TcmE-7V-XyhBiC_3y35MDlU7mWm-deRg
X-Proofpoint-GUID: ZAGid3oNachqK8YjOyOr06knXh3X5rk7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX4R/hnF7kk/Gb
 mLlhBeDxiw+P7USqZx+Ivtk1OTjEb6n5WqtJmXVVRiTYxrMNU+3S/HsT3WrudYFW0esahdURKd8
 2VuRf4Q50rxxPXobutN9csR86Qx7Cx1RCHDNR7Rc2TGIhiB9MWlN/KhUMBYjPhid22wbxM1KmjW
 TsS0mrF8B3olAxF9dKUSABo1AMW6YYKvuDhKvNLOMa01d7KRJeJvgN1i47vW2DA04X1ganY1dZt
 pqhl7+RHaSPgu8rlvjWJ7h41Y58/ABN4jyoOgrsi/69MnRYPXbS9NMK73hdjIdlA1z0bMJN30s7
 FBR4eq0v1xMe/ZfbTVCy6HRn/BAjWqsAlZFq3AH8Gn/WdnRcZJeOa7Hwzw/46A2SOFhXw58NYfA
 h0DCirbcmzQ/W8RWEpMFrop5R8b10Q==
X-Authority-Analysis: v=2.4 cv=a9dpNUSF c=1 sm=1 tr=0 ts=68a8241d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=udGWdZ-Mnbz566dSa5EA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

This adds various atomic write multi-fsblock stresst tests
with mixed mappings and O_SYNC, to ensure the data and metadata
is atomically persisted even if there is a shutdown.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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


