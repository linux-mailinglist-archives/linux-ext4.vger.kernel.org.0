Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6C558209D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 09:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiG0G75 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 02:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiG0G7n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 02:59:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847763CBC6;
        Tue, 26 Jul 2022 23:59:42 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lt4NZ5JYMzmVBC;
        Wed, 27 Jul 2022 14:57:50 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Jul 2022 14:59:37 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Jul
 2022 14:59:36 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH v5] ext4: resize an ext4 which resize_inode feature is disabled but has reserved GDT blocks.
Date:   Wed, 27 Jul 2022 15:11:40 +0800
Message-ID: <20220727071140.3886185-1-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks
check"). Make sure there's not kernel crash, if resize an ext4 which
resize_inode feature is disabled but has reserved GDT blocks.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/057     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..969da377
--- /dev/null
+++ b/tests/ext4/057
@@ -0,0 +1,41 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test 057
+#
+# A regression test for b55c3cd102a6 ("ext4: add reserved GDT blocks check").
+# Make sure there's not kernel crash, if resize an ext4 which resize_inode
+# feature is disabled but has reserved GDT blocks.
+#
+. ./common/preamble
+_begin_fstest auto resize quick
+
+# real QA test starts here
+_supported_fs ext4
+_fixed_by_kernel_commit b55c3cd102a6 \
+	"ext4: add reserved GDT blocks check"
+
+_require_command "$RESIZE2FS_PROG" resize2fs
+_require_command "$DEBUGFS_PROG" debugfs
+_require_scratch_size_nocheck $((1024 * 1024))
+
+# Initalize a 512M ext4 fs with resize_inode feature disabled
+dev_size=$((512 * 1024 * 1024))
+MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
+	>>$seqres.full 2>&1 || _fail "mkfs failed"
+
+# Force some reserved GDT blocks to trigger the bug
+$DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
+	>>$seqres.full 2>&1
+$DEBUGFS_PROG -R "show_super_stats -h" $SCRATCH_DEV 2>/dev/null | \
+	grep "Reserved GDT blocks"
+
+_scratch_mount
+
+# Expect no crash from this resize operation
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

