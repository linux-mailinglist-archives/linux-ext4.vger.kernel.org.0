Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6154D1D45
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 17:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348355AbiCHQen (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 11:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348358AbiCHQej (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 11:34:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88C050E09
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 08:33:37 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id z3so9070824plg.8
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhGSBme3jnSuRV07Q4H/MQOgwQep++URNvm38wnCKNQ=;
        b=qaVXWhvJyxoJzb2pQj2u3B5GdBEZLXBtEJRVjcJ6Q4B+8WAVtbN63IIqBVurfbCNcX
         RqSQmd63oFZbH+bG5Ux7Fs5Ri9/LH/uitxAYkMlEd8WtTkjcI/vpwtQ9Ktam1uwCz2IZ
         2Y/Nn10JSKUskjPDU3hKv/mkdT2+p46crD5oNYAQcCPTo8p0Mk+EJJbN9Ba2asVDMRw2
         DCsvOQu/mdKy8GOhqdOpQeAuP2pkf2Aq1tIq8UOiaeD/pPIdjXOh9GQLUuf1JMFQjMAG
         gYpySp0uKdMW+zsVjTGjTp7K1SrOQMBuAS8+nJsXUAZKyhMBHikc2MZaJgMPgV/p0lBH
         cucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhGSBme3jnSuRV07Q4H/MQOgwQep++URNvm38wnCKNQ=;
        b=d8d1O0jUVHN9KElG+tgRhleJTowWkgpi9Q0iXiTa9j61Pmt9idlCkrrGfFWqsg4ur0
         xEmXbjMyRpYmdiN9s60f4J2d5FaMxKfkIgVsO4EXUfiAXPAq7rrN9fG+eJnakP0Y0+dm
         9WC6BCMxb/WACLNx2n4zX3CbMrYjWnNxEDdpXM0o+ucc+P0hrWGtZXWvXV1qs+IJVFbC
         ihOa1aEkdx7aTG6hwBFottWHGvUeuP4+zTYM+hDFbPzknGlUBBD2anBk4xy++qz++pNV
         yHIBm5CJB3Dw0gqLKEZdcywvZqQ6U0kNd7khXz1X3LyZWKPeK4GwvXrVK0489BVEeN45
         10uA==
X-Gm-Message-State: AOAM533ow3Z0Tx/yzakGlI/RNC66y6PZHlJKOuuTRHz+WNi+5nyRKOaN
        CTkZOYAvPuD7u/kX8T87EA0WvpPm4c+80whG
X-Google-Smtp-Source: ABdhPJy+TfHh5i31QWUypBwpHu0zhtGmwajbAy0IcUdCVmnAvjHah3DkX4Ksvycrx2MW/j9WYG9VKA==
X-Received: by 2002:a17:902:cf03:b0:14d:880d:75b5 with SMTP id i3-20020a170902cf0300b0014d880d75b5mr18464870plg.129.1646757216519;
        Tue, 08 Mar 2022 08:33:36 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id m8-20020a17090a158800b001bf2cec0377sm4517720pja.3.2022.03.08.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 08:33:35 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 2/5] ext4: for committing inode, make ext4_fc_track_inode wait
Date:   Tue,  8 Mar 2022 08:33:16 -0800
Message-Id: <20220308163319.1183625-3-harshads@google.com>
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

If the inode that's being requested to track using ext4_fc_track_inode
is being committed, then wait until the inode finishes the commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c   | 12 ++++++++++++
 fs/ext4/ext4_jbd2.h   | 13 ++++---------
 fs/ext4/fast_commit.c | 28 ++++++++++++++++++++++++++++
 fs/ext4/inode.c       |  3 ++-
 4 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 3477a16d08ae..7fa301b0a35a 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 				   GFP_NOFS, type, line);
 }
 
+handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
+				  int type, int blocks, int rsv_blocks,
+				  int revoke_creds)
+{
+	handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
+						   type, blocks, rsv_blocks,
+						   revoke_creds);
+	if (ext4_handle_valid(handle) && !IS_ERR(handle))
+		ext4_fc_track_inode(handle, inode);
+	return handle;
+}
+
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
 {
 	struct super_block *sb;
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index db2ae4a2b38d..e408622fe896 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -302,6 +302,10 @@ static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
 	return ext4_free_metadata_revoke_credits(sb, 8);
 }
 
+handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
+			       int type, int blocks, int rsv_blocks,
+			       int revoke_creds);
+
 #define ext4_journal_start_sb(sb, type, nblocks)			\
 	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0,	\
 				ext4_trans_default_revoke_credits(sb))
@@ -318,15 +322,6 @@ static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
 	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
 			     (revoke_creds))
 
-static inline handle_t *__ext4_journal_start(struct inode *inode,
-					     unsigned int line, int type,
-					     int blocks, int rsv_blocks,
-					     int revoke_creds)
-{
-	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
-				       rsv_blocks, revoke_creds);
-}
-
 #define ext4_journal_stop(handle) \
 	__ext4_journal_stop(__func__, __LINE__, (handle))
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 9913de655b61..be8c5b3456ec 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -551,8 +551,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
 	return 0;
 }
 
+/*
+ * Track inode as part of the next fast commit. If the inode is being
+ * committed, this function will wait for the commit to finish.
+ */
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	wait_queue_head_t *wq;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -564,6 +570,28 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+			schedule();
+		finish_wait(wq, &wait.wq_entry);
+	}
+
 	ret = ext4_fc_track_template(handle, inode, __track_inode, NULL, 1);
 	trace_ext4_fc_track_inode(inode, ret);
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 531a94f48637..7a01f5bd377c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -629,6 +629,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 	 * with create == 1 flag.
 	 */
 	down_write(&EXT4_I(inode)->i_data_sem);
+	ext4_fc_track_inode(handle, inode);
 
 	/*
 	 * We need to check for EXT4 here because migrate
@@ -5690,7 +5691,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 		put_bh(iloc->bh);
 		return -EIO;
 	}
-	ext4_fc_track_inode(handle, inode);
 
 	if (IS_I_VERSION(inode))
 		inode_inc_iversion(inode);
@@ -5727,6 +5727,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 			brelse(iloc->bh);
 			iloc->bh = NULL;
 		}
+		ext4_fc_track_inode(handle, inode);
 	}
 	ext4_std_error(inode->i_sb, err);
 	return err;
-- 
2.35.1.616.g0bdcbb4464-goog

