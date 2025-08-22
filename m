Return-Path: <linux-ext4+bounces-9564-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEDB3113E
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DCDA0682D
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EBC2EFDB3;
	Fri, 22 Aug 2025 08:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aD3BK0lM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C702EFDB2;
	Fri, 22 Aug 2025 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849782; cv=none; b=G+xECOMBTtP8CL42KbhdLkqKzhIFPfD9DV3GeQKCYqyTQAZ30SKLKfJhSsExzVPRtP70uD66PBzqY9muVtjknYPUua7BNkCjKK7z6P34/6qBRfNWO+4TW0SRaFneQXabFT2WNx8bdTiWhbSFd3XMVb7qtI3I4W7M0UuyepiHzE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849782; c=relaxed/simple;
	bh=oaKqYHlsVtfa1zZFOpdl1nzBlYmVBXPTbCPK/8lQQq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsclmI4zExvVa+iWhZ39wlkB8P5xj9lDmXpC8tGzcixoKT9+KaT7XqF4Hg/rHrKtQorB/FoDgQzHbT+GupDXuoh6AMfna5/FiHeDgA1cHMerphM0mKDf4y1yp7pVx25cFOqQyixoyEForoCCHzMG452g5nR+tYqoozHqxSLNiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aD3BK0lM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7cxER026013;
	Fri, 22 Aug 2025 08:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c/tYPpUPqg61RgADq
	IE5QLIuPAEA+t+uU9KouQvjvHE=; b=aD3BK0lMGr+NYB/tnTq96O8rkl6Tb8FkD
	GUQH8ZZLbvmrQX3RRMM7wzVmm5EPHW+XNuTUBIDDyCmKESo0J2a4s3B90D0CLxOg
	vtwQ1okLkz+lMDkc3ESRFrUISOFqQWMPvplwVmjl5YBprDN+JUnGC+Vj/I/5npm0
	Mzo2iUe43Zb46G8SdB/GiRB+Ab8rRs4vYGfbbcU6E0vwTAWNse9yuB1wfa9KEJ1i
	6BnT1lVCffCePRH2rXbhUncUEg4Pmc9NCozcNMfV9ToDZJezQ58OEu3z3JriThSI
	FYKn2e7JUquksCo3fLoRCsIH9xack0IKzV9eRi2lCRBIoURA/qPEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnbs0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:52 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M7qQL7008128;
	Fri, 22 Aug 2025 08:02:51 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnbrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7woeu008761;
	Fri, 22 Aug 2025 08:02:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my42cafs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82muM51970336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 161A32005A;
	Fri, 22 Aug 2025 08:02:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B374420043;
	Fri, 22 Aug 2025 08:02:45 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:45 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 12/12] ext4: Atomic write test for extent split across leaf nodes
Date: Fri, 22 Aug 2025 13:32:11 +0530
Message-ID: <370b882f57455e2ca5d7568a26aa5d6ea068ffd4.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX7NstifbbIyyc
 FPwQeIMeNM5ybkydVcgNMAJYf6iIDftL5ydF41gTCS+k9oYh6AwJlZR1crg2O3g92PS6IYYK57d
 XzXnCY8uP8DCWjXO2agCNtq1WsuHv03CgJ4kkjAWjPkGmG8Iv1U7qh1gPoaIGt8Cit4Q2xh3Zp7
 sYo5rINC6KvvzZGOlHZt78wEExcyb5GUcLw602CAWZVCpRJW/9jg6oeEL+iiD5UqlhdtQaf/YNU
 293ZfwyeWwbYGn+qK9r7dHWupHs8ZDU4Tn/A89cmEKBzqFptzljJg0U0VcI+kkXwqLlImjgeE5R
 DS924O7Hc2Ffy7Ky+6eXJrbvfBdTUSBFGArK19btvW9X6vUGdKJM8VOnjRmi2tGM+9jmGwwYlMC
 Epi/jza71exiPszA9HjkpMiosOHJUg==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a8242c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BtNrGSYHu5IGmLxdGZgA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 0nSw54AFiHO5mtnIvUgqRaWhPlTloyFL
X-Proofpoint-ORIG-GUID: 1CKuFpzvUubDDZHmqxvfygvChOBhLR3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

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
index 00000000..19fb611b
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
+echo -n "Data verification at offset $torn_aw_offset suceeded!" >> $seqres.full
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


