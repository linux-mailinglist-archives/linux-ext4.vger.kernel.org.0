Return-Path: <linux-ext4+bounces-10261-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480B4B880DA
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 08:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094DB3BDAD3
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 06:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D82D5C6C;
	Fri, 19 Sep 2025 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iCCUACK0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C82D4B68;
	Fri, 19 Sep 2025 06:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758264534; cv=none; b=iFEgwL9VXHt4aAfmSDoJ/WUPu9S263F4wuEpRp3OzhiC8rTQc15Ks8OK1KgbN0dL6ikmove7bXvqkJOBgOUb++QWik7K7BwhH1BkMaaE1RVAwwlYZP2G/flcnKxLXejH2S4/ximZJru6R354LL4zFR2qAiECHN1QwG2eMxKg75k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758264534; c=relaxed/simple;
	bh=DuKA96AdpyKLqZYBHb58RoVvGwseEPk0CTPSH9y8nJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PD/gUeEfDINghe+Bn4Q+wa5Q+qjdGDHJjtmDBPaYjI89p1yHioHnmE0bGf1n+HsmbFplz9zIdQq+WHQR2i3HLBUFGykvJSPKzbnKSP+yE0LinEXts6jIovTDVdQ1KlG+ZjG2PPhc58XrnVvtAJBaN5lcfkMFvvuoiGVDrsLLGPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iCCUACK0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58J2WLt9000352;
	Fri, 19 Sep 2025 06:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ot+islW9QqRcQihl1
	cGnoj87N1ScOyDjNrHRSvRNX44=; b=iCCUACK0WXWC9tmkx8tOfZyXItW+qmUtW
	o77vs2b7QQXURdyA8ATPedve83OAeCWh10RJxFhlqnlYIZMXKv3Lh4cTHygiqrPM
	PttksOZ+3Ms8WXGZ43o1fdjjwxmWTq6iSAQsbzJ3r4s5owMWRbjsVI2zAmfMBTKV
	izsQIHgd1S/762j3L0+AoJU+QgoAIuvZfn3tNPkE+z4daMCIgkrm48YGVEQ70Qoy
	HFg1nPd9YwWik5biqP44PM9kT4Q3Nrkvbt4VUTtvggwjHJolhIWjZE3qDV1L7CxH
	bTd7a7eG29WpZAUXbn+I+TBdjuLlTIv9km7jrzQi9Wq5N4d5wFsYA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxwex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58J6k897000735;
	Fri, 19 Sep 2025 06:48:44 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4hxweu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J4KaYn005935;
	Fri, 19 Sep 2025 06:48:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxujufn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 06:48:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58J6mfv251314994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 06:48:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D40B620043;
	Fri, 19 Sep 2025 06:48:41 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9859920040;
	Fri, 19 Sep 2025 06:48:38 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.215.51])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 06:48:38 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v7 08/12] generic: Stress fsx with atomic writes enabled
Date: Fri, 19 Sep 2025 12:18:01 +0530
Message-ID: <710bc35098ed16ceeeaa1214153cfb5e31130da3.1758264169.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -bf3ix6oHCRkhNAX1VByXKZMqo2rZscI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX1XY+3tEnsdKB
 T3z40UY7OaJLCwJ38WB0P5ua4lWl7t7mXZMk5FjSQdX+UfH/dFSiXvZ7fwqYkXyw/+teJEpVXF3
 g49F9X1So0voMNiT40eVSuYz017hW6bx/CjyQCctiW9ZXBoAIiVDuUXUjCvRoY0Iiqs3GgYtOiN
 xead47vRUv3hbjHFe1VlXLj5HtnJCMl73um5tGNdh9wBmHT61Pw9AMOOrJolAHjOdBdZ8Na11ev
 nIlTUzMYsD87/hrPJ3P1juk3Kdc9RtV5ZgpVwQLxp2AQ9oe/zRl/gGvrDgIPXcTcv50SoKwh7fK
 +GhqZnzUqOQAh5GJ+hK2cTPO/Pemu6lX0UNT+sfKuZxstkk8Br7rrsuvj2bVBgGa112rveHfp+k
 D5a+ai2H
X-Proofpoint-GUID: kdDeZCPsoaCyKMOckpdkWSgOiXvTfUh8
X-Authority-Analysis: v=2.4 cv=co2bk04i c=1 sm=1 tr=0 ts=68ccfccd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=VnNF1IyMAAAA:8 a=zPW1cLLGUcrnTIp6xCMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160204

Stress file with atomic writes to ensure we exercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..6d4dcfed
--- /dev/null
+++ b/tests/generic/1229
@@ -0,0 +1,68 @@
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
+set_fsx_avoid() {
+	local file=$1
+
+	case "$FSTYP" in
+	"ext4")
+		local dev=$(findmnt -n -o SOURCE --target $testfile)
+
+		# fsx insert/collapse range support for ext4+bigalloc is
+		# currently broken, so disable it. Also disable in case we
+		# can't detect bigalloc to be on safer side.
+		if [ -z "$DUMPE2FS_PROG" ]; then
+			echo "dumpe2fs not found, disabling insert/collapse range" >> $seqres.full
+			FSX_AVOID+=" -I -C"
+			return
+		fi
+
+		$DUMPE2FS_PROG -h $dev 2>&1 | grep -q bigalloc && {
+			echo "fsx insert/collapse range not supported with bigalloc. Disabling.." >> $seqres.full
+			FSX_AVOID+=" -I -C"
+		}
+		;;
+	*)
+		;;
+	esac
+}
+
+# fsx usage:
+#
+# -N numops: total # operations to do
+# -l flen: the upper bound on file size
+# -o oplen: the upper bound on operation size (64k default)
+# -Z: O_DIRECT ()
+
+set_fsx_avoid
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


