Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3995E61F31A
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiKGM1O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiKGM1N (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:27:13 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B40A6405
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:27:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id k7so10909962pll.6
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DepVf17ZBIX728Wkzehxp6NgK34Qut61oRb1OEKT4E=;
        b=RUob6gVCqPBfVNTmNRQn2N1gMth/+gik+bW6iZG7/J5SB2DEXuQrEsUf7I/RBqXNW2
         5kl18IJb/qBfBoV6BmaBhnnAA8x2UJk0XRQIDKYvsWHloyWNcsyNK06FgdjOceyrPq8E
         Dp+zKz7zHa7gZbmH/mgboo8mveeBibo04hWXGQGYljt7WcP+K1YUFDExFoId9786dydx
         f6uQexduQW6gZ+k6cl6j0Z+OgbyXXqUWtzyCcbiSv6nD/yFTn1CYb9DEK2OMlMbTQnNi
         k+cN3fgTdf2Z1SMxqv0HNPN7NhyNp4PO+wa11H4DFPFfcxv6ORg61VS3dGoTZyYcPnUm
         cjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DepVf17ZBIX728Wkzehxp6NgK34Qut61oRb1OEKT4E=;
        b=BOSmfA1VxTG42D/hEihmWMG7gT54vEmwf1mS3TW2oBbH1wljd7BMukK8hAstwNOAOP
         B6NCoJj97LNZnzYNixegfn6J5C+PUMaVBlfixjcU1n6MSf09MyMUylaFETEHHEa+eojM
         PDiYpQZ+2JgYkzmUzgG6yHfDZbG8dHvZcA0C99C1ABt3JNEgYdnrXJeCOM3BaQf/Y9nX
         wqyQLEs7WB5UJd8PvvSvL9x4H+T08MLrigYEp+0rOqCXouuE/sRWl43deFCn1RHDV+tN
         hM5lh4KXCiv8qXrFHAunNndPLXL4Dh4gSyNeKVGchGBuggSdXfZGegu2YlMr2SyR/b0s
         /xpg==
X-Gm-Message-State: ACrzQf3OGBC2FxrlT884RaKoUHPsU1Bwq94DdWkW3oZPxw/XjED1i9Hx
        Y8Zfrl/IFQLWx+rHDISZrEM=
X-Google-Smtp-Source: AMsMyM72mTsCa66htpagyyqOCH4zKwarIwYY/xR5XoyhEvlkGy3UrXQDVM0dkK5sabZI85hMeB7bhQ==
X-Received: by 2002:a17:90a:cf06:b0:212:d9ab:811b with SMTP id h6-20020a17090acf0600b00212d9ab811bmr52187883pju.65.1667824031764;
        Mon, 07 Nov 2022 04:27:11 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id c195-20020a621ccc000000b00550724f8ea0sm4326209pfc.128.2022.11.07.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:27:11 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 47/72] e2fsck: kickoff mutex lock for block found map
Date:   Mon,  7 Nov 2022 17:51:35 +0530
Message-Id: <f38e5b590df514408de13c3a0d16e28104d69a0c.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Now @block_found_map is no longer shared by multiple threads,
and @block_dup_map need be checked again after threads finish.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.h                   |   9 +-
 e2fsck/pass1.c                    | 171 ++++++++++++++++++------------
 e2fsck/util.c                     |  34 ++++--
 tests/f_itable_collision/expect.1 |   3 -
 4 files changed, 137 insertions(+), 80 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index beac7054..23e8d2ed 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -211,6 +211,7 @@ struct resource_track {
 #define E2F_FLAG_TIME_INSANE	0x2000 /* Time is insane */
 #define E2F_FLAG_PROBLEMS_FIXED	0x4000 /* At least one problem was fixed */
 #define E2F_FLAG_ALLOC_OK	0x8000 /* Can we allocate blocks? */
+#define E2F_FLAG_DUP_BLOCK	0x20000 /* dup block found during pass1 */
 
 #define E2F_RESET_FLAGS (E2F_FLAG_TIME_INSANE | E2F_FLAG_PROBLEMS_FIXED)
 
@@ -489,7 +490,7 @@ struct e2fsck_struct {
 	/* serialize fix operation for multiple threads */
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
-	pthread_mutex_t		 fs_block_map_mutex;
+	pthread_rwlock_t	 fs_block_map_rwlock;
 #endif
 	/* Fast commit replay state */
 	struct e2fsck_fc_replay_state fc_replay_state;
@@ -796,8 +797,10 @@ extern errcode_t e2fsck_allocate_subcluster_bitmap(ext2_filsys fs,
 unsigned long long get_memory_size(void);
 extern void e2fsck_pass1_fix_lock(e2fsck_t ctx);
 extern void e2fsck_pass1_fix_unlock(e2fsck_t ctx);
-extern void e2fsck_pass1_block_map_lock(e2fsck_t ctx);
-extern void e2fsck_pass1_block_map_unlock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx);
 
 /* unix.c */
 extern void e2fsck_clear_progbar(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 06306a17..fdd1f3d6 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -650,6 +650,31 @@ static void check_inode_extra_space(e2fsck_t ctx, struct problem_context *pctx,
 
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
 /*
  * Check to see if the inode might really be a directory, despite i_mode
  *
@@ -753,15 +778,10 @@ static void check_is_really_dir(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -1221,11 +1241,28 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
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
 		ext2fs_mark_block_bitmap2(ctx->block_found_map,
 					  fs->super->s_mmp_block);
+#ifdef	HAVE_PTHREAD
+	pthread_mutex_init(&ctx->fs_fix_mutex, NULL);
+	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
+#endif
 
 	return 0;
 }
@@ -1302,12 +1339,17 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
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
 
@@ -1816,10 +1858,11 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				failed_csum = 0;
 			}
 
-			e2fsck_pass1_block_map_lock(ctx);
-			pctx.errcode = ext2fs_copy_bitmap(ctx->block_found_map,
-							  &pb.fs_meta_blocks);
-			e2fsck_pass1_block_map_unlock(ctx);
+			e2fsck_pass1_block_map_r_lock(ctx);
+			pctx.errcode = ext2fs_copy_bitmap(ctx->global_ctx ?
+					ctx->global_ctx->block_found_map :
+					ctx->block_found_map, &pb.fs_meta_blocks);
+			e2fsck_pass1_block_map_r_unlock(ctx);
 			if (pctx.errcode) {
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
@@ -2381,7 +2424,7 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 
 	assert(global_ctx->block_found_map != NULL);
 	assert(global_ctx->block_metadata_map != NULL);
-	assert(global_ctx->block_dup_map == NULL);
+	assert(global_ctx->block_dup_map != NULL);
 	assert(global_ctx->block_ea_map == NULL);
 	assert(global_ctx->fs->dblist == NULL);
 
@@ -2391,6 +2434,14 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		return retval;
 	}
 	memcpy(thread_context, global_ctx, sizeof(struct e2fsck_struct));
+	thread_context->block_dup_map = NULL;
+
+	retval = e2fsck_allocate_block_bitmap(global_ctx->fs,
+				_("in-use block map"), EXT2FS_BMAP64_RBTREE,
+				"block_found_map", &thread_context->block_found_map);
+	if (retval)
+		goto out_context;
+
 	thread_context->global_ctx = global_ctx;
 	retval = ext2fs_clone_fs(global_fs, &thread_fs,
 							 EXT2FS_CLONE_BLOCK | EXT2FS_CLONE_INODE |
@@ -2442,6 +2493,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 out_fs:
 	ext2fs_merge_fs(&thread_fs);
 out_context:
+	if (thread_context->block_found_map)
+		ext2fs_free_mem(&thread_context->block_found_map);
 	ext2fs_free_mem(&thread_context);
 	return retval;
 }
@@ -2696,7 +2749,6 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
 	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
 	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap block_dup_map = global_ctx->block_dup_map;
 	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
 	ext2_icount_t inode_count = global_ctx->inode_count;
 	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
@@ -2732,6 +2784,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
+	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
+	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf old_jmp;
@@ -2751,6 +2805,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
 	global_ctx->inode_reg_map = inode_reg_map;
 	global_ctx->block_dup_map = block_dup_map;
+	global_ctx->block_found_map = block_found_map;
 	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 	global_ctx->dx_dir_info = dx_dir_info;
@@ -2867,6 +2922,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	if (retval)
 		return retval;
 
+	if (ext2fs_has_feature_shared_blocks(global_fs->super) &&
+	    !(global_ctx->options & E2F_OPT_UNSHARE_BLOCKS))
+		return 0;
+	/*
+	 * This need be done after merging block_ea_map
+	 * because ea block might be shared, we need exclude
+	 * them from dup blocks.
+	 */
+	e2fsck_pass1_block_map_w_lock(thread_ctx);
+	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
+				     global_ctx->block_found_map,
+				     global_ctx->block_dup_map,
+				     global_ctx->block_ea_map);
+	e2fsck_pass1_block_map_w_unlock(thread_ctx);
+	if (retval == EEXIST)
+		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
+
 	return retval;
 }
 
@@ -2882,6 +2954,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_imagic_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inode_reg_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->inodes_to_rebuild);
+	e2fsck_pass1_free_bitmap(&thread_ctx->block_found_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	if (thread_ctx->refcount)
 		ea_refcount_free(thread_ctx->refcount);
@@ -3081,8 +3154,6 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	int num_threads = 1;
 	errcode_t retval;
 
-	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
-	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, num_threads, global_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, retval,
@@ -3356,54 +3427,27 @@ static void alloc_imagic_map(e2fsck_t ctx)
  * WARNING: Assumes checks have already been done to make sure block
  * is valid.  This is true in both process_block and process_bad_block.
  */
-static _INLINE_ void mark_block_used_unlocked(e2fsck_t ctx, blk64_t block)
+static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 {
 	struct problem_context pctx;
-	e2fsck_t global_ctx;
-
-	global_ctx = ctx->global_ctx;
-	if (!global_ctx)
-		global_ctx = ctx;
+	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	clear_problem_context(&pctx);
 
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
 }
 
-static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
-{
-	e2fsck_pass1_block_map_lock(ctx);
-	mark_block_used_unlocked(ctx, block);
-	e2fsck_pass1_block_map_unlock(ctx);
-
-}
-
 /*
  * When cluster size is greater than one block, it is caller's responsibility
  * to make sure block parameter starts at a cluster boundary.
@@ -3411,16 +3455,14 @@ static _INLINE_ void mark_block_used(e2fsck_t ctx, blk64_t block)
 static _INLINE_ void mark_blocks_used(e2fsck_t ctx, blk64_t block,
 				      unsigned int num)
 {
-	e2fsck_pass1_block_map_lock(ctx);
-	if (ext2fs_test_block_bitmap_range2(ctx->block_found_map, block, num)) {
+	if (!is_blocks_used(ctx, block, num)) {
 		ext2fs_mark_block_bitmap_range2(ctx->block_found_map, block, num);
 	} else {
 		unsigned int i;
 
 		for (i = 0; i < num; i += EXT2FS_CLUSTER_RATIO(ctx->fs))
-			mark_block_used_unlocked(ctx, block + i);
+			mark_block_used(ctx, block + i);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 }
 
 static errcode_t _INLINE_ e2fsck_write_ext_attr3(e2fsck_t ctx, blk64_t block,
@@ -3753,7 +3795,12 @@ refcount_fail:
 	inc_ea_inode_refs(ctx, pctx, first, end);
 	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
 	ea_refcount_store(ctx->refcount_orig, blk, header->h_refcount);
-	mark_block_used(ctx, blk);
+	/**
+	 * It might be racy that this block has been merged in the
+	 * global found map.
+	 */
+	if (!is_blocks_used(ctx, blk, 1))
+		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, blk);
 	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
 
@@ -5038,31 +5085,24 @@ static int process_bad_block(ext2_filsys fs,
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
-			if (e2fsck_should_abort(ctx)) {
-				e2fsck_pass1_block_map_unlock(ctx);
+			if (e2fsck_should_abort(ctx))
 				return BLOCK_ABORT;
-			}
 		} else {
-			mark_block_used_unlocked(ctx, blk);
+			mark_block_used(ctx, blk);
 		}
-		e2fsck_pass1_block_map_unlock(ctx);
 		return 0;
 	}
 #if 0
@@ -5075,13 +5115,10 @@ static int process_bad_block(ext2_filsys fs,
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
@@ -5236,7 +5273,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 	fix_problem(ctx, (old_block ? PR_1_RELOC_FROM_TO :
 			  PR_1_RELOC_TO), &pctx);
 	pctx.blk2 = 0;
-	e2fsck_pass1_block_map_lock(ctx);
 	for (i = 0; i < num; i++) {
 		pctx.blk = i;
 		ext2fs_mark_block_bitmap2(ctx->block_found_map, (*new_block)+i);
@@ -5257,7 +5293,6 @@ static void new_table_block(e2fsck_t ctx, blk64_t first_block, dgrp_t group,
 		if (pctx.errcode)
 			fix_problem(ctx, PR_1_RELOC_WRITE_ERR, &pctx);
 	}
-	e2fsck_pass1_block_map_unlock(ctx);
 	ext2fs_free_mem(&buf);
 }
 
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 93cd96c7..5714576a 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -592,17 +592,29 @@ void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
 }
 
-void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_wrlock(&global_ctx->fs_block_map_rwlock);
 }
 
-void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
 }
+
+void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_rdlock(&global_ctx->fs_block_map_rwlock);
+}
+
+void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
+ }
 #else
 void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
@@ -613,14 +625,24 @@ void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
 
 }
+void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
+{
 
-void e2fsck_pass1_block_map_lock(e2fsck_t ctx)
+}
+
+void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
 
 }
 
-void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
+void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
 {
+
+}
+
+void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
+{
+
 }
 #endif
 
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
2.37.3

