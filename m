Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258AC56B80C
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 13:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237789AbiGHLJa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jul 2022 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbiGHLJ3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jul 2022 07:09:29 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9C5804B8;
        Fri,  8 Jul 2022 04:09:29 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LfVpq0wJPz1L9W0;
        Fri,  8 Jul 2022 19:06:59 +0800 (CST)
Received: from kwepemm600010.china.huawei.com (7.193.23.86) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 19:09:27 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600010.china.huawei.com
 (7.193.23.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Jul
 2022 19:09:26 +0800
From:   Sun Ke <sunke32@huawei.com>
To:     <fstests@vger.kernel.org>
CC:     <zlang@kernel.org>, <linux-ext4@vger.kernel.org>,
        <sunke32@huawei.com>
Subject: [PATCH v2 2/2] ext4: set 256 blocks in a block group then apply io pressure
Date:   Fri, 8 Jul 2022 19:21:55 +0800
Message-ID: <20220708112155.2639551-3-sunke32@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220708112155.2639551-1-sunke32@huawei.com>
References: <20220708112155.2639551-1-sunke32@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 tests/ext4/058     | 33 +++++++++++++++++++++++++++++++++
 tests/ext4/058.out |  2 ++
 2 files changed, 35 insertions(+)
 create mode 100755 tests/ext4/058
 create mode 100644 tests/ext4/058.out

diff --git a/tests/ext4/058 b/tests/ext4/058
new file mode 100755
index 00000000..b718c1ac
--- /dev/null
+++ b/tests/ext4/058
@@ -0,0 +1,33 @@
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
+_supported_fs ext4
+_fixed_by_kernel_commit a08f789d2ab5 \
+	"ext4: fix bug_on ext4_mb_use_inode_pa"
+_require_scratch
+
+# set 256 blocks in a block group
+_scratch_mkfs -g 256 >>$seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mount
+
+$FSSTRESS_PROG -d $SCRATCH_MNT/stress -n 1000 >> $seqres.full
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

