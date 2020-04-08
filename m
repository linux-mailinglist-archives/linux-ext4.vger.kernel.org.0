Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53951A1EF4
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgDHKp5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:45:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34551 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgDHKp5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:45:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so3165829pgb.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xP864B6n00DWI8Mf+UC9hdnca8hS7dAYH/apD6+/5jQ=;
        b=Vf6NjiOSYxwoElUMRBvVpJ6fM2YOOjTfHE6KuD82aiCYcbaEb4t3eR8A9ytJwFKSdx
         JQThT100+o4IkTZBx0Htb6DurIlSnP3+z+rFWKXL1jcVbpa05ROa08bmyfFzFAUs2e1q
         SbBjaS+adeTIK96wcMqCLrhyPLdgOfkneXWNnUKboTCJJkzH5puzZTg2Fq3kBloc49me
         ucp4KjriBLhUyVFQQC+EIDD+Yr2yxMabMeHW+qsG3A4JLco1Puqjiv2ojWx4g2jeWku5
         Hf/Uk3LbYzsyZoNl4Q+V+E+2YGMFEZ4WDOvhBS1/8tp4ZlEfE7Glh1UwZRhYF7Y3BiiQ
         9Czg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xP864B6n00DWI8Mf+UC9hdnca8hS7dAYH/apD6+/5jQ=;
        b=qN9aI8dfZ8to0Q03JvOtUyvfZd6CbMN4eUM4x9ishhvs9lzIS06A5H6Dewxvrp0JNF
         AWCFsbFeUyzc4Ig9XulbujHOl2iBdTRQ/VC2UWwgnUPVhHo1UCg8sxByo1+iL9gzrlcA
         +WUw8S4iQJoQiXpiG0f8VPUSy0oHsr57xXEuerGuP501a52RsaqZ8SpMo+POU10IZXmp
         9KlWQNo6GSwK124dJ28uBfb9S6lfkeki1uuITk51KouE/CkbkT4IYYUIrRFo+6uEwIqy
         6mhXuueyxh2hC7LjgdpQKhaSnj35v8Mz8XP6JyKevr7PtMDt0SdDQVltMOu1b/c71Bih
         nj6A==
X-Gm-Message-State: AGi0PuYRM3bq/eZ8pu07sGdkUezMkzHnbO9FmadJW3MfqmI8MxfcSSXn
        dMGGWHAyXBU/HqQhML28SQbz8vd8Gkg=
X-Google-Smtp-Source: APiQypLZN1ea24lQKPgLoVCCEpP0Er3xlSdObLeAdiwgnR+Ut5M6konG9nMhoPOZDKKuwgeSYRXIzg==
X-Received: by 2002:a63:cf49:: with SMTP id b9mr6468776pgj.221.1586342754530;
        Wed, 08 Apr 2020 03:45:54 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.45.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:45:53 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 10/46] e2fsck: open io-channel when copying fs
Date:   Wed,  8 Apr 2020 19:44:38 +0900
Message-Id: <1586342714-12536-11-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
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
index c63b1852..58fb49c5 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -244,6 +244,7 @@ struct e2fsck_struct {
 	ino_t			 free_inodes;
 	int			 mount_flags;
 	int			 openfs_flags;
+	io_manager		 io_manager;
 	blkid_cache		 blkid; /* blkid cache */
 #ifdef HAVE_SETJMP_H
 	jmp_buf			abort_loc;
diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index de56562c..900d6cad 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2133,7 +2133,37 @@ do {									\
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
 
@@ -2171,6 +2201,33 @@ static errcode_t e2fsck_pass1_copy_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2181,9 +2238,15 @@ out_dblist:
 
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
@@ -2204,6 +2267,7 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 		if (retval)
 			goto out_dblist;
 	}
+	io_channel_close(src->io);
 	return 0;
 out_dblist:
 	ext2fs_free_dblist(dest->dblist);
@@ -2270,7 +2334,8 @@ static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thre
 		goto out_context;
 	}
 
-	retval = e2fsck_pass1_copy_fs(thread_fs, global_fs);
+	io_channel_flush_cleanup(global_fs->io);
+	retval = e2fsck_pass1_copy_fs(thread_fs, global_ctx, global_fs);
 	if (retval) {
 		com_err(global_ctx->program_name, retval, "while copying fs");
 		goto out_fs;
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 8226aff7..fff7376c 100644
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
2.25.2

