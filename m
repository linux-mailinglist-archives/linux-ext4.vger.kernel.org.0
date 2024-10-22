Return-Path: <linux-ext4+bounces-4721-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F179AB6B8
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 21:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AF4FB22968
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 19:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58BB1CB32F;
	Tue, 22 Oct 2024 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XZ8tdX8g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2AD145A1C;
	Tue, 22 Oct 2024 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625202; cv=none; b=CFaLkV940DdzeztJl9fRxLX3+YeDsidj9viIVBEUFML2edFSN/6vu7c5+xDyd9SSI5YhHOqHeujpzO9DC7DZOH54a1LfAbqktegOfJu/zWPEw+o06k7jNgiBYMVworOTvpSn+4bzStnFSKIoCcPUjUbl30STsgJl5noKtBRmM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625202; c=relaxed/simple;
	bh=6KaZFQagWlS+eaYwfw0exX6BXpLjCxzHxwQsoNYLWR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cN1cbf46KTqXCQSH6xjUqDq15+rhHtsAGhCDTVARoVIfOUsJSTwiYSmjmoDtKoMZN5EkWnuJM1X6WL1Gn8Lq+0TgTQWy5x8VNDdMVrqBKZKrIWDw8EpTvSS7akaJoqZ0qbM5AVAU0BjiqkwkU8YtQsFPnj5Aq3ITi6GdrBO79Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XZ8tdX8g; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MG9o9s009345;
	Tue, 22 Oct 2024 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xr8NS17tD14JGIIQ7
	tavOnzD/L6j5OkeFwMeo/geND8=; b=XZ8tdX8gMOVC+YqNXBvHNtkdD2TB+ZUl+
	89tJMi2JSfB+MmYItuSqU0R4UxbXpq8N8N16qYJijjOcPL1dPxpItczEmFe715iB
	BMlKfx36pOGTiave09/wCJeZSsDvzoH6lY36vkIdA2HMG7s/6seOdrpWfkojm9Lz
	aUmLZY+69obkK8eQxboU0z3RvHPxD2Zj+OotVCoov91LOVB9vaAiys8I2q/H/nwr
	y/gDERbicTXFR/nw6tvzwMwVw0G7c7imAzPePdKOu/AiATeQF3/7pODhLpYrUr9U
	tXSOCYT0+vFn5WcuOzdMLlTZenCMfDhnxkAoexb0APjfkGQIy+WAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmgh8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49MJQbk8013830;
	Tue, 22 Oct 2024 19:26:37 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5hmgh8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJBljI023829;
	Tue, 22 Oct 2024 19:26:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42cst14fp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MJQYxA57475360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 19:26:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0E452004B;
	Tue, 22 Oct 2024 19:26:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48E9920043;
	Tue, 22 Oct 2024 19:26:33 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.26.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 19:26:33 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH 2/2] generic: Addition of new tests for extsize hints
Date: Wed, 23 Oct 2024 00:56:20 +0530
Message-ID: <5cac327a9ee44c42035d9702b3a146aebc95e28c.1729624806.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1729624806.git.nirjhar@linux.ibm.com>
References: <cover.1729624806.git.nirjhar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: J48lVJJ-M9ngwz4fCDdjtaoiT1ovhYY2
X-Proofpoint-GUID: dh7m7iZi8qGxVfOdw7DrK4zDb9b1mckE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220125

This commit adds new tests that checks the behaviour of xfs/ext4
filesystems when extsize hint is set on file with inode size as 0, non-empty
files with allocated and delalloc extents and so on.
Although currently this test is placed under tests/generic, it
only runs on xfs and there is an ongoing patch series[1] to enable
extsize hints for ext4 as well.

[1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 tests/generic/365     | 156 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/365.out |  26 +++++++
 2 files changed, 182 insertions(+)
 create mode 100755 tests/generic/365
 create mode 100644 tests/generic/365.out

diff --git a/tests/generic/365 b/tests/generic/365
new file mode 100755
index 00000000..85a7ce9a
--- /dev/null
+++ b/tests/generic/365
@@ -0,0 +1,156 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
+#
+# FS QA Test 365
+#
+# This test verifies that extent allocation hint setting works correctly on files with
+# no extents allocated and non-empty files which are truncated. It also checks that the
+# extent hints setting fails with non-empty file i.e, with any file with allocated
+# extents or delayed allocation. We also check if the extsize value and the
+# xflag bit actually got reflected after setting/re-setting the extsize value.
+
+. ./common/config
+. ./common/filter
+. ./common/preamble
+. ./common/xfs
+
+_begin_fstest ioctl quick
+
+_supported_fs xfs
+
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+    "xfs: Check for delayed allocations before setting extsize",
+
+_require_scratch
+
+FILE_DATA_SIZE=1M
+
+filter_extsz()
+{
+    sed "s/$EXTSIZE/EXTSIZE/g"
+}
+
+setup()
+{
+    _scratch_mkfs >> "$seqres.full"  2>&1
+    _scratch_mount >> "$seqres.full" 2>&1
+    BLKSZ=`_get_block_size $SCRATCH_MNT`
+    EXTSIZE=$(( BLKSZ*2 ))
+}
+
+read_file_extsize()
+{
+    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz
+}
+
+check_extsz_and_xflag()
+{
+    local filename=$1
+    read_file_extsize $filename
+    _test_xfs_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
+}
+
+check_extsz_xflag_across_remount()
+{
+    local filename=$1
+    _scratch_cycle_mount
+    check_extsz_and_xflag $filename
+}
+
+# Extsize flag should be cleared when extsize is reset, so this function
+# checks that this behavior is followed.
+reset_extsz_and_recheck_extsz_xflag()
+{
+    local filename=$1
+    echo "Re-setting extsize hint to 0"
+    $XFS_IO_PROG -c "extsize 0" $filename
+    check_extsz_xflag_across_remount $filename
+}
+
+check_extsz_xflag_before_and_after_reset()
+{
+    local filename=$1
+    check_extsz_xflag_across_remount $filename
+    reset_extsz_and_recheck_extsz_xflag $filename
+}
+
+test_empty_file()
+{
+    echo "TEST: Set extsize on empty file"
+    local filename=$1
+    $XFS_IO_PROG \
+        -c "open -f $filename" \
+        -c "extsize $EXTSIZE" \
+
+    check_extsz_xflag_before_and_after_reset $filename
+    echo
+}
+
+test_data_delayed()
+{
+    echo "TEST: Set extsize on non-empty file with delayed allocation"
+    local filename=$1
+    $XFS_IO_PROG \
+        -c "open -f $filename" \
+        -c "pwrite -q  0 $FILE_DATA_SIZE" \
+        -c "extsize $EXTSIZE" | _filter_scratch
+
+    check_extsz_xflag_across_remount $filename
+    echo
+}
+
+test_data_allocated()
+{
+    echo "TEST: Set extsize on non-empty file with allocated extents"
+    local filename=$1
+    $XFS_IO_PROG \
+        -c "open -f $filename" \
+        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
+        -c "extsize $EXTSIZE" | _filter_scratch
+
+    check_extsz_xflag_across_remount $filename
+    echo
+}
+
+test_truncate_allocated()
+{
+    echo "TEST: Set extsize after truncating a file with allocated extents"
+    local filename=$1
+    $XFS_IO_PROG \
+        -c "open -f $filename" \
+        -c "pwrite -qW  0 $FILE_DATA_SIZE" \
+        -c "truncate 0" \
+        -c "extsize $EXTSIZE" \
+
+    check_extsz_xflag_across_remount $filename
+    echo
+}
+
+test_truncate_delayed()
+{
+    echo "TEST: Set extsize after truncating a file with delayed allocation"
+    local filename=$1
+    $XFS_IO_PROG \
+        -c "open -f $filename" \
+        -c "pwrite -q  0 $FILE_DATA_SIZE" \
+        -c "truncate 0" \
+        -c "extsize $EXTSIZE" \
+
+    check_extsz_xflag_across_remount $filename
+    echo
+}
+
+setup
+echo -e "EXTSIZE = $EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
+
+NEW_FILE_NAME_PREFIX=$SCRATCH_MNT/new-file-
+
+test_empty_file "$NEW_FILE_NAME_PREFIX"00
+test_data_delayed "$NEW_FILE_NAME_PREFIX"01
+test_data_allocated "$NEW_FILE_NAME_PREFIX"02
+test_truncate_allocated "$NEW_FILE_NAME_PREFIX"03
+test_truncate_delayed "$NEW_FILE_NAME_PREFIX"04
+
+status=0
+exit
diff --git a/tests/generic/365.out b/tests/generic/365.out
new file mode 100644
index 00000000..38cd0885
--- /dev/null
+++ b/tests/generic/365.out
@@ -0,0 +1,26 @@
+QA output created by 365
+TEST: Set extsize on empty file
+[EXTSIZE] SCRATCH_MNT/new-file-00
+e flag set
+Re-setting extsize hint to 0
+[0] SCRATCH_MNT/new-file-00
+e flag unset
+
+TEST: Set extsize on non-empty file with delayed allocation
+xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
+[0] SCRATCH_MNT/new-file-01
+e flag unset
+
+TEST: Set extsize on non-empty file with allocated extents
+xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
+[0] SCRATCH_MNT/new-file-02
+e flag unset
+
+TEST: Set extsize after truncating a file with allocated extents
+[EXTSIZE] SCRATCH_MNT/new-file-03
+e flag set
+
+TEST: Set extsize after truncating a file with delayed allocation
+[EXTSIZE] SCRATCH_MNT/new-file-04
+e flag set
+
-- 
2.43.5


