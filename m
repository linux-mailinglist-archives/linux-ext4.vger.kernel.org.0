Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987E34D1D49
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348365AbiCHQep (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348364AbiCHQem (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E7033890
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:40 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso2906325pjq.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPll1P7V9GBIOrJxOdF6hEwzL3wAJVuFpTywJr8/a3g=;
        b=BmOJ4Bh/pmOC6MzAQi/MFdX085SkkoDLAJ7XhMTZQDlsfmud9sr/BzoS9xG2/MIz6Y
         1Qz2qUI0dT8O/xvLvWma1Sq21X3Pl2aFiXnKTXCtPkagjZzm1rsuKG2mgmovRs8wMmao
         vrIUsvdMGUEnpHXBDkS84l9jpRygXzm4rAPiOUAqRPfZVW59ohg1xOCcpolGcdQWZnwm
         4aJ1X2busQIdq1Ugh2jsAcCPrkUwiuSz+doEQngDbJKsb5ipklciJqnvWnyWQO2rmbWn
         xFyMflPzeepCNH214uNl00dQbFcisPHVBAfQARCRdfdfj3CXB4Fl5l9RatY3rTY4iuqd
         V25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPll1P7V9GBIOrJxOdF6hEwzL3wAJVuFpTywJr8/a3g=;
        b=7+agyOLCJzF3eWAar9Dul3rDB0ebMkwLt7vJyu7bToiQ2NaxCh/9vT+m6Gl8vRetn9
         vYKmdhIoXCMH9xPktHQ2IzzOEp1FhFylYHo6fUBQBf8n9H4F2Z6bgvz99HPBA+X1A599
         fB6AghzELvi6qE/Lclukmhq8UQa3yIheT8SFMmEScFIiJYkHvADT+cEJUydT8wX8znYA
         s7AmRE9DOAdApov6xmE6w3p2c/1pdgE+pgAyycoKDeQZgN5197iQxAaaQIZ9vkwBtwtV
         RhRGph0TREh9D8LAPfzMBJ7vVZ6+J7i3fWx4PQNpzt6bymH6s1YkNko9CZVTWueQ5X8R
         T/aw==
X-Gm-Message-State: AOAM533ibGaHD4fSyXJmC5HQw/54d4lxK9za0fwlJ2sWZZTorlkyMKpl
        6y4+ovql7Fphi/a9kuwJb2VNBogDnWrU99Cc
X-Google-Smtp-Source: ABdhPJy5v2C/nV8LTZveqZywnla5y/zoVWLDDZkbauEXXvbsRH0uXQJ+QB9roQ1wkPccyx8u6PUP2g==
X-Received: by 2002:a17:903:228a:b0:151:ed55:39c8 with SMTP id b10-20020a170903228a00b00151ed5539c8mr10555071plh.53.1646757219470;
        Tue, 08 Mar 2022 08:33:39 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:38 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 4/5] ext4: drop i_fc_updates from inode fc info
Date:   Tue,  8 Mar 2022 08:33:18 -0800
Message-Id: <20220308163319.1183625-5-harshads@google.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 70 -------------------------------------------
 2 files changed, 75 deletions(-)

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
index eedcf8b4d47b..eea19e3ea9ba 100644
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
2.35.1.616.g0bdcbb4464-goog

