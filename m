Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93F72B80D0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgKRPlA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgKRPk7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:59 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED31C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so2921195ybj.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=yNDkWH0BXwLvDjF9+mJLlcGy9OjMar14FW9yoJaQjtI=;
        b=B6Pden76bt2NDqo96OwH2gvB62m6ELLNXRiMHhv77tGDBx/1/pTjBvVugYTSB3o/WX
         OHFjoKPkCwwZBuB02xDsJJp8BSG36Mc9y5ejaagEiPVthnr5uWXC8wRn0bDRZn6UmIXL
         J+rk4xWQa5KSfuwuKJQeZjmpCjb/Fz//aryJoG5FjmN7xFlhcOj076TlRdxZlTGPu7Ne
         FLVuC95oJQV3fuFkehRiQvQPXnYF1yd818iwBMmfgU7pcRnQgyjJ30t95FNxeTIbYl5I
         EZ8PmYdYhqTTEvpAQ13XPpDYj27Pyw9OnPBVeyP2cWOMQS1gdrQexVtKT5LGiDT6Xc1U
         74SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yNDkWH0BXwLvDjF9+mJLlcGy9OjMar14FW9yoJaQjtI=;
        b=n0UDxts7Y25Yg2wyv3Vrmc6qdKKFpQr5aNQj+OsTzmJVrr458Y3IN/F52+7bmvA3Ty
         PPW4o8m54NRZ3j7zpo05AFX0S5WaQdVONJj2xWaR7yYj0/QKOiDQySXmCB683t0av15Y
         SoniIUhP1GuzRPtXkmesT5CHW2TTftw2UDCFhg7/Nf8TYd0I3oOMgu4tdIKdz6Boiw5E
         GZAIOm2M6J/ku+1shOlFxOQE2OVzZagE8GU7q4eU0IcqMQ7HR2bXVxyxdsFIFZdgyTSd
         nzw9+gn10TKaOvn7z4XIJC4efnqsHIX70ILbQxoFD/s80f7KhStUdnXwhTeLCXU6JO/4
         sKOg==
X-Gm-Message-State: AOAM531OPUYfgofJdBrusnyScCx/aiJQRzXW82e59hUt7HbnhpirJDTm
        kuebcIol1AxZ0Tlt7FJMgALazPDO+A7+GWF1l1zKVPGSShmb81adbCIHawDnSdfdpTAdutRwWX+
        uxk7DCp0VOVj583wm1Nzdhjssz/BDdPzYxjntBaovcLZzUPHPlpRWfyog2N12/vCQrWAtFUMML5
        ns0ZWB08Q=
X-Google-Smtp-Source: ABdhPJyipPkd5wVNfZXUDE4hkO9509ktPqqaHuo7GZeAN18Vtnc60rEp1pTLaEGTsAgw2E7ElZkJsOF0mws98vjKvLw=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a25:b281:: with SMTP id
 k1mr7780646ybj.303.1605714057409; Wed, 18 Nov 2020 07:40:57 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:03 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-18-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 17/61] e2fsck: merge dir_info after thread finishes
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

dir_info need be merged after thread finish.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/dirinfo.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 e2fsck/e2fsck.h  |  2 ++
 e2fsck/pass1.c   | 58 +++++++++++++++++++++++++++++++++++++++---
 3 files changed, 123 insertions(+), 3 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 28baaca2..b4adaa6e 100644
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
index 06893f67..6783ed05 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -507,6 +507,8 @@ extern void read_bad_blocks_file(e2fsck_t ctx, const char *bad_blocks_file,
 
 /* dirinfo.c */
 extern void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent);
+void e2fsck_merge_dir_info(e2fsck_t ctx, struct dir_info_db *src,
+                           struct dir_info_db *dest);
 extern void e2fsck_free_dir_info(e2fsck_t ctx);
 extern int e2fsck_get_num_dirinfo(e2fsck_t ctx);
 extern struct dir_info_iter *e2fsck_dir_info_iter_begin(e2fsck_t ctx);
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d4a2e707..ef6b2d13 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2363,6 +2363,21 @@ out_context:
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
 	errcode_t	 retval;
@@ -2372,6 +2387,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	FILE		*global_logf = global_ctx->logf;
 	FILE		*global_problem_logf = global_ctx->problem_logf;
 	ext2fs_inode_bitmap inode_bad_map = global_ctx->inode_bad_map;
+	struct dir_info_db *dir_info = global_ctx->dir_info;
 	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
 	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
 	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
@@ -2404,6 +2420,8 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->block_dup_map = block_dup_map;
 	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->block_metadata_map = block_metadata_map;
+	global_ctx->dir_info = dir_info;
+	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
 
 	/* Keep the global singal flags*/
 	global_ctx->flags |= (flags & E2F_FLAG_SIGNAL_MASK) |
@@ -2503,6 +2521,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_dup_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_ea_map);
 	e2fsck_pass1_free_bitmap(&thread_ctx->block_metadata_map);
+	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
 	return retval;
@@ -2667,15 +2686,48 @@ out_abort:
 }
 #endif
 
+/* TODO: tdb needs to be handled properly for multiple threads*/
+static int multiple_threads_supported(e2fsck_t ctx)
+{
+#ifdef	CONFIG_TDB
+	unsigned int		threshold;
+	ext2_ino_t		num_dirs;
+	errcode_t		retval;
+	char			*tdb_dir;
+	int			enable;
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
+	    (!threshold || num_dirs > threshold))
+		return 0;
+ #endif
+	return 1;
+}
+
 void e2fsck_pass1(e2fsck_t ctx)
 {
 
 	init_ext2_max_sizes();
 #ifdef CONFIG_PFSCK
-	e2fsck_pass1_multithread(ctx);
-#else
-	e2fsck_pass1_run(ctx);
+	if (multiple_threads_supported(ctx)) {
+		e2fsck_pass1_multithread(ctx);
+		return;
+	}
+	fprintf(stderr, "Fall through single thread for pass1 "
+			"because tdb could not handle properly\n");
 #endif
+	e2fsck_pass1_run(ctx);
 }
 
 #undef FINISH_INODE_LOOP
-- 
2.29.2.299.gdc1121823c-goog

