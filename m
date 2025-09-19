Return-Path: <linux-ext4+bounces-10257-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F812B880AC
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1428A567903
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4162D2383;
	Fri, 19 Sep 2025 06:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QcAiWp3x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF92C0F66;
	Fri, 19 Sep 2025 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264523; cv=none; b=CvKFTW+xxKuLMNH6avKWQfsroQJjwxIUwPhDlDapOOLzVe8+qWeMbsqePFoNdLEAMrIycZ9bskGyPUg/fKMAKFkcX0PR5IZTREz6M6XQ9QzxP2aBbpWWRA2Pcxd8cbzhtNA8Lm3G7LeasQ9dQYdvjh5n0RLoUyIHfHl5u5iXHvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264523; c=relaxed/simple;
	bh=v26UflPQnu2h2Q5+BBo6b3eR9y7md2rK29p0D+NRWAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxU1NK3C8rgwOe1ZhxRYmeFnlno+PZ6y4QQ1/2rdIxO0z+MAmJJg3SyMfeZSq/nL7UcqvGqADLfATdRXVY/lKHhMwhzIKlnhOqSRNLgdCRG6Q7lIRHVQyqN47n5vBt/E/cDoOfQP6Lk+hgSFqMnTLIed0+bJdVOpFWTRP92WU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QcAiWp3x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5Ibxf000333;
	Fri, 19 Sep 2025 06:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rZYDWIxNta4tNx7sM
	Hsk5+3wUSG6W0FYsTLTVuBCzOs=; b=QcAiWp3x9cnGyZZBqS3/U66sCEayE/aBy
	kKkc+l8M9Rzaftpsco+2nMDNw8cTJ0qE+dEpIDY9UVAYzzmz72Bmp56Ft26uWiln
	vKvGDr2uxSqmSFQWurVs3OTaIm4M2D6agnIPMc7kWzuaWYg2pT6taJZPf4p22qxW
	UreJMT3vzjX4YDoB6zZ8gxRjDkhYmgfd6LEGLZcoXCCki3hP12Cupyx0Fhk6PaYF
	b+FHGqwoXBC3AtHn2OZGmRRgu1rS6lHhR2Y2bafRa0fs0FP18cUz5yxT7/P80w9p
	TQoWxDd5macDv0eNdRYrgLsiABlFOW1Tr0LsFj7p/NO956XuHvTWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxwe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6imam031168;
	Fri, 19 Sep 2025 06:48:34 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxwdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J5PEuo022316;
	Fri, 19 Sep 2025 06:48:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 495kxq2nvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mUHs52429300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC38A20043;
	Fri, 19 Sep 2025 06:48:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8807120040;
	Fri, 19 Sep 2025 06:48:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:27 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 05/12] generic: Add atomic write test using fio crc check verifier
Date: Fri, 19 Sep 2025 12:17:58 +0530
Message-ID: <3c034b2fb5b81b3a043f1851f3905ce6a41c827a.1758264169.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: bKpOq1dU1XUEzF1yZT7hmEKFpYVnJRE1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX5DbidT1VgjBu
 phwGKMAYMM4IZpfJrBGl6ias5CUeMhF9cV/og9udoSNhXXhHNy9Is4TSF3ea7uWX+0WLIX+1Nuy
 m0wLGbwY6JrO55TP2r88zNA110GSf7pHEzhHgyv9po+h3J9Gd9lfG8O0VzuLMRkuz2Jrpxq0s2q
 +AU4h+wu7PDIiUhpeWfIxrTl7wEaJ1rr1a+Kh78Hx4qXc1GqmQ+hqYNBnqKfnh0cPcfg62LDURN
 oEaaFF5MLbl/daK1I4zSDS78V8pmAhJoevQ5lTI/y/wbhsHZ6DgdaSR0+4Cx5+KcG0+TzTKWHI6
 KNY8kTuaVdI8tg7h9dmZX08duhgwl5cjxHoNHRVpjN5ABPRtrzdK08tDSBUsmwXbqSa+5bzRfd6
 wX2IpQwX
X-Proofpoint-GUID: WE7Y3O_XPlLqIfSLwAWYff4znxNnoFda
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ccfcc2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=TDUsxBfbQoAVH7yvDjsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

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
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1226     | 108 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1226.out |   2 +
 2 files changed, 110 insertions(+)
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out

diff --git a/tests/generic/1226 b/tests/generic/1226
new file mode 100755
index 00000000..7ad74554
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
+_require_fio_atomic_writes
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


