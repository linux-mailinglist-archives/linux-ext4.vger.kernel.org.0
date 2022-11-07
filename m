Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F067161F32F
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiKGM2O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiKGM2I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:28:08 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AD01B7AA
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:28:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 4so10959470pli.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NwtTBgowLxr+7Lmil9mnFdsbJs/rqDOnikb6oPdack=;
        b=Pe8RIuGtO7V8axRq8Zn1pqb6nORa1NyCinm11i6AZiDWZymmvrkfmbMwBvZnf2cAsw
         gk/LpfNd+0ChbZWKJqfmSFQvBA/PP9+Ls9oc9/lL5HfwrVIKannpxR8p+8H6TxknzpWe
         qqJ4MfkW+Dev6tm1VDPjcmzq36kVw4a6Jcj4Aw15pncwTJ9+PnN/wD772cl117haw8Ya
         Q5u8zt9I9vmPg0Uoqw9v11wDqb4Vp3JjA4kgH1dsUndVmRgT+XBHpKbTQ990z4RUX4nh
         CGQNTVjBABHFIyLxAaUY4550ePw1div19xkbB1HmpquljpnNm+826cF5x9rJFXrtufVO
         31VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7NwtTBgowLxr+7Lmil9mnFdsbJs/rqDOnikb6oPdack=;
        b=8Fq2a54GGWbVdfFcNA+xsiZeAg+Zq/xDSwhPJxCZZFGXs7rk68KjRqDbcD+ux47FJt
         WD9v505SOQMa4KUFxFM08iN/2/0VWn1SOOOmSpJjPk6zMQACE8Bjd7AiVKqsPQf2zIw2
         nFZ6dRJoveyq0vnkA2NJp+iql6yHFytc+UlX5V7oDRlBhhxbm1mI28yPwmZlEV0QfNa8
         UXqFy4gEfKLB9ntNjD6MQ6TGYf6Kwf1P0Jj+um0Vv+Mi3rZAO8mtFt9LIqArIbokoc/y
         Lxb71sklE5+DBTovn0B8uTPDauUK+txS8LS2Yga77rYhXHPhKp4C6Ni2h/tH4dqPCwcU
         F66A==
X-Gm-Message-State: ACrzQf1TneLqykifjX2mdHm0yVcD9NjdmT74U4L3JdmY6ohDNpSmORUZ
        d3nShg0Y8b3x0YfcvNTSy3U=
X-Google-Smtp-Source: AMsMyM7+sLKcGzEnmz6T+4yhEzGGY24hmdnoNSKmLU5I0xB/h4hRbngeGfwyc6vF78eyzTokcYBJ9g==
X-Received: by 2002:a17:90a:748c:b0:213:854f:f78a with SMTP id p12-20020a17090a748c00b00213854ff78amr49999825pjk.41.1667824084003;
        Mon, 07 Nov 2022 04:28:04 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b005618189b0ffsm4382758pfl.104.2022.11.07.04.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:28:03 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 56/72] e2fsck: wait fix thread finish before checking
Date:   Mon,  7 Nov 2022 17:51:44 +0530
Message-Id: <feeb2dc096e3cf080b91eca836957136f580da3a.1667822611.git.ritesh.list@gmail.com>
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

Before proceeding next inodes, waitting existed
fixing finished.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
[unlock from Jan's orphan inode path as well]
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/e2fsck.c |  3 +++
 e2fsck/e2fsck.h |  5 +++-
 e2fsck/pass1.c  | 70 +++++++++++++++++++++++++++++++++++++++++++------
 e2fsck/util.c   | 56 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 122 insertions(+), 12 deletions(-)

diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 1e295e3e..a5150dab 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -187,6 +187,9 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 	ctx->fs_fragmented_dir = 0;
 	ctx->large_files = 0;
 	ctx->large_dirs = 0;
+#ifdef HAVE_PTHREAD
+	ctx->fs_need_locking = 0;
+#endif
 
 	for (i=0; i < MAX_EXTENT_DEPTH_COUNT; i++)
 		ctx->extent_depth_count[i] = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index e3276924..01bd9d01 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -488,8 +488,9 @@ struct e2fsck_struct {
 
 #ifdef HAVE_PTHREAD
 	__u32			 fs_num_threads;
+	int			 fs_need_locking;
 	/* serialize fix operation for multiple threads */
-	pthread_mutex_t		 fs_fix_mutex;
+	pthread_rwlock_t	 fs_fix_rwlock;
 	/* protect block_found_map, block_dup_map */
 	pthread_rwlock_t	 fs_block_map_rwlock;
 #endif
@@ -553,6 +554,8 @@ extern int e2fsck_strnlen(const char * s, int count);
 
 extern void e2fsck_pass1(e2fsck_t ctx);
 extern void e2fsck_pass1_dupblocks(e2fsck_t ctx, char *block_buf);
+extern void e2fsck_pass1_check_lock(e2fsck_t ctx);
+extern void e2fsck_pass1_check_unlock(e2fsck_t ctx);
 extern void e2fsck_pass2(e2fsck_t ctx);
 extern void e2fsck_pass3(e2fsck_t ctx);
 extern void e2fsck_pass4(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a5dc6e44..29333acf 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -991,8 +991,10 @@ static void finish_processing_inode(e2fsck_t ctx, ext2_ino_t ino,
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
@@ -1374,8 +1376,12 @@ static errcode_t e2fsck_pass1_prepare(e2fsck_t ctx)
 		ext2fs_mark_block_bitmap2(ctx->block_found_map,
 					  fs->super->s_mmp_block);
 #ifdef	HAVE_PTHREAD
-	pthread_mutex_init(&ctx->fs_fix_mutex, NULL);
+	pthread_rwlock_init(&ctx->fs_fix_rwlock, NULL);
 	pthread_rwlock_init(&ctx->fs_block_map_rwlock, NULL);
+	if (ctx->fs_num_threads > 1)
+		ctx->fs_need_locking = 1;
+	else
+		ctx->fs_need_locking = 0;
 #endif
 
 	return 0;
@@ -1387,6 +1393,10 @@ static void e2fsck_pass1_post(e2fsck_t ctx)
 	ext2_filsys fs = ctx->fs;
 	char *block_buf;
 
+#ifdef HAVE_PTHREAD
+	ctx->fs_need_locking = 0;
+#endif
+
 	if (e2fsck_should_abort(ctx))
 		return;
 
@@ -1662,6 +1672,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 #endif
 
 	while (1) {
+		e2fsck_pass1_check_lock(ctx);
 		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
 			if (e2fsck_mmp_update(fs))
 				fatal_error(ctx, 0);
@@ -1672,8 +1683,10 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -1694,27 +1707,45 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
 #ifdef HAVE_PTHREAD
 		if (ctx->global_ctx)
 		        ctx->thread_info.et_inode_number++;
@@ -1767,6 +1798,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				pctx.num = inode->i_links_count;
 				fix_problem(ctx, PR_1_ICOUNT_STORE, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		} else if ((ino >= EXT2_FIRST_INODE(fs->super)) &&
@@ -1781,6 +1813,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 			}
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
 
@@ -1801,6 +1834,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 							       &pctx);
 			if (res < 0) {
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1822,6 +1856,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 			} else if (fix_problem(ctx, PR_1_INLINE_DATA_SET, &pctx)) {
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1866,6 +1901,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 					if (err) {
 						pctx.errcode = err;
 						ctx->flags |= E2F_FLAG_ABORT;
+						e2fsck_pass1_check_unlock(ctx);
 						goto endit;
 					}
 					inode->i_flags &= ~EXT4_INLINE_DATA_FL;
@@ -1880,6 +1916,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				/* Some other kind of non-xattr error? */
 				pctx.errcode = err;
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		}
@@ -1917,6 +1954,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 					ext2fs_mark_inode_bitmap2(ctx->inode_used_map,
 								 ino);
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1980,6 +2018,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 			pb.ino = EXT2_BAD_INO;
@@ -1997,16 +2036,19 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2048,6 +2090,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2075,6 +2118,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2101,6 +2145,7 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2139,11 +2184,13 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2253,12 +2300,14 @@ void e2fsck_pass1_run(e2fsck_t ctx)
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
@@ -2306,16 +2355,21 @@ void e2fsck_pass1_run(e2fsck_t ctx)
 
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
diff --git a/e2fsck/util.c b/e2fsck/util.c
index 5714576a..b7c1e7a5 100644
--- a/e2fsck/util.c
+++ b/e2fsck/util.c
@@ -82,7 +82,8 @@ void fatal_error(e2fsck_t ctx, const char *msg)
 	}
 out:
 	ctx->flags |= E2F_FLAG_ABORT;
-	if (ctx->flags & E2F_FLAG_SETJMP_OK)
+	if (!(ctx->options & E2F_OPT_MULTITHREAD) &&
+	    ctx->flags & E2F_FLAG_SETJMP_OK)
 		longjmp(ctx->abort_loc, 1);
 	if (ctx->logf)
 		fprintf(ctx->logf, "Exit status: %d\n", exit_value);
@@ -580,38 +581,79 @@ void e2fsck_read_inode_full(e2fsck_t ctx, unsigned long ino,
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
@@ -624,6 +666,14 @@ void e2fsck_pass1_fix_lock(e2fsck_t ctx)
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
2.37.3

