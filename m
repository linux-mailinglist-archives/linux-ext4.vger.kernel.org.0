Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A15A5A6281
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 13:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3Lx2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 07:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiH3LxL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 07:53:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9552A8949
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 04:53:08 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH5FN4gPPzkWch;
        Tue, 30 Aug 2022 19:49:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 19:53:06 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 13/13] ext4: factor out ext4_journal_data_check()
Date:   Tue, 30 Aug 2022 20:04:11 +0800
Message-ID: <20220830120411.2371968-14-yanaijie@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830120411.2371968-1-yanaijie@huawei.com>
References: <20220830120411.2371968-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500004.china.huawei.com (7.192.104.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Factor out ext4_journal_data_check(). No functional change.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 60 ++++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 95e70f0316db..c070d4f5ecc4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4910,6 +4910,39 @@ static int ext4_load_and_init_journal(struct super_block *sb,
 	return err;
 }
 
+static int ext4_journal_data_check(struct super_block *sb)
+{
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
+		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with "
+			    "data=journal disables delayed allocation, "
+			    "dioread_nolock, O_DIRECT and fast_commit support!\n");
+		/* can't mount with both data=journal and dioread_nolock. */
+		clear_opt(sb, DIOREAD_NOLOCK);
+		clear_opt2(sb, JOURNAL_FAST_COMMIT);
+		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
+			ext4_msg(sb, KERN_ERR, "can't mount with "
+				 "both data=journal and delalloc");
+			return -EINVAL;
+		}
+		if (test_opt(sb, DAX_ALWAYS)) {
+			ext4_msg(sb, KERN_ERR, "can't mount with "
+				 "both data=journal and dax");
+			return -EINVAL;
+		}
+		if (ext4_has_feature_encrypt(sb)) {
+			ext4_msg(sb, KERN_WARNING,
+				 "encrypted files will use data=ordered "
+				 "instead of data journaling mode");
+		}
+		if (test_opt(sb, DELALLOC))
+			clear_opt(sb, DELALLOC);
+	} else {
+		sb->s_iflags |= SB_I_CGROUPWB;
+	}
+
+	return 0;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh;
@@ -5033,31 +5066,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (ext4_encoding_init(sb, es))
 		goto failed_mount;
 
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA) {
-		printk_once(KERN_WARNING "EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!\n");
-		/* can't mount with both data=journal and dioread_nolock. */
-		clear_opt(sb, DIOREAD_NOLOCK);
-		clear_opt2(sb, JOURNAL_FAST_COMMIT);
-		if (test_opt2(sb, EXPLICIT_DELALLOC)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "both data=journal and delalloc");
-			goto failed_mount;
-		}
-		if (test_opt(sb, DAX_ALWAYS)) {
-			ext4_msg(sb, KERN_ERR, "can't mount with "
-				 "both data=journal and dax");
-			goto failed_mount;
-		}
-		if (ext4_has_feature_encrypt(sb)) {
-			ext4_msg(sb, KERN_WARNING,
-				 "encrypted files will use data=ordered "
-				 "instead of data journaling mode");
-		}
-		if (test_opt(sb, DELALLOC))
-			clear_opt(sb, DELALLOC);
-	} else {
-		sb->s_iflags |= SB_I_CGROUPWB;
-	}
+	if (ext4_journal_data_check(sb))
+		goto failed_mount;
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-- 
2.31.1

