Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3C931A1F15
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgDHKrE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:47:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41117 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgDHKrE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:47:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id d24so2369925pll.8
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RAjuh+1btcAwdLSNciTi1bbEpinto8548BF42CS+vUs=;
        b=keW/WNWKaSxYxgkbLOGpu+2lrONGpCmNLP2LUO3v4uJEMpaXgEUjchWvPBxHw8IJ0H
         HW3kzyuwgaCMle8NYUai0WU1usLyGQi2XMFrX4ehgbjfEiIlmWCFtkK0D5z3U0zpE6EO
         9BdKrZ+O4xUPrAeytTCmclP9LSPYskh4MECcEUbY0qRhOLAhcG7G+3ga/JHU8xNwke5l
         7u8BRYVq9xNUm5YFbiJhkKmwaweAFBrqKmp0W46Trz1XVgAwIdSTbjfFOBT7neN3MowK
         7kI8htvhjNIhleh8fylQJkVIZ47EjIFRcKpyDyvj733mzmy0WzAgGqWKeg3eXa+LCPkr
         8nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RAjuh+1btcAwdLSNciTi1bbEpinto8548BF42CS+vUs=;
        b=JDqaTHgcNNINo0SUoTp2AEaaZGktcQJT0j/iwCE1l7wBvDUtfd4o+08ELNUykT8ZM0
         J7JMlgxCM1xf5wr0O4hscjZz5QT3nuwKhJSm+UV7TGuSSzsr3n2LSM05TUFQiQG7PK2l
         eN816wokKi5fC9HSQ15v65Ef08uOjFWpfE+E03/9y1/qm/dHcKXOtI+jcNSleZQ8WJkB
         2j+suWYvNx3AUhoHdSIskO/MO3FtMBmWqBE+Mmvj4qszizqhU1lqiugr0N+o7o+CKr6N
         HQ3Y1AUgwVgNM6tvROy7O11qfN5XXTXpZwUXx5WBeXiSl2H9JTFa/vsV2rF1aBcAng1d
         nglw==
X-Gm-Message-State: AGi0PuYNe5VfR56Bpy/xFByf/fTDYjGn2s33EMFsc8K9Sb3BjLeyxn0h
        6SZGOcUIiXKWccTDY2CMqN79pALeCsw=
X-Google-Smtp-Source: APiQypKyOS9UcZgY/VXinJgFVzpBh//1Hj4NyKs6Z3FNqzdeqNr+F4tSI/o1mY4PlPNrX4M7FBgqqQ==
X-Received: by 2002:a17:90b:8e:: with SMTP id bb14mr4766011pjb.13.1586342822827;
        Wed, 08 Apr 2020 03:47:02 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.47.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:47:02 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 42/46] e2fsck: simplify e2fsck context merging codes
Date:   Wed,  8 Apr 2020 19:45:10 +0900
Message-Id: <1586342714-12536-43-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

We tried to copy thread context to global context directly
and then copy back some saved variables before merging.

Since we have finished almost all necessary variables
in the e2fsck context, we could simplify codes, and
this could help us understand what is missing rather
than hide problems.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c | 147 +++++++++----------------------------------------
 1 file changed, 25 insertions(+), 122 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index d7d37d8b..3c3d9251 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2387,11 +2387,6 @@ do {									\
     }									\
 } while (0)
 
-#define PASS1_MERGE_CTX_COUNT(_dest, _src, _field)			\
-do {									\
-    _dest->_field = _field + _src->_field;				\
-} while (0)
-
 static errcode_t pass1_open_io_channel(ext2_filsys fs,
 				       const char *io_options,
 				       io_manager manager, int flags)
@@ -2508,6 +2503,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2_badblocks_list badblocks;
 	ext2_dblist dblist;
 	int flags;
+	e2fsck_t dest_ctx = dest->priv_data;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
@@ -2523,6 +2519,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->block_map = block_map;
 	dest->badblocks = badblocks;
 	dest->dblist = dblist;
+	dest->priv_data = dest_ctx;
 	dest->flags = src->flags | flags;
 	if (!(src->flags & EXT2_FLAG_VALID) || !(flags & EXT2_FLAG_VALID))
 		ext2fs_unmark_valid(dest);
@@ -2985,130 +2982,42 @@ static errcode_t e2fsck_pass1_merge_ea_refcount(e2fsck_t global_ctx,
 	return retval;
 }
 
-static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx)
+static errcode_t e2fsck_pass1_merge_context(e2fsck_t global_ctx,
+					    e2fsck_t thread_ctx)
 {
-	errcode_t	 retval;
-	int		 flags = global_ctx->flags;
-	ext2_filsys	 thread_fs = thread_ctx->fs;
-	ext2_filsys	 global_fs = global_ctx->fs;
-	FILE		*global_logf = global_ctx->logf;
-	FILE		*global_problem_logf = global_ctx->problem_logf;
-	struct dir_info_db *dir_info = global_ctx->dir_info;
-	struct dx_dir_info *dx_dir_info = global_ctx->dx_dir_info;
-	ext2fs_inode_bitmap inode_used_map = global_ctx->inode_used_map;
-	ext2fs_inode_bitmap inode_dir_map = global_ctx->inode_dir_map;
-	ext2fs_inode_bitmap inode_bb_map = global_ctx->inode_bb_map;
-	ext2fs_inode_bitmap inode_imagic_map = global_ctx->inode_imagic_map;
-	ext2fs_inode_bitmap inode_reg_map = global_ctx->inode_reg_map;
-	ext2fs_block_bitmap inodes_to_rebuild = global_ctx->inodes_to_rebuild;
-	ext2_icount_t inode_count = global_ctx->inode_count;
-	ext2_icount_t inode_link_info = global_ctx->inode_link_info;
-	__u32	fs_directory_count = global_ctx->fs_directory_count;
-	__u32	fs_regular_count = global_ctx->fs_regular_count;
-	__u32	fs_blockdev_count = global_ctx->fs_blockdev_count;
-	__u32	fs_chardev_count = global_ctx->fs_chardev_count;
-	__u32	fs_links_count = global_ctx->fs_links_count;
-	__u32	fs_symlinks_count = global_ctx->fs_symlinks_count;
-	__u32	fs_fast_symlinks_count = global_ctx->fs_fast_symlinks_count;
-	__u32	fs_fifo_count = global_ctx->fs_fifo_count;
-	__u32	fs_total_count = global_ctx->fs_total_count;
-	__u32	fs_badblocks_count = global_ctx->fs_badblocks_count;
-	__u32	fs_sockets_count = global_ctx->fs_sockets_count;
-	__u32	fs_ind_count = global_ctx->fs_ind_count;
-	__u32	fs_dind_count = global_ctx->fs_dind_count;
-	__u32	fs_tind_count = global_ctx->fs_tind_count;
-	__u32	fs_fragmented = global_ctx->fs_fragmented;
-	__u32	fs_fragmented_dir = global_ctx->fs_fragmented_dir;
-	__u32	large_files = global_ctx->large_files;
-	int dx_dir_info_size = global_ctx->dx_dir_info_size;
-	int dx_dir_info_count = global_ctx->dx_dir_info_count;
-	ext2_u32_list dirs_to_hash = global_ctx->dirs_to_hash;
-	quota_ctx_t qctx = global_ctx->qctx;
-	int *invalid_block_bitmap_flag = global_ctx->invalid_block_bitmap_flag;
-	int *invalid_inode_bitmap_flag = global_ctx->invalid_inode_bitmap_flag;
-	int *invalid_inode_table_flag  = global_ctx->invalid_inode_table_flag;
-	int invalid_bitmaps = global_ctx->invalid_bitmaps;
-	ext2_refcount_t refcount = global_ctx->refcount;
-	ext2_refcount_t refcount_extra = global_ctx->refcount_extra;
-	ext2_refcount_t refcount_orig = global_ctx->refcount_orig;
-	ext2_refcount_t ea_block_quota_blocks = global_ctx->ea_block_quota_blocks;
-	ext2_refcount_t ea_block_quota_inodes = global_ctx->ea_block_quota_inodes;
-	ext2fs_block_bitmap block_ea_map = global_ctx->block_ea_map;
-	ext2_refcount_t ea_inode_refs = global_ctx->ea_inode_refs;
-	ext2fs_block_bitmap  block_found_map = global_ctx->block_found_map;
-	ext2fs_block_bitmap  block_dup_map = global_ctx->block_dup_map;
-	struct encrypted_file_info *dest_info = global_ctx->encrypted_files;
-
-#ifdef HAVE_SETJMP_H
-	jmp_buf		 old_jmp;
+	errcode_t retval;
 
-	memcpy(old_jmp, global_ctx->abort_loc, sizeof(jmp_buf));
-#endif
-	memcpy(global_ctx, thread_ctx, sizeof(struct e2fsck_struct));
-#ifdef HAVE_SETJMP_H
-	memcpy(global_ctx->abort_loc, old_jmp, sizeof(jmp_buf));
-#endif
+	global_ctx->fs_directory_count += thread_ctx->fs_directory_count;
+	global_ctx->fs_regular_count += thread_ctx->fs_regular_count;
+	global_ctx->fs_blockdev_count += thread_ctx->fs_blockdev_count;
+	global_ctx->fs_chardev_count += thread_ctx->fs_chardev_count;
+	global_ctx->fs_links_count += thread_ctx->fs_links_count;
+	global_ctx->fs_symlinks_count += thread_ctx->fs_symlinks_count;
+	global_ctx->fs_fast_symlinks_count += thread_ctx->fs_fast_symlinks_count;
+	global_ctx->fs_fifo_count += thread_ctx->fs_fifo_count;
+	global_ctx->fs_total_count += thread_ctx->fs_total_count;
+	global_ctx->fs_badblocks_count += thread_ctx->fs_badblocks_count;
+	global_ctx->fs_sockets_count += thread_ctx->fs_sockets_count;
+	global_ctx->fs_ind_count += thread_ctx->fs_ind_count;
+	global_ctx->fs_dind_count += thread_ctx->fs_dind_count;
+	global_ctx->fs_tind_count += thread_ctx->fs_tind_count;
+	global_ctx->fs_fragmented += thread_ctx->fs_fragmented;
+	global_ctx->fs_fragmented_dir += thread_ctx->fs_fragmented_dir;
+	global_ctx->large_files += thread_ctx->large_files;
+	global_ctx->flags |= thread_ctx->flags;
 
-	global_ctx->inode_used_map = inode_used_map;
-	global_ctx->inode_dir_map = inode_dir_map;
-	global_ctx->inode_bb_map = inode_bb_map;
-	global_ctx->inode_imagic_map = inode_imagic_map;
-	global_ctx->inodes_to_rebuild = inodes_to_rebuild;
-	global_ctx->inode_reg_map = inode_reg_map;
-	global_ctx->block_dup_map = block_dup_map;
-	global_ctx->block_found_map = block_found_map;
-	global_ctx->dir_info = dir_info;
 	e2fsck_pass1_merge_dir_info(global_ctx, thread_ctx);
-	global_ctx->dx_dir_info = dx_dir_info;
-	global_ctx->dx_dir_info_count = dx_dir_info_count;
-	global_ctx->dx_dir_info_size = dx_dir_info_size;
 	e2fsck_pass1_merge_dx_dir(global_ctx, thread_ctx);
-	global_ctx->inode_count = inode_count;
-	global_ctx->inode_link_info = inode_link_info;
-	global_ctx->refcount = refcount;
-	global_ctx->refcount_extra = refcount_extra;
-	global_ctx->refcount_orig = refcount_orig;
-	global_ctx->ea_block_quota_blocks = ea_block_quota_blocks;
-	global_ctx->ea_block_quota_inodes = ea_block_quota_inodes;
-	global_ctx->block_ea_map = block_ea_map;
-	global_ctx->ea_inode_refs = ea_inode_refs;
-	global_ctx->encrypted_files = dest_info;
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_directory_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_regular_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_blockdev_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_chardev_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_links_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_symlinks_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fast_symlinks_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fifo_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_total_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_badblocks_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_sockets_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_ind_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_dind_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_tind_count);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, fs_fragmented_dir);
-	PASS1_MERGE_CTX_COUNT(global_ctx, thread_ctx, large_files);
-
-	global_ctx->flags |= flags;
-
-	retval = e2fsck_pass1_merge_fs(global_fs, thread_fs);
+	retval = e2fsck_pass1_merge_fs(global_ctx->fs, thread_ctx->fs);
 	if (retval) {
 		com_err(global_ctx->program_name, 0, _("while merging fs\n"));
 		return retval;
 	}
-	global_fs->priv_data = global_ctx;
-	global_ctx->fs = global_fs;
-	global_ctx->logf = global_logf;
-	global_ctx->problem_logf = global_problem_logf;
-	global_ctx->global_ctx = NULL;
 	retval = e2fsck_pass1_merge_icounts(global_ctx, thread_ctx);
 	if (retval) {
 	com_err(global_ctx->program_name, 0, _("while merging icounts\n"));
 		return retval;
 	}
-	global_ctx->dirs_to_hash = dirs_to_hash;
 	retval = e2fsck_pass1_merge_dirs_to_hash(global_ctx, thread_ctx);
 	if (retval) {
 		com_err(global_ctx->program_name, 0, _("while merging dirs to hash\n"));
@@ -3116,18 +3025,12 @@ static int e2fsck_pass1_thread_join_one(e2fsck_t global_ctx, e2fsck_t thread_ctx
 	}
 	e2fsck_pass1_merge_ea_inode_refs(global_ctx, thread_ctx);
 	e2fsck_pass1_merge_ea_refcount(global_ctx, thread_ctx);
-	global_ctx->qctx = qctx;
 	e2fsck_pass1_merge_quota_ctx(global_ctx, thread_ctx);
 	retval = ext2fs_merge_bitmap(thread_ctx->block_found_map,
 				     global_ctx->block_found_map,
 				     global_ctx->block_dup_map);
-	e2fsck_pass1_block_map_unlock(global_ctx);
 	if (retval == EEXIST)
 		global_ctx->flags |= E2F_FLAG_DUP_BLOCK;
-	global_ctx->invalid_block_bitmap_flag = invalid_block_bitmap_flag;
-	global_ctx->invalid_inode_bitmap_flag = invalid_inode_bitmap_flag;
-	global_ctx->invalid_inode_table_flag = invalid_inode_table_flag;
-	global_ctx->invalid_bitmaps = invalid_bitmaps;
 	e2fsck_pass1_merge_invalid_bitmaps(global_ctx, thread_ctx);
 	retval = merge_two_encrypted_files(thread_ctx, global_ctx);
 	if (retval) {
@@ -3156,7 +3059,7 @@ static int e2fsck_pass1_thread_join(e2fsck_t global_ctx, e2fsck_t thread_ctx)
 {
 	errcode_t	retval;
 
-	retval = e2fsck_pass1_thread_join_one(global_ctx, thread_ctx);
+	retval = e2fsck_pass1_merge_context(global_ctx, thread_ctx);
 	ext2fs_free_mem(&thread_ctx->fs);
 	if (thread_ctx->logf)
 		fclose(thread_ctx->logf);
-- 
2.25.2

