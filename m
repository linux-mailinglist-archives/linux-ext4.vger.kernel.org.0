Return-Path: <linux-ext4+bounces-9312-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34632B1FA30
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E214177AE9
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C426CE36;
	Sun, 10 Aug 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lD9bpZVQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E472126B0A9;
	Sun, 10 Aug 2025 13:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833348; cv=none; b=WrnQwUTADe42CfMzbnlHc+O1wjuIIg2o+0Me8szXzp9O8Mw6OJ77BVSPZ8pARnfScCW3OVPVtK2FiYGbdSFjYrMDdKN26GVC1BsIQWHjjq9gUE/nnIDFOBUQ/buY4VxkR2XuY47vkbX95DECzSG8BNNPxVHEbaI6h0uer3FFFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833348; c=relaxed/simple;
	bh=+qeVIYKnwwz47UXPhCGvi3XbtVygUZqBgYxQmHU1pW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmig8bxEQAU1ZTeDOkacFWIq8uuUC3/htsOWrnP0tfpjZK0YtwcuOGpQpr1A8uAaZqhSVXpKKgl2davHDQVQukYgFpjPqDgDhMa+f0QWB/1VA2qS/7eVW1uczMQ3oJKzfvf4dXc0j2pbor18eCnH6mJIQf8Cjs0PD3qVZkRC55Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lD9bpZVQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A5KRwJ031106;
	Sun, 10 Aug 2025 13:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=J32fgvwaJN5e1OPuI
	SrC9tvkTy13J/GzTIvPrXn0Pco=; b=lD9bpZVQfbcq7Wx4iyIVSyomgaNrHxJfT
	WLO3ZpArzjp8BK2mLuJM4trvjHDa7mUK3NBFf5gpEmXTweZFScYyfcdBvWo+gEFT
	UtcZknKfmFHny8Qvb+R1rmwUETFly0+nB+0sgFag+LZD6IARqbpoGzJdP9jPL/jJ
	Jh2KxeyjoK4ofxfu1ecMZzHIUYd7IaeN0YOduJ0rur9uwORS5xysxEgJIo/f4Z7B
	g+Wu0accdzEFd8NdTDPNagFDrYXgT3G7dCNPgtjobiuVxRsjhDDtRcrJGtaKvDDj
	vM4ugRtYVZHYkx8UJOwBktf4GSfhKqxC9TlTD7NSDjrxzQM7gTxfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:19 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgJmP006980;
	Sun, 10 Aug 2025 13:42:19 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A963ol017606;
	Sun, 10 Aug 2025 13:42:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc39nee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgGOg44826942
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE8520040;
	Sun, 10 Aug 2025 13:42:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F85820043;
	Sun, 10 Aug 2025 13:42:14 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 04/11] generic: Add atomic write test using fio crc check verifier
Date: Sun, 10 Aug 2025 19:11:55 +0530
Message-ID: <783e950d8b5ad80672a359a19ede4faeb64e3dd7.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: CNIrG4HopbdaEGioj8F1BTg1Qv_yxp-K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXwlxz97p5tDGF
 M+cfN9djfMEGu2mX3FRFuqv/COspOMGQelmdRCm2saK1bU9ZLL9+h5NbLcmaOOpdcAUeRDxThHb
 wU0iJl/moKHZFAGHo0PLaWa0kuRz3PLOQDkFRnecQaHvSvZPK9eVhbCZqVl+smCcKxSnX7U/LVy
 0fEBc5ZKNC8FT3NwNxcGXXImFJm4R/fVQrY2PWaKByDjV3RV6rL/MlZw8zvncVKyibOY0lOQ9IY
 PGaJexh7Rt2jS+sYLX96IJBYADPiB5VY+cXbEStoQ43JbS8ixA+EZzYjmsQnEkz7mkCaYM3qo0H
 KXRoZpxEBCuGmO53ORW/4z3hB9JXUfOxpLUxj2UYCkTxu1KUJFE8Id74hllI+2SOM5xwrYS1w+R
 Vt5cktu5x/GedMowSHlFvTA2gJ6eadR8MG9CJMQI1rOUE23sC8/HvkPEBtu5pbPeToxh10ZU
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=6898a1bb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=TDUsxBfbQoAVH7yvDjsA:9
X-Proofpoint-ORIG-GUID: vsoPwVvazyk1EMLXzeKiEm58YMB7VB23
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

This adds atomic write test using fio based on it's crc check verifier.
fio adds a crc for each data block. If the underlying device supports
atomic write then it is guaranteed that we will never have a mix data from
two threads writing on the same physical block.

Avoid doing overlapping parallel atomic writes because it might give
unexpected results. Use offset_increment=, size= fio options to achieve
this behavior.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1226     | 107 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1226.out |   2 +
 2 files changed, 109 insertions(+)
 create mode 100755 tests/generic/1226
 create mode 100644 tests/generic/1226.out

diff --git a/tests/generic/1226 b/tests/generic/1226
new file mode 100755
index 00000000..efc360e1
--- /dev/null
+++ b/tests/generic/1226
@@ -0,0 +1,107 @@
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


