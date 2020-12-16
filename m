Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB522DBE86
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 11:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgLPKUN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Dec 2020 05:20:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:49052 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgLPKUN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Dec 2020 05:20:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8E6CAF31;
        Wed, 16 Dec 2020 10:18:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EC4281E136E; Wed, 16 Dec 2020 11:18:49 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] ext4: Drop ext4_handle_dirty_super()
Date:   Wed, 16 Dec 2020 11:18:44 +0100
Message-Id: <20201216101844.22917-9-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201216101844.22917-1-jack@suse.cz>
References: <20201216101844.22917-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The wrapper is now useless since it does what
ext4_handle_dirty_metadata() does. Just remove it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4_jbd2.c | 16 ----------------
 fs/ext4/ext4_jbd2.h |  5 -----
 fs/ext4/file.c      |  2 +-
 fs/ext4/inode.c     |  3 ++-
 fs/ext4/namei.c     |  4 ++--
 fs/ext4/resize.c    |  8 ++++----
 fs/ext4/xattr.c     |  2 +-
 7 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index c7e410c4ab7d..be799040a415 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -372,19 +372,3 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 	}
 	return err;
 }
-
-int __ext4_handle_dirty_super(const char *where, unsigned int line,
-			      handle_t *handle, struct super_block *sb)
-{
-	struct buffer_head *bh = EXT4_SB(sb)->s_sbh;
-	int err = 0;
-
-	if (ext4_handle_valid(handle)) {
-		err = jbd2_journal_dirty_metadata(handle, bh);
-		if (err)
-			ext4_journal_abort_handle(where, line, __func__,
-						  bh, handle, err);
-	} else
-		mark_buffer_dirty(bh);
-	return err;
-}
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 00dc668e052b..b9881ee1bf93 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -247,9 +247,6 @@ int __ext4_handle_dirty_metadata(const char *where, unsigned int line,
 				 handle_t *handle, struct inode *inode,
 				 struct buffer_head *bh);
 
-int __ext4_handle_dirty_super(const char *where, unsigned int line,
-			      handle_t *handle, struct super_block *sb);
-
 #define ext4_journal_get_write_access(handle, bh) \
 	__ext4_journal_get_write_access(__func__, __LINE__, (handle), (bh))
 #define ext4_forget(handle, is_metadata, inode, bh, block_nr) \
@@ -260,8 +257,6 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
 #define ext4_handle_dirty_metadata(handle, inode, bh) \
 	__ext4_handle_dirty_metadata(__func__, __LINE__, (handle), (inode), \
 				     (bh))
-#define ext4_handle_dirty_super(handle, sb) \
-	__ext4_handle_dirty_super(__func__, __LINE__, (handle), (sb))
 
 handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 				  int type, int blocks, int rsv_blocks,
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 26907d5835d0..1cd3d26e3217 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -814,7 +814,7 @@ static int ext4_sample_last_mounted(struct super_block *sb,
 		sizeof(sbi->s_es->s_last_mounted));
 	ext4_superblock_csum_set(sb);
 	unlock_buffer(sbi->s_sbh);
-	ext4_handle_dirty_super(handle, sb);
+	ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 out_journal:
 	ext4_journal_stop(handle);
 out:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 777eb08b29cd..a1baa6084db3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5155,7 +5155,8 @@ static int ext4_do_update_inode(handle_t *handle,
 		ext4_superblock_csum_set(sb);
 		unlock_buffer(EXT4_SB(sb)->s_sbh);
 		ext4_handle_sync(handle);
-		err = ext4_handle_dirty_super(handle, sb);
+		err = ext4_handle_dirty_metadata(handle, NULL,
+						 EXT4_SB(sb)->s_sbh);
 	}
 	ext4_update_inode_fsync_trans(handle, inode, need_datasync);
 out_brelse:
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d804505e1a32..c1ec073551ba 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2992,7 +2992,7 @@ int ext4_orphan_add(handle_t *handle, struct inode *inode)
 	mutex_unlock(&sbi->s_orphan_lock);
 
 	if (dirty) {
-		err = ext4_handle_dirty_super(handle, sb);
+		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 		rc = ext4_mark_iloc_dirty(handle, inode, &iloc);
 		if (!err)
 			err = rc;
@@ -3073,7 +3073,7 @@ int ext4_orphan_del(handle_t *handle, struct inode *inode)
 		ext4_superblock_csum_set(inode->i_sb);
 		unlock_buffer(sbi->s_sbh);
 		mutex_unlock(&sbi->s_orphan_lock);
-		err = ext4_handle_dirty_super(handle, inode->i_sb);
+		err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 	} else {
 		struct ext4_iloc iloc2;
 		struct inode *i_prev =
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 6155f2b9538c..bd0d185654f3 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -903,7 +903,7 @@ static int add_new_gdb(handle_t *handle, struct inode *inode,
 	le16_add_cpu(&es->s_reserved_gdt_blocks, -1);
 	ext4_superblock_csum_set(sb);
 	unlock_buffer(EXT4_SB(sb)->s_sbh);
-	err = ext4_handle_dirty_super(handle, sb);
+	err = ext4_handle_dirty_metadata(handle, NULL, EXT4_SB(sb)->s_sbh);
 	if (err)
 		ext4_std_error(sb, err);
 	return err;
@@ -1521,7 +1521,7 @@ static int ext4_flex_group_add(struct super_block *sb,
 
 	ext4_update_super(sb, flex_gd);
 
-	err = ext4_handle_dirty_super(handle, sb);
+	err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 
 exit_journal:
 	err2 = ext4_journal_stop(handle);
@@ -1734,7 +1734,7 @@ static int ext4_group_extend_no_check(struct super_block *sb,
 	err = ext4_group_add_blocks(handle, sb, o_blocks_count, add);
 	if (err)
 		goto errout;
-	ext4_handle_dirty_super(handle, sb);
+	ext4_handle_dirty_metadata(handle, NULL, EXT4_SB(sb)->s_sbh);
 	ext4_debug("freed blocks %llu through %llu\n", o_blocks_count,
 		   o_blocks_count + add);
 errout:
@@ -1891,7 +1891,7 @@ static int ext4_convert_meta_bg(struct super_block *sb, struct inode *inode)
 	ext4_superblock_csum_set(sb);
 	unlock_buffer(sbi->s_sbh);
 
-	err = ext4_handle_dirty_super(handle, sb);
+	err = ext4_handle_dirty_metadata(handle, NULL, sbi->s_sbh);
 	if (err) {
 		ext4_std_error(sb, err);
 		goto errout;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index ab46aa447baa..a236e606fa95 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -796,7 +796,7 @@ static void ext4_xattr_update_super_block(handle_t *handle,
 		ext4_set_feature_xattr(sb);
 		ext4_superblock_csum_set(sb);
 		unlock_buffer(EXT4_SB(sb)->s_sbh);
-		ext4_handle_dirty_super(handle, sb);
+		ext4_handle_dirty_metadata(handle, NULL, EXT4_SB(sb)->s_sbh);
 	}
 }
 
-- 
2.16.4

