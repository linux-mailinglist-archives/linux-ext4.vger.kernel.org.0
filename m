Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2029E19A
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Oct 2020 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgJ1Vsx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:48:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726080AbgJ1VnW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 28 Oct 2020 17:43:22 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S6VwT8041644;
        Wed, 28 Oct 2020 02:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Bbgs0Z0QSxiyBsuFYhMyOmSTvVA6L0TfO+yMN5+y2ds=;
 b=NZbdzUrG4jTNHFo5W/bU3UWfg2aaiw3VFlbGBBoh4HOOvbEk9gZAJdBNDIXJcbZDerKC
 nTVb49oxuFfZaaTl5D43pXQBEK2/Jz/u1RVeIWoLDhKHMSq/Jem07JH7nd0a/pngp2nd
 DewwQqgxf8WH5XDRo7W7VHXM7rUsMVYgXG2TeDO0x084dnvDmdaw1Ne+eEA2xRXyw1eN
 Wq8KQ2+uQ/gmt5fT8It31jn2ePARPeXpx8R3wzX9SAjRIcZNBs9m8RcIcU/j0vfc5vRz
 9KARPi/+SDY3sjw/SXv4AFT9MGVjpnKlpEFOGHgbHwABtOttUOrTkxZWmWbhsWtd8fI4 iw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34esjkf1hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 02:45:05 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09S6g2iJ017266;
        Wed, 28 Oct 2020 06:45:03 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 34esn307ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 06:45:02 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09S6j0a110420512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 06:45:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7BBB742047;
        Wed, 28 Oct 2020 06:45:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B599D42042;
        Wed, 28 Oct 2020 06:44:58 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.33.247])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Oct 2020 06:44:58 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, anju@linux.vnet.ibm.com,
        Eryu Guan <guan@eryu.me>,
        Christian Kujau <lists@nerdbynature.de>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/1] generic: Add test to check for mounting a huge sparse dm device
Date:   Wed, 28 Oct 2020 12:14:52 +0530
Message-Id: <daec44e9f2e3ce483b7845065db3bf148ff5cd2c.1603864280.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_01:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280038
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add this test (which Christian Kujau reported) to check for regression
caused due to ext4 bmap aops implementation was moved to use iomap APIs.
jbd2 calls bmap() kernel function from fs/inode.c which was failing since
iomap_bmap() implementation earlier returned 0 for block addr > INT_MAX.
This regression was fixed with following kernel commit [1]
commit b75dfde1212991b24b220c3995101c60a7b8ae74
("fibmap: Warn and return an error in case of block > INT_MAX")
[1]: https://patchwork.ozlabs.org/patch/1279914

w/o the kernel fix we get below error and mount fails

[ 1461.988701] run fstests generic/613 at 2020-10-27 19:57:34
[ 1530.511978] jbd2_journal_init_inode: Cannot locate journal superblock
[ 1530.513310] EXT4-fs (dm-1): Could not load journal inode

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc             | 10 +++++++
 tests/generic/613     | 66 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/613.out |  3 ++
 tests/generic/group   |  1 +
 4 files changed, 80 insertions(+)
 create mode 100755 tests/generic/613
 create mode 100644 tests/generic/613.out

diff --git a/common/rc b/common/rc
index 27a27ea36f75..b0c353c4c107 100644
--- a/common/rc
+++ b/common/rc
@@ -1607,6 +1607,16 @@ _require_scratch_size()
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
diff --git a/tests/generic/613 b/tests/generic/613
new file mode 100755
index 000000000000..b426ef91cacf
--- /dev/null
+++ b/tests/generic/613
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Christian Kujau. All Rights Reserved.
+# Copyright (c) 2020 Ritesh Harjani. All Rights Reserved.
+#
+# FS QA Test generic/613
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
+# For 1k bs with ext4, mkfs was failing maybe due to size limitation.
+if [ "$FSTYP" = "ext4" ]; then
+	export MKFS_OPTIONS="-F -b 4096"
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
diff --git a/tests/generic/613.out b/tests/generic/613.out
new file mode 100644
index 000000000000..4747b7596499
--- /dev/null
+++ b/tests/generic/613.out
@@ -0,0 +1,3 @@
+QA output created by 613
+wrote 1048576/1048576 bytes at offset 0
+XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/generic/group b/tests/generic/group
index 8054d874f005..360d145d2036 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -615,3 +615,4 @@
 610 auto quick prealloc zero
 611 auto quick attr
 612 auto quick clone
+613 auto mount quick
--
2.26.2

