Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28DF2FFC51
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 06:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbhAVFpu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 00:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbhAVFpq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 00:45:46 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE8DC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:21 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id i5so2978411pgo.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Jan 2021 21:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7EM4qh/OMmz07Fk/eZ3w/PAGmxE3PDewu/JmbFYI+w=;
        b=gMSRsa2/ddaXtxIWwFCLvws54riD29ShplCgtII5zPwbDPd/YQUG9UCRUbgCAIX/SB
         dutkz0A8Ub4HshLjQgpNL1vOpNSsRErP1O1Z/wy/Hn3Fq37PK+uOIcVZMBbc//vbGfv5
         Xx7y+9CORFjyPLn6iBYE5rfe5EKJtJpK38T/d/kTLMhJq/oUfBRlFuwZTUmsicTVaFJ8
         NmRbgYHI/JRATXPrJObLf+7uuozslzcQSGzzYlXsPZPk/wgkut6cI3Nr4Q/R4nehjqMR
         dnhX4BE7/u5iPD2gr2c99dw0Ak9mu4krMsNMZfGtiR/kqwvF0kmiobjYb23qfyYGI2XI
         Vg+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7EM4qh/OMmz07Fk/eZ3w/PAGmxE3PDewu/JmbFYI+w=;
        b=jydvMpoaPoGUqRmO6SlkOeB3VkSByH2U7wZg4bdrc5pSanFh6Sg12mgHBCFrKrQrIE
         2HCPIjeisdyQteAmwl2zubw+xApTLyJo0nLL5r/kU6Hh9EjT1tUdTpw9FWeQSCQ8BtY5
         pBFUsrn6pXAnFhoQdikDlv70TnAMhhnrsE0RA6CiWPaDA+cUKC8MocYIdqWi6vH3b6LM
         aWA1QsBSXNhqn7SENO+VJQ9Wah7MUC+5hWQIP54Im4mr1PgM8qPRvLGYmNMyW14R1p3b
         XYfi5JUMSFVfEcJiQQ3HhBqJwY8fU3XpsTllet8UJv33q7SdwedBWVAv6g/5HOOz5c08
         2Lpw==
X-Gm-Message-State: AOAM532XHSQ4Ws+aLnSNmVz3KWxfJhOYJYEkzLkf0kmWOwvbnKcTpIRL
        Z3A+CpaZXTqCaJE9SaYs//fRSRH4cB4=
X-Google-Smtp-Source: ABdhPJyWnvzaTOXzq/D1Krtv6bIiHxkka9FBeS5z5REQSYRq0GH9/R1gMPzEpQXJNGywy8J3b1OcrQ==
X-Received: by 2002:a17:90a:31cb:: with SMTP id j11mr3473209pjf.6.1611294320770;
        Thu, 21 Jan 2021 21:45:20 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id gg6sm12245827pjb.2.2021.01.21.21.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:45:19 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <--global>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 2/8] e2fsck: add function to rewrite extent tree
Date:   Thu, 21 Jan 2021 21:44:58 -0800
Message-Id: <20210122054504.1498532-3-user@harshads-520.kir.corp.google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
References: <20210122054504.1498532-1-user@harshads-520.kir.corp.google.com>
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
 e2fsck/extents.c | 175 +++++++++++++++++++++++++++++++----------------
 2 files changed, 131 insertions(+), 60 deletions(-)

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
index e9139326..600dbc97 100644
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
-
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
+	blk64_t			start_val, delta, blkcount;
 
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
@@ -289,36 +253,127 @@ extents_loaded:
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
 	return retval;
 }
 
+errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list)
+{
+	struct ext2_inode_large inode;
+	blk64_t blk_count;
+	errcode_t err;
+
+	memset(&inode, 0, sizeof(inode));
+	ext2fs_read_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+				sizeof(inode));
+
+	/* Skip deleted inodes and inline data files */
+	if (inode.i_flags & EXT4_INLINE_DATA_FL)
+		return 0;
+
+	err = rewrite_extent_replay(ctx, list, &inode);
+	if (err)
+		return err;
+
+	err = ext2fs_count_blocks(ctx->fs, list->ino, EXT2_INODE(&inode),
+				  &blk_count);
+	if (err)
+		return err;
+	ext2fs_iblk_set(ctx->fs, EXT2_INODE(&inode), blk_count);
+	ext2fs_write_inode_full(ctx->fs, list->ino, EXT2_INODE(&inode),
+		sizeof(inode));
+
+	return 0;
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
+	return retval;
+}
+
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
2.30.0.280.ga3ce27912f-goog

