Return-Path: <linux-ext4+bounces-9556-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB99B3112A
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A264B1CE7376
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2092EBBAF;
	Fri, 22 Aug 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnWmEWuI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B2B17BA3;
	Fri, 22 Aug 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849760; cv=none; b=FiGEJXKVPgXpu8qoyH9T6SgzMWU4Lcov2zsniXgm0L769gTh2EuRw9ASYggc0qrjSrYDHBXPjhn/l0uIaOU1zyywJX9PeeBq4xONg0I6f8kn7P67YITb/6fIKe0/Mo7b33oYKsLKLVHMVep2KDr0Y0MHTCV3SDMigK0ydZSdemw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849760; c=relaxed/simple;
	bh=1Zv5IS2OEvsc1CKEUq7+MH1dZdSqezFI+uP8i9Vi4oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mlIXjcBcsH1USHDyn2oRutRAoI26GjpKe8nwzpGtIWE151T/20ga80f6JklYsxb/qmqVUvTJQNYa/J6WhYdxQGUsFZWvQoBeWjQybKoTVy76TT/3FDg6a92beoE+lxU8IAR/jfWCIe6uSCxlAej+v5NZUjchc9GWm0BbxRDLPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnWmEWuI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LKhJRe012171;
	Fri, 22 Aug 2025 08:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5CB5aNgIhq1p3l6D2
	7WH6MDjxvFiRVYR09zhXrF2E5E=; b=cnWmEWuISpHcTUNBNdilLfq0zLjwL5q39
	6ImS3qkHmHP6cA7HoPAtPibEuMxwfxoaEvyeQIZlVOQFowvGGqMI402juoOnsaJp
	hh2YTtdYFyigYVTxL8HZSdDDyUzz70gxT5kFJ+phIyGLGl9ZiwBFbh7/Fm6UZ0p6
	4JEDFfjf9He7C79b6Vo4sgEf+1BwIF5KhS9/W6dF1wxikIH68jpSC88HbfNlCIVi
	Ngeah7zzEWp0OX719lumXz6/zWu7pGsy+f6ZxLkQcDHuUP1QR5TmhluT5liM1/Gn
	dEiFnh/tJEYb9IhIeraRLerMjeFpAKVqvFK4nyc/8E6Bxd80kcqAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnaxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:31 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82Vj3010348;
	Fri, 22 Aug 2025 08:02:31 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnaxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7dJR2016047;
	Fri, 22 Aug 2025 08:02:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my42cacu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82SLh20709776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8241F2004B;
	Fri, 22 Aug 2025 08:02:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13A3920040;
	Fri, 22 Aug 2025 08:02:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 05/12] generic: Add atomic write test using fio crc check verifier
Date: Fri, 22 Aug 2025 13:32:04 +0530
Message-ID: <90241ec96d84e6e87d8cf8bd0d0d75fcc296757c.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: U5r_lrmHFMLHvoCrNeKlwncZMwkiABg8
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a82417 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TDUsxBfbQoAVH7yvDjsA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX0/LaShGk/rgI
 zdx2Q5dqP8In2Qaccy0XTrxFNqYPUVZDNrTziKuxW1vqzbIYk2Qx10VQkeX4yUjrqEc3R6eEhIx
 ou+YgOVHBWsWRxh/i8LItvl4fdQDIOi5bTDpXRv0E5HiUlOobFoUiRhQ7gwmUclZ3uaaEPiLaR0
 PO3pmENPTxBCA34NL9fMo0FdPY9sr2kfwTYoObUZUkGwBsrXEjc8l10xJ0f/seiyzsqzlDADI2S
 GKEbA/2Omrk80cqCVPLMBfz3wBols4zKTJzmrg13Kgg/WsN7YKULR8EEBm9eR+JYb4045KT49IJ
 ZTfllDi+DILWcaPtxaDGHeTRpBlzWOMzJzXGbdXVy+j6LRTpUim92wQU1gushQxyScS+sO17L3p
 elgXZl8JDqaR3Vs4NBwejvDEsQhTRg==
X-Proofpoint-ORIG-GUID: 0FV5Qu1ubGrCdpfBVXmPrtCOfFuk0lJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

This adds atomic write test using fio based on it's crc check verifier.
fio adds a crc header for each data block, which is verified later to
ensure there is no data corruption or torn write.

This test essentially does a lot of parallel RWF_ATOMIC IO on a
preallocated file to stress the write and end-io unwritten conversion
code paths. The idea is to increase code coverage to ensure RWF_ATOMIC
hasn't introduced any issues.

Avoid doing overlapping parallel atomic writes because it might give
unexpected results. Use offset_increment=, size= fio options to achieve
this behavior.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1226     | 108 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1226.out |   2 +
 2 files changed, 110 insertions(+)
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out

diff --git a/tests/generic/1226 b/tests/generic/1226
new file mode 100755
index 00000000..4584f062
--- /dev/null
+++ b/tests/generic/1226
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1226
+#
+# Validate FS atomic write using fio crc check verifier.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic
+_require_odirect
+_require_aio
+_require_fio_version "3.38+"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+_require_xfs_io_command "falloc"
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+
+blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
+threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
+filesize=$((blocksize * threads * 100))
+depth=$threads
+io_size=$((filesize / threads))
+io_inc=$io_size
+testfile=$SCRATCH_MNT/test-file
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+
+function create_fio_configs()
+{
+	create_fio_aw_config
+	create_fio_verify_config
+}
+
+function create_fio_verify_config()
+{
+cat >$fio_verify_config <<EOF
+	[verify-job]
+	direct=1
+	ioengine=libaio
+	rw=read
+	bs=$blocksize
+	filename=$testfile
+	size=$filesize
+	iodepth=$depth
+	group_reporting=1
+
+	verify_only=1
+	verify=crc32c
+	verify_fatal=1
+	verify_state_save=0
+	verify_write_sequence=0
+EOF
+}
+
+function create_fio_aw_config()
+{
+cat >$fio_aw_config <<EOF
+	[atomicwrite-job]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$blocksize
+	filename=$testfile
+	size=$io_inc
+	offset_increment=$io_inc
+	iodepth=$depth
+	numjobs=$threads
+	group_reporting=1
+	atomic=1
+
+	verify_state_save=0
+	verify=crc32c
+	do_verify=0
+EOF
+}
+
+create_fio_configs
+_require_fio $fio_aw_config
+
+cat $fio_aw_config >> $seqres.full
+cat $fio_verify_config >> $seqres.full
+
+$XFS_IO_PROG -fc "falloc 0 $filesize" $testfile >> $seqres.full
+
+$FIO_PROG $fio_aw_config >> $seqres.full
+ret1=$?
+$FIO_PROG $fio_verify_config >> $seqres.full
+ret2=$?
+
+[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1226.out b/tests/generic/1226.out
new file mode 100644
index 00000000..6dce0ea5
--- /dev/null
+++ b/tests/generic/1226.out
@@ -0,0 +1,2 @@
+QA output created by 1226
+Silence is golden
-- 
2.49.0


