Return-Path: <linux-ext4+bounces-8956-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FF2B02B4F
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15861A48162
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79427E07D;
	Sat, 12 Jul 2025 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JYBcmFye"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B427E1C0;
	Sat, 12 Jul 2025 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329626; cv=none; b=ADg0j/huNvh1/OoaSbvNpgyYM5dtPinEL601clkVq0kYWOrRKVnUUYWeUXW0FiLNKeYcoEB3WCjH6qlpkTmXQ+WekLrEPq/aWaYcsuRVHs4dWOFTzg+We6Q2mKaEaIqRUsCZwfkbQcoR4OVik6TUVWMCe+BS08Ji5KbTjxBbzWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329626; c=relaxed/simple;
	bh=EWZ5P3hK76Z6OvtYAHftlDXYHxIiGpzvT+Filq2kvaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YPiqwyijXX4kbCiXzLBfrp3YEUkaNiA9L5tgOpqpNkDHt1squZkdAhuv96LGMEvkOV+jy4yfmEh3ArUQXAl6v0KFqO5LiboWcZPGR2/ymESboS9qW0NSV8AOJ4DVtzvdNQXQtEb6L1w4YzhWv9LfOo2B7RpXQ7MD2b/pGc+drb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JYBcmFye; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C9wska026642;
	Sat, 12 Jul 2025 14:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0Qp+LtOx7GmPwaZCz
	tYC+3HTAkC8Ob0pTvDIkziBgsk=; b=JYBcmFyeey5C5PVtBOB5r2LuuaXbkiYLT
	cELvrXh86tTU1VSltORKs09K8H6zxQOKfHS/cLG+4R+QZ+DNzzMM2gsrsoOma0E1
	KzI7DTtdnWuNez4aggiYNJ2I45DKSLdEc+CF/jdavU1FjW17eZJsFoKR+o3zF7k0
	4cVd12psBQDgyVcNN0mFBhdzPjMAP/GiW4Hl/xNfhhcEW0FZIgQwtRqV74NAV4+P
	tldp5ADgfxF7AZmBLKtB4zmIVT3Ax2aPjgjZEBM+f+w4+OMGU5M0leg/S7Cm/Fzq
	QLfgSi/xuPC+5VESPJiLoeVYmDWn0/Ghl6HzaM+l8zl88kp7J8dBg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDaGs009854;
	Sat, 12 Jul 2025 14:13:36 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CCZ2xm013555;
	Sat, 12 Jul 2025 14:13:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkmf66u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDXoE34406746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D966E20043;
	Sat, 12 Jul 2025 14:13:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70FEB20040;
	Sat, 12 Jul 2025 14:13:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:31 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 13/13] ext4/064: Add atomic write tests for journal credit calculation
Date: Sat, 12 Jul 2025 19:42:55 +0530
Message-ID: <77fb2f74dfce591aed65364984803904da9c1408.1752329098.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68726d91 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=s1tx9Ns7CSuJm8OCEucA:9
X-Proofpoint-GUID: pgtEJvlABbJuumr1DfJgI2bo07qs3x1n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfXxgm8ylP+urXk qAwz5ANPLBgnCJSpfvxccV+1H64nnIpck/5EzmhHqiQTDlxxq7qyllGj4x4XTlBIVYrWJTuus/i 52ZTDpza3m65DuB+egO2aFgXmaP8zdmTURCNlrKm45qClt1Y1cJXRns5INis+/7LAWY4SHQl+e4
 8/p1MzBIvIXHjDy122aBSpRMvrMGBIbYVvNW+T/f6m1HkF6F2/ShCJa/5HQTE3Gg4ObuGTyyyer j+YU6gJw7pgdoajEGkNKJ3UOpIYb8IEOmKuVA/2GCn+y0y3kNQdXMG9NKqE9HfSgrJiU2pGFWPB +xC7Ax8LQEqtClIhkQwRQwcXWxyQCHI5L9fnRwy4bL9x2lL9mqGxp1VBg6gSxnOI8YyInHiLVEd
 +AloaB92263am6Ru4y8mvsv7DX1u9O2tvADNn6r7bfhL2tD9PHGG6gB/ndLvmtDrMtGLcguM
X-Proofpoint-ORIG-GUID: 1XC8Tw3vG4vd7dXU-Fghyt3WBvMrZ3-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

Test atomic writes with journal credit calculation. We take 2 cases
here:

1. Atomic writes on single mapping causing tree to collapse into
   the inode
2. Atomic writes on mixed mapping causing tree to collapse into the
   inode

This test is inspired by ext4/034.

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/064     | 75 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/064.out |  2 ++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out

diff --git a/tests/ext4/064 b/tests/ext4/064
new file mode 100755
index 00000000..ec31f983
--- /dev/null
+++ b/tests/ext4/064
@@ -0,0 +1,75 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 034
+#
+# Test proper credit reservation is done when performing
+# tree collapse during an aotmic write based allocation
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest auto quick quota fiemap prealloc atomicwrites
+
+# Import common functions.
+
+
+# Modify as appropriate.
+_exclude_fs ext2
+_exclude_fs ext3
+_require_xfs_io_command "falloc"
+_require_xfs_io_command "fiemap"
+_require_xfs_io_command "syncfs"
+_require_scratch_write_atomic_multi_fsblock
+_require_atomic_write_test_commands
+
+echo "----- Testing with atomic write on non-mixed mapping -----" >> $seqres.full
+
+echo "Format and mount" >> $seqres.full
+_scratch_mkfs  > $seqres.full 2>&1
+_scratch_mount > $seqres.full 2>&1
+
+echo "Create the original file" >> $seqres.full
+touch $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Create 2 level extent tree (btree) for foobar with a unwritten extent" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
+	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
+	     -c "fsync" $SCRATCH_MNT/foobar >> $seqres.full
+
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
+$XFS_IO_PROG -dc "pwrite -A -V1 4k 4k" $SCRATCH_MNT/foobar >> $seqres.full
+
+echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy >> $seqres.full
+
+echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
+$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
+
+echo "----- Testing with atomi write on mixed mapping -----" >> $seqres.full
+
+echo "Create the original file" >> $seqres.full
+touch $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Create 2 level extent tree (btree) for foobar2 with a unwritten extent" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "falloc 4k 4k" -c "pwrite 8k 4k" \
+	     -c "pwrite 20k 4k"  -c "pwrite 28k 4k" -c "pwrite 36k 4k" \
+	     -c "fsync" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+$XFS_IO_PROG -c "fiemap -v" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Convert unwritten extent to written and collapse extent tree to inode" >> $seqres.full
+$XFS_IO_PROG -dc "pwrite -A -V1 0k 12k" $SCRATCH_MNT/foobar2 >> $seqres.full
+
+echo "Create a new file and do fsync to force a jbd2 commit" >> $seqres.full
+$XFS_IO_PROG -f -c "pwrite 0 4k" -c "fsync" $SCRATCH_MNT/dummy2 >> $seqres.full
+
+echo "sync $SCRATCH_MNT to writeback" >> $seqres.full
+$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT >> $seqres.full
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/ext4/064.out b/tests/ext4/064.out
new file mode 100644
index 00000000..d9076546
--- /dev/null
+++ b/tests/ext4/064.out
@@ -0,0 +1,2 @@
+QA output created by 064
+Silence is golden
-- 
2.49.0


