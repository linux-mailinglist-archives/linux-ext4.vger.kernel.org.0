Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990D72CEC6C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgLDKou (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 05:44:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53180 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729623AbgLDKot (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 05:44:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4A5gYc116731;
        Fri, 4 Dec 2020 05:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=G0o4U7l42ceBoZSOOLD9RruTYeOAbDLp15AUhCq8ddw=;
 b=JKFfoAgPSX0R8pCCiTrbjDByZ0mCpHjmrzMGb8/CTrXVUtUFlKZKFakUPB8VXchkiZ6R
 FEO4VmfQTY4gsfWoQt3qfF4pBEV+zmxZEPG6MWEqkcgueUM2HwVLJUeHnf6S9A9i0Bvb
 HJ+yiLZ115/pmfUH3Da49mO41FtJNwP7Q5qLMn8Ei1+ZR6F9ukcRKkcUZqDVAvw6UQ8l
 5JOxMlofRu8IT4YI7kXgF2UwQpcqr9SEsJzjbNj4lVNKLHITvJy7d+iHz15j1rM40AtF
 2CCC5ZOBsLKo6zTW/3OO9AvKGE5SPExcsildh4wKFa4TonGrPPWdG/fxSNlHRkA5M/VV Zg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3578amh3mq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 05:44:05 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B4AWogI022613;
        Fri, 4 Dec 2020 10:44:03 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 353e68b7f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 10:44:03 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B4Ai1lK59179276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 10:44:01 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61327A4055;
        Fri,  4 Dec 2020 10:44:01 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 036ADA4053;
        Fri,  4 Dec 2020 10:44:00 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.46.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Dec 2020 10:43:59 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-ext4@vger.kernel.org, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 2/2] generic: Add test to check for mounting a huge sparse dm device
Date:   Fri,  4 Dec 2020 16:13:54 +0530
Message-Id: <cc6f28972d73a50fb84a3797172ff44d396a6bef.1607078368.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607078368.git.riteshh@linux.ibm.com>
References: <cover.1607078368.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_03:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040057
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add this test to check for regression which was reported when ext4 bmap
aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
from fs/inode.c which was failing since iomap_bmap() implementation earlier
returned 0 for block addr > INT_MAX.
This regression was fixed with following kernel commit [1]
commit b75dfde1212991b24b220c3995101c60a7b8ae74
("fibmap: Warn and return an error in case of block > INT_MAX")
[1]: https://patchwork.ozlabs.org/patch/1279914

w/o the kernel fix we get below errors and mount fails

[ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
[ 1530.406645] ------------[ cut here ]------------
[ 1530.407332] would truncate bmap result
[ 1530.408956] WARNING: CPU: 0 PID: 6401 at fs/iomap/fiemap.c:116
iomap_bmap_actor+0x43/0x50
[ 1530.410607] Modules linked in:
[ 1530.411024] CPU: 0 PID: 6401 Comm: mount Tainted: G        W
<...>
 1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
 [ 1530.513310] EXT4-fs (dm-1): Could not load journal inode

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc             | 10 +++++++
 tests/generic/618     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/618.out |  3 ++
 tests/generic/group   |  1 +
 4 files changed, 84 insertions(+)
 create mode 100755 tests/generic/618
 create mode 100644 tests/generic/618.out

diff --git a/common/rc b/common/rc
index b5a504e0dcb4..128d75226958 100644
--- a/common/rc
+++ b/common/rc
@@ -1608,6 +1608,16 @@ _require_scratch_size()
 	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
 }
 
+# require a scratch dev of a minimum size (in kb) and should not be checked
+# post test
+_require_scratch_size_nocheck()
+{
+	[ $# -eq 1 ] || _fail "_require_scratch_size: expected size param"
+
+	_require_scratch_nocheck
+	local devsize=`_get_device_size $SCRATCH_DEV`
+	[ $devsize -lt $1 ] && _notrun "scratch dev too small"
+}
 
 # this test needs a test partition - check we're ok & mount it
 #
diff --git a/tests/generic/618 b/tests/generic/618
new file mode 100755
index 000000000000..45c14da80c06
--- /dev/null
+++ b/tests/generic/618
@@ -0,0 +1,70 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
+# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
+#
+# FS QA Test generic/618
+#
+# Since the test is not specific to ext4, hence adding it to generic.
+# Add this test to check for regression which was reported when ext4 bmap
+# aops was moved to use iomap APIs. jbd2 calls bmap() kernel function
+# from fs/inode.c which was failing since iomap_bmap() implementation earlier
+# returned 0 for block addr > INT_MAX.
+# This regression was fixed with following kernel commit [1]
+# commit b75dfde1212991b24b220c3995101c60a7b8ae74
+# ("fibmap: Warn and return an error in case of block > INT_MAX")
+# [1]: https://patchwork.ozlabs.org/patch/1279914
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	_dmhugedisk_cleanup
+	cd /
+	rm -f $tmp.*
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/dmhugedisk
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# Modify as appropriate.
+_supported_fs generic
+_require_dmhugedisk
+_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
+
+# For 1k bs with ext4, mkfs was failing due to size limitation and also it
+# becomes too slow when doing an mkfs on a huge sparse ext4 FS with 1k bs.
+# Hence on ext4 run only for 4K bs.
+if [ "$FSTYP" == "ext4" ]; then
+	_scratch_mkfs > /dev/null 2>&1
+	blksz=$(sudo debugfs -R stats $SCRATCH_DEV 2> /dev/null |grep "Block size" |cut -d ':' -f 2)
+	test $blksz -lt 4096 && _notrun "This test requires ext4 with minimum 4k bs"
+fi
+
+# 17TB dm huge-test-zer0 device
+# (in terms of 512 sectors)
+sectors=$((2*1024*1024*1024*17))
+chunk_size=128
+
+_dmhugedisk_init $sectors $chunk_size
+_mkfs_dev $DMHUGEDISK_DEV
+_mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for $DMHUGEDISK_DEV $SCRATCH_MNT"
+testfile=$SCRATCH_MNT/testfile-$seq
+
+$XFS_IO_PROG -fc "pwrite -S 0xaa 0 1m" -c "fsync" $testfile | _filter_xfs_io
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/618.out b/tests/generic/618.out
new file mode 100644
index 000000000000..b920fe4d907a
--- /dev/null
+++ b/tests/generic/618.out
@@ -0,0 +1,3 @@
+QA output created by 618
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 94e860b8c380..39e3ffb224a9 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -620,3 +620,4 @@
 615 auto rw
 616 auto rw io_uring stress
 617 auto rw io_uring stress
+618 auto mount quick
-- 
2.26.2

