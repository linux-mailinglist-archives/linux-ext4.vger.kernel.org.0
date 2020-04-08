Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 902AE1A2B8F
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgDHV4C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:56:02 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54846 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgDHV4B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:56:01 -0400
Received: by mail-pj1-f68.google.com with SMTP id np9so395863pjb.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GGxV/mejNxD37vT9WLknnVeLe//Orzd+TBlSuQQ1asI=;
        b=ki0QLS6mUCfZ/qikqVoms4pRFLbB7QI0ndTpgiJyNN4uFaMnhmTaeIU214OCuasR9p
         Y4N0ru0GUWOrMxdmzb+O6uyOElEwUbgIx3G9IrxoYCuVlmt976Sb6Z6Ecg6HC/A6G7sj
         WAid0F1IHEb6MEHFnoWpk6QEMJ17vo1wxb7i0ifVubGtqtcVMEqyniv9n3z4c8CL1snG
         FVkcOpDwvnQvWSruw9ZhUfAQ+umtxG0X5lQ97d+8a6zBf7tc24e1v2Yepwm1WD1hfCFt
         3MTAcCwejxdHucAkkmsHnsT3/wO9ke7RNDoRgDKbvO+OOkD6FnyjGNFV38yr6USPxwjN
         FjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GGxV/mejNxD37vT9WLknnVeLe//Orzd+TBlSuQQ1asI=;
        b=t3oZ3quNIfvfxVmtqC+V2wJX95k5W7AuzC+HB4XEvd9p73zbG5UXk5p2CmaeZKytGi
         zypJGbYli6RztOweEdi7IhehK5c2Rgo/R8a7oFDcUsO2yLykfy2eOlZcCIgMYakyeFHW
         biuwBg9eCP+V1IflUyGjwBDn2xgFGZIJNRYuhTk9zfwcQCW4nnZXIuzKrnxZy23gUHHg
         ZrUWiR/NfJQ7UMLk5/QtOCmMT3ydomXZkUYlLOrDZCtmDWDj7DGv69pOfEhqLpT4AtBM
         dqHvfMVg5uO5dQEtpwYCTBCEkNcsClLXQioebCEm9VY5jOuVgpGf0dZF6LwjIGwz8KOu
         kH8w==
X-Gm-Message-State: AGi0PuYE84MBYbMHcvHADgktHzUjb+qzwaNswpdcPLny+FGLD4i3oFuZ
        7Ys80MOk71Rr5MEMLZf8h+OxdXCy
X-Google-Smtp-Source: APiQypItRXx1VxSMtbvetlDpEqsH4jTVhIAw3RhznGAm0JS2oNa7W3+Qw74eyo1tK4GFyWv4m5t/1w==
X-Received: by 2002:a17:90a:24af:: with SMTP id i44mr7900511pje.136.1586382957867;
        Wed, 08 Apr 2020 14:55:57 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:57 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 19/20] ext4: add fast commit replay path
Date:   Wed,  8 Apr 2020 14:55:29 -0700
Message-Id: <20200408215530.25649-19-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Add main routine for replaying fast commit blocks. Fast commit replay
routine should be idempotent; so that if we crash while replaying,
we can restart from the beginning and won't result in a corrupted
file system.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h              |   9 +
 fs/ext4/ext4_jbd2.c         | 470 ++++++++++++++++++++++++++++++++++++
 include/trace/events/ext4.h |  22 ++
 3 files changed, 501 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 45b73c8bf5a6..df88e408d0bf 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1439,6 +1439,14 @@ struct ext4_super_block {
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
@@ -1650,6 +1658,7 @@ struct ext4_sb_info {
 					 * that have data changes in them.
 					 */
 	struct list_head s_fc_dentry_q;
+	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
 	struct ext4_fc_stats s_fc_stats;
 };
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b9b3833c8fdd..5effa1389705 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -5,6 +5,7 @@
 
 #include "ext4_jbd2.h"
 #include "ext4_extents.h"
+#include "mballoc.h"
 
 #include <trace/events/ext4.h>
 
@@ -856,6 +857,18 @@ static int fc_write_data(struct inode *inode, u8 *start, u8 *end,
 	return num_tlvs;
 }
 
+/* Get length of a particular tlv */
+static int fc_tag_len(struct ext4_fc_tl *tl)
+{
+	return le16_to_cpu(tl->fc_len);
+}
+
+/* Get a pointer to "value" of a tlv */
+static u8 *fc_tag_val(struct ext4_fc_tl *tl)
+{
+	return (u8 *)tl + sizeof(*tl);
+}
+
 static int fc_commit_data_inode(journal_t *journal, struct inode *inode)
 {
 	struct ext4_fc_commit_hdr *hdr;
@@ -1178,6 +1191,457 @@ static void ext4_journal_fc_cleanup_cb(journal_t *journal)
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
@@ -1357,6 +1821,12 @@ int ext4_fc_async_commit_inode(journal_t *journal, tid_t commit_tid,
 
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
index 8f31fd427ccc..22bacf860de8 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2736,6 +2736,28 @@ TRACE_EVENT(ext4_error,
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
2.26.0.110.g2183baf09c-goog

