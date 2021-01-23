Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9063014F5
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbhAWMCj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Jan 2021 07:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbhAWMCU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Jan 2021 07:02:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51BC06178B;
        Sat, 23 Jan 2021 04:01:39 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q20so5542347pfu.8;
        Sat, 23 Jan 2021 04:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LWEzsD6Vi86Sw131fcR0ddDGEbSMLqIEahx5CNjONiA=;
        b=CyygFx2YmYj3Og+SGDHEgxaUgzww3OeXY9YNgRH48J3BIrAHotCY210RuPq1DgwpIj
         79N1VO/+eH3gFuws4lio32DNwhU12/vn5pEjloE0VO+mMVMFRsQTNK17ZQp//7ODzwlO
         yodtUOZ+yj9XBRgPpze0MqHmfBR0gG5trH//wvfku6t320YusIsDH1+QD9tnkR0IC723
         E7+UWAVvEpYhAR5dlMEDXi2MR7OMA/7yvcm6QsdFlr5wU3HCGTL8PTmsZ+zWnu7+OZd7
         bsE8XKDs2rMuyzHJ6zh2Oet128hxvNEaB3Pb8vRMx8Iu1xflezDOXPLBAfHybk8LEqKN
         p2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LWEzsD6Vi86Sw131fcR0ddDGEbSMLqIEahx5CNjONiA=;
        b=Rk4AgWOOKLZwm+0zqH3opLQ3nr5/aX6OEpzKfoexiVDatZxs1EkjMHBQirWepZohm3
         7GEaJ3kLGqAEiCyqKFRpNxCjw/PE+J3VDh5HIFtUXxmoduS+95htc8QwRgxOz/zj6Vtq
         zn2CD+iwoALWXSdzWr0D7op+0NyW+kOm0AuEFnMf9AL7p51cocv2MWWsug2d+ACX4kr1
         mCY+wmVtF5/OqgnT7J3M+TtueNTpT6nbBmdw5jpHjLeLnOAEwz3RKI7fcrgRPxVAEYzS
         HYB/oBh2dzkLexj1jgnqBwwtgrkVuXcVkJMci1sNjoNwnFPE4gjkumHwzXHkv3V7Tyjb
         YXTg==
X-Gm-Message-State: AOAM531yCzRzm2HW+JTK4ebGfyn1AT0T3BhEhXwsACOUWN/Kh/n9daDe
        QHF9tsJyYlFNTSIaiEW6Qrw=
X-Google-Smtp-Source: ABdhPJxN7atUzkow/S9dbeCqTcH2wU9VwHPLQpJSD89s9wSscSLGG2CxdkAKLpU7a/TtVWSrcgAt6A==
X-Received: by 2002:a63:e109:: with SMTP id z9mr2384190pgh.5.1611403299212;
        Sat, 23 Jan 2021 04:01:39 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x19sm11854648pfp.207.2021.01.23.04.01.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 04:01:38 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/4] ext4: replace jbd_debug with the new log interface
Date:   Sat, 23 Jan 2021 20:00:46 +0800
Message-Id: <0ad3c4a22e1e2d2d738e1a044a73037bc538474e.1611402263.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
References: <cover.1611402263.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to support jbd2 per device debugging switch, here we need to
replace jbd_debug with a new log interface. But there is a small
disadvantage here. Because the debugging switch is placed in the journal_t
object, the log before the object is initialized will be lost. However,
usually this will not have much impact on debugging.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/balloc.c      |  2 +-
 fs/ext4/ext4_jbd2.c   |  3 +-
 fs/ext4/fast_commit.c | 64 +++++++++++++++++++++++--------------------
 fs/ext4/indirect.c    |  4 +--
 fs/ext4/inode.c       |  3 +-
 fs/ext4/namei.c       | 10 +++----
 fs/ext4/super.c       | 16 ++++++-----
 7 files changed, 56 insertions(+), 46 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f45f9feebe59..469aec970b36 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -645,7 +645,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	if (EXT4_SB(sb)->s_mb_free_pending == 0)
 		return 0;
 
-	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
+	jbd2_err(EXT4_SB(sb)->s_journal, "%s: retrying operation after ENOSPC\n", sb->s_id);
 	jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal);
 	return 1;
 }
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..5c1c06662019 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -259,7 +259,8 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	trace_ext4_forget(inode, is_metadata, blocknr);
 	BUFFER_TRACE(bh, "enter");
 
-	jbd_debug(4, "forgetting bh %p: is_metadata = %d, mode %o, "
+	jbd2_info(EXT4_SB(inode->i_sb)->s_journal,
+		  "forgetting bh %p: is_metadata = %d, mode %o, "
 		  "data mode %x\n",
 		  bh, is_metadata, inode->i_mode,
 		  test_opt(inode->i_sb, DATA_FLAGS));
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0a14a7c87bf8..1356b7063c99 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -865,8 +865,9 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	mutex_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
-	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
-		  __func__, cur_lblk_off, new_blk_size, inode->i_ino);
+	jbd2_err(EXT4_SB(inode->i_sb)->s_journal,
+		 "%s: will try writing %d to %d for inode %ld\n",
+		 __func__, cur_lblk_off, new_blk_size, inode->i_ino);
 
 	while (cur_lblk_off <= new_blk_size) {
 		map.m_lblk = cur_lblk_off;
@@ -1207,7 +1208,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 				sbi->s_fc_avg_commit_time * 3) / 4;
 	else
 		sbi->s_fc_avg_commit_time = commit_time;
-	jbd_debug(1,
+	jbd2_err(sbi->s_journal,
 		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
 		nblks, reason, subtid);
 	if (reason == EXT4_FC_REASON_FC_FAILED)
@@ -1319,14 +1320,15 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode %d not found", darg.ino);
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode %d not found", darg.ino);
 		return 0;
 	}
 
 	old_parent = ext4_iget(sb, darg.parent_ino,
 				EXT4_IGET_NORMAL);
 	if (IS_ERR(old_parent)) {
-		jbd_debug(1, "Dir with inode  %d not found", darg.parent_ino);
+		jbd2_err(EXT4_SB(sb)->s_journal, "Dir with inode  %d not found",
+			 darg.parent_ino);
 		iput(inode);
 		return 0;
 	}
@@ -1351,21 +1353,22 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 
 	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(dir)) {
-		jbd_debug(1, "Dir with inode %d not found.", darg->parent_ino);
+		jbd2_err(EXT4_SB(sb)->s_journal, "Dir with inode %d not found.",
+			 darg->parent_ino);
 		dir = NULL;
 		goto out;
 	}
 
 	dentry_dir = d_obtain_alias(dir);
 	if (IS_ERR(dentry_dir)) {
-		jbd_debug(1, "Failed to obtain dentry");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Failed to obtain dentry");
 		dentry_dir = NULL;
 		goto out;
 	}
 
 	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
 	if (!dentry_inode) {
-		jbd_debug(1, "Inode dentry not created.");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode dentry not created.");
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1378,7 +1381,7 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 	 * could complete.
 	 */
 	if (ret && ret != -EEXIST) {
-		jbd_debug(1, "Failed to link\n");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Failed to link\n");
 		goto out;
 	}
 
@@ -1411,7 +1414,7 @@ static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode not found.");
 		return 0;
 	}
 
@@ -1514,7 +1517,7 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
 	/* Given that we just wrote the inode on disk, this SHOULD succeed. */
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode not found.");
 		return -EFSCORRUPTED;
 	}
 
@@ -1566,7 +1569,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "inode %d not found.", darg.ino);
+		jbd2_err(EXT4_SB(sb)->s_journal, "inode %d not found.", darg.ino);
 		inode = NULL;
 		ret = -EINVAL;
 		goto out;
@@ -1579,7 +1582,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
 		 */
 		dir = ext4_iget(sb, darg.parent_ino, EXT4_IGET_NORMAL);
 		if (IS_ERR(dir)) {
-			jbd_debug(1, "Dir %d not found.", darg.ino);
+			jbd2_err(EXT4_SB(sb)->s_journal, "Dir %d not found.", darg.ino);
 			goto out;
 		}
 		ret = ext4_init_new_dir(NULL, dir, inode);
@@ -1655,7 +1658,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
 				EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode not found.");
 		return 0;
 	}
 
@@ -1667,7 +1670,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 	cur = start;
 	remaining = len;
-	jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
+	jbd2_err(EXT4_SB(sb)->s_journal,
+		 "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
 		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
 		  inode->i_ino);
 
@@ -1736,8 +1740,9 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		}
 
 		/* Range is mapped and needs a state change */
-		jbd_debug(1, "Converting from %d to %d %lld",
-				map.m_flags & EXT4_MAP_UNWRITTEN,
+		jbd2_err(EXT4_SB(sb)->s_journal,
+			 "Converting from %d to %d %lld",
+			 map.m_flags & EXT4_MAP_UNWRITTEN,
 			ext4_ext_is_unwritten(ex), map.m_pblk);
 		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex), map.m_pblk);
@@ -1779,15 +1784,16 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, le32_to_cpu(lrange->fc_ino), EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange->fc_ino));
+		jbd2_err(EXT4_SB(sb)->s_journal, "Inode %d not found",
+			 le32_to_cpu(lrange->fc_ino));
 		return 0;
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
 
-	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
-			inode->i_ino, le32_to_cpu(lrange->fc_lblk),
-			le32_to_cpu(lrange->fc_len));
+	jbd2_err(EXT4_SB(sb)->s_journal, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
+		 inode->i_ino, le32_to_cpu(lrange->fc_lblk),
+		 le32_to_cpu(lrange->fc_len));
 	while (remaining > 0) {
 		map.m_lblk = cur;
 		map.m_len = remaining;
@@ -1811,7 +1817,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 		le32_to_cpu(lrange->fc_lblk) << sb->s_blocksize_bits,
 		le32_to_cpu(lrange->fc_len) <<  sb->s_blocksize_bits);
 	if (ret)
-		jbd_debug(1, "ext4_punch_hole returned %d", ret);
+		jbd2_err(EXT4_SB(sb)->s_journal, "ext4_punch_hole returned %d", ret);
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
@@ -1834,8 +1840,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 		inode = ext4_iget(sb, state->fc_modified_inodes[i],
 			EXT4_IGET_NORMAL);
 		if (IS_ERR(inode)) {
-			jbd_debug(1, "Inode %d not found.",
-				state->fc_modified_inodes[i]);
+			jbd2_err(EXT4_SB(sb)->s_journal, "Inode %d not found.",
+				 state->fc_modified_inodes[i]);
 			continue;
 		}
 		cur = 0;
@@ -1957,8 +1963,8 @@ static int ext4_fc_replay_scan(journal_t *journal,
 
 	state->fc_replay_expected_off++;
 	fc_for_each_tl(start, end, tl) {
-		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
-			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
+		jbd2_notice(sbi->s_journal, "Scan phase, tag:%s, blk %lld\n",
+			    tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
 		switch (le16_to_cpu(tl->fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
 			ext = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
@@ -2052,7 +2058,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 		sbi->s_mount_state |= EXT4_FC_REPLAY;
 	}
 	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
-		jbd_debug(1, "Replay stops\n");
+		jbd2_err(journal, "Replay stops\n");
 		ext4_fc_set_bitmaps_and_counters(sb);
 		return 0;
 	}
@@ -2073,8 +2079,8 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ext4_fc_set_bitmaps_and_counters(sb);
 			break;
 		}
-		jbd_debug(3, "Replay phase, tag:%s\n",
-				tag2str(le16_to_cpu(tl->fc_tag)));
+		jbd2_notice(journal, "Replay phase, tag:%s\n",
+			    tag2str(le16_to_cpu(tl->fc_tag)));
 		state->fc_replay_num_tags--;
 		switch (le16_to_cpu(tl->fc_tag)) {
 		case EXT4_FC_TAG_LINK:
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 1223a18c3ff9..f544f0530e14 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -458,7 +458,7 @@ static int ext4_splice_branch(handle_t *handle,
 		 * the new i_size.  But that is not done here - it is done in
 		 * generic_commit_write->__mark_inode_dirty->ext4_dirty_inode.
 		 */
-		jbd_debug(5, "splicing indirect only\n");
+		jbd2_debug(EXT4_SB(ar->inode->i_sb)->s_journal, "splicing indirect only\n");
 		BUFFER_TRACE(where->bh, "call ext4_handle_dirty_metadata");
 		err = ext4_handle_dirty_metadata(handle, ar->inode, where->bh);
 		if (err)
@@ -470,7 +470,7 @@ static int ext4_splice_branch(handle_t *handle,
 		err = ext4_mark_inode_dirty(handle, ar->inode);
 		if (unlikely(err))
 			goto err_out;
-		jbd_debug(5, "splicing direct\n");
+		jbd2_debug(EXT4_SB(ar->inode->i_sb)->s_journal, "splicing direct\n");
 	}
 	return err;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c173c8405856..89683b7f1a48 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5212,7 +5212,8 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (EXT4_SB(inode->i_sb)->s_journal) {
 		if (ext4_journal_current_handle()) {
-			jbd_debug(1, "called recursively, non-PF_MEMALLOC!\n");
+			jbd2_err(EXT4_SB(inode->i_sb)->s_journal,
+				 "called recursively, non-PF_MEMALLOC!\n");
 			dump_stack();
 			return -EIO;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..0e8da7f010d1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3003,8 +3003,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	} else
 		brelse(iloc.bh);
 
-	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %lu will point to %d\n",
+	jbd2_info(sbi->s_journal, "superblock will point to %lu\n", inode->i_ino);
+	jbd2_info(sbi->s_journal, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out:
 	ext4_std_error(sb, err);
@@ -3039,7 +3039,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	}
 
 	mutex_lock(&sbi->s_orphan_lock);
-	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
+	jbd2_info(sbi->s_journal, "remove inode %lu from orphan list\n", inode->i_ino);
 
 	prev = ei->i_orphan.prev;
 	list_del_init(&ei->i_orphan);
@@ -3055,7 +3055,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 
 	ino_next = NEXT_ORPHAN(inode);
 	if (prev == &sbi->s_orphan) {
-		jbd_debug(4, "superblock will point to %u\n", ino_next);
+		jbd2_info(sbi->s_journal, "superblock will point to %u\n", ino_next);
 		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, sbi->s_sbh);
 		if (err) {
@@ -3073,7 +3073,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		struct inode *i_prev =
 			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
 
-		jbd_debug(4, "orphan inode %lu will point to %u\n",
+		jbd2_info(sbi->s_journal, "orphan inode %lu will point to %u\n",
 			  i_prev->i_ino, ino_next);
 		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
 		if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a6f9875aa34..e4ee88bd698c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2989,7 +2989,7 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 	int i;
 #endif
 	if (!es->s_last_orphan) {
-		jbd_debug(4, "no orphan inodes to clean up\n");
+		jbd2_info(EXT4_SB(sb)->s_journal, "no orphan inodes to clean up\n");
 		return;
 	}
 
@@ -3013,7 +3013,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				  "clearing orphan list.\n");
 			es->s_last_orphan = 0;
 		}
-		jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+		jbd2_err(EXT4_SB(sb)->s_journal,
+			 "Skipping orphan recovery on fs with errors.\n");
 		return;
 	}
 
@@ -3062,7 +3063,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 		 * so, skip the rest.
 		 */
 		if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
-			jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+			jbd2_err(EXT4_SB(sb)->s_journal,
+				 "Skipping orphan recovery on fs with errors.\n");
 			es->s_last_orphan = 0;
 			break;
 		}
@@ -3080,7 +3082,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				ext4_msg(sb, KERN_DEBUG,
 					"%s: truncating inode %lu to %lld bytes",
 					__func__, inode->i_ino, inode->i_size);
-			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
+			jbd2_warn(EXT4_SB(sb)->s_journal,
+				  "truncating inode %lu to %lld bytes\n",
 				  inode->i_ino, inode->i_size);
 			inode_lock(inode);
 			truncate_inode_pages(inode->i_mapping, inode->i_size);
@@ -3094,7 +3097,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				ext4_msg(sb, KERN_DEBUG,
 					"%s: deleting unreferenced inode %lu",
 					__func__, inode->i_ino);
-			jbd_debug(2, "deleting unreferenced inode %lu\n",
+			jbd2_warn(EXT4_SB(sb)->s_journal,
+				  "deleting unreferenced inode %lu\n",
 				  inode->i_ino);
 			nr_orphans++;
 		}
@@ -5226,8 +5230,6 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 		return NULL;
 	}
 
-	jbd_debug(2, "Journal inode found at %p: %lld bytes\n",
-		  journal_inode, journal_inode->i_size);
 	if (!S_ISREG(journal_inode->i_mode)) {
 		ext4_msg(sb, KERN_ERR, "invalid journal inode");
 		iput(journal_inode);
-- 
2.30.0

