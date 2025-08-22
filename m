Return-Path: <linux-ext4+bounces-9562-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BAB31139
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F6723BEB02
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA12EE60A;
	Fri, 22 Aug 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q3smdvy4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2D2EACE1;
	Fri, 22 Aug 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849775; cv=none; b=AtHuTCuEB1Vaw7ID9+drya1WuannTJsD2Xv5pg7ZajahnZR3Kr8zKWcrg1uRqCsNIJQR/A7YaCOPTgffFB87M4RUrnnFu5V3VTWqUAcMqr59uRUdfgsXUAQ5//6T07eQ/t1Td6gUCgvrN5pMX0eWIifs/HXvTBY+0xo7NZvYkbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849775; c=relaxed/simple;
	bh=g3w21KjqeY+mdjFwZ9JmSJ54JRxkKppYSjcHP7SC0QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOaU8xYasYZP6AWGP3znHmZJMcPGxR2u/V2f8EIMyQb5eXFT62eoCabCl0RiZbZHhzw7lipUkDF9LLb72rtCOR/5AfSXqf6cj/CX+IeCKyH1ALEplD81Wsw2whBWvqgc1MFJcLqrPVnRpOXqz4GVFW3NwRlZuLpwppN6wYz1e44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q3smdvy4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7UCLG017413;
	Fri, 22 Aug 2025 08:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rKMKSgqvLMQ8HeyFG
	FDgfgVrcaGypQx2FC//nyy1y68=; b=Q3smdvy40lL++Zpvc4SHOBK0zDEwZGnMI
	UpTq/xSrOpznrPPTMpXm5Yvaekcaa53ODOy+SUKV3g2Tf+JR08CYFaZZBd8qpdR5
	i5qNeQysEeH1gcyE53H9KR28U3ejAX9Ny+zciwWDLJMS/qG8kgRs1MmQW7RMW7zN
	nwX5Zs8LLK0d1b0rv/iMKWEXNfxpr04zmXXtlx+tJDj6yABbUrri91TbNdMSZtjQ
	rs4YWIxP3ftHaWYjdQU9XJjIFLWisbIdvri+tdC7PNmWKe6l0jSbGmsj6bDO23lw
	WK37vsJLwQMeSFW6va1W2Qvllw2V2/5C+wakK8XOVbP4ZvVXfZ+Yw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw9ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:46 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82jGC006388;
	Fri, 22 Aug 2025 08:02:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vw9et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7hftg024279;
	Fri, 22 Aug 2025 08:02:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43vajc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:44 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82g1G20709790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB9F820040;
	Fri, 22 Aug 2025 08:02:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AA9920043;
	Fri, 22 Aug 2025 08:02:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:39 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 10/12] ext4: test atomic write and ioend codepaths with bigalloc
Date: Fri, 22 Aug 2025 13:32:09 +0530
Message-ID: <5a39bfbbd73f8598e9f85fb4420955c8a95c78a2.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: c7Eefrw8S_dwePmhjRpFHSCWG3n-NJz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX+a3cDKvr6wLs
 ey7/YSEANsAhRDBprsluqxbWhkwM/CHsUfPiYYoAapTp2QbFRXyJuDZ8BHmP4zVsK6LO2H82EcK
 KDrJeogC+LilbP5u3+kvQronSxMYCnNbYucEM8F/stca2oiaAKzRSGCq6+s6LI/3dMbE/aiLzzH
 fMmJaVWpXJEFHBSY9nFRDCQS+wptLdlMUpXPkaeMD0CMOBKaxIggEIS3vqvCjigKu4HI8pUeia1
 swb1gecESMydfPospncp1b5FfFgC4k3PXMvKqfXUiVAM7HWw6Xc4juelwmfJEzPr04cne3ib9SW
 TnJpJQmPrxIdlTORMilYGqn+jgyMBrtzFAeVoDmy32hBEIdrue6AKfm34HMKJ5/XUvx/42zZepQ
 HuJytDPXUA8Flvn/OGm+8vFzszrQWA==
X-Proofpoint-GUID: ydLOqbuDgKa7FgZxA-RBrwHg8R3WzikW
X-Authority-Analysis: v=2.4 cv=KPwDzFFo c=1 sm=1 tr=0 ts=68a82426 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=KekteOT-tD_VQUBAREkA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508190222

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

This test does a lot of parallel RWF_ATOMIC IO on a preallocated file to
stress the write and end-io unwritten conversion code paths. We brute
force this for different blocksize and clustersizes and after each
iteration we ensure the data was not torn or corrupted using fio crc
verification.

Note that in this test we use overlapping atomic writes of same io size.
Although serializing racing writes is not guaranteed for RWF_ATOMIC,
NVMe and SCSI provide this guarantee as an inseparable feature to
power-fail atomicity. Keeping the iosize as same also ensures that ext4
doesn't tear the write due to racing ioend unwritten conversion.

The value of this test is that we make sure the RWF_ATOMIC is handled
correctly by ext4 as well as test that the block layer doesn't split or
only generate multiple bios for an atomic write.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061     | 155 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |   2 +
 2 files changed, 157 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..0ccf9f69
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,155 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# This test does a lot of parallel RWF_ATOMIC IO on a preallocated file to
+# stress the write and end-io unwritten conversion code paths. We brute force
+# this for all possible blocksize and clustersizes and after each iteration we
+# ensure the data was not torn or corrupted using fio crc verification.
+#
+# Note that in this test we use overlapping atomic writes of same io size.
+# Although serializing racing writes is not guaranteed for RWF_ATOMIC, NVMe and
+# SCSI provide this guarantee as an inseparable feature to power-fail
+# atomicity. Keeping the iosize as same also ensures that ext4 doesn't tear the
+# write due to racing ioend unwritten conversion.
+#
+# The value of this test is that we make sure the RWF_ATOMIC is handled
+# correctly by ext4 as well as test that the block layer doesn't split or only
+# generate multiple bios for an atomic write.
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+_require_fio_version "3.38+"
+
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100*1024*1024))
+
+# Calculate fsblocksize as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+bs=$(_max 4096 "$bdev_awu_min")
+
+function create_fio_configs()
+{
+	local bsize=$1
+	create_fio_aw_config $bsize
+	create_fio_verify_config $bsize
+}
+
+function create_fio_verify_config()
+{
+	local bsize=$1
+cat >$fio_verify_config <<EOF
+	[aio-dio-aw-verify]
+	direct=1
+	ioengine=libaio
+	rw=read
+	bs=$bsize
+	fallocate=native
+	filename=$SCRATCH_MNT/test-file
+	size=$SIZE
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	atomic=1
+	group_reporting=1
+
+	verify_only=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_write_sequence=0
+EOF
+}
+
+function create_fio_aw_config()
+{
+	local bsize=$1
+cat >$fio_aw_config <<EOF
+	[aio-dio-aw]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$bsize
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
+
+EOF
+}
+
+run_test_one() {
+	local bs=$1
+	local cs=$2
+	local iosize=$3
+
+	MKFS_OPTIONS="-O bigalloc -b $bs -C $cs"
+	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
+	if _try_scratch_mount >> $seqres.full 2>&1; then
+		echo "== Testing: bs=$bs cs=$cs iosize=$iosize ==" >> $seqres.full
+
+		touch $SCRATCH_MNT/f1
+		create_fio_configs $iosize
+
+		cat $fio_aw_config >> $seqres.full
+		echo >> $seqres.full
+		cat $fio_verify_config >> $seqres.full
+
+		$FIO_PROG $fio_aw_config >> $seqres.full
+		ret1=$?
+
+		$FIO_PROG $fio_verify_config >> $seqres.full
+		ret2=$?
+
+		_scratch_unmount
+
+		[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
+	fi
+}
+
+run_test() {
+	local bs=$1
+
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size
+	max_cs=$(_min $((16 * bs)) "$bdev_awu_max" $((128 * 1024)))
+
+	# Fuzz for combinations of blocksize, clustersize and
+	# iosize that cover most of the cases
+	run_test_one $bs $bs $bs
+	run_test_one $bs $max_cs $bs
+	run_test_one $bs $max_cs $max_cs
+	run_test_one $bs $max_cs $(_max "$((max_cs/2))" $bs)
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+create_fio_configs $bs
+_require_fio $fio_aw_config
+
+for ((bs=$bs; bs <= $(_get_page_size); bs = $bs << 1)); do
+	run_test $bs
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/061.out b/tests/ext4/061.out
new file mode 100644
index 00000000..273be9e0
--- /dev/null
+++ b/tests/ext4/061.out
@@ -0,0 +1,2 @@
+QA output created by 061
+Silence is golden
-- 
2.49.0


