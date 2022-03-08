Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC934D152B
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345979AbiCHKwf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345980AbiCHKw2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:28 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102AD43494
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m22so16839636pja.0
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvVTt2HEkb8f/xpc+LPElGJ0tdJkOFJQM6IGrmOPHdk=;
        b=Dd0X+1AhlaDPkblThdqSS3MhtJtQCvanUvNr10sTHaOMALZ3ssuDoY7ssgB6oVkBry
         FvltctVB/mRe9G30AFDdsR/p6WVyduG5ROWdQMb8nIj23rADn2kIshrmvA4ndy11JBq0
         cRsuEkXG4Ua5vUSIUNwvSt8G+0DT6fhjY6oixa4XGW/5KrYH3dY90G3SO7h0MwpQp9uI
         J+jKTPJq5Fs18blIzBj5Hsxrz0zu7jmgftzUUlBwMPdIT2yHdASvRVYyT8OdudM4VEzc
         3typFxCZR3IaQhg9wImABZzfCIAOnACbPRDK/CHpeN7Hn6Q9een6LI/eY8GBnOf3+plf
         /5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IvVTt2HEkb8f/xpc+LPElGJ0tdJkOFJQM6IGrmOPHdk=;
        b=NIhjxxk82hF6tzH0ekm5a1Fa0ve39fIokNcgIrCih9db4Qa4L/uAWj22rhbeAQpMX1
         QKylN18r53JENoU55xsJjOb89vwOTnXbfdSIBWX0Lll5nZVk/1Q4wNA8r1dfnjchero9
         TH9134q1BgmsnuBlvynBOHcJUuIMn5XyjKySrKtkJgGCxE9IdyqqRO5/7OVefigx1W81
         BA7vCHT0lQ++5SltVEbDkDYBONf/C9PSxYYMhLXiFOJ6rfJM/n4YKjch3AhBa59szhFv
         1w368nD3ubCCWlwGRStix4qyxrNzz9gfYhuzBpW9DAeoGerNUsqApfQoo7s+mKL+tkGQ
         54qw==
X-Gm-Message-State: AOAM5329oNGNAjkxTnQ7IUAa43Kyr7BlhIzlBMZx9mEYjA3niSncJ0je
        rhzY79rFnx2dpv/4DFDfiIpoJ7PsKMHwFF9h
X-Google-Smtp-Source: ABdhPJxT02MiABS4J8U7mA9SrhFqnPSSpgelWGZ1P1mCpFhjzD+Gh6loXWNXio62BMS7dAjm04CGUQ==
X-Received: by 2002:a17:902:f78d:b0:14f:ce61:eaf2 with SMTP id q13-20020a170902f78d00b0014fce61eaf2mr17350172pln.124.1646736691052;
        Tue, 08 Mar 2022 02:51:31 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:30 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 4/5] ext4: rework fast commit commit path
Date:   Tue,  8 Mar 2022 02:51:11 -0800
Message-Id: <20220308105112.404498-5-harshads@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
In-Reply-To: <20220308105112.404498-1-harshads@google.com>
References: <20220308105112.404498-1-harshads@google.com>
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
 fs/ext4/fast_commit.c | 79 ++++++++++++++++++++++---------------------
 fs/jbd2/journal.c     |  2 --
 2 files changed, 41 insertions(+), 40 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d69bf53bef21..831bb21dcb4f 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -203,31 +203,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	init_waitqueue_head(&ei->i_fc_wait);
 }
 
-/* This function must be called with sbi->s_fc_lock held. */
-static void ext4_fc_wait_committing_inode(struct inode *inode)
-__releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
-{
-	wait_queue_head_t *wq;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-#if (BITS_PER_LONG < 64)
-	DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
-			EXT4_STATE_FC_COMMITTING);
-	wq = bit_waitqueue(&ei->i_state_flags,
-				EXT4_STATE_FC_COMMITTING);
-#else
-	DEFINE_WAIT_BIT(wait, &ei->i_flags,
-			EXT4_STATE_FC_COMMITTING);
-	wq = bit_waitqueue(&ei->i_flags,
-				EXT4_STATE_FC_COMMITTING);
-#endif
-	lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	schedule();
-	finish_wait(wq, &wait.wq_entry);
-}
-
 /*
  * Remove inode from fast commit list. If the inode is being committed
  * we wait until inode commit is done.
@@ -242,20 +217,30 @@ void ext4_fc_del(struct inode *inode)
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
@@ -278,8 +263,6 @@ void ext4_fc_del(struct inode *inode)
 		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
 		kfree(fc_dentry->fcd_name.name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-
-	return;
 }
 
 /*
@@ -926,8 +909,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
-
 		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(ei->jinode);
 		if (ret)
@@ -1044,6 +1025,18 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	int ret = 0;
 	u32 crc = 0;
 
+	/* Lock the journal */
+	jbd2_journal_lock_updates(journal);
+	spin_lock(&sbi->s_fc_lock);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
+		spin_lock(&iter->i_fc_lock);
+		ext4_set_inode_state(&iter->vfs_inode,
+				     EXT4_STATE_FC_COMMITTING);
+		spin_unlock(&iter->i_fc_lock);
+	}
+	spin_unlock(&sbi->s_fc_lock);
+	jbd2_journal_unlock_updates(journal);
+
 	ret = ext4_fc_submit_inode_data_all(journal);
 	if (ret)
 		return ret;
@@ -1094,6 +1087,14 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		ret = ext4_fc_write_inode(inode, &crc);
 		if (ret)
 			goto out;
+		spin_lock(&iter->i_fc_lock);
+		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+		spin_unlock(&iter->i_fc_lock);
+#if (BITS_PER_LONG < 64)
+		wake_up_bit(&iter->i_state_flags, EXT4_STATE_FC_COMMITTING);
+#else
+		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
+#endif
 		spin_lock(&sbi->s_fc_lock);
 	}
 	spin_unlock(&sbi->s_fc_lock);
@@ -1227,13 +1228,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
-		list_del_init(&iter->i_fc_list);
+		spin_lock(&iter->i_fc_lock);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
+		spin_unlock(&iter->i_fc_lock);
 		if (iter->i_sync_tid <= tid)
 			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
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

