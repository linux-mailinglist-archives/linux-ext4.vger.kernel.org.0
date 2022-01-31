Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CA4A4AA8
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jan 2022 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379690AbiAaPev (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jan 2022 10:34:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27254 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1379701AbiAaPdx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 31 Jan 2022 10:33:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VEVomt027306;
        Mon, 31 Jan 2022 15:33:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=JC2iogRPytT4eUDlhTdHBzVKD2bWNrkTR7efl9xvFJU=;
 b=WOZzJSa3F+AVxMYTCr3/EkNja/b9nxtS52IosZ/sj5fNC1EHHHDGNxPJkQJ1swsqyce5
 Ac1+qAOK4R4j3lNKB1O6/am+oiLxR3WYPs3ISwHsCSkhXwn/EKleqn1G6wmXoZI6qvqI
 IGzoolNpVKZ8Hky+NtxOvHW1f6Vo820f4A9N8zfuKbqlrU2cvZ2WjiRcOFuYX0hWqRqF
 MPtouwfTyZGa8CXYUxqvz7gXrnjklDYpk/bDrltb6gXpA+tyZBgmTDOjtT/XA+ecC8p7
 c41s0h/qapcHPMgNb5ufjOcb28ar58ATR+F8B7mMZrPRrhTFWJ6xSuJlYAeASi+sGL5d SA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dxhm3sfqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:33:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20VFSDNa031243;
        Mon, 31 Jan 2022 15:33:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3dvw79cx34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 15:33:50 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20VFXld336307370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 15:33:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EFB342042;
        Mon, 31 Jan 2022 15:33:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F289542049;
        Mon, 31 Jan 2022 15:33:46 +0000 (GMT)
Received: from localhost (unknown [9.43.5.245])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Jan 2022 15:33:46 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC] ext4/056: Add fast_commit regression test causing data abort exception
Date:   Mon, 31 Jan 2022 21:03:42 +0530
Message-Id: <b834b83720f61a6aaab11fe20c48b75007be0a46.1643642943.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qki1lps2_EnUekg7DmBk_MWouaz5kW6n
X-Proofpoint-GUID: qki1lps2_EnUekg7DmBk_MWouaz5kW6n
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310101
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
 tests/ext4/056     | 103 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   3 ++
 2 files changed, 106 insertions(+)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..46562489
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,103 @@
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
+ _cleanup()
+ {
+	cd /
+	rm -r -f $tmp.*
+	_scratch_unmount > /dev/null 2>&1
+ }
+
+# Import common functions.
+ . ./common/filter
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
+$MKFS_EXT4_PROG -F -b $blocksize -O fast_commit $SCRATCH_DEV 5G >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+if [ $? -ne 0 ]; then
+	_notrun "requires ext4 fast_commit"
+fi
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

