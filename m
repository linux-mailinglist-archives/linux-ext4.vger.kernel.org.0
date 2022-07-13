Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396C5573240
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jul 2022 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiGMJQu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jul 2022 05:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbiGMJQn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jul 2022 05:16:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A19EA179;
        Wed, 13 Jul 2022 02:16:39 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LjX4B5gDQzhZ8C;
        Wed, 13 Jul 2022 17:14:02 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Jul 2022 17:16:37 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Jul
 2022 17:16:37 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH v3 1/2] ext4: resize fs after resize_inode without e2fsck
Date:   Wed, 13 Jul 2022 17:28:58 +0800
Message-ID: <20220713092859.3881376-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220713092859.3881376-1-sunke32@huawei.com>
References: <20220713092859.3881376-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600010.china.huawei.com (7.193.23.86)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Forget to run requested e2fsck after resize_inode, then resize fs, it
will trigger off null pointer.

Regression test for commit b55c3cd102a6 ext4: add reserved GDT blocks
check.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/057     | 44 ++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057.out |  3 +++
 2 files changed, 47 insertions(+)
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..44dae76c
--- /dev/null
+++ b/tests/ext4/057
@@ -0,0 +1,44 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test 057
+#
+# Forget to run requested e2fsck after resize_inode, then resize fs,
+# it will trigger off null pointer.
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
+_require_scratch
+_require_command "$TUNE2FS_PROG" tune2fs
+_require_command "$RESIZE2FS_PROG" resize2fs
+_require_scratch_size $((1024 * 1024)) #kB
+
+# set fs size 512M
+dev_size=$((512 * 1024 * 1024))
+_scratch_mkfs_sized $dev_size >> $seqres.full 2>&1
+
+# forget to run requested e2fsck after resize_inode
+$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV | grep -w "e2fsck"
+
+_scratch_mount
+
+# resize fs will trigger NULL pointer in ext4_flex_group_add
+$RESIZE2FS_PROG $SCRATCH_DEV 1G >> $seqres.full 2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/057.out b/tests/ext4/057.out
new file mode 100644
index 00000000..4784ad7e
--- /dev/null
+++ b/tests/ext4/057.out
@@ -0,0 +1,3 @@
+QA output created by 057
+Please run e2fsck -f on the filesystem.
+Silence is golden
-- 
2.13.6

