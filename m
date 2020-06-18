Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D3A1FF6E8
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgFRPa2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731321AbgFRPaL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:30:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704CFC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v14so3072294pgl.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9a9WnBjx07L+yJk5J10En0OLTFK3qkAegKJrqlvWsLA=;
        b=HycUmPuXV4SQxSObHpm/qE+abYzJECf3M2GId2Nj8I1Nr2kg0yYzc1rMBXl1yk6XQv
         sP+mHP1Ba2Sfn9pSIrdMV3jPHMrkXEx5xtF0HdR9/0TJ2/9ceMbMNUciI3ykGvtI5dCJ
         ujhGaakLvC3cqmhZlJIg2qJ/8odu2d19ksIqYphAutifRV+fKjuy2YlWPv8XySJM/3UD
         mgjjtCqGo9MrNIMDs+aeXH/lwJlAMb1VQGH+nHSd3koW+ZkJGFKu5O1EA+7M8QbbG8zH
         e6nPEH+IV8vNNwoj/SnKT28VvmlW+QZq2FzUHKnBvB1jCtIvRxNDjmPxswWK5kcNOKI7
         CmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9a9WnBjx07L+yJk5J10En0OLTFK3qkAegKJrqlvWsLA=;
        b=uF4Rkj0DbcAsi2eOv2NcrlojNQCKmAPWsVlG0Bb9JIKJ05LMOl0HR2CDKIgzsKFq3q
         hPD5meVjqlELYgFO1WXrYu10RZlfO8c59ECm7GT1PkrS8sOBuePZYqg6o9PCDVA+ack0
         sd6Pm5jf9u1B2i5IRaqSBM9TJ/ICKf2SfkRao/KHBTjd+AMBR8aWTGuh6B9rQQNGHdNQ
         E/TWilpELvYET512VrvpN/76d2aM+Nc6mK7J777vfpn6dc7rBq2n4GC8wM3xlgfb4Dcm
         2U29j3a9M+wuO/S3Hn5BOc/kwpOqPUSefacIZnDx4pzKJpGa7YmW8+eDBdeCNajrhJwj
         SmPg==
X-Gm-Message-State: AOAM532Le1W/ea7HDkOqU8FeAUjY5LQqj11E5T7F+IePsp4pTFardBTo
        BJtKH35E2oUVEyYJIcSVsvitlZTvd2g=
X-Google-Smtp-Source: ABdhPJxJlk0XF7FbzyrqRAYhYDqffic7EeBI+hy+er4QvJtO7VaI/1TzX6r1Y6iL8bguNMOBOaj/2Q==
X-Received: by 2002:a62:1444:: with SMTP id 65mr4021571pfu.294.1592494210573;
        Thu, 18 Jun 2020 08:30:10 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.30.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:30:10 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 49/51] e2fsck: wait fix thread finish before checking
Date:   Fri, 19 Jun 2020 00:27:52 +0900
Message-Id: <1592494074-28991-50-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Before proceeding next inodes, waitting existed
fixing finished.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h |  2 +-
 e2fsck/pass1.c  | 72 +++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 4a4f1098..86ec04ec 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -448,7 +448,7 @@ struct e2fsck_struct {
 	__u32			extent_depth_count[MAX_EXTENT_DEPTH_COUNT];
 	__u32			fs_num_threads;
 	/* serialize fix operation for multiple threads */
-	pthread_mutex_t		 fs_fix_mutex;
+	pthread_rwlock_t	 fs_fix_rwlock;
 	/* protect block_found_map, block_dup_map */
 	pthread_rwlock_t	 fs_block_map_rwlock;
 };
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 969475b4..52af4f13 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -137,16 +137,40 @@ static __u64 ext2_max_sizes[EXT2_MAX_BLOCK_LOG_SIZE -
 	if (!global_ctx)			\
 		global_ctx = ctx;		\
 
+/**
+ * before we hold write lock, read lock should
+ * has been held.
+ */
 static void e2fsck_pass1_fix_lock(e2fsck_t ctx)
 {
+	int err;
+
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_lock(&global_ctx->fs_fix_mutex);
+	err = pthread_rwlock_trywrlock(&global_ctx->fs_fix_rwlock);
+	assert(err != 0);
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
+	pthread_rwlock_wrlock(&global_ctx->fs_fix_rwlock);
 }
 
 static void e2fsck_pass1_fix_unlock(e2fsck_t ctx)
 {
 	e2fsck_get_lock_context(ctx);
-	pthread_mutex_unlock(&global_ctx->fs_fix_mutex);
+	/* unlock write lock */
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
+	/* get read lock again */
+	pthread_rwlock_rdlock(&global_ctx->fs_fix_rwlock);
+}
+
+static void e2fsck_pass1_check_lock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_rdlock(&global_ctx->fs_fix_rwlock);
+}
+
+static void e2fsck_pass1_check_unlock(e2fsck_t ctx)
+{
+	e2fsck_get_lock_context(ctx);
+	pthread_rwlock_unlock(&global_ctx->fs_fix_rwlock);
 }
 
 static inline void e2fsck_pass1_block_map_w_lock(e2fsck_t ctx)
@@ -1655,6 +1679,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	}
 
 	while (1) {
+		e2fsck_pass1_check_lock(ctx);
 		if (ino % (fs->super->s_inodes_per_group * 4) == 1) {
 			if (e2fsck_mmp_update(fs))
 				fatal_error(ctx, 0);
@@ -1665,8 +1690,10 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -1691,25 +1718,32 @@ void _e2fsck_pass1(e2fsck_t ctx)
 					ctx->flags |= E2F_FLAG_ABORT;
 				} else
 					ctx->flags |= E2F_FLAG_RESTART;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
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
 		if (ctx->global_ctx)
 		        ctx->thread_info.et_inode_number++;
 		pctx.ino = ino;
@@ -1764,6 +1798,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				pctx.num = inode->i_links_count;
 				fix_problem(ctx, PR_1_ICOUNT_STORE, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		} else if ((ino >= EXT2_FIRST_INODE(fs->super)) &&
@@ -1780,6 +1815,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				}
 			}
 			FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+			e2fsck_pass1_check_unlock(ctx);
 			continue;
 		}
 
@@ -1800,6 +1836,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 							       &pctx);
 			if (res < 0) {
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1822,6 +1859,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				e2fsck_clear_inode(ctx, ino, inode, 0, "pass1");
 				e2fsck_pass1_fix_unlock(ctx);
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1868,6 +1906,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 						pctx.errcode = err;
 						ctx->flags |= E2F_FLAG_ABORT;
 						e2fsck_pass1_fix_unlock(ctx);
+						e2fsck_pass1_check_unlock(ctx);
 						goto endit;
 					}
 					inode->i_flags &= ~EXT4_INLINE_DATA_FL;
@@ -1883,6 +1922,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				/* Some other kind of non-xattr error? */
 				pctx.errcode = err;
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 		}
@@ -1922,6 +1962,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 					ext2fs_mark_inode_bitmap2(ctx->inode_used_map,
 								 ino);
 				/* skip FINISH_INODE_LOOP */
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 		}
@@ -1992,6 +2033,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				pctx.num = 4;
 				fix_problem(ctx, PR_1_ALLOCATE_BBITMAP_ERROR, &pctx);
 				ctx->flags |= E2F_FLAG_ABORT;
+				e2fsck_pass1_check_unlock(ctx);
 				goto endit;
 			}
 			pb.ino = EXT2_BAD_INO;
@@ -2009,16 +2051,19 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -2064,6 +2109,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2095,6 +2141,7 @@ void _e2fsck_pass1(e2fsck_t ctx)
 				}
 				check_blocks(ctx, &pctx, block_buf, NULL);
 				FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
+				e2fsck_pass1_check_unlock(ctx);
 				continue;
 			}
 			if ((inode->i_links_count ||
@@ -2137,11 +2184,13 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -2250,12 +2299,14 @@ void _e2fsck_pass1(e2fsck_t ctx)
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
@@ -2303,16 +2354,21 @@ void _e2fsck_pass1(e2fsck_t ctx)
 
 		FINISH_INODE_LOOP(ctx, ino, &pctx, failed_csum);
 
-		if (e2fsck_should_abort(ctx))
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
@@ -3328,7 +3384,7 @@ static void e2fsck_pass1_multithread(e2fsck_t global_ctx)
 	struct e2fsck_thread_info	*infos = NULL;
 	errcode_t			 retval;
 
-	pthread_mutex_init(&global_ctx->fs_fix_mutex, NULL);
+	pthread_rwlock_init(&global_ctx->fs_fix_rwlock, NULL);
 	pthread_rwlock_init(&global_ctx->fs_block_map_rwlock, NULL);
 	retval = e2fsck_pass1_threads_start(&infos, global_ctx);
 	if (retval) {
-- 
2.25.4

