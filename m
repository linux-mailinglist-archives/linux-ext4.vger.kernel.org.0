Return-Path: <linux-ext4+bounces-8957-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB79B02B52
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1A5A481E0
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FE827F009;
	Sat, 12 Jul 2025 14:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fjKPOK+T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D3827EFE4;
	Sat, 12 Jul 2025 14:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329646; cv=none; b=A9mCKbQC9Y/dSazxwaAxG7R8M7hMy2ii+fU2L+913c3h3/kt39IHjKoj1/0b9PdBQl59GWoaWWMMg5KqBL1MSaLHsMYHup0rZH2ylinVwzXWnWrYZ5GhfiXWdksQ4IoV1v4Bvb1XSls18NFmAgJuOVBOLNUfFbGgF5Jt0CrFpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329646; c=relaxed/simple;
	bh=I3iYrD5WwI1ocmafgqtxBAhBJc+MnL6IfmTgqCCGZnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxvD+EXiGrI/j/lOIJfz7Wxu3xad0YcSD9i069bhMV1krUYkezdKnJ0TFoz/ki1fDNQizq0gazdct8KYPLJ3t+1t+D7SKiAlIOkspEHKtQZg3mhvPivlIbudBdFjDFK5YB5LkVFn+TR4Q5qs0k+xyB5/F15OWcvvjPg/RX1QTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fjKPOK+T; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56C8kboV026979;
	Sat, 12 Jul 2025 14:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Sb47yk01e7J3qOOmE
	/cujCmZTIsqm4s0zL7KCUqoS5w=; b=fjKPOK+T62PHfP50K1kzQo7GNnqoJEslF
	Z7Lc5o0AMNxy/1F2+vLRBcJS+xwz2xkY6Ug7A+YZoKXTFWFzZ16PMl9Fj84vRU2k
	0CuGuzyERxEZnh1/L0gnwkOm4eLnQOP3aAmkLAN+cEWdmpRRmLAFTdQJkyAP97oO
	q+hJ4rriWmPMGHklWYHdGV1yYdNH5j4Un6cjS2zuVbWZ22OHSoURZ8dZudrxO9uM
	voThorOzsr4wLlSaYVo5zg/YmOUE4Rb7o8sHD95rOaItNPEIOFUGHV/4bqAxj7RD
	3HYtcLPJ/hG9Yhz8YM8Sl6Q74gCiP7Az5CyXOJ5OUxfCP8/NXGZZA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st30t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:29 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDSYZ004827;
	Sat, 12 Jul 2025 14:13:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ud4st30j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56C9tMR3010790;
	Sat, 12 Jul 2025 14:13:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qes0qk7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDPPx30343694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAF9B20043;
	Sat, 12 Jul 2025 14:13:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55A3620040;
	Sat, 12 Jul 2025 14:13:23 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:23 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 10/13] ext4/061: Atomic writes stress test for bigalloc using fio crc verifier
Date: Sat, 12 Jul 2025 19:42:52 +0530
Message-ID: <9b59eb50b171dece1a15bc7c1b6cadff438586d6.1752329098.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNCBTYWx0ZWRfX5KGzAWTU3qBu N/JlvOAAzw1myelIEJyeLgEOJMjCCIkJgO73d93zY9MldqWJj9RT3l65VoSn9NW6wK3AEUhMeOu nrnK14Ip+EbdAS+OYqVKUOLjb80mloZHvqjuTd/v7jPS8zUNDPEkKHb4t2vRIN7RosfFIL+j/WT
 nPLGYKyagwPhZYAHkYdY5ECxkbVZADZxk9smyWKNRODzFbFNFGesF7KwkFhYl5dMYKIyklVGEAR S3Vn3dgx0nNmruBwn/Dm87QkwVaZijDzor3HHILpetsjPa2jTiONmnrVffehnzcKrWLa08ma6wQ rASiQnpBFJCS7BD5C4cDv6w3XGT1klLe09GgprgLbITNGewV9WmUVLfMfnSAAGfTyUTTjfG4ohk
 8rBoGaxObkvSAGpoYMlgakmCG4m03Va0HJz8gQDtn4ja6ueabAbg84BXN8oi8U3LrVXUXZYz
X-Proofpoint-GUID: bgzu00rkDSaEKEAAK2_bFebARTH_GFyb
X-Proofpoint-ORIG-GUID: Eq5_KCTouqDEGWF_fTlL_SK0fRYtfMj1
X-Authority-Analysis: v=2.4 cv=KezSsRYD c=1 sm=1 tr=0 ts=68726d89 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=jHICElQ_nnKT0EPUS5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 phishscore=0 mlxlogscore=822 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120104

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

We brute force all possible blocksize & clustersize combinations on
a bigalloc filesystem for stressing atomic write using fio data crc
verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
that we never see the mix of data contents from different threads on
a given bsrange.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/061     | 130 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/061.out |   2 +
 2 files changed, 132 insertions(+)
 create mode 100755 tests/ext4/061
 create mode 100644 tests/ext4/061.out

diff --git a/tests/ext4/061 b/tests/ext4/061
new file mode 100755
index 00000000..a0e49249
--- /dev/null
+++ b/tests/ext4/061
@@ -0,0 +1,130 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 061
+#
+# Brute force all possible blocksize clustersize combination on a bigalloc
+# filesystem for stressing atomic write using fio data crc verifier. We run
+# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
+# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
+# we should never see the mix of data contents from different threads for any
+# given fio blocksize.
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
+FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
+SIZE=$((100*1024*1024))
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
+	[aio-dio-aw-verify]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
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
+cat >$fio_aw_config <<EOF
+	[aio-dio-aw]
+	direct=1
+	ioengine=libaio
+	rw=randwrite
+	bs=$fiobsize
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
+	# blocks size
+	fs_max_clustersize=$(_min $((16 * fsblocksize)) "$bdev_awu_max" $((128 * 1024)))
+
+	for ((fsclustersize=$fsblocksize; fsclustersize <= $fs_max_clustersize; fsclustersize = $fsclustersize << 1)); do
+		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
+			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
+			_scratch_mkfs_ext4  >> $seqres.full 2>&1 || continue
+			if _try_scratch_mount >> $seqres.full 2>&1; then
+				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
+
+				touch $SCRATCH_MNT/f1
+				create_fio_configs
+
+				cat $fio_aw_config >> $seqres.full
+				echo >> $seqres.full
+				cat $fio_verify_config >> $seqres.full
+
+				$FIO_PROG $fio_aw_config >> $seqres.full
+				ret1=$?
+
+				$FIO_PROG $fio_verify_config >> $seqres.full
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


