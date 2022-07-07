Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DF756A406
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 15:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbiGGNqw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 09:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbiGGNqu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 09:46:50 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17C61A056;
        Thu,  7 Jul 2022 06:46:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LdyNj6RCXz1DDH7;
        Thu,  7 Jul 2022 21:45:57 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 21:46:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Jul
 2022 21:46:46 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH 1/2] ext4/057: resize fs after resize_inode without e2fsck
Date:   Thu, 7 Jul 2022 21:59:16 +0800
Message-ID: <20220707135917.373342-2-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220707135917.373342-1-sunke32@huawei.com>
References: <20220707135917.373342-1-sunke32@huawei.com>
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
check

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/057     | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/ext4/057.out |  2 ++
 2 files changed, 43 insertions(+)
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out

diff --git a/tests/ext4/057 b/tests/ext4/057
new file mode 100755
index 00000000..dacc14be
--- /dev/null
+++ b/tests/ext4/057
@@ -0,0 +1,41 @@
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
+_begin_fstest auto
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs ext4
+_require_scratch
+_require_command "$TUNE2FS_PROG" tune2fs
+_require_command "$RESIZE2FS_PROG" resize2
+
+
+# set fs size 3G
+dev_size=$((3 * 1024 * 1024 * 1024))
+_scratch_mkfs_sized $dev_size >/dev/null 2>&1
+
+# forget to run requested e2fsck after resize_inode
+$TUNE2FS_PROG -O ^resize_inode $SCRATCH_DEV >/dev/null 2>&1
+
+_scratch_mount
+
+# resize fs from 3G to 8G
+$RESIZE2FS_PROG $SCRATCH_DEV 8G >/dev/null 2>&1
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/057.out b/tests/ext4/057.out
new file mode 100644
index 00000000..185023c7
--- /dev/null
+++ b/tests/ext4/057.out
@@ -0,0 +1,2 @@
+QA output created by 057
+Silence is golden
-- 
2.13.6

