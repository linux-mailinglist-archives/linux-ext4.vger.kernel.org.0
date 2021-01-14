Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6202F569A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jan 2021 02:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbhANBtu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Jan 2021 20:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbhANA2m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Jan 2021 19:28:42 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C5C0617A3
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:01 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l22so2490353pgc.15
        for <linux-ext4@vger.kernel.org>; Wed, 13 Jan 2021 16:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=pZeIaokjC2nqbEfIPGoJMIdzRxxMzRkU6YJOMjp5EU8=;
        b=dcqmCotzavZSL/Q+uwpL2/ZkUi9fRZN6Ls2mk1NXF0KQOtYI/VDuw7TBJTYhaznrIT
         Y5roE0tkhkfpCkMXO4QXARsL+yZWreviRGezZj3EIWtKkRlt07uJmkYJk1rcKvrZO6KR
         HGm9WmtMdeJxpKPN3/tMktNMGCHOdti7tos73vuR1MpLuswhOOOEZNddWkB0qBwJrctb
         dmXgsKrzELPqlIabYikR74BDaYPSwEsZWXNQYfneylunpcq6cyXMX0ayuLwkEnZ8Ukkf
         uMbz8QirLPgi2qETtZHAZxuTpOvqMB0MjhXFDF0Q7BOZaYKsN+L/Y1d5W0hIs6T0XEGV
         VsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pZeIaokjC2nqbEfIPGoJMIdzRxxMzRkU6YJOMjp5EU8=;
        b=DqdBy5nUX3Hb/ru307sCCMkjuvBojq6YIXlsDZ4cLzeq1ahKXGuaA7PB/RAYhsaZ6M
         6Co+u2McK8wY/yQh8Kr28DOsVPYXXY1CTvyYsgIKPE49GxPbJd0GllydRrZrYGJ4jZgo
         bOk5EtZ29RORmhoLPaR6D6erUV1dnikDcc4ABeDHR9Sg6GADvABMQ/5qV0I2UZbYF2dR
         URQLe/oziXy+MpALvCdWPG6cIR6ULvV5m6WAmvyyRXcnlexjldB7KJIRINA260kvtkuC
         r60uxu00ZAduPOLNy0xB7X3dhCe6ZRnUkT8T6QCocWcXOC7cwkrRDbDsbZ3DSE6Hil3h
         OwGA==
X-Gm-Message-State: AOAM532p6xtCq0Hkh9C/pGciPjbjvEwGWyIyfdANRwgsRa1c2DN5hvkM
        uO4Nw5h2k4GdRD7nk+vOzuMJpEww31GwMiAFGijLFdch9GQD3AWMG/uipCOjxH1ltZMpJ0m+5Bq
        dPz/RBbX/x4V1r1TKYsphSs+9ypVg2X65ZkDVTI8dNG97WVb5JyiuiZ5lyOEVjKmyMo0GB7YLlh
        O/htJV1B0=
X-Google-Smtp-Source: ABdhPJwEmHnZ8NJUJ5bz41t2UNQPwVi4O+/Lb2fyJmAGCYLONB+kE7o9RoHsSPOLNpxtn50eH3zCsLPmDEk9e9bXQLU=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([2620:15c:2cd:202:f693:9fff:fef5:75ee])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:a9c5:b029:de:43a0:1498 with
 SMTP id b5-20020a170902a9c5b02900de43a01498mr2717132plr.46.1610584080808;
 Wed, 13 Jan 2021 16:28:00 -0800 (PST)
Date:   Wed, 13 Jan 2021 16:27:20 -0800
In-Reply-To: <20210114002723.643589-1-saranyamohan@google.com>
Message-Id: <20210114002723.643589-3-saranyamohan@google.com>
Mime-Version: 1.0
References: <20210114002723.643589-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v1 2/5] libext2fs: add threading support to the I/O
 manager abstraction
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

Add initial implementation support for the unix_io manager.
Applications which want to use threading should pass in
IO_FLAG_THREADS when opening the channel.  Channels which support
threading (which as of this commit is unix_io and test_io if the
backing io_manager supports threading) will set the
CHANNEL_FLAGS_THREADS bit in io->flags.  Library code or applications
can test if threading is enabled by checking this flag.

Applications using libext2fs can pass in EXT2_FLAG_THREADS to
ext2fs_open() or ext2fs_open2() to request threading support.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2_io.h |   2 +
 lib/ext2fs/ext2fs.h  |   1 +
 lib/ext2fs/openfs.c  |   2 +
 lib/ext2fs/test_io.c |   6 +-
 lib/ext2fs/undo_io.c |   2 +
 lib/ext2fs/unix_io.c | 137 ++++++++++++++++++++++++++++++++++++++-----
 6 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 5540900a..2e0da5a5 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -33,6 +33,7 @@ typedef struct struct_io_stats *io_stats;
 #define CHANNEL_FLAGS_WRITETHROUGH	0x01
 #define CHANNEL_FLAGS_DISCARD_ZEROES	0x02
 #define CHANNEL_FLAGS_BLOCK_DEVICE	0x04
+#define CHANNEL_FLAGS_THREADS		0x08
 
 #define io_channel_discard_zeroes_data(i) (i->flags & CHANNEL_FLAGS_DISCARD_ZEROES)
 
@@ -104,6 +105,7 @@ struct struct_io_manager {
 #define IO_FLAG_EXCLUSIVE	0x0002
 #define IO_FLAG_DIRECT_IO	0x0004
 #define IO_FLAG_FORCE_BOUNCE	0x0008
+#define IO_FLAG_THREADS		0x0010
 
 /*
  * Convenience functions....
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 69c8a3ff..5955c3ae 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -206,6 +206,7 @@ typedef struct ext2_file *ext2_file_t;
 #define EXT2_FLAG_IGNORE_SB_ERRORS	0x800000
 #define EXT2_FLAG_BBITMAP_TAIL_PROBLEM	0x1000000
 #define EXT2_FLAG_IBITMAP_TAIL_PROBLEM	0x2000000
+#define EXT2_FLAG_THREADS		0x4000000
 
 /*
  * Special flag in the ext2 inode i_flag field that means that this is
diff --git a/lib/ext2fs/openfs.c b/lib/ext2fs/openfs.c
index 3ed1e25c..5ec8ed5c 100644
--- a/lib/ext2fs/openfs.c
+++ b/lib/ext2fs/openfs.c
@@ -170,6 +170,8 @@ errcode_t ext2fs_open2(const char *name, const char *io_options,
 		io_flags |= IO_FLAG_EXCLUSIVE;
 	if (flags & EXT2_FLAG_DIRECT_IO)
 		io_flags |= IO_FLAG_DIRECT_IO;
+	if (flags & EXT2_FLAG_THREADS)
+		io_flags |= IO_FLAG_THREADS;
 	retval = manager->open(fs->device_name, io_flags, &fs->io);
 	if (retval)
 		goto cleanup;
diff --git a/lib/ext2fs/test_io.c b/lib/ext2fs/test_io.c
index ee828be7..480e68fc 100644
--- a/lib/ext2fs/test_io.c
+++ b/lib/ext2fs/test_io.c
@@ -197,6 +197,7 @@ static errcode_t test_open(const char *name, int flags, io_channel *channel)
 	io->read_error = 0;
 	io->write_error = 0;
 	io->refcount = 1;
+	io->flags = 0;
 
 	memset(data, 0, sizeof(struct test_private_data));
 	data->magic = EXT2_ET_MAGIC_TEST_IO_CHANNEL;
@@ -237,8 +238,11 @@ static errcode_t test_open(const char *name, int flags, io_channel *channel)
 	if ((value = safe_getenv("TEST_IO_WRITE_ABORT")) != NULL)
 		data->write_abort_count = strtoul(value, NULL, 0);
 
-	if (data->real)
+	if (data->real) {
 		io->align = data->real->align;
+		if (data->real->flags & CHANNEL_FLAGS_THREADS)
+			io->flags |= CHANNEL_FLAGS_THREADS;
+	}
 
 	*channel = io;
 	return 0;
diff --git a/lib/ext2fs/undo_io.c b/lib/ext2fs/undo_io.c
index 19862414..eb56f53d 100644
--- a/lib/ext2fs/undo_io.c
+++ b/lib/ext2fs/undo_io.c
@@ -698,6 +698,8 @@ static errcode_t undo_open(const char *name, int flags, io_channel *channel)
 	int		undo_fd = -1;
 	errcode_t	retval;
 
+	/* We don't support multi-threading, at least for now */
+	flags &= ~IO_FLAG_THREADS;
 	if (name == 0)
 		return EXT2_ET_BAD_DEVICE_NAME;
 	retval = ext2fs_get_mem(sizeof(struct struct_io_channel), &io);
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 628e60c3..9385487d 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -67,6 +67,9 @@
 #if HAVE_LINUX_FALLOC_H
 #include <linux/falloc.h>
 #endif
+#ifdef HAVE_PTHREAD
+#include <pthread.h>
+#endif
 
 #if defined(__linux__) && defined(_IO) && !defined(BLKROGET)
 #define BLKROGET   _IO(0x12, 94) /* Get read-only status (0 = read_write).  */
@@ -107,11 +110,58 @@ struct unix_private_data {
 	struct unix_cache cache[CACHE_SIZE];
 	void	*bounce;
 	struct struct_io_stats io_stats;
+#ifdef HAVE_PTHREAD
+	pthread_mutex_t cache_mutex;
+	pthread_mutex_t bounce_mutex;
+	pthread_mutex_t stats_mutex;
+#endif
 };
 
 #define IS_ALIGNED(n, align) ((((uintptr_t) n) & \
 			       ((uintptr_t) ((align)-1))) == 0)
 
+typedef enum lock_kind {
+	CACHE_MTX, BOUNCE_MTX, STATS_MTX
+} kind_t;
+
+#ifdef HAVE_PTHREAD
+static inline pthread_mutex_t *get_mutex(struct unix_private_data *data,
+					 kind_t kind)
+{
+	if (data->flags & IO_FLAG_THREADS) {
+		switch (kind) {
+		case CACHE_MTX:
+			return &data->cache_mutex;
+		case BOUNCE_MTX:
+			return &data->bounce_mutex;
+		case STATS_MTX:
+			return &data->stats_mutex;
+		}
+	}
+	return NULL;
+}
+#endif
+
+static inline void mutex_lock(struct unix_private_data *data, kind_t kind)
+{
+#ifdef HAVE_PTHREAD
+	pthread_mutex_t *mtx = get_mutex(data,kind);
+
+	if (mtx)
+		pthread_mutex_lock(mtx);
+#endif
+}
+
+static inline void mutex_unlock(struct unix_private_data *data, kind_t kind)
+{
+#ifdef HAVE_PTHREAD
+	pthread_mutex_t *mtx = get_mutex(data,kind);
+
+	if (mtx)
+		pthread_mutex_unlock(mtx);
+#endif
+}
+
 static errcode_t unix_get_stats(io_channel channel, io_stats *stats)
 {
 	errcode_t	retval = 0;
@@ -122,8 +172,11 @@ static errcode_t unix_get_stats(io_channel channel, io_stats *stats)
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
-	if (stats)
+	if (stats) {
+		mutex_lock(data, STATS_MTX);
 		*stats = &data->io_stats;
+		mutex_unlock(data, STATS_MTX);
+	}
 
 	return retval;
 }
@@ -167,7 +220,9 @@ static errcode_t raw_read_blk(io_channel channel,
 	ssize_t		really_read = 0;
 
 	size = (count < 0) ? -count : (ext2_loff_t) count * channel->block_size;
+	mutex_lock(data, STATS_MTX);
 	data->io_stats.bytes_read += size;
+	mutex_unlock(data, STATS_MTX);
 	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
 	if (data->flags & IO_FLAG_FORCE_BOUNCE) {
@@ -232,8 +287,10 @@ static errcode_t raw_read_blk(io_channel channel,
 	 */
 bounce_read:
 	while (size > 0) {
+		mutex_lock(data, BOUNCE_MTX);
 		actual = read(data->dev, data->bounce, channel->block_size);
 		if (actual != channel->block_size) {
+			mutex_unlock(data, BOUNCE_MTX);
 			actual = really_read;
 			buf -= really_read;
 			size += really_read;
@@ -246,6 +303,7 @@ bounce_read:
 		really_read += actual;
 		size -= actual;
 		buf += actual;
+		mutex_unlock(data, BOUNCE_MTX);
 	}
 	return 0;
 
@@ -277,7 +335,9 @@ static errcode_t raw_write_blk(io_channel channel,
 		else
 			size = (ext2_loff_t) count * channel->block_size;
 	}
+	mutex_lock(data, STATS_MTX);
 	data->io_stats.bytes_written += size;
+	mutex_unlock(data, STATS_MTX);
 
 	location = ((ext2_loff_t) block * channel->block_size) + data->offset;
 
@@ -341,11 +401,13 @@ static errcode_t raw_write_blk(io_channel channel,
 	 */
 bounce_write:
 	while (size > 0) {
+		mutex_lock(data, BOUNCE_MTX);
 		if (size < channel->block_size) {
 			actual = read(data->dev, data->bounce,
 				      channel->block_size);
 			if (actual != channel->block_size) {
 				if (actual < 0) {
+					mutex_unlock(data, BOUNCE_MTX);
 					retval = errno;
 					goto error_out;
 				}
@@ -362,6 +424,7 @@ bounce_write:
 			goto error_out;
 		}
 		actual = write(data->dev, data->bounce, channel->block_size);
+		mutex_unlock(data, BOUNCE_MTX);
 		if (actual < 0) {
 			retval = errno;
 			goto error_out;
@@ -481,24 +544,28 @@ static void reuse_cache(io_channel channel, struct unix_private_data *data,
 	cache->access_time = ++data->access_time;
 }
 
+#define FLUSH_INVALIDATE	0x01
+#define FLUSH_NOLOCK		0x02
+
 /*
  * Flush all of the blocks in the cache
  */
 static errcode_t flush_cached_blocks(io_channel channel,
 				     struct unix_private_data *data,
-				     int invalidate)
-
+				     int flags)
 {
 	struct unix_cache	*cache;
 	errcode_t		retval, retval2;
 	int			i;
 
 	retval2 = 0;
+	if ((flags & FLUSH_NOLOCK) == 0)
+		mutex_lock(data, CACHE_MTX);
 	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
 		if (!cache->in_use)
 			continue;
 
-		if (invalidate)
+		if (flags & FLUSH_INVALIDATE)
 			cache->in_use = 0;
 
 		if (!cache->dirty)
@@ -511,6 +578,8 @@ static errcode_t flush_cached_blocks(io_channel channel,
 		else
 			cache->dirty = 0;
 	}
+	if ((flags & FLUSH_NOLOCK) == 0)
+		mutex_unlock(data, CACHE_MTX);
 	return retval2;
 }
 #endif /* NO_IO_CACHE */
@@ -597,6 +666,7 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	io->read_error = 0;
 	io->write_error = 0;
 	io->refcount = 1;
+	io->flags = 0;
 
 	memset(data, 0, sizeof(struct unix_private_data));
 	data->magic = EXT2_ET_MAGIC_UNIX_IO_CHANNEL;
@@ -703,6 +773,25 @@ static errcode_t unix_open_channel(const char *name, int fd,
 			setrlimit(RLIMIT_FSIZE, &rlim);
 		}
 	}
+#endif
+#ifdef HAVE_PTHREAD
+	if (flags & IO_FLAG_THREADS) {
+		io->flags |= CHANNEL_FLAGS_THREADS;
+		retval = pthread_mutex_init(&data->cache_mutex, NULL);
+		if (retval)
+			goto cleanup;
+		retval = pthread_mutex_init(&data->bounce_mutex, NULL);
+		if (retval) {
+			pthread_mutex_destroy(&data->cache_mutex);
+			goto cleanup;
+		}
+		retval = pthread_mutex_init(&data->stats_mutex, NULL);
+		if (retval) {
+			pthread_mutex_destroy(&data->cache_mutex);
+			pthread_mutex_destroy(&data->bounce_mutex);
+			goto cleanup;
+		}
+	}
 #endif
 	*channel = io;
 	return 0;
@@ -796,6 +885,13 @@ static errcode_t unix_close(io_channel channel)
 	if (close(data->dev) < 0)
 		retval = errno;
 	free_cache(data);
+#ifdef HAVE_PTHREAD
+	if (data->flags & IO_FLAG_THREADS) {
+		pthread_mutex_destroy(&data->cache_mutex);
+		pthread_mutex_destroy(&data->bounce_mutex);
+		pthread_mutex_destroy(&data->stats_mutex);
+	}
+#endif
 
 	ext2fs_free_mem(&channel->private_data);
 	if (channel->name)
@@ -807,24 +903,27 @@ static errcode_t unix_close(io_channel channel)
 static errcode_t unix_set_blksize(io_channel channel, int blksize)
 {
 	struct unix_private_data *data;
-	errcode_t		retval;
+	errcode_t		retval = 0;
 
 	EXT2_CHECK_MAGIC(channel, EXT2_ET_MAGIC_IO_CHANNEL);
 	data = (struct unix_private_data *) channel->private_data;
 	EXT2_CHECK_MAGIC(data, EXT2_ET_MAGIC_UNIX_IO_CHANNEL);
 
 	if (channel->block_size != blksize) {
+		mutex_lock(data, CACHE_MTX);
+		mutex_lock(data, BOUNCE_MTX);
 #ifndef NO_IO_CACHE
-		if ((retval = flush_cached_blocks(channel, data, 0)))
+		if ((retval = flush_cached_blocks(channel, data, FLUSH_NOLOCK)))
 			return retval;
 #endif
 
 		channel->block_size = blksize;
 		free_cache(data);
-		if ((retval = alloc_cache(channel, data)))
-			return retval;
+		retval = alloc_cache(channel, data);
+		mutex_unlock(data, BOUNCE_MTX);
+		mutex_unlock(data, CACHE_MTX);
 	}
-	return 0;
+	return retval;
 }
 
 static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
@@ -832,7 +931,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 {
 	struct unix_private_data *data;
 	struct unix_cache *cache, *reuse[READ_DIRECT_SIZE];
-	errcode_t	retval;
+	errcode_t	retval = 0;
 	char		*cp;
 	int		i, j;
 
@@ -854,6 +953,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 	}
 
 	cp = buf;
+	mutex_lock(data, CACHE_MTX);
 	while (count > 0) {
 		/* If it's in the cache, use it! */
 		if ((cache = find_cached_block(data, block, &reuse[0]))) {
@@ -876,10 +976,11 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 			if ((retval = raw_read_blk(channel, data, block, 1,
 						   cache->buf))) {
 				cache->in_use = 0;
-				return retval;
+				break;
 			}
 			memcpy(cp, cache->buf, channel->block_size);
-			return 0;
+			retval = 0;
+			break;
 		}
 
 		/*
@@ -893,7 +994,7 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 		printf("Reading %d blocks starting at %lu\n", i, block);
 #endif
 		if ((retval = raw_read_blk(channel, data, block, i, cp)))
-			return retval;
+			break;
 
 		/* Save the results in the cache */
 		for (j=0; j < i; j++) {
@@ -904,7 +1005,8 @@ static errcode_t unix_read_blk64(io_channel channel, unsigned long long block,
 			cp += channel->block_size;
 		}
 	}
-	return 0;
+	mutex_unlock(data, CACHE_MTX);
+	return retval;
 #endif /* NO_IO_CACHE */
 }
 
@@ -935,7 +1037,8 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 	 * flush out the cache completely and then do a direct write.
 	 */
 	if (count < 0 || count > WRITE_DIRECT_SIZE) {
-		if ((retval = flush_cached_blocks(channel, data, 1)))
+		if ((retval = flush_cached_blocks(channel, data,
+						  FLUSH_INVALIDATE)))
 			return retval;
 		return raw_write_blk(channel, data, block, count, buf);
 	}
@@ -950,6 +1053,7 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 		retval = raw_write_blk(channel, data, block, count, buf);
 
 	cp = buf;
+	mutex_lock(data, CACHE_MTX);
 	while (count > 0) {
 		cache = find_cached_block(data, block, &reuse);
 		if (!cache) {
@@ -963,6 +1067,7 @@ static errcode_t unix_write_blk64(io_channel channel, unsigned long long block,
 		block++;
 		cp += channel->block_size;
 	}
+	mutex_unlock(data, CACHE_MTX);
 	return retval;
 #endif /* NO_IO_CACHE */
 }
@@ -1013,7 +1118,7 @@ static errcode_t unix_write_byte(io_channel channel, unsigned long offset,
 	/*
 	 * Flush out the cache completely
 	 */
-	if ((retval = flush_cached_blocks(channel, data, 1)))
+	if ((retval = flush_cached_blocks(channel, data, FLUSH_INVALIDATE)))
 		return retval;
 #endif
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

