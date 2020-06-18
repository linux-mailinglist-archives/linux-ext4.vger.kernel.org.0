Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED8B1FF6DF
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731675AbgFRPaC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731650AbgFRP3u (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B287BC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:50 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so2833318pjv.2
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=33kbnwTOZH+wDbnMAuYfl2VfPhjTx8r4vMKN5gBEIPo=;
        b=EWjusdnHi5mLoMLsSGjYR8yrnyYQNrlTJx5hrw8z3V4xBA76jBR7M79Bx2UIsiJccI
         t8CUCh6YgV0ppny2z4bTBicRIMOSrTIWlgLQPPW84ggMXC6x9UCedHaVJZ8NhZRVz7Bt
         dgrXz4jUQe9EftMdxbugLhOsA6h3ur4mF9ZLk596GY/oD96JFmO8l6SF83wKlHfJxxua
         sJTnisGsr2JMFWmKwTh/DCELtqn0LJgZnDs2fdqS3pUMZA6yhlOYEVXgWlw4AuK084AT
         LGIp7aCYguJYTmB1wcsSskY+bX/8R6MUYA/DMnK6bJf56gj8V2SOghFAFc/fk+wr1TIG
         yA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=33kbnwTOZH+wDbnMAuYfl2VfPhjTx8r4vMKN5gBEIPo=;
        b=KWyiXRSmTVk/IdiIhn2RKLFk4HaRy7ppWwebYTd4ODk5m2cJl6NZBb+4O0y66FGI1j
         tNJVOnIfXYsKVOa0chhcmVVJHAtwNsWVULL65e7DUlW7PvCx1Y+8RB2vjW63YPrRx48B
         D+VHNPRpqrh9x9CoObqJe5qRQ2sxSXRGt9dU3ajDxgp2U1+9ixFogK4yXE50kt5DcxPI
         KBWneMZtyy3QwQ+YER8KqlLXno2REyRXHK9pnecFX3InwlS63QZKWBw8ZYkbH29hAhqP
         ThwNaZ/zgmSpdbydoviqb4QyXVJfrUnN/zIlzdxpuu1VJYsnPCQ1ln4Za+2oYniy7fqE
         tVfw==
X-Gm-Message-State: AOAM533tnOp0sNI5FW2FYWA8RDjebrI4ZYn7gvSphj5zq/fhCSHn2dns
        MqORgHZW2ncN/GksSIY/KEmDTYJrziE=
X-Google-Smtp-Source: ABdhPJzagG0YnOyk1Ydaksuvg1LhScM2U865rLyBFRkdUTiR70TvjF6eSpetg5vjfWHWnkwC7Snsag==
X-Received: by 2002:a17:90a:8b98:: with SMTP id z24mr5071742pjn.159.1592494189306;
        Thu, 18 Jun 2020 08:29:49 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:48 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 40/51] e2fsck: kick off ea mutex lock from pfsck
Date:   Fri, 19 Jun 2020 00:27:43 +0900
Message-Id: <1592494074-28991-41-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

With this patch, we no longer share ea related
refcounts globally, so that mutex lock for ea could
be dropped, this is important for Lustre, since Lustre
backend filesystem use xattrs heavily.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h           |   3 +-
 e2fsck/pass1.c            | 310 +++++++++++++++++++++++++++++---------
 lib/ext2fs/bitmaps.c      |   6 +-
 lib/ext2fs/blkmap64_rb.c  |  20 ++-
 lib/ext2fs/bmap64.h       |   3 +-
 lib/ext2fs/ext2fs.h       |   6 +-
 lib/ext2fs/gen_bitmap64.c |  15 +-
 lib/ext2fs/icount.c       |   5 +-
 8 files changed, 277 insertions(+), 91 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 83be5353..153f2e21 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -365,6 +365,7 @@ struct e2fsck_struct {
 
 	ext2_refcount_t		refcount;
 	ext2_refcount_t		refcount_extra;
+	ext2_refcount_t		refcount_orig;
 
 	/*
 	 * Quota blocks and inodes to be charged for each ea block.
@@ -450,8 +451,6 @@ struct e2fsck_struct {
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
 	pthread_rwlock_t	 fs_block_map_rwlock;
-	/* protect ea related structure */
-	pthread_mutex_t		 fs_ea_mutex;
 };
 
 #ifdef DEBUG_THREADS
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 457c713f..ac3ffa7b 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -173,18 +173,6 @@ static inline void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
 	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
 }
 
-static inline void e2fsck_pass1_ea_lock(e2fsck_t ctx)
-{
-	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_ea_mutex);
-}
-
-static inline void e2fsck_pass1_ea_unlock(e2fsck_t ctx)
-{
-	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_ea_mutex);
-}
-
 /*
  * Check to make sure a device inode is real.  Returns 1 if the device
  * checks out, 0 if not.
@@ -453,16 +441,15 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 			      struct ext2_ext_attr_entry *first, void *end)
 {
 	struct ext2_ext_attr_entry *entry;
-	e2fsck_t global_ctx = ctx->global_ctx ? ctx->global_ctx : ctx;
 
 	for (entry = first;
 	     (void *)entry < end && !EXT2_EXT_IS_LAST_ENTRY(entry);
 	     entry = EXT2_EXT_ATTR_NEXT(entry)) {
 		if (!entry->e_value_inum)
 			continue;
-		if (!global_ctx->ea_inode_refs) {
+		if (!ctx->ea_inode_refs) {
 			pctx->errcode = ea_refcount_create(0,
-						&global_ctx->ea_inode_refs);
+						&ctx->ea_inode_refs);
 			if (pctx->errcode) {
 				pctx->num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
@@ -470,7 +457,7 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 				return;
 			}
 		}
-		ea_refcount_increment(global_ctx->ea_inode_refs,
+		ea_refcount_increment(ctx->ea_inode_refs,
 				      entry->e_value_inum, 0);
 	}
 }
@@ -597,10 +584,8 @@ fix:
 	 * EA(s) in automatic fashion -bzzz
 	 */
 	if (problem == 0 || !fix_problem(ctx, problem, pctx)) {
-		e2fsck_pass1_ea_lock(ctx);
 		inc_ea_inode_refs(ctx, pctx,
 				  (struct ext2_ext_attr_entry *)start, end);
-		e2fsck_pass1_ea_unlock(ctx);
 		return;
 	}
 
@@ -1414,16 +1399,6 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
 		ctx->refcount_extra = 0;
 	}
 
-	if (ctx->ea_block_quota_blocks) {
-		ea_refcount_free(ctx->ea_block_quota_blocks);
-		ctx->ea_block_quota_blocks = 0;
-	}
-
-	if (ctx->ea_block_quota_inodes) {
-		ea_refcount_free(ctx->ea_block_quota_inodes);
-		ctx->ea_block_quota_inodes = 0;
-	}
-
 	if (ctx->invalid_bitmaps)
 		handle_fs_bad_blocks(ctx);
 
@@ -2316,6 +2291,16 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	/* We don't need the encryption policy => ID map any more */
 	destroy_encryption_policy_map(ctx);
 
+	if (ctx->ea_block_quota_blocks) {
+		ea_refcount_free(ctx->ea_block_quota_blocks);
+		ctx->ea_block_quota_blocks = 0;
+	}
+
+	if (ctx->ea_block_quota_inodes) {
+		ea_refcount_free(ctx->ea_block_quota_inodes);
+		ctx->ea_block_quota_inodes = 0;
+	}
+
 	if (ctx->flags & E2F_FLAG_RESTART) {
 		/*
 		 * Only the master copy of the superblock and block
@@ -2373,7 +2358,8 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field, NULL);\
+						   _dest->_map_field, NULL,\
+						   NULL);		\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2390,7 +2376,8 @@ do {									\
 			_src->_map_field = NULL;			\
 		} else {						\
 			_ret = ext2fs_merge_bitmap(_src->_map_field,	\
-						   _dest->_map_field, NULL);\
+						   _dest->_map_field, NULL,\
+						   NULL);		\
 			if (_ret)					\
 				return _ret;				\
 		}							\
@@ -2855,6 +2842,157 @@ static void e2fsck_pass1_merge_quota_ctx(e2fsck_t global_ctx, e2fsck_t thread_ct
 	quota_release_context(&thread_ctx->qctx);
 }
 
+static errcode_t e2fsck_pass1_merge_ea_inode_refs(e2fsck_t global_ctx,
+						  e2fsck_t thread_ctx)
+{
+	ea_value_t count;
+	blk64_t blk;
+	errcode_t retval;
+
+	if (!thread_ctx->ea_inode_refs)
+		return 0;
+
+	if (!global_ctx->ea_inode_refs) {
+		global_ctx->ea_inode_refs = thread_ctx->ea_inode_refs;
+		thread_ctx->ea_inode_refs = NULL;
+		return 0;
+	}
+
+	ea_refcount_intr_begin(thread_ctx->ea_inode_refs);
+	while (1) {
+		if ((blk = ea_refcount_intr_next(thread_ctx->ea_inode_refs,
+						 &count)) == 0)
+			break;
+		if (!global_ctx->block_ea_map ||
+		    !ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+						    blk)) {
+			retval = ea_refcount_store(global_ctx->ea_inode_refs,
+						   blk, count);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return retval;
+}
+
+static ea_value_t ea_refcount_usage(e2fsck_t ctx, blk64_t blk,
+				    ea_value_t *orig)
+{
+	ea_value_t count_cur;
+	ea_value_t count_extra = 0;
+	ea_value_t count_orig;
+
+	ea_refcount_fetch(ctx->refcount_orig, blk, &count_orig);
+	ea_refcount_fetch(ctx->refcount, blk, &count_cur);
+	/* most of time this is not needed */
+	if (ctx->refcount_extra && count_cur == 0)
+		ea_refcount_fetch(ctx->refcount_extra, blk, &count_extra);
+
+	if (!count_orig)
+		count_orig = *orig;
+	else if (orig)
+		*orig = count_orig;
+
+	return count_orig + count_extra - count_cur;
+}
+
+static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
+						e2fsck_t thread_ctx)
+{
+	ea_value_t count;
+	blk64_t blk;
+	errcode_t retval = 0;
+
+	if (!thread_ctx->refcount)
+		return 0;
+
+	if (!global_ctx->refcount) {
+		global_ctx->refcount = thread_ctx->refcount;
+		thread_ctx->refcount = NULL;
+		global_ctx->refcount_extra = thread_ctx->refcount;
+		thread_ctx->refcount_extra = NULL;
+		return 0;
+	}
+
+	ea_refcount_intr_begin(thread_ctx->refcount);
+	while (1) {
+		if ((blk = ea_refcount_intr_next(thread_ctx->refcount,
+						 &count)) == 0)
+			break;
+		/**
+		 * this EA has never seen before, so just store its
+		 * refcount and refcount_extra into global_ctx if needed.
+		 */
+		if (!global_ctx->block_ea_map ||
+		    !ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+					   	    blk)) {
+			ea_value_t extra;
+
+			retval = ea_refcount_store(global_ctx->refcount,
+						   blk, count);
+			if (retval)
+				return retval;
+
+			if (count > 0 || !thread_ctx->refcount_extra)
+				continue;
+			ea_refcount_fetch(thread_ctx->refcount_extra, blk,
+					  &extra);
+			if (extra == 0)
+				continue;
+
+			if (!global_ctx->refcount_extra) {
+				retval = ea_refcount_create(0,
+					&global_ctx->refcount_extra);
+				if (retval)
+					return retval;
+			}
+			retval = ea_refcount_store(global_ctx->refcount_extra,
+						   blk, extra);
+			if (retval)
+				return retval;
+			
+		} else {
+			ea_value_t orig;
+			ea_value_t thread_usage;
+			ea_value_t global_usage;
+			ea_value_t new;
+
+			thread_usage = ea_refcount_usage(thread_ctx,
+							 blk, &orig);
+			global_usage = ea_refcount_usage(global_ctx,
+							 blk, &orig);
+			if (thread_usage + global_usage <= orig) {
+				new = orig - thread_usage - global_usage;
+				retval = ea_refcount_store(global_ctx->refcount,
+							   blk, new);
+				if (retval)
+					return retval;
+				continue;
+			}
+			/* update it is as zero */
+			retval = ea_refcount_store(global_ctx->refcount,
+						   blk, 0);
+			if (retval)
+				return retval;
+			/* Ooops, this EA was referenced more than it stated */
+			if (!global_ctx->refcount_extra) {
+				retval = ea_refcount_create(0,
+					   	&global_ctx->refcount_extra);
+				if (retval)
+					return retval;
+			}
+			new = global_usage + thread_usage - orig;
+			retval = ea_refcount_store(global_ctx->refcount_extra,
+						   blk, new);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return retval;
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	 retval;
@@ -2900,6 +3038,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 	ext2_refcount_t refcount = global_ctx->refcount;
 	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
+	ext2_refcount_t refcount_orig = global_ctx->refcount_orig;
 	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
@@ -2935,6 +3074,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_link_info = inode_link_info;
 	global_ctx->refcount = refcount;
 	global_ctx->refcount_extra = refcount_extra;
+	global_ctx->refcount_orig = refcount_orig;
 	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
 	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
 	global_ctx->block_ea_map = block_ea_map;
@@ -2981,15 +3121,10 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		com_err(global_ctx->program_name, 0, _("while merging dirs to hash\n"));
 		return retval;
 	}
+	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
 	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
-	e2fsck_pass1_block_map_w_lock(thread_ctx);
-	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
-				     global_ctx->block_found_map,
-				     global_ctx->block_dup_map);
-	e2fsck_pass1_block_map_w_unlock(thread_ctx);
-	if (retval == EEXIST)
-		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
 	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
 	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
 	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
@@ -3006,8 +3141,23 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
 
-	return 0;
+	/*
+	 * This need be done after merging block_ea_map
+	 * because ea block might be shared, we need exclude
+	 * them from dup blocks.
+	 */
+	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
+				     global_ctx->block_found_map,
+				     global_ctx->block_dup_map,
+				     global_ctx->block_ea_map);
+	if (retval == EEXIST) {
+		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
+		retval = 0;
+	}
+
+	return retval;
 }
 
 static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
@@ -3029,8 +3179,25 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inode_reg_map);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, inodes_to_rebuild);
 	PASS1_FREE_CTX_BITMAP(thread_ctx, block_found_map);
+	PASS1_FREE_CTX_BITMAP(thread_ctx, block_ea_map);
 	ext2fs_free_icount(thread_ctx->inode_count);
 	ext2fs_free_icount(thread_ctx->inode_link_info);
+	if (thread_ctx->refcount) {
+		ea_refcount_free(thread_ctx->refcount);
+		thread_ctx->refcount = NULL;
+	}
+	if (thread_ctx->refcount_extra) {
+		ea_refcount_free(thread_ctx->refcount_extra);
+		thread_ctx->refcount_extra = NULL;
+	}
+	if (thread_ctx->ea_inode_refs) {
+		ea_refcount_free(thread_ctx->ea_inode_refs);
+		thread_ctx->ea_inode_refs = NULL;
+	}
+	if (thread_ctx->refcount_orig) {
+		ea_refcount_free(thread_ctx->refcount_orig);
+		thread_ctx->refcount_orig = NULL;
+	}
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
@@ -3233,7 +3400,6 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_rwlock_init(&global_ctx->fs_block_map_rwlock, NULL);
-	pthread_mutex_init(&global_ctx->fs_ea_mutex, NULL);
 	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
 	if (retval) {
@@ -3567,30 +3733,35 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 	}
 
 	/* If ea bitmap hasn't been allocated, create it */
-	e2fsck_pass1_ea_lock(ctx);
-	if (!global_ctx->block_ea_map) {
+	if (!ctx->block_ea_map) {
 		pctx->errcode = e2fsck_allocate_block_bitmap(fs,
 					_("ext attr block map"),
 					EXT2FS_BMAP64_RBTREE, "block_ea_map",
-					&global_ctx->block_ea_map);
+					&ctx->block_ea_map);
 		if (pctx->errcode) {
 			pctx->num = 2;
 			fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
-			e2fsck_pass1_ea_unlock(ctx);
 			return 0;
 		}
 	}
 
 	/* Create the EA refcount structure if necessary */
-	if (!global_ctx->refcount) {
+	if (!ctx->refcount) {
 		pctx->errcode = ea_refcount_create(0,
-					&global_ctx->refcount);
+					&ctx->refcount);
+		if (pctx->errcode) {
+			pctx->num = 1;
+			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			return 0;
+		}
+		pctx->errcode = ea_refcount_create(0,
+					&ctx->refcount_orig);
 		if (pctx->errcode) {
 			pctx->num = 1;
 			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
-			e2fsck_pass1_ea_unlock(ctx);
 			return 0;
 		}
 	}
@@ -3601,44 +3772,39 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 #endif
 
 	/* Have we seen this EA block before? */
-	if (ext2fs_fast_test_block_bitmap2(global_ctx->block_ea_map,
+	if (ext2fs_fast_test_block_bitmap2(ctx->block_ea_map,
 					   blk)) {
 		ea_block_quota->blocks = EXT2FS_C2B(fs, 1);
 		ea_block_quota->inodes = 0;
 
-		if (global_ctx->ea_block_quota_blocks) {
-			ea_refcount_fetch(global_ctx->ea_block_quota_blocks,
+		if (ctx->ea_block_quota_blocks) {
+			ea_refcount_fetch(ctx->ea_block_quota_blocks,
 					  blk, &quota_blocks);
 			if (quota_blocks)
 				ea_block_quota->blocks = quota_blocks;
 		}
 
-		if (global_ctx->ea_block_quota_inodes)
-			ea_refcount_fetch(global_ctx->ea_block_quota_inodes,
+		if (ctx->ea_block_quota_inodes)
+			ea_refcount_fetch(ctx->ea_block_quota_inodes,
 					  blk, &ea_block_quota->inodes);
 
-		if (ea_refcount_decrement(global_ctx->refcount,
-					  blk, 0) == 0) {
-			e2fsck_pass1_ea_unlock(ctx);
+		if (ea_refcount_decrement(ctx->refcount,
+					  blk, 0) == 0)
 			return 1;
-		}
 		/* Ooops, this EA was referenced more than it stated */
-		if (!global_ctx->refcount_extra) {
+		if (!ctx->refcount_extra) {
 			pctx->errcode = ea_refcount_create(0,
-					   &global_ctx->refcount_extra);
+					   &ctx->refcount_extra);
 			if (pctx->errcode) {
 				pctx->num = 2;
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
-				e2fsck_pass1_ea_unlock(ctx);
 				return 0;
 			}
 		}
-		ea_refcount_increment(global_ctx->refcount_extra, blk, 0);
-		e2fsck_pass1_ea_unlock(ctx);
+		ea_refcount_increment(ctx->refcount_extra, blk, 0);
 		return 1;
 	}
-	e2fsck_pass1_ea_unlock(ctx);
 
 	/*
 	 * OK, we haven't seen this EA block yet.  So we need to
@@ -3765,50 +3931,48 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
 			return 0;
 	}
 
-	e2fsck_pass1_ea_lock(ctx);
 	if (quota_blocks != EXT2FS_C2B(fs, 1U)) {
-		if (!global_ctx->ea_block_quota_blocks) {
+		if (!ctx->ea_block_quota_blocks) {
 			pctx->errcode = ea_refcount_create(0,
-					&global_ctx->ea_block_quota_blocks);
+					&ctx->ea_block_quota_blocks);
 			if (pctx->errcode) {
 				pctx->num = 3;
 				goto refcount_fail;
 			}
 		}
-		ea_refcount_store(global_ctx->ea_block_quota_blocks,
+		ea_refcount_store(ctx->ea_block_quota_blocks,
 				  blk, quota_blocks);
 	}
 
 	if (quota_inodes) {
-		if (!global_ctx->ea_block_quota_inodes) {
+		if (!ctx->ea_block_quota_inodes) {
 			pctx->errcode = ea_refcount_create(0,
-					&global_ctx->ea_block_quota_inodes);
+					&ctx->ea_block_quota_inodes);
 			if (pctx->errcode) {
 				pctx->num = 4;
 refcount_fail:
 				fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
-				e2fsck_pass1_ea_unlock(ctx);
 				return 0;
 			}
 		}
 
-		ea_refcount_store(global_ctx->ea_block_quota_inodes,
+		ea_refcount_store(ctx->ea_block_quota_inodes,
 				  blk, quota_inodes);
 	}
 	ea_block_quota->blocks = quota_blocks;
 	ea_block_quota->inodes = quota_inodes;
 
-	inc_ea_inode_refs(global_ctx, pctx, first, end);
-	ea_refcount_store(global_ctx->refcount, blk, header->h_refcount - 1);
+	inc_ea_inode_refs(ctx, pctx, first, end);
+	ea_refcount_store(ctx->refcount, blk, header->h_refcount - 1);
+	ea_refcount_store(ctx->refcount_orig, blk, header->h_refcount);
 	/**
 	 * It might be racy that this block has been merged in the
 	 * global found map.
 	 */
 	if (!is_blocks_used(ctx, blk, 1))
 		ext2fs_fast_mark_block_bitmap2(ctx->block_found_map, blk);
-	ext2fs_fast_mark_block_bitmap2(global_ctx->block_ea_map, blk);
-	e2fsck_pass1_ea_unlock(ctx);
+	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
 
 clear_extattr:
diff --git a/lib/ext2fs/bitmaps.c b/lib/ext2fs/bitmaps.c
index 4cd664d3..000df234 100644
--- a/lib/ext2fs/bitmaps.c
+++ b/lib/ext2fs/bitmaps.c
@@ -48,9 +48,11 @@ errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 
 errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
 			      ext2fs_generic_bitmap dest,
-			      ext2fs_generic_bitmap dup)
+			      ext2fs_generic_bitmap dup,
+			      ext2fs_generic_bitmap dup_allowed)
 {
-	return ext2fs_merge_generic_bmap(src, dest, dup);
+	return ext2fs_merge_generic_bmap(src, dest, dup,
+					 dup_allowed);
 }
 
 void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map)
diff --git a/lib/ext2fs/blkmap64_rb.c b/lib/ext2fs/blkmap64_rb.c
index 2337302f..3ec4f4de 100644
--- a/lib/ext2fs/blkmap64_rb.c
+++ b/lib/ext2fs/blkmap64_rb.c
@@ -970,7 +970,8 @@ static void rb_print_stats(ext2fs_generic_bitmap_64 bitmap EXT2FS_ATTR((unused))
 
 static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
 			       ext2fs_generic_bitmap_64 dest,
-			       ext2fs_generic_bitmap_64 dup)
+			       ext2fs_generic_bitmap_64 dup,
+			       ext2fs_generic_bitmap_64 dup_allowed)
 {
 	struct ext2fs_rb_private *src_bp, *dest_bp, *dup_bp = NULL;
 	struct bmap_rb_extent *src_ext;
@@ -1004,9 +1005,20 @@ static errcode_t rb_merge_bmap(ext2fs_generic_bitmap_64 src,
 				if (retval) {
 					rb_insert_extent(i, 1, dest_bp);
 				} else {
-					if (dup_bp)
-						rb_insert_extent(i, 1, dup_bp);
-					dup_found = 1;
+					if (dup_allowed) {
+						retval = rb_test_clear_bmap_extent(dup_allowed,
+									i + src->start, 1);
+						/* not existed in dup_allowed */
+						if (retval) {
+							dup_found = 1;
+							if (dup_bp)
+								rb_insert_extent(i, 1, dup_bp);
+						} /* else we conside it not duplicated */
+					} else {
+						if (dup_bp)
+							rb_insert_extent(i, 1, dup_bp);
+						dup_found = 1;
+					}
 				}
 			}
 		}
diff --git a/lib/ext2fs/bmap64.h b/lib/ext2fs/bmap64.h
index 68a4bb0a..555193ee 100644
--- a/lib/ext2fs/bmap64.h
+++ b/lib/ext2fs/bmap64.h
@@ -74,7 +74,8 @@ struct ext2_bitmap_ops {
 			     ext2fs_generic_bitmap_64 dest);
 	errcode_t (*merge_bmap)(ext2fs_generic_bitmap_64 src,
 				ext2fs_generic_bitmap_64 dest,
-				ext2fs_generic_bitmap_64 dup);
+				ext2fs_generic_bitmap_64 dup,
+				ext2fs_generic_bitmap_64 dup_allowed);
 	errcode_t (*resize_bmap)(ext2fs_generic_bitmap_64 bitmap,
 			       __u64 new_end,
 			       __u64 new_real_end);
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 38ae2dee..44e569e6 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -842,7 +842,8 @@ extern errcode_t ext2fs_copy_bitmap(ext2fs_generic_bitmap src,
 
 extern errcode_t ext2fs_merge_bitmap(ext2fs_generic_bitmap src,
 				     ext2fs_generic_bitmap dest,
-				     ext2fs_generic_bitmap dup);
+				     ext2fs_generic_bitmap dup,
+				     ext2fs_generic_bitmap dup_allowed);
 extern errcode_t ext2fs_write_inode_bitmap(ext2_filsys fs);
 extern errcode_t ext2fs_write_block_bitmap (ext2_filsys fs);
 extern errcode_t ext2fs_read_inode_bitmap (ext2_filsys fs);
@@ -1442,7 +1443,8 @@ errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap bmap,
 				     __u64 new_real_end);
 errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
                                     ext2fs_generic_bitmap gen_dest,
-				    ext2fs_generic_bitmap gen_dup);
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap dup_allowed);
 errcode_t ext2fs_compare_generic_bmap(errcode_t neq,
 				      ext2fs_generic_bitmap bm1,
 				      ext2fs_generic_bitmap bm2);
diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
index c27a52e4..a8f8fde2 100644
--- a/lib/ext2fs/gen_bitmap64.c
+++ b/lib/ext2fs/gen_bitmap64.c
@@ -341,31 +341,36 @@ errcode_t ext2fs_copy_generic_bmap(ext2fs_generic_bitmap gen_src,
 
 errcode_t ext2fs_merge_generic_bmap(ext2fs_generic_bitmap gen_src,
 				    ext2fs_generic_bitmap gen_dest,
-				    ext2fs_generic_bitmap gen_dup)
+				    ext2fs_generic_bitmap gen_dup,
+				    ext2fs_generic_bitmap gen_dup_allowed)
 {
 	ext2fs_generic_bitmap_64 src = (ext2fs_generic_bitmap_64) gen_src;
 	ext2fs_generic_bitmap_64 dest = (ext2fs_generic_bitmap_64) gen_dest;
 	ext2fs_generic_bitmap_64 dup = (ext2fs_generic_bitmap_64) gen_dup;
+	ext2fs_generic_bitmap_64 dup_allowed = (ext2fs_generic_bitmap_64) gen_dup_allowed;
 
 	if (!src || !dest)
 		return EINVAL;
 
 	if (!EXT2FS_IS_64_BITMAP(src) || !EXT2FS_IS_64_BITMAP(dest) ||
-	    (dup && !EXT2FS_IS_64_BITMAP(dup)))
+	    (dup && !EXT2FS_IS_64_BITMAP(dup)) || (dup_allowed &&
+		!EXT2FS_IS_64_BITMAP(dup_allowed)))
 		return EINVAL;
 
 	if (src->bitmap_ops != dest->bitmap_ops ||
-	    (dup && src->bitmap_ops != dup->bitmap_ops))
+	    (dup && src->bitmap_ops != dup->bitmap_ops) ||
+	    (dup_allowed && src->bitmap_ops != dup_allowed->bitmap_ops))
 		return EINVAL;
 
 	if (src->cluster_bits != dest->cluster_bits ||
-	    (dup && dup->cluster_bits != src->cluster_bits))
+	    (dup && dup->cluster_bits != src->cluster_bits) ||
+	    (dup_allowed && dup->cluster_bits != dup_allowed->cluster_bits))
 		return EINVAL;
 
 	if (src->bitmap_ops->merge_bmap == NULL)
 		return EOPNOTSUPP;
 
-	return src->bitmap_ops->merge_bmap(src, dest, dup);
+	return src->bitmap_ops->merge_bmap(src, dest, dup, dup_allowed);
 }
 
 errcode_t ext2fs_resize_generic_bmap(ext2fs_generic_bitmap gen_bmap,
diff --git a/lib/ext2fs/icount.c b/lib/ext2fs/icount.c
index 7ec490dc..8fe6ff4e 100644
--- a/lib/ext2fs/icount.c
+++ b/lib/ext2fs/icount.c
@@ -786,13 +786,14 @@ errcode_t ext2fs_icount_merge(ext2_icount_t src, ext2_icount_t dest)
 		return ext2fs_icount_merge_full_map(src, dest);
 
 	retval = ext2fs_merge_bitmap(src->single,
-				     dest->single, NULL);
+				     dest->single, NULL, NULL);
 	if (retval)
 		return retval;
 
 	if (src->multiple) {
 		retval = ext2fs_merge_bitmap(src->multiple,
-					     dest->multiple, NULL);
+					     dest->multiple, NULL,
+					     NULL);
 		if (retval)
 			return retval;
 	}
-- 
2.25.4

