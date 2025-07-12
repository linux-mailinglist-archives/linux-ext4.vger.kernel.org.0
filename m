Return-Path: <linux-ext4+bounces-8958-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6674CB02B57
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0471AA2364
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3A927FB2A;
	Sat, 12 Jul 2025 14:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BfjF9u7W"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81827E047;
	Sat, 12 Jul 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329647; cv=none; b=sL0okDnQpb4K/cIa2ku0nbE5+jfO/KNBPFGBUSspwQcuKXw3CnKzjy/1aZzbq45J51cNndt3Y4fmMJmSKBoQlPbGDMbkL+Al1MKvWP8hYUAtVuxubq34Zo1gP8+v5LsnUZQ+BnNTyaPm8YOMrFYAwLaNG3qRpkpUHcrmZedCmg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329647; c=relaxed/simple;
	bh=KNrAQHgMsXhyOwPfV9u/T0Jg4bGopTaJ35cfz1MUYuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYd/SdhIMWSG8jE5iOyshW1crI/4xH5cDtnE4+ajRFF/I3hi2UxNL0K8E/zbgvnDCfViGu7NJG5XA7juoB/QPx6X6lVTL0Ar1GMK7xwYwrgj8Z/nlN86IOMOP7EXWbt14BdJ/HzE8xhgz/n2RImmfnzhDXhFnHLnXMSzTTRVJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BfjF9u7W; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CCwcta031931;
	Sat, 12 Jul 2025 14:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/HrkyBHl/xr+a469M
	1SoZyj2BKanRPoZvRyiqaCwunU=; b=BfjF9u7WsH8OV+iqk8CBJmh/qICPDneKF
	HQMk9Vm1LGvYCrc3gfBM9XP1sFdEqe6IS/Z8N3zgzYC5j8QQYE5KIPuorQE0w9lo
	JU5drRolIs0fTldDDWnczweuR1ut+JopmfxUjo2N6HQ5/j13sOqWt5q2/k2EG9bt
	4pqBHOpx88qWM19o2UdZsNiRWUVwT+cYkMb2fGtcqmwMSQtNmM746xo54LR/tX6p
	EUKmv4XrEeoTSgjPxJjoemBTagrBniLZ0DpBiqQrBtK/kyyYJCf1EfhLj8NKLHeV
	d6t+C+mrg8QChHF1QL75/1j6p2ReXiTDj0JYxbYyL9Uq6wtM76xiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeehqvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:31 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDUuM031405;
	Sat, 12 Jul 2025 14:13:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeehqv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56CBdNON013616;
	Sat, 12 Jul 2025 14:13:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qgkmf65d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDS2n18481612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5838020043;
	Sat, 12 Jul 2025 14:13:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19CEA20040;
	Sat, 12 Jul 2025 14:13:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 11/13] ext4/062: Atomic writes test for bigalloc using fio crc verifier on multiple files
Date: Sat, 12 Jul 2025 19:42:53 +0530
Message-ID: <0116498a542ba9ea9026b2b61ad747eca31f931d.1752329098.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX3VBEYmIfO40y 4J8D/pu03m/sfmH209oeigTuMnbNP3TnXAGND+LG9lXxC1i6nuf3gyLWRFVJ7TyZds1Xlcb0rwP LmKgx/JXJHkKblGMPquNOJqDLVimlBKkSL/QUadmtSz/NXQ+2cs0ld7Bhp82yis2Tm/RIsDJJLA
 DZ+SDtEGTnFAVlHB0EJe/iZ2pwnmHQulPzbbdDLgzYUqA1kN0aa1nMVyHK/mdLrq3anFwc3c4Zp fbXt7oTyiTj5BmK2NKJgHKO61NYGmt6xv9pgMWvxe1l3lEydzp7YvlYoyT6GlEcn9hEP27iq1MH qDD4CybmVxy5mHGG8FhjT1JnPNzjpQr01fbW+6SUL4RCMop3B6oQhxj9mwVqL++nacgCOkBsOBa
 doqhoug5KrssOuLol5NJ4phoQWUMmOHM9+VW9OSTuixzCsg92N87MljQAriqsmvi3jc5FIw0
X-Proofpoint-ORIG-GUID: Bn_q3_yU56Y9fED776peuyFyy11fk7qw
X-Authority-Analysis: v=2.4 cv=C9/pyRP+ c=1 sm=1 tr=0 ts=68726d8b cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=yVCtIWGlblad6CDWSz4A:9
X-Proofpoint-GUID: qKwxC4nF61vVidSZYV87Wfu-Xi13qJl2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=991 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Brute force all possible blocksize clustersize combination on a bigalloc
filesystem for stressing atomic write using fio data crc verifier. We run
multiple threads in parallel with each job writing to its own file. The
parallel jobs running on a constrained filesystem size ensure that we stress
the ext4 allocator to allocate contiguous extents.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 176 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 178 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..85b82f97
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,176 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. We also create 8 such parallel jobs to run on
+# a constrained filesystem size to stress the ext4 allocator to allocate
+# contiguous extents.
+#
+
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto rw stress atomicwrites
+
+_require_scratch_write_atomic
+_require_aiodio
+
+FSSIZE=$((360*1024*1024))
+FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
+fiobsize=4096
+
+# Calculate fsblocksize as per bdev atomic write units.
+bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
+bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
+fsblocksize=$(_max 4096 "$bdev_awu_min")
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
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_only=1
+	verify_state_save=0
+	verify=crc32c
+	verify_fatal=1
+	verify_write_sequence=0
+
+	[verify-job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[verify-job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[verify-job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[verify-job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[verify-job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[verify-job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[verify-job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[verify-job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+function create_fio_aw_config()
+{
+cat >$fio_aw_config <<EOF
+	[global]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
+	fallocate=truncate
+	size=$((FSSIZE / 12))
+	iodepth=$FIO_LOAD
+	numjobs=$FIO_LOAD
+	group_reporting=1
+	atomic=1
+
+	verify_state_save=0
+	verify=crc32c
+	do_verify=0
+
+	[write-job1]
+	filename=$SCRATCH_MNT/testfile-job1
+
+	[write-job2]
+	filename=$SCRATCH_MNT/testfile-job2
+
+	[write-job3]
+	filename=$SCRATCH_MNT/testfile-job3
+
+	[write-job4]
+	filename=$SCRATCH_MNT/testfile-job4
+
+	[write-job5]
+	filename=$SCRATCH_MNT/testfile-job5
+
+	[write-job6]
+	filename=$SCRATCH_MNT/testfile-job6
+
+	[write-job7]
+	filename=$SCRATCH_MNT/testfile-job7
+
+	[write-job8]
+	filename=$SCRATCH_MNT/testfile-job8
+
+EOF
+}
+
+# Let's create a sample fio config to check whether fio supports all options.
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+create_fio_configs
+_require_fio $fio_aw_config
+
+for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
+	# cluster sizes above 16 x blocksize are experimental so avoid them
+	# Also, cap cluster size at 128kb to keep it reasonable for large
+	# blocks size cases.
+	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
+
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+
+				touch $SCRATCH_MNT/f1
+				create_fio_configs
+
+				cat $fio_aw_config >> $seqres.full
+				cat $fio_verify_config >> $seqres.full
+
+				$FIO_PROG $fio_aw_config >> $seqres.full
+				ret1=$?
+
+				$FIO_PROG $fio_verify_config  >> $seqres.full
+				ret2=$?
+
+				_scratch_unmount
+
+				[[ $ret1 -eq 0 && $ret2 -eq 0 ]] || _fail "fio with atomic write failed"
+			fi
+		done
+	done
+done
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/ext4/062.out b/tests/ext4/062.out
new file mode 100644
index 00000000..a1578f48
--- /dev/null
+++ b/tests/ext4/062.out
@@ -0,0 +1,2 @@
+QA output created by 062
+Silence is golden
-- 
2.49.0


