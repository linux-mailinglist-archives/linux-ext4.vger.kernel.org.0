Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C571A1F11
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgDHKq4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36946 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKqz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id u65so2232071pfb.4
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w0AODl7Eb3YSB/hFowqs3E8B7le5vdNgf7Buve3ErFk=;
        b=Ok+aQUIb3D9Qa1sSFMeAM3UnJhAVaRpMUEFysT5ziLxPe7oX2gQFSrLoQJb6TVtj4N
         GrXRiMFqLt4Oq86R8krj1/s2+/j+bfQVj3SV3m9q6SKjehAnnQequlM4FO/C66vOjNZC
         Lo2A7yt+20Gjqhb78K9XJwZcpPmWedbixsSox6A08ej4/h0tv66wI67RarQ0ycwIKnim
         uQaQ8LkOy09gZo3UpO9TyMjYxgghQMicFbFPV3wX0FfO5QCYH1pnUCKfR9zMBdNo2cNL
         JBbDkOqtkl55x8DYjZlnO3y1ziNwId4I54djOjJ6cub4zKMjtShQg6EAhVJi9nhXMZ+0
         C1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w0AODl7Eb3YSB/hFowqs3E8B7le5vdNgf7Buve3ErFk=;
        b=kJ40qv+CzBtyrsnvD+byNA/Q2kXQ6WQ/Tr/QrJ4Qa1M5AV+XVuzqhp7Q1zAPyN1GP+
         tle9FkICkY4i2/Te252cS0ELsgDL6rOKCSR5bDDQyUMyI9UHaDiB+bPDji8VUXBuuvbR
         bhpmGLg140rHKWold+w2As+to0o05g3S6HKiWKkgVZkP2vxuENRLwxCSiKxawGALaFqy
         11lXTfrRfkB46L5RVix5JIUzVdCtYeqC+akVMfmJCLGj5+UVBV68NNZGJVZiIko+Sqhk
         SoYIQX+kPv9alcE/RKOSwFTlnQ4uX7bZVILKAOadpjKFCnh8RKmG4Dijiz5bStu0NRw3
         3A2g==
X-Gm-Message-State: AGi0Puaz1/6C0kAQGTvUr6rJnnArQx3Hn5Q/UUliZ91XavOMQjnbR/6Q
        ILauMSAR8gQyjRJcJDAOYVj7IApJ00Q=
X-Google-Smtp-Source: APiQypJQ8g8qKIp5f08+G03wLvkooaV1d/9XGO8REs92kQdpXCgsr40kVd8e/6ggHO18iFo66STElA==
X-Received: by 2002:aa7:8bd0:: with SMTP id s16mr7170940pfd.101.1586342812227;
        Wed, 08 Apr 2020 03:46:52 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:51 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 37/46] e2fsck: kickoff mutex lock for block found map
Date:   Wed,  8 Apr 2020 19:45:05 +0900
Message-Id: <1586342714-12536-38-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/e2fsck.h                   |   1 +
 e2fsck/pass1.c                    | 143 ++++++++++++++++--------------
 lib/ext2fs/bitmaps.c              |   5 +-
 lib/ext2fs/bitops.h               |   2 +
 lib/ext2fs/blkmap64_rb.c          |  38 ++++++--
 lib/ext2fs/bmap64.h               |   3 +-
 lib/ext2fs/ext2fs.h               |   9 +-
 lib/ext2fs/gen_bitmap64.c         |  49 +++++++++-
 lib/ext2fs/icount.c               |   6 +-
 tests/f_itable_collision/expect.1 |   3 -
 10 files changed, 170 insertions(+), 89 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index cfe045a1..26ef1d81 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -202,6 +202,7 @@ struct resource_track {
 #define E2F_FLAG_TIME_INSANE	0x2000 /* Time is insane */
 #define E2F_FLAG_PROBLEMS_FIXED	0x4000 /* At least one problem was fixed */
 #define E2F_FLAG_ALLOC_OK	0x8000 /* Can we allocate blocks? */
+#define E2F_FLAG_DUP_BLOCK	0x20000 /* dup block found during pass1 */
 
 #define E2F_RESET_FLAGS (E2F_FLAG_TIME_INSANE | E2F_FLAG_PROBLEMS_FIXED)
 
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 7320d85f..4654e673 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -712,6 +712,30 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 
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
+		if (ctx->global_ctx)
+			retval = ext2fs_test_block_bitmap_range2(
+					ctx->global_ctx->block_found_map, block, num);
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
@@ -815,15 +839,10 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -1294,6 +1313,19 @@ static int _e2fsck_pass1_prepare(e2fsck_t ctx)
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
@@ -1382,12 +1414,17 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 		return;
 
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
 
@@ -1901,10 +1938,8 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
-			e2fsck_pass1_block_map_lock(ctx);
-			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
+			pctx.errcode = ext2fs_copy_bitmap(ctx->global_ctx->block_found_map,
 							  &pb.fs_meta_blocks);
-			e2fsck_pass1_block_map_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2296,7 +2331,7 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field);	\
+						   _dest->_map_field, NULL);\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2313,7 +2348,7 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field);	\
+						   _dest->_map_field, NULL);\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2613,7 +2648,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 	assert(global_ctx->inode_reg_map == NULL);
 	assert(global_ctx->inodes_to_rebuild == NULL);
 
-	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_dup_map != NULL);
 	assert(global_ctx->block_found_map != NULL);
 	assert(global_ctx->block_metadata_map != NULL);
 	assert(global_ctx->block_ea_map == NULL);
@@ -2624,8 +2659,15 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
-	thread_context->global_ctx = global_ctx;
+	thread_context->block_dup_map = NULL;
 
+	retval = e2fsck_allocate_block_bitmap(global_ctx->fs,
+				_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+				"block_found_map", &thread_context->block_found_map);
+	if (retval)
+		goto out_context;
+
+	thread_context->global_ctx = global_ctx;
 	retval = ext2fs_get_mem(sizeof(struct struct_ext2_filsys), &thread_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while allocating memory");
@@ -2675,6 +2717,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx,
 out_fs:
 	ext2fs_free_mem(&thread_fs);
 out_context:
+	if (thread_context->block_found_map)
+		ext2fs_free_mem(&thread_context->block_found_map);
 	ext2fs_free_mem(&thread_context);
 	return retval;
 }
@@ -2712,7 +2756,6 @@ static void e2fsck_pass1_merge_dx_dir(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_merge_dx_dir(global_ctx, thread_ctx);
 }
 
-
 #define PASS1_MERGE_CTX_ICOUNT(_dest, _src, _field)			\
 do {									\
     if (_src->_field) {							\
@@ -2785,7 +2828,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2820,6 +2862,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
+	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -2838,6 +2882,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
 	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_found_map = block_found_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -2895,6 +2940,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
+	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
+				     global_ctx->block_found_map,
+				     global_ctx->block_dup_map);
+	e2fsck_pass1_block_map_unlock(global_ctx);
+	if (retval == EEXIST)
+		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
 	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
 	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
 	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
@@ -2933,6 +2984,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_imagic_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
 	ext2fs_free_mem(&thread_ctx);
@@ -3368,38 +3420,18 @@ static void alloc_imagic_map(e2fsck_t ctx)
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
+		e2fsck_pass1_block_map_lock(ctx);
 		ext2fs_fast_mark_block_bitmap2(global_ctx->block_dup_map, block);
+		e2fsck_pass1_block_map_unlock(ctx);
 	} else {
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, block);
 	}
@@ -3412,8 +3444,7 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 				      unsigned int num)
 {
-	e2fsck_pass1_block_map_lock(ctx);
-	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num)) {
+	if (!is_blocks_used(ctx, block, num)) {
 		ext2fs_mark_block_bitmap_range2(ctx->block_found_map, block, num);
 	} else {
 		unsigned int i;
@@ -3421,7 +3452,6 @@ static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 		for (i = 0; i < num; i += EXT2FS_CLUSTER_RATIO(ctx->fs))
 			mark_block_used(ctx, block + i);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 /*
@@ -3747,9 +3777,7 @@ refcount_fail:
 
 	inc_ea_inode_refs(global_ctx, pctx, first, end);
 	ea_refcount_store(global_ctx->refcount, blk, header->h_refcount - 1);
-	e2fsck_pass1_block_map_lock(ctx);
 	mark_block_used(ctx, blk);
-	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_fast_mark_block_bitmap2(global_ctx->block_ea_map, blk);
 	e2fsck_pass1_ea_unlock(ctx);
 	return 1;
@@ -4135,9 +4163,7 @@ report_problem:
 				pctx->str = "EXT2_EXTENT_UP";
 				return;
 			}
-			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
-			e2fsck_pass1_block_map_unlock(ctx);
 			pb->num_blocks++;
 			goto next;
 		}
@@ -4244,7 +4270,6 @@ alloc_later:
 					      pb->last_block,
 					      extent.e_pblk,
 					      extent.e_lblk)) {
-			e2fsck_pass1_block_map_lock(ctx);
 			for (i = 0; i < extent.e_len; i++) {
 				pctx->blk = extent.e_lblk + i;
 				pctx->blk2 = extent.e_pblk + i;
@@ -4252,7 +4277,6 @@ alloc_later:
 				mark_block_used(ctx, extent.e_pblk + i);
 				mark_block_used(ctx, extent.e_pblk + i);
 			}
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 
 		/*
@@ -4938,9 +4962,7 @@ static int process_block(ext2_filsys fs,
 		 * by mark_table_blocks()).
 		 */
 		if (blockcnt == BLOCK_COUNT_DIND) {
-			e2fsck_pass1_block_map_lock(ctx);
 			mark_block_used(ctx, blk);
-			e2fsck_pass1_block_map_unlock(ctx);
 		}
 		p->num_blocks++;
 	} else if (!(ctx->fs->cluster_ratio_bits &&
@@ -4949,19 +4971,15 @@ static int process_block(ext2_filsys fs,
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
@@ -5028,31 +5046,25 @@ static int process_bad_block(ext2_filsys fs,
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
@@ -5065,13 +5077,10 @@ static int process_bad_block(ext2_filsys fs,
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
@@ -5226,7 +5235,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
-	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -5247,7 +5255,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index baa7c627..01a3b7cb 100644
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
index 6c872ed1..8121b642 100644
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
index 78384e20..d354cffa 100644
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
index a72b53b3..ebbc1243 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -784,12 +784,14 @@ errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
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
2.25.2

