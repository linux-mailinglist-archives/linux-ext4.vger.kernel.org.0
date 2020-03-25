Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E47419244E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 10:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCYJhi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 05:37:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgCYJhi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 05:37:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so385648pgl.1
        for <linux-ext4@vger.kernel.org>; Wed, 25 Mar 2020 02:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y6ekVHoJwjw/CrxxlQ+BDBWLCrdEjYYuNbVPQOl19d0=;
        b=O2GuxmQe1iwjdA9SMaR8M9hok0OSgExWbeFxoiXstrMFr5dNY2V7rEstBsW4i4OrYS
         +z6pNMNoY/DiKdKchjKnvlqmI1SyqaMLtdlWaHeao+vS62QAwLAQE9CbnuvCrYZPHFZa
         Ah9Za6R/eGHYNnYdSkqwcYACupqtPjZ+n5fhNUoWr7lrT1EqNvx9XWfddLG4ZaNMWDrR
         jwkb68dUvttPvg4vXFIVB08j/N8+uUrbJu5jBVVQhvP4HP4dRRQmT7ylQT0emgGjnfmD
         FmIO+ex6nWEG1+fz6z69JFBsahINcK2nJgmia8Y18FlVu5urmB9TdT0qyk1oiQdWF12l
         QJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y6ekVHoJwjw/CrxxlQ+BDBWLCrdEjYYuNbVPQOl19d0=;
        b=ffbIGSHNFQJDcENefP8rx3yJNd7CX/8cjjdQw6ffOUkue9djH0kZfkzSkJQkb+xJWj
         dcgc0ZmFcdfrOVeNRZXAfb7/7iGX9zQ7oIKrAlVxP7j4AlmkpVXShCIqRS/rEPvS8qq5
         DxpP2ql2Ld8l9p0VwDkrO/M0NeOwRCKMfxJHdPkK67T6tEOuAnef/+ERtO7q99/b+fPb
         1oU46xfl+bmAGjYeabNDCDEcgrynIQ7RbPlPAgZyTZVK2que5SXvstUG9IzmVcGzHg/5
         TgsKco5GMxZUkQ52CfqKonhAXEnJnoKFvY1KduZRCaIUOryR0VFiyQBaOZl1kwbJNYEF
         SSyw==
X-Gm-Message-State: ANhLgQ2m+vYGt/4yzrZqXBudEiJmfsIitoBJQFq+g51W3JQDd7QOBd7N
        yu0+vRF9CQmlvpdMZZrK/3UGyZe0
X-Google-Smtp-Source: ADFU+vuUxRhoivRmqUXvcjkkPSeAHzrf3zhQKtfb8od7fiINoNow8+TDFG0VduHp8tP/1lSwIsbjJA==
X-Received: by 2002:a62:8247:: with SMTP id w68mr2601843pfd.146.1585129056201;
        Wed, 25 Mar 2020 02:37:36 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q43sm4289927pjc.40.2020.03.25.02.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 02:37:35 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/2] ext4: shrink directories on dentry delete
Date:   Wed, 25 Mar 2020 02:37:28 -0700
Message-Id: <20200325093728.204211-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch adds shrinking support for htree based directories. The
high level algorithm is as follows:

* If after dentry removal the dirent block (let's call it B) becomes
  empty, then remove its references in its dx parent.
* Swap its contents with that of the last block (L) in directory.
* Update L's parents to point to B instead.
* Remove L
* Repeat this for all the ancestors of B.

We add variants of dx_probe that allow us perform reverse lookups from
a logical block to its dx parents.

Ran kvm-xfstests smoke and verified that no new failures are
introduced. Ran shrinking for directories with following number of
files and then deleted files one by one:
* 1000 (size before deletion 36K, after deletion 4K)
* 10000 (size before deletion 196K, after deletion 4K)
* 100000 (size before deletion 2.1M, after deletion 4K)
* 200000 (size before deletion 4.2M, after deletion 4K)

In all cases directory shrunk significantly. We fallback to linear
directories if the directory becomes empty.

But note that most of the shrinking happens during last 1-2% deletions
in an average case. Therefore, the next step here is to merge dx nodes
when possible. That can be achieved by storing the fullness index in
htree nodes. But that's an on-disk format change. We can instead build
on tooling added by this patch to perform reverse lookup on a dx
node and then reading adjacent nodes to check their fullness.

This patch supersedes the other directory shrinking patch sent in Aug
2019 ("ext4: attempt to shrink directory on dentry removal").

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4_jbd2.h |   7 +
 fs/ext4/namei.c     | 355 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 353 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 7ea4f6fa173b..5b18276c7321 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -83,6 +83,13 @@
  */
 #define EXT4_INDEX_EXTRA_TRANS_BLOCKS	12U
 
+/*
+ * Number of credits needed to perform directory shrinking. For each htree
+ * level, we need 6 blocks (block in question, its parent, last block, last
+ * block's parent, bitmap block, bg summary).
+ */
+#define EXT4_DIR_SHRINK_TRANS_BLOCKS	6U
+
 #ifdef CONFIG_QUOTA
 /* Amount of blocks needed for quota update - we know that the structure was
  * allocated so we need to update only data block */
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d567b9589875..b78c6f9a6eba 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -275,10 +275,12 @@ static void dx_set_count(struct dx_entry *entries, unsigned value);
 static void dx_set_limit(struct dx_entry *entries, unsigned value);
 static unsigned dx_root_limit(struct inode *dir, unsigned infosize);
 static unsigned dx_node_limit(struct inode *dir);
-static struct dx_frame *dx_probe(struct ext4_filename *fname,
+static struct dx_frame *__dx_probe(struct ext4_filename *fname,
 				 struct inode *dir,
 				 struct dx_hash_info *hinfo,
-				 struct dx_frame *frame);
+				 struct dx_frame *frame,
+				 ext4_lblk_t lblk_end,
+				 bool shrink);
 static void dx_release(struct dx_frame *frames);
 static int dx_make_map(struct inode *dir, struct ext4_dir_entry_2 *de,
 		       unsigned blocksize, struct dx_hash_info *hinfo,
@@ -747,15 +749,19 @@ struct stats dx_show_entries(struct dx_hash_info *hinfo, struct inode *dir,
 /*
  * Probe for a directory leaf block to search.
  *
- * dx_probe can return ERR_BAD_DX_DIR, which means there was a format
+ * __dx_probe can return ERR_BAD_DX_DIR, which means there was a format
  * error in the directory index, and the caller should fall back to
- * searching the directory normally.  The callers of dx_probe **MUST**
+ * searching the directory normally.  The callers of __dx_probe **MUST**
  * check for this error code, and make sure it never gets reflected
- * back to userspace.
+ * back to userspace. If lblk_end is set and if __dx_probe hits lblk_end
+ * logical block, it reads it and stops. If strict is true, __dx_probe
+ * performs stronger checks for "count" during the lookup. See other
+ * variants below.
  */
 static struct dx_frame *
-dx_probe(struct ext4_filename *fname, struct inode *dir,
-	 struct dx_hash_info *hinfo, struct dx_frame *frame_in)
+__dx_probe(struct ext4_filename *fname, struct inode *dir,
+	 struct dx_hash_info *hinfo, struct dx_frame *frame_in,
+	 ext4_lblk_t lblk_end, bool strict)
 {
 	unsigned count, indirect;
 	struct dx_entry *at, *entries, *p, *q, *m;
@@ -820,7 +826,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	dxtrace(printk("Look up %x", hash));
 	while (1) {
 		count = dx_get_count(entries);
-		if (!count || count > dx_get_limit(entries)) {
+		/* If we are called from the shrink path */
+		if (count > dx_get_limit(entries) ||
+		    (strict && !count)) {
 			ext4_warning_inode(dir,
 					   "dx entry: count %u beyond limit %u",
 					   count, dx_get_limit(entries));
@@ -859,7 +867,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 			       dx_get_block(at)));
 		frame->entries = entries;
 		frame->at = at;
-		if (!indirect--)
+		if (!indirect-- || dx_get_block(at) == lblk_end)
 			return frame;
 		frame++;
 		frame->bh = ext4_read_dirblock(dir, dx_get_block(at), INDEX);
@@ -889,6 +897,154 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	return ret_err;
 }
 
+static inline struct dx_frame *
+dx_probe(struct ext4_filename *fname, struct inode *dir,
+	 struct dx_hash_info *hinfo, struct dx_frame *frame_in)
+{
+	return __dx_probe(fname, dir, hinfo, frame_in, 0, true);
+}
+
+/*
+ * dx_probe with relaxed checks. This function is used in the directory
+ * shrinking code since we can run into intermediate states where we have
+ * internal dx nodes with count = 0.
+ */
+static inline struct dx_frame *
+dx_probe_relaxed(struct ext4_filename *fname, struct inode *dir,
+		struct dx_hash_info *hinfo, struct dx_frame *frame_in)
+{
+	return __dx_probe(fname, dir, hinfo, frame_in, 0, false);
+}
+
+/*
+ * Perform only a parttial dx_probe until we find block end_lblk.
+ */
+static inline struct dx_frame *
+dx_probe_partial(struct ext4_filename *fname, struct inode *dir,
+		 struct dx_hash_info *hinfo, struct dx_frame *frame_in,
+		 ext4_lblk_t end_lblk)
+{
+	return __dx_probe(fname, dir, hinfo, frame_in, end_lblk, false);
+}
+
+/* dx_probe() variant that allows us to lookup frames for a dirent block. */
+struct dx_frame *dx_probe_dirent_blk(struct inode *dir, struct dx_frame *frames,
+				    struct buffer_head *bh, ext4_lblk_t lblk)
+{
+	struct dx_hash_info hinfo;
+	struct dx_frame *frame_ptr;
+	struct ext4_dir_entry_2 *dead_de;
+
+	hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	if (hinfo.hash_version <= DX_HASH_TEA)
+		hinfo.hash_version +=
+			EXT4_SB(dir->i_sb)->s_hash_unsigned;
+	hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+
+	/* Let's assume that the lblk is a leaf dirent block */
+	dead_de = (struct ext4_dir_entry_2 *)bh->b_data;
+	ext4fs_dirhash(dir, dead_de->name, dead_de->name_len, &hinfo);
+
+	frame_ptr = dx_probe_relaxed(NULL, dir, &hinfo, frames);
+	if (!IS_ERR(frame_ptr)) {
+		/*
+		 * Cross-check if the dead de helped us find the block that we
+		 * are looking to delete.
+		 */
+		if (dx_get_block(frame_ptr->at) == lblk)
+			return frame_ptr;
+		dx_release(frames);
+		frame_ptr = ERR_PTR(-EINVAL);
+	}
+	return frame_ptr;
+}
+
+/* dx_probe() variant that allows us to lookup frames for a dx node. */
+struct dx_frame *dx_probe_dx_node(struct inode *dir, struct dx_frame *frames,
+				  struct buffer_head *bh, ext4_lblk_t lblk)
+{
+	struct dx_hash_info hinfo;
+	struct dx_frame *frame_ptr;
+	struct dx_entry *entries;
+	int count;
+
+	hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	if (hinfo.hash_version <= DX_HASH_TEA)
+		hinfo.hash_version +=
+			EXT4_SB(dir->i_sb)->s_hash_unsigned;
+	hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+	entries = ((struct dx_node *)(bh->b_data))->entries;
+	count = dx_get_count(entries);
+	if (count > dx_get_limit(entries)) {
+		ext4_warning_inode(dir,
+				   "dx entry: count %u beyond limit %u",
+				   count, dx_get_limit(entries));
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Use the first hash found in the dx node */
+	hinfo.hash = le32_to_cpu(entries[1].hash);
+	frame_ptr = dx_probe_partial(NULL, dir, &hinfo, frames, lblk);
+	if (IS_ERR_OR_NULL(frame_ptr))
+		return frame_ptr;
+	if (dx_get_block(frame_ptr->at) != lblk) {
+		dx_release(frames);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return frame_ptr;
+}
+
+/*
+ * This function tries to remove the entry of a dirent block (which was just
+ * emptied by the caller) from the dx frame. It does so by reducing the count by
+ * 1 and left shifting all the entries after the deleted entry.
+ */
+int
+ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
+		     struct dx_frame *dx_frame)
+{
+	struct dx_entry *entries;
+	unsigned int count;
+	unsigned int limit;
+	int err, i = 0;
+
+	entries = dx_frame->entries;
+	count = dx_get_count(entries);
+	limit = dx_get_limit(entries);
+
+	for (i = 0; i < count; i++)
+		if (entries[i].block == dx_frame->at->block)
+			break;
+	if (i >= count)
+		return -EINVAL;
+
+	err = ext4_journal_get_write_access(handle, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return -EINVAL;
+	}
+
+	for (; i < count - 1; i++)
+		entries[i] = entries[i + 1];
+
+	/*
+	 * If i was 0 when we began above loop, we would have overwritten count
+	 * and limit values since those values live in dx_entry->hash of the
+	 * first entry. We need to update count but we should set limit as well.
+	 */
+	dx_set_count(entries, count - 1);
+	dx_set_limit(entries, limit);
+
+	err = ext4_handle_dirty_dx_node(handle, dir, dx_frame->bh);
+	if (err) {
+		ext4_std_error(dir->i_sb, err);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
@@ -1413,6 +1569,19 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 	return 0;
 }
 
+static inline bool is_empty_dirent_block(struct inode *dir,
+					 struct buffer_head *bh)
+{
+	struct ext4_dir_entry_2 *de = (struct ext4_dir_entry_2 *)bh->b_data;
+	int	csum_size = 0;
+
+	if (ext4_has_metadata_csum(dir->i_sb) && is_dx(dir))
+		csum_size = sizeof(struct ext4_dir_entry_tail);
+
+	return ext4_rec_len_from_disk(de->rec_len, dir->i_sb->s_blocksize) ==
+			dir->i_sb->s_blocksize - csum_size && de->inode == 0;
+}
+
 static int is_dx_internal_node(struct inode *dir, ext4_lblk_t block,
 			       struct ext4_dir_entry *de)
 {
@@ -2496,6 +2665,171 @@ int ext4_generic_delete_entry(handle_t *handle,
 	return -ENOENT;
 }
 
+static void make_unindexed(handle_t *handle, struct inode *dir,
+				struct buffer_head *bh)
+{
+	struct ext4_dir_entry_2 *de;
+	int parent_ino, csum_size = 0;
+
+	de = (struct ext4_dir_entry_2 *)bh->b_data;
+	parent_ino = le32_to_cpu(
+		((struct dx_root *)bh->b_data)->dotdot.inode);
+	if (ext4_has_metadata_csum(dir->i_sb))
+		csum_size = sizeof(struct ext4_dir_entry_tail);
+	memset(bh->b_data, 0, dir->i_sb->s_blocksize);
+	ext4_init_dot_dotdot(dir, de, dir->i_sb->s_blocksize, csum_size,
+				parent_ino, 0);
+	if (csum_size)
+		ext4_initialize_dirent_tail(bh, dir->i_sb->s_blocksize);
+	ext4_handle_dirty_dirblock(handle, dir, bh);
+	ext4_clear_inode_flag(dir, EXT4_INODE_INDEX);
+	ext4_mark_inode_dirty(handle, dir);
+}
+
+/*
+ * Copy contents from lblk_src to lblk_dst and remap internal dx nodes
+ * such that parent of lblk_src points to lblk_dst.
+ */
+static int ext4_dx_remap_block(handle_t *handle, struct inode *dir,
+				struct buffer_head *bh_dst,
+				ext4_lblk_t lblk_dst, ext4_lblk_t lblk_src)
+{
+	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame_ptr;
+	struct buffer_head *bh_src;
+	int ret;
+
+	bh_src = ext4_bread(handle, dir, lblk_src, 0);
+	if (IS_ERR_OR_NULL(bh_src))
+		return -EIO;
+
+	memset(frames, 0, sizeof(frames));
+
+	/*
+	 * blk_src can either be a dirent block or dx node. Try to search
+	 * using both and use whichever one that returns success.
+	 */
+	frame_ptr = dx_probe_dirent_blk(dir, frames, bh_src, lblk_src);
+	if (IS_ERR_OR_NULL(frame_ptr)) {
+		frame_ptr = dx_probe_dx_node(dir, frames, bh_src, lblk_src);
+		if (IS_ERR_OR_NULL(frame_ptr)) {
+			brelse(bh_src);
+			return PTR_ERR(frame_ptr);
+		}
+	}
+
+	memcpy(bh_dst->b_data, bh_src->b_data, bh_dst->b_size);
+	frame_ptr->at->block = cpu_to_le32(lblk_dst);
+
+	/* Set pointer in bh_last_parent to bh */
+	ret = ext4_journal_get_write_access(handle, bh_src);
+	if (ret)
+		goto out;
+
+	ret = ext4_journal_get_write_access(handle, frame_ptr->bh);
+	if (ret)
+		goto out;
+
+	ret = ext4_handle_dirty_metadata(handle, dir, bh_src);
+	if (ret) {
+		ext4_std_error(dir->i_sb, ret);
+		goto out;
+	}
+
+	ret = ext4_handle_dirty_dx_node(handle, dir, frame_ptr->bh);
+	if (ret) {
+		ext4_std_error(dir->i_sb, ret);
+		goto out;
+	}
+out:
+	brelse(bh_src);
+	dx_release(frames);
+	return ret;
+}
+
+/*
+ * Try to shrink directory as much as possible. This function
+ * truncates directory to the new size.
+ *
+ * The high level algorithm is as follows:
+ *
+ * - If after dentry removal the dirent block (let's call it B) becomes
+ *   empty, then remove its references in its dx parent.
+ * - Swap its contents with that of the last block (L) in directory.
+ * - Update L's parents to point to B instead.
+ * - Remove L
+ * - Repeat this for all the ancestors of B.
+ */
+static int ext4_try_dir_shrink(handle_t *handle, struct inode *dir,
+				ext4_lblk_t lblk, struct buffer_head *bh)
+{
+	struct buffer_head *bh_last = NULL, *parent_bh = NULL;
+	struct dx_frame frames[EXT4_HTREE_LEVEL], *frame_ptr;
+	ext4_lblk_t shrink = 0, last_lblk, parent_lblk;
+	int ret = 0;
+	bool check_empty;
+
+	memset(frames, 0, sizeof(frames));
+	frame_ptr = dx_probe_dirent_blk(dir, frames, bh, lblk);
+	if (IS_ERR(frame_ptr))
+		return -EINVAL;
+
+	last_lblk = (dir->i_size >> dir->i_sb->s_blocksize_bits) - 1;
+
+	check_empty = is_empty_dirent_block(dir, bh);
+	while (check_empty && frame_ptr >= frames) {
+		parent_lblk = frame_ptr > frames ?
+			dx_get_block((frame_ptr - 1)->at) : 0;
+		lblk = dx_get_block(frame_ptr->at);
+		if (ext4_journal_extend(
+			handle, EXT4_DIR_SHRINK_TRANS_BLOCKS, 0) < 0)
+			break;
+		if (ext4_remove_dx_entry(handle, dir, frame_ptr) < 0)
+			break;
+		check_empty = dx_get_count(frame_ptr->entries) == 0;
+		if (lblk != last_lblk) {
+			ret = ext4_dx_remap_block(handle, dir, bh, lblk,
+							last_lblk);
+			if (ret)
+				break;
+		}
+
+		if (parent_lblk == last_lblk)
+			parent_lblk = lblk;
+		last_lblk--;
+		shrink++;
+
+		if (parent_lblk == 0)
+			break;
+		if (!IS_ERR_OR_NULL(parent_bh))
+			brelse(parent_bh);
+		parent_bh = ext4_bread(handle, dir, parent_lblk, 0);
+		if (IS_ERR_OR_NULL(parent_bh))
+			break;
+		dx_release(frames);
+		frame_ptr = dx_probe_dx_node(dir, frames, parent_bh,
+					     parent_lblk);
+		if (IS_ERR(frame_ptr))
+			break;
+		bh = parent_bh;
+	}
+
+	/* Fallback to linear directories if root node becomes empty */
+	if (dx_get_count(frames[0].entries) == 0)
+		make_unindexed(handle, dir, frames[0].bh);
+	if (!IS_ERR(frame_ptr))
+		dx_release(frames);
+	if (!IS_ERR_OR_NULL(bh_last))
+		brelse(bh_last);
+	if (!IS_ERR_OR_NULL(parent_bh))
+		brelse(parent_bh);
+
+	if (ret || !shrink)
+		return ret;
+
+	dir->i_size -= shrink * dir->i_sb->s_blocksize;
+	return ext4_truncate(dir);
+}
+
 static int ext4_delete_entry(handle_t *handle,
 			     struct inode *dir,
 			     struct ext4_dir_entry_2 *de_del,
@@ -2530,6 +2864,9 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
+	if (is_dx(dir))
+		ext4_try_dir_shrink(handle, dir, lblk, bh);
+
 	return 0;
 out:
 	if (err != -ENOENT)
-- 
2.25.1.696.g5e7596f4ac-goog

