Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9B611A1EFA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgDHKqJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34570 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbgDHKqJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id l14so3166050pgb.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/M5iITtDPr9Fx1MobQuL0MQj7lmTDUjEonV4FCeaj9I=;
        b=SN86pZS/hOJg2tOtNlFWRDYkmV6iMmiIRKu7bjZugsD5qSAwsuZe1r7iE5ntYjcsz0
         Be8SEBeTet52k5kpYRXTnf1bHs6mQuTDtXWIrxWLrdLt2M1xaR2wc94WuF/MeRId99hn
         z7wglfgItIhjyNIllzjxSvhG3vNQEVh9yKd6eA8ku5l82mFU4lMxKmgjbbjaGzD5cMNc
         xJyR7g6nBy4QIPxg9vrTxl3eJ4QGhC4yB7QIoes1O73G3BTrYMV9fbvnqiFkwX2bOAbF
         w462kDg6waaymDfpH8EJyuPC9/+/anuX7sGpo42a78hGs4TxobdfNzMQsuAR9S4f8VXj
         rXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/M5iITtDPr9Fx1MobQuL0MQj7lmTDUjEonV4FCeaj9I=;
        b=JoKTN/tWTXgiy/Up+XA/Xrzu8O4rNZUHpRc1X7bQkGF36mm2piP5hn6mmq/zcFF+jZ
         wsmoAPZMZeEMmj28FDwOM92wUqAZCqEdb+Tg6D2kdwzw0KE6YjaW7cE9u/iYrnHFjIC4
         TRBWHda1s9eRINLTkVGtzCUpp+aZAX8aLIfcQL0nt65hpYjbRsdY1PGZni/ex1gPMy+N
         TqRjs4Jwa2Y9HVnV21baj9mhTxVTtg8ZHiu5TpxDSyKagCF4AkHT19MF6+EUUY/eds4R
         tpIvdaSF1Hs2cldWFvDbTp+d33VfTcLsX7yptn0uiuqYfdODgF6RHUC+jasRqE+osPDx
         CD+w==
X-Gm-Message-State: AGi0Pub7EY56DVgiWxC66JZfT8tIa487xNw7Ez0dGGAZUoZhBfu/r8Br
        BOOArciwAkxXCHxaUW3aBEWYA1oLgGM=
X-Google-Smtp-Source: APiQypIqZHA7yfyh+ToVVPze1gHRHTaaTHlx1Aid9yG9QnLSxXPI6ohHAnyRBlgjXIwg6DZVW/u+1w==
X-Received: by 2002:a63:a502:: with SMTP id n2mr6110749pgf.449.1586342767363;
        Wed, 08 Apr 2020 03:46:07 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:06 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 16/46] e2fsck: merge bitmaps after thread completes
Date:   Wed,  8 Apr 2020 19:44:44 +0900
Message-Id: <1586342714-12536-17-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

A new method merge_bmap has been added to bitmap operations. But
only red-black bitmap has that operation now.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c            | 149 +++++++++++++++++++++++++++++---------
 lib/ext2fs/bitmaps.c      |   7 ++
 lib/ext2fs/blkmap64_rb.c  |  25 +++++++
 lib/ext2fs/bmap64.h       |   2 +
 lib/ext2fs/ext2fs.h       |   4 +
 lib/ext2fs/gen_bitmap64.c |  21 ++++++
 6 files changed, 173 insertions(+), 35 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7a66bdf9..2c2973c7 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2123,31 +2123,57 @@ endit:
 		ctx->invalid_bitmaps++;
 }
 
-#define PASS1_COPY_FS_BITMAP(_dest, _src, _map_filed)			\
+#define PASS1_COPY_FS_BITMAP(_dest, _src, _map_filed)		\
+do {								\
+	errcode_t _ret;						\
+	if (_src->_map_filed) {					\
+		_ret = ext2fs_copy_bitmap(_src->_map_filed,	\
+					  &_dest->_map_filed);	\
+		if (_ret)                                       \
+			return _ret;				\
+		_dest->_map_filed->fs = _dest;			\
+	}							\
+} while (0)
+
+#define PASS1_MERGE_FS_BITMAP(_dest, _src, _map_field)			\
 do {									\
-    errcode_t _ret;							\
-    if (_src->_map_filed) {						\
-        _ret = ext2fs_copy_bitmap(_src->_map_filed, &_dest->_map_filed);\
-        if (_ret)							\
-            return _ret;						\
-        _dest->_map_filed->fs = _dest;					\
-									\
-        ext2fs_free_generic_bmap(_src->_map_filed);			\
-        _src->_map_filed = NULL;					\
-    }									\
+	errcode_t _ret = 0;						\
+	if (_src->_map_field) {						\
+		if (_dest->_map_field == NULL)	{			\
+			_dest->_map_field = _src->_map_field;		\
+			_src->_map_field = NULL;			\
+		} else {						\
+			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
+						   _dest->_map_field);	\
+			if (_ret)					\
+				return _ret;				\
+		}							\
+		_dest->_map_field->fs = _dest;				\
+	}								\
 } while (0)
 
-#define PASS1_COPY_CTX_BITMAP(_dest, _src, _map_filed)			\
+#define PASS1_MERGE_CTX_BITMAP(_dest, _src, _map_field)			\
 do {									\
-    errcode_t _ret;							\
-    if (_src->_map_filed) {						\
-        _ret = ext2fs_copy_bitmap(_src->_map_filed, &_dest->_map_filed);\
-        if (_ret)							\
-            return _ret;						\
-        _dest->_map_filed->fs = _dest->fs;				\
-									\
-        ext2fs_free_generic_bmap(_src->_map_filed);			\
-        _src->_map_filed = NULL;					\
+	errcode_t _ret = 0;						\
+	if (_src->_map_field) {						\
+		if (_dest->_map_field == NULL)	{			\
+			_dest->_map_field = _src->_map_field;		\
+			_src->_map_field = NULL;			\
+		} else {						\
+			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
+						   _dest->_map_field);	\
+			if (_ret)					\
+				return _ret;				\
+		}							\
+		_dest->_map_field->fs = _dest->fs;			\
+	}								\
+} while (0)
+
+#define PASS1_FREE_CTX_BITMAP(_src, _map_field)				\
+do {									\
+    if (_src->_map_field) {						\
+        ext2fs_free_generic_bmap(_src->_map_field);			\
+        _src->_map_field = NULL;					\
     }									\
 } while (0)
 
@@ -2186,6 +2212,9 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
 	errcode_t	retval;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	dest->inode_map = NULL;
+	dest->block_map = NULL;
+
 	/*
 	 * PASS1_COPY_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
@@ -2259,18 +2288,24 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	errcode_t retval = 0;
 	io_channel dest_io;
 	io_channel dest_image_io;
+	ext2fs_inode_bitmap inode_map;
+	ext2fs_block_bitmap block_map;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
+	inode_map = dest->inode_map;
+	block_map = dest->block_map;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
+	dest->inode_map = inode_map;
+	dest->block_map = block_map;
 	/*
-	 * PASS1_COPY_FS_BITMAP might return directly from this function,
+	 * PASS1_MERGE_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
 	 */
-	PASS1_COPY_FS_BITMAP(dest, src, inode_map);
-	PASS1_COPY_FS_BITMAP(dest, src, block_map);
+	PASS1_MERGE_FS_BITMAP(dest, src, inode_map);
+	PASS1_MERGE_FS_BITMAP(dest, src, block_map);
 
 	if (src->dblist) {
 		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
@@ -2299,6 +2334,11 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 
 	retval = _e2fsck_pass1_merge_fs(dest, src);
 
+	if (src->inode_map)
+		ext2fs_free_generic_bmap(src->inode_map);
+	if (src->block_map)
+		ext2fs_free_generic_bmap(src->block_map);
+
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
@@ -2406,6 +2446,17 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys	 global_fs = global_ctx->fs;
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
+	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
+	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
+	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
+	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
+	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
+	ext2fs_block_bitmap block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
+	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
+	ext2fs_block_bitmap block_metadata_map = global_ctx->block_metadata_map;
+	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
+	
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
 
@@ -2415,6 +2466,18 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 #ifdef HAVE_SETJMP_H
 	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
 #endif
+
+	global_ctx->inode_used_map = inode_used_map;
+	global_ctx->inode_dir_map = inode_dir_map;
+	global_ctx->inode_bb_map = inode_bb_map;
+	global_ctx->inode_imagic_map = inode_imagic_map;
+	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
+	global_ctx->inode_reg_map = inode_reg_map;
+	global_ctx->block_found_map = block_found_map;
+	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_ea_map = block_ea_map;
+	global_ctx->block_metadata_map = block_metadata_map;
+
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
 			     (global_ctx->flags & E2F_FLAG_SIGNAL_MASK);
@@ -2434,16 +2497,16 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
 	 */
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_used_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_dir_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_bb_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_found_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
-	PASS1_COPY_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_used_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_dir_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_bb_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_found_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_dup_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_metadata_map);
 
 	return 0;
 }
@@ -2460,6 +2523,16 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		fputs("</problem_log>\n", thread_ctx->problem_logf);
 		fclose(thread_ctx->problem_logf);
 	}
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_used_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_dir_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_bb_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_imagic_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_dup_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_metadata_map);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
@@ -2486,7 +2559,13 @@ static int e2fsck_pass1_threads_join(struct e2fsck_thread_info *infos,
 			if (ret == 0)
 				ret = rc;
 		}
-		e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		rc = e2fsck_pass1_thread_join(global_ctx, infos[i].eti_thread_ctx);
+		if (rc) {
+			com_err(global_ctx->program_name, rc,
+				_("while joining pass1 thread\n"));
+			if (ret == 0)
+				ret = rc;
+		}
 	}
 	free(infos);
 
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index e25db2c6..baa7c627 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -45,6 +45,13 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 {
 	return (ext2fs_copy_generic_bmap(src, dest));
 }
+
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest)
+{
+	return ext2fs_merge_generic_bmap(src, dest);
+}
+
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
 {
 	ext2fs_set_generic_bmap_padding(map);
diff --git a/lib/ext2fs/blkmap64_rb.c b/lib/ext2fs/blkmap64_rb.c
index 1fd55274..42a10536 100644
--- a/lib/ext2fs/blkmap64_rb.c
+++ b/lib/ext2fs/blkmap64_rb.c
@@ -968,11 +968,36 @@ static void rb_print_stats(ext2fs_generic_bitmap_64 bitmap EXT2FS_ATTR((unused))
 }
 #endif
 
+static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
+			       ext2fs_generic_bitmap_64 dest)
+{
+	struct ext2fs_rb_private *src_bp, *dest_bp;
+	struct bmap_rb_extent *src_ext;
+	struct rb_node *src_node;
+	errcode_t retval = 0;
+
+	src_bp = (struct ext2fs_rb_private *) src->private;
+	dest_bp = (struct ext2fs_rb_private *) dest->private;
+	src_bp->rcursor = NULL;
+	dest_bp->rcursor = NULL;
+
+	src_node = ext2fs_rb_first(&src_bp->root);
+	while (src_node) {
+		src_ext = node_to_extent(src_node);
+		rb_insert_extent(src_ext->start, src_ext->count, dest_bp);
+
+		src_node = ext2fs_rb_next(src_node);
+	}
+
+	return retval;
+}
+
 struct ext2_bitmap_ops ext2fs_blkmap64_rbtree = {
 	.type = EXT2FS_BMAP64_RBTREE,
 	.new_bmap = rb_new_bmap,
 	.free_bmap = rb_free_bmap,
 	.copy_bmap = rb_copy_bmap,
+	.merge_bmap = rb_merge_bmap,
 	.resize_bmap = rb_resize_bmap,
 	.mark_bmap = rb_mark_bmap,
 	.unmark_bmap = rb_unmark_bmap,
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index de334548..09a5886b 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -72,6 +72,8 @@ struct ext2_bitmap_ops {
 	void	(*free_bmap)(ext2fs_generic_bitmap_64 bitmap);
 	errcode_t (*copy_bmap)(ext2fs_generic_bitmap_64 src,
 			     ext2fs_generic_bitmap_64 dest);
+	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
+				ext2fs_generic_bitmap_64 dest);
 	errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
 			       __u64 new_end,
 			       __u64 new_real_end);
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 93ecf29c..2cc6d76e 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -837,6 +837,8 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bitmap bitmap);
 extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
+errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+			      ext2fs_generic_bitmap dest);
 extern errcode_t ext2fs_write_inode_bitmap(ext2_filsys fs);
 extern errcode_t ext2fs_write_block_bitmap (ext2_filsys fs);
 extern errcode_t ext2fs_read_inode_bitmap (ext2_filsys fs);
@@ -1433,6 +1435,8 @@ void ext2fs_set_generic_bmap_padding(ext2fs_generic_bitmap bmap);
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
 				     __u64 new_end,
 				     __u64 new_real_end);
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+                                    ext2fs_generic_bitmap gen_dest);
 errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 				      ext2fs_generic_bitmap bm1,
 				      ext2fs_generic_bitmap bm2);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 6e4d8b71..ccba4427 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -344,6 +344,27 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 	return 0;
 }
 
+errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
+				    ext2fs_generic_bitmap gen_dest)
+{
+	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64) gen_src;
+	ext2fs_generic_bitmap_64 dest = (ext2fs_generic_bitmap_64) gen_dest;
+
+	if (!src || !dest)
+		return EINVAL;
+
+	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest))
+		return EINVAL;
+
+	if (src->bitmap_ops != dest->bitmap_ops)
+		return EINVAL;
+
+	if (src->bitmap_ops->merge_bmap == NULL)
+		return EOPNOTSUPP;
+
+	return src->bitmap_ops->merge_bmap(src, dest);
+}
+
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
 				     __u64 new_end,
 				     __u64 new_real_end)
-- 
2.25.2

