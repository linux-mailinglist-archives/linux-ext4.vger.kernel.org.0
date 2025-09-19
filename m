Return-Path: <linux-ext4+bounces-10264-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0BB880E2
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827B116693A
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08412D94AD;
	Fri, 19 Sep 2025 06:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dixeyOKm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16DC277C95;
	Fri, 19 Sep 2025 06:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264548; cv=none; b=VjKQUe+57da4rtVexuKK2lkhAj0n+Lyy9TD3JNlDwvu5ObDdpDJFBKalJuv2xsr/cgD/Z7qHJLwW792hxEARr0fVUmWieZkxOFB/8yDhkuc/D72hwqX+7f5aBFjX0q/e7X/aawYv89Z51F7u71nT/SBsYjv6kFtQ1ZDrvThhfsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264548; c=relaxed/simple;
	bh=/23TnMcmUpdflLUBR/TKi4uqya8y8NfSo8bYiPAZYPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdjLPEmJRUXuk6HcTD9qkxVHqnKBACpBeeNQwKkhY7vzh1yExbpZluLxVKTUXC6XbxHzIlgyN33HrtRdrmu3DdScgoE1OBEvYfUwVXyxMPl1/hp1tz8pAvj/ranY1yKihinGKYHTbDzR4klIhP/yMrag38cgV4kVJ2uvkQuby2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dixeyOKm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58INLuSD023783;
	Fri, 19 Sep 2025 06:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vRTNUGKdoq8A+YlHn
	I5gzyY7Rjkkw4gAzlowW/XKnQg=; b=dixeyOKmFhOlH03bWANFowZ6qWNru7M0B
	4l4Ep41RmoJS9wYH9jhbBbtZrKnCpRXIuCPqqUP91ZcAhy/yl1v5tepV5cmt+dyS
	MH5+G50FdpXyqeg9ER0xETAaWMd5vgd+mjge2ngyip4qtNu+jYYPvdoZIMWuYLJs
	pF6LVVRXAtIrRA5stwxunm3o4qM5HWIHPsEBUy/3nviYxTLHciU6Tdf8s12bl8ls
	sfjNO7ERV6HmW2IK3D2nvfE3SYKxU3i5zxJjEAkPziEfjl3ggxBCg35HSoVL89OM
	fCIK6POyOiGCipA4qRBRLK8lLP6gBwtmQlivfYuCBdx2zeCQxxO5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qxatp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:49:00 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6kx81022278;
	Fri, 19 Sep 2025 06:48:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4qxatk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J51vwm029468;
	Fri, 19 Sep 2025 06:48:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kb1atr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:58 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6muNb56558066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71ED20040;
	Fri, 19 Sep 2025 06:48:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEBF220043;
	Fri, 19 Sep 2025 06:48:53 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:53 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 12/12] ext4: Atomic write test for extent split across leaf nodes
Date: Fri, 19 Sep 2025 12:18:05 +0530
Message-ID: <721505bb10ec191d93f0612f5ad98b864ba5c980.1758264169.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: wm3CUYiP2jcwdxdBnktZHmOUjCLCpJE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX+dEkyR9DnSsM
 ivR3pqJnB5O5F3egjsOokko1KlRm/StTwbbiZjFEqKAIBt7t/M+KBNm6CeC/iSFtlnFpweUSRKe
 CNIzmt2QzAQuyHGUNFfD3Ad0bfnsQn6FXlkojp9l0+RhYcxIuCqmAYuBsUwI6Hf2B7g0oKYWSLn
 h8BddfsZOSKUzFXSAcjBFVsX5/lAjR7PLz8BTK7qykJJgJXlnj726WDie4RkgHQo+Zp9UBpP4l8
 eKzhq0GaYAKklM8mwrBHXC/TcvOhm3zggtgXvlJuGAaREHJLsvCovN+/PqrLo2XphdQm9hOpH6W
 aw0nPD06sdjVYyJU45rrtmr6ccOIiHaBYbj6DvfHppn/4ujEwP2fAdc1lLJn4LYSoKBTUDbxepy
 jow2iNFL
X-Authority-Analysis: v=2.4 cv=R8oDGcRX c=1 sm=1 tr=0 ts=68ccfcdc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=BtNrGSYHu5IGmLxdGZgA:9
X-Proofpoint-GUID: L13-LolBoW-NPJ0NajznfdqwYExF1W6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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


