Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB52D6447
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 19:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392460AbgLJSAk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392986AbgLJR5W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:22 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C41C061257
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:46 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u4so3144411plr.12
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D+OxFsStV5aI0ereJRg6ySSMVrQ7VbkMxafjZEWait4=;
        b=kmv2DmiJRAAuAZkjsIKOrI3pBnjSTG1X+0kB4wiCQClcq+cp3PGu+52VEFQWkKV3+o
         c2ijvyUvs4dON0TLhOhDtkVS4nM0XVgwHzih7dr4BYWiqI/2YA7rXe9Fh6qvxPHX/WbH
         jJXx2gpWOXiBb6eSKmnDNUgEk99PtbIqhTGdwGBoEVe9DGyYB8jZFtLcyeU7+zpQAVhP
         9mMDDU83O5Iy8+lVSsHKxl3N4Y2BfnDoW4GjHscJ+Ky0Vy578E8RDUe1maTZCIzi8omF
         U8ouRmMeLDilzXT9PFSSB7r9SdoatBD2AUP6TeDkuFyx2bB7qASjvulkm0SdSp/ji9zH
         ysLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D+OxFsStV5aI0ereJRg6ySSMVrQ7VbkMxafjZEWait4=;
        b=ZIQEK8e19bA1YFyyz+yUcZuD0GXnTQmRps9t+h09U2Axvt6Ko+YaJlxpb6Z1EflJ6c
         XRkFIL0VITmLBtsaPgEHCI5JL0F0qO8eQT/r4zZ9lyPG0pdai3d4wwn9zIjA/dWf4Df5
         ZQxz5ltHe1n9o0zcB/mDIXDljV5tyW0yei7BQrv+MgMnPg50PvfCYmTEjCHpjqH0mp8X
         YkuLSk/QrSqteq2M1WUCmyZNMl/P4zrGLtmuN1gGzvPixQV2DRo4EwK5m3yNDa0bcOU7
         3h9HqVu4TB/KO0BvhYjWfp2t3tR5uMN9Cg0WIxy+jK5PFygD39mH6FvfHkGStD90Cfc1
         UMlA==
X-Gm-Message-State: AOAM532GZlc8nGZOn5YXVzzTT5fS2DWBgn7RItV5fuWbyRLq0awk9GqU
        HsF5fuzU3LID+AmBtkbFsKmNzcxlqQc=
X-Google-Smtp-Source: ABdhPJxjqAzqN585WqRjx4saqfH8Oe9jJCSPSnY/lvOGBYF1upAIjZ9b5Ny9IuqL24o/4a9pPSWTZg==
X-Received: by 2002:a17:902:8e87:b029:d8:e26a:77ea with SMTP id bg7-20020a1709028e87b02900d8e26a77eamr7575743plb.18.1607623005452;
        Thu, 10 Dec 2020 09:56:45 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:44 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 07/15] e2fsck: add function to rewrite extent tree
Date:   Thu, 10 Dec 2020 09:56:00 -0800
Message-Id: <20201210175608.3265541-8-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Fast commit replay needs to rewrite the entire extent tree for inodes
found in fast commit area. This patch makes e2fsck's rewrite extent
tree path visible.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 e2fsck/e2fsck.h  |  16 +++++
 e2fsck/extents.c | 168 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 124 insertions(+), 60 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 85f953b2..3b9c1874 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -226,6 +226,19 @@ typedef struct e2fsck_struct *e2fsck_t;
 
 #define MAX_EXTENT_DEPTH_COUNT 5
 
+/*
+ * This strucutre is used to manage the list of extents in a file. Placing
+ * it here since this is used by fast_commit.h.
+ */
+struct extent_list {
+	blk64_t blocks_freed;
+	struct ext2fs_extent *extents;
+	unsigned int count;
+	unsigned int size;
+	unsigned int ext_read;
+	errcode_t retval;
+	ext2_ino_t ino;
+};
 struct e2fsck_struct {
 	ext2_filsys fs;
 	const char *program_name;
@@ -536,6 +549,9 @@ errcode_t e2fsck_should_rebuild_extents(e2fsck_t ctx,
 					struct problem_context *pctx,
 					struct extent_tree_info *eti,
 					struct ext2_extent_info *info);
+errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents);
+errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx,
+				     struct extent_list *extents);
 
 /* journal.c */
 extern errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx);
diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index e9139326..d6c74834 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -58,16 +58,6 @@ int e2fsck_ino_will_be_rebuilt(e2fsck_t ctx, ext2_ino_t ino)
 	return ext2fs_test_inode_bitmap2(ctx->inodes_to_rebuild, ino);
 }
 
-struct extent_list {
-	blk64_t blocks_freed;
-	struct ext2fs_extent *extents;
-	unsigned int count;
-	unsigned int size;
-	unsigned int ext_read;
-	errcode_t retval;
-	ext2_ino_t ino;
-};
-
 static errcode_t load_extents(e2fsck_t ctx, struct extent_list *list)
 {
 	ext2_filsys		fs = ctx->fs;
@@ -206,66 +196,40 @@ static int find_blocks(ext2_filsys fs, blk64_t *blocknr, e2_blkcnt_t blockcnt,
 	return 0;
 }
 
-static errcode_t rebuild_extent_tree(e2fsck_t ctx, struct extent_list *list,
-				     ext2_ino_t ino)
+errcode_t rewrite_extent_replay(e2fsck_t ctx, struct extent_list *list,
+				       struct ext2_inode_large *inode)
 {
-	struct ext2_inode_large	inode;
 	errcode_t		retval;
 	ext2_extent_handle_t	handle;
 	unsigned int		i, ext_written;
 	struct ext2fs_extent	*ex, extent;
-	blk64_t			start_val, delta;
-
-	list->count = 0;
-	list->blocks_freed = 0;
-	list->ino = ino;
-	list->ext_read = 0;
-	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode), sizeof(inode),
-			       "rebuild_extents");
+	blk64_t			start_val, delta, blkcount;
 
-	/* Skip deleted inodes and inline data files */
-	if (inode.i_links_count == 0 ||
-	    inode.i_flags & EXT4_INLINE_DATA_FL)
-		return 0;
-
-	/* Collect lblk->pblk mappings */
-	if (inode.i_flags & EXT4_EXTENTS_FL) {
-		retval = load_extents(ctx, list);
-		if (retval)
-			goto err;
-		goto extents_loaded;
-	}
-
-	retval = ext2fs_block_iterate3(ctx->fs, ino, BLOCK_FLAG_READ_ONLY, 0,
-				       find_blocks, list);
-	if (retval)
-		goto err;
-	if (list->retval) {
-		retval = list->retval;
-		goto err;
-	}
-
-extents_loaded:
 	/* Reset extent tree */
-	inode.i_flags &= ~EXT4_EXTENTS_FL;
-	memset(inode.i_block, 0, sizeof(inode.i_block));
+	inode->i_flags &= ~EXT4_EXTENTS_FL;
+	memset(inode->i_block, 0, sizeof(inode->i_block));
 
 	/* Make a note of freed blocks */
-	quota_data_sub(ctx->qctx, &inode, ino,
+	quota_data_sub(ctx->qctx, inode, list->ino,
 		       list->blocks_freed * ctx->fs->blocksize);
-	retval = ext2fs_iblk_sub_blocks(ctx->fs, EXT2_INODE(&inode),
+	retval = ext2fs_iblk_sub_blocks(ctx->fs, EXT2_INODE(inode),
 					list->blocks_freed);
 	if (retval)
-		goto err;
+		return retval;
 
 	/* Now stuff extents into the file */
-	retval = ext2fs_extent_open2(ctx->fs, ino, EXT2_INODE(&inode), &handle);
+	retval = ext2fs_extent_open2(ctx->fs, list->ino, EXT2_INODE(inode),
+					&handle);
 	if (retval)
-		goto err;
+		return retval;
 
 	ext_written = 0;
-	start_val = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode));
+
+	start_val = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(inode));
+
 	for (i = 0, ex = list->extents; i < list->count; i++, ex++) {
+		if (ex->e_len == 0)
+			continue;
 		memcpy(&extent, ex, sizeof(struct ext2fs_extent));
 		extent.e_flags &= EXT2_EXTENT_FLAGS_UNINIT;
 		if (extent.e_flags & EXT2_EXTENT_FLAGS_UNINIT) {
@@ -289,36 +253,120 @@ extents_loaded:
 		}
 
 #ifdef DEBUG
-		printf("W: ino=%d pblk=%llu lblk=%llu len=%u\n", ino,
+		printf("W: ino=%d pblk=%llu lblk=%llu len=%u\n", list->ino,
 				extent.e_pblk, extent.e_lblk, extent.e_len);
 #endif
 		retval = ext2fs_extent_insert(handle, EXT2_EXTENT_INSERT_AFTER,
 					      &extent);
 		if (retval)
-			goto err2;
+			goto err;
 		retval = ext2fs_extent_fix_parents(handle);
 		if (retval)
-			goto err2;
+			goto err;
 		ext_written++;
 	}
 
-	delta = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(&inode)) -
+	delta = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(inode)) -
 		start_val;
 	if (delta)
-		quota_data_add(ctx->qctx, &inode, ino, delta << 9);
+		quota_data_add(ctx->qctx, inode, list->ino, delta << 9);
 
 #if defined(DEBUG) || defined(DEBUG_SUMMARY)
 	printf("rebuild: ino=%d extents=%d->%d\n", ino, list->ext_read,
 	       ext_written);
 #endif
-	e2fsck_write_inode(ctx, ino, EXT2_INODE(&inode), "rebuild_extents");
+	e2fsck_write_inode(ctx, list->ino, EXT2_INODE(inode),
+				"rebuild_extents");
 
-err2:
-	ext2fs_extent_free(handle);
 err:
+	ext2fs_extent_free(handle);
+	return retval;
+}
+
+errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list)
+{
+	struct ext2_inode_large inode;
+	int ret;
+
+	memset(&inode, 0, sizeof(inode));
+	ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+				sizeof(inode));
+
+	/* Skip deleted inodes and inline data files */
+	if (inode.i_flags & EXT4_INLINE_DATA_FL)
+		return 0;
+
+	ret = rewrite_extent_replay(ctx, list, &inode);
+	ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode),
+		ext2fs_count_blocks(ctx->fs, list->ino, EXT2_INODE(&inode)));
+	ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+		sizeof(inode));
+
+	return ret;
+}
+
+errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents)
+{
+	struct ext2_inode_large	inode;
+	errcode_t		retval;
+
+	extents->extents = NULL;
+	extents->count = 0;
+	extents->blocks_freed = 0;
+	extents->ext_read = 0;
+	extents->size = NUM_EXTENTS;
+	retval = ext2fs_get_array(NUM_EXTENTS, sizeof(struct ext2fs_extent),
+				  &extents->extents);
+	if (retval)
+		return -ENOMEM;
+
+	retval = ext2fs_read_inode(ctx->fs, extents->ino, EXT2_INODE(&inode));
+	if (retval)
+		goto err_out;
+
+	retval = load_extents(ctx, extents);
+	if (!retval)
+		return 0;
+err_out:
+	ext2fs_free_mem(&extents->extents);
+	extents->size = 0;
+	extents->count = 0;
 	return retval;
 }
 
+static errcode_t rebuild_extent_tree(e2fsck_t ctx, struct extent_list *list,
+				     ext2_ino_t ino)
+{
+	struct ext2_inode_large	inode;
+	errcode_t		retval;
+
+	list->count = 0;
+	list->blocks_freed = 0;
+	list->ino = ino;
+	list->ext_read = 0;
+	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode), sizeof(inode),
+			       "rebuild_extents");
+
+	/* Skip deleted inodes and inline data files */
+	if (inode.i_links_count == 0 ||
+	    inode.i_flags & EXT4_INLINE_DATA_FL)
+		return 0;
+
+	/* Collect lblk->pblk mappings */
+	if (inode.i_flags & EXT4_EXTENTS_FL) {
+		retval = load_extents(ctx, list);
+		if (retval)
+			return retval;
+		return rewrite_extent_replay(ctx, list, &inode);
+	}
+
+	retval = ext2fs_block_iterate3(ctx->fs, ino, BLOCK_FLAG_READ_ONLY, 0,
+				       find_blocks, list);
+
+	return retval || list->retval ||
+		rewrite_extent_replay(ctx, list, &inode);
+}
+
 /* Rebuild the extents immediately */
 static errcode_t e2fsck_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino)
 {
-- 
2.29.2.576.ga3fc446d84-goog

