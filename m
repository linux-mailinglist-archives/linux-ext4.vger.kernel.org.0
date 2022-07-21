Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D3D57C40E
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiGUGDF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbiGUGDC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:03:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0529C7AB16
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so738741pgs.3
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gw1tvgmsX9USbUcdfOLPUt99Xa2Ep6XpIu5vjIGEUvo=;
        b=nCb28GiVKxZCIe7IIj0IF27PzIkSbJF7/pLTWMD/RL50OURnTVn3SFxGMIBqngVZ8Q
         gMBLW+X07ent8Scqm/NM7itoFSBBAViyuxjgwZSjm2n7JCh89deSsiUIUrFioYOS254x
         BpXrDWFJ5b6mN9URSsj5rfzNwusksWCxvflknrQyNGswIVD1mzLY+Dw84iLYuBFJf3T2
         yVm7R2Pgzb/VLUKVBq57bHJcgzvOaSEtBO5Tcd3RIMtKXW4dI2IuUbD+AQuI1V9uRAHK
         4mxfMtf/jnxtvjVdcnoXDjUCxsDnzlhQYC5iOwtvRGz5IYs5ECfDdMG7uMYGjKyFDmh1
         YRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gw1tvgmsX9USbUcdfOLPUt99Xa2Ep6XpIu5vjIGEUvo=;
        b=O+CoszHa+3VXHuRNApSLSWn63FEKOwcljt4eku/aD5Ybc4CNTuWbrh5t64geiSU42G
         06gWXevWqES5MrWpltjb3rUvFwyyHXEyl/u64Y9CUMlF4j6ZVj9QBtVixKOyvCkSsYm6
         leB21QHG97JVMVfxDIKwGAWjGegLY8FS4sM5FGe8rX2mAEnei5ehuTVubX3kcvLfgyUA
         2TljL62+1bnKmOq04ciaTYGhPuYcb9qzfcX6tJ7rX7O6QsqrO/vxtGTtCyLkhtxOnk5F
         dAzL/4f5id/0W096Onqi8cRWmhZP4uZK7Uo0H7CcUDZ0aQJyrjelb49GBBZ40wb2BkhV
         OZhA==
X-Gm-Message-State: AJIora+0gdx8rInXfopwkHUDjj7zbA7T/IB7ah2wKFXxaX93VumdqK+r
        eTQpR9UbGs34PR8sJ4A9hHuC+NwFr4Y0EczL
X-Google-Smtp-Source: AGRyM1vgncA7xegLkUWultJwUPcGnKYK1p9uDt7aHxEsetgPH5/UOHZIw7JZHzS6vOq558i+VKxxeg==
X-Received: by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP id j15-20020a056a00174f00b00525518e71d6mr43458840pfc.68.1658383377897;
        Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:57 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v4 4/8] ext4: rework fast commit commit path
Date:   Thu, 21 Jul 2022 06:02:42 +0000
Message-Id: <20220721060246.1696852-5-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
References: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch reworks fast commit's commit path to remove locking the
journal for the entire duration of a fast commit. Instead, we only lock
the journal while marking all the eligible inodes as "committing". This
allows handles to make progress in parallel with the fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fast_commit.c | 73 ++++++++++++++++++++++++++++---------------
 fs/jbd2/journal.c     |  2 --
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 916f62cfa7f7..608ae16afcd6 100644
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
@@ -1006,19 +1014,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 
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
@@ -1131,6 +1126,16 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1183,6 +1188,20 @@ static int ext4_fc_perform_commit(journal_t *journal)
 			goto out;
 		spin_lock(&sbi->s_fc_lock);
 	}
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
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
+	}
 	spin_unlock(&sbi->s_fc_lock);
 
 	ret = ext4_fc_write_tail(sb, crc);
@@ -1318,13 +1337,17 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
index c0cbeeaec2d1..64b56bf02c52 100644
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
2.37.0.170.g444d1eabd0-goog

