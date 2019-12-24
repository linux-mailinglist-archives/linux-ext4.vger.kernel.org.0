Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EE7129EE1
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfLXIPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33328 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfLXIPE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:04 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so10076025pgk.0
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IrjrEfuBkbvLCfvYlfjKFHtz72+uoqhZEndSRgL5pho=;
        b=g2QZXQypz9W470gi4wWuVF+bgK2WgIULpa3qCDO8b3UtVLvKfXGB1QTzOscqP8gpYx
         DvEz6y9b5cdUTpwgFYsdmgLwO/l8O0dwAosPa8qvr0GdroamavMU9PdJ6XoryThVQfrZ
         rkeTtSxdDYQKYBA4S34+TdkGhuClnlyLqPUTLEljE46d1rHk2DvO8lWSdinjNmkci6lY
         r2/yPs1HBvCSfQLDqjBsQ+7IKS2/T3psvyWbZUdQMZyw2M7vD7xQC/g0/8FYas+Sanm1
         Pu8LfzegLTU7N5VWwrDBpx/0Fj0e9c0VPzW8oom+PQpZE5QUNoEeVYOiAZyUwk0jS+PX
         ZGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IrjrEfuBkbvLCfvYlfjKFHtz72+uoqhZEndSRgL5pho=;
        b=FgQ4oz6GF7w93mWFNPSizlf1NPXj8LKHf3tf0iUWMbUPfNNQhOFDUM96LoH4AUz4wo
         6EnbEXlNbdW00m330tFBfGOBxrXzbPh4Z+UapJn3PMjeohC4IHaB51RWuiwj8r7990iq
         guwN//ZLPB4MpcK/Kd2VTicb7rNMKgppETSoXCkPtLdmGrAFM4of79K7yKaYMpxpOkEH
         dAmFXJXmkjaZw3vpA418urGmAsl1u//EOhSkkkDjaHnayT/lQ4umTMOnAYUaR8N3E9wt
         ImGMrMbgyWU3sr2pxfmHr+xgg0gDED9VvYw+SlKrFbWPg/WgpKe0Kq9Y2yBMrvNJrocn
         Vrzg==
X-Gm-Message-State: APjAAAW1QTvWRY7J7cAVJoM53ci+IBjTPNiPFSjR09wVQ6VqPUXqYYru
        r6SrSqmF67zS0MJN+n6eye0iH6KN
X-Google-Smtp-Source: APXvYqxMNt7vEWIgum2qYyGEGVSvXf3otbdlU3kVagTJdNg+dY8UzyPH72E/wce5NWVwIFZVE8BV/A==
X-Received: by 2002:a63:1945:: with SMTP id 5mr36714551pgz.310.1577175302922;
        Tue, 24 Dec 2019 00:15:02 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:15:02 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 19/20] ext4: add fast commit replay path
Date:   Tue, 24 Dec 2019 00:13:23 -0800
Message-Id: <20191224081324.95807-19-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add main routine for replaying fast commit blocks. Fast commit replay
routine should be idempotent; so that if we crash while replaying,
we can restart from the beginning and won't result in a corrupted
file system.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |   9 +
 fs/ext4/ext4_jbd2.c         | 459 ++++++++++++++++++++++++++++++++++++
 include/trace/events/ext4.h |  22 ++
 3 files changed, 490 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1957f30a7f2e..e12900d77673 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1436,6 +1436,14 @@ struct ext4_super_block {
 #define ext4_has_strict_mode(sbi) \
 	(sbi->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL)
 
+/*
+ * Fast commit replay state.
+ */
+struct ext4_fc_replay_state {
+	int fc_replay_error;
+	int fc_replay_expected_off;
+};
+
 /*
  * Fast commit ineligible reasons.
  */
@@ -1642,6 +1650,7 @@ struct ext4_sb_info {
 					 * that have data changes in them.
 					 */
 	struct list_head s_fc_dentry_q;
+	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
 	struct ext4_fc_stats s_fc_stats;
 };
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 7c6cdbc63aa6..ef36a973ed8b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -5,6 +5,7 @@
 
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
+#include "mballoc.h"
 
 #include <trace/events/ext4.h>
 
@@ -1153,6 +1154,457 @@ static void ext4_journal_fc_cleanup_cb(journal_t *journal)
 	trace_ext4_journal_fc_stats(sb);
 }
 
+struct dentry_info_args {
+	int parent_ino, dname_len, ino, inode_len;
+	char *dname;
+};
+
+static int fc_replay_add_link(struct super_block *sb, struct inode *inode,
+			     struct dentry_info_args *darg)
+{
+	struct inode *dir = NULL;
+	struct dentry *dentry_dir = NULL, *dentry_inode = NULL;
+	struct qstr qstr_dname = QSTR_INIT(darg->dname, darg->dname_len);
+	int ret = 0;
+
+	dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
+	if (IS_ERR(dir)) {
+		jbd_debug(1, "Dir with inode %d not found.", darg->parent_ino);
+		ret = PTR_ERR(dir);
+		dir = NULL;
+		goto out;
+	}
+
+	dentry_dir = d_obtain_alias(dir);
+	if (IS_ERR(dentry_dir)) {
+		jbd_debug(1, "Failed to obtain dentry");
+		ret = PTR_ERR(dentry_dir);
+		dentry_dir = NULL;
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
+	ret = __ext4_link(dir, inode, dentry_inode);
+	if (ret && ret != -EEXIST) {
+		jbd_debug(1, "Failed to link\n");
+		goto out;
+	}
+
+	/*
+	 * It's possible that link already existed since data blocks
+	 * for the dir in question got persisted before we crashed.
+	 */
+	if (ret == -EEXIST)
+		ret = 0;
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
+	return ret;
+}
+
+static int fc_replay_create_inode(struct super_block *sb,
+			struct ext4_inode *raw_inode,
+			struct dentry_info_args *darg)
+{
+	int ret = 0;
+	struct ext4_iloc iloc;
+	int orig_nlink = 0;
+	struct inode *inode = NULL;
+	struct inode *dir = NULL;
+
+	/*
+	 * First let's setup the on-disk inode using the one found in
+	 * the journal
+	 */
+	ret = ext4_get_fc_inode_loc(sb, darg->ino, &iloc);
+	if (ret)
+		goto out;
+
+	orig_nlink = le16_to_cpu(ext4_raw_inode(&iloc)->i_links_count);
+	memcpy(ext4_raw_inode(&iloc), raw_inode, darg->inode_len);
+	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
+	if (ret)
+		goto out;
+	sync_dirty_buffer(iloc.bh);
+	brelse(iloc.bh);
+	iloc.bh = NULL;
+
+	/* This takes care of update group descriptor and other metadata */
+	ret = ext4_mark_inode_used(sb, darg->ino);
+	if (ret)
+		goto out;
+
+	inode = ext4_iget(sb, darg->ino, EXT4_IGET_NORMAL);
+	if (IS_ERR(inode)) {
+		jbd_debug(1, "inode %d not found.", darg->ino);
+		ret = PTR_ERR(inode);
+		goto out;
+	}
+
+	if (S_ISDIR(inode->i_mode)) {
+		dir = ext4_iget(sb, darg->parent_ino, EXT4_IGET_NORMAL);
+		if (IS_ERR_OR_NULL(dir)) {
+			iput(inode);
+			ret = PTR_ERR(dir);
+			goto out;
+		}
+		ret = ext4_init_new_dir(NULL, dir, inode);
+		iput(dir);
+		if (ret)
+			goto out;
+	}
+	ret = fc_replay_add_link(sb, inode, darg);
+	if (ret)
+		goto out;
+	set_nlink(inode, orig_nlink + 1);
+out:
+	if (inode)
+		iput(inode);
+	if (iloc.bh)
+		brelse(iloc.bh);
+	return ret;
+}
+
+static int fc_replay_dentries(journal_t *journal,
+			struct ext4_fc_commit_hdr *fc_hdr)
+{
+	struct dentry_info_args darg = {0};
+	struct super_block *sb = journal->j_private;
+	struct ext4_fc_tl *tl;
+	__u8 *start;
+	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
+	struct inode *old_parent;
+	struct inode *inode;
+	int ret;
+	int i;
+	struct ext4_fc_dentry_info *fcd;
+
+	if (EXT4_INODE_SIZE(sb) > EXT4_GOOD_OLD_INODE_SIZE)
+		inode_len +=
+			le16_to_cpu(((struct ext4_inode *)
+				     (fc_hdr + 1))->i_extra_isize);
+	tl = (struct ext4_fc_tl *)((u8 *)fc_hdr +
+				   sizeof(struct ext4_fc_commit_hdr) +
+				   inode_len);
+	start = (__u8 *)tl;
+	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
+		fcd = (struct ext4_fc_dentry_info *)fc_tag_val(tl);
+
+		darg.parent_ino = le32_to_cpu(fcd->fc_parent_ino);
+		darg.ino = le32_to_cpu(fcd->fc_ino);
+		darg.dname = fcd->fc_dname;
+		darg.dname_len = fc_tag_len(tl) -
+			sizeof(struct ext4_fc_dentry_info);
+		if (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_ADD_DENTRY) {
+			inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
+			if (IS_ERR_OR_NULL(inode)) {
+				jbd_debug(1, "Inode not found.");
+				return PTR_ERR(inode);
+			}
+			ret = fc_replay_add_link(sb, inode, &darg);
+			iput(inode);
+			if (ret)
+				return ret;
+		} else if (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_DEL_DENTRY) {
+			const struct qstr entry = {
+				.name = darg.dname,
+				.len = darg.dname_len
+			};
+			inode = ext4_iget(sb, darg.ino, EXT4_IGET_NORMAL);
+
+			if (IS_ERR_OR_NULL(inode))
+				return -ECANCELED;
+
+			old_parent = ext4_iget(sb, darg.parent_ino,
+					       EXT4_IGET_NORMAL);
+			if (IS_ERR_OR_NULL(old_parent)) {
+				iput(inode);
+				return -ECANCELED;
+			}
+
+			ret = __ext4_unlink(old_parent, &entry, inode);
+			/* -ENOENT ok coz it might not exist anymore. */
+			if (ret == -ENOENT)
+				ret = 0;
+			iput(old_parent);
+			iput(inode);
+			if (ret)
+				return ret;
+		} else if (le16_to_cpu(tl->fc_tag) ==
+			   EXT4_FC_TAG_CREAT_DENTRY) {
+			darg.inode_len = inode_len;
+			ret = fc_replay_create_inode(
+				sb, (struct ext4_inode *)(fc_hdr + 1), &darg);
+			if (ret) {
+				jbd_debug(1, "Failed to create ext4 inode.");
+				return ret;
+			}
+		}
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +
+					   le16_to_cpu(tl->fc_len) +
+					   sizeof(*tl));
+	}
+	return 0;
+}
+
+static int ext4_journal_fc_replay_scan(journal_t *journal,
+				       struct buffer_head *bh, int off)
+{
+	struct super_block *sb = journal->j_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_fc_replay_state *state;
+	struct ext4_fc_commit_hdr *fc_hdr;
+	__u32 csum, old_csum;
+	__u8 *start, *end;
+
+	state = &sbi->s_fc_replay_state;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	start = (u8 *)fc_hdr;
+	end = (__u8 *)bh->b_data + journal->j_blocksize;
+
+	/* Check if we already concluded that this fast commit is not useful */
+	if (state->fc_replay_expected_off && state->fc_replay_error)
+		goto out_err;
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
+	state->fc_replay_expected_off++;
+
+	if (le16_to_cpu(fc_hdr->fc_features)) {
+		state->fc_replay_error = -EOPNOTSUPP;
+		goto out_err;
+	}
+
+	old_csum = fc_hdr->fc_csum;
+	fc_hdr->fc_csum = 0;
+	csum = ext4_chksum(sbi, 0, start, end - start);
+	fc_hdr->fc_csum = old_csum;
+
+	if (csum != le32_to_cpu(fc_hdr->fc_csum)) {
+		state->fc_replay_error = -EFSBADCRC;
+		goto out_err;
+	}
+
+	trace_ext4_journal_fc_replay_scan(sb, state->fc_replay_error, off);
+	return 0;
+
+out_err:
+	trace_ext4_journal_fc_replay_scan(sb, state->fc_replay_error, off);
+	return state->fc_replay_error;
+}
+
+static int fc_add_range(struct inode *inode, struct ext4_extent *ex)
+{
+	struct ext4_extent newex;
+	ext4_lblk_t start, cur;
+	int remaining, len;
+	ext4_fsblk_t start_pblk;
+	struct ext4_map_blocks map;
+	struct ext4_ext_path *path = NULL;
+	int ret;
+
+	start = le32_to_cpu(ex->ee_block);
+	start_pblk = ext4_ext_pblock(ex);
+	len = ext4_ext_get_actual_len(ex);
+
+	cur = start;
+	remaining = len;
+
+	jbd_debug(1, "Adding extent %ld:%ld to inode %ld\n",
+		  start, len, inode->i_ino);
+
+	while (remaining > 0) {
+		map.m_lblk = cur;
+		map.m_len = remaining;
+
+		ret = ext4_map_blocks(NULL, inode, &map, 0);
+		if (ret < 0)
+			return -ECANCELED;
+		if (ret > 0) {
+			if (!!(ext4_ext_is_unwritten(ex)) ==
+			    !!(map.m_flags & EXT4_MAP_UNWRITTEN)) {
+				remaining -= ret;
+				cur += ret;
+				ext4_mb_mark_used(inode->i_sb,
+						  ext4_ext_pblock(ex),
+						  map.m_len);
+				continue;
+			}
+
+			/* handle change of state */
+			map.m_lblk = cur;
+			map.m_len = ret;
+			map.m_flags = 0;
+			ret = ext4_map_blocks(
+				NULL, inode, &map,
+				EXT4_GET_BLOCKS_IO_CONVERT_EXT);
+			if (ret <= 0)
+				return -ECANCELED;
+			remaining -= ret;
+			cur += ret;
+		} else if (ret == 0) {
+			path = ext4_find_extent(inode, cur, NULL, 0);
+			if (!path)
+				continue;
+			memset(&newex, 0, sizeof(newex));
+			newex.ee_block = cpu_to_le32(cur);
+			ext4_ext_store_pblock(
+				&newex, start_pblk + cur - start);
+			newex.ee_len = cpu_to_le16(map.m_len);
+			if (ext4_ext_is_unwritten(ex))
+				ext4_ext_mark_unwritten(&newex);
+			down_write(&EXT4_I(inode)->i_data_sem);
+
+			ret = ext4_ext_insert_extent(
+				NULL, inode, &path, &newex, 0);
+			ext4_mb_mark_used(
+				inode->i_sb, ext4_ext_pblock(&newex),
+				map.m_len);
+			up_write((&EXT4_I(inode)->i_data_sem));
+			kfree(path);
+			if (ret)
+				return -ECANCELED;
+			cur += map.m_len;
+			remaining -= map.m_len;
+		}
+	}
+	return 0;
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
+	struct ext4_fc_lrange *lrange;
+	struct inode *inode;
+
+	int i, ret;
+	int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
+
+	if (pass == PASS_SCAN)
+		return ext4_journal_fc_replay_scan(journal, bh, off);
+
+	if (sbi->s_fc_replay_state.fc_replay_error) {
+		jbd_debug(1, "FC replay error set = %d\n",
+			  sbi->s_fc_replay_state.fc_replay_error);
+		return sbi->s_fc_replay_state.fc_replay_error;
+	}
+
+	sbi->s_mount_state |= EXT4_FC_REPLAY;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	jbd_debug(3, "%s: Got FC block for inode %d at [%d,%d]", __func__,
+		  le32_to_cpu(fc_hdr->fc_ino),
+		  be32_to_cpu(((journal_header_t *)bh->b_data)->h_sequence));
+
+	if (EXT4_INODE_SIZE(sb) > EXT4_GOOD_OLD_INODE_SIZE)
+		inode_len += le16_to_cpu(((struct ext4_inode *)
+					  (fc_hdr + 1))->i_extra_isize);
+
+	ret = fc_replay_dentries(journal, fc_hdr);
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
+	tl = (struct ext4_fc_tl *)((u8 *)fc_hdr +
+				   sizeof(struct ext4_fc_commit_hdr) +
+				   inode_len);
+	for (i = 0; i < le16_to_cpu(fc_hdr->fc_num_tlvs); i++) {
+		switch (le16_to_cpu(tl->fc_tag)) {
+		case EXT4_FC_TAG_ADD_RANGE:
+			ex = (struct ext4_extent *)(tl + 1);
+			ret = fc_add_range(inode, ex);
+			break;
+		case EXT4_FC_TAG_DEL_RANGE:
+			lrange = (struct ext4_fc_lrange *)(tl + 1);
+			inode_unlock(inode);
+			ret = ext4_punch_hole(inode,
+				le32_to_cpu(lrange->fc_lblk) <<
+					      sb->s_blocksize_bits,
+				le32_to_cpu(lrange->fc_len) <<
+					      sb->s_blocksize_bits);
+			inode_lock(inode);
+			break;
+		case EXT4_FC_TAG_ADD_DENTRY:
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
+		memcpy(ext4_raw_inode(&iloc), fc_hdr + 1, inode_len);
+	} else {
+		memcpy(ext4_raw_inode(&iloc), fc_hdr + 1,
+		       offsetof(struct ext4_inode, i_block));
+		memcpy(&ext4_raw_inode(&iloc)->i_generation,
+		       &((struct ext4_inode *)(fc_hdr + 1))->i_generation,
+		       inode_len -
+		       offsetof(struct ext4_inode, i_generation));
+	}
+	inode->i_generation = le32_to_cpu(ext4_raw_inode(&iloc)->i_generation);
+	ext4_reset_inode_seed(inode);
+
+	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
+	ret = ext4_handle_dirty_metadata(NULL, NULL, iloc.bh);
+	sync_dirty_buffer(iloc.bh);
+	brelse(iloc.bh);
+	iput(inode);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+
+	sbi->s_mount_state &= ~EXT4_FC_REPLAY;
+
+	return ret;
+}
+
 int ext4_fc_perform_hard_commit(journal_t *journal)
 {
 	struct super_block *sb = (struct super_block *)(journal->j_private);
@@ -1202,6 +1654,7 @@ int ext4_fc_perform_hard_commit(journal_t *journal)
 
 	return nblks;
 }
+
 int ext4_fc_async_commit_inode(journal_t *journal, tid_t commit_tid,
 			       struct inode *inode)
 {
@@ -1331,6 +1784,12 @@ int ext4_fc_async_commit_inode(journal_t *journal, tid_t commit_tid,
 
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
+	/*
+	 * We set replay callback even if fast commit disabled because we may
+	 * could still have fast commit blocks that need to be replayed even if
+	 * fast commit has now been turned off.
+	 */
+	journal->j_fc_replay_callback = ext4_journal_fc_replay_cb;
 	if (!ext4_should_fast_commit(sb))
 		return;
 	journal->j_fc_cleanup_callback = ext4_journal_fc_cleanup_cb;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 8da371b38332..c455f8384def 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2716,6 +2716,28 @@ TRACE_EVENT(ext4_error,
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
2.24.1.735.g03f4e72817-goog

