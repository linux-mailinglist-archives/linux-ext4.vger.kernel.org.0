Return-Path: <linux-ext4+bounces-8954-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E7B02B4B
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8061AA23B7
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8368288CB3;
	Sat, 12 Jul 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c42IurbO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC881289814;
	Sat, 12 Jul 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752329613; cv=none; b=uHePtPVkIEBzQnHFZW/jUgUqsvGu6NXUieDNS5ec/FTgA/qnIgCRQf6RsK0QXnBO5s/kYHMYsH51XeWxI57nuZekTXW03pBSIZBNG3vwAzaTquVjT/Y267YTtlc7pAkqsoFyrCzwfiOeM4ipCExdpEI5xcRFTgk680RB11E9mUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752329613; c=relaxed/simple;
	bh=WanGwxHlBHd/+1ooGk/OJ6/nLWjp8/ahCzh2gOmWpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRRte+2QECoo5361g8R/gwENyBdRmjmQ84MMUWzkz2vFxbOayIwM172lRUcWXolvjxYpnv3aqFk5ti8SIn9wsE04Ze1PuqevFU9K0pSaLTov3SQgUyv5b6qhxf+2TyvGy7DVHCbknThZIpv14qPi9SE3JL3g0c/qbLvW1SlHl6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c42IurbO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56CBwYlL024719;
	Sat, 12 Jul 2025 14:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QfO5LbuVEdFD6MYBG
	+KY8MBTI7LF3bPGUyNsn/KAUzs=; b=c42IurbOOoLYl4C8qiZA1+PN7eGLhdJi6
	mgyISr0X+FW648wWmgQlggXVdv7SG5aB0THersOoDAOEvLuIMV/VRQUdt+6R/OpN
	swRjA6o6SM9T2dfMvtKFk4ii7BWgfQY48Y9bolDRtqiW54PzOmOCNuOOA861JgL5
	hq3+Xe9uFb8MHxmp/aMvA2SINpxAxbu4xf8ExDFP6CDtm/iVHCbZdQiHpbuibjgB
	hNQniJVoUvkpMD3IXn3bxn66cmqXkg41PFM0OA1HtJlPtiZutFEi1o3Nyw/K7LwL
	TsJi/bUxecrDS1l4q32nR2zQJe16ug7f0vmlkXwqRe6PqVYvkP6SQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeehqtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56CEDNKJ031205;
	Sat, 12 Jul 2025 14:13:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufeehqtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56C9obF7025642;
	Sat, 12 Jul 2025 14:13:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47qfcpqe4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:13:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56CEDKg835848628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Jul 2025 14:13:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42F8320043;
	Sat, 12 Jul 2025 14:13:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03DDF20040;
	Sat, 12 Jul 2025 14:13:18 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.252])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Jul 2025 14:13:17 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v3 08/13] generic/1229: Stress fsx with atomic writes enabled
Date: Sat, 12 Jul 2025 19:42:50 +0530
Message-ID: <1e1e7d552e91fab58037b7b35ffbf8b2e7070be5.1752329098.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEyMDEwNyBTYWx0ZWRfX8MhNBY7hH4Dd ghO7a6Kx/Wu1PomAqgGgcFCFCyiW5Y524JsRxtJQ1bTCet/2UzErl2zuBkZFeWDkTuq/vNWCBEp gRd6r/VvgU63FZ+LfT48RhWpGUFsbhECQIDMro1YUPlnphegsrU5djjZkycGHiZDgalWHeSkGTM
 KVNVQ1i4SH5g5Lb7pAj1ja0aNZLYT6URXLv1ZGZj4cLecmVYW2kRPe3ngYtWdW72c3bZrK7slRP nekGDcSGyfD5JCKHt7te7kcYwDdGHDUDXWz4B4pynWH/a/HMLgFHiuECMOnLJaWopP690/6DQSa bIoveumr3+kpqpAuxHaqTCIFwJunC38oXMkX4lIS6dZBvG1wNaB5qwG5F25TWKjHES7HEkqs/oB
 pwGXUELwlzpMcrXdJrlBWjA2rJbOBttphJPWXBpKCSvi8rSKBcrjNMl33OpESuhAXiCozcNW
X-Proofpoint-ORIG-GUID: q2YYk-6xTqq9a0JkHl6WMN6Sm1MayKAv
X-Authority-Analysis: v=2.4 cv=C9/pyRP+ c=1 sm=1 tr=0 ts=68726d84 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=Wb1JkmetP80A:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=JyoSrJM7ovCTkwbihYMA:9 a=U1FKsahkfWQA:10
X-Proofpoint-GUID: 68j3FQTHx7-vvIQ4Dc-nFslgOgBc8Pbg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-12_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=796 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507120107

Stress file with atomic writes to ensure we excercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..98e9b50c
--- /dev/null
+++ b/tests/generic/1229
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
+#
+# FS QA Test 1229
+#
+# fuzz fsx with atomic writes
+#
+. ./common/preamble
+. ./common/atomicwrites
+_begin_fstest rw auto quick atomicwrites
+
+_require_odirect
+_require_scratch_write_atomic
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount  >> $seqres.full 2>&1
+
+testfile=$SCRATCH_MNT/testfile
+touch $testfile
+
+awu_max=$(_get_atomic_write_unit_max $testfile)
+blksz=$(_get_block_size $SCRATCH_MNT)
+bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
+
+# fsx usage:
+#
+# -N numops: total # operations to do
+# -l flen: the upper bound on file size
+# -o oplen: the upper bound on operation size (64k default)
+# -Z: O_DIRECT ()
+
+_run_fsx_on_file $testfile -N 10000 -o $awu_max -A -l 500000 -r $bsize -w $bsize -Z $FSX_AVOID  >> $seqres.full
+if [[ "$?" != "0" ]]
+then
+	_fail "fsx returned error: $?"
+fi
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/1229.out b/tests/generic/1229.out
new file mode 100644
index 00000000..737d61c6
--- /dev/null
+++ b/tests/generic/1229.out
@@ -0,0 +1,2 @@
+QA output created by 1229
+Silence is golden
-- 
2.49.0


