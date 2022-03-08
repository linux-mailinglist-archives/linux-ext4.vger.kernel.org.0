Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50364D1529
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345996AbiCHKwc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbiCHKw0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:26 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671E643490
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:30 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s11so16960956pfu.13
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HCp1FHskvtMyIrX2agnH7JRCxJemMirq6JXUnUJo8iA=;
        b=KrcOqyiE3w59x8pmgoX8I6jifkJpVq7MNCIpFcyn3UBFztiLHS7ZmH4SRbZwZAs/GH
         TlImRmlXJd1jjmMht5nzIs598rJKrAM8QA5nXK1T1/r/rmKR+dmbitGXfA8OVYqCKcVb
         BX2/uedjoUtaQkp2TENVJrorclaVrzFR+xa8QDePEmqM4eEVeymEZk5nzGfIfQ2GBvBw
         BCwRVp7awqiJyRNPJkCjxgbGvRS3ZNMmdeGUc2lqMgMIqz+jRwBQY3XXRBVbozihyegh
         JMS/RBfQwY9aWEq4FekteoeyFveQ/CzVGkZ3gRsowWcOtpNMZIAdg28QmWgFllh1UOnH
         oaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HCp1FHskvtMyIrX2agnH7JRCxJemMirq6JXUnUJo8iA=;
        b=4OIwEaRmyR0b8sQ2Jj5vLH8W4fz6iudsAeiT59ypIweKxYBFIG/7PKxnzPIfIDzoRu
         4n3MSdH8i3uFDcuFmYoEP7LHwY7dwd3BsmFXpCdHuNpPjfzotwNC0pcQdLU32kAxU7Jq
         joJzCoYkdctZYaLMHCcipHjyBihO2ftGr72jSlg4VomjZWZ620I9CoAhM74jWp9X/9nM
         Q7osY5nXw9Xdr/jujpartywgeQ4bj/eKEiVwAu5Lv0Ebazuixii3/G2NEyBqJvRow2tO
         7UHPSYK9kfCj1r7PoGUANpQfFI1U4/freC8CE+s1Ig5RuzQyZkIu1i74ye2hhFGMvQiR
         rtfw==
X-Gm-Message-State: AOAM5323MmY9YYN/XbpCzEyAKrrOSOGwVPyAFcmh8CWxjDF41Cthygdm
        U+G4mFCT0TzKO/ryTBbdW0qUfAlTPrJk8gN7
X-Google-Smtp-Source: ABdhPJzhhdr84KHZQKx9qXn3NyVrladHaDNgWz/ElDTDz5jwpM3iruCw6YPprxxvRML3ODacZywclw==
X-Received: by 2002:a63:4b09:0:b0:372:c793:ab50 with SMTP id y9-20020a634b09000000b00372c793ab50mr13677681pga.495.1646736688602;
        Tue, 08 Mar 2022 02:51:28 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:27 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/5] ext4: drop i_fc_updates from inode fc info
Date:   Tue,  8 Mar 2022 02:51:09 -0800
Message-Id: <20220308105112.404498-3-harshads@google.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 58 +------------------------------------------
 2 files changed, 1 insertion(+), 62 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index fb6d65f1176f..6861a3127a42 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1059,9 +1059,6 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
-	/* Number of ongoing updates on this inode */
-	atomic_t  i_fc_updates;
-
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -2930,8 +2927,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4f2caf6f987c..a589fc415dbe 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -201,7 +201,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	init_waitqueue_head(&ei->i_fc_wait);
-	atomic_set(&ei->i_fc_updates, 0);
 }
 
 /* This function must be called with sbi->s_fc_lock held. */
@@ -229,50 +228,6 @@ __releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
 	finish_wait(wq, &wait.wq_entry);
 }
 
-/*
- * Inform Ext4's fast about start of an inode update
- *
- * This function is called by the high level call VFS callbacks before
- * performing any inode update. This function blocks if there's an ongoing
- * fast commit on the inode in question.
- */
-void ext4_fc_start_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	if (list_empty(&ei->i_fc_list))
-		goto out;
-
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
-	}
-out:
-	atomic_inc(&ei->i_fc_updates);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-}
-
-/*
- * Stop inode update and wake up waiting fast commits if any.
- */
-void ext4_fc_stop_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
-	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
-		return;
-
-	if (atomic_dec_and_test(&ei->i_fc_updates))
-		wake_up_all(&ei->i_fc_wait);
-}
-
 /*
  * Remove inode from fast commit list. If the inode is being committed
  * we wait until inode commit is done.
@@ -939,18 +894,7 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
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
+
 		spin_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(ei->jinode);
 		if (ret)
-- 
2.35.1.616.g0bdcbb4464-goog

