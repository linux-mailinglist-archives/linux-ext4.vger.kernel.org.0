Return-Path: <linux-ext4+bounces-9560-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A28B31136
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40469AE4CDE
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B22ED17D;
	Fri, 22 Aug 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pRQYB1Jq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741572EACE1;
	Fri, 22 Aug 2025 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849769; cv=none; b=pto1RKDhBe2e2UOg80sh7S8dNphTpiLswEyg9ld7M8tuw6qc0sHOYMyYoRsXYkwd4IZQPdapnesmIorRVqD+vB8TeHhS6SVkl6ImVEa/OdMDtkJP1oFE+NTNpUgqTbbet1a7DVhaHsl+c7BsqPGlfrrChDqmn8oKYiUs9p9Ap/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849769; c=relaxed/simple;
	bh=RxPrTaQAs9qgU+jIKC0eIPg2SC3HuaGHuhdMAdcX158=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4jr4+oC0y5hxfQwQ6tXkScMBXaLvm11baZFwX2XvEz1IpUb5pYRRYuzzB+HfkvgguhMrwv1Sq39wwp3/I15rNnWVP1s8GQux8zkm2Q1D4G2DpLwQ9jD8n1rlNAETTVurtmTOPctIVQtq9BYgfqHvzn0glHHFZDC/dWoAgh87j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pRQYB1Jq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7cDCg003075;
	Fri, 22 Aug 2025 08:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U0xLYgn5+zfKzcdPT
	vows24RLUS6/k6+Ygwt8UBcx3A=; b=pRQYB1Jqh5BCs27irvY51EWIZ72Ly7pf8
	STTI33xDqx+5f/roDeSQK+/voLIhrpDsj+HKhCoCXCFM7jj8shb83p7vmE1kaNk2
	zN6/+2qhqeASpKcsLA8d6XGCbqjMn7jYA/qXb/YgQocjczsaseoZwO3pPrwi/6qA
	AvyJHr3ebnzRv+MG2Kko76fNN+kmaO4xymsX/X71+U8q6Iaj7Fm4qc867nj14j8u
	O4SfpOMVNX4GJY4QBx9O0drZzDlAaz7PEADEUUSMXzLXnWvvGVJ94jjCVAkoDFcR
	PK6q7TBKExrH8TRdvrdW30ZcJEzHMeWdgX/efhwmy2JwqZoDP/WWQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38wd32r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:39 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M7v4Af030742;
	Fri, 22 Aug 2025 08:02:39 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38wd32p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M7hfte024279;
	Fri, 22 Aug 2025 08:02:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my43vaj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:38 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82axU55443768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ADF532004E;
	Fri, 22 Aug 2025 08:02:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FE9120040;
	Fri, 22 Aug 2025 08:02:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:34 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 08/12] generic: Stress fsx with atomic writes enabled
Date: Fri, 22 Aug 2025 13:32:07 +0530
Message-ID: <6d0de75776499a6751ccf12d2c3a1f059396b631.1755849134.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX/orhR4pHhBNC
 Q0F2PZDpOcxvqeGxyOkpvxgw4fdXATasAnNbnL1Ie9IWBVehyE48hM4tCvWmHbpXhOz4J/dDXS+
 sxGvA+FdUEbUI7BP8W9ZUhWfdacXopu2udT3haNWXCX7LlF7rMUtfwc2EWp6nbkhamlNV89cF6Q
 lA4RfXgNXTu4twwX/OdAcflRaAe89Lw03dCpvzimZHQHQgudkStFVSwq3vRFIrplq06SgLb4AZk
 SapuTZWz1LPmW4ABkpv8I+YADgQhRoFYm3FBFRTJ2YVrdM7SuR0Rfz5hStllUd9wdIbuWFQDjh8
 2lMNplSLKAF1ira9oGzz2RfVaj+xSTEmIY4LD0aYHXK9CR9S4vDUIehwQa6NkBK+TJUWQhpfeJl
 AKUI4vthl6/bKmk3mm9QpBtbqY4BKw==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a8241f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=zPW1cLLGUcrnTIp6xCMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: _bE4VOMz1WfjTP9FBajJj9dl5XLTStgq
X-Proofpoint-GUID: Ox_AOXjZOX-9tYmeV3ZeUBQW7oV0bQqv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

Stress file with atomic writes to ensure we excercise codepaths
where we are mixing different FS operations with atomic writes

Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/generic/1229     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/1229.out |  2 ++
 2 files changed, 70 insertions(+)
 create mode 100755 tests/generic/1229
 create mode 100644 tests/generic/1229.out

diff --git a/tests/generic/1229 b/tests/generic/1229
new file mode 100755
index 00000000..7fa57105
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
+		# fsx insert/collpase range support for ext4+bigalloc is
+		# currently broken, so disable it. Also disable incase we can't
+		# detect bigalloc to be on safer side.
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


