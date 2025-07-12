Return-Path: <linux-ext4+bounces-8952-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1A1B02B45
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C350B188B7BD
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EB0287278;
	Sat, 12 Jul 2025 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLTSc3pa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F2284B56;
	Sat, 12 Jul 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329607; cv=none; b=nqhLJ6uEg+YofNGp0NuGuBcch7xQ/w4/ccOZ5ud6svuNHXBgT8Zh+9ypiolgTFgn5/GIQO9oPMFovYcBfmCO9qL/rvXOXWlBK5UmMUPdrY7NQtYLHxcx6wieXzOnl08NSVG5K3VpCNWOdD940o6q4aHXa/OArXcKbX8hqrhxiYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329607; c=relaxed/simple;
	bh=NbKJl4MIkBjbKokRgks+75U1IqsVpspVnPb0d087uRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsG2WJhxc0nl6JX6Ko3cPOi9mdN4QKy6tT1a4NIFnUEmhh5hkRCc+wkqsawHlCJZC+lCCAijU56ViVW5pC6aINLxa9xkdEgdZ3qp/Wh1b0DCA8Em8C6gCSwbVCseu8TikCj5uQxZ97uQiczG9mIzs7DTVmn5aGM/McsMlNyaidY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLTSc3pa; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C2wLYO005951;
	Sat, 12 Jul 2025 14:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rT9EgbiIW9JY2UPbN
	E2nI/jlnTr+TgFGnm5C5P1lbkk=; b=WLTSc3papKwPjvsBOdYjGSNc7LJpOe4UR
	fBNl/9xNY5Glf1XsK7q1oO5cnBVKJeJlp1ocTx66C88Is3t3FDkGdiG4PzJHU6AO
	UvHa/ZK/TCr2ToNTeTQHFr4FWdNbmhpICXLwIjQhJBNtrkh4lGJT/3jeFV59O3/u
	aYaZGUBJbp3HexECWAHRBkpsgh0jVFSTC9ezrYe1pwEjfbVXNqsUiYEuh+mJwBl7
	cfA7PeLkwLER/IH7tc223omSM11h3wirQ4k0tR8p6Ee9+bSjHwkeIuo8/E/T+1IC
	RSaOWEyHiYrEBe1l/qXEWUBuOfv8J5voyqDwC4pIMCxKkXJ3EE0Lg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufcysr7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDIb4008429;
	Sat, 12 Jul 2025 14:13:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufcysr7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56C91GFZ010841;
	Sat, 12 Jul 2025 14:13:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0qk6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDErO35521154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D289520043;
	Sat, 12 Jul 2025 14:13:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEA9020040;
	Sat, 12 Jul 2025 14:13:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 06/13] generic/1227: Add atomic write test using fio verify on file mixed mappings
Date: Sat, 12 Jul 2025 19:42:48 +0530
Message-ID: <f2d4a366f32ca56e1d47897dc5cf6cc8d85328b4.1752329098.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J6iq7BnS c=1 sm=1 tr=0 ts=68726d7e cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=ZzjZKRc1KEgCYT2eLxwA:9
X-Proofpoint-GUID: vQXvLn4qNjY_a4grMjnswC7N7woNlctU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX5zNynLNRfb34 dnNuOLGOJmdvoEof9O0hyHsnDYOkQ6JE8SWLiAV0RpWG6OeQCzJURXqE/PF7O9/1aLJbXbqvERC ouKgbbL+/9kp/TORFdO11YNPKnHdwbhlKX/S/D/2KdJ0u81ov5ghHn4mCZkAmjzD+gTCYgvXdPI
 DlNsyxvTmP1O+/bP6RV19/XpYzgQcnpbWoTzeJG/coMSV3XR0pLBSKexP8SEq+5h16kTOOMsQwz Hkp02rxowNS9cyiJZ8NMzwxXTwWjeqdRspOwu4pseWOV0kDyeibqVLCTAulYMx4fusI351m0UmT aNK/fJHkirn9+kWZw7p2PYp6YE9Dn4eu0uP9VM0J0S5NKUq0PkP39/m0B7UFEVZYfQuskWNwgEv
 7MkdzpIRLTiTJ6KTp+BgPk7jW0BskI00a4KWqQ2ffa/QK3gor5XCgNDWRGGqI94luLguhLmH
X-Proofpoint-ORIG-GUID: amrTx6z_leAjrOAm5_agPxdX2t6vVbfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This tests uses fio to first create a file with mixed mappings. Then it
does atomic writes using aio dio with parallel jobs to the same file
with mixed mappings. This forces the filesystem allocator to allocate
extents over mixed mapping regions to stress FS block allocators.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1227     | 123 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1227.out |   2 +
 2 files changed, 125 insertions(+)
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out

diff --git a/tests/generic/1227 b/tests/generic/1227
new file mode 100755
index 00000000..cfdc54ec
--- /dev/null
+++ b/tests/generic/1227
@@ -0,0 +1,123 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1227
+#
+# Validate FS atomic write using fio crc check verifier on mixed mappings
+# of a file.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_odirect
+_require_aio
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
+
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+
+fio_prep_config=$tmp.prep.fio
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((128 * 1024 * 1024))
+
+cat >$fio_prep_config <<EOF
+# prep file to have mixed mappings
+[global]
+ioengine=libaio
+fallocate=none
+filename=$SCRATCH_MNT/test-file
+filesize=$SIZE
+bs=$fsbsize
+direct=1
+group_reporting=1
+
+# Create written extents
+[prep_written_blocks]
+ioengine=libaio
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+
+# Create unwritten extents
+[prep_unwritten_blocks]
+ioengine=falloc
+rw=randwrite
+io_size=$((SIZE/3))
+random_generator=lfsr
+EOF
+
+cat >$fio_aw_config <<EOF
+# atomic write to mixed mappings of written/unwritten/holes
+[atomic_write_job]
+ioengine=libaio
+rw=randwrite
+direct=1
+atomic=1
+random_generator=lfsr
+group_reporting=1
+
+filename=$SCRATCH_MNT/test-file
+size=$SIZE
+bs=$aw_bsize
+iodepth=$FIO_LOAD
+numjobs=$FIO_LOAD
+
+verify_state_save=0
+verify=crc32c
+do_verify=0
+EOF
+
+cat >$fio_verify_config <<EOF
+# verify atomic writes done by previous job
+[verify_job]
+ioengine=libaio
+rw=randwrite
+random_generator=lfsr
+group_reporting=1
+
+filename=$SCRATCH_MNT/test-file
+size=$SIZE
+bs=$aw_bsize
+iodepth=$FIO_LOAD
+
+verify_state_save=0
+verify_only=1
+verify=crc32c
+verify_fatal=1
+verify_write_sequence=0
+EOF
+
+_require_fio $fio_aw_config
+_require_fio $fio_verify_config
+
+cat $fio_prep_config >> $seqres.full
+cat $fio_aw_config >> $seqres.full
+cat $fio_verify_config >> $seqres.full
+
+#prepare file with mixed mappings
+$FIO_PROG $fio_prep_config >> $seqres.full
+
+# do atomic writes without verifying
+$FIO_PROG $fio_aw_config >> $seqres.full
+
+# verify data is not torn
+$FIO_PROG $fio_verify_config >> $seqres.full
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1227.out b/tests/generic/1227.out
new file mode 100644
index 00000000..2605d062
--- /dev/null
+++ b/tests/generic/1227.out
@@ -0,0 +1,2 @@
+QA output created by 1227
+Silence is golden
-- 
2.49.0


