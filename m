Return-Path: <linux-ext4+bounces-5189-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938C9CD62F
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 05:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95252B23D64
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 04:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637A9175D4C;
	Fri, 15 Nov 2024 04:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="naES/mBY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5402E400;
	Fri, 15 Nov 2024 04:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731644257; cv=none; b=g/r7CwQMIplRpyuc7bGQrltRThxyHQMsS1heMQFaGDaWTsCGjGgDN7dODF4TVkirqP3HZzMjmhocVQHcNb5gegDGjk3ZoVaKAgh9sGBjsCMDxBvhu9+eJXFbiyeFmHnjDBNTkitPJOhqmegPoynoCC/yybuQLLNxT187kXkJ6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731644257; c=relaxed/simple;
	bh=/tlzlOAJx/nJnmxGUB9JYmwKPaoRZDxZjUyf6pKCgMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekUSpXAOzaOOSQsQG5ov9vi9V7jawhyqKCT1E7NJidFmf9sYriKflO7ZL2PFsIGilFkECt3jPjjVW7V3z98rQGTGTxqLnW8QsRZqnkqAggfHDPdiJPGLt8mgsx2XYDuvC/kBoKbC2F/RSpeZ81RqMDiBsssj5VXgL2NsHcG1Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=naES/mBY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF0jteS022913;
	Fri, 15 Nov 2024 04:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fhN+I4U8up6q18hTt
	VfYthI7xpZnDBMvIzCmPcedcoA=; b=naES/mBYwXpqeVdMpmvOpOJrl3ge/Lh/b
	P62RWI+uy28ymJ7kZSKSwyTPMYZnnnc+lX2XIiBb9f7owUhvIK6gl2hvGqZVpZnY
	0DWqA4/xb9Z1usvN2aeZhV5Upn/5pZKD/rJmAPR5FAiSnLSjlgFu3LOeInMmYpoN
	R7wc9Xi8mrn7rVyQadnXSgwvopN7M2TdzTIRl72AWAyRtRSV5oUfGR5zdN0K7xrq
	3X7UsmYo8YsWV5al7rtbBjNTjnP4w+QSU/vi9cVg/EhlVuUJWa7JHkDLDEngSlhI
	co50CqAmysOyxAP7oB+EM2fPrAx/QnVZUPjEAl45AMgKLp9tAq+Pg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vs209-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AF4EUEU013432;
	Fri, 15 Nov 2024 04:17:31 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wu2vs204-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF4D87W008270;
	Fri, 15 Nov 2024 04:17:30 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjf0eqsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 04:17:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AF4HSFi56426986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 04:17:28 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C692004B;
	Fri, 15 Nov 2024 04:17:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B710E20040;
	Fri, 15 Nov 2024 04:17:26 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.124.220.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 04:17:26 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH v2 2/2] generic: Addition of new tests for extsize hints
Date: Fri, 15 Nov 2024 09:45:59 +0530
Message-ID: <373a7e378ba4a76067dc7da5835ac722248144f9.1731597226.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1731597226.git.nirjhar@linux.ibm.com>
References: <cover.1731597226.git.nirjhar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: i5Yaa4WE-H6wtzYo1FpzA1WRF3NErTmM
X-Proofpoint-GUID: 2VYnupRISgOAnJsxobHaNUO7YvJs8-ja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150032

This commit adds new tests that checks the behaviour of xfs/ext4
filesystems when extsize hint is set on file with inode size as 0, non-empty
files with allocated and delalloc extents and so on.
Although currently this test is placed under tests/generic, it
only runs on xfs and there is an ongoing patch series[1] to enable
extsize hints for ext4 as well.

[1] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Reviewed-by Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Suggested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
---
 tests/generic/366     | 172 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/366.out |  26 +++++++
 2 files changed, 198 insertions(+)
 create mode 100755 tests/generic/366
 create mode 100644 tests/generic/366.out

diff --git a/tests/generic/366 b/tests/generic/366
new file mode 100755
index 00000000..7ff4e8e2
--- /dev/null
+++ b/tests/generic/366
@@ -0,0 +1,172 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Nirjhar Roy (nirjhar@linux.ibm.com).  All Rights Reserved.
+#
+# FS QA Test 366
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
+
+_begin_fstest ioctl quick
+
+_supported_fs xfs
+
+_fixed_by_kernel_commit "2a492ff66673 \
+                        xfs: Check for delayed allocations before setting extsize"
+
+_require_scratch
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
+    # Making sure the new extsize is not the same as the default extsize
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
+    _test_fsx_xflags_field $filename "e" && echo "e flag set" || echo "e flag unset"
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
+echo -e "EXTSIZE = $EXTSIZE DEFAULT_EXTSIZE = $DEFAULT_EXTSIZE BLOCKSIZE = $BLKSZ\n" >> "$seqres.full"
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
diff --git a/tests/generic/366.out b/tests/generic/366.out
new file mode 100644
index 00000000..cdd2f5fa
--- /dev/null
+++ b/tests/generic/366.out
@@ -0,0 +1,26 @@
+QA output created by 366
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


