Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FEA1FF6AB
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgFRP2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgFRP2k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD12C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s23so2934664pfh.7
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/TRhWWFlk0kjW+bCFPrhQQJZUsLXBMgZVZeLcdCGQ4U=;
        b=rdkGJfUMwu7V1/85JOZaMyxeu6JUyU3jJiXr4r6qJ3cUsSvgnn26t+Z1hLw/df3Ddk
         D7+yKx6RTvi4IuRsuIFKtZVI8A+WJUsLw+nT49GP747LGmWtch6CLhdRP6G3gXoBGhia
         HWupqPCidU4wbFvrQWQfptwOv8TUVgHKtroWD4LRIC/Eo89/YBm+Epr22XxXNk+c3YmE
         lm6fZYHeqjf3x/Ml/gYeWzL10LOwSc+ZyU16Is6FwGONoTrMMNNj1liLjEx15gSHgCVr
         19ed+WQTRuWWdMqLuVqvZCQALJZ5dEDkkKk67Y34SQRuWQoQ/+z0wHvJk9R022tc+qvO
         KSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/TRhWWFlk0kjW+bCFPrhQQJZUsLXBMgZVZeLcdCGQ4U=;
        b=Yhtwy149KWrvfDKa0MLtmLreKy7YkQnN3fntF+HXlqSTxLzdd/THUB8UpBs5tAhhja
         tsTPEXAuQI0GN7j3W/ddPyx4L00e8ipHc/UjQfCD9njmR5YOmyycM6LhGePGtYx+73nm
         5qkYawuKXl6eb6mMjaVTATUhh2ywAYUcAHAJ/ZYGnGaQ/eU7ZCdqlp3PjT8j6BfX+peW
         MsyZSB3fOfweZQjA2pK834WzThH3RogELm0YuRVLMAnmS1C2BnIPnNsMb7/3dQr/rmGo
         yigTTaDzqaAAgTf+Lk84DW+ENsVEZNYsuWaRbc0ww65JCnMEICHa5U+B/A2M8Ixb3bA2
         4RHQ==
X-Gm-Message-State: AOAM530ur0tn9CPyAtpjjrnQ5+k7PtUkaJTE2UTUOy1FCzfEc7ejPhLO
        0Vrpd2z5bjRKYgTrJ0Q/99oMjIdZquk=
X-Google-Smtp-Source: ABdhPJyeOX0GlQGL2QU5uiUPgC/y211MWDO1qpuBSwaKOxDUHXIpfzDoIaZPBIP8CqEMEJtKcACfDg==
X-Received: by 2002:a62:7712:: with SMTP id s18mr4143341pfc.145.1592494119154;
        Thu, 18 Jun 2020 08:28:39 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:38 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 11/51] e2fsck: open io-channel when copying fs
Date:   Fri, 19 Jun 2020 00:27:14 +0900
Message-Id: <1592494074-28991-12-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

This patch also add writethrough flag to the thread io-channel.
When multiple threads write the same disk, we don't want the
data being saved in memory cache. This will be useful in the
future, but even without that flag, the tests can be passed too.

This patch also cleanup the io channel cache of the global
context. Otherwise, after pass1 step, the next steps would old
data saved in the cache. And the cached data might have already
been overwritten in the pass1 step.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/e2fsck.h      |  1 +
 e2fsck/pass1.c       | 71 ++++++++++++++++++++++++++++++++++++++++++--
 e2fsck/unix.c        |  1 +
 lib/ext2fs/ext2_io.h |  2 ++
 lib/ext2fs/undo_io.c | 19 ++++++++++++
 lib/ext2fs/unix_io.c | 24 +++++++++++++--
 6 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 46792c9b..8925b5d8 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -244,6 +244,7 @@ struct e2fsck_struct {
 	ext2_ino_t		 free_inodes;
 	int			 mount_flags;
 	int			 openfs_flags;
+	io_manager		 io_manager;
 	blkid_cache		 blkid; /* blkid cache */
 #ifdef HAVE_SETJMP_H
 	jmp_buf			 abort_loc;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index a1feb166..013c8478 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2115,7 +2115,37 @@ do {									\
     }									\
 } while (0)
 
-static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
+static errcode_t pass1_open_io_channel(ext2_filsys fs,
+				       const char *io_options,
+				       io_manager manager, int flags)
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
+	return 0;
+out_close:
+	io_channel_close(fs->io);
+	return retval;
+}
+
+static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, e2fsck_t src_context,
+				      ext2_filsys src)
 {
 	errcode_t	retval;
 
@@ -2153,6 +2183,33 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
 		ext2fs_badblocks_list_free(src->badblocks);
 		src->badblocks = NULL;
 	}
+
+	/* disable it for now */
+	src_context->openfs_flags &= ~EXT2_FLAG_EXCLUSIVE;
+	retval = pass1_open_io_channel(dest, src_context->io_options,
+				       src_context->io_manager,
+				       src_context->openfs_flags);
+	if (retval)
+		goto out_dblist;
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
 	return 0;
 
 out_dblist:
@@ -2163,9 +2220,15 @@ out_dblist:
 
 static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 {
-	errcode_t	retval = 0;
+	errcode_t retval = 0;
+	io_channel dest_io;
+	io_channel dest_image_io;
 
+	dest_io = dest->io;
+	dest_image_io = dest->image_io;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
+	dest->io = dest_io;
+	dest->image_io = dest_image_io;
 	/*
 	 * PASS1_COPY_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
@@ -2186,6 +2249,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		if (retval)
 			goto out_dblist;
 	}
+	io_channel_close(src->io);
 	return 0;
 out_dblist:
 	ext2fs_free_dblist(dest->dblist);
@@ -2252,7 +2316,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_context;
 	}
 
-	retval = e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	io_channel_flush_cleanup(global_fs->io);
+	retval = e2fsck_pass1_copy_fs(thread_fs, global_ctx, global_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while copying fs");
 		goto out_fs;
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 83b62032..3124019a 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -1524,6 +1524,7 @@ restart:
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
2.25.4

