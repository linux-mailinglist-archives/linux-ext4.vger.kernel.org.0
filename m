Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04718C3C7
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbgCSXez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:55 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:37872 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgCSXey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:54 -0400
Received: by mail-pj1-f66.google.com with SMTP id ca13so1682760pjb.2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oen5NA9RLjhbwmLZvofgZ+fwd5jtfW269Vg4wwnl8xE=;
        b=Ja3Y9iQ6Tn58S4jKkp2LN+WkVmNa91Fen0G/l94S38QtPIHt0qXpV84VQK2vpXCUFl
         RImGqpDwsU8IdIgv8g8OKb7O2dPH6v5FMkfI/d0O6jR3G7x7TnJTBLkDqnjNSyiPdRdF
         3KpeM/hPNV9yj0P1HF7e1EWoNxuMd1e9CQhrkFGQPz8BmTvrZtHvWvjxF3Nriww32PHD
         NI4/jENiPHioy9taOTCk+w9zag+HurJxrl4j2wUDSZV1BwtVKJdOjI4g1fivKbDy1RdQ
         CtqS8fgG0EAJaOmIqKVDCAZKMYIzguG8GSrxp7RAuTDDB0if6vXndOLcbHylZT9q0BDI
         MIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oen5NA9RLjhbwmLZvofgZ+fwd5jtfW269Vg4wwnl8xE=;
        b=O7IPKMF9Y7YG7zqkQkvAETqHsU+zHeHF0jK0VxSacludAO82skgAkrwb6zf5/7IPTp
         O67k5BH67Pv72C9vOI7v6UsxRnS+px25wqhVlueard6hNKGVtw7DnbBNfN3ulFvm+6Ab
         Hq3x3RyDP1tWXPFT2k7n3C+QTGhtEIchlypfV3ct0ABrNhEAweJ0YQJgRz+AMq6sIikI
         QT6/pxH37qd86aTE46CPB3K4ZcOF7O3dXcQZSfq0gDsgqChPBIPVIpa+bSndRYcIPtW4
         GdOeGTO0XTyshHO3agKdhog13/eKyFtVNv+ds5vHZgU36JjWCYq/gVwfZIXWgMhKuatY
         zstA==
X-Gm-Message-State: ANhLgQ2ILNK2/LfpgxG08qy/LF8OP1bJg+Pi1Gcwkz8tHbLMcZHUX7dN
        19I6AWd2GE9xeygTfrE6WveM08l+
X-Google-Smtp-Source: ADFU+vuMZduTnAdf0Ml6VDvhLRl4aad5lPL+j5KyAd8P+Tb/vuztb6erwzlUglfzPpR8LGdOmxhFDQ==
X-Received: by 2002:a17:90a:62cb:: with SMTP id k11mr6528215pjs.20.1584660892382;
        Thu, 19 Mar 2020 16:34:52 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:51 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 2/7] e2fsck: allow rewriting extents of a file
Date:   Thu, 19 Mar 2020 16:34:28 -0700
Message-Id: <20200319233433.117144-3-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
References: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add a new function e2fsck_rewrite_extent_tree() that replaces extent
tree for an inode. This allows fast_commit code in subsequent patches
to recreate a file as expected.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/e2fsck.h  |  17 +++++
 e2fsck/extents.c | 160 +++++++++++++++++++++++++++++------------------
 2 files changed, 117 insertions(+), 60 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 9b2b9ce8..68f7a249 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -526,6 +526,19 @@ void destroy_encryption_policy_map(e2fsck_t ctx);
 void destroy_encrypted_file_info(e2fsck_t ctx);
 
 /* extents.c */
+struct extent_list {
+	blk64_t blocks_freed;
+	struct ext2fs_extent *extents;
+	unsigned int count;
+	unsigned int size;
+	unsigned int ext_read;
+	errcode_t retval;
+	ext2_ino_t ino;
+};
+
+#define NUM_EXTENTS	341	/* about one ETB' worth of extents */
+
+
 errcode_t e2fsck_rebuild_extents_later(e2fsck_t ctx, ext2_ino_t ino);
 int e2fsck_ino_will_be_rebuilt(e2fsck_t ctx, ext2_ino_t ino);
 void e2fsck_pass1e(e2fsck_t ctx);
@@ -536,6 +549,10 @@ errcode_t e2fsck_should_rebuild_extents(e2fsck_t ctx,
 					struct problem_context *pctx,
 					struct extent_tree_info *eti,
 					struct ext2_extent_info *info);
+errcode_t e2fsck_read_extents(e2fsck_t ctx, struct extent_list *extents);
+errcode_t e2fsck_rewrite_extent_tree(e2fsck_t ctx,
+				     struct extent_list *extents);
+
 
 /* journal.c */
 extern errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx);
diff --git a/e2fsck/extents.c b/e2fsck/extents.c
index e9139326..dc10cc8c 100644
--- a/e2fsck/extents.c
+++ b/e2fsck/extents.c
@@ -20,7 +20,6 @@
 #undef DEBUG_SUMMARY
 #undef DEBUG_FREE
 
-#define NUM_EXTENTS	341	/* about one ETB' worth of extents */
 
 static errcode_t e2fsck_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino);
 
@@ -58,16 +57,6 @@ int e2fsck_ino_will_be_rebuilt(e2fsck_t ctx, ext2_ino_t ino)
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
@@ -206,65 +195,35 @@ static int find_blocks(ext2_filsys fs, blk64_t *blocknr, e2_blkcnt_t blockcnt,
 	return 0;
 }
 
-static errcode_t rebuild_extent_tree(e2fsck_t ctx, struct extent_list *list,
-				     ext2_ino_t ino)
+errcode_t __e2fsck_rewrite_extent_tree(e2fsck_t ctx, struct extent_list *list,
+				       struct ext2_inode_large *inode)
 {
-	struct ext2_inode_large	inode;
 	errcode_t		retval;
 	ext2_extent_handle_t	handle;
 	unsigned int		i, ext_written;
 	struct ext2fs_extent	*ex, extent;
 	blk64_t			start_val, delta;
 
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
+	start_val = ext2fs_get_stat_i_blocks(ctx->fs, EXT2_INODE(inode));
 	for (i = 0, ex = list->extents; i < list->count; i++, ex++) {
 		memcpy(&extent, ex, sizeof(struct ext2fs_extent));
 		extent.e_flags &= EXT2_EXTENT_FLAGS_UNINIT;
@@ -289,36 +248,117 @@ extents_loaded:
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
+	int i;
+
+	e2fsck_read_inode_full(ctx, list->ino, EXT2_INODE(&inode),
+				sizeof(inode), "e2fsck_rewrite_extent_tree");
+
+	/* Skip deleted inodes and inline data files */
+	if (inode.i_links_count == 0 ||
+	    inode.i_flags & EXT4_INLINE_DATA_FL)
+		return 0;
+
+	return __e2fsck_rewrite_extent_tree(ctx, list, &inode);
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
+	e2fsck_read_inode_full(ctx, extents->ino, EXT2_INODE(&inode),
+				sizeof(inode), "read_extents");
+
+	/* Skip deleted inodes and inline data files */
+	if (inode.i_links_count == 0 || inode.i_flags & EXT4_INLINE_DATA_FL)
+		return 0;
+
+	if (!inode.i_flags & EXT4_EXTENTS_FL)
+		return 0;
+	retval = load_extents(ctx, extents);
+	if (retval) {
+		ext2fs_free_mem(&extents->extents);
+		return retval;
+	}
+	return 0;
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
+		return __e2fsck_rewrite_extent_tree(ctx, list, &inode);
+	}
+
+	retval = ext2fs_block_iterate3(ctx->fs, ino, BLOCK_FLAG_READ_ONLY, 0,
+				       find_blocks, list);
+
+	return retval || list->retval ||
+		__e2fsck_rewrite_extent_tree(ctx, list, &inode);
+}
+
 /* Rebuild the extents immediately */
 static errcode_t e2fsck_rebuild_extents(e2fsck_t ctx, ext2_ino_t ino)
 {
-- 
2.25.1.696.g5e7596f4ac-goog

