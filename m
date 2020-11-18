Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BE72B80C5
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgKRPkm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgKRPkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:41 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883B8C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:41 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n10so1412118plk.14
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=qg5BK0rcxP0/PI+nGwJo9iQN43w6xws7xVsxbzy2MlQ=;
        b=qzfRpErrIEdRTyRTuM7y1Is925M7TR1zoHcNXSVdhqK5h9z7I+s8T6qo1I4QxYaH3y
         +3U9lNZ8tuBgR0buOLEKTr9WhdZRuX9Ysp4KlktazTTUlKv7Q9UTPQjvojenMOHDIxeJ
         1S8ZT1YuFPBF2uKPSqKRy/2FqpOkTDRnjnbEP7jcPFyEEKSu5sl7J2q8WNo361pOGZ0R
         3qFVuN9Y7fgaDhgwS9kUq2kobyhBKet1EGUlcpRNVShuJ/TmldV7tzlGBbeAEJlSyP60
         clRAuq8YoWDgnZbJs1AYBkvz9SFLYUr1Wb+WR5kJZL+bdjXoTOSx7kkwArZPEjNi5XTw
         Lguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qg5BK0rcxP0/PI+nGwJo9iQN43w6xws7xVsxbzy2MlQ=;
        b=FQ1bemR4LfUr+EnGUz/nKTyyTUCpmHjF1sqKMt35HKEOefSuckoW9V5B8sujZaMhQM
         lrjmfbToq746T4X8lMKJ2J5eEc9dmRQxuHQSte9e1ujQI5jj/rM6BA2tQrCBZCNF1TbZ
         vK8HeufAjSwNEe2Z1ZdI0xRjmK2F97PDpuRfDu0YgRkomBIg58mzbO6P+BxR0xab8YxG
         xvfgrQbZBzrhzK04xwBDlrAWkhTGxiF0zBIgpVd18w2NBM0s158bvN4c37DPyprJRsiR
         XgzEuSGti9ei/DgpgGXpYjTXEO4VPYOwQhAb1vvpIflwNfe9B9tt0qvTLuwTNIHTgyUI
         ZUuA==
X-Gm-Message-State: AOAM53000aQ2P0n43yRG4S6CAElOKbHvC4SNCcU219JAvOM8YsXh81yT
        7wXUxi4dMO3vwwpErEHX1WDPhxiNTv6c4XLuGOON9Z5pqKXRJg4s+Uxsf58C8cTlqYRvFBvrXAk
        Vvh7T0rQKej/UaI+CbORXojm4z+VuCb1BGBecy5y/hIpldiTFuxU/ooYAbIUc66PqTvOnCRCtIw
        Ihf229YjY=
X-Google-Smtp-Source: ABdhPJwicrj/jmUEg1L2oIFuo/N1vwlTC6ISDwvnPVTGQtgdht749rOHOYazIzuWnRDcl8npoqNcdbG4sZFJ7Mj8b3A=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr46084pjb.1.1605714040309; Wed, 18 Nov 2020 07:40:40 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:38:54 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-9-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 08/61] e2fsck: open io-channel when copying fs
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

This patch also add writethrough flag to the thread io-channel.
When multiple threads write the same disk, we don't want the
data being saved in memory cache. This will be useful in the
future, but even without that flag, the tests can be passed too.

This patch also cleanup the io channel cache of the global
context. Otherwise, after pass1 step, the next steps would use
old data saved in the cache. And the cached data might have
already been overwritten in pass1.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/e2fsck.h      |  3 +++
 e2fsck/pass1.c       | 46 ++++++++++++++++++++++++++++++++++++++----
 e2fsck/unix.c        |  1 +
 lib/ext2fs/ext2_io.h |  2 ++
 lib/ext2fs/ext2fs.h  |  3 +++
 lib/ext2fs/openfs.c  | 48 +++++++++++++++++++++++++++++++-------------
 lib/ext2fs/undo_io.c | 19 ++++++++++++++++++
 lib/ext2fs/unix_io.c | 24 +++++++++++++++++++---
 8 files changed, 125 insertions(+), 21 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index e2784248..1416f15e 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -228,6 +228,8 @@ typedef struct e2fsck_struct *e2fsck_t;
 #define MAX_EXTENT_DEPTH_COUNT 5
 
 struct e2fsck_struct {
+	/* Global context to get the cancel flag */
+	e2fsck_t		global_ctx;
 	ext2_filsys fs;
 	const char *program_name;
 	char *filesystem_name;
@@ -247,6 +249,7 @@ struct e2fsck_struct {
 	ext2_ino_t free_inodes;
 	int	mount_flags;
 	int	openfs_flags;
+	io_manager io_manager;
 	blkid_cache blkid;	/* blkid cache */
 
 #ifdef HAVE_SETJMP_H
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 14508dd8..10efa0ed 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2103,7 +2103,9 @@ static errcode_t e2fsck_pass1_copy_bitmap(ext2_filsys fs, ext2fs_generic_bitmap
 	return 0;
 }
 
-static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
+
+static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
+				      ext2_filsys src)
 {
 	errcode_t	retval;
 
@@ -2129,6 +2131,33 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 			return retval;
 	}
 
+	/* disable it for now */
+	src_context->openfs_flags &= ~EXT2_FLAG_EXCLUSIVE;
+	retval = ext2fs_open_channel(dest, src_context->io_options,
+				     src_context->io_manager,
+				     src_context->openfs_flags,
+				     src->io->block_size);
+	if (retval)
+		return retval;
+
+	/* Block size might not be default */
+	io_channel_set_blksize(dest->io, src->io->block_size);
+	ehandler_init(dest->io);
+
+	assert(dest->io->magic == src->io->magic);
+	assert(dest->io->manager == src->io->manager);
+	assert(strcmp(dest->io->name, src->io->name) == 0);
+	assert(dest->io->block_size == src->io->block_size);
+	assert(dest->io->read_error == src->io->read_error);
+	assert(dest->io->write_error == src->io->write_error);
+	assert(dest->io->refcount == src->io->refcount);
+	assert(dest->io->flags == src->io->flags);
+	assert(dest->io->app_data == dest);
+	assert(src->io->app_data == src);
+	assert(dest->io->align == src->io->align);
+
+	/* The data should be written to disk immediately */
+	dest->io->flags |= CHANNEL_FLAGS_WRITETHROUGH;
 	/* icache will be rebuilt if needed, so do not copy from @src */
 	src->icache = NULL;
 	return 0;
@@ -2137,9 +2166,17 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
 	struct ext2_inode_cache *icache = dest->icache;
-	errcode_t	retval = 0;
+	errcode_t retval = 0;
+	io_channel dest_io;
+	io_channel dest_image_io;
+
+	dest_io = dest->io;
+	dest_image_io = dest->image_io;
 
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	dest->io = dest_io;
+	dest->image_io = dest_image_io;
+	dest->icache = icache;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 	if (src->inode_map) {
@@ -2154,7 +2191,6 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		if (retval)
 			return retval;
 	}
-	dest->icache = icache;
 
 	if (src->icache) {
 		ext2fs_free_inode_cache(src->icache);
@@ -2168,6 +2204,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		src->badblocks = NULL;
 	}
 
+	io_channel_close(src->io);
 	return retval;
 }
 
@@ -2205,7 +2242,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_context;
 	}
 
-	retval = e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	io_channel_flush_cleanup(global_fs->io);
+	retval = e2fsck_pass1_copy_fs(thread_fs, global_ctx, global_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while copying fs");
 		goto out_fs;
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 42f616e2..f973af62 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1525,6 +1525,7 @@ restart:
 	}
 
 	ctx->openfs_flags = flags;
+	ctx->io_manager = io_ptr;
 	retval = try_open_fs(ctx, flags, io_ptr, &fs);
 
 	if (!ctx->superblock && !(ctx->options & E2F_OPT_PREEN) &&
diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 5540900a..4ad2fec8 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -81,6 +81,7 @@ struct struct_io_manager {
 	errcode_t (*write_blk)(io_channel channel, unsigned long block,
 			       int count, const void *data);
 	errcode_t (*flush)(io_channel channel);
+	errcode_t (*flush_cleanup)(io_channel channel);
 	errcode_t (*write_byte)(io_channel channel, unsigned long offset,
 				int count, const void *data);
 	errcode_t (*set_option)(io_channel channel, const char *option,
@@ -113,6 +114,7 @@ struct struct_io_manager {
 #define io_channel_read_blk(c,b,n,d)	((c)->manager->read_blk((c),b,n,d))
 #define io_channel_write_blk(c,b,n,d)	((c)->manager->write_blk((c),b,n,d))
 #define io_channel_flush(c) 		((c)->manager->flush((c)))
+#define io_channel_flush_cleanup(c) 	((c)->manager->flush_cleanup((c)))
 #define io_channel_bumpcount(c)		((c)->refcount++)
 
 /* io_manager.c */
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 69c8a3ff..5b76d02e 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1643,6 +1643,9 @@ extern errcode_t ext2fs_open2(const char *name, const char *io_options,
 			      int flags, int superblock,
 			      unsigned int block_size, io_manager manager,
 			      ext2_filsys *ret_fs);
+errcode_t ext2fs_open_channel(ext2_filsys fs, const char *io_options,
+			      io_manager manager, int flags,
+			      int blocksize);
 /*
  * The dgrp_t argument to these two functions is not actually a group number
  * but a block number offset within a group table!  Convert with the formula
diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index 3ed1e25c..7e93d145 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -99,6 +99,38 @@ static void block_sha_map_free_entry(void *data)
 	return;
 }
 
+errcode_t ext2fs_open_channel(ext2_filsys fs, const char *io_options,
+			      io_manager manager, int flags,
+			      int blocksize)
+{
+	errcode_t	retval;
+	unsigned int	io_flags = 0;
+
+	if (flags & EXT2_FLAG_RW)
+		io_flags |= IO_FLAG_RW;
+	if (flags & EXT2_FLAG_EXCLUSIVE)
+		io_flags |= IO_FLAG_EXCLUSIVE;
+	if (flags & EXT2_FLAG_DIRECT_IO)
+		io_flags |= IO_FLAG_DIRECT_IO;
+	retval = manager->open(fs->device_name, io_flags, &fs->io);
+	if (retval)
+		return retval;
+
+	if (io_options &&
+	    (retval = io_channel_set_options(fs->io, io_options)))
+		goto out_close;
+	fs->image_io = fs->io;
+	fs->io->app_data = fs;
+
+	if (blocksize > 0)
+		io_channel_set_blksize(fs->io, blocksize);
+
+	return 0;
+out_close:
+	io_channel_close(fs->io);
+	return retval;
+}
+
 /*
  *  Note: if superblock is non-zero, block-size must also be non-zero.
  * 	Superblock and block_size can be zero to use the default size.
@@ -122,7 +154,7 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 	errcode_t	retval;
 	unsigned long	i, first_meta_bg;
 	__u32		features;
-	unsigned int	blocks_per_group, io_flags;
+	unsigned int	blocks_per_group;
 	blk64_t		group_block, blk;
 	char		*dest, *cp;
 	int		group_zero_adjust = 0;
@@ -163,21 +195,9 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 		io_options = cp;
 	}
 
-	io_flags = 0;
-	if (flags & EXT2_FLAG_RW)
-		io_flags |= IO_FLAG_RW;
-	if (flags & EXT2_FLAG_EXCLUSIVE)
-		io_flags |= IO_FLAG_EXCLUSIVE;
-	if (flags & EXT2_FLAG_DIRECT_IO)
-		io_flags |= IO_FLAG_DIRECT_IO;
-	retval = manager->open(fs->device_name, io_flags, &fs->io);
+	retval = ext2fs_open_channel(fs, io_options, manager, flags, 0);
 	if (retval)
 		goto cleanup;
-	if (io_options &&
-	    (retval = io_channel_set_options(fs->io, io_options)))
-		goto cleanup;
-	fs->image_io = fs->io;
-	fs->io->app_data = fs;
 	retval = io_channel_alloc_buf(fs->io, -SUPERBLOCK_SIZE, &fs->super);
 	if (retval)
 		goto cleanup;
diff --git a/lib/ext2fs/undo_io.c b/lib/ext2fs/undo_io.c
index 19862414..1391a534 100644
--- a/lib/ext2fs/undo_io.c
+++ b/lib/ext2fs/undo_io.c
@@ -1020,6 +1020,24 @@ static errcode_t undo_flush(io_channel channel)
 	return retval;
 }
 
+/*
+ * Flush data buffers to disk and cleanup the cache.
+ */
+static errcode_t undo_flush_cleanup(io_channel channel)
+{
+	errcode_t	retval = 0;
+	struct undo_private_data *data;
+
+	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
+	data = (struct undo_private_data *) channel->private_data;
+	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
+
+	if (data->real)
+		retval = io_channel_flush_cleanup(data->real);
+
+	return retval;
+}
+
 static errcode_t undo_set_option(io_channel channel, const char *option,
 				 const char *arg)
 {
@@ -1091,6 +1109,7 @@ static struct struct_io_manager struct_undo_manager = {
 	.read_blk	= undo_read_blk,
 	.write_blk	= undo_write_blk,
 	.flush		= undo_flush,
+	.flush_cleanup	= undo_flush_cleanup,
 	.write_byte	= undo_write_byte,
 	.set_option	= undo_set_option,
 	.get_stats	= undo_get_stats,
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 628e60c3..c9defd4b 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1030,9 +1030,9 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 }
 
 /*
- * Flush data buffers to disk.
+ * Flush data buffers to disk and invalidate cache if needed
  */
-static errcode_t unix_flush(io_channel channel)
+static errcode_t _unix_flush(io_channel channel, int invalidate)
 {
 	struct unix_private_data *data;
 	errcode_t retval = 0;
@@ -1042,7 +1042,7 @@ static errcode_t unix_flush(io_channel channel)
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
 #ifndef NO_IO_CACHE
-	retval = flush_cached_blocks(channel, data, 0);
+	retval = flush_cached_blocks(channel, data, invalidate);
 #endif
 #ifdef HAVE_FSYNC
 	if (!retval && fsync(data->dev) != 0)
@@ -1051,6 +1051,22 @@ static errcode_t unix_flush(io_channel channel)
 	return retval;
 }
 
+/*
+ * Flush data buffers to disk.
+ */
+static errcode_t unix_flush(io_channel channel)
+{
+	return _unix_flush(channel, 0);
+}
+
+/*
+ * Flush data buffers to disk and invalidate cache.
+ */
+static errcode_t unix_flush_cleanup(io_channel channel)
+{
+	return _unix_flush(channel, 1);
+}
+
 static errcode_t unix_set_option(io_channel channel, const char *option,
 				 const char *arg)
 {
@@ -1225,6 +1241,7 @@ static struct struct_io_manager struct_unix_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flush_cleanup	= unix_flush_cleanup,
 };
 
 io_manager unix_io_manager = &struct_unix_manager;
@@ -1246,6 +1263,7 @@ static struct struct_io_manager struct_unixfd_manager = {
 	.discard	= unix_discard,
 	.cache_readahead	= unix_cache_readahead,
 	.zeroout	= unix_zeroout,
+	.flush_cleanup	= unix_flush_cleanup,
 };
 
 io_manager unixfd_io_manager = &struct_unixfd_manager;
-- 
2.29.2.299.gdc1121823c-goog

