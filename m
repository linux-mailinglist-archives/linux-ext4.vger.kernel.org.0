Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84464AB735
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 10:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiBGJIV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 04:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242721AbiBGI6U (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 03:58:20 -0500
X-Greylist: delayed 1910 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:58:17 PST
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A097BC043185;
        Mon,  7 Feb 2022 00:58:17 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2175jKMi012901;
        Mon, 7 Feb 2022 08:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XtH5Lt5cujBteGNIfrsNm/vtsQZOEhV+jgmFaqnDsVA=;
 b=M+5fuNIDLbX04lhJHpWTreFbgew/qSwODrFvvyR+bYY4YLd+Y/bBTN73bYi2NKK1MCph
 jyK+LzQdg+m0ukaVq6SPoESHzYETkAQ11oKHcxuNb17J1gnLN54j8pJ8UQ5KfQVQFrN2
 CJbU6F25x5+tTS2gKuMFVH1Tk8qT5tISVH6bTelr+8VX0DF9imBtuRE9Si2+HDgWqdx4
 PbOlrl8Uv57JapQcIIzLd5NWaLa/C9X/i8dQc/yXdJvpqP1SyiA44m1WBgEYQCUoXCiV
 AeyA9vvJekWEwhnK68hEHcSgshN2h/GxntviqlXcfG1tG8SfdBv7hoMBB/8ucsb9tLVv fg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e23annpn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 08:26:31 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2178CsW5029243;
        Mon, 7 Feb 2022 08:26:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 3e1gv9s8kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 08:26:29 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2178QQkx27197760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 08:26:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 681BFA4069;
        Mon,  7 Feb 2022 08:26:26 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FD80A405B;
        Mon,  7 Feb 2022 08:26:23 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.26.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 08:26:22 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, riteshh@linux.ibm.com
Subject: [PATCH 2/2] ext4: Test to ensure resize with sparse_super2 is handled correctly
Date:   Mon,  7 Feb 2022 13:55:34 +0530
Message-Id: <aead63bfa6cca5a8a1c8225075f48a29d06df1ae.1644217569.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1644217569.git.ojaswin@linux.ibm.com>
References: <cover.1644217569.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AuCLskpZLx7KbRyjUU4eHotwmbrBIWB0
X-Proofpoint-ORIG-GUID: AuCLskpZLx7KbRyjUU4eHotwmbrBIWB0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202070053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kernel currently doesn't support resize of EXT4 mounted
with sparse_super2 option enabled. Earlier, it used to leave the resize
incomplete and the fs would be left in an inconsistent state, however commit
b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
-ENOTSUPP.

Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
resize for multiple iterations because this leads to kernel crash due to
fs corruption, which we want to detect.

Related commit in mainline:

[1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61

	ext4: add check to prevent attempting to resize an fs with sparse_super2

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 tests/ext4/056     | 102 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 2 files changed, 104 insertions(+)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..9185621d
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,102 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM. All Rights Reserved.
+#
+# We don't currently support resize of EXT4 filesystems mounted
+# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
+# incomplete and the fs would be left into an incomplete state, however commit
+# b1489186cc83 fixed this to avoid the fs corruption by clearly returning
+# -ENOTSUPP.
+#
+# This test ensures that kernel handles resizing with sparse_super2 correctly
+#
+# Related commit in mainline:
+#
+# commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
+# ext4: add check to prevent attempting to resize an fs with sparse_super2
+#
+
+. ./common/preamble
+_begin_fstest auto ioctl resize quick
+
+# real QA test starts here
+
+INITIAL_FS_SIZE=1G
+RESIZED_FS_SIZE=$((2*1024*1024*1024))  # 2G
+ONLINE_RESIZE_BLOCK_LIMIT=$((256*1024*1024))
+
+_supported_fs ext4
+_require_scratch_size $(($RESIZED_FS_SIZE/1024))
+_require_test_program "ext4_resize"
+
+_log()
+{
+	echo "$seq: $*" >> $seqres.full 2>&1
+}
+
+do_resize()
+{
+
+	$MKFS_PROG `_scratch_mkfs_options -t ext4 -E resize=$ONLINE_RESIZE_BLOCK_LIMIT \
+		-O sparse_super2` $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
+		|| _fail "$MKFS_PROG failed. Exiting"
+
+	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
+
+	BS=$(_get_block_size $SCRATCH_MNT)
+	NEW_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
+
+	local RESIZE_RET
+	local EOPNOTSUPP=95
+
+	$here/src/ext4_resize $SCRATCH_MNT $NEW_BLOCKS >> $seqres.full 2>&1
+	RESIZE_RET=$?
+
+	# Use $RESIZE_RET for logging
+	if [ $RESIZE_RET = 0 ]
+	then
+		_log "Resizing succeeded but FS might still be corrupt."
+	elif [ $RESIZE_RET = $EOPNOTSUPP ]
+	then
+		_log "Resize operation not supported with sparse_super2"
+		_log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
+
+	else
+		_log "Output of resize = $RESIZE_RET. Expected $EOPNOTSUPP (EOPNOTSUPP)"
+		_log "You might be missing kernel patch b1489186cc83"
+	fi
+
+	# unount after ioctl sometimes fails with "device busy" so add a small delay
+	sleep 0.1
+
+	_scratch_unmount >> $seqres.full 2>&1 || _fail "$UMOUNT_PROG failed. Exiting"
+}
+
+run_test()
+{
+	local FSCK_RET
+	local ITERS=8
+
+	for i in $(seq 1 $ITERS)
+	do
+		_log "----------- Iteration: $i ------------"
+		do_resize
+	done
+
+	_log "-------- Iterations Complete ---------"
+	_log "Checking if FS is in consistent state"
+	_check_scratch_fs
+	FSCK_RET=$?
+
+	return $FSCK_RET
+}
+
+run_test
+status=$?
+
+if [ "$status" -eq "0" ]
+then
+	echo "Test Succeeded!" | tee -a $seqres.full
+fi
+
+exit
diff --git a/tests/ext4/056.out b/tests/ext4/056.out
new file mode 100644
index 00000000..41706284
--- /dev/null
+++ b/tests/ext4/056.out
@@ -0,0 +1,2 @@
+QA output created by 056
+Test Succeeded!
-- 
2.27.0

