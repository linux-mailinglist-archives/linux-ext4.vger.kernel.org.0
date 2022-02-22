Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876A24C0074
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 18:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiBVRvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 12:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiBVRvh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 12:51:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F241693AC;
        Tue, 22 Feb 2022 09:51:11 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MFfrOM026010;
        Tue, 22 Feb 2022 17:51:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=pA7fbVCrWaZOzvY9vqa9EjTA+Ti2CX2ZmtW1wya8qC8=;
 b=j/CtF/Px2Q+5WRRVgR6B1wemHZxN+3TL7nUevAXymxImfvNnks/mmBNp9SEJLRfUsZ7w
 UDJJd3XVgJqpo+yo+fdS+XiT+J/oIqkqCRZ26zzewVWQsetbu8khFtYXxnzM/CpjUFwr
 DaMrXizqUM9jnjg0e5CGrp8j1RMRWrz9s72PgnWXtg8k+IsH2wGuzpbgQ5c6en2kAjSc
 HpAq6wJSu0WTG04reH+4M+lKFP3n9o37+ae6p582PTUVsJ2yflbIYNKed6AJ04W1dBN9
 15OqbyH1DDH7ns/bpVRa5U1nvBM/lEg6vtJ9EdDfV9afq+Qrs5SBHBBL96EDWjyUIIzc FQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed2pruhxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MHl3AF016279;
        Tue, 22 Feb 2022 17:51:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3ear69bjeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:08 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MHePSk44892494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 17:40:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0F4BA4040;
        Tue, 22 Feb 2022 17:51:02 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56D9BA4057;
        Tue, 22 Feb 2022 17:51:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.41.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 17:51:01 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [PATCH v2 2/2] ext4: Test to ensure resize with sparse_super2 is handled correctly
Date:   Tue, 22 Feb 2022 23:20:53 +0530
Message-Id: <30fa381cac3dcc03b6fae4b9db5bf6c9a01f7bf6.1645549521.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1645549521.git.ojaswin@linux.ibm.com>
References: <cover.1645549521.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g6iMS8guzG-U1DDYnYU4Ca58Q_JcHUsB
X-Proofpoint-ORIG-GUID: g6iMS8guzG-U1DDYnYU4Ca58Q_JcHUsB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220107
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
-EOPNOTSUPP.

Test to ensure that kernel handles resizing with sparse_super2 correctly. Run
resize for multiple iterations because this sometimes leads to kernel crash due
to fs corruption, which we want to detect.

Related commit in mainline:

[1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61

	ext4: add check to prevent attempting to resize an fs with sparse_super2

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---

I would like to add a few comments on the approach followed in this
test:

1. So although we check the return codes of the resize operation for
	 proper logging, the test is only considered to be passed if fsck
	 passes after the resize. This is because resizing a patched kernel
	 always keeps the fs consistent whereas resizing on unpatched kernel
	 always corrupts the fs. 

2. I've noticed that running mkfs + resize multiple times on unpatched
	 kernel sometimes results in KASAN reporting use-after-free. Hence, if
	 we detect the kernel is unpatched (doesn't return EOPNOTSUPP on
	 resize) we continue iterating to capture this. In this case, we don't
	 run fsck in each iteration but run it only after all iterations are
	 complete because _check_scratch_fs exits the test if it fails.

3. In case we detect patched kernel, we stop iterating, and run fsck to
	 confirm success 

 tests/ext4/056     | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 2 files changed, 110 insertions(+)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

diff --git a/tests/ext4/056 b/tests/ext4/056
new file mode 100755
index 00000000..0f275dea
--- /dev/null
+++ b/tests/ext4/056
@@ -0,0 +1,108 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 IBM. All Rights Reserved.
+#
+# We don't currently support resize of EXT4 filesystems mounted
+# with sparse_super2 option enabled. Earlier, kernel used to leave the resize
+# incomplete and the fs would be left into an incomplete state, however commit
+# b1489186cc83[1] fixed this to avoid the fs corruption by clearly returning
+# -ENOTSUPP.
+#
+# This test ensures that kernel handles resizing with sparse_super2 correctly
+#
+# Related commit in mainline:
+#
+# [1] commit b1489186cc8391e0c1e342f9fbc3eedf6b944c61
+# 	ext4: add check to prevent attempting to resize an fs with sparse_super2
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
+STOP_ITER=255   # Arbitrary return code
+
+_supported_fs ext4
+_require_scratch_size $(($RESIZED_FS_SIZE/1024))
+_require_test_program "ext4_resize"
+
+log()
+{
+	echo "$seq: $*" >> $seqres.full 2>&1
+}
+
+do_resize()
+{
+	_mkfs_dev -E resize=$ONLINE_RESIZE_BLOCK_LIMIT -O sparse_super2 \
+		$SCRATCH_DEV $INITIAL_FS_SIZE >> $seqres.full 2>&1 \
+		|| _fail "$MKFS_PROG failed. Exiting"
+
+	_scratch_mount || _fail "Failed to mount scratch partition. Exiting"
+
+	local BS=$(_get_block_size $SCRATCH_MNT)
+	local REQUIRED_BLOCKS=$(($RESIZED_FS_SIZE/$BS))
+
+	local RESIZE_RET
+	local EOPNOTSUPP=95
+
+	log "Resizing FS"
+	$here/src/ext4_resize $SCRATCH_MNT $REQUIRED_BLOCKS >> $seqres.full 2>&1
+	RESIZE_RET=$?
+
+	# Test appears to be successful. Stop iterating and confirm if FS is
+	# consistent.
+	if [ $RESIZE_RET = $EOPNOTSUPP ]
+	then
+		log "Resize operation not supported with sparse_super2"
+		log "Threw expected error $RESIZE_RET (EOPNOTSUPP)"
+		return $STOP_ITER
+	fi
+
+	# Test appears to be unsuccessful. Most probably, the fs is corrupt,
+	# iterate a few more times to further stress test this.
+	log "Something is wrong. Output of resize = $RESIZE_RET. \
+		Expected $EOPNOTSUPP (EOPNOTSUPP)"
+
+	# unmount after ioctl sometimes fails with "device busy" so add a small
+	# delay
+	sleep 0.2
+	_scratch_unmount >> $seqres.full 2>&1 \
+		|| _fail "$UMOUNT_PROG failed. Exiting"
+}
+
+run_test()
+{
+	local FSCK_RET
+	local ITERS=8
+	local RET=0
+
+	for i in $(seq 1 $ITERS)
+	do
+		log "----------- Iteration: $i ------------"
+		do_resize
+		RET=$?
+
+		[ "$RET" = "$STOP_ITER" ] && break
+	done
+
+	log "-------- Iterations Complete ---------"
+	log "Checking if FS is in consistent state"
+	_check_scratch_fs
+	FSCK_RET=$?
+
+	[ "$FSCK_RET" -ne "0" ] && \
+		echo "fs corrupt. Check $seqres.full for more details"
+
+	return $FSCK_RET
+}
+
+echo "Silence is golden"
+run_test
+status=$?
+
+exit
diff --git a/tests/ext4/056.out b/tests/ext4/056.out
new file mode 100644
index 00000000..6142fcd2
--- /dev/null
+++ b/tests/ext4/056.out
@@ -0,0 +1,2 @@
+QA output created by 056
+Silence is golden
-- 
2.27.0

