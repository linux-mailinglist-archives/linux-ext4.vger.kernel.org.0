Return-Path: <linux-ext4+bounces-10469-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5881BA7850
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 23:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F9B43B7504
	for <lists+linux-ext4@lfdr.de>; Sun, 28 Sep 2025 21:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2A2284886;
	Sun, 28 Sep 2025 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IYBRftNM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35151225D6
	for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094631; cv=none; b=igJ/W6eYrUZotG3jCkMs0lmGNKotXezQ+F+TLHB4UtLVuwL1w/XKPjwHzm9ofGoFw1xZd55Vxq9EB0YipMPP+DgRn+PDzNxH+rDH2+w4mEk8rP5X9+U1MdLKRm495yOnOwqmte3cfLyyqp4VVEQOS7WCcZN474XcYlEzaR0h0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094631; c=relaxed/simple;
	bh=G1eHWtPRWOiBNBWGSRyxHv0eZNM+Be5OB070RPSTSoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWjC3rAlU5osMiKzf+63VUBZZ3rfkogVYMAuWxkvnjx1mGWnGiACuKfzYpQLjBDAQFMMeJtu75UgsmEiQeKwUKWyAiD7+8uRawnpz/ff+kXNbHXsbU+P8pklblSM5GTE7WDzF9tj2nAemFHqPQWXnP0qdKzRCM6w5BS2AVee8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IYBRftNM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-115-162.bstnma.fios.verizon.net [173.48.115.162])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 58SLNg8H000909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Sep 2025 17:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759094624; bh=BzkZ4CiebSLlb1FTm6zv6Ia3OZa9OFeuAzjVtcBOSiM=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=IYBRftNM7bkzeh1EEVdKg3aZOeZoc1W7LpAyWuVHz8U8z9qtvcq209OMSzZHQlr/c
	 akV0l86VUdKA2sO34I3OTxB/fmg+D+6ZkokfcxfePQEXNbFfF6epPjUFslu+JhWc5W
	 fgANivykutwCaPf86lI44x73fC8lKzuP5iuRHSNAk4nq4ilK4pz4WeSevvANeP0Mq/
	 n24ryoc7vs2OJyl/fh66YSbkrW4Lonpz5EdFyDBY2xgetuSdc1Sj2wOqDZaiIIFy2T
	 qOz3DCvsiEIlEtV/IevLt+1Y3tmMt4PtFyxHL/C+iwbwFPNEBDkaRag7gMqeSR9wxd
	 SQGayFdGdBQEw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 75AAC2E00D7; Sun, 28 Sep 2025 17:23:42 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: sunjunchao2870@gmail.com, Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: shrink directories on dentry delete
Date: Sun, 28 Sep 2025 17:23:18 -0400
Message-ID: <20250928212318.281605-2-tytso@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250928212318.281605-1-tytso@mit.edu>
References: <20250928210231.GB274922@mit.edu>
 <20250928212318.281605-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

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
htree nodes.

Performance Testing:
-------------------

Created 1 million files and unlinked all of them. Did this with and without
directory shrinking. Journalling was on. Used ftrace to measure time
spent in ext4_unlink:

* Without directory shrinking

  Size Before: 22M     /mnt/1
  1000000 files created and deleted.
  Average Total Elapsed Time (across 3 runs): 43.787s
  Size After: 22M     /mnt/1

  useconds          #count
  ------------------------
  0-9                3690
  10-19           2790131
  20-29            179209
  30-39             14270
  40-49              7981
  50-59              2212
  60-69              1132
  70-79               703
  80-89               403
  90-99               274

  Num samples > 40us: 12615

* With directory shrinking

  Size Before: 22M     /mnt/1
  1000000 files created and deleted.
  Average Total Elapsed Time(across 3 runs): 44.230s
  Size After: 4.0K    /mnt/1

  useconds         #count
  -----------------------
  0-9                3316
  10-19           2786451
  20-29            172015
  30-39             13259
  40-49             17847
  50-59              4843
  60-69               924
  70-79               569
  80-89               390
  90-99               389

  Num samples > 40us: 24962

  We see doubled number of samples of >40us in case of directory shrinking.
  Because these constitute to < 1% of total samples, the overall effect of
  direcotry shrinking on unlink / rmdir performance is negligible. There
  was no notable difference in cpu usage.

This patch supersedes the other directory shrinking patch sent in Aug
2019 ("ext4: attempt to shrink directory on dentry removal").

Changes since V1:
  * ext4_remove_dx_entry(), dx_probe_dx_node() fixes
  * dx_probe_dirent_blk() continuation fix
  * Added performance evaluation

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Message-ID: <20200407064616.221459-2-harshadshirwadkar@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h      |   3 +-
 fs/ext4/ext4_jbd2.h |   7 +
 fs/ext4/inline.c    |   2 +-
 fs/ext4/namei.c     | 355 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 355 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 01a6e2de7fc3..17f3478eea35 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3114,7 +3114,8 @@ extern int ext4_generic_delete_entry(struct inode *dir,
 				     struct buffer_head *bh,
 				     void *entry_buf,
 				     int buf_size,
-				     int csum_size);
+				     int csum_size,
+				     bool *empty);
 extern bool ext4_empty_dir(struct inode *inode);
 
 /* resize.c */
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 63d17c5201b5..d4348de0e6e6 100644
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
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..96c30763be47 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1673,7 +1673,7 @@ int ext4_delete_inline_entry(handle_t *handle,
 		goto out;
 
 	err = ext4_generic_delete_entry(dir, de_del, bh,
-					inline_start, inline_size, 0);
+					inline_start, inline_size, 0, NULL);
 	if (err)
 		goto out;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 9a6d8b87492f..f8f5e7329afc 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -296,6 +296,11 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		struct ext4_dir_entry_2 **res_dir, ext4_lblk_t *lblk);
 static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 			     struct inode *dir, struct inode *inode);
+static void dx_release(struct dx_frame *frames);
+static int ext4_htree_next_block(struct inode *dir, __u32 hash,
+				 struct dx_frame *frame,
+				 struct dx_frame *frames,
+				 __u32 *start_hash);
 
 /* checksumming functions */
 void ext4_initialize_dirent_tail(struct buffer_head *bh,
@@ -768,15 +773,19 @@ static inline void htree_rep_invariant_check(struct dx_entry *at,
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
 	unsigned count, indirect, level, i;
 	struct dx_entry *at, *entries, *p, *q, *m;
@@ -867,7 +876,9 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 	blocks[0] = 0;
 	while (1) {
 		count = dx_get_count(entries);
-		if (!count || count > dx_get_limit(entries)) {
+		/* If we are called from the shrink path */
+		if (count > dx_get_limit(entries) ||
+		    (strict && !count)) {
 			ext4_warning_inode(dir,
 					   "dx entry: count %u beyond limit %u",
 					   count, dx_get_limit(entries));
@@ -903,7 +914,7 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
 				goto fail;
 			}
 		}
-		if (++level > indirect)
+		if (++level > indirect || dx_get_block(at) == lblk_end)
 			return frame;
 		blocks[level] = block;
 		frame++;
@@ -935,6 +946,139 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
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
+/* dx_probe() variant that allows us to lookup frames for a dirent block. */
+static struct dx_frame *dx_probe_dirent_blk(struct inode *dir,
+					    struct dx_frame *frames,
+					    struct buffer_head *bh,
+					    ext4_lblk_t lblk)
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
+		 * See if we need to move our frame_ptr.
+		 */
+		while (dx_get_block(frame_ptr->at) != lblk) {
+			if (!ext4_htree_next_block(dir, hinfo.hash, frame_ptr,
+						   frames, NULL))
+				break;
+		}
+		if (dx_get_block(frame_ptr->at) == lblk)
+			return frame_ptr;
+		dx_release(frames);
+		frame_ptr = ERR_PTR(-EINVAL);
+	}
+	return frame_ptr;
+}
+
+/* dx_probe() variant that allows us to lookup frames for a dx node. */
+static struct dx_frame *dx_probe_dx_node(struct inode *dir,
+					 struct dx_frame *frames,
+					 struct buffer_head *bh,
+					 ext4_lblk_t lblk)
+{
+	struct dx_hash_info hinfo;
+	struct dx_frame *frame_ptr;
+	struct dx_entry *entries;
+
+	hinfo.hash_version = EXT4_SB(dir->i_sb)->s_def_hash_version;
+	if (hinfo.hash_version <= DX_HASH_TEA)
+		hinfo.hash_version +=
+			EXT4_SB(dir->i_sb)->s_hash_unsigned;
+	hinfo.seed = EXT4_SB(dir->i_sb)->s_hash_seed;
+	entries = ((struct dx_node *)(bh->b_data))->entries;
+
+	/* Use the first hash found in the dx node */
+	hinfo.hash = le32_to_cpu(entries[1].hash);
+	frame_ptr = __dx_probe(NULL, dir, &hinfo, frames, lblk, false);
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
+ * ext4_remove_dx_entry() does NOT mark dx_frame dirty, that's left to the
+ * caller. The reason for doing this is that this function removes entry from
+ * a dx_node and can potentially leave dx_node with no entries. Since older
+ * kernels don't allow dx_parent nodes to have 0 count, the caller should
+ * only mark buffer dirty when we are sure that we won't leave dx_node
+ * with 0 count.
+ */
+static int
+ext4_remove_dx_entry(handle_t *handle, struct inode *dir,
+		     struct dx_frame *dx_frame)
+{
+	struct dx_entry *entries = dx_frame->entries;
+	int err, i = 0;
+	unsigned int count = dx_get_count(entries);
+
+	for (i = 0; i < count; i++)
+		if (entries[i].block == dx_frame->at->block)
+			break;
+	if (i >= count)
+		return -EINVAL;
+
+	err = ext4_journal_get_write_access(handle, dir->i_sb, dx_frame->bh,
+					    EXT4_JTR_NONE);
+	if (err)
+		goto out_err;
+
+	if (i == 0) {
+		entries[0].block = entries[1].block;
+		i++;
+	}
+	if (i < count - 1)
+		memmove(&entries[i], &entries[i + 1], (count - i - 1) *
+						sizeof(struct dx_entry));
+	dx_set_count(entries, count - 1);
+
+	return 0;
+out_err:
+	ext4_std_error(dir->i_sb, err);
+	return -EINVAL;
+
+}
+
 static void dx_release(struct dx_frame *frames)
 {
 	struct dx_root_info *info;
@@ -2649,6 +2793,24 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	return err;
 }
 
+/*
+ * Checks if dirent block is empty. If de is passed, we
+ * skip directory entries before de in the block.
+ */
+static inline bool is_empty_dirent_block(struct inode *dir,
+					struct buffer_head *bh,
+					 struct ext4_dir_entry_2 *de)
+{
+	if (!de)
+		de = (struct ext4_dir_entry_2 *)bh->b_data;
+	while ((u8 *)de < (u8 *)bh->b_data + dir->i_sb->s_blocksize) {
+		if (de->inode)
+			return false;
+		de = ext4_next_entry(de, dir->i_sb->s_blocksize);
+	}
+	return true;
+}
+
 /*
  * ext4_generic_delete_entry deletes a directory entry by merging it
  * with the previous entry
@@ -2658,7 +2820,8 @@ int ext4_generic_delete_entry(struct inode *dir,
 			      struct buffer_head *bh,
 			      void *entry_buf,
 			      int buf_size,
-			      int csum_size)
+			      int csum_size,
+			      bool *empty)
 {
 	struct ext4_dir_entry_2 *de, *pde;
 	unsigned int blocksize = dir->i_sb->s_blocksize;
@@ -2667,6 +2830,8 @@ int ext4_generic_delete_entry(struct inode *dir,
 	i = 0;
 	pde = NULL;
 	de = entry_buf;
+	if (empty)
+		*empty = false;
 	while (i < buf_size - csum_size) {
 		if (ext4_check_dir_entry(dir, NULL, de, bh,
 					 entry_buf, buf_size, i))
@@ -2692,7 +2857,9 @@ int ext4_generic_delete_entry(struct inode *dir,
 					offsetof(struct ext4_dir_entry_2,
 								name_len));
 			}
-
+			if (empty)
+				*empty = is_empty_dirent_block(dir, bh,
+								pde ? pde : de);
 			inode_inc_iversion(dir);
 			return 0;
 		}
@@ -2703,12 +2870,176 @@ int ext4_generic_delete_entry(struct inode *dir,
 	return -ENOENT;
 }
 
+static void make_unindexed(handle_t *handle, struct inode *dir,
+				struct buffer_head *bh)
+{
+ 	int parent_ino = le32_to_cpu(
+		((struct dx_root *)bh->b_data)->dotdot.inode);
+
+	memset(bh->b_data, 0, dir->i_sb->s_blocksize);
+	ext4_init_dirblock(handle, dir, bh, parent_ino, NULL, 0);
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
+	WARN_ON(dx_get_block(frame_ptr->at) != lblk_src);
+	memcpy(bh_dst->b_data, bh_src->b_data, bh_dst->b_size);
+	dx_set_block(frame_ptr->at, lblk_dst);
+
+	/* Set pointer in bh_last_parent to bh */
+	ret = ext4_journal_get_write_access(handle, dir->i_sb, bh_src,
+					    EXT4_JTR_NONE);
+	if (ret)
+		goto out;
+
+	ret = ext4_journal_get_write_access(handle, dir->i_sb, frame_ptr->bh,
+					    EXT4_JTR_NONE);
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
+	bool check_empty = true;
+
+	memset(frames, 0, sizeof(frames));
+	frame_ptr = dx_probe_dirent_blk(dir, frames, bh, lblk);
+	if (IS_ERR(frame_ptr))
+		return -EINVAL;
+
+	last_lblk = (dir->i_size >> dir->i_sb->s_blocksize_bits) - 1;
+
+	while (check_empty && frame_ptr >= frames) {
+		parent_lblk = frame_ptr > frames ?
+			dx_get_block((frame_ptr - 1)->at) : 0;
+		lblk = dx_get_block(frame_ptr->at);
+		if (ext4_journal_extend(
+			handle, EXT4_DIR_SHRINK_TRANS_BLOCKS, 0) < 0)
+			break;
+		if (ext4_remove_dx_entry(handle, dir, frame_ptr) < 0) {
+			dxtrace(pr_warn("remove dx entry failed\n"));
+			break;
+		}
+		check_empty = dx_get_count(frame_ptr->entries) == 0;
+		if (lblk != last_lblk) {
+			ret = ext4_dx_remap_block(handle, dir, bh, lblk,
+							last_lblk);
+			if (ret) {
+				dxtrace(pr_warn("remap failed\n"));
+				break;
+			}
+		}
+		ret = ext4_handle_dirty_dx_node(handle, dir, frame_ptr->bh);
+		if (ret)
+			break;
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
 			     struct buffer_head *bh, ext4_lblk_t lblk)
 {
 	int err, csum_size = 0;
+	bool block_empty = false;
 
 	if (ext4_has_inline_data(dir)) {
 		int has_inline_data = 1;
@@ -2728,7 +3059,8 @@ static int ext4_delete_entry(handle_t *handle,
 		goto out;
 
 	err = ext4_generic_delete_entry(dir, de_del, bh, bh->b_data,
-					dir->i_sb->s_blocksize, csum_size);
+					dir->i_sb->s_blocksize, csum_size,
+					&block_empty);
 	if (err)
 		goto out;
 
@@ -2737,6 +3069,9 @@ static int ext4_delete_entry(handle_t *handle,
 	if (unlikely(err))
 		goto out;
 
+	if (block_empty && is_dx(dir))
+		ext4_try_dir_shrink(handle, dir, lblk, bh);
+
 	return 0;
 out:
 	if (err != -ENOENT)
-- 
2.51.0


