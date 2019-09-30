Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90CC1F6D
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2019 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfI3Knd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Sep 2019 06:43:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:57664 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730725AbfI3Knc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Sep 2019 06:43:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 399ABB158;
        Mon, 30 Sep 2019 10:43:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0F4A61E4839; Mon, 30 Sep 2019 12:43:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 19/19] ext4: Reserve revoke credits for freed blocks
Date:   Mon, 30 Sep 2019 12:43:37 +0200
Message-Id: <20190930104339.24919-19-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190930103544.11479-1-jack@suse.cz>
References: <20190930103544.11479-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

So far we have reserved only relatively high fixed amount of revoke
credits for each transaction. We over-reserved by large amount for most
cases but when freeing large directories or files with data journalling,
the fixed amount is not enough. In fact the worst case estimate is
inconveniently large (maximum extent size) for freeing of one extent.

We fix this by doing proper estimate of the amount of blocks that need
to be revoked when removing blocks from the inode due to truncate or
hole punching and otherwise reserve just a small amount of revoke
credits for each transaction to accommodate freeing of xattrs block or
so.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h              |  3 +-
 fs/ext4/ext4_jbd2.c         | 20 +++++++-----
 fs/ext4/ext4_jbd2.h         | 79 +++++++++++++++++++++++++++++++--------------
 fs/ext4/extents.c           | 25 ++++++++++----
 fs/ext4/ialloc.c            |  2 +-
 fs/ext4/indirect.c          | 12 ++++---
 fs/ext4/inode.c             |  2 +-
 fs/ext4/migrate.c           | 24 ++++++++------
 fs/ext4/resize.c            | 16 ++++++---
 fs/ext4/xattr.c             |  4 ++-
 include/trace/events/ext4.h | 13 +++++---
 11 files changed, 133 insertions(+), 67 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d6d0286fae28..72279b0bc715 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3253,7 +3253,8 @@ extern int ext4_swap_extents(handle_t *handle, struct inode *inode1,
 			     int mark_unwritten,int *err);
 extern int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu);
 extern int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
-				       int check_cred, int restart_cred);
+				       int check_cred, int restart_cred,
+				       int revoke_cred);
 
 
 /* move_extent.c */
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b81190bee32d..d3b8cdea5df7 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -65,12 +65,14 @@ static int ext4_journal_check_start(struct super_block *sb)
 }
 
 handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
-				  int type, int blocks, int rsv_blocks)
+				  int type, int blocks, int rsv_blocks,
+				  int revoke_creds)
 {
 	journal_t *journal;
 	int err;
 
-	trace_ext4_journal_start(sb, blocks, rsv_blocks, _RET_IP_);
+	trace_ext4_journal_start(sb, blocks, rsv_blocks, revoke_creds,
+				 _RET_IP_);
 	err = ext4_journal_check_start(sb);
 	if (err < 0)
 		return ERR_PTR(err);
@@ -78,8 +80,8 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 	journal = EXT4_SB(sb)->s_journal;
 	if (!journal)
 		return ext4_get_nojournal();
-	return jbd2__journal_start(journal, blocks, rsv_blocks, 1024, GFP_NOFS,
-				   type, line);
+	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
+				   GFP_NOFS, type, line);
 }
 
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
@@ -134,14 +136,16 @@ handle_t *__ext4_journal_start_reserved(handle_t *handle, unsigned int line,
 }
 
 int __ext4_journal_ensure_credits(handle_t *handle, int check_cred,
-				  int extend_cred)
+				  int extend_cred, int revoke_cred)
 {
 	if (!ext4_handle_valid(handle))
 		return 0;
-	if (jbd2_handle_buffer_credits(handle) >= check_cred)
+	if (jbd2_handle_buffer_credits(handle) >= check_cred &&
+	    handle->h_revoke_credits >= revoke_cred)
 		return 0;
-	return ext4_journal_extend(handle,
-			   extend_cred - jbd2_handle_buffer_credits(handle));
+	extend_cred = max(0, extend_cred - jbd2_handle_buffer_credits(handle));
+	revoke_cred = max(0, revoke_cred - handle->h_revoke_credits);
+	return ext4_journal_extend(handle, extend_cred, revoke_cred);
 }
 
 static void ext4_journal_abort_handle(const char *caller, unsigned int line,
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 1970ac78aae9..156b1d7eff0f 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -261,7 +261,8 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 	__ext4_handle_dirty_super(__func__, __LINE__, (handle), (sb))
 
 handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
-				  int type, int blocks, int rsv_blocks);
+				  int type, int blocks, int rsv_blocks,
+				  int revoke_creds);
 int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle);
 
 #define EXT4_NOJOURNAL_MAX_REF_COUNT ((unsigned long) 4096)
@@ -288,21 +289,40 @@ static inline int ext4_handle_is_aborted(handle_t *handle)
 	return 0;
 }
 
+static inline int ext4_free_metadata_revoke_credits(struct super_block *sb,
+						    int blocks)
+{
+	return blocks + 2*EXT4_SB(sb)->s_cluster_ratio;
+}
+
+static inline int ext4_trans_default_revoke_credits(struct super_block *sb)
+{
+	return ext4_free_metadata_revoke_credits(sb, 8);
+}
+
 #define ext4_journal_start_sb(sb, type, nblocks)			\
-	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0)
+	__ext4_journal_start_sb((sb), __LINE__, (type), (nblocks), 0,	\
+				ext4_trans_default_revoke_credits(sb))
 
 #define ext4_journal_start(inode, type, nblocks)			\
-	__ext4_journal_start((inode), __LINE__, (type), (nblocks), 0)
+	__ext4_journal_start((inode), __LINE__, (type), (nblocks), 0,	\
+			     ext4_trans_default_revoke_credits((inode)->i_sb))
 
-#define ext4_journal_start_with_reserve(inode, type, blocks, rsv_blocks) \
-	__ext4_journal_start((inode), __LINE__, (type), (blocks), (rsv_blocks))
+#define ext4_journal_start_with_reserve(inode, type, blocks, rsv_blocks)\
+	__ext4_journal_start((inode), __LINE__, (type), (blocks), (rsv_blocks),\
+			     ext4_trans_default_revoke_credits((inode)->i_sb))
+
+#define ext4_journal_start_with_revoke(inode, type, blocks, revoke_creds) \
+	__ext4_journal_start((inode), __LINE__, (type), (blocks), 0,	\
+			     (revoke_creds))
 
 static inline handle_t *__ext4_journal_start(struct inode *inode,
 					     unsigned int line, int type,
-					     int blocks, int rsv_blocks)
+					     int blocks, int rsv_blocks,
+					     int revoke_creds)
 {
 	return __ext4_journal_start_sb(inode->i_sb, line, type, blocks,
-				       rsv_blocks);
+				       rsv_blocks, revoke_creds);
 }
 
 #define ext4_journal_stop(handle) \
@@ -325,22 +345,23 @@ static inline handle_t *ext4_journal_current_handle(void)
 	return journal_current_handle();
 }
 
-static inline int ext4_journal_extend(handle_t *handle, int nblocks)
+static inline int ext4_journal_extend(handle_t *handle, int nblocks, int revoke)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_extend(handle, nblocks, 1024);
+		return jbd2_journal_extend(handle, nblocks, revoke);
 	return 0;
 }
 
-static inline int ext4_journal_restart(handle_t *handle, int nblocks)
+static inline int ext4_journal_restart(handle_t *handle, int nblocks,
+				       int revoke)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2__journal_restart(handle, nblocks, 1024, GFP_NOFS);
+		return jbd2__journal_restart(handle, nblocks, revoke, GFP_NOFS);
 	return 0;
 }
 
 int __ext4_journal_ensure_credits(handle_t *handle, int check_cred,
-				  int extend_cred);
+				  int extend_cred, int revoke_cred);
 
 
 /*
@@ -353,18 +374,19 @@ int __ext4_journal_ensure_credits(handle_t *handle, int check_cred,
  * credits or transaction extension succeeded, 1 in case transaction had to be
  * restarted.
  */
-#define ext4_journal_ensure_credits_fn(handle, check_cred, extend_cred, fn) \
+#define ext4_journal_ensure_credits_fn(handle, check_cred, extend_cred,	\
+				       revoke_cred, fn) \
 ({									\
 	__label__ __ensure_end;						\
 	int err = __ext4_journal_ensure_credits((handle), (check_cred),	\
-						(extend_cred));		\
+					(extend_cred), (revoke_cred));	\
 									\
 	if (err <= 0)							\
 		goto __ensure_end;					\
 	err = (fn);							\
 	if (err < 0)							\
 		goto __ensure_end;					\
-	err = ext4_journal_restart((handle), (extend_cred));		\
+	err = ext4_journal_restart((handle), (extend_cred), (revoke_cred)); \
 	if (err == 0)							\
 		err = 1;						\
 __ensure_end:								\
@@ -373,18 +395,16 @@ __ensure_end:								\
 
 /*
  * Ensure given handle has at least requested amount of credits available,
- * possibly restarting transaction if needed.
+ * possibly restarting transaction if needed. We also make sure the transaction
+ * has space for at least ext4_trans_default_revoke_credits(sb) revoke records
+ * as freeing one or two blocks is very common pattern and requesting this is
+ * very cheap.
  */
-static inline int ext4_journal_ensure_credits(handle_t *handle, int credits)
+static inline int ext4_journal_ensure_credits(handle_t *handle, int credits,
+					      int revoke_creds)
 {
-	return ext4_journal_ensure_credits_fn(handle, credits, credits, 0);
-}
-
-static inline int ext4_journal_ensure_credits_batch(handle_t *handle,
-						    int credits)
-{
-	return ext4_journal_ensure_credits_fn(handle, credits,
-					      EXT4_MAX_TRANS_DATA, 0);
+	return ext4_journal_ensure_credits_fn(handle, credits, credits,
+				revoke_creds, 0);
 }
 
 static inline int ext4_journal_blocks_per_page(struct inode *inode)
@@ -478,6 +498,15 @@ static inline int ext4_should_writeback_data(struct inode *inode)
 	return ext4_inode_journal_mode(inode) & EXT4_INODE_WRITEBACK_DATA_MODE;
 }
 
+static inline int ext4_free_data_revoke_credits(struct inode *inode, int blocks)
+{
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA)
+		return 0;
+	if (!ext4_should_journal_data(inode))
+		return 0;
+	return blocks + 2*EXT4_SB(inode->i_sb)->s_cluster_ratio;
+}
+
 /*
  * This function controls whether or not we should try to go down the
  * dioread_nolock code paths, which makes it safe to avoid taking
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 13af104f38f4..063b80776268 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -124,13 +124,14 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
  * and < 0 in case of fatal error.
  */
 int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
-				int check_cred, int restart_cred)
+				int check_cred, int restart_cred,
+				int revoke_cred)
 {
 	int ret;
 	int dropped = 0;
 
 	ret = ext4_journal_ensure_credits_fn(handle, check_cred, restart_cred,
-			ext4_ext_trunc_restart_fn(inode, &dropped));
+		revoke_cred, ext4_ext_trunc_restart_fn(inode, &dropped));
 	if (dropped)
 		down_write(&EXT4_I(inode)->i_data_sem);
 	return ret;
@@ -1851,7 +1852,8 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
 	 * group descriptor to release the extent tree block.  If we
 	 * can't get the journal credits, give up.
 	 */
-	if (ext4_journal_extend(handle, 2))
+	if (ext4_journal_extend(handle, 2,
+			ext4_free_metadata_revoke_credits(inode->i_sb, 1)))
 		return;
 
 	/*
@@ -2692,7 +2694,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int err = 0, correct_index = 0;
-	int depth = ext_depth(inode), credits;
+	int depth = ext_depth(inode), credits, revoke_credits;
 	struct ext4_extent_header *eh;
 	ext4_lblk_t a, b;
 	unsigned num;
@@ -2784,9 +2786,16 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			credits += (ext_depth(inode)) + 1;
 		}
 		credits += EXT4_MAXQUOTAS_TRANS_BLOCKS(inode->i_sb);
+		/*
+		 * We may end up freeing some index blocks and data from the
+		 * punched range. Note that partial clusters are accounted for
+		 * by ext4_free_data_revoke_credits().
+		 */
+		revoke_credits = ext_depth(inode) +
+			ext4_free_data_revoke_credits(inode, b - a + 1);
 
 		err = ext4_datasem_ensure_credits(handle, inode, credits,
-						  credits);
+						  credits, revoke_credits);
 		if (err) {
 			if (err > 0)
 				err = -EAGAIN;
@@ -2917,7 +2926,9 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	ext_debug("truncate since %u to %u\n", start, end);
 
 	/* probably first extent we're gonna free will be last in block */
-	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, depth + 1);
+	handle = ext4_journal_start_with_revoke(inode, EXT4_HT_TRUNCATE,
+			depth + 1,
+			ext4_free_metadata_revoke_credits(inode->i_sb, depth));
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
@@ -5144,7 +5155,7 @@ ext4_access_path(handle_t *handle, struct inode *inode,
 	 * groups
 	 */
 	credits = ext4_writepage_trans_blocks(inode);
-	err = ext4_datasem_ensure_credits(handle, inode, 7, credits);
+	err = ext4_datasem_ensure_credits(handle, inode, 7, credits, 0);
 	if (err < 0)
 		return err;
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 764ff4c56233..fa8c3c485e4b 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -927,7 +927,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 			BUG_ON(nblocks <= 0);
 			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
 							 handle_type, nblocks,
-							 0);
+							 0, 0);
 			if (IS_ERR(handle)) {
 				err = PTR_ERR(handle);
 				ext4_std_error(sb, err);
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 63e1d5846442..3a4ab70fe9e0 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -736,13 +736,14 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
  */
 static int ext4_ind_truncate_ensure_credits(handle_t *handle,
 					    struct inode *inode,
-					    struct buffer_head *bh)
+					    struct buffer_head *bh,
+					    int revoke_creds)
 {
 	int ret;
 	int dropped = 0;
 
 	ret = ext4_journal_ensure_credits_fn(handle, EXT4_RESERVE_TRANS_BLOCKS,
-			ext4_blocks_for_truncate(inode),
+			ext4_blocks_for_truncate(inode), revoke_creds,
 			ext4_ind_trunc_restart_fn(handle, inode, bh, &dropped));
 	if (dropped)
 		down_write(&EXT4_I(inode)->i_data_sem);
@@ -889,7 +890,8 @@ static int ext4_clear_blocks(handle_t *handle, struct inode *inode,
 		return 1;
 	}
 
-	err = ext4_ind_truncate_ensure_credits(handle, inode, bh);
+	err = ext4_ind_truncate_ensure_credits(handle, inode, bh,
+				ext4_free_data_revoke_credits(inode, count));
 	if (err < 0)
 		goto out_err;
 
@@ -1075,7 +1077,9 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 			if (ext4_handle_is_aborted(handle))
 				return;
 			if (ext4_ind_truncate_ensure_credits(handle, inode,
-							     NULL) < 0)
+					NULL,
+					ext4_free_metadata_revoke_credits(
+							inode->i_sb, 1)) < 0)
 				return;
 
 			/*
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index c2303a4d5a74..add4745ae50b 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5964,7 +5964,7 @@ static int ext4_try_to_expand_extra_isize(struct inode *inode,
 	 * force a large enough s_min_extra_isize.
 	 */
 	if (ext4_journal_extend(handle,
-				EXT4_DATA_TRANS_BLOCKS(inode->i_sb)) != 0)
+				EXT4_DATA_TRANS_BLOCKS(inode->i_sb), 0) != 0)
 		return -ENOSPC;
 
 	if (ext4_write_trylock_xattr(inode, &no_expand) == 0)
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 65f09dc9d941..89725fa42573 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -50,7 +50,7 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	needed = ext4_ext_calc_credits_for_single_extent(inode,
 		    lb->last_block - lb->first_block + 1, path);
 
-	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed);
+	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed, 0);
 	if (retval < 0)
 		goto err_out;
 	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
@@ -182,10 +182,11 @@ static int free_dind_blocks(handle_t *handle,
 	int i;
 	__le32 *tmp_idata;
 	struct buffer_head *bh;
+	struct super_block *sb = inode->i_sb;
 	unsigned long max_entries = inode->i_sb->s_blocksize >> 2;
 	int err;
 
-	bh = ext4_sb_bread(inode->i_sb, le32_to_cpu(i_data), 0);
+	bh = ext4_sb_bread(sb, le32_to_cpu(i_data), 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -193,7 +194,8 @@ static int free_dind_blocks(handle_t *handle,
 	for (i = 0; i < max_entries; i++) {
 		if (tmp_idata[i]) {
 			err = ext4_journal_ensure_credits(handle,
-						EXT4_RESERVE_TRANS_BLOCKS);
+				EXT4_RESERVE_TRANS_BLOCKS,
+				ext4_free_metadata_revoke_credits(sb, 1));
 			if (err < 0) {
 				put_bh(bh);
 				return err;
@@ -205,7 +207,8 @@ static int free_dind_blocks(handle_t *handle,
 		}
 	}
 	put_bh(bh);
-	err = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS);
+	err = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS,
+				ext4_free_metadata_revoke_credits(sb, 1));
 	if (err < 0)
 		return err;
 	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
@@ -238,7 +241,8 @@ static int free_tind_blocks(handle_t *handle,
 		}
 	}
 	put_bh(bh);
-	retval = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS);
+	retval = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS,
+			ext4_free_metadata_revoke_credits(inode->i_sb, 1));
 	if (retval < 0)
 		return retval;
 	ext4_free_blocks(handle, inode, NULL, le32_to_cpu(i_data), 1,
@@ -254,7 +258,8 @@ static int free_ind_block(handle_t *handle, struct inode *inode, __le32 *i_data)
 	/* ei->i_data[EXT4_IND_BLOCK] */
 	if (i_data[0]) {
 		retval = ext4_journal_ensure_credits(handle,
-						     EXT4_RESERVE_TRANS_BLOCKS);
+			EXT4_RESERVE_TRANS_BLOCKS,
+			ext4_free_metadata_revoke_credits(inode->i_sb, 1));
 		if (retval < 0)
 			return retval;
 		ext4_free_blocks(handle, inode, NULL,
@@ -291,7 +296,7 @@ static int ext4_ext_swap_inode_data(handle_t *handle, struct inode *inode,
 	 * One credit accounted for writing the
 	 * i_data field of the original inode
 	 */
-	retval = ext4_journal_ensure_credits(handle, 1);
+	retval = ext4_journal_ensure_credits(handle, 1, 0);
 	if (retval < 0)
 		goto err_out;
 
@@ -368,7 +373,8 @@ static int free_ext_idx(handle_t *handle, struct inode *inode,
 		}
 	}
 	put_bh(bh);
-	retval = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS);
+	retval = ext4_journal_ensure_credits(handle, EXT4_RESERVE_TRANS_BLOCKS,
+			ext4_free_metadata_revoke_credits(inode->i_sb, 1));
 	if (retval < 0)
 		return retval;
 	ext4_free_blocks(handle, inode, NULL, block, 1,
@@ -548,7 +554,7 @@ int ext4_ext_migrate(struct inode *inode)
 	}
 
 	/* We mark the tmp_inode dirty via ext4_ext_tree_init. */
-	retval = ext4_journal_ensure_credits(handle, 1);
+	retval = ext4_journal_ensure_credits(handle, 1, 0);
 	if (retval < 0)
 		goto out_stop;
 	/*
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a9a0a24bcd89..9eb09228714a 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -388,6 +388,12 @@ static struct buffer_head *bclean(handle_t *handle, struct super_block *sb,
 	return bh;
 }
 
+static int ext4_resize_ensure_credits_batch(handle_t *handle, int credits)
+{
+	return ext4_journal_ensure_credits_fn(handle, credits,
+		EXT4_MAX_TRANS_DATA, 0, 0);
+}
+
 /*
  * set_flexbg_block_bitmap() mark clusters [@first_cluster, @last_cluster] used.
  *
@@ -427,7 +433,7 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 			continue;
 		}
 
-		err = ext4_journal_ensure_credits_batch(handle, 1);
+		err = ext4_resize_ensure_credits_batch(handle, 1);
 		if (err)
 			return err;
 
@@ -520,7 +526,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 			struct buffer_head *gdb;
 
 			ext4_debug("update backup group %#04llx\n", block);
-			err = ext4_journal_ensure_credits_batch(handle, 1);
+			err = ext4_resize_ensure_credits_batch(handle, 1);
 			if (err)
 				goto out;
 
@@ -578,7 +584,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 
 		/* Initialize block bitmap of the @group */
 		block = group_data[i].block_bitmap;
-		err = ext4_journal_ensure_credits_batch(handle, 1);
+		err = ext4_resize_ensure_credits_batch(handle, 1);
 		if (err)
 			goto out;
 
@@ -607,7 +613,7 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 
 		/* Initialize inode bitmap of the @group */
 		block = group_data[i].inode_bitmap;
-		err = ext4_journal_ensure_credits_batch(handle, 1);
+		err = ext4_resize_ensure_credits_batch(handle, 1);
 		if (err)
 			goto out;
 		/* Mark unused entries in inode bitmap used */
@@ -1085,7 +1091,7 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 		ext4_fsblk_t backup_block;
 
 		/* Out of journal space, and can't get more - abort - so sad */
-		err = ext4_journal_ensure_credits_batch(handle, 1);
+		err = ext4_resize_ensure_credits_batch(handle, 1);
 		if (err < 0)
 			break;
 
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 17d7eea144e8..efaed2462d42 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1155,6 +1155,7 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 		}
 
 		err = ext4_journal_ensure_credits_fn(handle, credits, credits,
+			ext4_free_metadata_revoke_credits(parent->i_sb, 1),
 			ext4_xattr_restart_fn(handle, parent, bh, block_csum,
 					      dirty));
 		if (err < 0) {
@@ -2841,7 +2842,8 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 	struct inode *ea_inode;
 	int error;
 
-	error = ext4_journal_ensure_credits(handle, extra_credits);
+	error = ext4_journal_ensure_credits(handle, extra_credits,
+			ext4_free_metadata_revoke_credits(inode->i_sb, 1));
 	if (error) {
 		EXT4_ERROR_INODE(inode, "ensure credits (error %d)", error);
 		goto cleanup;
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index d68e9e536814..182c9fe9c0e9 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1746,15 +1746,16 @@ TRACE_EVENT(ext4_load_inode,
 
 TRACE_EVENT(ext4_journal_start,
 	TP_PROTO(struct super_block *sb, int blocks, int rsv_blocks,
-		 unsigned long IP),
+		 int revoke_creds, unsigned long IP),
 
-	TP_ARGS(sb, blocks, rsv_blocks, IP),
+	TP_ARGS(sb, blocks, rsv_blocks, revoke_creds, IP),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(unsigned long,	ip			)
 		__field(	  int,	blocks			)
 		__field(	  int,	rsv_blocks		)
+		__field(	  int,	revoke_creds		)
 	),
 
 	TP_fast_assign(
@@ -1762,11 +1763,13 @@ TRACE_EVENT(ext4_journal_start,
 		__entry->ip		 = IP;
 		__entry->blocks		 = blocks;
 		__entry->rsv_blocks	 = rsv_blocks;
+		__entry->revoke_creds	 = revoke_creds;
 	),
 
-	TP_printk("dev %d,%d blocks, %d rsv_blocks, %d caller %pS",
-		  MAJOR(__entry->dev), MINOR(__entry->dev),
-		  __entry->blocks, __entry->rsv_blocks, (void *)__entry->ip)
+	TP_printk("dev %d,%d blocks %d, rsv_blocks %d, revoke_creds %d, "
+		  "caller %pS", MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->blocks, __entry->rsv_blocks, __entry->revoke_creds,
+		  (void *)__entry->ip)
 );
 
 TRACE_EVENT(ext4_journal_start_reserved,
-- 
2.16.4

