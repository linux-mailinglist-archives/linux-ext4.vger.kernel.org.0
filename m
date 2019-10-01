Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF88C2E5B
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfJAHmK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47021 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAHmK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:10 -0400
Received: by mail-pf1-f196.google.com with SMTP id q5so7280723pfg.13
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZuXRej6L5vOiGN+sOKYPoKIMS1zv0yuoG40GTFYvado=;
        b=Ysg7GglAxgQBkmjejoAEZ7LemIICRrBrkNR8tPnBQFLaoYSeCHQ9P0FcnHvhdn+C9B
         z1Dit/hoDXtww6iPxVgAXAMKU7uIVLLYIRo7yy9mi+Fkg21VKE5VeZ3JCmLi6zUyIJWP
         lctVEkD99k6hsp9cc6VHTOl/e9PaxhkuTqu02Ljm4CvqgQuBR87eJ1UDJSkKcNg+KhZa
         5MZs64NNhmo51VNNp5GXZs+es5FHgTawFW/5OyI8s1k5QPKfkws/Krk59ZqZbBdfr2WP
         gGXkq1+Q+Xh+TqRYhMQq69yffqkniPFDSHZMSttgG0Wn6UtvBKIxtQ/Y6nd3Qvf0J8Cl
         NP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZuXRej6L5vOiGN+sOKYPoKIMS1zv0yuoG40GTFYvado=;
        b=KUL0PeuXDzJtgow1y/4KGfmCvB7v6CIvB0+ruhothmKIjvMDd8O1QNUwqPGfHezdJs
         EsHo9bRtmroCRwb44wI4gLOJc71kfeYjL7RkgHLm+BnaLvChaHFTedf84gBZ9dN5ZxwF
         TidyXauf6wNVL35DhzwiAzpkkDm3FBU4SmyM4qmiwKNnQM/yrWaZRFy0Vkrkj+wQE2z8
         OFWLAPdmBrbuuAZRyPMgW22/T8elfGo8VksT+96rwwYs2M/RLQSHMSKQAEkOLqsOLwCN
         XTlwxjWrmyZ4oYJGy0JieXtIl4LadCHvdBIrad/qRxhok+SIW7MGwKn4SiLHVtpq1wqA
         MVIg==
X-Gm-Message-State: APjAAAUTTqts6zSZr1VWDZIv1VHk+HA2RoBeHujF5Dwllz/mMkReFsN7
        B5yd9QQJ+OGA2nT/F7zCpbsI9Z+obx8=
X-Google-Smtp-Source: APXvYqxgCSdaR5KHU38MeXQVwfkv23dPsEuzW8Bl0+jLRbZwZWg5JazQmIlJv/0RGhght9BxVR+5cw==
X-Received: by 2002:a17:90a:ba91:: with SMTP id t17mr4125233pjr.116.1569915728449;
        Tue, 01 Oct 2019 00:42:08 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:08 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 10/13] ext4: fast-commit recovery path changes
Date:   Tue,  1 Oct 2019 00:40:59 -0700
Message-Id: <20191001074101.256523-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds core fast-commit recovery path changes. Each fast
commit block stores modified extents and added dentry for a particular
file. Replay code maps blocks in each such extent to the actual file
one-by-one. We also update corresponding file system metadata to account
for newly mapped blocks. Also, for the newly added dentrys we open the
parent inode and add dentry found in fast commit block into the parent
dir. In order to achieve all of these, ext4_inode_csum_set(),
ext4_inode_blocks(), ext4_find_entry(), ext4_add_nondir(),
ext4_reset_inode_seed() which were earlier static are now made visible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/balloc.c            |   7 +-
 fs/ext4/ext4.h              |  19 ++
 fs/ext4/ext4_jbd2.c         | 369 ++++++++++++++++++++++++++++++++++++
 fs/ext4/extents.c           |  19 +-
 fs/ext4/ialloc.c            |  51 +++--
 fs/ext4/inode.c             |  13 +-
 fs/ext4/ioctl.c             |   6 +-
 fs/ext4/mballoc.c           |  83 ++++++++
 fs/ext4/mballoc.h           |   2 +
 fs/ext4/namei.c             |   4 +-
 include/trace/events/ext4.h |  22 +++
 11 files changed, 560 insertions(+), 35 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..2433f12d2d88 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -360,7 +360,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->s_fc_replay)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c36ec23046f3..cd5b567d8ca8 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1404,6 +1404,13 @@ struct ext4_super_block {
 #define ext4_has_strict_mode(sbi) \
 	(sbi->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL)
 
+struct ext4_fc_replay_state {
+	int fc_replay_error;
+	int fc_replay_expected_off;
+	int fc_replay_expected_tid;
+	int fc_replay_current_subtid;
+};
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1588,6 +1595,7 @@ struct ext4_sb_info {
 					 * Are changes after the last commit
 					 * eligible for fast commit?
 					 */
+	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
 };
 
@@ -2577,6 +2585,10 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
@@ -2660,12 +2672,19 @@ extern int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
 /* ioctl.c */
 extern long ext4_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext4_compat_ioctl(struct file *, unsigned int, unsigned long);
+extern void ext4_reset_inode_seed(struct inode *inode);
 
 /* migrate.c */
 extern int ext4_ext_migrate(struct inode *);
 extern int ext4_ind_migrate(struct inode *inode);
 
 /* namei.c */
+extern struct buffer_head *ext4_find_entry(struct inode *dir,
+					   const struct qstr *d_name,
+					   struct ext4_dir_entry_2 **res_dir,
+				    int *inlined);
+extern int ext4_add_nondir(handle_t *handle,
+		    struct dentry *dentry, struct inode *inode);
 extern int ext4_dirblock_csum_verify(struct inode *inode,
 				     struct buffer_head *bh);
 extern int ext4_orphan_add(handle_t *, struct inode *);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index fd7740372438..12d6e70bf676 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -5,6 +5,7 @@
 
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
+#include "mballoc.h"
 
 #include <trace/events/ext4.h>
 
@@ -517,6 +518,16 @@ static inline u8 *fc_add_tag(u8 *dst, u16 tag, u16 len, u8 *val)
 	return dst + sizeof(tl) + len;
 }
 
+static int fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+static u8 *fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (u8 *)tl + sizeof(*tl);
+}
+
 int ext4_fc_write_inode(journal_t *journal, struct buffer_head *bh,
 			struct inode *inode, tid_t tid, tid_t subtid,
 			int is_last, struct dentry *dentry)
@@ -782,10 +793,368 @@ static int ext4_journal_fc_commit_cb(journal_t *journal, tid_t tid,
 	return jbd2_wait_on_fc_bufs(journal, num_bufs);
 }
 
+int ext4_fc_create_inode(struct super_block *sb, struct ext4_inode *raw_inode,
+			 int ino, unsigned long parent, const char *dname,
+			 int dlen)
+{
+	struct inode *dir = NULL, *inode = NULL;
+	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
+	struct qstr qstr_dname = QSTR_INIT(dname, dlen);
+	struct ext4_dir_entry_2 *res_dir = NULL;
+	struct buffer_head *dirent_bh;
+	int ret = 0, inlined;
+
+	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
+	if (!IS_ERR(inode)) {
+		jbd_debug(1, "Inode %d already exists.", inode->i_ino);
+		iput(inode);
+		return PTR_ERR(inode);
+	}
+
+	dir = ext4_iget(sb, parent, EXT4_IGET_NORMAL);
+	if (IS_ERR(dir)) {
+		jbd_debug(1, "Dir with inode %d not found.", parent);
+		ret = PTR_ERR(inode);
+		goto out;
+	}
+
+	dentry_dir = d_obtain_alias(dir);
+	if (IS_ERR(dentry_dir)) {
+		jbd_debug(1, "Failed to obtain dentry");
+		ret = PTR_ERR(dentry_dir);
+		goto out;
+	}
+
+	dentry_inode = d_alloc(dentry_dir, &qstr_dname);
+	if (!dentry_inode) {
+		jbd_debug(1, "Inode dentry not created.");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	inode = ext4_new_inode(NULL, dir, le16_to_cpu(raw_inode->i_mode), NULL,
+			       ino, NULL, le32_to_cpu(raw_inode->i_flags));
+	if (IS_ERR(inode)) {
+		jbd_debug(1, "Failed to create a new inode.");
+		ret = PTR_ERR(inode);
+		goto out;
+	}
+
+	dirent_bh = ext4_find_entry(dir, &qstr_dname, &res_dir, &inlined);
+	if (!dirent_bh || IS_ERR(dirent_bh)) {
+		ret = ext4_add_nondir(NULL, dentry_inode, inode);
+		if (ret != 0) {
+			jbd_debug(1, "Failed to add dentry\n");
+			goto out;
+		}
+	} else {
+		if (le32_to_cpu(res_dir->inode) != inode->i_ino) {
+			jbd_debug(1, "Entry exists and mismatched inode nos.");
+			brelse(dirent_bh);
+			ret = -EEXIST;
+			goto out;
+		}
+		brelse(dirent_bh);
+	}
+
+	ext4_mark_inode_dirty(NULL, dir);
+
+out:
+	if (dentry_dir) {
+		d_drop(dentry_dir);
+		dput(dentry_dir);
+	} else if (dir) {
+		iput(dir);
+	}
+	if (dentry_inode) {
+		d_drop(dentry_inode);
+		dput(dentry_inode);
+	}
+
+	return 0;
+}
+
+static int ext4_journal_fc_replay_scan(struct super_block *sb,
+				       struct buffer_head *bh, int off)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_replay_state *state;
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_fc_tl *tl;
+	__u32 csum, dummy_csum = 0;
+	__u8 *start;
+	tid_t fc_subtid;
+	int i;
+
+	state = &sbi->s_fc_replay_state;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	fc_subtid = le32_to_cpu(fc_hdr->fc_subtid);
+
+	if (le32_to_cpu(fc_hdr->fc_magic) != EXT4_FC_MAGIC) {
+		state->fc_replay_error = -ENOENT;
+		goto out_err;
+	}
+
+	if (off != state->fc_replay_expected_off) {
+		state->fc_replay_error = -EFSCORRUPTED;
+		goto out_err;
+	}
+
+	if (le16_to_cpu(fc_hdr->fc_features)) {
+		state->fc_replay_error = -EOPNOTSUPP;
+		goto out_err;
+	}
+
+	/* Check if we already concluded that this fast commit is not useful */
+	if (state->fc_replay_error && state->fc_replay_error != -EPROTO)
+		goto out_err;
+
+	if (state->fc_replay_expected_off == 0) {
+		/* This is a first block */
+		state->fc_replay_current_subtid = fc_subtid;
+		/*
+		 * We set replay error by default until we find an end
+		 * block for a particular subtid
+		 */
+		state->fc_replay_error = -EPROTO;
+	}
+
+	if (state->fc_replay_error == 0) {
+		/*
+		 * We have already encountered _last_ block for previous
+		 * subtid. So we should only find a bigger subtid here.
+		 */
+		if (fc_subtid <= state->fc_replay_current_subtid) {
+			state->fc_replay_error = -EFSCORRUPTED;
+			goto out_err;
+		}
+		state->fc_replay_current_subtid = fc_subtid;
+		state->fc_replay_error = -EPROTO;
+	} else if (state->fc_replay_current_subtid != fc_subtid) {
+		/*
+		 * Different subtid found before we found the end of this
+		 * subtid.
+		 */
+		state->fc_replay_error = -EFSCORRUPTED;
+		goto out_err;
+	}
+
+	/*
+	 * We can replay fast commit blocks only if we find a _last_ block for
+	 * all subtids.
+	 */
+	if (ext4_fc_is_last(fc_hdr))
+		state->fc_replay_error = 0;
+
+	csum = ext4_chksum(sbi, 0, fc_hdr,
+			   offsetof(struct ext4_fc_commit_hdr, fc_csum));
+	csum = ext4_chksum(sbi, csum, &dummy_csum, sizeof(dummy_csum));
+
+	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
+	start = (__u8 *)tl;
+	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_PARENT_INO:
+		case EXT4_FC_TAG_DNAME:
+		case EXT4_FC_TAG_EXT:
+			break;
+		default:
+			goto out_err;
+		}
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +
+					   le16_to_cpu(tl->fc_len) +
+					   sizeof(*tl));
+	}
+	csum = ext4_chksum(sbi, csum, start, (__u8 *)tl - start);
+	if (csum != le32_to_cpu(fc_hdr->fc_csum)) {
+		state->fc_replay_error = -EFSBADCRC;
+		goto out_err;
+	}
+
+	state->fc_replay_expected_off++;
+	return 0;
+
+out_err:
+	trace_ext4_journal_fc_replay_scan(sb, off, state->fc_replay_error);
+	return state->fc_replay_error;
+}
+
+static void ext4_fc_add_block(struct inode *inode, ext4_lblk_t lblk,
+			      ext4_fsblk_t pblk, int unwritten)
+{
+	struct ext4_extent ex;
+	struct ext4_ext_path *path = NULL;
+	struct ext4_map_blocks map;
+	int ret;
+
+	map.m_lblk = lblk;
+	map.m_len = 0x1;
+	ret = ext4_map_blocks(NULL, inode, &map, 0);
+	if (ret > 0) {
+		if (pblk != map.m_pblk)
+			jbd_debug(1, "Bad mapping found while replaying fc\n");
+		return;
+	}
+
+	ex.ee_block = cpu_to_le32(lblk);
+	ext4_ext_store_pblock(&ex, pblk);
+	ex.ee_len = cpu_to_le16(0x1);
+	if (unwritten)
+		ext4_ext_mark_unwritten(&ex);
+
+	path = ext4_find_extent(inode, lblk, NULL, 0);
+	if (path) {
+		down_write(&EXT4_I(inode)->i_data_sem);
+		ret = ext4_ext_insert_extent(NULL, inode, &path, &ex, 0);
+		ext4_mb_mark_used(inode->i_sb, ext4_ext_pblock(&ex), 0x1);
+		up_write((&EXT4_I(inode)->i_data_sem));
+		kfree(path);
+	}
+}
+
+static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
+				     enum passtype pass, int off)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_commit_hdr *fc_hdr;
+	struct ext4_fc_tl *tl;
+	struct ext4_iloc iloc;
+	struct ext4_extent *ex;
+	struct inode *inode;
+	char *dname = NULL;
+	int dname_len = 0;
+	int parent_ino = -1;
+	int i, j, ret;
+
+	if (pass == PASS_SCAN)
+		return ext4_journal_fc_replay_scan(sb, bh, off);
+
+	if (sbi->s_fc_replay_state.fc_replay_error) {
+		jbd_debug(1, "FC replay error set = %d\n",
+			  sbi->s_fc_replay_state.fc_replay_error);
+		return sbi->s_fc_replay_state.fc_replay_error;
+	}
+
+	sbi->s_fc_replay = true;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	jbd_debug(3, "%s: Got FC block for inode %d at [%d,%d]", __func__,
+		  le32_to_cpu(fc_hdr->fc_ino),
+		  be32_to_cpu(((journal_header_t *)bh->b_data)->h_sequence),
+		  le32_to_cpu(fc_hdr->fc_subtid));
+
+	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
+	if (le16_to_cpu(fc_hdr->fc_num_tlvs) >= 2) {
+		for (i = 0; i < 2; i++) {
+			switch (le16_to_cpu(tl->fc_tag)) {
+			case EXT4_FC_TAG_DNAME:
+				dname = fc_tag_val(tl);
+				dname_len = fc_tag_len(tl);
+				break;
+			case EXT4_FC_TAG_PARENT_INO:
+				parent_ino = le32_to_cpu(
+				    *(__le32 *)fc_tag_val(tl));
+				break;
+			}
+			tl = (struct ext4_fc_tl *)(fc_tag_val(tl) +
+						   fc_tag_len(tl));
+		}
+	}
+
+	if (parent_ino && dname) {
+		ret = ext4_fc_create_inode(sb, &fc_hdr->inode,
+				     le32_to_cpu(fc_hdr->fc_ino), parent_ino,
+				     dname, dname_len);
+		if (ret) {
+			jbd_debug(1, "Failed to create ext4 inode.");
+			return ret;
+		}
+	}
+
+	inode = ext4_iget(sb, le32_to_cpu(fc_hdr->fc_ino), EXT4_IGET_NORMAL);
+	if (IS_ERR(inode))
+		return 0;
+
+	ret = ext4_get_inode_loc(inode, &iloc);
+	if (ret)
+		return ret;
+
+	inode_lock(inode);
+	tl = (struct ext4_fc_tl *)(fc_hdr + 1);
+	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_EXT:
+			ex = (struct ext4_extent *)(tl + 1);
+			/*
+			 * We add block by block because part of extent may
+			 * already have been added by a previous fast commit
+			 * replay.
+			 */
+			for (j = 0; j < ext4_ext_get_actual_len(ex); j++)
+				ext4_fc_add_block(inode,
+						  le32_to_cpu(ex->ee_block) + j,
+						  ext4_ext_pblock(ex) + j,
+						  ext4_ext_is_unwritten(ex));
+			break;
+		case EXT4_FC_TAG_PARENT_INO:
+		case EXT4_FC_TAG_DNAME:
+			break;
+		default:
+			jbd_debug(1, "Unknown tag found.\n");
+		}
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +
+					   le16_to_cpu(tl->fc_len) +
+					   sizeof(*tl));
+	}
+	ext4_reserve_inode_write(NULL, inode, &iloc);
+	inode_unlock(inode);
+
+	/*
+	 * Unless inode contains inline data, copy everything except
+	 * i_blocks. i_blocks would have been set alright by ext4_fc_add_block
+	 * call above.
+	 */
+	if (ext4_has_inline_data(inode)) {
+		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
+		       sizeof(struct ext4_inode));
+	} else {
+		memcpy(ext4_raw_inode(&iloc), &fc_hdr->inode,
+		       offsetof(struct ext4_inode, i_block));
+		memcpy(&ext4_raw_inode(&iloc)->i_generation,
+		       &fc_hdr->inode.i_generation,
+		       sizeof(struct ext4_inode) -
+		       offsetof(struct ext4_inode, i_generation));
+	}
+	inode->i_generation = le32_to_cpu(ext4_raw_inode(&iloc)->i_generation);
+	ext4_reset_inode_seed(inode);
+
+	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
+	ret = ext4_handle_dirty_metadata(NULL, inode, iloc.bh);
+	brelse(iloc.bh);
+	iput(inode);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+
+	sbi->s_fc_replay = false;
+
+	return ret;
+}
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
 	if (ext4_should_fast_commit(sb)) {
 		journal->j_fc_commit_callback = ext4_journal_fc_commit_cb;
 		journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
 	}
+
+	/*
+	 * We set replay callback even if fast commit disabled because we may
+	 * could still have fast commit blocks that need to be replayed even if
+	 * fast commit has now been turned off.
+	 */
+	journal->j_fc_replay_callback = ext4_journal_fc_replay_cb;
 }
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index dea4c2632272..d70c09cbbc3f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2893,7 +2893,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
 	struct partial_cluster partial;
-	handle_t *handle;
+	handle_t *handle = NULL;
 	int i = 0, err = 0;
 
 	partial.pclu = 0;
@@ -2903,9 +2903,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	ext_debug("truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
-	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (!sbi->s_fc_replay) {
+		handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
 
 again:
 	trace_ext4_ext_remove_space(inode, start, end, depth);
@@ -2925,7 +2927,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		/* find extent for or closest extent to this block */
 		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
 		if (IS_ERR(path)) {
-			ext4_journal_stop(handle);
+			if (!sbi->s_fc_replay)
+				ext4_journal_stop(handle);
 			return PTR_ERR(path);
 		}
 		depth = ext_depth(inode);
@@ -3011,7 +3014,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS);
 		if (path == NULL) {
-			ext4_journal_stop(handle);
+			if (!sbi->s_fc_replay)
+				ext4_journal_stop(handle);
 			return -ENOMEM;
 		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
@@ -3141,7 +3145,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	path = NULL;
 	if (err == -EAGAIN)
 		goto again;
-	ext4_journal_stop(handle);
+	if (!sbi->s_fc_replay)
+		ext4_journal_stop(handle);
 
 	return err;
 }
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 47d04a33a3ca..d32dea0757fe 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -82,7 +82,12 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->s_fc_replay)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
@@ -287,15 +292,17 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
 	bitmap_bh = ext4_read_inode_bitmap(sb, block_group);
 	/* Don't bother if the inode bitmap is corrupt. */
-	grp = ext4_get_group_info(sb, block_group);
 	if (IS_ERR(bitmap_bh)) {
 		fatal = PTR_ERR(bitmap_bh);
 		bitmap_bh = NULL;
 		goto error_return;
 	}
-	if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
-		fatal = -EFSCORRUPTED;
-		goto error_return;
+	if (!sbi->s_fc_replay) {
+		grp = ext4_get_group_info(sb, block_group);
+		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
+			fatal = -EFSCORRUPTED;
+			goto error_return;
+		}
 	}
 
 	BUFFER_TRACE(bitmap_bh, "get_write_access");
@@ -758,7 +765,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	struct inode *ret;
 	ext4_group_t i;
 	ext4_group_t flex_group;
-	struct ext4_group_info *grp;
+	struct ext4_group_info *grp = NULL;
 	int encrypt = 0;
 
 	/* Cannot create files in a deleted directory */
@@ -896,15 +903,20 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		if (ext4_free_inodes_count(sb, gdp) == 0)
 			goto next_group;
 
-		grp = ext4_get_group_info(sb, group);
-		/* Skip groups with already-known suspicious inode tables */
-		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
-			goto next_group;
+		if (!sbi->s_fc_replay) {
+			grp = ext4_get_group_info(sb, group);
+			/*
+			 * Skip groups with already-known suspicious inode
+			 * tables
+			 */
+			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+				goto next_group;
+		}
 
 		brelse(inode_bitmap_bh);
 		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
 		/* Skip groups with suspicious inode tables */
-		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp) ||
+		if ((!sbi->s_fc_replay && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
 		    IS_ERR(inode_bitmap_bh)) {
 			inode_bitmap_bh = NULL;
 			goto next_group;
@@ -923,7 +935,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 			goto next_group;
 		}
 
-		if (!handle) {
+		if (!sbi->s_fc_replay && !handle) {
 			BUG_ON(nblocks <= 0);
 			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
 							 handle_type, nblocks,
@@ -1027,9 +1039,15 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	/* Update the relevant bg descriptor fields */
 	if (ext4_has_group_desc_csum(sb)) {
 		int free;
-		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
-
-		down_read(&grp->alloc_sem); /* protect vs itable lazyinit */
+		struct ext4_group_info *grp = NULL;
+
+		if (!sbi->s_fc_replay) {
+			grp = ext4_get_group_info(sb, group);
+			down_read(&grp->alloc_sem); /*
+						     * protect vs itable
+						     * lazyinit
+						     */
+		}
 		ext4_lock_group(sb, group); /* while we modify the bg desc */
 		free = EXT4_INODES_PER_GROUP(sb) -
 			ext4_itable_unused_count(sb, gdp);
@@ -1045,7 +1063,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		if (ino > free)
 			ext4_itable_unused_set(sb, gdp,
 					(EXT4_INODES_PER_GROUP(sb) - ino));
-		up_read(&grp->alloc_sem);
+		if (!sbi->s_fc_replay)
+			up_read(&grp->alloc_sem);
 	} else {
 		ext4_lock_group(sb, group);
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index cbfa1ec858a1..9e5d8a82556f 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -103,8 +103,8 @@ static int ext4_inode_csum_verify(struct inode *inode, struct ext4_inode *raw,
 	return provided == calculated;
 }
 
-static void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
-				struct ext4_inode_info *ei)
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei)
 {
 	__u32 csum;
 
@@ -4800,8 +4800,8 @@ void ext4_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_CASEFOLD);
 }
 
-static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
-				  struct ext4_inode_info *ei)
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei)
 {
 	blkcnt_t i_blocks ;
 	struct inode *inode = &(ei->vfs_inode);
@@ -4951,8 +4951,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
-		ext4_error_inode(inode, function, line, 0,
-				 "iget: checksum invalid");
+		if (!EXT4_SB(sb)->s_fc_replay)
+			ext4_error_inode(inode, function, line, 0,
+					 "iget: checksum invalid");
 		ret = -EFSBADCRC;
 		goto bad_inode;
 	}
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a8e23acb5c03..35019e9d2803 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -86,7 +86,7 @@ static void swap_inode_data(struct inode *inode1, struct inode *inode2)
 	i_size_write(inode2, isize);
 }
 
-static void reset_inode_seed(struct inode *inode)
+void ext4_reset_inode_seed(struct inode *inode)
 {
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
@@ -199,8 +199,8 @@ static long swap_inode_boot_loader(struct super_block *sb,
 
 	inode->i_generation = prandom_u32();
 	inode_bl->i_generation = prandom_u32();
-	reset_inode_seed(inode);
-	reset_inode_seed(inode_bl);
+	ext4_reset_inode_seed(inode);
+	ext4_reset_inode_seed(inode_bl);
 
 	ext4_discard_preallocations(inode);
 
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a3e2767bdf2f..70551fa91237 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2915,6 +2915,89 @@ void ext4_exit_mballoc(void)
 }
 
 
+void ext4_mb_mark_used(struct super_block *sb, ext4_fsblk_t block,
+		       int len)
+{
+	struct buffer_head *bitmap_bh = NULL;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	ext4_group_t group;
+	ext4_fsblk_t cluster;
+	ext4_grpblk_t blkoff;
+	int i, clen, err;
+	int already_allocated_count;
+
+	cluster = EXT4_B2C(sbi, block);
+	clen = EXT4_B2C(sbi, len);
+
+	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
+	bitmap_bh = ext4_read_block_bitmap(sb, group);
+	if (IS_ERR(bitmap_bh)) {
+		err = PTR_ERR(bitmap_bh);
+		bitmap_bh = NULL;
+		goto out_err;
+	}
+
+	err = -EIO;
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp)
+		goto out_err;
+
+	if (!ext4_data_block_valid(sbi, block, len)) {
+		ext4_error(sb, "Allocating blks %llu-%llu which overlap mdata",
+			   cluster, cluster+clen);
+		/* File system mounted not to panic on error
+		 * Fix the bitmap and return EFSCORRUPTED
+		 * We leak some of the blocks here.
+		 */
+		ext4_lock_group(sb, group);
+		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
+		ext4_unlock_group(sb, group);
+		err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+		if (!err)
+			err = -EFSCORRUPTED;
+		goto out_err;
+	}
+
+	ext4_lock_group(sb, group);
+	already_allocated_count = 0;
+	for (i = 0; i < clen; i++)
+		if (mb_test_bit(blkoff + i, bitmap_bh->b_data))
+			already_allocated_count++;
+
+	ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
+	if (ext4_has_group_desc_csum(sb) &&
+	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
+		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
+		ext4_free_group_clusters_set(sb, gdp,
+					     ext4_free_clusters_after_init(sb,
+						group, gdp));
+	}
+	clen = ext4_free_group_clusters(sb, gdp) - clen +
+	       already_allocated_count;
+	ext4_free_group_clusters_set(sb, gdp, clen);
+	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
+	ext4_group_desc_csum_set(sb, group, gdp);
+
+	ext4_unlock_group(sb, group);
+
+	if (sbi->s_log_groups_per_flex) {
+		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+
+		atomic64_sub(len,
+			     &sbi->s_flex_groups[flex_group].free_clusters);
+	}
+
+	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
+	if (err)
+		goto out_err;
+	err = ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
+
+out_err:
+	brelse(bitmap_bh);
+}
+
 /*
  * Check quota and mark chosen space (ac->ac_b_ex) non-free in bitmaps
  * Returns 0 if success or error code
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 88c98f17e3d9..1881710041b6 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -215,4 +215,6 @@ ext4_mballoc_query_range(
 	ext4_mballoc_query_range_fn	formatter,
 	void				*priv);
 
+void ext4_mb_mark_used(struct super_block *sb, ext4_fsblk_t block,
+		       int len);
 #endif
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8b73c5a38d49..0f0b6a64b3b1 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1578,7 +1578,7 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 	return ret;
 }
 
-static struct buffer_head *ext4_find_entry(struct inode *dir,
+struct buffer_head *ext4_find_entry(struct inode *dir,
 					   const struct qstr *d_name,
 					   struct ext4_dir_entry_2 **res_dir,
 					   int *inlined)
@@ -2549,7 +2549,7 @@ static void ext4_dec_count(handle_t *handle, struct inode *inode)
 }
 
 
-static int ext4_add_nondir(handle_t *handle,
+int ext4_add_nondir(handle_t *handle,
 		struct dentry *dentry, struct inode *inode)
 {
 	int err = ext4_add_entry(handle, dentry, inode);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 9c24b1c5239f..59329d69d0fc 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2703,6 +2703,28 @@ TRACE_EVENT(ext4_error,
 		  __entry->function, __entry->line)
 );
 
+TRACE_EVENT(ext4_journal_fc_replay_scan,
+	TP_PROTO(struct super_block *sb, int error, int off),
+
+	TP_ARGS(sb, error, off),
+
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(int, error)
+		__field(int, off)
+	),
+
+	TP_fast_assign(
+		__entry->dev = sb->s_dev;
+		__entry->error = error;
+		__entry->off = off;
+	),
+
+	TP_printk("FC scan pass on dev %d,%d: error %d, off %d",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->error, __entry->off)
+);
+
 TRACE_EVENT(ext4_journal_fc_commit_cb_start,
 	TP_PROTO(struct super_block *sb),
 
-- 
2.23.0.444.g18eeb5a265-goog

