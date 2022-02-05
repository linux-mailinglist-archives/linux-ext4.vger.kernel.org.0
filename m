Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08454AA96D
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 15:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380137AbiBEO3Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 09:29:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47362 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355500AbiBEO3X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 09:29:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215BS84M026407;
        Sat, 5 Feb 2022 14:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DOdkmKm1Y2btrP4rCP5FQCDxOI86sx/OHN8djhv4Gv8=;
 b=thMbseC/YZ2Z0qdLaisV/0T7XQZ5pVe10E7hwf7pgw19gp41Q6hma9wZ0tLzAMCe8o6V
 7GeB2UZnqwBfDW2F71FGocdNqqSz4BytgU6yKUPIH2D6dAV2NFYkRADgRsCHgMeYDOYp
 nM1kgfruGn0ylJZuPWyqf6/3TuemPqO5CBYhEnbG2fo1FuzoZ0D6htKpxO2aSs68TiPB
 GAFw6RbMpCxA9dMkEvPlme1bHSuwdPeh8e3vba/68Ng6JSgiy4bNt6PycIFoShTdd8KF
 CltXePMloTPt8i+X+8z4VxVpVeXbIm2D9/cjS3BVdaKGr/DhDzxZTdVtKu7O3QSzl+8m ZA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7mexse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:23 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215ERk2P022884;
        Sat, 5 Feb 2022 14:29:20 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3e1gv8t2pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215ETHqk47382786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:29:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7EE7842042;
        Sat,  5 Feb 2022 14:29:17 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C7034203F;
        Sat,  5 Feb 2022 14:29:16 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:29:16 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 3/4] ext4/057: Add crash test to check unwritten extents tracking with fast_commit
Date:   Sat,  5 Feb 2022 19:58:53 +0530
Message-Id: <0c28ae0676bf76d02d2b0edf092f55cb6d049737.1644070604.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644070604.git.riteshh@linux.ibm.com>
References: <cover.1644070604.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Hv93-zQ7okUoipHulrx6GII7AewXWRjT
X-Proofpoint-GUID: Hv93-zQ7okUoipHulrx6GII7AewXWRjT
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

fast_commit in certain cases as discussed in the corresponding kernel
commit may miss to track the unwritten extents. This patch add a test
case around that (based on test case shared in kernel commit)

5e4d0eba1ccaf19f
ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/057     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057.out |  6 +++++
 2 files changed, 68 insertions(+)
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..9d008b65
--- /dev/null
+++ b/tests/ext4/057
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM.  All Rights Reserved.
+#
+# FS QA Test 057
+#
+# Test for ext4 fast_commit crash recovery test fixed by below kernel commit.
+#
+# commit 5e4d0eba1ccaf19f
+# ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
+#
+. ./common/preamble
+_begin_fstest auto quick log shutdown
+
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	rm -r -f $tmp.*
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
+t1=$SCRATCH_MNT/t1
+
+$MKFS_EXT4_PROG -F -O 64bit,fast_commit $SCRATCH_DEV 512m >> $seqres.full 2>&1
+_scratch_mount >> $seqres.full 2>&1
+
+bs=$(_get_block_size $SCRATCH_MNT)
+
+# create and write data to t1
+$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io
+
+# fsync t1
+$XFS_IO_PROG -c "fsync" $t1
+
+# fzero certain range in between
+$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1 | _filter_xfs_io
+
+# fsync t1
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
diff --git a/tests/ext4/057.out b/tests/ext4/057.out
new file mode 100644
index 00000000..fc905de6
--- /dev/null
+++ b/tests/ext4/057.out
@@ -0,0 +1,6 @@
+QA output created by 057
+wrote 409600/409600 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+0: [0..39]: none
+1: [40..59]: unwritten
+2: [60..99]: nonelast
-- 
2.31.1

