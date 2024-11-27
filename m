Return-Path: <linux-ext4+bounces-5429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729339DA182
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 05:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E15284F2E
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Nov 2024 04:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D3A13A89B;
	Wed, 27 Nov 2024 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZNcCDN40"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EEE1946B;
	Wed, 27 Nov 2024 04:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732681742; cv=none; b=spebLV6on+tjb52SlvATD5s8IsjjNz0gW7w/dlPScIqva3Drh/KKKY7TM7GU1lUBcItYKFbqV8R+qONEjLANIIjE6ytnFBjpy+sIlHDSSoylivcPfBv6nXdmyy1KbptBfdHbnBh0TNZBDM9dH8WXz9dqmOKxOAnJn75bPl4AVro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732681742; c=relaxed/simple;
	bh=zH+PYlOdq8bcYGzyNN/Ln9Z/WnvXcvgkzChe5svZpJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WG+kQZuwuafkmCjBETJspn7ibIJmnZV9QO+Ktb1Wf5att4Buiw2wUQGu8xfuiAyNnj5E9GsblYLVSzO4DHiIZoWvbKnPaV9j6hbChHTBOiHUPRFwKS7uBiSINeOxDh/pCQ3FeCMGAISzFatlR91+BFXPS/YYvSFbh1idTBOW9GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZNcCDN40; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR1h9Gl010586;
	Wed, 27 Nov 2024 04:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pZfhMKryS4H4Yta8H
	gHbHaz6s0sC8cEmtXxw/av1EbU=; b=ZNcCDN4024CdoDvFawgSjn6prQNtlo16h
	MOvddyAs5q2fRp3tMw95QY7+zrBl95zW59U0sFJR4Kk22pq8iAwwXLaPvXqagGW2
	OyqZsSCY03MRzD2VUNaF2D7fovE/fk7Xb9KonEJNY7XMl1CO73cP4cHweR749XOe
	7OWww8RMkSlDg4UiUtDVcEhGm9rVGw6shUIiUmvCGuHQjatRcMfcOYZHeCkqIqZe
	jhXyfMEHdPiba/5Jp/g4s6VV+9p9MAp9G7k0Vf2hGq+tnDHJ0B8G+Y8CaQ3ZF5Tk
	zkAP5rm+BTjMEBavB2LCVLsavYpAo6KRAa7XvY6KT+cVImdnVZgJA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1bnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:57 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AR4NXDC022322;
	Wed, 27 Nov 2024 04:28:56 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43386k1bnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AR33cEn024887;
	Wed, 27 Nov 2024 04:28:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 433tvkj2wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 04:28:56 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AR4Sq0M65405398
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 04:28:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 525D22004B;
	Wed, 27 Nov 2024 04:28:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4C1120043;
	Wed, 27 Nov 2024 04:28:50 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.20.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 04:28:50 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org, nirjhar@linux.ibm.com
Subject: [PATCH v5 3/3] generic: Addition of new tests for extsize hints
Date: Wed, 27 Nov 2024 09:58:01 +0530
Message-ID: <f631f38a8b95dc6caee01015b8b24599f15b6c9b.1732681064.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1732681064.git.nirjhar@linux.ibm.com>
References: <cover.1732681064.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ieqHzQBQTjRopkF8enM2EBdGyeO0IR4W
X-Proofpoint-GUID: JG0MoEt_-WIAxVubX7Q4PGJbnXc0PimG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270035

This commit adds new tests that checks the behaviour of xfs/ext4
filesystems when extsize hint is set on file with inode size as 0,
non-empty files with allocated and delalloc extents and so on.
Although currently this test is placed under tests/generic, it
only runs on xfs and there is an ongoing patch series[1] to
enable extsize hints for ext4 as well.

[1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 tests/generic/367     | 174 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/367.out |  26 +++++++
 2 files changed, 200 insertions(+)
 create mode 100755 tests/generic/367
 create mode 100644 tests/generic/367.out

diff --git a/tests/generic/367 b/tests/generic/367
new file mode 100755
index 00000000..7cf90695
--- /dev/null
+++ b/tests/generic/367
@@ -0,0 +1,174 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
+#
+# FS QA Test 367
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
+_fixed_by_kernel_commit 2a492ff66673 \
+	"xfs: Check for delayed allocations before setting extsize"
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


