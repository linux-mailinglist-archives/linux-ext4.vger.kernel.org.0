Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD4F3E8E60
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Aug 2021 12:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhHKKTz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Aug 2021 06:19:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47610 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236937AbhHKKTu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Aug 2021 06:19:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1A5F9221CF;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628677166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQ8hPipCeBFJLpbn/QEao91JvBydgWwfObVrJRl4SGE=;
        b=GtAaGSrU0ylmSAYkeHMZWhn7m+G/qa+udZCXZeiIOEEB8brUS0N5Q7hiz2hVkhQvRIEpU4
        PGRkbvOyjbKYuMg9IRP1qmO1LVLYOMj55P674OWR+PT5ZYjVVdxisv0V7rzaYKXwWJiQ3R
        fcrossKmn0xqum4uX2TWaulUqDdpUcI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628677166;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EQ8hPipCeBFJLpbn/QEao91JvBydgWwfObVrJRl4SGE=;
        b=JdpHL+IrmpdIRd1ezfzFh53vjKOivPOaMJhYDxDj4iI+cjEJgMFjiaypZYKAe7BT7tTK4W
        qOwfRZtyFnZa6IAw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0555EA3BFD;
        Wed, 11 Aug 2021 10:19:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D14701E14BC; Wed, 11 Aug 2021 12:19:25 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/5] ext4: Support for checksumming from journal triggers
Date:   Wed, 11 Aug 2021 12:19:11 +0200
Message-Id: <20210811101925.6973-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210811101006.2033-1-jack@suse.cz>
References: <20210811101006.2033-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=45590; h=from:subject; bh=SelBa9v/sHEPlwMPkEoE2xbKkwVu7mDN0raHgOwYYng=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhE6QejRejrRJUSzfCUosVdRR465mM2SEimcBO0qoI 60/leWyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYROkHgAKCRCcnaoHP2RA2XG1B/ sFV+CMNPdzbgTOmEDzbMYUcV8UWCf/M4VYjaKNksbrmeHW80Y5YMd3ttLcQnlmHpNfpsnZKagLseSt Z2IT2CcTGHa0xlPU/BGly0VgCi7sogFtWNPMNWQF2J8WEGgi/3yj9Kb4/WqzQi3Qm15J+hG58Hp1Qw G95vAgCB4ocivhhuJgBDDuMuDihLL59DE2/y0nWpaon2OIHfPanJjr+wRdIToB9RtvYcF8lfF7D9/S xlJ3mfl9w90KZWqEW4QzzIGb7Ah8eCTuHNEmQYWEvbryJqJaNpqSE/4vuA5+vqYVWM6R3hpYEsq2d0 Ecv4cehtEuEDMROujIXTPsKuJpjc7q
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

JBD2 layer support triggers which are called when journaling layer moves
buffer to a certain state. We can use the frozen trigger, which gets
called when buffer data is frozen and about to be written out to the
journal, to compute block checksums for some buffer types (similarly as
does ocfs2). This avoids unnecessary repeated recomputation of the
checksum (at the cost of larger window where memory corruption won't be
caught by checksumming) and is even necessary when there are
unsynchronized updaters of the checksummed data.

So add superblock and journal trigger type arguments to
ext4_journal_get_write_access() and ext4_journal_get_create_access() so
that frozen triggers can be set accordingly. Also add inode argument to
ext4_walk_page_buffers() and all the callbacks used with that function
for the same purpose. This patch is mostly only a change of prototype of
the above mentioned functions and a few small helpers. Real checksumming
will come later.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        | 26 ++++++++++++--
 fs/ext4/ext4_jbd2.c   | 43 +++++++++++++++-------
 fs/ext4/ext4_jbd2.h   | 18 ++++++----
 fs/ext4/extents.c     | 12 ++++---
 fs/ext4/file.c        |  3 +-
 fs/ext4/ialloc.c      | 19 ++++++----
 fs/ext4/indirect.c    | 15 +++++---
 fs/ext4/inline.c      | 26 +++++++++-----
 fs/ext4/inode.c       | 84 +++++++++++++++++++++++++------------------
 fs/ext4/ioctl.c       |  4 ++-
 fs/ext4/mballoc.c     | 15 ++++----
 fs/ext4/namei.c       | 40 +++++++++++++--------
 fs/ext4/resize.c      | 38 ++++++++++++--------
 fs/ext4/super.c       | 16 ++++++++-
 fs/ext4/xattr.c       | 26 +++++++++-----
 fs/jbd2/transaction.c |  2 +-
 16 files changed, 259 insertions(+), 128 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3c51e243450d..c3cd7faa6cf2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1447,6 +1447,24 @@ struct ext4_super_block {
 
 #define EXT4_ENC_UTF8_12_1	1
 
+/* Types of ext4 journal triggers */
+enum ext4_journal_trigger_type {
+	EXT4_JTR_NONE	/* This must be the last entry for indexing to work! */
+};
+
+#define EXT4_JOURNAL_TRIGGER_COUNT EXT4_JTR_NONE
+
+struct ext4_journal_trigger {
+	struct jbd2_buffer_trigger_type tr_triggers;
+	struct super_block *sb;
+};
+
+static inline struct ext4_journal_trigger *EXT4_TRIGGER(
+				struct jbd2_buffer_trigger_type *trigger)
+{
+	return container_of(trigger, struct ext4_journal_trigger, tr_triggers);
+}
+
 /*
  * fourth extended-fs super-block data in memory
  */
@@ -1625,6 +1643,9 @@ struct ext4_sb_info {
 	struct mb_cache *s_ea_inode_cache;
 	spinlock_t s_es_lock ____cacheline_aligned_in_smp;
 
+	/* Journal triggers for checksum computation */
+	struct ext4_journal_trigger s_journal_triggers[EXT4_JOURNAL_TRIGGER_COUNT];
+
 	/* Ratelimit ext4 messages. */
 	struct ratelimit_state s_err_ratelimit_state;
 	struct ratelimit_state s_warning_ratelimit_state;
@@ -2920,13 +2941,14 @@ int ext4_get_block(struct inode *inode, sector_t iblock,
 int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 			   struct buffer_head *bh, int create);
 int ext4_walk_page_buffers(handle_t *handle,
+			   struct inode *inode,
 			   struct buffer_head *head,
 			   unsigned from,
 			   unsigned to,
 			   int *partial,
-			   int (*fn)(handle_t *handle,
+			   int (*fn)(handle_t *handle, struct inode *inode,
 				     struct buffer_head *bh));
-int do_journal_get_write_access(handle_t *handle,
+int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index b60f0152ea57..6def7339056d 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -218,9 +218,11 @@ static void ext4_check_bdev_write_error(struct super_block *sb)
 }
 
 int __ext4_journal_get_write_access(const char *where, unsigned int line,
-				    handle_t *handle, struct buffer_head *bh)
+				    handle_t *handle, struct super_block *sb,
+				    struct buffer_head *bh,
+				    enum ext4_journal_trigger_type trigger_type)
 {
-	int err = 0;
+	int err;
 
 	might_sleep();
 
@@ -229,11 +231,18 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
 
 	if (ext4_handle_valid(handle)) {
 		err = jbd2_journal_get_write_access(handle, bh);
-		if (err)
+		if (err) {
 			ext4_journal_abort_handle(where, line, __func__, bh,
 						  handle, err);
+			return err;
+		}
 	}
-	return err;
+	if (trigger_type == EXT4_JTR_NONE || !ext4_has_metadata_csum(sb))
+		return 0;
+	BUG_ON(trigger_type >= EXT4_JOURNAL_TRIGGER_COUNT);
+	jbd2_journal_set_triggers(bh,
+		&EXT4_SB(sb)->s_journal_triggers[trigger_type].tr_triggers);
+	return 0;
 }
 
 /*
@@ -301,17 +310,27 @@ int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 }
 
 int __ext4_journal_get_create_access(const char *where, unsigned int line,
-				handle_t *handle, struct buffer_head *bh)
+				handle_t *handle, struct super_block *sb,
+				struct buffer_head *bh,
+				enum ext4_journal_trigger_type trigger_type)
 {
-	int err = 0;
+	int err;
 
-	if (ext4_handle_valid(handle)) {
-		err = jbd2_journal_get_create_access(handle, bh);
-		if (err)
-			ext4_journal_abort_handle(where, line, __func__,
-						  bh, handle, err);
+	if (!ext4_handle_valid(handle))
+		return 0;
+
+	err = jbd2_journal_get_create_access(handle, bh);
+	if (err) {
+		ext4_journal_abort_handle(where, line, __func__, bh, handle,
+					  err);
+		return err;
 	}
-	return err;
+	if (trigger_type == EXT4_JTR_NONE || !ext4_has_metadata_csum(sb))
+		return 0;
+	BUG_ON(trigger_type >= EXT4_JOURNAL_TRIGGER_COUNT);
+	jbd2_journal_set_triggers(bh,
+		&EXT4_SB(sb)->s_journal_triggers[trigger_type].tr_triggers);
+	return 0;
 }
 
 int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 0d2fa423b7ad..0e4fa644df01 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -231,26 +231,32 @@ int ext4_expand_extra_isize(struct inode *inode,
  * Wrapper functions with which ext4 calls into JBD.
  */
 int __ext4_journal_get_write_access(const char *where, unsigned int line,
-				    handle_t *handle, struct buffer_head *bh);
+				    handle_t *handle, struct super_block *sb,
+				    struct buffer_head *bh,
+				    enum ext4_journal_trigger_type trigger_type);
 
 int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
 		  int is_metadata, struct inode *inode,
 		  struct buffer_head *bh, ext4_fsblk_t blocknr);
 
 int __ext4_journal_get_create_access(const char *where, unsigned int line,
-				handle_t *handle, struct buffer_head *bh);
+				handle_t *handle, struct super_block *sb,
+				struct buffer_head *bh,
+				enum ext4_journal_trigger_type trigger_type);
 
 int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				 handle_t *handle, struct inode *inode,
 				 struct buffer_head *bh);
 
-#define ext4_journal_get_write_access(handle, bh) \
-	__ext4_journal_get_write_access(__func__, __LINE__, (handle), (bh))
+#define ext4_journal_get_write_access(handle, sb, bh, trigger_type) \
+	__ext4_journal_get_write_access(__func__, __LINE__, (handle), (sb), \
+					(bh), (trigger_type))
 #define ext4_forget(handle, is_metadata, inode, bh, block_nr) \
 	__ext4_forget(__func__, __LINE__, (handle), (is_metadata), (inode), \
 		      (bh), (block_nr))
-#define ext4_journal_get_create_access(handle, bh) \
-	__ext4_journal_get_create_access(__func__, __LINE__, (handle), (bh))
+#define ext4_journal_get_create_access(handle, sb, bh, trigger_type) \
+	__ext4_journal_get_create_access(__func__, __LINE__, (handle), (sb), \
+					 (bh), (trigger_type))
 #define ext4_handle_dirty_metadata(handle, inode, bh) \
 	__ext4_handle_dirty_metadata(__func__, __LINE__, (handle), (inode), \
 				     (bh))
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92ad64b89d9b..7edc921107ac 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -139,7 +139,8 @@ static int ext4_ext_get_access(handle_t *handle, struct inode *inode,
 	if (path->p_bh) {
 		/* path points to block */
 		BUFFER_TRACE(path->p_bh, "get_write_access");
-		return ext4_journal_get_write_access(handle, path->p_bh);
+		return ext4_journal_get_write_access(handle, inode->i_sb,
+						     path->p_bh, EXT4_JTR_NONE);
 	}
 	/* path points to leaf/index in inode body */
 	/* we use in-core data, no need to protect them */
@@ -1082,7 +1083,8 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	}
 	lock_buffer(bh);
 
-	err = ext4_journal_get_create_access(handle, bh);
+	err = ext4_journal_get_create_access(handle, inode->i_sb, bh,
+					     EXT4_JTR_NONE);
 	if (err)
 		goto cleanup;
 
@@ -1160,7 +1162,8 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 		}
 		lock_buffer(bh);
 
-		err = ext4_journal_get_create_access(handle, bh);
+		err = ext4_journal_get_create_access(handle, inode->i_sb, bh,
+						     EXT4_JTR_NONE);
 		if (err)
 			goto cleanup;
 
@@ -1286,7 +1289,8 @@ static int ext4_ext_grow_indepth(handle_t *handle, struct inode *inode,
 		return -ENOMEM;
 	lock_buffer(bh);
 
-	err = ext4_journal_get_create_access(handle, bh);
+	err = ext4_journal_get_create_access(handle, inode->i_sb, bh,
+					     EXT4_JTR_NONE);
 	if (err) {
 		unlock_buffer(bh);
 		goto out;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 816dedcbd541..eda12bc50592 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -822,7 +822,8 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 	if (IS_ERR(handle))
 		goto out;
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto out_journal;
 	lock_buffer(sbi->s_sbh);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e89fc0f770b0..f73e5eb43eae 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -300,7 +300,8 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	}
 
 	BUFFER_TRACE(bitmap_bh, "get_write_access");
-	fatal = ext4_journal_get_write_access(handle, bitmap_bh);
+	fatal = ext4_journal_get_write_access(handle, sb, bitmap_bh,
+					      EXT4_JTR_NONE);
 	if (fatal)
 		goto error_return;
 
@@ -308,7 +309,8 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	gdp = ext4_get_group_desc(sb, block_group, &bh2);
 	if (gdp) {
 		BUFFER_TRACE(bh2, "get_write_access");
-		fatal = ext4_journal_get_write_access(handle, bh2);
+		fatal = ext4_journal_get_write_access(handle, sb, bh2,
+						      EXT4_JTR_NONE);
 	}
 	ext4_lock_group(sb, block_group);
 	cleared = ext4_test_and_clear_bit(bit, bitmap_bh->b_data);
@@ -1085,7 +1087,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			}
 		}
 		BUFFER_TRACE(inode_bitmap_bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, inode_bitmap_bh);
+		err = ext4_journal_get_write_access(handle, sb, inode_bitmap_bh,
+						    EXT4_JTR_NONE);
 		if (err) {
 			ext4_std_error(sb, err);
 			goto out;
@@ -1127,7 +1130,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	}
 
 	BUFFER_TRACE(group_desc_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, group_desc_bh);
+	err = ext4_journal_get_write_access(handle, sb, group_desc_bh,
+					    EXT4_JTR_NONE);
 	if (err) {
 		ext4_std_error(sb, err);
 		goto out;
@@ -1144,7 +1148,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 			goto out;
 		}
 		BUFFER_TRACE(block_bitmap_bh, "get block bitmap access");
-		err = ext4_journal_get_write_access(handle, block_bitmap_bh);
+		err = ext4_journal_get_write_access(handle, sb, block_bitmap_bh,
+						    EXT4_JTR_NONE);
 		if (err) {
 			brelse(block_bitmap_bh);
 			ext4_std_error(sb, err);
@@ -1583,8 +1588,8 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
 	num = sbi->s_itb_per_group - used_blks;
 
 	BUFFER_TRACE(group_desc_bh, "get_write_access");
-	ret = ext4_journal_get_write_access(handle,
-					    group_desc_bh);
+	ret = ext4_journal_get_write_access(handle, sb, group_desc_bh,
+					    EXT4_JTR_NONE);
 	if (ret)
 		goto err_out;
 
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index a7bc6ad656a9..89efa78ed4b2 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -354,7 +354,8 @@ static int ext4_alloc_branch(handle_t *handle,
 		}
 		lock_buffer(bh);
 		BUFFER_TRACE(bh, "call get_create_access");
-		err = ext4_journal_get_create_access(handle, bh);
+		err = ext4_journal_get_create_access(handle, ar->inode->i_sb,
+						     bh, EXT4_JTR_NONE);
 		if (err) {
 			unlock_buffer(bh);
 			goto failed;
@@ -429,7 +430,8 @@ static int ext4_splice_branch(handle_t *handle,
 	 */
 	if (where->bh) {
 		BUFFER_TRACE(where->bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, where->bh);
+		err = ext4_journal_get_write_access(handle, ar->inode->i_sb,
+						    where->bh, EXT4_JTR_NONE);
 		if (err)
 			goto err_out;
 	}
@@ -728,7 +730,8 @@ static int ext4_ind_truncate_ensure_credits(handle_t *handle,
 		return ret;
 	if (bh) {
 		BUFFER_TRACE(bh, "retaking write access");
-		ret = ext4_journal_get_write_access(handle, bh);
+		ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+						    EXT4_JTR_NONE);
 		if (unlikely(ret))
 			return ret;
 	}
@@ -916,7 +919,8 @@ static void ext4_free_data(handle_t *handle, struct inode *inode,
 
 	if (this_bh) {				/* For indirect block */
 		BUFFER_TRACE(this_bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, this_bh);
+		err = ext4_journal_get_write_access(handle, inode->i_sb,
+						    this_bh, EXT4_JTR_NONE);
 		/* Important: if we can't update the indirect pointers
 		 * to the blocks, we can't free them. */
 		if (err)
@@ -1079,7 +1083,8 @@ static void ext4_free_branches(handle_t *handle, struct inode *inode,
 				 */
 				BUFFER_TRACE(parent_bh, "get_write_access");
 				if (!ext4_journal_get_write_access(handle,
-								   parent_bh)){
+						inode->i_sb, parent_bh,
+						EXT4_JTR_NONE)) {
 					*p = 0;
 					BUFFER_TRACE(parent_bh,
 					"call ext4_handle_dirty_metadata");
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 70cb64db33f7..fc15ed79f09d 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -264,7 +264,8 @@ static int ext4_create_inline_data(handle_t *handle,
 		return error;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
-	error = ext4_journal_get_write_access(handle, is.iloc.bh);
+	error = ext4_journal_get_write_access(handle, inode->i_sb, is.iloc.bh,
+					      EXT4_JTR_NONE);
 	if (error)
 		goto out;
 
@@ -350,7 +351,8 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
-	error = ext4_journal_get_write_access(handle, is.iloc.bh);
+	error = ext4_journal_get_write_access(handle, inode->i_sb, is.iloc.bh,
+					      EXT4_JTR_NONE);
 	if (error)
 		goto out;
 
@@ -427,7 +429,8 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
 		goto out;
 
 	BUFFER_TRACE(is.iloc.bh, "get_write_access");
-	error = ext4_journal_get_write_access(handle, is.iloc.bh);
+	error = ext4_journal_get_write_access(handle, inode->i_sb, is.iloc.bh,
+					      EXT4_JTR_NONE);
 	if (error)
 		goto out;
 
@@ -593,7 +596,7 @@ static int ext4_convert_inline_data_to_extent(struct address_space *mapping,
 		ret = __block_write_begin(page, from, to, ext4_get_block);
 
 	if (!ret && ext4_should_journal_data(inode)) {
-		ret = ext4_walk_page_buffers(handle, page_buffers(page),
+		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
 					     from, to, NULL,
 					     do_journal_get_write_access);
 	}
@@ -682,7 +685,8 @@ int ext4_try_to_write_inline_data(struct address_space *mapping,
 		goto convert;
 	}
 
-	ret = ext4_journal_get_write_access(handle, iloc.bh);
+	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
+					    EXT4_JTR_NONE);
 	if (ret)
 		goto out;
 
@@ -923,7 +927,8 @@ int ext4_da_write_inline_data_begin(struct address_space *mapping,
 		if (ret < 0)
 			goto out_release_page;
 	}
-	ret = ext4_journal_get_write_access(handle, iloc.bh);
+	ret = ext4_journal_get_write_access(handle, inode->i_sb, iloc.bh,
+					    EXT4_JTR_NONE);
 	if (ret)
 		goto out_release_page;
 
@@ -1028,7 +1033,8 @@ static int ext4_add_dirent_to_inline(handle_t *handle,
 		return err;
 
 	BUFFER_TRACE(iloc->bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, iloc->bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, iloc->bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		return err;
 	ext4_insert_dentry(dir, inode, de, inline_size, fname);
@@ -1223,7 +1229,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
 	}
 
 	lock_buffer(data_bh);
-	error = ext4_journal_get_create_access(handle, data_bh);
+	error = ext4_journal_get_create_access(handle, inode->i_sb, data_bh,
+					       EXT4_JTR_NONE);
 	if (error) {
 		unlock_buffer(data_bh);
 		error = -EIO;
@@ -1707,7 +1714,8 @@ int ext4_delete_inline_entry(handle_t *handle,
 	}
 
 	BUFFER_TRACE(bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto out;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..d29bd3bfbcfd 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -139,7 +139,6 @@ static inline int ext4_begin_ordered_truncate(struct inode *inode,
 static void ext4_invalidatepage(struct page *page, unsigned int offset,
 				unsigned int length);
 static int __ext4_journalled_writepage(struct page *page, unsigned int len);
-static int ext4_bh_delay_or_unwritten(handle_t *handle, struct buffer_head *bh);
 static int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 
@@ -869,7 +868,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 		 */
 		lock_buffer(bh);
 		BUFFER_TRACE(bh, "call get_create_access");
-		err = ext4_journal_get_create_access(handle, bh);
+		err = ext4_journal_get_create_access(handle, inode->i_sb, bh,
+						     EXT4_JTR_NONE);
 		if (unlikely(err)) {
 			unlock_buffer(bh);
 			goto errout;
@@ -954,12 +954,12 @@ int ext4_bread_batch(struct inode *inode, ext4_lblk_t block, int bh_count,
 	return err;
 }
 
-int ext4_walk_page_buffers(handle_t *handle,
+int ext4_walk_page_buffers(handle_t *handle, struct inode *inode,
 			   struct buffer_head *head,
 			   unsigned from,
 			   unsigned to,
 			   int *partial,
-			   int (*fn)(handle_t *handle,
+			   int (*fn)(handle_t *handle, struct inode *inode,
 				     struct buffer_head *bh))
 {
 	struct buffer_head *bh;
@@ -978,7 +978,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				*partial = 1;
 			continue;
 		}
-		err = (*fn)(handle, bh);
+		err = (*fn)(handle, inode, bh);
 		if (!ret)
 			ret = err;
 	}
@@ -1009,7 +1009,7 @@ int ext4_walk_page_buffers(handle_t *handle,
  * is elevated.  We'll still have enough credits for the tiny quotafile
  * write.
  */
-int do_journal_get_write_access(handle_t *handle,
+int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh)
 {
 	int dirty = buffer_dirty(bh);
@@ -1028,7 +1028,8 @@ int do_journal_get_write_access(handle_t *handle,
 	if (dirty)
 		clear_buffer_dirty(bh);
 	BUFFER_TRACE(bh, "get write access");
-	ret = ext4_journal_get_write_access(handle, bh);
+	ret = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+					    EXT4_JTR_NONE);
 	if (!ret && dirty)
 		ret = ext4_handle_dirty_metadata(handle, NULL, bh);
 	return ret;
@@ -1208,8 +1209,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 		ret = __block_write_begin(page, pos, len, ext4_get_block);
 #endif
 	if (!ret && ext4_should_journal_data(inode)) {
-		ret = ext4_walk_page_buffers(handle, page_buffers(page),
-					     from, to, NULL,
+		ret = ext4_walk_page_buffers(handle, inode,
+					     page_buffers(page), from, to, NULL,
 					     do_journal_get_write_access);
 	}
 
@@ -1253,7 +1254,8 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 }
 
 /* For write_end() in data=journal mode */
-static int write_end_fn(handle_t *handle, struct buffer_head *bh)
+static int write_end_fn(handle_t *handle, struct inode *inode,
+			struct buffer_head *bh)
 {
 	int ret;
 	if (!buffer_mapped(bh) || buffer_freed(bh))
@@ -1352,6 +1354,7 @@ static int ext4_write_end(struct file *file,
  * to call ext4_handle_dirty_metadata() instead.
  */
 static void ext4_journalled_zero_new_buffers(handle_t *handle,
+					    struct inode *inode,
 					    struct page *page,
 					    unsigned from, unsigned to)
 {
@@ -1370,7 +1373,7 @@ static void ext4_journalled_zero_new_buffers(handle_t *handle,
 					size = min(to, block_end) - start;
 
 					zero_user(page, start, size);
-					write_end_fn(handle, bh);
+					write_end_fn(handle, inode, bh);
 				}
 				clear_buffer_new(bh);
 			}
@@ -1412,13 +1415,13 @@ static int ext4_journalled_write_end(struct file *file,
 		copied = ret;
 	} else if (unlikely(copied < len) && !PageUptodate(page)) {
 		copied = 0;
-		ext4_journalled_zero_new_buffers(handle, page, from, to);
+		ext4_journalled_zero_new_buffers(handle, inode, page, from, to);
 	} else {
 		if (unlikely(copied < len))
-			ext4_journalled_zero_new_buffers(handle, page,
+			ext4_journalled_zero_new_buffers(handle, inode, page,
 							 from + copied, to);
-		ret = ext4_walk_page_buffers(handle, page_buffers(page), from,
-					     from + copied, &partial,
+		ret = ext4_walk_page_buffers(handle, inode, page_buffers(page),
+					     from, from + copied, &partial,
 					     write_end_fn);
 		if (!partial)
 			SetPageUptodate(page);
@@ -1619,7 +1622,8 @@ static void ext4_print_free_blocks(struct inode *inode)
 	return;
 }
 
-static int ext4_bh_delay_or_unwritten(handle_t *handle, struct buffer_head *bh)
+static int ext4_bh_delay_or_unwritten(handle_t *handle, struct inode *inode,
+				      struct buffer_head *bh)
 {
 	return (buffer_delay(bh) || buffer_unwritten(bh)) && buffer_dirty(bh);
 }
@@ -1851,13 +1855,15 @@ int ext4_da_get_block_prep(struct inode *inode, sector_t iblock,
 	return 0;
 }
 
-static int bget_one(handle_t *handle, struct buffer_head *bh)
+static int bget_one(handle_t *handle, struct inode *inode,
+		    struct buffer_head *bh)
 {
 	get_bh(bh);
 	return 0;
 }
 
-static int bput_one(handle_t *handle, struct buffer_head *bh)
+static int bput_one(handle_t *handle, struct inode *inode,
+		    struct buffer_head *bh)
 {
 	put_bh(bh);
 	return 0;
@@ -1888,7 +1894,7 @@ static int __ext4_journalled_writepage(struct page *page,
 			BUG();
 			goto out;
 		}
-		ext4_walk_page_buffers(handle, page_bufs, 0, len,
+		ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
 				       NULL, bget_one);
 	}
 	/*
@@ -1920,11 +1926,11 @@ static int __ext4_journalled_writepage(struct page *page,
 	if (inline_data) {
 		ret = ext4_mark_inode_dirty(handle, inode);
 	} else {
-		ret = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
-					     do_journal_get_write_access);
+		ret = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
+					     NULL, do_journal_get_write_access);
 
-		err = ext4_walk_page_buffers(handle, page_bufs, 0, len, NULL,
-					     write_end_fn);
+		err = ext4_walk_page_buffers(handle, inode, page_bufs, 0, len,
+					     NULL, write_end_fn);
 	}
 	if (ret == 0)
 		ret = err;
@@ -1941,7 +1947,7 @@ static int __ext4_journalled_writepage(struct page *page,
 	unlock_page(page);
 out_no_pagelock:
 	if (!inline_data && page_bufs)
-		ext4_walk_page_buffers(NULL, page_bufs, 0, len,
+		ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len,
 				       NULL, bput_one);
 	brelse(inode_bh);
 	return ret;
@@ -2031,7 +2037,7 @@ static int ext4_writepage(struct page *page,
 	 * for the extremely common case, this is an optimization that
 	 * skips a useless round trip through ext4_bio_write_page().
 	 */
-	if (ext4_walk_page_buffers(NULL, page_bufs, 0, len, NULL,
+	if (ext4_walk_page_buffers(NULL, inode, page_bufs, 0, len, NULL,
 				   ext4_bh_delay_or_unwritten)) {
 		redirty_page_for_writepage(wbc, page);
 		if ((current->flags & PF_MEMALLOC) ||
@@ -3794,7 +3800,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	}
 	if (ext4_should_journal_data(inode)) {
 		BUFFER_TRACE(bh, "get write access");
-		err = ext4_journal_get_write_access(handle, bh);
+		err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+						    EXT4_JTR_NONE);
 		if (err)
 			goto unlock;
 	}
@@ -5142,7 +5149,9 @@ static int ext4_do_update_inode(handle_t *handle,
 	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
 	if (set_large_file) {
 		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
-		err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
+		err = ext4_journal_get_write_access(handle, sb,
+						    EXT4_SB(sb)->s_sbh,
+						    EXT4_JTR_NONE);
 		if (err)
 			goto out_brelse;
 		lock_buffer(EXT4_SB(sb)->s_sbh);
@@ -5743,7 +5752,8 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 	err = ext4_get_inode_loc(inode, iloc);
 	if (!err) {
 		BUFFER_TRACE(iloc->bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, iloc->bh);
+		err = ext4_journal_get_write_access(handle, inode->i_sb,
+						    iloc->bh, EXT4_JTR_NONE);
 		if (err) {
 			brelse(iloc->bh);
 			iloc->bh = NULL;
@@ -5866,7 +5876,8 @@ int ext4_expand_extra_isize(struct inode *inode,
 	ext4_write_lock_xattr(inode, &no_expand);
 
 	BUFFER_TRACE(iloc->bh, "get_write_access");
-	error = ext4_journal_get_write_access(handle, iloc->bh);
+	error = ext4_journal_get_write_access(handle, inode->i_sb, iloc->bh,
+					      EXT4_JTR_NONE);
 	if (error) {
 		brelse(iloc->bh);
 		goto out_unlock;
@@ -6037,7 +6048,8 @@ int ext4_change_inode_journal_flag(struct inode *inode, int val)
 	return err;
 }
 
-static int ext4_bh_unmapped(handle_t *handle, struct buffer_head *bh)
+static int ext4_bh_unmapped(handle_t *handle, struct inode *inode,
+			    struct buffer_head *bh)
 {
 	return !buffer_mapped(bh);
 }
@@ -6110,7 +6122,7 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	 * inode to the transaction's list to writeprotect pages on commit.
 	 */
 	if (page_has_buffers(page)) {
-		if (!ext4_walk_page_buffers(NULL, page_buffers(page),
+		if (!ext4_walk_page_buffers(NULL, inode, page_buffers(page),
 					    0, len, NULL,
 					    ext4_bh_unmapped)) {
 			/* Wait so that we don't change page under IO */
@@ -6156,11 +6168,13 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 		err = __block_write_begin(page, 0, len, ext4_get_block);
 		if (!err) {
 			ret = VM_FAULT_SIGBUS;
-			if (ext4_walk_page_buffers(handle, page_buffers(page),
-					0, len, NULL, do_journal_get_write_access))
+			if (ext4_walk_page_buffers(handle, inode,
+					page_buffers(page), 0, len, NULL,
+					do_journal_get_write_access))
 				goto out_error;
-			if (ext4_walk_page_buffers(handle, page_buffers(page),
-					0, len, NULL, write_end_fn))
+			if (ext4_walk_page_buffers(handle, inode,
+					page_buffers(page), 0, len, NULL,
+					write_end_fn))
 				goto out_error;
 			if (ext4_jbd2_inode_add_write(handle, inode,
 						      page_offset(page), len))
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 6eed6170aded..20aeff88cab6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1154,7 +1154,9 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 				err = PTR_ERR(handle);
 				goto pwsalt_err_exit;
 			}
-			err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+			err = ext4_journal_get_write_access(handle, sb,
+							    sbi->s_sbh,
+							    EXT4_JTR_NONE);
 			if (err)
 				goto pwsalt_err_journal;
 			lock_buffer(sbi->s_sbh);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 089c958aa2c3..349fabed7e0a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3726,7 +3726,8 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 	}
 
 	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, bitmap_bh);
+	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto out_err;
 
@@ -3739,7 +3740,7 @@ ext4_mb_mark_diskspace_used(struct ext4_allocation_context *ac,
 			ext4_free_group_clusters(sb, gdp));
 
 	BUFFER_TRACE(gdp_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gdp_bh);
+	err = ext4_journal_get_write_access(handle, sb, gdp_bh, EXT4_JTR_NONE);
 	if (err)
 		goto out_err;
 
@@ -5916,7 +5917,8 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, bitmap_bh);
+	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto error_return;
 
@@ -5926,7 +5928,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	 * using it
 	 */
 	BUFFER_TRACE(gd_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gd_bh);
+	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
 	if (err)
 		goto error_return;
 #ifdef AGGRESSIVE_CHECK
@@ -6107,7 +6109,8 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	}
 
 	BUFFER_TRACE(bitmap_bh, "getting write access");
-	err = ext4_journal_get_write_access(handle, bitmap_bh);
+	err = ext4_journal_get_write_access(handle, sb, bitmap_bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto error_return;
 
@@ -6117,7 +6120,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 	 * using it
 	 */
 	BUFFER_TRACE(gd_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gd_bh);
+	err = ext4_journal_get_write_access(handle, sb, gd_bh, EXT4_JTR_NONE);
 	if (err)
 		goto error_return;
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index f3bbcd4efb56..dfb3ae61dfe8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -70,7 +70,8 @@ static struct buffer_head *ext4_append(handle_t *handle,
 	inode->i_size += inode->i_sb->s_blocksize;
 	EXT4_I(inode)->i_disksize = inode->i_size;
 	BUFFER_TRACE(bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+					    EXT4_JTR_NONE);
 	if (err) {
 		brelse(bh);
 		ext4_std_error(inode->i_sb, err);
@@ -1927,12 +1928,14 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
 	}
 
 	BUFFER_TRACE(*bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, *bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, *bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto journal_error;
 
 	BUFFER_TRACE(frame->bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, frame->bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, frame->bh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto journal_error;
 
@@ -2109,7 +2112,8 @@ static int add_dirent_to_buf(handle_t *handle, struct ext4_filename *fname,
 			return err;
 	}
 	BUFFER_TRACE(bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, bh,
+					    EXT4_JTR_NONE);
 	if (err) {
 		ext4_std_error(dir->i_sb, err);
 		return err;
@@ -2167,7 +2171,8 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
 	blocksize =  dir->i_sb->s_blocksize;
 	dxtrace(printk(KERN_DEBUG "Creating index: inode %lu\n", dir->i_ino));
 	BUFFER_TRACE(bh, "get_write_access");
-	retval = ext4_journal_get_write_access(handle, bh);
+	retval = ext4_journal_get_write_access(handle, dir->i_sb, bh,
+					       EXT4_JTR_NONE);
 	if (retval) {
 		ext4_std_error(dir->i_sb, retval);
 		brelse(bh);
@@ -2419,7 +2424,7 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 	}
 
 	BUFFER_TRACE(bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, sb, bh, EXT4_JTR_NONE);
 	if (err)
 		goto journal_error;
 
@@ -2476,7 +2481,8 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 		node2->fake.rec_len = ext4_rec_len_to_disk(sb->s_blocksize,
 							   sb->s_blocksize);
 		BUFFER_TRACE(frame->bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, frame->bh);
+		err = ext4_journal_get_write_access(handle, sb, frame->bh,
+						    EXT4_JTR_NONE);
 		if (err)
 			goto journal_error;
 		if (!add_level) {
@@ -2486,8 +2492,9 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
 				       icount1, icount2));
 
 			BUFFER_TRACE(frame->bh, "get_write_access"); /* index root */
-			err = ext4_journal_get_write_access(handle,
-							     (frame - 1)->bh);
+			err = ext4_journal_get_write_access(handle, sb,
+							    (frame - 1)->bh,
+							    EXT4_JTR_NONE);
 			if (err)
 				goto journal_error;
 
@@ -2636,7 +2643,8 @@ static int ext4_delete_entry(handle_t *handle,
 		csum_size = sizeof(struct ext4_dir_entry_tail);
 
 	BUFFER_TRACE(bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, dir->i_sb, bh,
+					    EXT4_JTR_NONE);
 	if (unlikely(err))
 		goto out;
 
@@ -3088,7 +3096,8 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 		  S_ISLNK(inode->i_mode)) || inode->i_nlink == 0);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto out;
 
@@ -3186,7 +3195,8 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 	if (prev == &sbi->s_orphan) {
 		jbd_debug(4, "superblock will point to %u\n", ino_next);
 		BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+		err = ext4_journal_get_write_access(handle, inode->i_sb,
+						    sbi->s_sbh, EXT4_JTR_NONE);
 		if (err) {
 			mutex_unlock(&sbi->s_orphan_lock);
 			goto out_brelse;
@@ -3675,7 +3685,8 @@ static int ext4_rename_dir_prepare(handle_t *handle, struct ext4_renament *ent)
 	if (le32_to_cpu(ent->parent_de->inode) != ent->dir->i_ino)
 		return -EFSCORRUPTED;
 	BUFFER_TRACE(ent->dir_bh, "get_write_access");
-	return ext4_journal_get_write_access(handle, ent->dir_bh);
+	return ext4_journal_get_write_access(handle, ent->dir->i_sb,
+					     ent->dir_bh, EXT4_JTR_NONE);
 }
 
 static int ext4_rename_dir_finish(handle_t *handle, struct ext4_renament *ent,
@@ -3710,7 +3721,8 @@ static int ext4_setent(handle_t *handle, struct ext4_renament *ent,
 	int retval, retval2;
 
 	BUFFER_TRACE(ent->bh, "get write access");
-	retval = ext4_journal_get_write_access(handle, ent->bh);
+	retval = ext4_journal_get_write_access(handle, ent->dir->i_sb, ent->bh,
+					       EXT4_JTR_NONE);
 	if (retval)
 		return retval;
 	ent->de->inode = cpu_to_le32(ino);
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 7a9f1adef679..b63cb88ccdae 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -409,7 +409,8 @@ static struct buffer_head *bclean(handle_t *handle, struct super_block *sb,
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 	BUFFER_TRACE(bh, "get_write_access");
-	if ((err = ext4_journal_get_write_access(handle, bh))) {
+	err = ext4_journal_get_write_access(handle, sb, bh, EXT4_JTR_NONE);
+	if (err) {
 		brelse(bh);
 		bh = ERR_PTR(err);
 	} else {
@@ -474,7 +475,8 @@ static int set_flexbg_block_bitmap(struct super_block *sb, handle_t *handle,
 			return -ENOMEM;
 
 		BUFFER_TRACE(bh, "get_write_access");
-		err = ext4_journal_get_write_access(handle, bh);
+		err = ext4_journal_get_write_access(handle, sb, bh,
+						    EXT4_JTR_NONE);
 		if (err) {
 			brelse(bh);
 			return err;
@@ -569,7 +571,8 @@ static int setup_new_flex_group_blocks(struct super_block *sb,
 			}
 
 			BUFFER_TRACE(gdb, "get_write_access");
-			err = ext4_journal_get_write_access(handle, gdb);
+			err = ext4_journal_get_write_access(handle, sb, gdb,
+							    EXT4_JTR_NONE);
 			if (err) {
 				brelse(gdb);
 				goto out;
@@ -837,17 +840,18 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	}
 
 	BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, EXT4_SB(sb)->s_sbh,
+					    EXT4_JTR_NONE);
 	if (unlikely(err))
 		goto errout;
 
 	BUFFER_TRACE(gdb_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gdb_bh);
+	err = ext4_journal_get_write_access(handle, sb, gdb_bh, EXT4_JTR_NONE);
 	if (unlikely(err))
 		goto errout;
 
 	BUFFER_TRACE(dind, "get_write_access");
-	err = ext4_journal_get_write_access(handle, dind);
+	err = ext4_journal_get_write_access(handle, sb, dind, EXT4_JTR_NONE);
 	if (unlikely(err)) {
 		ext4_std_error(sb, err);
 		goto errout;
@@ -956,7 +960,7 @@ static int add_new_gdb_meta_bg(struct super_block *sb,
 	n_group_desc[gdb_num] = gdb_bh;
 
 	BUFFER_TRACE(gdb_bh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, gdb_bh);
+	err = ext4_journal_get_write_access(handle, sb, gdb_bh, EXT4_JTR_NONE);
 	if (err) {
 		kvfree(n_group_desc);
 		brelse(gdb_bh);
@@ -1042,7 +1046,8 @@ static int reserve_backup_gdb(handle_t *handle, struct inode *inode,
 
 	for (i = 0; i < reserved_gdb; i++) {
 		BUFFER_TRACE(primary[i], "get_write_access");
-		if ((err = ext4_journal_get_write_access(handle, primary[i])))
+		if ((err = ext4_journal_get_write_access(handle, sb, primary[i],
+							 EXT4_JTR_NONE)))
 			goto exit_bh;
 	}
 
@@ -1149,10 +1154,9 @@ static void update_backups(struct super_block *sb, sector_t blk_off, char *data,
 			   backup_block, backup_block -
 			   ext4_group_first_block_no(sb, group));
 		BUFFER_TRACE(bh, "get_write_access");
-		if ((err = ext4_journal_get_write_access(handle, bh))) {
-			brelse(bh);
+		if ((err = ext4_journal_get_write_access(handle, sb, bh,
+							 EXT4_JTR_NONE)))
 			break;
-		}
 		lock_buffer(bh);
 		memcpy(bh->b_data, data, size);
 		if (rest)
@@ -1232,7 +1236,8 @@ static int ext4_add_new_descs(handle_t *handle, struct super_block *sb,
 			gdb_bh = sbi_array_rcu_deref(sbi, s_group_desc,
 						     gdb_num);
 			BUFFER_TRACE(gdb_bh, "get_write_access");
-			err = ext4_journal_get_write_access(handle, gdb_bh);
+			err = ext4_journal_get_write_access(handle, sb, gdb_bh,
+							    EXT4_JTR_NONE);
 
 			if (!err && reserved_gdb && ext4_bg_num_gdb(sb, group))
 				err = reserve_backup_gdb(handle, resize_inode, group);
@@ -1509,7 +1514,8 @@ static int ext4_flex_group_add(struct super_block *sb,
 	}
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto exit_journal;
 
@@ -1722,7 +1728,8 @@ static int ext4_group_extend_no_check(struct super_block *sb,
 	}
 
 	BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, EXT4_SB(sb)->s_sbh,
+					    EXT4_JTR_NONE);
 	if (err) {
 		ext4_warning(sb, "error %d on journal write access", err);
 		goto errout;
@@ -1884,7 +1891,8 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 		return PTR_ERR(handle);
 
 	BUFFER_TRACE(sbi->s_sbh, "get_write_access");
-	err = ext4_journal_get_write_access(handle, sbi->s_sbh);
+	err = ext4_journal_get_write_access(handle, sb, sbi->s_sbh,
+					    EXT4_JTR_NONE);
 	if (err)
 		goto errout;
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index dfa09a277b56..61fcea9dce3d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4014,6 +4014,20 @@ static const char *ext4_quota_mode(struct super_block *sb)
 #endif
 }
 
+static void ext4_setup_csum_trigger(struct super_block *sb,
+				    enum ext4_journal_trigger_type type,
+				    void (*trigger)(
+					struct jbd2_buffer_trigger_type *type,
+					struct buffer_head *bh,
+					void *mapped_data,
+					size_t size))
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	sbi->s_journal_triggers[type].sb = sb;
+	sbi->s_journal_triggers[type].tr_triggers.t_frozen = trigger;
+}
+
 static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct dax_device *dax_dev = fs_dax_get_by_bdev(sb->s_bdev);
@@ -6609,7 +6623,7 @@ static ssize_t ext4_quota_write(struct super_block *sb, int type,
 	if (!bh)
 		goto out;
 	BUFFER_TRACE(bh, "get write access");
-	err = ext4_journal_get_write_access(handle, bh);
+	err = ext4_journal_get_write_access(handle, sb, bh, EXT4_JTR_NONE);
 	if (err) {
 		brelse(bh);
 		return err;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 6dd5c05c444a..1e0fc1ed845b 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -791,7 +791,8 @@ static void ext4_xattr_update_super_block(handle_t *handle,
 		return;
 
 	BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get_write_access");
-	if (ext4_journal_get_write_access(handle, EXT4_SB(sb)->s_sbh) == 0) {
+	if (ext4_journal_get_write_access(handle, sb, EXT4_SB(sb)->s_sbh,
+					  EXT4_JTR_NONE) == 0) {
 		lock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_set_feature_xattr(sb);
 		ext4_superblock_csum_set(sb);
@@ -1169,7 +1170,8 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 			continue;
 		}
 		if (err > 0) {
-			err = ext4_journal_get_write_access(handle, bh);
+			err = ext4_journal_get_write_access(handle,
+					parent->i_sb, bh, EXT4_JTR_NONE);
 			if (err) {
 				ext4_warning_inode(ea_inode,
 						"Re-get write access err=%d",
@@ -1230,7 +1232,8 @@ ext4_xattr_release_block(handle_t *handle, struct inode *inode,
 	int error = 0;
 
 	BUFFER_TRACE(bh, "get_write_access");
-	error = ext4_journal_get_write_access(handle, bh);
+	error = ext4_journal_get_write_access(handle, inode->i_sb, bh,
+					      EXT4_JTR_NONE);
 	if (error)
 		goto out;
 
@@ -1371,7 +1374,8 @@ static int ext4_xattr_inode_write(handle_t *handle, struct inode *ea_inode,
 					 "ext4_getblk() return bh = NULL");
 			return -EFSCORRUPTED;
 		}
-		ret = ext4_journal_get_write_access(handle, bh);
+		ret = ext4_journal_get_write_access(handle, ea_inode->i_sb, bh,
+						   EXT4_JTR_NONE);
 		if (ret)
 			goto out;
 
@@ -1855,7 +1859,8 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 
 	if (s->base) {
 		BUFFER_TRACE(bs->bh, "get_write_access");
-		error = ext4_journal_get_write_access(handle, bs->bh);
+		error = ext4_journal_get_write_access(handle, sb, bs->bh,
+						      EXT4_JTR_NONE);
 		if (error)
 			goto cleanup;
 		lock_buffer(bs->bh);
@@ -1987,8 +1992,9 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				if (error)
 					goto cleanup;
 				BUFFER_TRACE(new_bh, "get_write_access");
-				error = ext4_journal_get_write_access(handle,
-								      new_bh);
+				error = ext4_journal_get_write_access(
+						handle, sb, new_bh,
+						EXT4_JTR_NONE);
 				if (error)
 					goto cleanup_dquot;
 				lock_buffer(new_bh);
@@ -2092,7 +2098,8 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 			}
 
 			lock_buffer(new_bh);
-			error = ext4_journal_get_create_access(handle, new_bh);
+			error = ext4_journal_get_create_access(handle, sb,
+							new_bh, EXT4_JTR_NONE);
 			if (error) {
 				unlock_buffer(new_bh);
 				error = -EIO;
@@ -2848,7 +2855,8 @@ int ext4_xattr_delete_inode(handle_t *handle, struct inode *inode,
 			goto cleanup;
 		}
 
-		error = ext4_journal_get_write_access(handle, iloc.bh);
+		error = ext4_journal_get_write_access(handle, inode->i_sb,
+						iloc.bh, EXT4_JTR_NONE);
 		if (error) {
 			EXT4_ERROR_INODE(inode, "write access (error %d)",
 					 error);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 8804e126805f..707f92d78c69 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1404,7 +1404,7 @@ void jbd2_journal_set_triggers(struct buffer_head *bh,
 {
 	struct journal_head *jh = jbd2_journal_grab_journal_head(bh);
 
-	if (WARN_ON(!jh))
+	if (WARN_ON_ONCE(!jh))
 		return;
 	jh->b_triggers = type;
 	jbd2_journal_put_journal_head(jh);
-- 
2.26.2

