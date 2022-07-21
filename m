Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D6D57C411
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiGUGDR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiGUGDE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:03:04 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720287AB00
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id e16so817993pfm.11
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGAGNpawL/u7W8Xz6zunSJw4vTxtsiclV0M76QUq9aE=;
        b=ePiII6fqRq4HLP2bz2zP0693CqxfQQ6qgkVrqvEd0zDlET2JsD/Rwq0wvlllPBXsjZ
         TwbRzW4SrlDbqb6hs5Zc0/HI3/xk3pOET6ta0e50RZGiMr/bVgAmlnQjJSw0wjlCDY10
         i3QLURY4WafdJLJd8R2d37fU2r0nqE+d50LZr9IwS0cOXXZm6bn3y9jBCcVjJKEixQSN
         FtFTyPkJ/VXYAdVDY7RtgTWoUYDOQtox6maWojTRBO5P5twbF2qxM89PRTC+nxpW3UVV
         9VlGeDE9YriX3T2A+W28ExVgCLAoYihM7CPcG9SZ7avx9Ur98F92+Ot0oywrdmUwPB24
         V/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGAGNpawL/u7W8Xz6zunSJw4vTxtsiclV0M76QUq9aE=;
        b=RTXXZFtmxxLluoE488hPlGK1/WsW+rsfVhLqT+QZRgZU/IaNu3uVQ6JXzlhYfxi7Br
         giNmYY9ccATMNwjIQd2QkFmjZKVtHYzNYIvr06m/Y0hNKaaNfDY9ykRZ9Tm9xd5Q6jGX
         XoPENM9RRvtvXIOuFd23BfZ+pPtAVG8FJBQtOQulttaNkDSJvlUeBgHNsJbTUSCHidWL
         B8K1lRJT+3zB6bN8OxIrJIoC5KgVGKckA8PN+mfRnushVUDIjmNxyXK3dggi9L5Sqkve
         Oh3bX6jpOkNsvdreVhq7/iRqnfxrWP60kqk4h6vU80e6Z1v5QDJqh+5DuXvS59ZAzC2j
         UBcw==
X-Gm-Message-State: AJIora8vW0WRNdQ99pk3VqRcNmvr2Qp4u5VR5kblwF55TVDRrPwxVCyw
        7calDKebKqvUGMihsNWEKdvTninRfDA+xCzy
X-Google-Smtp-Source: AGRyM1uTIZn8Ctj6tmUHxi2UdsYSKxvznxBQuQkrt8ZDXz81/gbYt4DP449GpBsDVCTt1ZtFY3RSfw==
X-Received: by 2002:a05:6a00:84e:b0:52b:a5fd:f0bc with SMTP id q14-20020a056a00084e00b0052ba5fdf0bcmr7066611pfk.86.1658383381460;
        Wed, 20 Jul 2022 23:03:01 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:03:00 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v4 7/8] ext4: add lockdep annotation in fc commit path
Date:   Thu, 21 Jul 2022 06:02:45 +0000
Message-Id: <20220721060246.1696852-8-harshadshirwadkar@gmail.com>
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

This patch adds lockdep annotation in fast commit commit path.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  9 +++++++++
 fs/ext4/fast_commit.c | 12 ++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 51ed372faff0..eabf0c9a3765 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1070,6 +1070,15 @@ struct ext4_inode_info {
 	 */
 	spinlock_t i_fc_lock;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	/*
+	 * Lockdep entity to track fast commit waiting dependencies. Any caller
+	 * who sets / resets EXT4_STATE_FC_COMMITTING flag should let lockdep
+	 * know that they are doing so by locking / unlocking fc_commit_map.
+	 */
+	struct lockdep_map	i_fc_commit_map;
+	struct lock_class_key	i_fc_commit_key;
+#endif
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a9cac460de26..727a87073e6a 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -201,6 +201,8 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	init_waitqueue_head(&ei->i_fc_wait);
+	lockdep_init_map(&ei->i_fc_commit_map, "i_fc_commit",
+			 &ei->i_fc_commit_key, 0);
 }
 
 /*
@@ -1061,6 +1063,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_COMMITTING);
+		mutex_acquire(&iter->i_fc_commit_map, 0, 0, _THIS_IP_);
 	}
 	spin_unlock(&sbi->s_fc_lock);
 	jbd2_journal_unlock_updates(journal);
@@ -1119,6 +1122,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+		mutex_release(&iter->i_fc_commit_map, _THIS_IP_);
 		/*
 		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
 		 * visible before we send the wakeup. Pairs with implicit
@@ -1266,8 +1270,12 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	spin_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
-		ext4_clear_inode_state(&iter->vfs_inode,
-				       EXT4_STATE_FC_COMMITTING);
+		if (ext4_test_inode_state(&iter->vfs_inode,
+						EXT4_STATE_FC_COMMITTING)) {
+			ext4_clear_inode_state(&iter->vfs_inode,
+					       EXT4_STATE_FC_COMMITTING);
+			mutex_release(&iter->i_fc_commit_map, _THIS_IP_);
+		}
 		if (iter->i_sync_tid <= tid)
 			ext4_fc_reset_inode(&iter->vfs_inode);
 		/*
-- 
2.37.0.170.g444d1eabd0-goog

