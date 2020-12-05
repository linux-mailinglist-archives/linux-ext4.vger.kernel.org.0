Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C429F2CF95E
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Dec 2020 06:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgLEE7y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 23:59:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50363 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726709AbgLEE7x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 23:59:53 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B54wwf4001988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 4 Dec 2020 23:58:59 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 89A8042027C; Fri,  4 Dec 2020 23:58:58 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>, adilger.kernel@dilger.ca,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH RFC 2/5] libext2fs: add threading support to the I/O manager abstraction
Date:   Fri,  4 Dec 2020 23:58:53 -0500
Message-Id: <20201205045856.895342-3-tytso@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201205045856.895342-1-tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index 5540900a5..2e0da5a53 100644
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
index 69c8a3ff0..5955c3ae9 100644
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
index 3ed1e25cd..5ec8ed5c1 100644
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
index ee828be7a..480e68fcc 100644
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
index 198624145..eb56f53d5 100644
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
index 628e60c39..9385487d9 100644
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
2.28.0

