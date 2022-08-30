Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0715A6280
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Aug 2022 13:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiH3LxZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Aug 2022 07:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiH3LxK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Aug 2022 07:53:10 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C81A8337
        for <linux-ext4@vger.kernel.org>; Tue, 30 Aug 2022 04:53:08 -0700 (PDT)
Received: from canpemm500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MH5Gm6NtLznTsc;
        Tue, 30 Aug 2022 19:50:40 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500004.china.huawei.com
 (7.192.104.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 30 Aug
 2022 19:53:06 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <lczerner@redhat.com>,
        <linux-ext4@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 12/13] ext4: factor out ext4_load_and_init_journal()
Date:   Tue, 30 Aug 2022 20:04:10 +0800
Message-ID: <20220830120411.2371968-13-yanaijie@huawei.com>
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

This patch group the journal load and initialize code together and
factor out ext4_load_and_init_journal(). This patch also removes the
lable 'no_journal' which is not needed after refactor.

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ext4/super.c | 157 +++++++++++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 69 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 40f155543df0..95e70f0316db 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4823,6 +4823,93 @@ static int ext4_group_desc_init(struct super_block *sb,
 	return ret;
 }
 
+static int ext4_load_and_init_journal(struct super_block *sb,
+				      struct ext4_super_block *es,
+				      struct ext4_fs_context *ctx)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	int err;
+
+	err = ext4_load_journal(sb, es, ctx->journal_devnum);
+	if (err)
+		return err;
+
+	if (ext4_has_feature_64bit(sb) &&
+	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
+				       JBD2_FEATURE_INCOMPAT_64BIT)) {
+		ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
+		goto out;
+	}
+
+	if (!set_journal_csum_feature_set(sb)) {
+		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
+			 "feature set");
+		goto out;
+	}
+
+	if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
+		!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
+					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
+		ext4_msg(sb, KERN_ERR,
+			"Failed to set fast commit journal feature");
+		goto out;
+	}
+
+	/* We have now updated the journal if required, so we can
+	 * validate the data journaling mode. */
+	switch (test_opt(sb, DATA_FLAGS)) {
+	case 0:
+		/* No mode set, assume a default based on the journal
+		 * capabilities: ORDERED_DATA if the journal can
+		 * cope, else JOURNAL_DATA
+		 */
+		if (jbd2_journal_check_available_features
+		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
+			set_opt(sb, ORDERED_DATA);
+			sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
+		} else {
+			set_opt(sb, JOURNAL_DATA);
+			sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
+		}
+		break;
+
+	case EXT4_MOUNT_ORDERED_DATA:
+	case EXT4_MOUNT_WRITEBACK_DATA:
+		if (!jbd2_journal_check_available_features
+		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
+			ext4_msg(sb, KERN_ERR, "Journal does not support "
+			       "requested data journaling mode");
+			goto out;
+		}
+		break;
+	default:
+		break;
+	}
+
+	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
+	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
+		ext4_msg(sb, KERN_ERR, "can't mount with "
+			"journal_async_commit in data=ordered mode");
+		goto out;
+	}
+
+	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
+
+	sbi->s_journal->j_submit_inode_data_buffers =
+		ext4_journal_submit_inode_data_buffers;
+	sbi->s_journal->j_finish_inode_data_buffers =
+		ext4_journal_finish_inode_data_buffers;
+
+	return 0;
+
+out:
+	/* flush s_error_work before journal destroy. */
+	flush_work(&sbi->s_error_work);
+	jbd2_journal_destroy(sbi->s_journal);
+	sbi->s_journal = NULL;
+	return err;
+}
+
 static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 {
 	struct buffer_head *bh;
@@ -5182,7 +5269,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	 * root first: it may be modified in the journal!
 	 */
 	if (!test_opt(sb, NOLOAD) && ext4_has_feature_journal(sb)) {
-		err = ext4_load_journal(sb, es, ctx->journal_devnum);
+		err = ext4_load_and_init_journal(sb, es, ctx);
 		if (err)
 			goto failed_mount3a;
 	} else if (test_opt(sb, NOLOAD) && !sb_rdonly(sb) &&
@@ -5220,76 +5307,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 		clear_opt2(sb, JOURNAL_FAST_COMMIT);
 		sbi->s_journal = NULL;
 		needs_recovery = 0;
-		goto no_journal;
 	}
 
-	if (ext4_has_feature_64bit(sb) &&
-	    !jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
-				       JBD2_FEATURE_INCOMPAT_64BIT)) {
-		ext4_msg(sb, KERN_ERR, "Failed to set 64-bit journal feature");
-		goto failed_mount_wq;
-	}
-
-	if (!set_journal_csum_feature_set(sb)) {
-		ext4_msg(sb, KERN_ERR, "Failed to set journal checksum "
-			 "feature set");
-		goto failed_mount_wq;
-	}
-
-	if (test_opt2(sb, JOURNAL_FAST_COMMIT) &&
-		!jbd2_journal_set_features(EXT4_SB(sb)->s_journal, 0, 0,
-					  JBD2_FEATURE_INCOMPAT_FAST_COMMIT)) {
-		ext4_msg(sb, KERN_ERR,
-			"Failed to set fast commit journal feature");
-		goto failed_mount_wq;
-	}
-
-	/* We have now updated the journal if required, so we can
-	 * validate the data journaling mode. */
-	switch (test_opt(sb, DATA_FLAGS)) {
-	case 0:
-		/* No mode set, assume a default based on the journal
-		 * capabilities: ORDERED_DATA if the journal can
-		 * cope, else JOURNAL_DATA
-		 */
-		if (jbd2_journal_check_available_features
-		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
-			set_opt(sb, ORDERED_DATA);
-			sbi->s_def_mount_opt |= EXT4_MOUNT_ORDERED_DATA;
-		} else {
-			set_opt(sb, JOURNAL_DATA);
-			sbi->s_def_mount_opt |= EXT4_MOUNT_JOURNAL_DATA;
-		}
-		break;
-
-	case EXT4_MOUNT_ORDERED_DATA:
-	case EXT4_MOUNT_WRITEBACK_DATA:
-		if (!jbd2_journal_check_available_features
-		    (sbi->s_journal, 0, 0, JBD2_FEATURE_INCOMPAT_REVOKE)) {
-			ext4_msg(sb, KERN_ERR, "Journal does not support "
-			       "requested data journaling mode");
-			goto failed_mount_wq;
-		}
-		break;
-	default:
-		break;
-	}
-
-	if (test_opt(sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA &&
-	    test_opt(sb, JOURNAL_ASYNC_COMMIT)) {
-		ext4_msg(sb, KERN_ERR, "can't mount with "
-			"journal_async_commit in data=ordered mode");
-		goto failed_mount_wq;
-	}
-
-	set_task_ioprio(sbi->s_journal->j_task, ctx->journal_ioprio);
-
-	sbi->s_journal->j_submit_inode_data_buffers =
-		ext4_journal_submit_inode_data_buffers;
-	sbi->s_journal->j_finish_inode_data_buffers =
-		ext4_journal_finish_inode_data_buffers;
-
-no_journal:
 	if (!test_opt(sb, NO_MBCACHE)) {
 		sbi->s_ea_block_cache = ext4_xattr_create_cache();
 		if (!sbi->s_ea_block_cache) {
-- 
2.31.1

