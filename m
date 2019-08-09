Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C128704D
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Aug 2019 05:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405245AbfHIDqj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Aug 2019 23:46:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36728 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405192AbfHIDqh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Aug 2019 23:46:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so45277325pfl.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 Aug 2019 20:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70mL84Zj+oqJwB1/rpWefyytz1K+z1achazCJoanKpM=;
        b=fLnatKr8XK+rZrFSwAKA3CyzSiznLG7DjSSaDr5b3RExAqZ2Xp3lUFu6dZGehbXB3/
         lgN0BiHWmGN1szcvhGPqqfEqMWUy7nWnx9ArB2OsxPuAT/GqA0FN85CgY3gHaRvlFhzs
         GR03HXniuPdpEt39EVCA4FgLjKnopvEP8hoLgPNHnr3iube16+UUMDUHs+FyBTVdUcyd
         sfDqmyL4M4Hl9L36WPVV5PAoNKg+aBH9AZqwnzq/1VqkftWcLQZJO+U2Pb4dlZiYy3b2
         EPbwbozjbKDQhBQTpzUqUA/tZcXclCB6Gve0p/jaNQoR5HE9Hier1Ignyo4ntLUHAhOt
         fJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70mL84Zj+oqJwB1/rpWefyytz1K+z1achazCJoanKpM=;
        b=Mt4eV/o6puZhNDWDffvPcFeO6fq7cs8yOgCysEt+3D2/Ow3LnsljleWtnVHQsflhx/
         vNg2KmwmyunvA8yrly7OZEvz4I+vwO5QOAkIM9RkMZKGZFcRXKkpjRoU7ZlhL2gWQI3F
         4yRQRPc9Hm2Z7GR4BIOpekolAhddbVWV2KJjAEwr0OAJu/6RaOn31t8VVO+dhtz3Yo/C
         pSBdBTIkMdVLp2c4u9YBgzvkRlmhS8QbD1PkLxTfndwvNUjSz13Kw8OPXKs8y3THqogl
         gpixd8qkDhjMaZ3rpEOdgOwxQDt6JSbeKRdvkHzdUXU19rCBYr8T6PwU7rMsVJN9K81W
         caLw==
X-Gm-Message-State: APjAAAUpM/Zc/96xIYUuvD9ED5S96CHsS8fL3u6Y+JC7hUdCPmKTmiFc
        aswVYyihZgbICbinn+pHwdYIW1ES
X-Google-Smtp-Source: APXvYqwNccvxQkUwFP7jLsc6K9vUAkw5GNEg480Z3z4ecXMJD1MVsjbyY0P+cBTajCV0Uat/94XidQ==
X-Received: by 2002:a62:b615:: with SMTP id j21mr18649527pff.190.1565322396018;
        Thu, 08 Aug 2019 20:46:36 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id s5sm80191085pfm.97.2019.08.08.20.46.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 20:46:35 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 11/12] ext4: fast-commit recovery path changes
Date:   Thu,  8 Aug 2019 20:45:51 -0700
Message-Id: <20190809034552.148629-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds core fast-commit recovery path changes. Each fast
commit block stores modified extents for a particular file. Replay
code maps blocks in each such extent to the actual file one-by-one. We
also update corresponding file system metadata to account for newly
mapped blocks. In order to achieve all of these,
ext4_inode_csum_set(), ext4_inode_blocks() which were earlier static
are now made visible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

---

Changelog:

V2:
1) Fixed warning reported by Kbuild.

2) Implement scan pass.
    - we look for "last" blocks to maintain atomicity of
      subtransactions.
    - Implement CRC checksum verification.
    - If scan pass detects error, we don't perform replay pass.

3) Calling j_fc_replay_callback for SCAN pass as well. So added
   passtype and fast commit block offset parameters to
   j_fc_replay_callback.

Added tracepoint for replay SCAN pass
---
 fs/ext4/balloc.c            |   7 +-
 fs/ext4/ext4.h              |  12 ++
 fs/ext4/extents.c           |  19 +--
 fs/ext4/inode.c             |   8 +-
 fs/ext4/mballoc.c           |  83 +++++++++++++
 fs/ext4/mballoc.h           |   2 +
 fs/ext4/super.c             | 225 ++++++++++++++++++++++++++++++++++++
 fs/jbd2/commit.c            |   6 +-
 fs/jbd2/recovery.c          |  11 +-
 include/linux/jbd2.h        |   5 +-
 include/trace/events/ext4.h |  22 ++++
 include/trace/events/jbd2.h |   9 +-
 12 files changed, 386 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 0b202e00d93f..75c3025c7089 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -360,7 +360,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->fc_replay)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 210bd4c86d4f..ca1fbd77a934 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1378,6 +1378,13 @@ struct ext4_super_block {
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
@@ -1562,6 +1569,7 @@ struct ext4_sb_info {
 					 * Are changes after the last commit
 					 * eligible for fast commit?
 					 */
+	struct ext4_fc_replay_state s_fc_replay_state;
 	spinlock_t s_fc_lock;
 };
 
@@ -2588,6 +2596,10 @@ extern int ext4_trim_fs(struct super_block *, struct fstrim_range *);
 extern void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid);
 
 /* inode.c */
+void ext4_inode_csum_set(struct inode *inode, struct ext4_inode *raw,
+			 struct ext4_inode_info *ei);
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei);
 int ext4_inode_is_fast_symlink(struct inode *inode);
 struct buffer_head *ext4_getblk(handle_t *, struct inode *, ext4_lblk_t, int);
 struct buffer_head *ext4_bread(handle_t *, struct inode *, ext4_lblk_t, int);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 66f7f4fb1612..59fe596ce97d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2894,7 +2894,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
 	struct partial_cluster partial;
-	handle_t *handle;
+	handle_t *handle = NULL;
 	int i = 0, err = 0;
 
 	partial.pclu = 0;
@@ -2904,9 +2904,11 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	ext_debug("truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
-	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
-	if (IS_ERR(handle))
-		return PTR_ERR(handle);
+	if (!sbi->fc_replay) {
+		handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
+		if (IS_ERR(handle))
+			return PTR_ERR(handle);
+	}
 
 again:
 	trace_ext4_ext_remove_space(inode, start, end, depth);
@@ -2926,7 +2928,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		/* find extent for or closest extent to this block */
 		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
 		if (IS_ERR(path)) {
-			ext4_journal_stop(handle);
+			if (!sbi->fc_replay)
+				ext4_journal_stop(handle);
 			return PTR_ERR(path);
 		}
 		depth = ext_depth(inode);
@@ -3012,7 +3015,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
 			       GFP_NOFS);
 		if (path == NULL) {
-			ext4_journal_stop(handle);
+			if (!sbi->fc_replay)
+				ext4_journal_stop(handle);
 			return -ENOMEM;
 		}
 		path[0].p_maxdepth = path[0].p_depth = depth;
@@ -3142,7 +3146,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	path = NULL;
 	if (err == -EAGAIN)
 		goto again;
-	ext4_journal_stop(handle);
+	if (!sbi->fc_replay)
+		ext4_journal_stop(handle);
 
 	return err;
 }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index dd5d39a48363..21c9b5197c72 100644
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
 
@@ -4801,8 +4801,8 @@ void ext4_set_inode_flags(struct inode *inode)
 			S_ENCRYPTED|S_CASEFOLD);
 }
 
-static blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
-				  struct ext4_inode_info *ei)
+blkcnt_t ext4_inode_blocks(struct ext4_inode *raw_inode,
+			   struct ext4_inode_info *ei)
 {
 	blkcnt_t i_blocks ;
 	struct inode *inode = &(ei->vfs_inode);
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
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1191ebbb55c5..3b535eb624a7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -408,6 +408,224 @@ static int block_device_ejected(struct super_block *sb)
 	return bdi->dev == NULL;
 }
 
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
+	if (state->fc_replay_error != 0) {
+		if (state->fc_replay_current_subtid != fc_subtid) {
+			state->fc_replay_error = -EFSCORRUPTED;
+			goto out_err;
+		}
+	} else {
+		/*
+		 * We encountered _last_ block for previous subtid. So we should
+		 * only find a bigger subtid here.
+		 */
+		if (fc_subtid <= state->fc_replay_current_subtid) {
+			state->fc_replay_error = -EFSCORRUPTED;
+			goto out_err;
+		}
+		state->fc_replay_current_subtid = fc_subtid;
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
+		if (le16_to_cpu(tl->fc_tag) != EXT4_FC_TAG_EXT)
+			goto out_err;
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
+	int ret;
+
+	if (pass == PASS_SCAN)
+		return ext4_journal_fc_replay_scan(sb, bh, off);
+
+	if (sbi->s_fc_replay_state.fc_replay_error)
+		return sbi->s_fc_replay_state.fc_replay_error;
+
+	sbi->fc_replay = true;
+	fc_hdr = (struct ext4_fc_commit_hdr *)
+		  ((__u8 *)bh->b_data + sizeof(journal_header_t));
+
+	jbd_debug(3, "%s: Got FC block for inode %d at [%d,%d]", __func__,
+		  le32_to_cpu(fc_hdr->fc_ino),
+		  be32_to_cpu(((journal_header_t *)bh->b_data)->h_sequence),
+		  le32_to_cpu(fc_hdr->fc_subtid));
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
+	while (le16_to_cpu(tl->fc_tag) == EXT4_FC_TAG_EXT) {
+		int i;
+
+		ex = (struct ext4_extent *)(tl + 1);
+		tl = (struct ext4_fc_tl *)((__u8 *)tl +
+					   le16_to_cpu(tl->fc_len) +
+					   sizeof(*tl));
+		/*
+		 * We add block by block because part of extent may already have
+		 * been added by a previous fast commit replay.
+		 */
+		for (i = 0; i < ext4_ext_get_actual_len(ex); i++)
+			ext4_fc_add_block(inode, le32_to_cpu(ex->ee_block) + i,
+					  ext4_ext_pblock(ex) + i,
+					  ext4_ext_is_unwritten(ex));
+	}
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
+
+	ext4_reserve_inode_write(NULL, inode, &iloc);
+	inode_unlock(inode);
+	sbi->fc_replay = false;
+
+	ext4_inode_csum_set(inode, ext4_raw_inode(&iloc), EXT4_I(inode));
+	ret = ext4_handle_dirty_metadata(NULL, inode, iloc.bh);
+	iput(inode);
+	if (!ret)
+		ret = blkdev_issue_flush(sb->s_bdev, GFP_KERNEL, NULL);
+
+	brelse(iloc.bh);
+
+	return ret;
+}
+
+
 static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 {
 	struct super_block		*sb = journal->j_private;
@@ -4981,6 +5199,13 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
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
 	write_lock(&journal->j_state_lock);
 	if (test_opt(sb, BARRIER))
 		journal->j_flags |= JBD2_BARRIER;
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index db62a53436e3..1875cdc839fb 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -469,6 +469,10 @@ void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
 			if (fc)
 				*fc = true;
 			write_unlock(&journal->j_state_lock);
+			trace_jbd2_run_stats(journal->j_fs_dev->bd_dev,
+					     journal->j_running_transaction
+					     ->t_tid,
+					     &stats.run, true);
 			goto update_overall_stats;
 		}
 		if (journal->j_fc_cleanup_callback)
@@ -1156,7 +1160,7 @@ void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
 	stats.run.rs_handle_count =
 		atomic_read(&commit_transaction->t_handle_count);
 	trace_jbd2_run_stats(journal->j_fs_dev->bd_dev,
-			     commit_transaction->t_tid, &stats.run);
+			     commit_transaction->t_tid, &stats.run, false);
 	stats.ts_requested = (commit_transaction->t_requested) ? 1 : 0;
 
 	commit_transaction->t_state = T_COMMIT_CALLBACK;
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 3a6cd1497504..ba049a31febc 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -35,7 +35,6 @@ struct recovery_info
 	int		nr_revoke_hits;
 };
 
-enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 static int do_one_pass(journal_t *journal,
 				struct recovery_info *info, enum passtype pass);
 static int scan_revoke_records(journal_t *, struct buffer_head *,
@@ -444,10 +443,10 @@ static int fc_do_one_pass(journal_t *journal,
 		}
 		jbd_debug(3, "Processing fast commit blk with seq %d",
 			  seq);
-		if (pass == PASS_REPLAY &&
-		    journal->j_fc_replay_callback) {
-			err = journal->j_fc_replay_callback(journal,
-							    bh);
+		if (journal->j_fc_replay_callback) {
+			err = journal->j_fc_replay_callback(
+				journal, bh, pass,
+				next_fc_block - journal->j_first_fc);
 			if (err)
 				break;
 		}
@@ -849,7 +848,7 @@ static int do_one_pass(journal_t *journal,
 		}
 	}
 
-	if (jbd2_has_feature_fast_commit(journal) && pass == PASS_REPLAY)
+	if (jbd2_has_feature_fast_commit(journal) && pass != PASS_REVOKE)
 		fc_do_one_pass(journal, info, pass);
 
 	if (block_error && success == 0)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5362777d06f8..000363d994bb 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -759,6 +759,8 @@ jbd2_time_diff(unsigned long start, unsigned long end)
 
 #define JBD2_NR_BATCH	64
 
+enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
+
 /**
  * struct journal_s - The journal_s type is the concrete type associated with
  *     journal_t.
@@ -1240,7 +1242,8 @@ struct journal_s
 	 * the journal.
 	 */
 	int (*j_fc_replay_callback)(struct journal_s *journal,
-				    struct buffer_head *bh);
+				    struct buffer_head *bh,
+				    enum passtype pass, int off);
 	/**
 	 * @j_fc_cleanup_callback:
 	 *
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 8ef67b61d54a..9aef10c8e16d 100644
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
 
diff --git a/include/trace/events/jbd2.h b/include/trace/events/jbd2.h
index 2310b259329f..af78bacdae83 100644
--- a/include/trace/events/jbd2.h
+++ b/include/trace/events/jbd2.h
@@ -233,9 +233,9 @@ TRACE_EVENT(jbd2_handle_stats,
 
 TRACE_EVENT(jbd2_run_stats,
 	TP_PROTO(dev_t dev, unsigned long tid,
-		 struct transaction_run_stats_s *stats),
+		 struct transaction_run_stats_s *stats, bool fc),
 
-	TP_ARGS(dev, tid, stats),
+	TP_ARGS(dev, tid, stats, fc),
 
 	TP_STRUCT__entry(
 		__field(		dev_t,	dev		)
@@ -249,6 +249,7 @@ TRACE_EVENT(jbd2_run_stats,
 		__field(		__u32,	handle_count	)
 		__field(		__u32,	blocks		)
 		__field(		__u32,	blocks_logged	)
+		__field(		 bool,	fc		)
 	),
 
 	TP_fast_assign(
@@ -263,11 +264,13 @@ TRACE_EVENT(jbd2_run_stats,
 		__entry->handle_count	= stats->rs_handle_count;
 		__entry->blocks		= stats->rs_blocks;
 		__entry->blocks_logged	= stats->rs_blocks_logged;
+		__entry->fc		= fc;
 	),
 
-	TP_printk("dev %d,%d tid %lu wait %u request_delay %u running %u "
+	TP_printk("%s commit, dev %d,%d tid %lu wait %u request_delay %u running %u "
 		  "locked %u flushing %u logging %u handle_count %u "
 		  "blocks %u blocks_logged %u",
+		  __entry->fc ? "fast" : "full",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->tid,
 		  jiffies_to_msecs(__entry->wait),
 		  jiffies_to_msecs(__entry->request_delay),
-- 
2.23.0.rc1.153.gdeed80330f-goog

