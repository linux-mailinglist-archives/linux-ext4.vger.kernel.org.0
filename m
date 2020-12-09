Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1972D3969
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Dec 2020 05:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgLIEEg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 23:04:36 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgLIEEg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 23:04:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B942AMd016067;
        Tue, 8 Dec 2020 23:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=AsnMMUjxtiyADZpc5hylXyUZvdur9rYhvhs5q29HBxg=;
 b=Y8bvT4X6gr6zk3nfNMJYcheDI5WNseVO4Grjx/2tCbAn8zdRTGjnvR5Gg/qCwQnuxjB4
 44dGZHPjXCC01Y7/mFN2Ciu4ZfRLkV/K72021aZ+vRKQ2OuGylZK3IsqSKlPJR4wmhgJ
 dlOaTz6Y68Sdq64Vzz/2WVb/3DytMx/GdReEzdWgnp0mq8Cm2mEJrQI0hFSAsvXzq5BO
 2fFf3sh+c1HfVRPwKXwHXrzt8dzZkGh17/ZYFLJinCY9NoWjC5t13qy6jNA3w/d8YI7q
 cXvlveOfx3fbmQOxTM0GJQJWYwRwDGNpNhgipsmppArbksgpp+uXmHG16GY3pP8lHTW5 GA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35apm00rqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 23:03:49 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B942EIj016302;
        Wed, 9 Dec 2020 04:03:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3583svm2wp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Dec 2020 04:03:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B943jwp26542476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Dec 2020 04:03:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8BF52054;
        Wed,  9 Dec 2020 04:03:45 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.34.110])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 671645204F;
        Wed,  9 Dec 2020 04:03:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, anju@linux.vnet.ibm.com, lists@nerdbynature.de,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 1/1] generic: Add test to check for mounting a huge sparse dm device
Date:   Wed,  9 Dec 2020 09:33:41 +0530
Message-Id: <4e4755473e28f8d662bc709b909e25cab0785604.1607486295.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_02:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090023
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
v2->v3: Addressed review comments from Eryu [1]
[1]: https://patchwork.kernel.org/patch/11951463
 common/rc             | 31 ++++++++++++++++++++++
 tests/generic/620     | 62 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/620.out |  3 +++
 tests/generic/group   |  1 +
 4 files changed, 97 insertions(+)
 create mode 100755 tests/generic/620
 create mode 100644 tests/generic/620.out

diff --git a/common/rc b/common/rc
index 5911a6c89a78..33b5b598a198 100644
--- a/common/rc
+++ b/common/rc
@@ -1608,6 +1608,37 @@ _require_scratch_size()
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
+
+# require scratch fs which supports >16T of filesystem size.
+_require_scratch_16T_support()
+{
+	case $FSTYP in
+	ext2|ext3|f2fs)
+		_notrun "$FSTYP doesn't support >16T filesystem"
+		;;
+	ext4)
+		_scratch_mkfs >> $seqres.full 2>&1
+		_scratch_mount
+		local blocksize=$(_get_block_size $SCRATCH_MNT)
+		if [ $blocksize -lt 4096 ]; then
+			_notrun "This test requires >16T fs support"
+		fi
+		_scratch_unmount
+		;;
+	*)
+		;;
+	esac
+}

 # this test needs a test partition - check we're ok & mount it
 #
diff --git a/tests/generic/620 b/tests/generic/620
new file mode 100755
index 000000000000..ad63fa9ab4e6
--- /dev/null
+++ b/tests/generic/620
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
+# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
+#
+# FS QA Test generic/620
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
+_require_scratch_16T_support
+_require_scratch_size_nocheck $((4 * 1024 * 1024)) #kB
+_require_dmhugedisk
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
diff --git a/tests/generic/620.out b/tests/generic/620.out
new file mode 100644
index 000000000000..9a51e9e2cb8c
--- /dev/null
+++ b/tests/generic/620.out
@@ -0,0 +1,3 @@
+QA output created by 620
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 15a2f40e2520..d8758d7f6a5f 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -622,3 +622,4 @@
 617 auto rw io_uring stress
 618 auto quick attr
 619 auto rw enospc
+620 auto mount quick
--
2.26.2

