Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745D856A405
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Jul 2022 15:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiGGNqv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 09:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbiGGNqu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 09:46:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C188D1BEBE;
        Thu,  7 Jul 2022 06:46:49 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LdyMz1PkYzkWnD;
        Thu,  7 Jul 2022 21:45:19 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 7 Jul 2022 21:46:47 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Jul
 2022 21:46:47 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH 2/2] ext4/058: set 256 blocks in a block group Set 256 blocks in a block group
Date:   Thu, 7 Jul 2022 21:59:17 +0800
Message-ID: <20220707135917.373342-3-sunke32@huawei.com>
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

Set 256 blocks in a block group, then inject I/O pressure, it will
trigger off kernel BUG in ext4_mb_mark_diskspace_used.

Regression test for commit a08f789d2ab5 ext4: fix bug_on
ext4_mb_use_inode_pa.

Signed-off-by: Sun Ke <sunke32@huawei.com>
---
 tests/ext4/058     | 37 +++++++++++++++++++++++++++++++++++++
 tests/ext4/058.out |  2 ++
 2 files changed, 39 insertions(+)
 create mode 100755 tests/ext4/058
 create mode 100644 tests/ext4/058.out

diff --git a/tests/ext4/058 b/tests/ext4/058
new file mode 100755
index 00000000..dc7903b7
--- /dev/null
+++ b/tests/ext4/058
@@ -0,0 +1,37 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 HUAWEI.  All Rights Reserved.
+#
+# FS QA Test 058
+#
+# Set 256 blocks in a block group, then inject I/O pressure,
+# it will trigger off kernel BUG in ext4_mb_mark_diskspace_used
+#
+# Regression test for commit
+# a08f789d2ab5 ext4: fix bug_on ext4_mb_use_inode_pa 
+#
+. ./common/preamble
+_begin_fstest auto
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs generic
+_require_scratch
+_require_command "$KILLALL_PROG" killall
+
+# set 256 blocks in a block group
+MKFS_OPTIONS="-g 256"
+_scratch_mkfs >>$seqres.full 2>&1
+_scratch_mount
+
+$FSSTRESS_PROG -d $SCRATCH_MNT -n 1000 -p 1 >> $seqres.full 2>&1 &
+sleep 3
+$KILLALL_PROG -q $FSSTRESS_PROG
+wait
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/058.out b/tests/ext4/058.out
new file mode 100644
index 00000000..fb5ca60b
--- /dev/null
+++ b/tests/ext4/058.out
@@ -0,0 +1,2 @@
+QA output created by 058
+Silence is golden
-- 
2.13.6

