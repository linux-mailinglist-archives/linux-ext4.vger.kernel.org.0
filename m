Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363BA1A1F12
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgDHKq6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40661 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKq6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id c20so2225332pfi.7
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TkttZMbI5YmsiyEYMKmULwkeHyD5ZLQHYlN7QL62d5o=;
        b=nqzTHDqT/tnoE4/g+ZgR9LRSRYSrOXR4vO9IpWimvMES+7saxwKe/tk0x9mr9po8dX
         PawI5YG6hxe//v54dKa5ZGd/wyP4YqKsQUlJuJrSM5wA6nv8Z8swx1sLtOSynb8R7fpt
         0u2N0whNHOuqcgvGNiB3gVpambUsJgaZZP9Mcf452P+lJngpUHH/HEjqq/9wmD2fmkn9
         4NiP825FzTTeHGYo7cdi56k8alV8pcFsozr8lRJIbqvfuG2E/wVC04om7rTca5S7DQC1
         OcthbI3pbr6Ooei/J66bIkiUDDKDWqzw8ooYLaNQ/oYInyq0NEuzeo4FNpFt/GbOobDg
         a3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TkttZMbI5YmsiyEYMKmULwkeHyD5ZLQHYlN7QL62d5o=;
        b=C3E0WKWRSEk31DADOq8Mq/Fq+2HzsegILuT/iPTC0CWJRlC0ApfJAT8Y45BeDbxnwD
         ntlqMn/fAs1fldCpx8fKtnTh9hdl5umhecc9oO4xju+heOLGdlzJePrQxSuJLrQ27HJW
         AWe2RV0/E402O8ADO8aLGvKiEpBjQpSSS8MXqkyu9I8hb/3YQBTkpNutyovMIV9qgefL
         /CqmmQJpuFEULYWO3u64SRaH7W75G3/El8s1Y5FOl5c4Sxwo6igIECwzKE1xFicUV6Zd
         T1c9SiUycu96aL1dvc/y1ob7aQi7PAXlQIeG/xhw3CDePqfcTrIOrygG7L5fLAJOZIEK
         uk5Q==
X-Gm-Message-State: AGi0PubdlogjU+kaReJCS3LEOA9gntzIFXVlFkb8gu6P/UqCtR5pVlAW
        OnhFAfkw7VoCwwSq4zt+jjVUP10uKjc=
X-Google-Smtp-Source: APiQypJ/HTanFVZ0U82iQpk479gF6YIYAQOaWgZSMMcmmTYw0Dwom3sZatWQJiH8dKPACtGKg95orQ==
X-Received: by 2002:a62:5e86:: with SMTP id s128mr7354533pfb.157.1586342816428;
        Wed, 08 Apr 2020 03:46:56 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:55 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 39/46] e2fsck: kick off ea mutex lock from pfsck
Date:   Wed,  8 Apr 2020 19:45:07 +0900
Message-Id: <1586342714-12536-40-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/e2fsck.h |   3 +-
 e2fsck/pass1.c  | 279 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 217 insertions(+), 65 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 26ef1d81..b25ee666 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -367,6 +367,7 @@ struct e2fsck_struct {
 
 	ext2_refcount_t		refcount;
 	ext2_refcount_t		refcount_extra;
+	ext2_refcount_t		refcount_orig;
 
 	/*
 	 * Quota blocks and inodes to be charged for each ea block.
@@ -454,8 +455,6 @@ struct e2fsck_struct {
 	pthread_mutex_t		 fs_fix_mutex;
 	/* protect block_found_map, block_dup_map */
 	pthread_mutex_t		 fs_block_map_mutex;
-	/* protect ea related structure */
-	pthread_mutex_t		 fs_ea_mutex;
 };
 
 #ifdef DEBUG_THREADS
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index efd2e72d..127b390d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -161,18 +161,6 @@ static inline void e2fsck_pass1_block_map_unlock(e2fsck_t ctx)
 	pthread_mutex_unlock(&global_ctx->fs_block_map_mutex);
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
  * Free all memory allocated by pass1 in preparation for restarting
  * things.
@@ -451,16 +439,15 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -468,7 +455,7 @@ static void inc_ea_inode_refs(e2fsck_t ctx, struct problem_context *pctx,
 				return;
 			}
 		}
-		ea_refcount_increment(global_ctx->ea_inode_refs,
+		ea_refcount_increment(ctx->ea_inode_refs,
 				      entry->e_value_inum, 0);
 	}
 }
@@ -595,10 +582,8 @@ fix:
 	 * EA(s) in automatic fashion -bzzz
 	 */
 	if (problem == 0 || !fix_problem(ctx, problem, pctx)) {
-		e2fsck_pass1_ea_lock(ctx);
 		inc_ea_inode_refs(ctx, pctx,
 				  (struct ext2_ext_attr_entry *)start, end);
-		e2fsck_pass1_ea_unlock(ctx);
 		return;
 	}
 
@@ -1410,16 +1395,6 @@ static void _e2fsck_pass1_post(e2fsck_t ctx)
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
 
@@ -2315,6 +2290,16 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -2854,6 +2839,155 @@ static void e2fsck_pass1_merge_quota_ctx(e2fsck_t global_ctx, e2fsck_t thread_ct
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
+	if (orig)
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
+							 blk, NULL);
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
@@ -2899,6 +3033,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	int invalid_bitmaps = global_ctx->invalid_bitmaps;
 	ext2_refcount_t refcount = global_ctx->refcount;
 	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
+	ext2_refcount_t refcount_orig = global_ctx->refcount_orig;
 	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
 	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
 	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
@@ -2934,6 +3069,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->inode_link_info = inode_link_info;
 	global_ctx->refcount = refcount;
 	global_ctx->refcount_extra = refcount_extra;
+	global_ctx->refcount_orig = refcount_orig;
 	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
 	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
 	global_ctx->block_ea_map = block_ea_map;
@@ -2979,6 +3115,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 		com_err(global_ctx->program_name, 0, _("while merging dirs to hash\n"));
 		return retval;
 	}
+	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
+	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
 	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
 	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
@@ -3003,6 +3141,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_imagic_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inode_reg_map);
 	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, inodes_to_rebuild);
+	PASS1_MERGE_CTX_BITMAP(global_ctx, thread_ctx, block_ea_map);
 
 	return 0;
 }
@@ -3026,8 +3165,25 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
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
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
@@ -3229,7 +3385,6 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 
 	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
 	pthread_mutex_init(&global_ctx->fs_block_map_mutex, NULL);
-	pthread_mutex_init(&global_ctx->fs_ea_mutex, NULL);
 
 	init_ext2_max_sizes();
 	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
@@ -3564,30 +3719,35 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
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
+		pctx->errcode = ea_refcount_create(0,
+					&ctx->refcount);
+		if (pctx->errcode) {
+			pctx->num = 1;
+			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
+			ctx->flags |= E2F_FLAG_ABORT;
+			return 0;
+		}
 		pctx->errcode = ea_refcount_create(0,
-					&global_ctx->refcount);
+					&ctx->refcount_orig);
 		if (pctx->errcode) {
 			pctx->num = 1;
 			fix_problem(ctx, PR_1_ALLOCATE_REFCOUNT, pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
-			e2fsck_pass1_ea_unlock(ctx);
 			return 0;
 		}
 	}
@@ -3598,44 +3758,39 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
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
@@ -3762,45 +3917,43 @@ static int check_ext_attr(e2fsck_t ctx, struct problem_context *pctx,
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
 	mark_block_used(ctx, blk);
-	ext2fs_fast_mark_block_bitmap2(global_ctx->block_ea_map, blk);
-	e2fsck_pass1_ea_unlock(ctx);
+	ext2fs_fast_mark_block_bitmap2(ctx->block_ea_map, blk);
 	return 1;
 
 clear_extattr:
-- 
2.25.2

