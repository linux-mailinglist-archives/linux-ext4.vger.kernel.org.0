Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F5C1FF6D9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgFRP34 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbgFRP3x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A991AC0613ED
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so2702200pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pLKU6vcRAcvDVZdogFYcJhcmjzMR3WdLKbu5fkhzAYU=;
        b=Qbm9lRfUoo87OuB1Lj6aMLx/kmU9/x84oFdVJDAqbbgOU4QOVD+4uG4Mn402eMqTMc
         VlL0DanSnBdnRswxN7NK/dyjZnunyQaqCmvQhTOOq2aqO0pctLZF2kIxIPToI6/5E9eY
         SxxWsbR6WVV87dhSgWc5Rmsht3a7mgUhTXx6JjTtAg7exZUw9I2CcIB5zeiGJzu9/dHd
         mYlEqFCQ/dsEUt9trdeP6MHoQYsQyCimAeoun7pCb28GgeSViTCNF00JKBU4S2f07OKo
         O0olriAI5/PNlwpcS/olpbhtdxmA4vycYZHROAgnsw944CfAnHeM0eFSfHrGv8n9rRik
         aFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pLKU6vcRAcvDVZdogFYcJhcmjzMR3WdLKbu5fkhzAYU=;
        b=tJoCK819Ruddjr61o8yi/tnMFapGs3p2HmeE5uiCAob2bj7afzQ2GIYDbJGbqj3Zd6
         UCBnoVbVzdFID55QoeVaTGfc2dDof+KPiD88Kj48eEuFa4ZEa3940Uc87Iaw38Ld66yf
         8eDCYTekAg02H55WpU5mcMMq5GVZJ9WVYnwm7PA/NM6czcsNgHKKaawRwZKTDYbGU0E0
         nXS3ulZJvNQ4+QAOuTq6MeTmyYaU8KlmHv3icr0oTNBun4/v95CmzM/Su/c/a7KSJ8y+
         CrTCt8Jpb8oQWVzoqw+8Tf/Sc7yrS8thQpiBI/99DH7d9b6nVx0SV67u4Lu0K31UvAyS
         kIow==
X-Gm-Message-State: AOAM5337i3kfWL+GjYscUvbqjhqHAVkN3lXbw/Za/m0UQvHEbYdhIpKb
        daLxs3DjHl/TgPGtl/GSDtNOVzJtG4g=
X-Google-Smtp-Source: ABdhPJzocmZFDO2YUTPjKk53XoaB6FaW8MTzcUUZSR4Gx7M6zeY/4qs6LQPpzbu84L2qvTPmWmJm6A==
X-Received: by 2002:a17:90b:3691:: with SMTP id mj17mr4367318pjb.152.1592494191698;
        Thu, 18 Jun 2020 08:29:51 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:51 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 41/51] e2fsck: merge encrypted_files after threads finish
Date:   Fri, 19 Jun 2020 00:27:44 +0900
Message-Id: <1592494074-28991-42-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h          |   1 +
 e2fsck/encrypted_files.c | 175 +++++++++++++++++++++++++++++++++------
 e2fsck/pass1.c           |  12 ++-
 3 files changed, 160 insertions(+), 28 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 153f2e21..4a4f1098 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -585,6 +585,7 @@ __u32 find_encryption_policy(e2fsck_t ctx, ext2_ino_t ino);
 
 void destroy_encryption_policy_map(e2fsck_t ctx);
 void destroy_encrypted_file_info(e2fsck_t ctx);
+int merge_two_encrypted_files(e2fsck_t src_ctx, e2fsck_t dest_ctx);
 
 /* extents.c */
 errcode_t e2fsck_rebuild_extents_later(e2fsck_t ctx, ext2_ino_t ino);
diff --git a/e2fsck/encrypted_files.c b/e2fsck/encrypted_files.c
index 16be2d6d..40540963 100644
--- a/e2fsck/encrypted_files.c
+++ b/e2fsck/encrypted_files.c
@@ -280,6 +280,9 @@ out:
 static int handle_nomem(e2fsck_t ctx, struct problem_context *pctx,
 			size_t size_needed)
 {
+	if (!pctx)
+		return -ENOMEM;
+
 	pctx->num = size_needed;
 	fix_problem(ctx, PR_1_ALLOCATE_ENCRYPTED_INODE_LIST, pctx);
 	/* Should never get here */
@@ -287,11 +290,155 @@ static int handle_nomem(e2fsck_t ctx, struct problem_context *pctx,
 	return 0;
 }
 
+static int increase_file_ranges_capacity(e2fsck_t ctx,
+					 struct encrypted_file_info *info,
+					 struct problem_context *pctx)
+{
+	int size = sizeof(struct encrypted_file_range);
+
+	if (info->file_ranges_count == info->file_ranges_capacity) {
+		/* Double the capacity by default. */
+		size_t new_capacity = info->file_ranges_capacity * 2;
+
+		/* ... but go from 0 to 128 right away. */
+		if (new_capacity < 128)
+			new_capacity = 128;
+
+		/* We won't need more than the filesystem's inode count. */
+		if (new_capacity > ctx->fs->super->s_inodes_count)
+			new_capacity = ctx->fs->super->s_inodes_count;
+
+		/* To be safe, ensure the capacity really increases. */
+		if (new_capacity < info->file_ranges_capacity + 1)
+			new_capacity = info->file_ranges_capacity + 1;
+
+		if (ext2fs_resize_mem(info->file_ranges_capacity * size,
+				new_capacity * size, &info->file_ranges) != 0)
+			return handle_nomem(ctx, pctx,
+					    new_capacity * size);
+
+		info->file_ranges_capacity = new_capacity;
+	}
+
+	return 0;
+}
+
+int find_entry_insert(e2fsck_t dest_ctx,
+		      struct encrypted_file_range *insert_range)
+{
+	size_t l, r, m;
+	struct encrypted_file_range *range;
+	int merge_left = 0, merge_right = 0;
+	struct encrypted_file_info *dest_info = dest_ctx->encrypted_files;
+	int ret;
+
+	l = 0;
+	r = dest_info->file_ranges_count;
+	if (r < 1)
+		return -EINVAL;
+
+	while (l < r) {
+		m = l + (r - l) / 2;
+		range = &dest_info->file_ranges[m];
+
+		if (insert_range->first_ino < range->first_ino)
+			r = m;
+		else if (insert_range->first_ino > range->last_ino)
+			l = m + 1;
+		else /* should not happen */ {
+			return -EINVAL;
+		}
+	}
+
+	/* check wheather it could be merged left */
+	if (l >= 1) {
+		range = &dest_info->file_ranges[l - 1];
+		if (range->last_ino + 1 ==
+		    insert_range->first_ino &&
+		    range->policy_id == insert_range->policy_id) {
+			range->last_ino = insert_range->last_ino;
+			merge_left = 1;
+		}
+	}
+
+	/* check wheather it could be merged right */
+	if (l < dest_info->file_ranges_count - 1) {
+		range = &dest_info->file_ranges[l + 1];
+		if (range->first_ino ==
+		    insert_range->last_ino + 1 &&
+		    range->policy_id == insert_range->policy_id) {
+			range->first_ino = insert_range->first_ino;
+			merge_right = 1;
+		}
+	}
+	/* check if we could shrink array */
+	if (merge_left && merge_right) {
+		for (m = l; m < dest_info->file_ranges_count - 1;
+			m++)
+			dest_info->file_ranges[m] =
+				dest_info->file_ranges[m + 1];
+
+		dest_info->file_ranges_count--;
+		return 0;
+	} else if (merge_left || merge_right) { /* return directly */
+		return 0;
+	}
+
+	ret = increase_file_ranges_capacity(dest_ctx, dest_info, NULL);
+	if (ret)
+		return ret;
+
+	/* move forward */
+	for (m = dest_info->file_ranges_count; m >= l; m--)
+		dest_info->file_ranges[m + 1] =
+			dest_info->file_ranges[m];
+
+	dest_info->file_ranges[l] = *insert_range;
+	dest_info->file_ranges_count++;
+	return 0;
+}
+
+int merge_two_encrypted_files(e2fsck_t src_ctx, e2fsck_t dest_ctx)
+{
+	struct encrypted_file_info *src_info = src_ctx->encrypted_files;
+	struct encrypted_file_info *dest_info = dest_ctx->encrypted_files;
+	struct encrypted_file_range *range;
+	__u32 policy_id;
+	errcode_t retval;
+	size_t i;
+
+	/* nothing to merge */
+	if (!src_info)
+		return 0;
+
+	if (!dest_info) {
+		dest_ctx->encrypted_files = src_info;
+		src_ctx->encrypted_files = NULL;
+		return 0;
+	}
+
+	for (i = 0; i < src_info->file_ranges_count; i++) {
+		range = &src_info->file_ranges[i];
+		retval = get_encryption_policy_id(dest_ctx, range->first_ino,
+						  &policy_id);
+		if (retval != 0)
+			return retval;
+		/* reset policy id */
+		range->policy_id = policy_id;
+		retval = find_entry_insert(dest_ctx, range);
+		if (retval)
+			return retval;
+	}
+
+	return 0;
+}
+
 static int append_ino_and_policy_id(e2fsck_t ctx, struct problem_context *pctx,
 				    ext2_ino_t ino, __u32 policy_id)
 {
 	struct encrypted_file_info *info = ctx->encrypted_files;
 	struct encrypted_file_range *range;
+	int ret;
 
 	/* See if we can just extend the last range. */
 	if (info->file_ranges_count > 0) {
@@ -310,32 +457,10 @@ static int append_ino_and_policy_id(e2fsck_t ctx, struct problem_context *pctx,
 		}
 	}
 	/* Nope, a new range is needed. */
+	ret = increase_file_ranges_capacity(ctx, info, pctx);
+	if (ret)
+		return ret;
 
-	if (info->file_ranges_count == info->file_ranges_capacity) {
-		/* Double the capacity by default. */
-		size_t new_capacity = info->file_ranges_capacity * 2;
-
-		/* ... but go from 0 to 128 right away. */
-		if (new_capacity < 128)
-			new_capacity = 128;
-
-		/* We won't need more than the filesystem's inode count. */
-		if (new_capacity > ctx->fs->super->s_inodes_count)
-			new_capacity = ctx->fs->super->s_inodes_count;
-
-		/* To be safe, ensure the capacity really increases. */
-		if (new_capacity < info->file_ranges_capacity + 1)
-			new_capacity = info->file_ranges_capacity + 1;
-
-		if (ext2fs_resize_mem(info->file_ranges_capacity *
-					sizeof(*range),
-				      new_capacity * sizeof(*range),
-				      &info->file_ranges) != 0)
-			return handle_nomem(ctx, pctx,
-					    new_capacity * sizeof(*range));
-
-		info->file_ranges_capacity = new_capacity;
-	}
 	range = &info->file_ranges[info->file_ranges_count++];
 	range->first_ino = ino;
 	range->last_ino = ino;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index ac3ffa7b..06e7d753 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2288,9 +2288,6 @@ void _e2fsck_pass1(e2fsck_t ctx)
 	ext2fs_close_inode_scan(scan);
 	scan = NULL;
 
-	/* We don't need the encryption policy => ID map any more */
-	destroy_encryption_policy_map(ctx);
-
 	if (ctx->ea_block_quota_blocks) {
 		ea_refcount_free(ctx->ea_block_quota_blocks);
 		ctx->ea_block_quota_blocks = 0;
@@ -3045,6 +3042,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
 	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
 	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
+	struct encrypted_file_info *dest_info = global_ctx->encrypted_files;
 
 #ifdef HAVE_SETJMP_H
 	jmp_buf		 old_jmp;
@@ -3079,6 +3077,7 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
 	global_ctx->block_ea_map = block_ea_map;
 	global_ctx->ea_inode_refs = ea_inode_refs;
+	global_ctx->encrypted_files = dest_info;
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_directory_count);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_regular_count);
 	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_blockdev_count);
@@ -3130,6 +3129,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
 	global_ctx->invalid_bitmaps = invalid_bitmaps;
 	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
+	retval = merge_two_encrypted_files(thread_ctx, global_ctx);
+	if (retval) {
+		com_err(global_ctx->program_name, 0,
+			_("while merging encrypted files"));
+		return retval;
+	}
 
 	/*
 	 * PASS1_COPY_CTX_BITMAP might return directly from this function,
@@ -3198,6 +3203,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 		ea_refcount_free(thread_ctx->refcount_orig);
 		thread_ctx->refcount_orig = NULL;
 	}
+	destroy_encrypted_file_info(thread_ctx);
 	e2fsck_free_dir_info(thread_ctx);
 	ext2fs_free_mem(&thread_ctx);
 
-- 
2.25.4

