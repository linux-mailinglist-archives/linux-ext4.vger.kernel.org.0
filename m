Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1B45809CF
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jul 2022 05:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiGZDKu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jul 2022 23:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiGZDKt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jul 2022 23:10:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD21220D5;
        Mon, 25 Jul 2022 20:10:48 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LsMJX3S7fzWfFv;
        Tue, 26 Jul 2022 11:06:52 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 11:10:34 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Jul
 2022 11:10:33 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH v4] ext4: resize fs after set reserved GDT blocks equals 100
Date:   Tue, 26 Jul 2022 11:22:40 +0800
Message-ID: <20220726032240.3709879-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Set reserved GDT blocks equals 100, then resize fs, will trigger null
pointer.

Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
check.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/057     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..f4bbcd32
--- /dev/null
+++ b/tests/ext4/057
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test 057
+#
+# Set reserved GDT blocks equals 100, then resize fs, will trigger null pointer.
+#
+# Regression test for commit
+# b55c3cd102a6 ext4: add reserved GDT blocks check
+#
+. ./common/preamble
+_begin_fstest auto resize quick
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_fixed_by_kernel_commit b55c3cd102a6 \
+	"ext4: add reserved GDT blocks check"
+
+_require_command "$TUNE2FS_PROG" tune2fs
+_require_command "$RESIZE2FS_PROG" resize2fs
+_require_command "$DEBUGFS_PROG" debugfs
+_require_scratch_size $((1024 * 1024)) #kB
+_require_scratch_nocheck
+
+# set fs size 512M
+dev_size=$((512 * 1024 * 1024))
+MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
+	>>$seqres.full 2>&1 || _fail "mkfs failed"
+
+$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
+	>>$seqres.full 2>&1
+
+$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
+	grep "Reserved GDT blocks"
+
+_scratch_mount
+
+# resize fs will trigger NULL pointer in ext4_flex_group_add
+$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/057.out b/tests/ext4/057.out
new file mode 100644
index 00000000..99423e16
--- /dev/null
+++ b/tests/ext4/057.out
@@ -0,0 +1,2 @@
+QA output created by 057
+Reserved GDT blocks:      100
-- 
2.13.6

