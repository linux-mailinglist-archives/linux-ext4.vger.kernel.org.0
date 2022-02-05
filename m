Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467B34AA96E
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 15:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380139AbiBEO32 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 09:29:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1380134AbiBEO31 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 09:29:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215DQNjl021802;
        Sat, 5 Feb 2022 14:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=foYX60cfFPgyXzRx97URzzhS+rlh07CUJw4hGmMnd6A=;
 b=jb3INu2TzCAjMK+zN2htAx75UCsWp02GGogPTb+VC5NtXg6OqVcVFPEux+LT/AadDbA6
 kiZ56UT7H06yJHT0M5lM3akP+0aCj538iPuPlOpv5qRYpR6FM9Mt1eCLDsDhhnzz7p05
 MuyQYPZvbqYOtshLSX50edjA7wb90b1Lt408hKnXCLhg+oD1RGkNHmMAHf7CcSNLxJ+9
 M0aclwGcB+eiM11AK0bbWao09bJ8hvqXmhj2QfRWhDhI2/DAzyRgGACHS7dt2BP1Qz14
 KtLztjY4WzNGrUwiBzTD8sLVmwBJs5ilN2iSlSRvn1lX69q8wMYwEWBYq7nKnhNUuwyl Iw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3e1en89tec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:26 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215ERalO032508;
        Sat, 5 Feb 2022 14:29:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv8j7uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:25 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215ETLUq44892462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:29:21 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D48415204F;
        Sat,  5 Feb 2022 14:29:21 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F251A5204E;
        Sat,  5 Feb 2022 14:29:20 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 4/4] ext4/058: Add shutdown recovery test with fast_commit
Date:   Sat,  5 Feb 2022 19:58:54 +0530
Message-Id: <6f55546f021fac9b35ae07d4323f4aba00baad95.1644070604.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644070604.git.riteshh@linux.ibm.com>
References: <cover.1644070604.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iFg6-LsGGO1xqf6iGh6AJ6J9w_1HSL_K
X-Proofpoint-ORIG-GUID: iFg6-LsGGO1xqf6iGh6AJ6J9w_1HSL_K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In certain cases fast_commit may not delete the range during replay
phase (after sudden FS shutdown) due to some operations which depends on
inode->i_size (which during replay of an inode with fast_commit could be
0 for sometime). This fstest tests such scenario with fast_commit in
ext4.

This test case is based on the test case shared via Xin Yin.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/058     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/058.out |  7 +++++
 2 files changed, 73 insertions(+)
 create mode 100755 tests/ext4/058
 create mode 100644 tests/ext4/058.out

diff --git a/tests/ext4/058 b/tests/ext4/058
new file mode 100755
index 00000000..4d70f483
--- /dev/null
+++ b/tests/ext4/058
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM.  All Rights Reserved.
+#
+# FS QA Test 058
+#
+# Tests fast_commit feature of ext4 as fixed in below commit
+# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
+# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
+#
+. ./common/preamble
+_begin_fstest auto shutdown quick log recoveryloop
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
+   _scratch_unmount > /dev/null 2>&1
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/punch
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+_require_scratch_ext4_feature "fast_commit"
+
+t1=$SCRATCH_MNT/foo
+t2=$SCRATCH_MNT/bar
+
+$MKFS_EXT4_PROG -F -O 64bit,fast_commit $SCRATCH_DEV 512m >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+bs=$(_get_block_size $SCRATCH_MNT)
+
+# create and write data to t1
+$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io
+
+# fzero certain range in between with -k
+$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1 | _filter_xfs_io
+
+# create and fsync a new file t2
+$XFS_IO_PROG -f -c "fsync" $t2
+
+# fpunch within the i_size of a file
+$XFS_IO_PROG -c "fpunch $((30*$bs)) $((20*$bs))" $t1
+
+# fsync t1 to trigger fast_commit operation
+$XFS_IO_PROG -c "fsync" $t1
+
+# shutdown FS now for replay of FC to kick in next mount
+_scratch_shutdown -v >> $seqres.full 2>&1
+
+_scratch_cycle_mount
+
+# check fiemap reported is valid or not
+$XFS_IO_PROG -c "fiemap -v" $t1 | _filter_fiemap_flags $bs
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/058.out b/tests/ext4/058.out
new file mode 100644
index 00000000..98359e01
--- /dev/null
+++ b/tests/ext4/058.out
@@ -0,0 +1,7 @@
+QA output created by 058
+wrote 409600/409600 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..29]: none
+1: [30..49]: hole
+2: [50..59]: unwritten
+3: [60..99]: nonelast
-- 
2.31.1

