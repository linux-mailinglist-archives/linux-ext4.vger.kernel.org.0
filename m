Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B84D1D48
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348362AbiCHQep (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348365AbiCHQem (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:42 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3042F50E0B
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:39 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id c11so4524993pgu.11
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hkBFK5UIhzAU2q83FdXV4SDp4KTiJVRQe1MMt7tEGKE=;
        b=KrYwhZRoWC/yYQXwBjPcxK3/fRYkfhNbJ87NtTHlSwHK8jCO0QroDNtj3XQ4pAwgwX
         qETm08mp7Uj6SlK2/MIWb7cQRnvWygNk6/BP+GQY5zsuhPvwNeV7sa4bqFfSU7H+A4Yj
         YgC9CQc84M4FTJ8cNuJWVTP0JkfC0hk+m5f14op/X+/kc9l9vT9GxxJxPx30gcQ2tLja
         KBAmxP3xHyzgZkOZ8eOxmKmESeRfliewZM5NJr/7Ueznz32dd3MFxZZRenMV7h+PCFop
         fdD0+i1NBM/92mZqTZp5+L7iHqjw7r6LlLpc+Rr4N7AqpF/R7bGYt5epxoc4gdWdKVYD
         v5jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hkBFK5UIhzAU2q83FdXV4SDp4KTiJVRQe1MMt7tEGKE=;
        b=vwB5HlTKPOp4NU3b1URiJpYijg5cnZ/BXf91e/yNI7QnGbiTk6Yx5qFtPIfygxo5ol
         XBZHsltAePfjjX/jFBaM8aPFsZM9KlcilKqVXjHKV9+SvbWLKXGtiq0HGIqvlPJLxpFf
         DVpFeEMypVCD5b0Wgf0Pmnc0lNJn9Z5AoZhO53MHIG9Ahx+dnOsBTuRyeB5gm8WFN8oR
         ECLlvPLyCnbsH1UNQTWC1qQs/7cxw3TVttUeyrwxBnJDYiA6eXYVcbX2kyLQkHjYE48q
         PkaUVuoUTs6vPPWLhnOs10hVgYbfP1j7rho0BKPJk7x47ZzuSsMc+oGKYDLw2MRhQo2n
         h2uw==
X-Gm-Message-State: AOAM530cdlsCUdD6yj1fFUw2VEaBSMCo2RS9v5CA5HLdp11TqIRALdz3
        mF3BPi+z7WmoM+jIsTmNmxdid95IhZQEsIW4
X-Google-Smtp-Source: ABdhPJyIgxKXoUtmR3sWMWpj42TJAcr+WtuaMr7KI3qd3KbL355F8OSd2Iwyta2UoUke58CTrXpCjQ==
X-Received: by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP id b6-20020a056a00114600b004c9ede0725amr19420303pfm.35.1646757218072;
        Tue, 08 Mar 2022 08:33:38 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:36 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 3/5] ext4: rework fast commit commit path
Date:   Tue,  8 Mar 2022 08:33:17 -0800
Message-Id: <20220308163319.1183625-4-harshads@google.com>
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

This patch reworks fast commit's commit path to remove locking the
journal for the entire duration of a fast commit. Instead, we only lock
the journal while marking all the eligible inodes as "committing". This
allows handles to make progress in parallel with the fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/fast_commit.c | 77 ++++++++++++++++++++++++++-----------------
 fs/jbd2/journal.c     |  2 --
 2 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index be8c5b3456ec..eedcf8b4d47b 100644
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
@@ -964,19 +972,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
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
@@ -998,13 +993,9 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		spin_lock(&pos->i_fc_lock);
 		if (!ext4_test_inode_state(&pos->vfs_inode,
-					   EXT4_STATE_FC_COMMITTING)) {
-			spin_unlock(&pos->i_fc_lock);
+					   EXT4_STATE_FC_COMMITTING))
 			continue;
-		}
-		spin_unlock(&pos->i_fc_lock);
 		spin_unlock(&sbi->s_fc_lock);
 
 		ret = jbd2_wait_inode_data(journal, pos->jinode);
@@ -1093,6 +1084,16 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1143,6 +1144,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1276,13 +1289,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
2.35.1.616.g0bdcbb4464-goog

