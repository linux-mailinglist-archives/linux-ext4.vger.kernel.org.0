Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44F4904FB
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jan 2022 10:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbiAQJhb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jan 2022 04:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiAQJh3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jan 2022 04:37:29 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5ED4C061574
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:28 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i17so9713743pfk.11
        for <linux-ext4@vger.kernel.org>; Mon, 17 Jan 2022 01:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwbnUDZTqvWR5Enash5noKPvbQSY5R+v73OYAxJe5K8=;
        b=7o6XQmk1OKSS6hbwLK1eNu6qpTq82aozArTSDhioFS3twKocyTkb303A87d++wi7cU
         EQfPGMjChPI01v8jrTxlOrVlTyAPSUdlHhvWSItVRKdEQopap6OUw19r3HIYmWUMfrSR
         b3WJJkXJN2Xp5yQM9HtzRvw855+XcLGmfEuWsL2pGSz2p+3C9SUCyiMnrXZbuJeMEgII
         KnMEP6aCMawuvJAW+eoBMKneAtMLvr7ayRmED1NKoDClCrT0W1WKRFFis6at8J0niL/s
         CilYe07bPGlXZBidSvPqA7XLbpUloQQz33ICM5xMIvCQedSH3FeiCL2bbQjDQUBLR/7A
         8/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwbnUDZTqvWR5Enash5noKPvbQSY5R+v73OYAxJe5K8=;
        b=gmqszl2jZGbyAHmQqsu6e4x/KMiIh+PNn9PpjRrKCzLuYh/07J6zUNEdxRjB3XTEMU
         7DI+SvbJtdlTcB5R7HTUV/HA1xj5H0k6M0WDZ4lB4vASo68XX5tMZrbNDyazCUFG811Y
         GG6j6p/fI+gqK2Sa4Vk6l/vPlOqg7dKbPA3apC3Uq1u5069hOtTZbpYQuPvcIS+ouaY1
         kmrVeMgUH38rUWWscNxnYGsx1G8hkB/RlHFNoSlzP45M/5YOgdoz66+P6ZF4GCRvPy9S
         RU7FClPoFS8+eEAETsL2pcKNeM1Mnrf7HekLchN/7iCBsjj7Tmjsr1tPvJBk9rmz5s33
         EM7A==
X-Gm-Message-State: AOAM533W1N7D3gvxONNM7yKfAHgzrhe1cGH0WngiPid6ZZExk+0P/ESE
        AnZDmDSymVLvrnVQ4WMEx7wTqw==
X-Google-Smtp-Source: ABdhPJzb1kyryG9lqB84bttxxHy+emvZ1fmbrVjtAhLQ888ATFjo9RkAoqfSjRjgXU05ambSDD+9Ug==
X-Received: by 2002:a63:b812:: with SMTP id p18mr18841018pge.22.1642412248353;
        Mon, 17 Jan 2022 01:37:28 -0800 (PST)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id z16sm11426497pgi.89.2022.01.17.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 01:37:27 -0800 (PST)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     harshadshirwadkar@gmail.com, tytso@mit.edu,
        adilger.kernel@dilger.ca
Cc:     dan.carpenter@oracle.com, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Yin <yinxin.x@bytedance.com>
Subject: [PATCH v3 2/2] ext4: fast commit may miss file actions
Date:   Mon, 17 Jan 2022 17:36:55 +0800
Message-Id: <20220117093655.35160-3-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117093655.35160-1-yinxin.x@bytedance.com>
References: <20220117093655.35160-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

in the follow scenario:
1. jbd start transaction n
2. task A get new handle for transaction n+1
3. task A do some actions and add inode to FC_Q_MAIN fc_q
4. jbd complete transaction n and clear FC_Q_MAIN fc_q
5. task A call fsync

fast commit will lost the file actions during a full commit.

we should also add updates to staging queue during a full commit.
and in ext4_fc_cleanup(), when reset a inode's fc track range, check
it's i_sync_tid, if it bigger than current transaction tid, do not
rest it, or we will lost the track range.

And EXT4_MF_FC_COMMITTING is not needed anymore, so drop it.

Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
v2: drop EXT4_MF_FC_COMMITTING
---
 fs/ext4/ext4.h        |  5 +----
 fs/ext4/fast_commit.c | 11 ++++++-----
 fs/ext4/super.c       |  1 -
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 881f480dd150..22a954fb0c20 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1796,10 +1796,7 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
 	EXT4_MF_FS_ABORTED,	/* Fatal error detected */
-	EXT4_MF_FC_INELIGIBLE,	/* Fast commit ineligible */
-	EXT4_MF_FC_COMMITTING	/* File system underoing a fast
-				 * commit.
-				 */
+	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
 };
 
 static inline void ext4_set_mount_flag(struct super_block *sb, int bit)
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index e031afee42de..ccd2b216d6ba 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -375,7 +375,8 @@ static int ext4_fc_track_template(
 	spin_lock(&sbi->s_fc_lock);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
-				(ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING)) ?
+				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
 	spin_unlock(&sbi->s_fc_lock);
@@ -428,7 +429,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	node->fcd_name.len = dentry->d_name.len;
 
 	spin_lock(&sbi->s_fc_lock);
-	if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_COMMITTING))
+	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
+		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
 				&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	else
@@ -893,7 +895,6 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	int ret = 0;
 
 	spin_lock(&sbi->s_fc_lock);
-	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
 		while (atomic_read(&ei->i_fc_updates)) {
@@ -1211,7 +1212,8 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		ext4_fc_reset_inode(&iter->vfs_inode);
+		if (iter->i_sync_tid <= tid)
+			ext4_fc_reset_inode(&iter->vfs_inode);
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
@@ -1240,7 +1242,6 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
 				&sbi->s_fc_q[FC_Q_MAIN]);
 
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	if (tid >= sbi->s_fc_ineligible_tid) {
 		sbi->s_fc_ineligible_tid = 0;
 		ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 38b496745825..2b0a7e4fa379 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5086,7 +5086,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	INIT_LIST_HEAD(&sbi->s_fc_dentry_q[FC_Q_STAGING]);
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	sbi->s_fc_ineligible_tid = 0;
 	spin_lock_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
-- 
2.25.1

