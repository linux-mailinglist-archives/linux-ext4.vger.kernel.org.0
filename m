Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27554D1D44
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbiCHQeh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348353AbiCHQeg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:36 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311B50479
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:36 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d17so8935785pfv.6
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3g8xwiafbXVjM4nIfugn8PU3H0lmTrt8i93qpTMpsU=;
        b=kPNd71QY8yX0JZH7dwltpUDI1Bc94mo4aoewcV034X5bFXqXjzt7Qsb2ga357Dadln
         RWd2oSRGnLFKcgHlvDBXtmqwln9UadXDgc7kEhSYK3xv+0ktpwe6jZcvhws+7Yh6KXzO
         rUZytw71w6Q5k6pE7UYYnMcMkXhy9+StgEKUQsrfnkUm/HVRTVdX2lKKuud/RKaNpyq7
         Uj6Qah2XGzX55GojS2iyeM6rBw6VcSmmCIBef9SSHhSTqNxJU7vyNxBHDgZu5akjH1Lk
         qMgVQd9y4R0Smv2pkaOR93W0SAuZW9Dr08D3st5i0kqJBp8HFX/dzO+LxYM85oTjZoNU
         EmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3g8xwiafbXVjM4nIfugn8PU3H0lmTrt8i93qpTMpsU=;
        b=Ezj7lpwzywAayxisfuUj9Rj6rwyAiXZ9CK4Lj6LB+oPaGC5N5IOay3qezPBmO6IvCX
         27LPaGcUtAdRNQWfva/dcM/hDpl9TuufB3e1hSpGfyprZnYXEz8C+CCTJ1+vob1jUP8+
         +T0Tf4+PfLIJoXb40Y1mcWw8ZhYdZgE+f5tF/5YfWzi/Uq6DICr5HtZY6RYW69l4wmYH
         DhyYh27OR5UAC5nYG5B/gQFQjEdhN8qMAh5LjLN3RR8QJFy9wBZVGgZP0cKOAjRMlnaX
         4XRDOTFYsQX8XhCUYLwRk9zGpJgrnkJDwgHlVV0D+om5sSYghgJu9qC+/7dR6EI77dgK
         64Vw==
X-Gm-Message-State: AOAM5301bIdHAmwn1TonDwZyaYkLiuCUVYKh4XBs6NBrcDpfBivALhwz
        Zuga1AndV9yJMrP+eGvYDyRu7oZfPAbJBGdO
X-Google-Smtp-Source: ABdhPJxgpbk9QXAAUrNCxtjN9ENLaGrETZQA1eDUZfo0T9DNLWrniAH95ZKs6MBcwDf4qaA88vZtYw==
X-Received: by 2002:a62:8ccb:0:b0:4f6:ee14:9c1e with SMTP id m194-20020a628ccb000000b004f6ee149c1emr14367038pfd.19.1646757215098;
        Tue, 08 Mar 2022 08:33:35 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:34 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 1/5] ext4: convert i_fc_lock to spinlock
Date:   Tue,  8 Mar 2022 08:33:15 -0800
Message-Id: <20220308163319.1183625-2-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308163319.1183625-1-harshads@google.com>
References: <20220308163319.1183625-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 28 +++++++++++++++-------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3f87cca49f0c..fb6d65f1176f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1065,8 +1065,11 @@ struct ext4_inode_info {
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
-	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
-	struct mutex i_fc_lock;
+	/*
+	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
+	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
+	 */
+	spinlock_t i_fc_lock;
 
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5ac594e03402..9913de655b61 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -387,7 +387,7 @@ static int ext4_fc_track_template(
 		return -EINVAL;
 
 	tid = handle->h_transaction->t_tid;
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -395,7 +395,7 @@ static int ext4_fc_track_template(
 		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(inode, args, update);
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
 		return ret;
@@ -427,11 +427,11 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	struct dentry *dentry = dentry_update->dentry;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
 		ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_NOMEM, NULL);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
 
@@ -444,7 +444,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(inode->i_sb,
 				EXT4_FC_REASON_NOMEM, NULL);
-			mutex_lock(&ei->i_fc_lock);
+			spin_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
 		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
@@ -478,7 +478,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
 	spin_unlock(&sbi->s_fc_lock);
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 
 	return 0;
 }
@@ -580,10 +580,8 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 	struct __track_range_args *__arg =
 		(struct __track_range_args *)arg;
 
-	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
-		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
 		return -ECANCELED;
-	}
 
 	oldstart = ei->i_fc_lblk_start;
 
@@ -867,15 +865,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	struct ext4_extent *ex;
 	int ret;
 
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (ei->i_fc_lblk_len == 0) {
-		mutex_unlock(&ei->i_fc_lock);
+		spin_unlock(&ei->i_fc_lock);
 		return 0;
 	}
 	old_blk_size = ei->i_fc_lblk_start;
 	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
 	ei->i_fc_lblk_len = 0;
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
 	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
@@ -972,9 +970,13 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		spin_lock(&pos->i_fc_lock);
 		if (!ext4_test_inode_state(&pos->vfs_inode,
-					   EXT4_STATE_FC_COMMITTING))
+					   EXT4_STATE_FC_COMMITTING)) {
+			spin_unlock(&pos->i_fc_lock);
 			continue;
+		}
+		spin_unlock(&pos->i_fc_lock);
 		spin_unlock(&sbi->s_fc_lock);
 
 		ret = jbd2_wait_inode_data(journal, pos->jinode);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1e5f4994fe57..38d63113c383 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1346,7 +1346,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.35.1.616.g0bdcbb4464-goog

