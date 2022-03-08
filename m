Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B734D152A
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Mar 2022 11:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiCHKwd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Mar 2022 05:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345979AbiCHKw1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Mar 2022 05:52:27 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24143493
        for <linux-ext4@vger.kernel.org>; Tue,  8 Mar 2022 02:51:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id cx5so16824862pjb.1
        for <linux-ext4@vger.kernel.org>; Tue, 08 Mar 2022 02:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivg8AwMdf5DL1tSRgm8p90NLmn6yDl8YDncOWO+HOoc=;
        b=K6h9kOFqVIJlKfz1PkMDW94EM5/HqlUWttps6wHFPMl/c8tytIuGKJ32q4BJRsrAAm
         RXhl5IBJl1ojQRCHXRbZSxMs/ZpgHvt7GriOKAinL9Nc7WVqveux8oxStaGG6twuEFBU
         TasxxbB+NNOKYRyRYg8x6p+0liXNKYQaUxby7zpzzRo7NYJ22sOD9oRjISIiYRHsTNR7
         ePcHZGnrWp2Z1Bs8o48iQ5rB/7MVtmhNnVwYz2MBqXp0rOlBRqGd2l95wv6T7+5F7D3b
         E5CzXo7FraUnupnpbE6R6NyZxd0z/xq7mKZ5fEYDGfia8Gq8Uu/MgJyYIfX401z3JfzW
         EX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivg8AwMdf5DL1tSRgm8p90NLmn6yDl8YDncOWO+HOoc=;
        b=dGGKxIObFDkUUNJyo4OVgr4hmGwhtnLKS5/a2kdjc5WXr/NiJJQ8yB/W/bfkC8K0GG
         aqgSYy6Ju1YnEP7RqKoQjgAKERcoQXvv90KvchsKBvOLxfQtsOXbUgYM5xnFnKsJavo5
         5OO/VQKezhsK1ST06XrO+jMm+fJYEiRNVfocNWxDPm3uIgGVK3D2EZX2i5rtlWRl6ShR
         vrtNFPrSV44ZIKPXeT1JGAApoJHwh68yMEPQk13JZm2kzY5PvICo2M6OqmQ6/sn13rbP
         FbLH3HlMtXwtk7mmWYNFJ6xvsrQvjhSYBE9KeVnDkLeQkiiCZ/tzli1vLXrtvlIdbVLy
         urtA==
X-Gm-Message-State: AOAM531nN7ISZfVmW+eM0KJNbo5xCUVrC5snBYM3DFvmeH6PkOJUePPp
        JvwQNuDWgXFpOvxwnWSb3ESrUHur0TpqGW8r
X-Google-Smtp-Source: ABdhPJxVLOSwX1Z40uw75S90dhOYt0bYqfx1k052z7iZl9t1yaGy+HRBdpdrTAoWVo4tiUqsWsKVlA==
X-Received: by 2002:a17:90a:1f4d:b0:1bb:a657:ace5 with SMTP id y13-20020a17090a1f4d00b001bba657ace5mr3902544pjy.39.1646736689795;
        Tue, 08 Mar 2022 02:51:29 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:c24c:d8e5:a9be:227])
        by smtp.googlemail.com with ESMTPSA id f6-20020a056a00228600b004f709f5f3c1sm6282040pfe.28.2022.03.08.02.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 02:51:28 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com, jack@suse.cz, tytso@mit.edu,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/5] ext4: for committing inode, make ext4_fc_track_inode wait
Date:   Tue,  8 Mar 2022 02:51:10 -0800
Message-Id: <20220308105112.404498-4-harshads@google.com>
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

If the inode that's being requested to track using ext4_fc_track_inode
is being committed, then wait until the inode finishes the commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.c   | 12 ++++++++++++
 fs/ext4/ext4_jbd2.h   | 13 ++++---------
 fs/ext4/fast_commit.c | 33 +++++++++++++++++++++++++++++++++
 fs/ext4/inode.c       |  3 ++-
 4 files changed, 51 insertions(+), 10 deletions(-)

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
index a589fc415dbe..d69bf53bef21 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -506,8 +506,14 @@ static int __track_inode(struct inode *inode, void *arg, bool update)
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
@@ -519,6 +525,33 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 	}
 
+	if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
+	    (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
+		return;
+
+	spin_lock(&ei->i_fc_lock);
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
+
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		spin_unlock(&ei->i_fc_lock);
+
+		schedule();
+		finish_wait(wq, &wait.wq_entry);
+		spin_lock(&ei->i_fc_lock);
+	}
+	spin_unlock(&ei->i_fc_lock);
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

