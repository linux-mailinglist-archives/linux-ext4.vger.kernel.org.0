Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB354AA96A
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 15:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380129AbiBEO3R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 09:29:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380122AbiBEO3Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 09:29:16 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215BOEsg025853;
        Sat, 5 Feb 2022 14:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=oybUHuEDFVN53eQO0IGUWJxdwIqWJ4mony3xODNm0Qs=;
 b=XfuVeCatkAg8VoQLJxZl8R2KS1KlECXkaitVLfcbv/OUyTsv/wXeotGg+xil6oEDLPYc
 627GvTqv8b+ew/uKt3CL6e35yGFT/RUIb6qsk+9HQ/NenxihRXDn/OCapuMXmy3311CT
 ujN7HQHbEyq/b6XSIUtacTRkkIVFyqpR905AWryb1vZ+SJhRVcrfhSiYs18O+dQy/Bc1
 1Sb03ItRzACySDxIKC1QKEcf6KseKB7/+YfhSQgSszkMMPsJvX4kSQ1utmEaDykotlq/
 jKWgS2344zgJnGfN34SmKA9XaC5po4x3QudPzk4S2omNOCcwiJ+SI0QlY7cFv5/IRPp+ Yw== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7mexrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:16 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215ERmx3022922;
        Sat, 5 Feb 2022 14:29:14 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3e1gv8t2pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:14 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215ET8sZ48628094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:29:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 695544C040;
        Sat,  5 Feb 2022 14:29:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C1344C046;
        Sat,  5 Feb 2022 14:29:07 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:29:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 1/4] ext4/056: Add fast_commit regression test causing data abort exception
Date:   Sat,  5 Feb 2022 19:58:51 +0530
Message-Id: <78fa98fd44ad52e3c89bee87f7261d1eb5cfe045.1644070604.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644070604.git.riteshh@linux.ibm.com>
References: <cover.1644070604.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qv5m-Pe8l-C1rkh_mDX7KI8g7Hu4-dWS
X-Proofpoint-GUID: qv5m-Pe8l-C1rkh_mDX7KI8g7Hu4-dWS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds a targeted regression test which could cause data abort
exception to hit on latest kernel with fast_commit enabled.

ext4_mb_mark_bb() does not takes care of block boundary overflow of a given
block group while doing set/clear in buffer_head bitmap during
fast_commit recovery (after a sudden shutdown).

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/056     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   3 ++
 2 files changed, 104 insertions(+)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..588e8af8
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,101 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
+#
+# FS QA Test 056
+#
+# regression testing to test kernel crash with fast_commit feature.
+# (based on example from tests/generic/468)
+# commit: https://patchwork.ozlabs.org/patch/1586856
+#
+
+. ./common/preamble
+_begin_fstest auto quick log
+
+# Override the default cleanup function.
+_cleanup()
+{
+   cd /
+   rm -r -f $tmp.*
+   _scratch_unmount > /dev/null 2>&1
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+_require_scratch_shutdown
+_require_scratch_ext4_feature "fast_commit"
+
+testfile1=$SCRATCH_MNT/testfile1
+testfile2=$SCRATCH_MNT/testfile2
+blocksize=4096
+
+$MKFS_EXT4_PROG -F -b $blocksize -O fast_commit $SCRATCH_DEV 5G >> $seqres.full 2>&1 ||
+	_notrun "Require 5G disk space"
+
+_scratch_mount >> $seqres.full 2>&1
+
+check_stat_before_after()
+{
+	before="$1"
+	after="$2"
+
+	if [ "$before" != "$after" ]; then
+		echo "Before: $before"
+		echo "After : $after"
+	fi
+	echo "Before: $before" >> $seqres.full
+	echo "After : $after" >> $seqres.full
+}
+
+#
+# Idea is to create a file of 5M & write 5M of data followed by fsync.
+# Then falloc extra blocks (with -k) such that the blocks extend the block group
+# boundary considerably, followed by fsync, followed by shutdown.
+# This will trigger fast_commit recovery and will help test kernel crash w/o
+# fix.
+#
+fact=10
+echo "Test-1: fsync shutdown recovery test"
+$XFS_IO_PROG -f -c "truncate $((5*1024*1024))" \
+			-c "pwrite 0 $((5*1024*1024))" \
+			-c "fsync"  \
+			-c "falloc -k $((5*1024*1024)) $((32768*$blocksize*$fact))" \
+			$testfile1 >> $seqres.full 2>&1
+
+stat_opt='-c "b: %b s: %s a: %x m: %y c: %z"'
+before=$(stat "$stat_opt" "$testfile1")
+
+$XFS_IO_PROG -c "fsync" $testfile1
+_scratch_shutdown -v >> $seqres.full 2>&1
+_scratch_cycle_mount >> $seqres.full 2>&1
+
+after=$(stat "$stat_opt" $testfile1)
+
+check_stat_before_after "$before" "$after"
+
+echo "Test-2: fdatasync shutdown recovery test"
+$XFS_IO_PROG -f -c "truncate $((5*1024*1024))" \
+			-c "pwrite 0 $((5*1024*1024))" \
+			-c "fsync"  \
+			-c "falloc -k $((5*1024*1024)) $((32768*$blocksize*$fact))" \
+			$testfile2 >> $seqres.full 2>&1
+
+stat_opt='-c "b: %b s: %s"'
+before=$(stat "$stat_opt" $testfile2)
+
+$XFS_IO_PROG -c "fdatasync" $testfile2
+_scratch_shutdown -v >> $seqres.full 2>&1
+_scratch_cycle_mount >> $seqres.full 2>&1
+
+after=$(stat "$stat_opt" "$testfile2")
+check_stat_before_after "$before" "$after"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/056.out b/tests/ext4/056.out
new file mode 100644
index 00000000..0a793a4c
--- /dev/null
+++ b/tests/ext4/056.out
@@ -0,0 +1,3 @@
+QA output created by 056
+Test-1: fsync shutdown recovery test
+Test-2: fdatasync shutdown recovery test
-- 
2.31.1

