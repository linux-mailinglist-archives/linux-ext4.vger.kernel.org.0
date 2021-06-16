Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCBF3A90D8
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFPE6w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:38820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFPE6s (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B28E6610A0
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819402;
        bh=npg/SFMqOdeEQmJVunISpFeJ9hc6ZEklmlbgQAbrrfA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VIyOn3F3WOO1Azq1WOCETsioVdKogH0x8Blxh7b2FhCfaNgoUtHiDCan/0mfgo+HC
         6wMHlUYb9yC8twKVhS9dQEobTgzEbdkCR51pAThOk30IfrtULaeCQhGspWJGW3BQ+u
         yl0cZmMbPd+6TzXNm4ro1IJi7VLQCzcQwLyYuEQNWD7RsfUh30hJgreHLsYr/hSh8d
         gKQk8ctLRmvzpzWAefNqV4Qp6nhGhSwnlXnw2PavMZd3GFeOFr52vL6ZihFwfc8yVa
         mNkreLJ383WkC0dJUSDQRPp3+DTCaHH6rLBRX1Ibg3zjKZO0T/DzstQYCyNRe32cvz
         h8ETyuz5oFwCA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/6] Fix -Wunused-parameter warnings
Date:   Tue, 15 Jun 2021 21:53:32 -0700
Message-Id: <20210616045334.1655288-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fix all warnings about unused function parameters that were introduced
since e2fsprogs v1.45.4, by adding EXT2FS_ATTR((unused)) or removing
parameters as appropriate.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 debugfs/journal.c     | 3 ++-
 e2fsck/jfs_user.h     | 3 ++-
 e2fsck/journal.c      | 7 ++++---
 e2fsck/pass1b.c       | 3 ++-
 e2fsck/pass2.c        | 3 ++-
 lib/support/mkquota.c | 3 ++-
 6 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 686d0eb0..095fff00 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -161,7 +161,8 @@ int sync_blockdev(kdev_t kdev)
 	return io_channel_flush(io) ? EIO : 0;
 }
 
-void ll_rw_block(int rw, int op_flags, int nr, struct buffer_head *bhp[])
+void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
+		 struct buffer_head *bhp[])
 {
 	errcode_t retval;
 	struct buffer_head *bh;
diff --git a/e2fsck/jfs_user.h b/e2fsck/jfs_user.h
index 1babf417..6d24558b 100644
--- a/e2fsck/jfs_user.h
+++ b/e2fsck/jfs_user.h
@@ -92,7 +92,8 @@ typedef struct kmem_cache {
 #define kmalloc(len, flags) malloc(len)
 #define kfree(p) free(p)
 
-static inline void *kmalloc_array(unsigned n, unsigned size, int flags)
+static inline void *kmalloc_array(unsigned n, unsigned size,
+				  int flags EXT2FS_ATTR((unused)))
 {
 	if (n && (~0U)/n < size)
 		return NULL;
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a0a4d968..5a06e26e 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -155,7 +155,8 @@ int sync_blockdev(kdev_t kdev)
 	return io_channel_flush(io) ? -EIO : 0;
 }
 
-void ll_rw_block(int rw, int op_flags, int nr, struct buffer_head *bhp[])
+void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
+		 struct buffer_head *bhp[])
 {
 	errcode_t retval;
 	struct buffer_head *bh;
@@ -439,7 +440,7 @@ static int ex_len_compar(const void *arg1, const void *arg2)
 	return 0;
 }
 
-static void ex_sort_and_merge(e2fsck_t ctx, struct extent_list *list)
+static void ex_sort_and_merge(struct extent_list *list)
 {
 	blk64_t ex_end;
 	int i, j;
@@ -549,7 +550,7 @@ static int ext4_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
 		list->extents[list->count - 1] = add_ex;
 	}
 
-	ex_sort_and_merge(ctx, list);
+	ex_sort_and_merge(list);
 
 	/* Mark all occupied blocks allocated */
 	for (i = 0; i < list->count; i++)
diff --git a/e2fsck/pass1b.c b/e2fsck/pass1b.c
index 656a275b..92c746c1 100644
--- a/e2fsck/pass1b.c
+++ b/e2fsck/pass1b.c
@@ -104,7 +104,8 @@ static dict_t clstr_dict, ino_dict;
 
 static ext2fs_inode_bitmap inode_dup_map;
 
-static int dict_int_cmp(const void* cmp_ctx, const void *a, const void *b)
+static int dict_int_cmp(const void *cmp_ctx EXT2FS_ATTR((unused)),
+			const void *a, const void *b)
 {
 	intptr_t	ia, ib;
 
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index e504b30a..1b2cb94a 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -332,7 +332,8 @@ static short htree_depth(struct dx_dir_info *dx_dir,
 	return depth;
 }
 
-static int dict_de_cmp(const void *cmp_ctx, const void *a, const void *b)
+static int dict_de_cmp(const void *cmp_ctx EXT2FS_ATTR((unused)),
+		       const void *a, const void *b)
 {
 	const struct ext2_dir_entry *de_a, *de_b;
 	int	a_len, b_len;
diff --git a/lib/support/mkquota.c b/lib/support/mkquota.c
index fbc3833a..71f42c2c 100644
--- a/lib/support/mkquota.c
+++ b/lib/support/mkquota.c
@@ -234,7 +234,8 @@ out:
 /* Helper functions for computing quota in memory.                */
 /******************************************************************/
 
-static int dict_uint_cmp(const void *cmp_ctx, const void *a, const void *b)
+static int dict_uint_cmp(const void *cmp_ctx EXT2FS_ATTR((unused)),
+			 const void *a, const void *b)
 {
 	unsigned int	c, d;
 
-- 
2.32.0.272.g935e593368-goog

