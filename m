Return-Path: <linux-ext4+bounces-8951-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75019B02B42
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775231AA1668
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C62853F7;
	Sat, 12 Jul 2025 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MTz6as9M"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9870927FD5A;
	Sat, 12 Jul 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329605; cv=none; b=K9jrxbkwf14asr6nQCv5QsbEXtgBTRYikrKLv6hLtcWNqCTu9NO7+ww63Bz4poYg0WRn7GGNQroI4G7A2HpObE8dfpZAfQVEgPBhH5IGMXMYx5RcAYx+IAXk5s3FYLOqpY0HxEW1X4uj/4Xl5EeuYB7XtZOQp1XmPp3DrSBs8pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329605; c=relaxed/simple;
	bh=33sNqFw/dIEXLfBV+bssmhsXLFSDEC+TSaoWvP3jet0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSc40q9MTozuR/qsbstl4Mm3YA1qXmIWips5C6CM05yieaX9fgIgnBG52YgODkjRt1H42m/QSYkrKzezDAAUUgO2Jb/iFbsqo43ujSeMOWbjBoS7l/Zrt8zJB9wK+hcrocvGe0l/TCaTHpHmpduKDJZ2hv5Hmn5G5FnhbbHmR+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MTz6as9M; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CBRevL015518;
	Sat, 12 Jul 2025 14:13:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dpo+GxVAnJKnVsHbr
	uMPnygjKAgCy7bk1yjwL0JberA=; b=MTz6as9MH0VerFuEq21S8hDC3kENw5fSO
	EuE8F02o9vFSDstWnPkdIMn9e1fAJo9bG9NiERp+qHCNdoqAHG4k8JxQ6KvJ09Ah
	S1YltDUAMq+85Rq9xZsofzPmCQwyPvUn9c6XK44Qt7TCVNZUMdNoR/c2qmLHjgcq
	TBv2gwhyhwKkgt/inhsDz++Wb0vMdk7JOExbahgbdFIsLcvAcAt/PIiww814PspO
	vgsnHdqz7M1kDma00V27WB/dGefORC2VDtorDA296Ogl9+t+vo0r5/hX2MAgy0/v
	Z3GcQAezw3K0VOLnEmwC8M60W5rIYd6NrJzMIdGIwwjCoH+8IrZlA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:15 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CE9mqS003407;
	Sat, 12 Jul 2025 14:13:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4thv45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56C8rYg9010832;
	Sat, 12 Jul 2025 14:13:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0qk6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDCNr34406734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 748CE20043;
	Sat, 12 Jul 2025 14:13:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3961B20040;
	Sat, 12 Jul 2025 14:13:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:09 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 05/13] generic/1226: Add atomic write test using fio crc check verifier
Date: Sat, 12 Jul 2025 19:42:47 +0530
Message-ID: <1e6dad5f4bdc8107e670cc0bd3ce0fccd0c9037a.1752329098.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68726d7b cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TDUsxBfbQoAVH7yvDjsA:9
X-Proofpoint-GUID: RLkQSbKDyKq2eRQvOYpk5xaOf_f92E3n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX/FS3B8SfoU9B ddy/nYnVUzuKIhQpzswmzPsbRhXLzYafQWgoAxWPcmby1UQXxDJjjThH3hdwDlcPpj4Ld8Ma8w3 F+bUxUuvleGPiSbExESM9PPyIJECu9Xm7ys2ld8etRjuTxgbMD5dDcDVSGOH+C9uHbjb/ikuAuW
 79FzAJyVHxzs38hycMgfADpxfrtJtjI2M5uhR6jayV3ou96JBLrsKZzE+2k8oD+7XCyuGGTUdjq uzOWmbU8Ut/mktvZmi6HoQFV1hCorD61N9jEuGkVpV6ZxBCgXLSSWoAT5Druy216qFB0ILypXqi hYpldXg1qR7DEiJcFdyxmg3CEe5i7J906dNet4ONvZVKSIznhRtwwBVf0kT2HLJbPFv1ZCZa+ni
 TzQZy7PHApEDG5GL0kRSHfrgrC4CtrBq2AkS+lTIQiGbARRnBQTq2o/Yi3Guzja/IHXLP28s
X-Proofpoint-ORIG-GUID: MYTLZeoP1tUSq9jCDda48dRAEi0JEKiN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=918
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This adds atomic write test using fio based on it's crc check verifier.
fio adds a crc for each data block. If the underlying device supports atomic
write then it is guaranteed that we will never have a mix data from two
threads writing on the same physical block.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1226     | 101 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1226.out |   2 +
 2 files changed, 103 insertions(+)
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out

diff --git a/tests/generic/1226 b/tests/generic/1226
new file mode 100755
index 00000000..455fc55f
--- /dev/null
+++ b/tests/generic/1226
@@ -0,0 +1,101 @@
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
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+blocksize=$(_max "$awu_min_write" "$((awu_max_write/2))")
+
+fio_config=$tmp.fio
+fio_out=$tmp.fio.out
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100 * 1024 * 1024))
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
+	rw=randwrite
+	bs=$blocksize
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
+	iodepth=$FIO_LOAD
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
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_state_save=0
+	verify=crc32c
+	do_verify=0
+EOF
+}
+
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+
+create_fio_configs
+_require_fio $fio_aw_config
+
+cat $fio_aw_config >> $seqres.full
+cat $fio_verify_config >> $seqres.full
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


