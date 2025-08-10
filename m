Return-Path: <linux-ext4+bounces-9319-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B7B1FA48
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A96188BB80
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51A42798FF;
	Sun, 10 Aug 2025 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eh+Axr50"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B1E27932D;
	Sun, 10 Aug 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833367; cv=none; b=WiUSOheP+bRducJ+nsruEcADRyJm1IEIp68tSvx/1td/F6P59u/JAXdmVSuXhOAtcuoqsz1wTsnkocHBICWu7i10KUuUzt3mz3tYZrvk0cZeI6z2G4bDP7q1NnIP5TRyducCKEfQOIOAYTyUuKVucmiOYUi47nW42U1kvVXhtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833367; c=relaxed/simple;
	bh=gmaBm0x7uDbdmIXG5IfwG/w+jWZjkMAjllytUqcjUBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQ1aDttRvEMYL7VopgEhFJafrCO3U0UxeqUpK26vN5sIpcLXPGYOdkdmSr4zTF/qGoHd9Lza9B8+aLUfLOS9CfwtnkfYhvuaKbYkMkGhzQ71jc9ie1ScaaOXYfp29i0vszdRUYZwdN3Z9i3O6UZJXyTHek4SVNX5rFHY6/Jd3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eh+Axr50; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A3jCU8030469;
	Sun, 10 Aug 2025 13:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0IjariK8pY14h7+X2
	4bWSkvksl0nJpavjJtDkM8wVT8=; b=eh+Axr507KOyKuL9J2wu1GlZNAYkbFfbu
	R7ogdjUeRquixBrfUTi1htgSYsE9bM/4OQXvin7WJGsdagcfu5jSvlgrb4CHZxqo
	baUjqVBaw5FygAe1lWeKrXuW7BTmT8+r4dt1EIfSgqzTNsYr1GOnBIV1dIYdGVhf
	KK4mip/Tya1DFYzK9rbnM/iGZqi86tzPM9djwXwOT1+2Rt7NnLnVIzS8rzjsuYsZ
	Onr0EyPyJ3lzA3/nvm+fHGYVcuM5pcTDZIpGZlz3P1i2ZQKHCWq8ywCXgQv/xDP8
	/xymsP0O7IvypS/o0xzF+Kp8qaJ7ZBWa4oDwVYMmPmWNP0MLgZ2Kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cnb4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:37 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgbWl013788;
	Sun, 10 Aug 2025 13:42:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2cnb4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A9ApPL017581;
	Sun, 10 Aug 2025 13:42:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc39nfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgY2429098598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A2F72004B;
	Sun, 10 Aug 2025 13:42:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69CBD20040;
	Sun, 10 Aug 2025 13:42:32 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:32 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 11/11] ext4: Atomic write test for extent split across leaf nodes
Date: Sun, 10 Aug 2025 19:12:02 +0530
Message-ID: <2c241ea2ede39914d29aa59cd06acfc951aed160.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXwqhnm0fuu3Yj
 FUFaXx/o8z3zpAK+/aiqXE+KsslYQkZF/cvkSZaauco1lIZHbug/OUhl7pdd8gswyOqzCCEKa7m
 HqtqYiFX8e5GFq5HVTlaTvT7zMwIqedEGe0sO3LIPHBVFP9z4Dpwbdf1Q4eTMkzdxzgvR6dcNrS
 ZxrxHU+18VYC6/UTHwTPzIZesz82PzOvzATtF4/YfnXm8Rhceosnx7DZeKK6tZlKx/ta6uJg/IA
 +0dAQgvl1/a0k2AoaEJEehtv/4X3zaPRfhmxgDfcjmNrVNjV3iYXp1nvvA+inQT7bECz4c9L6OI
 ay7xaUNWi2OXC+arpUaxxip25NU/TeRVpnjJMbVHB/FO9vZwJqjjzIClk8BuAaL0JQ5DtAGZmaf
 vQYwUZewYgS6YkFDGgDqRrSHfyu4i79OzY+PfjmgV8HIm7YG5kd5A70uP2hfOvPRaMUQbhBt
X-Proofpoint-GUID: Q73VRy-nX547rMYQyL3uRFJXu57SlkTA
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=6898a1ce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=BtNrGSYHu5IGmLxdGZgA:9
X-Proofpoint-ORIG-GUID: vl1O7FVlYpGgKqAdz-SvSJorus_rXwhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100097

In ext4, even if an allocated range is physically and logically
contiguous, it can still be split into 2 extents. This is because ext4
does not merge extents across leaf nodes. This is an issue for atomic
writes since even for a continuous extent the map block could (in rare
cases) return a shorter map, hence tearning the write. This test creates
such a file and ensures that the atomic write handles this case
correctly

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/063     | 129 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/063.out |   2 +
 2 files changed, 131 insertions(+)
 create mode 100755 tests/ext4/063
 create mode 100644 tests/ext4/063.out

diff --git a/tests/ext4/063 b/tests/ext4/063
new file mode 100755
index 00000000..40867acb
--- /dev/null
+++ b/tests/ext4/063
@@ -0,0 +1,129 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# In ext4, even if an allocated range is physically and logically contiguous,
+# it can still be split into 2 extents. This is because ext4 does not merge
+# extents across leaf nodes. This is an issue for atomic writes since even for
+# a continuous extent the map block could (in rare cases) return a shorter map,
+# hence tearning the write. This test creates such a file and ensures that the
+# atomic write handles this case correctly
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
+	# contiguous. However, since we dont merge extents across leaf we will
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


