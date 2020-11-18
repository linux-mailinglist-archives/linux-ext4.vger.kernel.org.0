Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50922B80EA
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKRPlp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgKRPlo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:44 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA892C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:44 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id f20so1391522pjq.9
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PM5k/+pyYeYWvC2oKkTa57pw4+TAFvx0ODzORD+kTV8=;
        b=SSG+ztGeC6uRPYN8UmJjjmVNVqfSXpgL4NmYzgdSTPgorCRFIoqy2OZlNNXtdcZEzI
         wQpdN9CREMVciY6319f9UaWyD23NJ+dXs+IoeFGYS+ltWbnQ0964sgZ6TKf+adS3epBB
         xO55GvSUwoL7OO3AKpJiYfJpVI9FpJN2g78Nz2j/7obFQaNQnQPyY+e/CloUL4jP4jOi
         6k478iIydRgyXg7LDTbAsakl37lxcweJiGxqq6MjZDCGg0V8Lh+FcJuKt1juciKQFnGv
         wK74Wmq76mnYM+cfIjvD0LawUZnsrdO+zsLJXdFNWSsmtyJyXmnZSdGraO3vjjM4OwEm
         GYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PM5k/+pyYeYWvC2oKkTa57pw4+TAFvx0ODzORD+kTV8=;
        b=dUYbSjCabxBnFVk1GwAkaAD4aIFSvsZ+Ia/rhTFDv0S7Ua4RaeekiXiloxPOf5C4+5
         yWCgJm2Wx4Bhm65G+cIufbMmuTqp+zwkkxCVQH2sULZFcImiGa/8yS7cVUa10AKWtdzl
         gDW1J+VIhJLhQv+DVA1A0D6ySGfl/NWncq3hijRATnMUg3cOPt2L9OkJZtTrYKB/Ypal
         B+M8wbPukeURY/Na/bOKQzDcd7KdXV4M0ZmBPElzI+XgAzmFAzZMSOANOVj6IdNSXtya
         wabzmpOg6Rtu8j1/GF6xwz+YccYbr//fVn/VcaO8RIrRRzs/vpr71RkVjsQgmU+NdF68
         zk8g==
X-Gm-Message-State: AOAM531U32SjAMiFBK8IjvidS6L0eSIE7OeJXrNJslgISMCP4aV0u2Mr
        EoWQnPwi5OD+IGsRmYDFP1Tv3OeQB7pDUUamspT2hQ2paDFNgHEJeRbChGZd2OWORPYiNEZb2Ji
        d6r2bevCY2jP+M9hlknrngp9eCrv5YKvnlfbx7Vej5FjZNVDJeZUOsLBlry8mFkBcOi4oaTDO5D
        M/vdKPWtU=
X-Google-Smtp-Source: ABdhPJyhuVa6fqMC7HY6Pkykr5Bz53dPa+HlsiGRV1zsPtiEIRnBZR9LCvRn4sJazRozRt4ZyvhIZxOaKktIw6pZCOI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:ff07:b029:d8:eea2:afae with
 SMTP id f7-20020a170902ff07b02900d8eea2afaemr5033556plj.18.1605714103963;
 Wed, 18 Nov 2020 07:41:43 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:28 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-43-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 42/61] e2fsck: wait fix thread finish before checking
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Before proceeding next inodes, waitting existed
fixing finished.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.c |  3 +++
 e2fsck/e2fsck.h |  5 +++-
 e2fsck/pass1.c  | 65 +++++++++++++++++++++++++++++++++++++++++++------
 e2fsck/util.c   | 56 +++++++++++++++++++++++++++++++++++++++---
 4 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index d8be566f..1fd57504 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -178,6 +178,9 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 	ctx->fs_fragmented = 0;
 	ctx->fs_fragmented_dir = 0;
 	ctx->large_files = 0;
+#ifdef CONFIG_PFSCK
+	ctx->fs_need_locking = 0;
+#endif
 
 	for (i=0; i < MAX_EXTENT_DEPTH_COUNT; i++)
 		ctx->extent_depth_count[i] = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index f46a95ef..a66772c1 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -451,8 +451,9 @@ struct e2fsck_struct {
 	char *undo_file;
 #ifdef CONFIG_PFSCK
 	__u32			 fs_num_threads;
+	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
-	pthread_mutex_t		 fs_fix_mutex;
+	pthread_rwlock_t	 fs_fix_rwlock;
 	/* protect block_found_map, block_dup_map */
 	pthread_rwlock_t	 fs_block_map_rwlock;
 #endif
@@ -514,6 +515,8 @@ extern int e2fsck_strnlen(const char * s, int count);
 
 extern void e2fsck_pass1(e2fsck_t ctx);
 extern void e2fsck_pass1_dupblocks(e2fsck_t ctx, char *block_buf);
+extern void e2fsck_pass1_check_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_check_unlock(e2fsck_t ctx);
 extern void e2fsck_pass2(e2fsck_t ctx);
 extern void e2fsck_pass3(e2fsck_t ctx);
 extern void e2fsck_pass4(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 62345bb6..5e62e357 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -986,8 +986,10 @@ static void finish_processing_inode(e2fsck_t ctx, ext2_ino_t ino,
 #define FINISH_INODE_LOOP(ctx, ino, pctx, failed_csum) \
 	do { \
 		finish_processing_inode((ctx), (ino), (pctx), (failed_csum)); \
-		if ((ctx)->flags & E2F_FLAG_ABORT) \
+		if ((ctx)->flags & E2F_FLAG_ABORT) { \
+			e2fsck_pass1_check_unlock(ctx); \
 			return; \
+		} \
 	} while (0)
 
 static int could_be_block_map(ext2_filsys fs, struct ext2_inode *inode)
@@ -1368,8 +1370,10 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 		ext2fs_mark_block_bitmap2(ctx->block_found_map,
 					  fs->super->s_mmp_block);
 #ifdef	CONFIG_PFSCK
-	pthread_mutex_init(&ctx->fs_fix_mutex, NULL);
+	pthread_rwlock_init(&ctx->fs_fix_rwlock, NULL);
 	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
+	if (ctx->fs_num_threads > 1)
+		ctx->fs_need_locking = 1;
 #endif
 
 	return 0;
@@ -1642,6 +1646,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 #endif
 
 	while (1) {
+		e2fsck_pass1_check_lock(ctx);
 		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
 			if (e2fsck_mmp_update(fs))
 				fatal_error(ctx, 0);
@@ -1652,8 +1657,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 		if (ino > ino_threshold)
 			pass1_readahead(ctx, &ra_group, &ino_threshold);
 		ehandler_operation(old_op);
-		if (e2fsck_should_abort(ctx))
+		if (e2fsck_should_abort(ctx)) {
+			e2fsck_pass1_check_unlock(ctx);
 			goto endit;
+		}
 		if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
 			/*
 			 * If badblocks says badblocks is bad, offer to clear
@@ -1674,27 +1681,45 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 					fix_problem(ctx, PR_1_ISCAN_ERROR,
 						    &pctx);
 					ctx->flags |= E2F_FLAG_ABORT;
+					e2fsck_pass1_check_unlock(ctx);
+					goto endit;
 				} else
 					ctx->flags |= E2F_FLAG_RESTART;
-				goto endit;
+				err = ext2fs_inode_scan_goto_blockgroup(scan,
+									0);
+				if (err) {
+					fix_problem(ctx, PR_1_ISCAN_ERROR,
+						    &pctx);
+					ctx->flags |= E2F_FLAG_ABORT;
+					e2fsck_pass1_check_unlock(ctx);
+					goto endit;
+				}
+				e2fsck_pass1_check_unlock(ctx);
+				continue;
 			}
 			if (!ctx->inode_bb_map)
 				alloc_bb_map(ctx);
 			ext2fs_mark_inode_bitmap2(ctx->inode_bb_map, ino);
 			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
-		if (pctx.errcode == EXT2_ET_SCAN_FINISHED)
+		if (pctx.errcode == EXT2_ET_SCAN_FINISHED) {
+			e2fsck_pass1_check_unlock(ctx);
 			break;
+		}
 		if (pctx.errcode &&
 		    pctx.errcode != EXT2_ET_INODE_CSUM_INVALID &&
 		    pctx.errcode != EXT2_ET_INODE_IS_GARBAGE) {
 			fix_problem(ctx, PR_1_ISCAN_ERROR, &pctx);
 			ctx->flags |= E2F_FLAG_ABORT;
+			e2fsck_pass1_check_unlock(ctx);
 			goto endit;
 		}
-		if (!ino)
+		if (!ino) {
+			e2fsck_pass1_check_unlock(ctx);
 			break;
+		}
 #ifdef CONFIG_PFSCK
 		if (ctx->global_ctx)
 		        ctx->thread_info.et_inode_number++;
@@ -1747,6 +1772,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				pctx.num = inode->i_links_count;
 				fix_problem(ctx, PR_1_ICOUNT_STORE, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		} else if ((ino >= EXT2_FIRST_INODE(fs->super)) &&
@@ -1761,6 +1787,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 			}
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
 
@@ -1781,6 +1808,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 							       &pctx);
 			if (res < 0) {
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1801,6 +1829,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			} else if (fix_problem(ctx, PR_1_INLINE_DATA_SET, &pctx)) {
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1845,6 +1874,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 					if (err) {
 						pctx.errcode = err;
 						ctx->flags |= E2F_FLAG_ABORT;
+						e2fsck_pass1_check_unlock(ctx);
 						goto endit;
 					}
 					inode->i_flags &= ~EXT4_INLINE_DATA_FL;
@@ -1859,6 +1889,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				/* Some other kind of non-xattr error? */
 				pctx.errcode = err;
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		}
@@ -1896,6 +1927,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 					ext2fs_mark_inode_bitmap2(ctx->inode_used_map,
 								 ino);
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1959,6 +1991,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 			pb.ino = EXT2_BAD_INO;
@@ -1976,16 +2009,19 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			if (pctx.errcode) {
 				fix_problem(ctx, PR_1_BLOCK_ITERATE, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 			if (pb.bbcheck)
 				if (!fix_problem(ctx, PR_1_BBINODE_BAD_METABLOCK_PROMPT, &pctx)) {
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 			ext2fs_mark_inode_bitmap2(ctx->inode_used_map, ino);
 			clear_problem_context(&pctx);
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		} else if (ino == EXT2_ROOT_INO) {
 			/*
@@ -2027,6 +2063,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2054,6 +2091,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2092,11 +2130,13 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			}
 			check_blocks(ctx, &pctx, block_buf, NULL);
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
 
 		if (!inode->i_links_count) {
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
 		/*
@@ -2201,12 +2241,14 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			ctx->fs_symlinks_count++;
 			if (inode->i_flags & EXT4_INLINE_DATA_FL) {
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			} else if (ext2fs_is_fast_symlink(inode)) {
 				ctx->fs_fast_symlinks_count++;
 				check_blocks(ctx, &pctx, block_buf,
 					     &ea_ibody_quota);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -2254,16 +2296,21 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 
 		FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
 
-		if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
+		if (e2fsck_should_abort(ctx)) {
+			e2fsck_pass1_check_unlock(ctx);
 			goto endit;
+		}
 
 		if (process_inode_count >= ctx->process_inode_size) {
 			process_inodes(ctx, block_buf, inodes_to_process,
 				       &process_inode_count);
 
-			if (e2fsck_should_abort(ctx))
+			if (e2fsck_should_abort(ctx)) {
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
+			}
 		}
+		e2fsck_pass1_check_unlock(ctx);
 	}
 	process_inodes(ctx, block_buf, inodes_to_process,
 		       &process_inode_count);
@@ -3271,6 +3318,8 @@ void e2fsck_pass1(e2fsck_t ctx)
 		need_single = 0;
 		e2fsck_pass1_multithread(ctx);
 	}
+	/* No lock is needed at this time */
+	ctx->fs_need_locking = 0;
 #endif
 	if (need_single)
 		e2fsck_pass1_run(ctx);
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 3a84abb6..3d85bff4 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -86,7 +86,8 @@ void fatal_error(e2fsck_t ctx, const char *msg)
 	}
 out:
 	ctx->flags |= E2F_FLAG_ABORT;
-	if (ctx->flags & E2F_FLAG_SETJMP_OK)
+	if (!(ctx->options & E2F_OPT_MULTITHREAD) &&
+	    ctx->flags & E2F_FLAG_SETJMP_OK)
 		longjmp(ctx->abort_loc, 1);
 	if (ctx->logf)
 		fprintf(ctx->logf, "Exit status: %d\n", exit_value);
@@ -575,38 +576,79 @@ void e2fsck_read_inode_full(e2fsck_t ctx, unsigned long ino,
 	if (!global_ctx)			\
 		global_ctx = ctx;		\
 
+/**
+ * before we hold write lock, read lock should
+ * has been held.
+ */
 void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
+	int err;
+
+	if (!ctx->fs_need_locking)
+		return;
+
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
+	err = pthread_rwlock_trywrlock(&global_ctx->fs_fix_rwlock);
+	assert(err != 0);
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
+	pthread_rwlock_wrlock(&global_ctx->fs_fix_rwlock);
 }
 
 void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
+	if (!ctx->fs_need_locking)
+		return;
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
+	/* unlock write lock */
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
+	/* get read lock again */
+	pthread_rwlock_rdlock(&global_ctx->fs_fix_rwlock);
+}
+
+void e2fsck_pass1_check_lock(e2fsck_t ctx)
+{
+	if (!ctx->fs_need_locking)
+		return;
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_rdlock(&global_ctx->fs_fix_rwlock);
+}
+
+void e2fsck_pass1_check_unlock(e2fsck_t ctx)
+{
+	if (!ctx->fs_need_locking)
+		return;
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
 }
 
 void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
 {
+	if (!ctx->fs_need_locking)
+		return;
 	e2fsck_get_lock_context(ctx);
 	pthread_rwlock_wrlock(&global_ctx->fs_block_map_rwlock);
 }
 
 void e2fsck_pass1_block_map_w_unlock(e2fsck_t ctx)
 {
+	if (!ctx->fs_need_locking)
+		return;
 	e2fsck_get_lock_context(ctx);
 	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
 }
 
 void e2fsck_pass1_block_map_r_lock(e2fsck_t ctx)
 {
+	if (!ctx->fs_need_locking)
+		return;
 	e2fsck_get_lock_context(ctx);
 	pthread_rwlock_rdlock(&global_ctx->fs_block_map_rwlock);
 }
 
 void e2fsck_pass1_block_map_r_unlock(e2fsck_t ctx)
 {
+	if (!ctx->fs_need_locking)
+		return;
 	e2fsck_get_lock_context(ctx);
 	pthread_rwlock_unlock(&global_ctx->fs_block_map_rwlock);
  }
@@ -619,6 +661,14 @@ void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
 
+}
+void e2fsck_pass1_check_lock(e2fsck_t ctx)
+{
+
+}
+void e2fsck_pass1_check_unlock(e2fsck_t ctx)
+{
+
 }
 void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
 {
-- 
2.29.2.299.gdc1121823c-goog

