Return-Path: <linux-ext4+bounces-9318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C875FB1FA46
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9050318869C5
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F098D278E67;
	Sun, 10 Aug 2025 13:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ScAiz6GJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F382777E8;
	Sun, 10 Aug 2025 13:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833364; cv=none; b=galmk1K3aSoXkTEtHelIdgja2/4LDaYYez3REF35W/K8KTeaU5ij3wOvClOTGbfcO7mdASmOVawNnIhYwlumOBw5DVjEbC/aOLQBgBCgMrEzIZ1r5KVmRQ4zub4fjnddiwbJMkCmPJQ279vE1j3g2jsac/qI9LJFcJLlccUnH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833364; c=relaxed/simple;
	bh=a8+l/vQCVd7zvGymmqioCgbO00ixsS34NRSk50oKXGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJHI5xjFRcGrLKjc9wzaAvC9RDFNwnx4FIrxSjY0IUfYh6u8/DXF/vR8c9VKT08vzXRnRxIFxcgyMsWRk5U/NHNu9opMsqSpTBh72qWDyIw93Us/fNpukmwvr+/KIemqKrNUSlBNvxnSLJFFwKknQdcOjLCYhoFOzwwKE3G9YD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ScAiz6GJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A7jQxV032216;
	Sun, 10 Aug 2025 13:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IjNJEN3tswwPw+vKz
	Dpz+GmwVdM6YneETCeOAS+DPLo=; b=ScAiz6GJdsJFupNOmynah+5Fk7xixlc04
	SYhMAPAigErr9eGzKegvZv/J9uVaDw35fIsCrLHejj80cvEAt4iI1tC7z1yci87V
	+dJIfBpZHBhAuJQtadIFiLvV/02NFg4bwJB6iPKvdGgOavYmoutrJzhyg2xFJs7P
	sQPepyAS8HBOfKhTHddXSWSJcADBwEjunztkeVeFVrBStDmaPwrCXnsczVsq++gZ
	EGpgNOSPhEMbNB8r1s/oDagbufQ93SAB2A+fVKPUBTMvGF0+AaSf/9J1weDryDDC
	P7pfI0GlQti/JdVpeSZZXQfA4/pqkOC31lGWY8AjnriduXNvS3pQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx145b1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgZbb021347;
	Sun, 10 Aug 2025 13:42:35 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx145b1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57AC0Vgs026275;
	Sun, 10 Aug 2025 13:42:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh20t4nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgWrv46334240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 057FC2004B;
	Sun, 10 Aug 2025 13:42:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E85D20040;
	Sun, 10 Aug 2025 13:42:30 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:29 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 10/11] ext4: Atomic writes test for bigalloc using fio crc verifier on multiple files
Date: Sun, 10 Aug 2025 19:12:01 +0530
Message-ID: <48873bdce79f491b8b8948680afe041831af08cd.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: xzEFJrD-pyhVh85Bb_wWln9DZmGQsAC0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfX/UnZalWhXx1J
 Y6iqbb7xktIRYuDaCubrw/wVmBDUkPGI2J8UHfMcN667Q2xGqqmNmObsnAoExkDHdYZTGL039M2
 xn8SsZflXh/7YS3COXcOJOQeDZVbPcb513+D9Yhv7DDgFjtaiiaYvCEaUxl8mF3AGbT1FG1RSxH
 Yyi7EZHFZP6yvLXQrcq+wpHmy3r9QylsbgokajD4FjgBuFYCLN/f61x9hkJyByIlw20RoQi5vkH
 gq89Ld1F8aElvy3WKBcDb/M5zA9Fsrfzc84q02uw64ctA82X2Vgd9s7MrMi07kDIXs0eL/jRmR3
 sPnRrtozvyO1dlsOW+elQDKVfeDdZSdmy1eQtP6PEjvs65dC1MI1jD+liNCcBbBfYBfQrQ3JeYI
 4Vw2n3Jf1a9Oulmq/LKk0QZSl3+3ruJu1Mzath2AQnVjd4bLYkDyoRmcNvd0Zqq4sb/o2soJ
X-Proofpoint-GUID: -IkvSt6TVQfCjNwQVxfB-Y5BGPGruG9U
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=6898a1cc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yVCtIWGlblad6CDWSz4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508100097

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Brute force all possible blocksize clustersize combination on a bigalloc
filesystem for stressing atomic write using fio data crc verifier. We run
multiple threads in parallel with each job writing to its own file. The
parallel jobs running on a constrained filesystem size ensure that we
stress the ext4 allocator to allocate contiguous extents.

This test might do overlapping atomic writes but that should be okay
since overlapping parallel hardware atomic writes don't cause tearing as
long as io size is the same for all writes.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/062     | 176 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/062.out |   2 +
 2 files changed, 178 insertions(+)
 create mode 100755 tests/ext4/062
 create mode 100644 tests/ext4/062.out

diff --git a/tests/ext4/062 b/tests/ext4/062
new file mode 100755
index 00000000..da5e1076
--- /dev/null
+++ b/tests/ext4/062
@@ -0,0 +1,176 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 062
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


