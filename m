Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177DC507693
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Apr 2022 19:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbiDSRfA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Apr 2022 13:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353834AbiDSRex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Apr 2022 13:34:53 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFE393C0
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:10 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t12so16440570pll.7
        for <linux-ext4@vger.kernel.org>; Tue, 19 Apr 2022 10:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrAkIi1J7AvRs5T8VP57+42mQc7Jp6i+BoH4fTdf41w=;
        b=pF+mKLIKL6Z7oEzeUuLPxZq8JcIcjaKitAFjnzT1dWaEQV8qDcaXeonIHDiFhnMN8Q
         aqnIDoX+mT+MdipD4FfZkTc1Iquz8RVdPQmb7Pmvs/C24SzQUrOdgLQp5iyzI+mCNZqk
         yAwtAEA2o0UpIhdeoECjhIP723r0kBHZeKWF+o9jUCzuGrCHfvUH/7FRDnBSYdr0mv6W
         kVpf6u27doa6STEKoas203NV74DhHenYIarfNUjjIVh0Xz5yc+4NNSy9VrfLhRvMKHO4
         z2XTEPNw11ffjUo9EVNLvRBuXbR+a7cO8FTURZAhgRlYS8jUKKl0AS5H/P/WahWPvW8Z
         gQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrAkIi1J7AvRs5T8VP57+42mQc7Jp6i+BoH4fTdf41w=;
        b=CJ+IQnF2A/NwzCKT0p/pYcQfkbiua10Mi4VFHy+Aotg6FeiQb7ViJKjNzXbztwB9De
         6P6mEvC/WACN25kCfZjZhbPN7R3YTZOIRAqnS0Se215UMgdfQr+zl6VfhLzNWeJrzDu7
         tL+cmxXfauRlHbmbE1rrvN3cCJ8gJRh+9jJGs3xPioewfpuwJpxLuODQkE/A3SOah9Cq
         EFHEMokzJsA31lqOp4WScBhyJPHege90I/7wuNURAn23fhY9YEhfPxncIjWJZvneeOd2
         K3YRgDaAnosm9196Uuep2fOYW4DtPTw4eAmNoaekkmsPhQXTdBy3y12UgBD5Ck+DVEL9
         8/RQ==
X-Gm-Message-State: AOAM532Ba4gd+M5W5mcHP9MCcmpCTH9+h2UwcFQEBkuKEfFeODiFExKV
        mfC+PZuo9wcIQwZBtlX+L+PFFSiKbgG3Sg==
X-Google-Smtp-Source: ABdhPJxN4IkguOt9n1bRQPRYBWJZf7Rgh6rtlHdETfos9n/Yh4I1NEt5ESZ8dMRcQIrIKUnyvkaRUA==
X-Received: by 2002:a17:903:2045:b0:158:c130:31b7 with SMTP id q5-20020a170903204500b00158c13031b7mr17430661pla.154.1650389529420;
        Tue, 19 Apr 2022 10:32:09 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:91ac:bc24:f886:dffc])
        by smtp.googlemail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm17266093pgn.70.2022.04.19.10.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:32:08 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 5/6] ext4: drop i_fc_updates from inode fc info
Date:   Tue, 19 Apr 2022 10:31:42 -0700
Message-Id: <20220419173143.3564144-6-harshads@google.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 70 -------------------------------------------
 2 files changed, 75 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 46ca0979e73b..dd8d1623fbac 100644
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
index 75f5abbf7c5d..266c95ff0d74 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -201,76 +201,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	init_waitqueue_head(&ei->i_fc_wait);
-	atomic_set(&ei->i_fc_updates, 0);
-}
-
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
 }
 
 /*
-- 
2.36.0.rc0.470.gd361397f0d-goog

