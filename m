Return-Path: <linux-ext4+bounces-9934-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CA1B53A1F
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55E7B7B87E3
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CE436CDE4;
	Thu, 11 Sep 2025 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GcDuIt6f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F3A36CC84;
	Thu, 11 Sep 2025 17:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610880; cv=none; b=FKsDm1L+k0Wrm/vTZ+ghIz0X/50ndi+dhC4Sl00Uwybokx6pnxj8nhA2ImYvg4b+JHlMTmgW8YavVauz6XnYirjIl4Xq3bh5arU2WWtgnhh1KPFdmEclfzUhcXsMLoLUIika+CFbMz+CqtqwLvovsRoVu+/NcX4vKh1RBXaIq3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610880; c=relaxed/simple;
	bh=/dAIy0nEihrCd/H2CLq+qnSEnaJT7cWIBOh5/Pwnnmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEotfrmOkmmWgnLlq/jH6mWtL/ze7CM6/lGRVKnJL0pAKajE9Lay9mCbxLyRjJ1B/3BtwD/Tae8u6grVE2KrANci4myjXR8jfPZ2epSNRh0twXSB0S9vcWEtwn1uudQsYc+NviRZzm7LvX1IIPIj7/nt2jRJQANwrEjKuo2sHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GcDuIt6f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B7qqbx011724;
	Thu, 11 Sep 2025 17:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9DamNFw+yvGG3nqW3
	SMA+ylj0WVex2u22K5E7mhw8/o=; b=GcDuIt6ft9Vwt11UZv/izCYB9VeOge2nY
	5tpSlipR9uyBPGOo+AN8oyiMPDTAj9W8MsXGGJPYeSkO1q2rBZgvNCFJVE4wOTG0
	Xm4JuNK51JQmOV3JbYeW5XxwtggxtX/h8dgFD7W3bRdplScePMkZ9ssPodwm9cHp
	KUoT2mfoqjk9diX2so9muIKibbOUOhTYb6wNU4I42eRQTv+0q60flwVxpBS08jv5
	wCmEBcvpwKjaT3WBgr7QJXbkR+5GRUqmswVxz2iV82uHRA69NOsEEIvgHkwHqZI/
	RufUm0iPRHMiZk/JVwDsn6MLCb0BmnjL7isF1KMXphRfn52lC0CWw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydb1aq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BHCk5n000615;
	Thu, 11 Sep 2025 17:14:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xydb1aj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEOVXs017181;
	Thu, 11 Sep 2025 17:14:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmppqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:14:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHER5u58392860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:14:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D77E120040;
	Thu, 11 Sep 2025 17:14:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6129320043;
	Thu, 11 Sep 2025 17:14:24 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:14:24 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 10/12] ext4: Test atomic write and ioend codepaths with bigalloc
Date: Thu, 11 Sep 2025 22:43:41 +0530
Message-ID: <79f496bc075a9fe5e2778e1433e4ffd1c8ab678e.1757610403.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -7k2JEyt3o0ubTlbzHPx8Eu_LztEPdHs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX3n284ruYq2Qz
 2tvs8JOQakCLVM9DHmBnSZXJvoM0IRqRpofOtJX0+T09co22SN765V1euJgTj/gd+PEjbhhQ+di
 KaXNWnCbOgv6yRSfD7nSN6M6AR7KHM92y/eNsPlOsQfo6SHtp5ETeo8qrYrFwUfUWEYbbOjtYJj
 qD4PmZOdyA+WGseJotZgmJfJWibX3TfuSzYCEgO4uwpqLcXkSKrRgkRwYEs5ORvoMQH1mH3rm9a
 nVMEPdv543EFA5VhRwgzU0GIzNJFRKbFgmZFnZ6B4nDBGjYoLZEVrGOEACafwpC9xi4lErvmEc2
 9gugDMIMDJbbvgILJUIQbzUS/uDoG2Wf1kw6JfQLH0C0ErJVt0PXaZfz+Zy4SXNYV1zNENUDOpF
 d2NgvOyP
X-Proofpoint-GUID: 1O0yTUJJx2VnzXnSJ6maKuNHMObj6vRA
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c30377 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=KekteOT-tD_VQUBAREkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061     | 155 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |   2 +
 2 files changed, 157 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..1d61c8b0
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
+_require_fio_atomic_writes
+_require_aiodio
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
+	_scratch_mkfs_ext4  >> $seqres.full 2>&1 || return
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


