Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4125D57C410
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiGUGDQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiGUGDD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:03:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF6E7AB07
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f11so875374plr.4
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV09mUR7NPB7eGHDljRTvkjtRaYH2nALEITwnc5n28w=;
        b=Cdvhy/MKGUII3/qU50EOdqfATcKIX5hwsL8GfpvabwZKOI3h/UGcwXqDFplnvvBePa
         EFGkFIuxsmicr0QJvRC00IhNotbRHPrCgPpXHriCEk6Z/VO/XzaK9SDQSomI3TRGy65j
         ZZh4olytMlgiFWAHKfqRo30kFzp2XGTFRAP5DXAfYbZXG1nGzMwymjuyzqNLG/069y+f
         9qhfa6WkyMq/dCT5O+uLK0lxMbHXs0ZrCd72fFMnE1+deivJhs3mLf9M2VLiR/jC2LKt
         evcdbFtqK4ux594+qEPO6wEWXGkdacMlCgXwC9UHicT4p2/L3m2D8xJ1mFWj44c1LjnQ
         H4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV09mUR7NPB7eGHDljRTvkjtRaYH2nALEITwnc5n28w=;
        b=OiGiTT8+MAOGQl9SM1feEoOdjyZ7hEFRxPZ/B2XgIfQhWpIPRPC7zA2X6FKSEBg82r
         fPmZwHgayklc2udAQCYO0bXPffgHnJCtKvze9XMdJ4IowL/nJvKHe0pQQfpb8bsPieiV
         +ws2x+0XkSol54LOES00cxyD4ioVIDn/wSpffFf8lVm5qkxndT3h7/1u2xeolFzu26fb
         R/jQ27UFmt4SWTUqGnIRa3OelBFeISpb5Vi0HL+nHzcxKrZ5H5Uhzgc0RmcwS6EwGU+K
         GKCcn+M6UrN6TLTtQzMGCJS2zyb5KjE1rXrDW/Kpp5Ndq2iWrHfEL7EG0R7atuYd/Q0+
         7F/g==
X-Gm-Message-State: AJIora9z853yQ2GhS989t1SW7Zg53fNMRO3r6ihWo0qM3sY2pZOpJ3W5
        8MkNA//+xpSX0UCTxPHnsHhcShaFf8P4tYyg
X-Google-Smtp-Source: AGRyM1v6kgGK3stYDp48C/tb2eTC4mYRQ1q9IdgakJ+nrgbLLpt8YTQBAFvnXWchXh6QZYdrW1aM2Q==
X-Received: by 2002:a17:90b:4b8f:b0:1f0:7c99:10fd with SMTP id lr15-20020a17090b4b8f00b001f07c9910fdmr9509618pjb.86.1658383380329;
        Wed, 20 Jul 2022 23:03:00 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:59 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v4 6/8] ext4: drop i_fc_updates from inode fc info
Date:   Thu, 21 Jul 2022 06:02:44 +0000
Message-Id: <20220721060246.1696852-7-harshadshirwadkar@gmail.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 70 -------------------------------------------
 2 files changed, 75 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 12c8691f08d3..51ed372faff0 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1061,9 +1061,6 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
-	/* Number of ongoing updates on this inode */
-	atomic_t  i_fc_updates;
-
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -2882,8 +2879,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0307e21e5b29..a9cac460de26 100644
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
2.37.0.170.g444d1eabd0-goog

