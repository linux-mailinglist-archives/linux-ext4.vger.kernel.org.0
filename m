Return-Path: <linux-ext4+bounces-9929-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBEBB53A16
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1612167A30
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BA436996F;
	Thu, 11 Sep 2025 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fx3esfge"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2F369341;
	Thu, 11 Sep 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610861; cv=none; b=L42xeB+97tG8g3bTViR2AACyDmenZdAbLGGkOdONee10Yj3Hc1oLO8m2AYSvxpEzCHQ4/6oiPUY3Rv9/9of5RJu8gaAOI1LXyArbCUXM2/fi83wgXNtetFxsPVQgGkm3+tMzjBH/vHxDC04YMvNjcnsCpcwmtIPjz4hfbZf553E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610861; c=relaxed/simple;
	bh=v26UflPQnu2h2Q5+BBo6b3eR9y7md2rK29p0D+NRWAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTn7x/dl2REXUNczRPKQID1TDRAK1Zyho/uJWNrp0tGrECW4RbmYPDfRbrEgPRi1ClE1v6fIiN8k0+Mhg0uXYVLj8n8Jo75CkwGPI1xLbYw358PrQM/vh8/RY1JtKPoVjCHnaQdIyMdN973268G8GlNFU4+vMOCsg4tifhyVbKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fx3esfge; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDhJKp009660;
	Thu, 11 Sep 2025 17:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rZYDWIxNta4tNx7sM
	Hsk5+3wUSG6W0FYsTLTVuBCzOs=; b=Fx3esfgea2YMexvvS+Msd1bFFU9eho9KQ
	x65HZZ8ruz/qZLyyIjwjc+xE+L0hFGm1l6+liqLdFd3eIggSP5jfxk5i2mwwYdcM
	mBHtfEjrZppjsRtP/eGFtBLNUEmwN0a+ZB01HHtrt+TUxqO7VR6hrXXToBl8NPHZ
	XHHuHR2lEcliGQjpZKWmq9b+IXlSUn9unZx9zBWdjVQJUrmYKq//TdLNIQN/bRSf
	e/QL3khtptbxC6HKSRBV5eRUzjWD2EKTDtQ3/LbWLq4MAxtiUh1uWb0t9cH5XCIQ
	/aKJ63yGK7bUyn3G5AUHdSJaMUwP9E8ti0NAsmO80p37br/4WBL2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:10 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BH9HCY026022;
	Thu, 11 Sep 2025 17:14:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEF4iG017172;
	Thu, 11 Sep 2025 17:14:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmpppt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHE7Tt61669810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C672A20043;
	Thu, 11 Sep 2025 17:14:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 810A72004B;
	Thu, 11 Sep 2025 17:14:04 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:04 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 05/12] generic: Add atomic write test using fio crc check verifier
Date: Thu, 11 Sep 2025 22:43:36 +0530
Message-ID: <38047ca73eb768e5fc71bc640185b1c0a032e40a.1757610403.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: j-ZVafVNBa7doXfPW8QzxacdSuTN8vwQ
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c30363 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=TDUsxBfbQoAVH7yvDjsA:9
X-Proofpoint-ORIG-GUID: RAmvoPdIzeRoY8bl0d-PKUcV8OXCjIME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX6LHyvnOR4CwM
 s35ryb9EntFIfGf4DXkwmv0CrPLPIIIB3tzcPaJM/MeOLJxWZX6VIW29h84ZPmGCkrPF0JdA/aH
 Sd0YhwR2gzVfTx0rWLOqw6BHEvEtM1+Dh281OJOat+Yr9KElXzVl9L3l1V/VhCe+rEBAesNGG1M
 mj4l365DAKa0W9rHEXGMeuOqb+3K7a72jCbIzarrT9LE4606aaaTPwkKdnwKckJtyxaV9ZxXP0I
 9AiR/XeRL47EV6sQkIUkoBtXAh04uFGA587rzsBnIW6ULDoJ9h8/MHr6Qz/xifu5+tMH8JrjC6l
 TWD8+6XRcdr6lutGiaN4PCuAWwNK2Nn/kwbUmfd+g/HrUYHVEazPAUiZuzlJryi16qAXV7WenSB
 zsT6/7Fh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

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


