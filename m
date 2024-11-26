Return-Path: <linux-ext4+bounces-5410-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECBD9D9189
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 06:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E677E288569
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Nov 2024 05:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0032315B980;
	Tue, 26 Nov 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A7YyfrNj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02940539A;
	Tue, 26 Nov 2024 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600574; cv=none; b=m0ZGAGvo8yt6m6zzVBeNQR0QDCgMqPgunhq3cD2ApUwbTOqgLkGRKj/ZAAO+Sydi7tXM7emfdYQLytdBquog3utNK4K/NYapkTHcjCoTyjI5VeS+DLKVsgEEQlxCr6IFNdJMgOxTOHMPjJ9XC5dLBGdP6ZZFDLzuhqNGfCa4+08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600574; c=relaxed/simple;
	bh=cn174m9jg4C3BFXFpSF/xbIhggpuOPpTw35NN8sHUX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7ZlOEsPVBlf5as15Bi5zxqT2Siz/pyoKsDTfi/F+7SyU/cwNJfEsIa1g0PGG1GCOi0jQAphv/2DCWbYgktwHtjaTFhqSFCPGKH8cDP8LECPxmbJI9URpcL9jA1NL19lHrWI4Qf9eEGk7A1Vn6Mk21abPcv/d33jqzwBgU+5o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A7YyfrNj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4APMYegn021731;
	Tue, 26 Nov 2024 05:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ohLAjc+2WssuciWrE
	26hMXvxGBkiRa++RL43JHH8XZM=; b=A7YyfrNjY0RvEU0Xa7070EvV8wxX/OzZC
	UDsPj9TxTKhuEe1NZraFiy9IjxtsyrJsuZU/UBOzrpvec5DX2qASALIwNNiv4Kbn
	WtowLbPNAUXQXeoC91vr2GHGwD7ZdDtuciPznfWytUvApjNyoS+TeBg+AOV6dq+j
	PDotTmqpXBLz5HT8jcf6yx3RL6QWKAJe3Zq9XTMvBj7779v4tT6111AiYamcn+Zl
	bWEZGJ6CJybj4VgHLCqMQOEx7CstA7lfDsZzN5pLSWAgcsI6f3v4lPefdbq8CaAo
	YjwGhZx2ZsPMSMdsxPlIhSjSx47FJbUiJYqZzDgEUrCNBLwLwehgQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386juw5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:56:09 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AQ5bXxn009882;
	Tue, 26 Nov 2024 05:56:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386juw5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:56:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQ2O2LN008775;
	Tue, 26 Nov 2024 05:56:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scruw57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 05:56:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AQ5u5rS62521822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 05:56:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 248BE2004B;
	Tue, 26 Nov 2024 05:56:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5671520043;
	Tue, 26 Nov 2024 05:56:03 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.222.125])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Nov 2024 05:56:03 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v4 3/3] generic: Addition of new tests for extsize hints
Date: Tue, 26 Nov 2024 11:24:08 +0530
Message-ID: <4b3bc104222cba372115d6e249da555f7fbe528b.1732599868.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732599868.git.nirjhar@linux.ibm.com>
References: <cover.1732599868.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9JAF9Kn_lsmE0ZNXF9C_UBjN6QAxObtZ
X-Proofpoint-GUID: HDafXfrtYhc5cgwQ2n9x-PmsBBmLQ_-3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411260043

This commit adds new tests that checks the behaviour of xfs/ext4
filesystems when extsize hint is set on file with inode size as 0,
non-empty files with allocated and delalloc extents and so on.
Although currently this test is placed under tests/generic, it
only runs on xfs and there is an ongoing patch series[1] to
enable extsize hints for ext4 as well.

[1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 tests/generic/367     | 175 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out |  26 +++++++
 2 files changed, 201 insertions(+)
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out

diff --git a/tests/generic/367 b/tests/generic/367
new file mode 100755
index 00000000..25d23f42
--- /dev/null
+++ b/tests/generic/367
@@ -0,0 +1,175 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
+#
+# FS QA Test 366
+#
+# This test verifies that extent allocation hint setting works correctly on
+# files with no extents allocated and non-empty files which are truncated.
+# It also checks that the  extent hints setting fails with non-empty file
+# i.e, with any file with allocated extents or delayed allocation. We also
+# check if the extsize value and the xflag bit actually got reflected after
+# setting/re-setting the extsize value.
+
+. ./common/config
+. ./common/filter
+. ./common/preamble
+
+_begin_fstest ioctl quick
+
+_fixed_by_kernel_commit "2a492ff66673 \
+                        xfs: Check for delayed allocations before setting \
+			extsize"
+
+_require_scratch_extsize
+
+FILE_DATA_SIZE=1M
+
+get_default_extsize()
+{
+    if [ -z $1 ] || [ ! -d $1 ]; then
+        echo "Missing mount point argument for get_default_extsize"
+        exit 1
+    fi
+    $XFS_IO_PROG -c "extsize" "$1" | sed 's/^\[\([0-9]\+\)\].*/\1/'
+}
+
+filter_extsz()
+{
+    sed "s/\[$1\]/\[EXTSIZE\]/g"
+}
+
+setup()
+{
+    _scratch_mkfs >> "$seqres.full"  2>&1
+    _scratch_mount >> "$seqres.full" 2>&1
+    BLKSZ=`_get_block_size $SCRATCH_MNT`
+    DEFAULT_EXTSIZE=`get_default_extsize $SCRATCH_MNT`
+    EXTSIZE=$(( BLKSZ*2 ))
+    # Make sure the new extsize is not the same as the default
+    # extsize so that we can observe it changing
+    [[ "$DEFAULT_EXTSIZE" -eq "$EXTSIZE" ]] && EXTSIZE=$(( BLKSZ*4 ))
+}
+
+read_file_extsize()
+{
+    $XFS_IO_PROG -c "extsize" $1 | _filter_scratch | filter_extsz $2
+}
+
+check_extsz_and_xflag()
+{
+    local filename=$1
+    local extsize=$2
+    read_file_extsize $filename $extsize
+    _test_fsxattr_xflag $filename "extsize" && echo "e flag set" || \
+	    echo "e flag unset"
+}
+
+check_extsz_xflag_across_remount()
+{
+    local filename=$1
+    local extsize=$2
+    _scratch_cycle_mount
+    check_extsz_and_xflag $filename $extsize
+}
+
+# Extsize flag should be cleared when extsize is reset, so this function
+# checks that this behavior is followed.
+reset_extsz_and_recheck_extsz_xflag()
+{
+    local filename=$1
+    echo "Re-setting extsize hint to 0"
+    $XFS_IO_PROG -c "extsize 0" $filename
+    check_extsz_xflag_across_remount $filename "0"
+}
+
+check_extsz_xflag_before_and_after_reset()
+{
+    local filename=$1
+    local extsize=$2
+    check_extsz_xflag_across_remount $filename $extsize
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
+    check_extsz_xflag_before_and_after_reset $filename $EXTSIZE
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
+    echo "test for default extsize setting if any"
+    read_file_extsize $filename $DEFAULT_EXTSIZE
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
+    echo "test for default extsize setting if any"
+    read_file_extsize $filename $DEFAULT_EXTSIZE
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
+    check_extsz_xflag_across_remount $filename $EXTSIZE
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
+    check_extsz_xflag_across_remount $filename $EXTSIZE
+    echo
+}
+
+setup
+echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE \
+	BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
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
diff --git a/tests/generic/367.out b/tests/generic/367.out
new file mode 100644
index 00000000..f94e8545
--- /dev/null
+++ b/tests/generic/367.out
@@ -0,0 +1,26 @@
+QA output created by 367
+TEST: Set extsize on empty file
+[EXTSIZE] SCRATCH_MNT/new-file-00
+e flag set
+Re-setting extsize hint to 0
+[EXTSIZE] SCRATCH_MNT/new-file-00
+e flag unset
+
+TEST: Set extsize on non-empty file with delayed allocation
+xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-01: Invalid argument
+test for default extsize setting if any
+[EXTSIZE] SCRATCH_MNT/new-file-01
+
+TEST: Set extsize on non-empty file with allocated extents
+xfs_io: FS_IOC_FSSETXATTR SCRATCH_MNT/new-file-02: Invalid argument
+test for default extsize setting if any
+[EXTSIZE] SCRATCH_MNT/new-file-02
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


