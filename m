Return-Path: <linux-ext4+bounces-10263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820A4B880EE
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8087C0E58
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4602D77E3;
	Fri, 19 Sep 2025 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LZaQA80U"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA272C2356;
	Fri, 19 Sep 2025 06:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264542; cv=none; b=rK3KnOXlrrD80YKgf8JWoxnsdGuHzctsmuJKwF7lrvTO+cE9sK/lX9qkBFe07oUkMIh1XmFBc0ihG34ljFQvOEjSfzzdIZ9FuOd2W2kroEArX5dAj2hb4lEjLaTcjEvW6gozk1i/PLGa3uvDGvbY0tYtFlEjxgqFC7eWZBrCGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264542; c=relaxed/simple;
	bh=/dAIy0nEihrCd/H2CLq+qnSEnaJT7cWIBOh5/Pwnnmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jeKMris6wdQrqufpq1CdojgzDKTgFP2t428iYFUK7hzA50nVTZUHriTh20t6MvGp/1iR9HU4RwBHw49Wok7oaTVH32csom4mBonXlBC+uBKDa7eo0j4LsGIhGzDH1ULUCLLB/hSjs/0FY/9eWrOY4eUvGktW9DUNmDSffot5qjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LZaQA80U; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2U8X6011266;
	Fri, 19 Sep 2025 06:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9DamNFw+yvGG3nqW3
	SMA+ylj0WVex2u22K5E7mhw8/o=; b=LZaQA80UsR90BC2VFJiWN3mV9giiIthh1
	QvVQNixUqaeeqp9TBUNGvY1dWxvqumKTM0Up4SKmXy4f7my02oRR9Asvmpp6OQRm
	kU8iLuta2qAz3ZyONRpCdB+HKLt8e5ZCQgqk06VAvr5an5QCaNRDrlHqC3yYUGTg
	ywRDEVCJwyRiSLt7kl9Ir4T977uT8e76bWNkF1bDcrHGt/r+QCd5412icsh+IghM
	lyY9FXHFCl+8k+5S/bTBNzd9wBqWNvAn0xV4TVdVVC7zAILx5cscbaiJBdEV1DXS
	usQstxNJSfiEmRActihFyCTGb0/wXelVz4HL2/5iL7wLYoAmf4wPw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6jvJt023032;
	Fri, 19 Sep 2025 06:48:52 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4npbvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J30khW008987;
	Fri, 19 Sep 2025 06:48:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 495nn3t9x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mn6Z56558058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 536E120040;
	Fri, 19 Sep 2025 06:48:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 300E82004B;
	Fri, 19 Sep 2025 06:48:46 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:45 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 10/12] ext4: Test atomic write and ioend codepaths with bigalloc
Date: Fri, 19 Sep 2025 12:18:03 +0530
Message-ID: <a48832c898f5346630040da68ea86cfabff1b364.1758264169.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MN5gmNZl c=1 sm=1 tr=0 ts=68ccfcd4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=KekteOT-tD_VQUBAREkA:9
X-Proofpoint-GUID: uLWUbRL3MUXTw19gY0UjD8hcJtOhgd1K
X-Proofpoint-ORIG-GUID: UIctzot_ScCafPkOo147-Q95M9C7fBk_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX6aioTMEJaAAG
 3AdSrauEne0QrC5dX6DpmFFn/Dc5vFYC5V8haH0DeYtXFC5KEVfB1aIZUZt6bTKHu0EWJbl395Q
 iE413jfree2qsGiRPoZJ32sIYROaIhxxIWpzuI9lBSe2weZ1zQq1Q5PE6m7GQG/R1x9KY+eQrhA
 5OdPZ+z628zmAKByF4YpNrTzwwmwSuGqmOTXwKNR9LXqCMMfLfrZmtJAaf3cL4+EsWCkhATjmEo
 NREmTRJ62tJLun+lURb+fcgHNKdLw3bdL63cd5oRmioYoImBWSsWkrYgzylcA23JOICQL52M1+N
 5an/lk8bGoD6mxxhScxBXZYWzllgv2xz7/bCNWr52nAFyWI4R53S9l64isGpZW3ganY5MNHIz53
 1VbkBAL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

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


