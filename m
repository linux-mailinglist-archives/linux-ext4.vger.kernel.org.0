Return-Path: <linux-ext4+bounces-9936-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42456B53A30
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794C0AA83AE
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90FE36206A;
	Thu, 11 Sep 2025 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g7oFKh65"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4A362069;
	Thu, 11 Sep 2025 17:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610892; cv=none; b=h66XKA9AK5SnuN6fzrv1w6nos+09y/+ZLYAJUdMxs6boFUYjhNSiOLO7gjWtsNjyDH45+RqGr1RP+VEbaTFZferzfn3jDib/YzYT/zMABgDbTTDcrGNt8B40nzl04qEejZ3t/j1jIhX5nbibU2SiVvPn+56mVA6KNNaenaqWqJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610892; c=relaxed/simple;
	bh=/23TnMcmUpdflLUBR/TKi4uqya8y8NfSo8bYiPAZYPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZyRMZ7+Ug7tSqLClvwxtPnKgQ5oaeq9+ebEyKtVNE7W0QpAfqpMliMIYR1jW76cRRWAMeWzO95pC2xKkhaj5PIMJup7+PFtBksgLVkFPmqbmXYj4zGXyiM2wXkJD+xXxr4D+t9N0dzwMkXmuWtCHx7WEQgrLwP5v2Ut+Uo0E9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g7oFKh65; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B9GCIN001309;
	Thu, 11 Sep 2025 17:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vRTNUGKdoq8A+YlHn
	I5gzyY7Rjkkw4gAzlowW/XKnQg=; b=g7oFKh65f706tQETRS7T4gleRsUAX2pNz
	3OFuS66GSxg0hXXYohBQE57Zemucju8UwN7S35d+1NYkVEyc0Mkyv80PCy5yoVQa
	U/eUBbjJS3b3NMV51C72uD4VRZZ2pieiq8rofJNquE/t3gbA5vCifPryZLR/xjuR
	LQzChNtnR+xrrV5GoL6OyElEsCNBKVVUwwuDZJxqrCH6FUe0ziBU9L2lfYRMKllD
	Y7PA1TkG3s7RL/RmrdMOfsFnRQbz30CI47wUYPeiLI4cHD6hnSph+mFhareNdoeX
	//TQG7OariD2tih8rdiL/xupvZqPgbo/hjnxUYxuDmDqcgfBp8o1g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BH5MaS018264;
	Thu, 11 Sep 2025 17:14:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BFsZWT011447;
	Thu, 11 Sep 2025 17:14:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uq553-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHEajE32113302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3706C2004B;
	Thu, 11 Sep 2025 17:14:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D329520043;
	Thu, 11 Sep 2025 17:14:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:32 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 12/12] ext4: Atomic write test for extent split across leaf nodes
Date: Thu, 11 Sep 2025 22:43:43 +0530
Message-ID: <4ac353bfdf94c896345fdd308467a9666cb3d6f3.1757610403.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: A2SUQ2zU8gdMPIWg3z9EEzhwjt9p9N6w
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c3037f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BtNrGSYHu5IGmLxdGZgA:9
X-Proofpoint-ORIG-GUID: B9xwJd3nktRtiesckJVwiPCfb9yu33wk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfXxz0Gk4ElXfeB
 WNK84P68+k0tITlGE2QA+SSEvLGCnIhjFyrBVU/+GhkH214lPjhxZUCLrd2EDs0HxEMRTdm7Xx4
 sAbFl5JyWshz1Kf1ivPuRYjrg7VVaniHS9041ciTJsjzAZdU8frFKFUFMmfpdlo44DvnO6hRFyR
 47mxaoapJEYO1goT6ksIrSboNJVIF0ttNh0OiuLG7+JAFAusDLxwd+5n84WBbcb6iesGiPdu4hb
 NoerEo15LcWXvBD1hJTI2wE2JPgnJjNYYA59yIb4YenSrlXCzAw7kKhLXaI0j19mIEXFsU0q5ZF
 6zbGtI4GeI0eP5fJQ3SBhwHhkb1hKZaTg9N9GbdXrd/F8ivFsV4GmeRWzWppNoJUZg/loE0YGdA
 7pLENdrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

In ext4, even if an allocated range is physically and logically
contiguous, it can still be split into 2 extents. This is because ext4
does not merge extents across leaf nodes. This is an issue for atomic
writes since even for a continuous extent the map block could (in rare
cases) return a shorter map, hence tearning the write. This test creates
such a file and ensures that the atomic write handles this case
correctly

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/063     | 129 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/063.out |   2 +
 2 files changed, 131 insertions(+)
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out

diff --git a/tests/ext4/063 b/tests/ext4/063
new file mode 100755
index 00000000..9d6265a8
--- /dev/null
+++ b/tests/ext4/063
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# In ext4, even if an allocated range is physically and logically contiguous,
+# it can still be split into 2 or more extents. This is because ext4 does not
+# merge extents across leaf nodes. This is an issue for atomic writes since
+# even for a continuous extent the map block could (in rare cases) return a
+# shorter map, hence tearing the write. This test creates such a file and
+# ensures that the atomic write handles this case correctly
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+_require_command "$DEBUGFS_PROG" debugfs
+
+prep() {
+	local bs=`_get_block_size $SCRATCH_MNT`
+	local ex_hdr_bytes=12
+	local ex_entry_bytes=12
+	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
+
+	# fill the extent tree leaf with bs len extents at alternate offsets.
+	# The tree should look as follows
+	#
+	#                    +---------+---------+
+	#                    | index 1 | index 2 |
+	#                    +-----+---+-----+---+
+	#                   +------+         +-----------+
+	#                   |                            |
+	#      +-------+-------+---+---------+     +-----+----+
+	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1  |
+	#      | off:0 | off:2 |...| off:678 |     |  off:680 |
+	#      | len:1 | len:1 |   |  len:1  |     |   len:1  |
+	#      +-------+-------+---+---------+     +----------+
+	#
+	for i in $(seq 0 $entries_per_blk)
+	do
+		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
+	done
+	sync $testfile
+
+	echo >> $seqres.full
+	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
+	echo "...">> $seqres.full
+	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1).
+	# Since this is a new FS the allocator would find continuous blocks
+	# such that ex(n) ex(new) ex(n+1) are physically(and logically)
+	# contiguous. However, since we don't merge extents across leaf we will
+	# end up with a tree as:
+	#
+	#                    +---------+---------+
+	#                    | index 1 | index 2 |
+	#                    +-----+---+-----+---+
+	#                   +------+         +------------+
+	#                   |                             |
+	#      +-------+-------+---+---------+     +------+-----------+
+	#      | ex 1  | ex 2  |   |  ex n   |     |  ex n+1 (merged) |
+	#      | off:0 | off:2 |...| off:678 |     |      off:679     |
+	#      | len:1 | len:1 |   |  len:1  |     |      len:2       |
+	#      +-------+-------+---+---------+     +------------------+
+	#
+	echo >> $seqres.full
+	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
+	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
+	sync $testfile
+
+	echo >> $seqres.full
+	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
+	echo "...">> $seqres.full
+	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+	_scratch_cycle_mount
+}
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount >> $seqres.full
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+awu_max=$(_get_atomic_write_unit_max $testfile)
+
+echo >> $seqres.full
+echo "# Prepping the file" >> $seqres.full
+prep
+
+torn_aw_offset=$((torn_ex_offset - (torn_ex_offset % awu_max)))
+
+echo >> $seqres.full
+echo "# Performing atomic IO on the torn extent range. Command: " >> $seqres.full
+echo $XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
+$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
+
+echo >> $seqres.full
+echo "Extent state after atomic write:">> $seqres.full
+echo "...">> $seqres.full
+$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
+
+echo >> $seqres.full
+echo "# Checking data integrity" >> $seqres.full
+
+# create a dummy file with expected data
+$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp >> /dev/null
+expected_data=$(od -An -t x1 -j 0 -N $awu_max $testfile.exp)
+
+# We ensure that the data after atomic writes should match the expected data
+actual_data=$(od -An -t x1 -j $torn_aw_offset -N $awu_max $testfile)
+if [[ "$actual_data" != "$expected_data" ]]
+then
+	echo "Checksum match failed at off: $torn_aw_offset size: $awu_max"
+	echo
+	echo "Expected: "
+	echo "$expected_data"
+	echo
+	echo "Actual contents: "
+	echo "$actual_data"
+
+	_fail
+fi
+
+echo -n "Data verification at offset $torn_aw_offset succeeded!" >> $seqres.full
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/063.out b/tests/ext4/063.out
new file mode 100644
index 00000000..de35fc52
--- /dev/null
+++ b/tests/ext4/063.out
@@ -0,0 +1,2 @@
+QA output created by 063
+Silence is golden
-- 
2.49.0


