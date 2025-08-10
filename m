Return-Path: <linux-ext4+bounces-9313-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F227B1FA36
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 15:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D789018998AD
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Aug 2025 13:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E059326F46E;
	Sun, 10 Aug 2025 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OulLKpaV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8C326D4D4;
	Sun, 10 Aug 2025 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754833350; cv=none; b=YmAPq0Pra9OzCZDwd2QD6c/s11TNVNazCOj86DwVPVMCU4+1RfgWNiyLlvPDHSrTK7OToNG18uI6PCj52qgDauHIWA5kh6pfl75NFOLzf7M93hSdB/ZPAjJ99M7sY9qYjDzMorABizaTN7yehYuIetsxGDd55mldi+oSbjFoyKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754833350; c=relaxed/simple;
	bh=gNroVsPMuCxy0m+6hMmmrV8t4DGNlzsl+eGzKh1/4J4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EaMShcQaxz+u5vqwXT8oqfBH8dYw0ft5J8qvhibn6RvDaN4q/fQBpsiWjgUSpo89zzq860za89CAMTTIlauAzZkzIIgaSyoeu/Wn229JtRff6HoJRIJSCWbWeY6vONqzVuiRUei4Br7WnXnLw98RD/BHUyBAHmv7KzXZHr7yBDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OulLKpaV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57A9LVDe021434;
	Sun, 10 Aug 2025 13:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0B3hJJmho2YHLFXzV
	e2sFYTqjmwhGSM+TyAncg1vENY=; b=OulLKpaVxnspNd9GRxbc1i51EhVUu/lzG
	M0JexYkqGv5SdBb4m6KC2j9OrGB/axXisMac9gRXqnHyWa+gPHvVSRCE5/EkA3qV
	vsPFHbWVb31G2JnLdLz/+kFjXBwXIdRm0CJXhmrSGxDXtjgT0OsDGEkugH9Je++u
	+VFii4lqhi56yWBDwWh0hmgJjCxuOxrvjwoPCys1cLTk+nnlIzq2dKvA8Q/VahAZ
	q05Z/DcJTGm8oFbTCKPgSVmrn85y5H+GqOq0OrXmO1wJjdKTMFy23uhlQJguRFHq
	ZUVf7QEEPb5/+Sjcxm2uX/Fca+eMyCUzY/KsE+zMbOEXKP9Tz/lmg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57ADgLDn007055;
	Sun, 10 Aug 2025 13:42:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48durtwjay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57A946Tf017594;
	Sun, 10 Aug 2025 13:42:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc39nem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 10 Aug 2025 13:42:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57ADgJ2q58458440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 13:42:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 456622004F;
	Sun, 10 Aug 2025 13:42:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF18C20040;
	Sun, 10 Aug 2025 13:42:16 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.43])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 10 Aug 2025 13:42:16 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v4 05/11] generic: Add atomic write test using fio verify on file mixed mappings
Date: Sun, 10 Aug 2025 19:11:56 +0530
Message-ID: <508d55ad8e3b8efde87ffbe3354e9e1d9ee8c908.1754833177.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: 6nkjJfpfydRyso1WUAEKta8R09VJ7QXI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA5NyBTYWx0ZWRfXwLXx7cp9tQzH
 eetFrhQbCf4amPLV052LcsI1ZH2yxAKKSvD0lUbabUxPvRcSfUEpq/NdizBjIt2DxcZ6wFnsMqH
 5jaDCS5aIUkKGMWtcamANURBmZM7Z5p1oKnytstF4CowQUjI1HtPpXxHsRweKvjj9pwk9xXTeUh
 IKCIWuwjwDapt2ZkCTW/VxbHsEBPrZZqEJxwBK5MtJFo6rKfiw3pmtdKYtykvf042vb1m3Xl82P
 EYEE9nkwG+6nDAMSO6nXF8ZKXnVAcgbCJQPL44M2o2YOEygRhaE7UxkQxrOfA3ZafYwOMXPHR1o
 n7PBmp4i4lGUjmf26A7EU8EL4517FIMCa7LsWBdKvhmzcjixJFKLYBK7ahCsvhV6QYVtX27SAiK
 Hhsvqoilp/v02SRnEBdiBiOCCc1TEN11moDrM0c5rjwZf0G4DDfG58ot7ecoh3K5ibZuVQrh
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=6898a1be cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=ZzjZKRc1KEgCYT2eLxwA:9
X-Proofpoint-ORIG-GUID: 2TyRVTReJBJCdTm-Ok1MgeBMLERT0JtK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508100097

This tests uses fio to first create a file with mixed mappings. Then it
does atomic writes using aio dio with parallel jobs to the same file with
mixed mappings. This forces the filesystem allocator to allocate extents
over mixed mapping regions to stress FS block allocators.

Avoid doing overlapping parallel atomic writes because it might give
unexpected results. Use offset_increment=, size= fio options to achieve
this behavior.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1227     | 131 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1227.out |   2 +
 2 files changed, 133 insertions(+)
 create mode 100755 tests/generic/1227
 create mode 100644 tests/generic/1227.out

diff --git a/tests/generic/1227 b/tests/generic/1227
new file mode 100755
index 00000000..7423e67c
--- /dev/null
+++ b/tests/generic/1227
@@ -0,0 +1,131 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1227
+#
+# Validate FS atomic write using fio crc check verifier on mixed mappings
+# of a file.
+#
+. ./common/preamble
+. ./common/atomicwrites
+
+_begin_fstest auto aio rw atomicwrites
+
+_require_scratch_write_atomic_multi_fsblock
+_require_odirect
+_require_aio
+_require_xfs_io_command "truncate"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+touch "$SCRATCH_MNT/f1"
+awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
+awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
+
+aw_bsize=$(_max "$awu_min_write" "$((awu_max_write/4))")
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+
+threads=$(_min "$(($(nproc) * 2 * LOAD_FACTOR))" "100")
+filesize=$((aw_bsize * threads * 100))
+depth=$threads
+aw_io_size=$((filesize / threads))
+aw_io_inc=$aw_io_size
+testfile=$SCRATCH_MNT/test-file
+
+fio_prep_config=$tmp.prep.fio
+fio_aw_config=$tmp.aw.fio
+fio_verify_config=$tmp.verify.fio
+fio_out=$tmp.fio.out
+
+cat >$fio_prep_config <<EOF
+# prep file to have mixed mappings
+[global]
+ioengine=libaio
+filename=$testfile
+size=$filesize
+bs=$fsbsize
+direct=1
+iodepth=$depth
+group_reporting=1
+
+# Create written extents
+[prep_written_blocks]
+ioengine=libaio
+rw=randwrite
+io_size=$((filesize/3))
+random_generator=lfsr
+
+# Create unwritten extents
+[prep_unwritten_blocks]
+ioengine=falloc
+rw=randwrite
+io_size=$((filesize/3))
+random_generator=lfsr
+EOF
+
+cat >$fio_aw_config <<EOF
+# atomic write to mixed mappings of written/unwritten/holes
+[atomic_write_job]
+ioengine=libaio
+rw=randwrite
+direct=1
+atomic=1
+random_generator=lfsr
+group_reporting=1
+
+filename=$testfile
+bs=$aw_bsize
+size=$aw_io_size
+offset_increment=$aw_io_inc
+iodepth=$depth
+numjobs=$threads
+
+verify_state_save=0
+verify=crc32c
+do_verify=0
+EOF
+
+cat >$fio_verify_config <<EOF
+# verify atomic writes done by previous job
+[verify_job]
+ioengine=libaio
+rw=read
+random_generator=lfsr
+group_reporting=1
+
+filename=$testfile
+size=$filesize
+bs=$aw_bsize
+iodepth=$depth
+
+verify_state_save=0
+verify_only=1
+verify=crc32c
+verify_fatal=1
+verify_write_sequence=0
+EOF
+
+_require_fio $fio_aw_config
+_require_fio $fio_verify_config
+
+cat $fio_prep_config >> $seqres.full
+cat $fio_aw_config >> $seqres.full
+cat $fio_verify_config >> $seqres.full
+
+$XFS_IO_PROG -fc "truncate $filesize" $testfile >> $seqres.full
+
+#prepare file with mixed mappings
+$FIO_PROG $fio_prep_config >> $seqres.full
+
+# do atomic writes without verifying
+$FIO_PROG $fio_aw_config >> $seqres.full
+
+# verify data is not torn
+$FIO_PROG $fio_verify_config >> $seqres.full
+
+# success, all done
+echo Silence is golden
+status=0
+exit
diff --git a/tests/generic/1227.out b/tests/generic/1227.out
new file mode 100644
index 00000000..2605d062
--- /dev/null
+++ b/tests/generic/1227.out
@@ -0,0 +1,2 @@
+QA output created by 1227
+Silence is golden
-- 
2.49.0


