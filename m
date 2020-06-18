Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA501FF6E0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgFRPaF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731622AbgFRP3q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B36C0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e18so3057253pgn.7
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ApP89QNK2Dd7CBRoBr3+yxuD/nZlTnlzj/79o6O0QIo=;
        b=BqYt3j0LhISomCF/I2pk5JBtbADcZktGwqzB6fjLbvKhD5ILSQ8WV7v7buEV1DEel8
         9H5Ef1hO3waXC8q/OhMQw+L8ZLExsNOrux1vlM7m5RvPO4ksC4afEAOUig0KtP2E2L0n
         zu8SLNgroZFfEOStDRpk6u6d9G7QZQChH9x04hjsWdWSxfHKJDGDEnNmDagvuBaOSvo2
         Iiriu0G3cqq9dVKaXdBUD0jfSpwINNM2GG+M5eMcxRgtps6aeYwf2Bu5BjXxycP0jjbk
         jSzrb09n7lTJUJodoxB5nFKUbdKFGX7fP7yPxolGie+u5DlzByptSGnM7Yh+ZLga8Oo7
         ACmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ApP89QNK2Dd7CBRoBr3+yxuD/nZlTnlzj/79o6O0QIo=;
        b=fzXWVaj8uvQ858YqXZHCCh3oWpGljJl338eGO/KyZuU63KUTNoMGgkC36p8D4nw0j9
         Qy5su7OB9ez5CCjPiPvm/IAm2AkeaR8Z3Ak+dE63fk/gQjgTHCBgH2wUNgoi+Oo46EAq
         8d7GETaBHJ4souNFEODxtM8zO1z7kbPnrqBGVaYdAU2FTWnogqA07qopZIaXQmd+L4qu
         /AxSmPtJB8eCQp3VDf67039fhPr2tUByEUV25Eq8NnQzayIGJzRhskxk+QUxGdeEbGGJ
         1fWWT47Hx/jF2eiDdGeLGbQq7EMR7lwRgbw0ljWOaAPfDw0O3cJ4tc19pEQrhcW4lueD
         nDYw==
X-Gm-Message-State: AOAM530ey92Nn0i0AKE4dmrWMh7zOcJ0ZSKRVyLVTbyKt4IiyTufjmPg
        5o+3WH+UyDhlBeua3Lk6fBqO8W470ow=
X-Google-Smtp-Source: ABdhPJy21GMvMGIAUtvoNwx7Dr21Fd27/LEmdFW3heCPsABGyPG2G5z5wMMCffG3J15G5vJh2gKURQ==
X-Received: by 2002:a65:4487:: with SMTP id l7mr3839702pgq.221.1592494184407;
        Thu, 18 Jun 2020 08:29:44 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:43 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 38/51] e2fsck: kickoff mutex lock for block found map
Date:   Fri, 19 Jun 2020 00:27:41 +0900
Message-Id: <1592494074-28991-39-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Now @block_found_map is no longer shared by multiple threads,
and @block_dup_map need be checked again after threads finish.

This patch also fix a bug in bitmap merging codes, this could
make following pass skip many checkings and fixes..

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h                   |   3 +-
 e2fsck/pass1.c                    | 177 +++++++++++++++++-------------
 lib/ext2fs/bitmaps.c              |   5 +-
 lib/ext2fs/bitops.h               |   2 +
 lib/ext2fs/blkmap64_rb.c          |  38 ++++++-
 lib/ext2fs/bmap64.h               |   3 +-
 lib/ext2fs/ext2fs.h               |   9 +-
 lib/ext2fs/gen_bitmap64.c         |  49 ++++++++-
 lib/ext2fs/icount.c               |   6 +-
 tests/f_itable_collision/expect.1 |   3 -
 10 files changed, 199 insertions(+), 96 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index cd1bab07..83be5353 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -202,6 +202,7 @@ struct resource_track {
 #define E2F_FLAG_TIME_INSANE	0x2000 /* Time is insane */
 #define E2F_FLAG_PROBLEMS_FIXED	0x4000 /* At least one problem was fixed */
 #define E2F_FLAG_ALLOC_OK	0x8000 /* Can we allocate blocks? */
+#define E2F_FLAG_DUP_BLOCK	0x20000 /* dup block found during pass1 */
 
 #define E2F_RESET_FLAGS (E2F_FLAG_TIME_INSANE | E2F_FLAG_PROBLEMS_FIXED)
 
@@ -448,7 +449,7 @@ struct e2fsck_struct {
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
-	pthread_mutex_t		 fs_block_map_mutex;
+	pthread_rwlock_t	 fs_block_map_rwlock;
 	/* protect ea related structure */
 	pthread_mutex_t		 fs_ea_mutex;
 };
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 40fe6b36..0cc4e60d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -149,16 +149,28 @@ static void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
 }
 
-static inline void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+static inline void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_wrlock(&global_ctx->fs_block_map_rwlock);
 }
 
-static inline void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+static inline void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
+}
+
+static inline void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_rdlock(&global_ctx->fs_block_map_rwlock);
+}
+
+static inline void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
 }
 
 static inline void e2fsck_pass1_ea_lock(e2fsck_t ctx)
@@ -702,6 +714,32 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 
 }
 
+static _INLINE_ int is_blocks_used(e2fsck_t ctx, blk64_t block,
+				   unsigned int num)
+{
+	int retval;
+
+	/* used to avoid duplicate output from below */
+	retval = ext2fs_test_block_bitmap_range2_valid(ctx->block_found_map,
+						       block, num);
+	if (!retval)
+		return 0;
+
+	retval = ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num);
+	if (retval) {
+		e2fsck_pass1_block_map_r_lock(ctx);
+		if (ctx->global_ctx)
+			retval = ext2fs_test_block_bitmap_range2(
+					ctx->global_ctx->block_found_map, block, num);
+		e2fsck_pass1_block_map_r_unlock(ctx);
+		if (retval)
+			return 0;
+	}
+
+	return 1;
+}
+
+
 /*
  * Check to see if the inode might really be a directory, despite i_mode
  *
@@ -805,15 +843,10 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
 			if (i >= 4)
 				not_device++;
 
-			e2fsck_pass1_block_map_lock(ctx);
 			if (blk < ctx->fs->super->s_first_data_block ||
 			    blk >= ext2fs_blocks_count(ctx->fs->super) ||
-			    ext2fs_fast_test_block_bitmap2(ctx->block_found_map,
-							   blk)) {
-				e2fsck_pass1_block_map_unlock(ctx);
+			    is_blocks_used(ctx, blk, 1))
 				return;	/* Invalid block, can't be dir */
-			}
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 		blk = inode->i_block[0];
 	}
@@ -1284,6 +1317,19 @@ static int _e2fsck_pass1_prepare(e2fsck_t ctx)
 		return pctx.errcode;
 	}
 
+	pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
+			_("multiply claimed block map"),
+			EXT2FS_BMAP64_RBTREE, "block_dup_map",
+			&ctx->block_dup_map);
+	if (pctx.errcode) {
+		pctx.num = 3;
+		fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR,
+			    &pctx);
+		/* Should never get here */
+		ctx->flags |= E2F_FLAG_ABORT;
+		return pctx.errcode;
+	}
+
 	if (ext2fs_has_feature_mmp(fs->super) &&
 	    fs->super->s_mmp_block > fs->super->s_first_data_block &&
 	    fs->super->s_mmp_block < ext2fs_blocks_count(fs->super))
@@ -1375,12 +1421,17 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 	}
 
 	if (ctx->block_dup_map) {
+		if (!(ctx->flags & E2F_FLAG_DUP_BLOCK)) {
+			ext2fs_free_mem(&block_buf);
+			return;
+		}
 		if (ctx->options & E2F_OPT_PREEN) {
 			clear_problem_context(&pctx);
 			fix_problem(ctx, PR_1_DUP_BLOCKS_PREENSTOP, &pctx);
 		}
 		e2fsck_pass1_dupblocks(ctx, block_buf);
 		ext2fs_free_mem(&block_buf);
+		ctx->flags &= ~E2F_FLAG_DUP_BLOCK;
 	}
 }
 
@@ -1886,10 +1937,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
-			e2fsck_pass1_block_map_lock(ctx);
-			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
+			e2fsck_pass1_block_map_r_lock(ctx);
+			pctx.errcode = ext2fs_copy_bitmap(ctx->global_ctx->block_found_map,
 							  &pb.fs_meta_blocks);
-			e2fsck_pass1_block_map_unlock(ctx);
+			e2fsck_pass1_block_map_r_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2281,7 +2332,7 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field);	\
+						   _dest->_map_field, NULL);\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2298,7 +2349,7 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field);	\
+						   _dest->_map_field, NULL);\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2598,7 +2649,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 	assert(global_ctx->inode_reg_map == NULL);
 	assert(global_ctx->inodes_to_rebuild == NULL);
 
-	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_dup_map != NULL);
 	assert(global_ctx->block_found_map != NULL);
 	assert(global_ctx->block_metadata_map != NULL);
 	assert(global_ctx->block_ea_map == NULL);
@@ -2609,8 +2660,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
-	thread_context->global_ctx = global_ctx;
+	thread_context->block_dup_map = NULL;
+
+	retval = e2fsck_allocate_block_bitmap(global_ctx->fs,
+				_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+				"block_found_map", &thread_context->block_found_map);
+	if (retval)
+		goto out_context;
 
+	thread_context->global_ctx = global_ctx;
 	retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &thread_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
@@ -2660,6 +2718,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 out_fs:
 	ext2fs_free_mem(&thread_fs);
 out_context:
+	if (thread_context->block_found_map)
+		ext2fs_free_mem(&thread_context->block_found_map);
 	ext2fs_free_mem(&thread_context);
 	return retval;
 }
@@ -2697,7 +2757,6 @@ static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_merge_dx_dir(global_ctx, thread_ctx);
 }
 
-
 #define PASS1_MERGE_CTX_ICOUNT(_dest, _src, _field)			\
 do {									\
     if (_src->_field) {							\
@@ -2770,7 +2829,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2805,6 +2863,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
+	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2823,6 +2883,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
 	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_found_map = block_found_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -2881,6 +2942,13 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
+	e2fsck_pass1_block_map_w_lock(thread_ctx);
+	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
+				     global_ctx->block_found_map,
+				     global_ctx->block_dup_map);
+	e2fsck_pass1_block_map_w_unlock(thread_ctx);
+	if (retval == EEXIST)
+		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
 	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
 	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
 	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
@@ -2919,6 +2987,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_imagic_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	e2fsck_free_dir_info(thread_ctx);
@@ -3127,7 +3196,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 		goto out_abort;
 
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
-	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
+	pthread_rwlock_init(&global_ctx->fs_block_map_rwlock, NULL);
 	pthread_mutex_init(&global_ctx->fs_ea_mutex, NULL);
 	if (ext2fs_has_feature_flex_bg(global_ctx->fs->super))
 		flexbg_size = 1 << global_ctx->fs->super->s_log_groups_per_flex;
@@ -3355,38 +3424,18 @@ static void alloc_imagic_map(e2fsck_t ctx)
 static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 {
 	struct problem_context pctx;
-	e2fsck_t global_ctx;
-
-	global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	clear_problem_context(&pctx);
-
-	if (ext2fs_fast_test_block_bitmap2(ctx->block_found_map, block)) {
+	if (is_blocks_used(ctx, block, 1)) {
 		if (ext2fs_has_feature_shared_blocks(ctx->fs->super) &&
 		    !(ctx->options & E2F_OPT_UNSHARE_BLOCKS)) {
 			return;
 		}
-		/**
-		 * this should be safe because this operation has
-		 * been serialized by mutex.
-		 */
-		if (!global_ctx->block_dup_map) {
-			pctx.errcode = e2fsck_allocate_block_bitmap(ctx->fs,
-					_("multiply claimed block map"),
-					EXT2FS_BMAP64_RBTREE, "block_dup_map",
-					&global_ctx->block_dup_map);
-			if (pctx.errcode) {
-				pctx.num = 3;
-				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR,
-					    &pctx);
-				/* Should never get here */
-				ctx->flags |= E2F_FLAG_ABORT;
-				return;
-			}
-		}
+		ctx->flags |= E2F_FLAG_DUP_BLOCK;
+		e2fsck_pass1_block_map_w_lock(ctx);
 		ext2fs_fast_mark_block_bitmap2(global_ctx->block_dup_map, block);
+		e2fsck_pass1_block_map_w_unlock(ctx);
 	} else {
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, block);
 	}
@@ -3399,8 +3448,7 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 				      unsigned int num)
 {
-	e2fsck_pass1_block_map_lock(ctx);
-	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num)) {
+	if (!is_blocks_used(ctx, block, num)) {
 		ext2fs_mark_block_bitmap_range2(ctx->block_found_map, block, num);
 	} else {
 		unsigned int i;
@@ -3408,7 +3456,6 @@ static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 		for (i = 0; i < num; i += EXT2FS_CLUSTER_RATIO(ctx->fs))
 			mark_block_used(ctx, block + i);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 /*
@@ -3734,9 +3781,12 @@ refcount_fail:
 
 	inc_ea_inode_refs(global_ctx, pctx, first, end);
 	ea_refcount_store(global_ctx->refcount, blk, header->h_refcount - 1);
-	e2fsck_pass1_block_map_lock(ctx);
-	mark_block_used(ctx, blk);
-	e2fsck_pass1_block_map_unlock(ctx);
+	/**
+	 * It might be racy that this block has been merged in the
+	 * global found map.
+	 */
+	if (!is_blocks_used(ctx, blk, 1))
+		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, blk);
 	ext2fs_fast_mark_block_bitmap2(global_ctx->block_ea_map, blk);
 	e2fsck_pass1_ea_unlock(ctx);
 	return 1;
@@ -4122,9 +4172,7 @@ report_problem:
 				pctx->str = "EXT2_EXTENT_UP";
 				return;
 			}
-			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
-			e2fsck_pass1_block_map_unlock(ctx);
 			pb->num_blocks++;
 			goto next;
 		}
@@ -4231,7 +4279,6 @@ alloc_later:
 					      pb->last_block,
 					      extent.e_pblk,
 					      extent.e_lblk)) {
-			e2fsck_pass1_block_map_lock(ctx);
 			for (i = 0; i < extent.e_len; i++) {
 				pctx->blk = extent.e_lblk + i;
 				pctx->blk2 = extent.e_pblk + i;
@@ -4239,7 +4286,6 @@ alloc_later:
 				mark_block_used(ctx, extent.e_pblk + i);
 				mark_block_used(ctx, extent.e_pblk + i);
 			}
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 
 		/*
@@ -4925,9 +4971,7 @@ static int process_block(ext2_filsys fs,
 		 * by mark_table_blocks()).
 		 */
 		if (blockcnt == BLOCK_COUNT_DIND) {
-			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 		p->num_blocks++;
 	} else if (!(ctx->fs->cluster_ratio_bits &&
@@ -4936,19 +4980,15 @@ static int process_block(ext2_filsys fs,
 		      EXT2FS_B2C(ctx->fs, p->previous_block)) &&
 		     (blk & EXT2FS_CLUSTER_MASK(ctx->fs)) ==
 		     ((unsigned) blockcnt & EXT2FS_CLUSTER_MASK(ctx->fs)))) {
-		e2fsck_pass1_block_map_lock(ctx);
 		mark_block_used(ctx, blk);
-		e2fsck_pass1_block_map_unlock(ctx);
 		p->num_blocks++;
 	} else if (has_unaligned_cluster_map(ctx, p->previous_block,
 					     p->last_block, blk, blockcnt)) {
 		pctx->blk = blockcnt;
 		pctx->blk2 = blk;
 		fix_problem(ctx, PR_1_MISALIGNED_CLUSTER, pctx);
-		e2fsck_pass1_block_map_lock(ctx);
 		mark_block_used(ctx, blk);
 		mark_block_used(ctx, blk);
-		e2fsck_pass1_block_map_unlock(ctx);
 	}
 	if (blockcnt >= 0)
 		p->last_block = blockcnt;
@@ -5015,31 +5055,25 @@ static int process_bad_block(ext2_filsys fs,
 	}
 
 	if (blockcnt < 0) {
-		e2fsck_pass1_block_map_lock(ctx);
 		if (ext2fs_test_block_bitmap2(p->fs_meta_blocks, blk)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BB_FS_BLOCK, pctx)) {
 				*block_nr = 0;
-				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
-		} else if (ext2fs_test_block_bitmap2(ctx->block_found_map,
-						    blk)) {
+		} else if (is_blocks_used(ctx, blk, 1)) {
 			p->bbcheck = 1;
 			if (fix_problem(ctx, PR_1_BBINODE_BAD_METABLOCK,
 					pctx)) {
 				*block_nr = 0;
-				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_CHANGED;
 			}
 			if (e2fsck_should_abort(ctx)) {
-				e2fsck_pass1_block_map_unlock(ctx);
 				return BLOCK_ABORT;
 			}
 		} else {
 			mark_block_used(ctx, blk);
 		}
-		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
 #if 0
@@ -5052,13 +5086,10 @@ static int process_bad_block(ext2_filsys fs,
 	 * there's an overlap between the filesystem table blocks
 	 * (bitmaps and inode table) and the bad block list.
 	 */
-	e2fsck_pass1_block_map_lock(ctx);
-	if (!ext2fs_test_block_bitmap2(ctx->block_found_map, blk)) {
+	if (!is_blocks_used(ctx, blk, 1)) {
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, blk);
-		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	/*
 	 * Try to find the where the filesystem block was used...
 	 */
@@ -5213,7 +5244,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
-	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -5234,7 +5264,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index 74a8c347..4cd664d3 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -47,9 +47,10 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 }
 
 errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
-			      ext2fs_generic_bitmap dest)
+			      ext2fs_generic_bitmap dest,
+			      ext2fs_generic_bitmap dup)
 {
-	return ext2fs_merge_generic_bmap(src, dest);
+	return ext2fs_merge_generic_bmap(src, dest, dup);
 }
 
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
index 505b3c9c..1facc8dd 100644
--- a/lib/ext2fs/bitops.h
+++ b/lib/ext2fs/bitops.h
@@ -120,6 +120,8 @@ extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 extern __u32 ext2fs_get_generic_bitmap_start(ext2fs_generic_bitmap bitmap);
 extern __u32 ext2fs_get_generic_bitmap_end(ext2fs_generic_bitmap bitmap);
+extern int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+						blk64_t block, unsigned int num);
 
 /* 64-bit versions */
 
diff --git a/lib/ext2fs/blkmap64_rb.c b/lib/ext2fs/blkmap64_rb.c
index 42a10536..2337302f 100644
--- a/lib/ext2fs/blkmap64_rb.c
+++ b/lib/ext2fs/blkmap64_rb.c
@@ -969,27 +969,53 @@ static void rb_print_stats(ext2fs_generic_bitmap_64 bitmap EXT2FS_ATTR((unused))
 #endif
 
 static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
-			       ext2fs_generic_bitmap_64 dest)
+			       ext2fs_generic_bitmap_64 dest,
+			       ext2fs_generic_bitmap_64 dup)
 {
-	struct ext2fs_rb_private *src_bp, *dest_bp;
+	struct ext2fs_rb_private *src_bp, *dest_bp, *dup_bp = NULL;
 	struct bmap_rb_extent *src_ext;
 	struct rb_node *src_node;
-	errcode_t retval = 0;
+	int retval = 0;
+	int dup_found = 0;
 
 	src_bp = (struct ext2fs_rb_private *) src->private;
 	dest_bp = (struct ext2fs_rb_private *) dest->private;
+	if (dup)
+		dup_bp = (struct ext2fs_rb_private *) dup->private;
 	src_bp->rcursor = NULL;
 	dest_bp->rcursor = NULL;
 
 	src_node = ext2fs_rb_first(&src_bp->root);
 	while (src_node) {
 		src_ext = node_to_extent(src_node);
-		rb_insert_extent(src_ext->start, src_ext->count, dest_bp);
-
+		retval = rb_test_clear_bmap_extent(dest,
+					src_ext->start + src->start,
+					src_ext->count);
+		if (retval) {
+			rb_insert_extent(src_ext->start, src_ext->count,
+					 dest_bp);
+		} else {
+			/* unlikely case, do it one by one block */
+			__u64 i;
+
+			for (i = src_ext->start;
+			     i < src_ext->start + src_ext->count; i++) {
+				retval = rb_test_clear_bmap_extent(dest, i + src->start, 1);
+				if (retval) {
+					rb_insert_extent(i, 1, dest_bp);
+				} else {
+					if (dup_bp)
+						rb_insert_extent(i, 1, dup_bp);
+					dup_found = 1;
+				}
+			}
+		}
 		src_node = ext2fs_rb_next(src_node);
 	}
 
-	return retval;
+	if (dup_found && dup)
+		return EEXIST;
+	return 0;
 }
 
 struct ext2_bitmap_ops ext2fs_blkmap64_rbtree = {
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index 09a5886b..68a4bb0a 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -73,7 +73,8 @@ struct ext2_bitmap_ops {
 	errcode_t (*copy_bmap)(ext2fs_generic_bitmap_64 src,
 			     ext2fs_generic_bitmap_64 dest);
 	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
-				ext2fs_generic_bitmap_64 dest);
+				ext2fs_generic_bitmap_64 dest,
+				ext2fs_generic_bitmap_64 dup);
 	errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
 			       __u64 new_end,
 			       __u64 new_real_end);
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 37460a31..38ae2dee 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -839,8 +839,10 @@ extern void ext2fs_free_block_bitmap(ext2fs_block_bitmap bitmap);
 extern void ext2fs_free_inode_bitmap(ext2fs_inode_bitmap bitmap);
 extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 				    ext2fs_generic_bitmap *dest);
-errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
-			      ext2fs_generic_bitmap dest);
+
+extern errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
+				     ext2fs_generic_bitmap dest,
+				     ext2fs_generic_bitmap dup);
 extern errcode_t ext2fs_write_inode_bitmap(ext2_filsys fs);
 extern errcode_t ext2fs_write_block_bitmap (ext2_filsys fs);
 extern errcode_t ext2fs_read_inode_bitmap (ext2_filsys fs);
@@ -1439,7 +1441,8 @@ errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
 				     __u64 new_end,
 				     __u64 new_real_end);
 errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
-                                    ext2fs_generic_bitmap gen_dest);
+                                    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup);
 errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 				      ext2fs_generic_bitmap bm1,
 				      ext2fs_generic_bitmap bm2);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index 7bae443f..c27a52e4 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -340,24 +340,32 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 }
 
 errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
-				    ext2fs_generic_bitmap gen_dest)
+				    ext2fs_generic_bitmap gen_dest,
+				    ext2fs_generic_bitmap gen_dup)
 {
 	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64) gen_src;
 	ext2fs_generic_bitmap_64 dest = (ext2fs_generic_bitmap_64) gen_dest;
+	ext2fs_generic_bitmap_64 dup = (ext2fs_generic_bitmap_64) gen_dup;
 
 	if (!src || !dest)
 		return EINVAL;
 
-	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest))
+	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest) ||
+	    (dup && !EXT2FS_IS_64_BITMAP(dup)))
 		return EINVAL;
 
-	if (src->bitmap_ops != dest->bitmap_ops)
+	if (src->bitmap_ops != dest->bitmap_ops ||
+	    (dup && src->bitmap_ops != dup->bitmap_ops))
+		return EINVAL;
+
+	if (src->cluster_bits != dest->cluster_bits ||
+	    (dup && dup->cluster_bits != src->cluster_bits))
 		return EINVAL;
 
 	if (src->bitmap_ops->merge_bmap == NULL)
 		return EOPNOTSUPP;
 
-	return src->bitmap_ops->merge_bmap(src, dest);
+	return src->bitmap_ops->merge_bmap(src, dest, dup);
 }
 
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
@@ -712,6 +720,39 @@ int ext2fs_test_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 	return bmap->bitmap_ops->test_clear_bmap_extent(bmap, block, num);
 }
 
+int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
+					  blk64_t block, unsigned int num)
+{
+	ext2fs_generic_bitmap_64 bmap = (ext2fs_generic_bitmap_64)bitmap;
+	__u64	end = block + num;
+
+	if (!bmap)
+		return 0;
+
+	if (EXT2FS_IS_32_BITMAP(bmap)) {
+		if ((block & ~0xffffffffULL) ||
+		    ((block+num-1) & ~0xffffffffULL)) {
+			return 0;
+		}
+	}
+
+	if (!EXT2FS_IS_64_BITMAP(bmap))
+		return 0;
+
+	/* convert to clusters if necessary */
+	block >>= bmap->cluster_bits;
+	end += (1 << bmap->cluster_bits) - 1;
+	end >>= bmap->cluster_bits;
+	num = end - block;
+
+	if ((block < bmap->start) || (block > bmap->end) ||
+	    (block+num-1 > bmap->end))
+		return 0;
+
+	return 1;
+}
+
+
 void ext2fs_mark_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
 				     blk64_t block, unsigned int num)
 {
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 729f993f..7ec490dc 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -785,12 +785,14 @@ errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
 	if (src->fullmap)
 		return ext2fs_icount_merge_full_map(src, dest);
 
-	retval = ext2fs_merge_bitmap(src->single, dest->single);
+	retval = ext2fs_merge_bitmap(src->single,
+				     dest->single, NULL);
 	if (retval)
 		return retval;
 
 	if (src->multiple) {
-		retval = ext2fs_merge_bitmap(src->multiple, dest->multiple);
+		retval = ext2fs_merge_bitmap(src->multiple,
+					     dest->multiple, NULL);
 		if (retval)
 			return retval;
 	}
diff --git a/tests/f_itable_collision/expect.1 b/tests/f_itable_collision/expect.1
index 01c85d4d..7e98baa8 100644
--- a/tests/f_itable_collision/expect.1
+++ b/tests/f_itable_collision/expect.1
@@ -1,6 +1,5 @@
 Pass 1: Checking inodes, blocks, and sizes
 Inode 12 block 37 conflicts with critical metadata, skipping block checks.
-Illegal block number passed to ext2fs_test_block_bitmap #268435455 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #268435455 for in-use block map
 Inode 12, i_blocks is 48, should be 56.  Fix? yes
 
@@ -27,9 +26,7 @@ Clear inode? yes
 Restarting e2fsck from the beginning...
 Pass 1: Checking inodes, blocks, and sizes
 Inode 12 block 37 conflicts with critical metadata, skipping block checks.
-Illegal block number passed to ext2fs_test_block_bitmap #4294967294 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #4294967294 for in-use block map
-Illegal block number passed to ext2fs_test_block_bitmap #268435455 for in-use block map
 Illegal block number passed to ext2fs_mark_block_bitmap #268435455 for in-use block map
 
 Running additional passes to resolve blocks claimed by more than one inode...
-- 
2.25.4

