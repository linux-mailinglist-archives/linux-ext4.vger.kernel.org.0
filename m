Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EB6305599
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhA0IZy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 03:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbhA0IXh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 03:23:37 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03862C0613ED;
        Wed, 27 Jan 2021 00:22:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so1050532pgm.11;
        Wed, 27 Jan 2021 00:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LxrbqAM1++GEF2gcGqw/ycLmXycTOzgbHHp81cZPk7w=;
        b=Q699JJ73Hkt9QTy4HRh5dkdtqjKYzE3mXMMFxPSmhpGcHbbKJx4R6pr5ra2+Ivo7eq
         fyHklVr85os6XFsao2LU+KmY4T5L+3v9ReyctRjQttR+i5gz1bxLh8lG5hSqkItxLD0F
         FwLrPj8nJasG6+ac70XJqtb2L/F/mN1Nb6Nbs18LhAUrmvBkBVB1tycxw190P45QA09D
         gjvH0/DtFJwlb35IEjXiMZJLRuT3f84P29ukUdL4y0RV41NvPOrRh3LHpY6xJQslNBUU
         gR1j1zlpI56xLGeu0RnxkAhSwT/01w8G1+Nk2gRPoJ+y6mWV4VpaA9ZMjvF1Gi7/E8Yz
         il+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=LxrbqAM1++GEF2gcGqw/ycLmXycTOzgbHHp81cZPk7w=;
        b=Dxog9ksD9+vN5bbumytNvPGVZwVdf4pC0d9GeKcqASydKPlzpP1aWE8RRMOEMZT4dU
         NXNH8Z2ABEL4FgDCIv7hjBmYOlcujvUZ2Ac2+1btAis4bP9KTc8/dDB+CP5VuYSjkelk
         O/0kppTdFVby8QgPndij0LzRu90ImiRgmXGPXwwWidtubIkF7iuGAWO1imHOtSv4+YNF
         5sI8rsyseNROI3sOAZ76Vi7K7xPN7m5Pia669wZdkLDu0YcFqMZMtOQzAIQ7B/yBMgoR
         5S4z1roH05cTsXjNIgdNWnHtOrytdXo9SF26KtVdFwqQFkEVrEgK0mm8AA5Xu9mmiptd
         gt9w==
X-Gm-Message-State: AOAM5323EHRiFRSx46FS/ftmQ5H9c2o0DL3sJC88x+B657/1pfjqll+I
        qYR/7HyI5HSS0R3WowlLKVs=
X-Google-Smtp-Source: ABdhPJwOuDYtxSshpmxu0zaDklNIkgegYeL555OcDWKKai4rMpxgRm1NPLIeJNdX76JWt2P9/MZZ5Q==
X-Received: by 2002:a65:488d:: with SMTP id n13mr9726350pgs.315.1611735776513;
        Wed, 27 Jan 2021 00:22:56 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id q17sm1499902pfl.143.2021.01.27.00.22.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:22:56 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 3/3] ext4: update the arguments of jbd_debug()
Date:   Wed, 27 Jan 2021 16:22:06 +0800
Message-Id: <efc1b70651d821d077d1a05e311acfe4c2cfd198.1611733806.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
In-Reply-To: <cover.1611733806.git.brookxu@tencent.com>
References: <cover.1611733806.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

In order to support jbd2 per device debugging switch, here we need
to replace jbd_debug with a new log interface. But there is a small
disadvantage here. Because the debugging switch is placed in the
journal_t object, the log before the object is initialized will be
lost. However, usually this will not have much impact on debugging.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/balloc.c      |  2 +-
 fs/ext4/ext4_jbd2.c   |  4 +--
 fs/ext4/fast_commit.c | 60 ++++++++++++++++++++++++-------------------
 fs/ext4/indirect.c    |  4 +--
 fs/ext4/inode.c       |  3 ++-
 fs/ext4/namei.c       | 10 ++++----
 fs/ext4/super.c       | 15 ++++++-----
 7 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index f45f9feebe59..028b4d1d8cab 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -645,7 +645,7 @@ int ext4_should_retry_alloc(struct super_block *sb, int *retries)
 	if (EXT4_SB(sb)->s_mb_free_pending == 0)
 		return 0;
 
-	jbd_debug(1, "%s: retrying operation after ENOSPC\n", sb->s_id);
+	jbd_debug(EXT4_SB(sb)->s_journal, 1, "%s: retrying operation after ENOSPC\n", sb->s_id);
 	jbd2_journal_force_commit_nested(EXT4_SB(sb)->s_journal);
 	return 1;
 }
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index be799040a415..0e1800768ec8 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -259,8 +259,8 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 	trace_ext4_forget(inode, is_metadata, blocknr);
 	BUFFER_TRACE(bh, "enter");
 
-	jbd_debug(4, "forgetting bh %p: is_metadata = %d, mode %o, "
-		  "data mode %x\n",
+	jbd_debug(EXT4_SB(inode->i_sb)->s_journal, 4,
+		  "forgetting bh %p: is_metadata = %d, mode %o, data mode %x\n",
 		  bh, is_metadata, inode->i_mode,
 		  test_opt(inode->i_sb, DATA_FLAGS));
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 0a14a7c87bf8..257ec136ac4c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -865,7 +865,8 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	mutex_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
-	jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
+	jbd_debug(EXT4_SB(inode->i_sb)->s_journal, 1,
+		  "%s: will try writing %d to %d for inode %ld\n",
 		  __func__, cur_lblk_off, new_blk_size, inode->i_ino);
 
 	while (cur_lblk_off <= new_blk_size) {
@@ -1207,7 +1208,7 @@ int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
 				sbi->s_fc_avg_commit_time * 3) / 4;
 	else
 		sbi->s_fc_avg_commit_time = commit_time;
-	jbd_debug(1,
+	jbd_debug(journal, 1,
 		"Fast commit ended with blks = %d, reason = %d, subtid - %d",
 		nblks, reason, subtid);
 	if (reason == EXT4_FC_REASON_FC_FAILED)
@@ -1319,14 +1320,15 @@ static int ext4_fc_replay_unlink(struct super_block *sb, struct ext4_fc_tl *tl)
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode %d not found", darg.ino);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode %d not found", darg.ino);
 		return 0;
 	}
 
 	old_parent = ext4_iget(sb, darg.parent_ino,
 				EXT4_IGET_NORMAL);
 	if (IS_ERR(old_parent)) {
-		jbd_debug(1, "Dir with inode  %d not found", darg.parent_ino);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Dir with inode  %d not found",
+			  darg.parent_ino);
 		iput(inode);
 		return 0;
 	}
@@ -1351,21 +1353,22 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 
 	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(dir)) {
-		jbd_debug(1, "Dir with inode %d not found.", darg->parent_ino);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1,
+			  "Dir with inode %d not found.", darg->parent_ino);
 		dir = NULL;
 		goto out;
 	}
 
 	dentry_dir = d_obtain_alias(dir);
 	if (IS_ERR(dentry_dir)) {
-		jbd_debug(1, "Failed to obtain dentry");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Failed to obtain dentry");
 		dentry_dir = NULL;
 		goto out;
 	}
 
 	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
 	if (!dentry_inode) {
-		jbd_debug(1, "Inode dentry not created.");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode dentry not created.");
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -1378,7 +1381,7 @@ static int ext4_fc_replay_link_internal(struct super_block *sb,
 	 * could complete.
 	 */
 	if (ret && ret != -EEXIST) {
-		jbd_debug(1, "Failed to link\n");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Failed to link\n");
 		goto out;
 	}
 
@@ -1411,7 +1414,7 @@ static int ext4_fc_replay_link(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode not found.");
 		return 0;
 	}
 
@@ -1514,7 +1517,7 @@ static int ext4_fc_replay_inode(struct super_block *sb, struct ext4_fc_tl *tl)
 	/* Given that we just wrote the inode on disk, this SHOULD succeed. */
 	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode not found.");
 		return -EFSCORRUPTED;
 	}
 
@@ -1566,7 +1569,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "inode %d not found.", darg.ino);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "inode %d not found.", darg.ino);
 		inode = NULL;
 		ret = -EINVAL;
 		goto out;
@@ -1579,7 +1582,7 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl)
 		 */
 		dir = ext4_iget(sb, darg.parent_ino, EXT4_IGET_NORMAL);
 		if (IS_ERR(dir)) {
-			jbd_debug(1, "Dir %d not found.", darg.ino);
+			jbd_debug(EXT4_SB(sb)->s_journal, 1, "Dir %d not found.", darg.ino);
 			goto out;
 		}
 		ret = ext4_init_new_dir(NULL, dir, inode);
@@ -1655,7 +1658,7 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	inode = ext4_iget(sb, le32_to_cpu(fc_add_ex->fc_ino),
 				EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode not found.");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode not found.");
 		return 0;
 	}
 
@@ -1667,7 +1670,8 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 
 	cur = start;
 	remaining = len;
-	jbd_debug(1, "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
+	jbd_debug(EXT4_SB(sb)->s_journal, 1,
+		  "ADD_RANGE, lblk %d, pblk %lld, len %d, unwritten %d, inode %ld\n",
 		  start, start_pblk, len, ext4_ext_is_unwritten(ex),
 		  inode->i_ino);
 
@@ -1736,9 +1740,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		}
 
 		/* Range is mapped and needs a state change */
-		jbd_debug(1, "Converting from %d to %d %lld",
-				map.m_flags & EXT4_MAP_UNWRITTEN,
-			ext4_ext_is_unwritten(ex), map.m_pblk);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1,
+			  "Converting from %d to %d %lld",
+			  map.m_flags & EXT4_MAP_UNWRITTEN,
+			  ext4_ext_is_unwritten(ex), map.m_pblk);
 		ret = ext4_ext_replay_update_ex(inode, cur, map.m_len,
 					ext4_ext_is_unwritten(ex), map.m_pblk);
 		if (ret) {
@@ -1779,15 +1784,16 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 
 	inode = ext4_iget(sb, le32_to_cpu(lrange->fc_ino), EXT4_IGET_NORMAL);
 	if (IS_ERR(inode)) {
-		jbd_debug(1, "Inode %d not found", le32_to_cpu(lrange->fc_ino));
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode %d not found",
+			  le32_to_cpu(lrange->fc_ino));
 		return 0;
 	}
 
 	ret = ext4_fc_record_modified_inode(sb, inode->i_ino);
 
-	jbd_debug(1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
-			inode->i_ino, le32_to_cpu(lrange->fc_lblk),
-			le32_to_cpu(lrange->fc_len));
+	jbd_debug(EXT4_SB(sb)->s_journal, 1, "DEL_RANGE, inode %ld, lblk %d, len %d\n",
+		  inode->i_ino, le32_to_cpu(lrange->fc_lblk),
+		  le32_to_cpu(lrange->fc_len));
 	while (remaining > 0) {
 		map.m_lblk = cur;
 		map.m_len = remaining;
@@ -1811,7 +1817,7 @@ ext4_fc_replay_del_range(struct super_block *sb, struct ext4_fc_tl *tl)
 		le32_to_cpu(lrange->fc_lblk) << sb->s_blocksize_bits,
 		le32_to_cpu(lrange->fc_len) <<  sb->s_blocksize_bits);
 	if (ret)
-		jbd_debug(1, "ext4_punch_hole returned %d", ret);
+		jbd_debug(EXT4_SB(sb)->s_journal, 1, "ext4_punch_hole returned %d", ret);
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
@@ -1834,8 +1840,8 @@ static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
 		inode = ext4_iget(sb, state->fc_modified_inodes[i],
 			EXT4_IGET_NORMAL);
 		if (IS_ERR(inode)) {
-			jbd_debug(1, "Inode %d not found.",
-				state->fc_modified_inodes[i]);
+			jbd_debug(EXT4_SB(sb)->s_journal, 1, "Inode %d not found.",
+				  state->fc_modified_inodes[i]);
 			continue;
 		}
 		cur = 0;
@@ -1957,7 +1963,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
 
 	state->fc_replay_expected_off++;
 	fc_for_each_tl(start, end, tl) {
-		jbd_debug(3, "Scan phase, tag:%s, blk %lld\n",
+		jbd_debug(journal, 3, "Scan phase, tag:%s, blk %lld\n",
 			  tag2str(le16_to_cpu(tl->fc_tag)), bh->b_blocknr);
 		switch (le16_to_cpu(tl->fc_tag)) {
 		case EXT4_FC_TAG_ADD_RANGE:
@@ -2052,7 +2058,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 		sbi->s_mount_state |= EXT4_FC_REPLAY;
 	}
 	if (!sbi->s_fc_replay_state.fc_replay_num_tags) {
-		jbd_debug(1, "Replay stops\n");
+		jbd_debug(journal, 1, "Replay stops\n");
 		ext4_fc_set_bitmaps_and_counters(sb);
 		return 0;
 	}
@@ -2073,7 +2079,7 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ext4_fc_set_bitmaps_and_counters(sb);
 			break;
 		}
-		jbd_debug(3, "Replay phase, tag:%s\n",
+		jbd_debug(journal, 3, "Replay phase, tag:%s\n",
 				tag2str(le16_to_cpu(tl->fc_tag)));
 		state->fc_replay_num_tags--;
 		switch (le16_to_cpu(tl->fc_tag)) {
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 1223a18c3ff9..c02729abd707 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -458,7 +458,7 @@ static int ext4_splice_branch(handle_t *handle,
 		 * the new i_size.  But that is not done here - it is done in
 		 * generic_commit_write->__mark_inode_dirty->ext4_dirty_inode.
 		 */
-		jbd_debug(5, "splicing indirect only\n");
+		jbd_debug(EXT4_SB(ar->inode->i_sb)->s_journal, 5, "splicing indirect only\n");
 		BUFFER_TRACE(where->bh, "call ext4_handle_dirty_metadata");
 		err = ext4_handle_dirty_metadata(handle, ar->inode, where->bh);
 		if (err)
@@ -470,7 +470,7 @@ static int ext4_splice_branch(handle_t *handle,
 		err = ext4_mark_inode_dirty(handle, ar->inode);
 		if (unlikely(err))
 			goto err_out;
-		jbd_debug(5, "splicing direct\n");
+		jbd_debug(EXT4_SB(ar->inode->i_sb)->s_journal, 5, "splicing direct\n");
 	}
 	return err;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c173c8405856..bd1c74352a03 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5212,7 +5212,8 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	if (EXT4_SB(inode->i_sb)->s_journal) {
 		if (ext4_journal_current_handle()) {
-			jbd_debug(1, "called recursively, non-PF_MEMALLOC!\n");
+			jbd_debug(EXT4_SB(inode->i_sb)->s_journal, 1,
+				  "called recursively, non-PF_MEMALLOC!\n");
 			dump_stack();
 			return -EIO;
 		}
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cf652ba3e74d..7ae23964db2f 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3003,8 +3003,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	} else
 		brelse(iloc.bh);
 
-	jbd_debug(4, "superblock will point to %lu\n", inode->i_ino);
-	jbd_debug(4, "orphan inode %lu will point to %d\n",
+	jbd_debug(sbi->s_journal, 4, "superblock will point to %lu\n", inode->i_ino);
+	jbd_debug(sbi->s_journal, 4, "orphan inode %lu will point to %d\n",
 			inode->i_ino, NEXT_ORPHAN(inode));
 out:
 	ext4_std_error(sb, err);
@@ -3039,7 +3039,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	}
 
 	mutex_lock(&sbi->s_orphan_lock);
-	jbd_debug(4, "remove inode %lu from orphan list\n", inode->i_ino);
+	jbd_debug(sbi->s_journal, 4, "remove inode %lu from orphan list\n", inode->i_ino);
 
 	prev = ei->i_orphan.prev;
 	list_del_init(&ei->i_orphan);
@@ -3055,7 +3055,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 
 	ino_next = NEXT_ORPHAN(inode);
 	if (prev == &sbi->s_orphan) {
-		jbd_debug(4, "superblock will point to %u\n", ino_next);
+		jbd_debug(sbi->s_journal, 4, "superblock will point to %u\n", ino_next);
 		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
 		err = ext4_journal_get_write_access(handle, sbi->s_sbh);
 		if (err) {
@@ -3073,7 +3073,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		struct inode *i_prev =
 			&list_entry(prev, struct ext4_inode_info, i_orphan)->vfs_inode;
 
-		jbd_debug(4, "orphan inode %lu will point to %u\n",
+		jbd_debug(sbi->s_journal, 4, "orphan inode %lu will point to %u\n",
 			  i_prev->i_ino, ino_next);
 		err = ext4_reserve_inode_write(handle, i_prev, &iloc2);
 		if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9a6f9875aa34..06c1d1a794bd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2989,7 +2989,7 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 	int i;
 #endif
 	if (!es->s_last_orphan) {
-		jbd_debug(4, "no orphan inodes to clean up\n");
+		jbd_debug(EXT4_SB(sb)->s_journal, 4, "no orphan inodes to clean up\n");
 		return;
 	}
 
@@ -3013,7 +3013,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				  "clearing orphan list.\n");
 			es->s_last_orphan = 0;
 		}
-		jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+		jbd_debug(EXT4_SB(sb)->s_journal, 1,
+			  "Skipping orphan recovery on fs with errors.\n");
 		return;
 	}
 
@@ -3062,7 +3063,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 		 * so, skip the rest.
 		 */
 		if (EXT4_SB(sb)->s_mount_state & EXT4_ERROR_FS) {
-			jbd_debug(1, "Skipping orphan recovery on fs with errors.\n");
+			jbd_debug(EXT4_SB(sb)->s_journal, 1,
+				  "Skipping orphan recovery on fs with errors.\n");
 			es->s_last_orphan = 0;
 			break;
 		}
@@ -3080,7 +3082,8 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				ext4_msg(sb, KERN_DEBUG,
 					"%s: truncating inode %lu to %lld bytes",
 					__func__, inode->i_ino, inode->i_size);
-			jbd_debug(2, "truncating inode %lu to %lld bytes\n",
+			jbd_debug(EXT4_SB(sb)->s_journal, 2,
+				  "truncating inode %lu to %lld bytes\n",
 				  inode->i_ino, inode->i_size);
 			inode_lock(inode);
 			truncate_inode_pages(inode->i_mapping, inode->i_size);
@@ -3094,7 +3097,7 @@ static void ext4_orphan_cleanup(struct super_block *sb,
 				ext4_msg(sb, KERN_DEBUG,
 					"%s: deleting unreferenced inode %lu",
 					__func__, inode->i_ino);
-			jbd_debug(2, "deleting unreferenced inode %lu\n",
+			jbd_debug(EXT4_SB(sb)->s_journal, 2, "deleting unreferenced inode %lu\n",
 				  inode->i_ino);
 			nr_orphans++;
 		}
@@ -5226,7 +5229,7 @@ static struct inode *ext4_get_journal_inode(struct super_block *sb,
 		return NULL;
 	}
 
-	jbd_debug(2, "Journal inode found at %p: %lld bytes\n",
+	jbd_debug(EXT4_SB(sb)->s_journal, 2, "Journal inode found at %p: %lld bytes\n",
 		  journal_inode, journal_inode->i_size);
 	if (!S_ISREG(journal_inode->i_mode)) {
 		ext4_msg(sb, KERN_ERR, "invalid journal inode");
-- 
2.30.0

