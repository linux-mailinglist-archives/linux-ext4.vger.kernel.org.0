Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EE250769A
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbiDSRe7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350190AbiDSRew (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:52 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A2387A7
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso2574567pjj.2
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjRsC/YDA7+z/rnKixh0Ac+zg4HAF5I+ejCNfZn2tq8=;
        b=SjN9WNXoxYqXJLgzYA/vk5eCaUGXAXrdoAM9dqY3K2vN2wG0X+ylt7LZM30+MTnfy4
         rb92kZB71ppbstybZmxX7z2GbSsPlLOt68RRwfUMOyCbq0awm6yfB+aP8G19q6Q4Cqsw
         LmhA0a8ukHZ+ONpoM0I1VA/WI+Y3Y5+H2SSU73pso6tCfIiTIiBJklKQNMw6bgGE1nmu
         N9S/QTK84+rhQu4ECiw6AWsY09IdCPPr4qt/9ySIFoGEclJum7HVzXFe9refGAXTMZHd
         EItzz+rxFmKMJjyjyAsRsspGW77g7N3uCbhJweKmBfWHxEPUGFz4xjR3F3yFjegfqnI4
         Ym5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjRsC/YDA7+z/rnKixh0Ac+zg4HAF5I+ejCNfZn2tq8=;
        b=QLLkvwl5+3h2RAyY08tcL75b6zEB7NwL9s5POc96rDtQFZDDYTupu4wBNkaQorPqbT
         1jP1csSpSZXd/48cQ4glGgaLee/47xgmqM28D6zzwQSlhc1o5tUP6lYDd/iU/wdzkN2v
         AUVBAE27SrqGdZzGpj6EqJBIEJgWjamZh5sWOJ4aDL2M6eCf0FQlG8z+H6/abzzk4Ofj
         j9UZVqJLMuXJAJnfDZigE1f6DzkdUrc2U7w73v7HLcTTJ6B2SMo5drODPx8BMangXRYw
         U3mnX9JUTMkXR2Jqzx3akyO3bdeCuIQm9GxQhNkPHvtyen6MSOMaTjLnHmihI6/fciQh
         nBpg==
X-Gm-Message-State: AOAM530xV5lE190yFalpgrdnjTqcejY9KtIJ5U/Q5sYG2nWRgKbt8y2C
        pCG53q5FS1UVH1CPAZMX5sv0pEIthjI2mQ==
X-Google-Smtp-Source: ABdhPJytrq+YY5Xg5yDtBqtBIGxiFbwXesbb7sbaGVmsYmgQrpQsmq7aaT1oSTAqdUEwH66GPfoWFQ==
X-Received: by 2002:a17:90b:90:b0:1d2:b873:fdd with SMTP id bb16-20020a17090b009000b001d2b8730fddmr8539757pjb.207.1650389527614;
        Tue, 19 Apr 2022 10:32:07 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:06 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 4/6] ext4: rework fast commit commit path
Date:   Tue, 19 Apr 2022 10:31:41 -0700
Message-Id: <20220419173143.3564144-5-harshads@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
In-Reply-To: <20220419173143.3564144-1-harshads@google.com>
References: <20220419173143.3564144-1-harshads@google.com>
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

This patch reworks fast commit's commit path to remove locking the
journal for the entire duration of a fast commit. Instead, we only lock
the journal while marking all the eligible inodes as "committing". This
allows handles to make progress in parallel with the fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 71 ++++++++++++++++++++++++++++---------------
 fs/jbd2/journal.c     |  2 --
 2 files changed, 46 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 55f4c5ddd8e5..75f5abbf7c5d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -287,20 +287,30 @@ void ext4_fc_del(struct inode *inode)
 	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
 		return;
 
-restart:
 	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
 		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 		return;
 	}
 
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
-	}
-
-	if (!list_empty(&ei->i_fc_list))
-		list_del_init(&ei->i_fc_list);
+	/*
+	 * Since ext4_fc_del is called from ext4_evict_inode while having a
+	 * handle open, there is no need for us to wait here even if a fast
+	 * commit is going on. That is because, if this inode is being
+	 * committed, ext4_mark_inode_dirty would have waited for inode commit
+	 * operation to finish before we come here. So, by the time we come
+	 * here, inode's EXT4_STATE_FC_COMMITTING would have been cleared. So,
+	 * we shouldn't see EXT4_STATE_FC_COMMITTING to be set on this inode
+	 * here.
+	 *
+	 * We may come here without any handles open in the "no_delete" case of
+	 * ext4_evict_inode as well. However, if that happens, we first mark the
+	 * file system as fast commit ineligible anyway. So, even in that case,
+	 * it is okay to remove the inode from the fc list.
+	 */
+	WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)
+		&& !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE));
+	list_del_init(&ei->i_fc_list);
 
 	/*
 	 * Since this inode is getting removed, let's also remove all FC
@@ -323,8 +333,6 @@ void ext4_fc_del(struct inode *inode)
 		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
 		kfree(fc_dentry->fcd_name.name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -1013,19 +1021,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
-		while (atomic_read(&ei->i_fc_updates)) {
-			DEFINE_WAIT(wait);
-
-			prepare_to_wait(&ei->i_fc_wait, &wait,
-						TASK_UNINTERRUPTIBLE);
-			if (atomic_read(&ei->i_fc_updates)) {
-				spin_unlock(&sbi->s_fc_lock);
-				schedule();
-				spin_lock(&sbi->s_fc_lock);
-			}
-			finish_wait(&ei->i_fc_wait, &wait);
-		}
 		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(ei->jinode);
 		if (ret)
@@ -1138,6 +1133,16 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	int ret = 0;
 	u32 crc = 0;
 
+	/* Lock the journal */
+	jbd2_journal_lock_updates(journal);
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_COMMITTING);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+	jbd2_journal_unlock_updates(journal);
+
 	ret = ext4_fc_submit_inode_data_all(journal);
 	if (ret)
 		return ret;
@@ -1188,6 +1193,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		ret = ext4_fc_write_inode(inode, &crc);
 		if (ret)
 			goto out;
+		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+		/*
+		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+		 * visible before we send the wakeup. Pairs with implicit
+		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 */
+		smp_mb();
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
+#else
+		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
+#endif
 		spin_lock(&sbi->s_fc_lock);
 	}
 	spin_unlock(&sbi->s_fc_lock);
@@ -1325,13 +1342,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
-		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
 		if (iter->i_sync_tid <= tid)
 			ext4_fc_reset_inode(&iter->vfs_inode);
-		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
+		/*
+		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+		 * visible before we send the wakeup. Pairs with implicit
+		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 */
 		smp_mb();
+		list_del_init(&iter->i_fc_list);
 #if (BITS_PER_LONG < 64)
 		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
 #else
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index c2cf74b01ddb..06b885628b1c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -757,7 +757,6 @@ int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
 	}
 	journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
 	write_unlock(&journal->j_state_lock);
-	jbd2_journal_lock_updates(journal);
 
 	return 0;
 }
@@ -769,7 +768,6 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
 	write_lock(&journal->j_state_lock);
-- 
2.36.0.rc0.470.gd361397f0d-goog

