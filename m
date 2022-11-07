Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20BAA61F30C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiKGM0F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiKGMZx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223701B9E6
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:53 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b11so10416344pjp.2
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0/CK5a9TPR66DPtC901kFn8FeF4wHzokbGENRJGLC8=;
        b=nIAk90/PYkpri0HOXZgT1CNhCjgup5LEpsA6UrZN+LTLX0fwKeUGICWnj8MVaWrer7
         wCCyXXNVBnzegxSRLmGBfEiUH6Cjyy75oLSQEv5Q7Kotg30Zl6MECq0L3dbo5kiYmlhY
         5feBcdzp64Skq4yH8v9srdf/nrDHgnE6g61N1udBJm4HGyQK46Edx5R7IwwAQAwPLoK3
         NWUo15QicbD3VEMZv+nWBPCUHULK3lkmZenmfYsJkRRXUzirLqRDZtYBCwUBc/+G8rXN
         CAqjIUhBlDVKnHos35bz4kud4kMWq8xpks966Odog2FfWvG4eiS8IwhRNLIwt1c8vhKr
         zQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0/CK5a9TPR66DPtC901kFn8FeF4wHzokbGENRJGLC8=;
        b=a3/nvpmN/H+bjXOud0x2CQHJ/8pMTX9K/fnLEI6vIQWegsbi5YytRQRRoBokW+L+n3
         WJ4bJF/gqxs9wOg9ZINqHWdf3C1XCLsDKccic1NHGvs0in8cp9rrBCPbZDnWVABvc23J
         T+G8uG7oG9B6XCy7KBnYtrXynGzIFzFMydW+lDwxG4nUixHTJXV+qHubnQ7JGynnCar3
         uPfjAhJrnDzSP/NR/tpFIJyjylJLKtLXEiYFPo1B15tVp0DBtVCITJzAEkKTXlzUQQ/c
         4dazt7FaYcFSUZQ8qzNYQ7DRL0HH4ZdriuW/fPoNz8CGcaK9YBi8lcCkcWtEmjQFhu0k
         MD4w==
X-Gm-Message-State: ACrzQf3JpiqdpaATZ4gucjVSsyvVM4hhOyCR15z2T3prhIQ0GIQ50HgH
        L/wYkmTUL5ScE35zJzWnevM=
X-Google-Smtp-Source: AMsMyM5uG9jUJ1g5swt3MnWgTTv4XjVOcqFG9vsA8fYK0Rd3MSKZjM3OkCULkdTyznShj87iLbd74g==
X-Received: by 2002:a17:902:e745:b0:187:2033:1832 with SMTP id p5-20020a170902e74500b0018720331832mr42125914plf.119.1667823952630;
        Mon, 07 Nov 2022 04:25:52 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id k31-20020a635a5f000000b00438834b14a1sm4062783pgm.80.2022.11.07.04.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:52 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 34/72] e2fsck: merge dir_info after thread finishes
Date:   Mon,  7 Nov 2022 17:51:22 +0530
Message-Id: <a7600ba774056276b83b8fa1b9be3e76d27ff04a.1667822611.git.ritesh.list@gmail.com>
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

From: Li Xi <lixi@ddn.com>

dir_info need be merged after thread finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/dirinfo.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h  |  2 ++
 e2fsck/pass1.c   | 53 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 5c360a90..ee8d8a69 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -169,6 +169,72 @@ e2fsck_dir_info_min_larger_equal(struct dir_info_db *dir_info,
 	return -ENOENT;
 }
 
+/*
+ * Merge two sorted dir info to @dest
+ */
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+			   struct dir_info_db *dest)
+{
+	size_t		 size_dir_info = sizeof(struct dir_info);
+	ext2_ino_t	 size = dest->size;
+	struct dir_info	 *src_array = src->array;
+	struct dir_info	 *dest_array = dest->array;
+	ext2_ino_t	 src_count = src->count;
+	ext2_ino_t	 dest_count = dest->count;
+	ext2_ino_t	 total_count = src_count + dest_count;
+	struct dir_info	*tmp_array;
+	struct dir_info	*array_ptr;
+	ext2_ino_t	 src_index = 0;
+	ext2_ino_t	 dest_index = 0;
+
+	if (src->count == 0)
+		return;
+
+	if (size < total_count)
+		size = total_count;
+
+	if (size < src->size)
+		size = src->size;
+
+	tmp_array = e2fsck_allocate_memory(ctx, size * size_dir_info,
+					    "directory map");
+	array_ptr = tmp_array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes
+	 * would be more complex. And if the groups distributed to each
+	 * thread are strided, this implementation won't be too bad
+	 * comparing to the optimiztion.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_dir_info);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_dir_info);
+			break;
+		}
+		if (src_array[src_index].ino < dest_array[dest_index].ino) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index].ino >
+			       dest_array[dest_index].ino);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	if (dest->array)
+		ext2fs_free_mem(&dest->array);
+	dest->array = tmp_array;
+	dest->size = size;
+	dest->count = total_count;
+}
+
 /*
  *
  * Insert an inode into the sorted array. The array should have at least one
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index cdd158cc..2ee37f78 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -546,6 +546,8 @@ extern void read_bad_blocks_file(e2fsck_t ctx, const char *bad_blocks_file,
 
 /* dirinfo.c */
 extern void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent);
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+                           struct dir_info_db *dest);
 extern void e2fsck_free_dir_info(e2fsck_t ctx);
 extern int e2fsck_get_num_dirinfo(e2fsck_t ctx);
 extern struct dir_info_iter *e2fsck_dir_info_iter_begin(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d5c01dc7..57003d8c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2325,6 +2325,21 @@ out_context:
 	return retval;
 }
 
+static void e2fsck_pass1_merge_dir_info(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+{
+	if (thread_ctx->dir_info == NULL)
+		return;
+
+	if (global_ctx->dir_info == NULL) {
+		global_ctx->dir_info = thread_ctx->dir_info;
+		thread_ctx->dir_info = NULL;
+		return;
+	}
+
+	e2fsck_merge_dir_info(global_ctx, thread_ctx->dir_info,
+			      global_ctx->dir_info);
+}
+
 static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t retval = 0;
@@ -2334,6 +2349,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_filsys thread_fs = thread_ctx->fs;
 	ext2_filsys global_fs = global_ctx->fs;
 	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
+	struct dir_info_db *dir_info = global_ctx->dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2366,6 +2382,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_metadata_map = block_metadata_map;
+	global_ctx->dir_info = dir_info;
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2458,6 +2476,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_dup_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
+	e2fsck_free_dir_info(thread_ctx);
 
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
@@ -2628,11 +2647,43 @@ out_abort:
 }
 #endif
 
+/* TODO: tdb needs to be handled properly for multiple threads*/
+static int multiple_threads_supported(e2fsck_t ctx)
+{
+#ifdef	CONFIG_TDB
+	unsigned int threshold;
+	ext2_ino_t num_dirs;
+	errcode_t retval;
+	char *tdb_dir;
+	int enable;
+
+	profile_get_string(ctx->profile, "scratch_files", "directory", 0, 0,
+			   &tdb_dir);
+	profile_get_uint(ctx->profile, "scratch_files",
+			 "numdirs_threshold", 0, 0, &threshold);
+	profile_get_boolean(ctx->profile, "scratch_files",
+			    "icount", 0, 1, &enable);
+
+	retval = ext2fs_get_num_dirs(ctx->fs, &num_dirs);
+	if (retval)
+		num_dirs = 1024;	/* Guess */
+
+	/* tdb is unsupported now */
+	if (enable && tdb_dir && !access(tdb_dir, W_OK) &&
+	    (!threshold || num_dirs > threshold)) {
+		fprintf(stderr, "Fall through single thread for pass1 "
+				"because tdb could not handle properly\n");
+		return 0;
+	}
+ #endif
+	return 1;
+}
+
 void e2fsck_pass1(e2fsck_t ctx)
 {
 	init_ext2_max_sizes();
 #ifdef HAVE_PTHREAD
-	if (ctx->options & E2F_OPT_MULTITHREAD)
+	if (ctx->options & E2F_OPT_MULTITHREAD && multiple_threads_supported(ctx))
 		e2fsck_pass1_multithread(ctx);
 	else
 #endif
-- 
2.37.3

