Return-Path: <linux-ext4+bounces-7487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2C7A9BA1B
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 256613B566A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAED11A317D;
	Thu, 24 Apr 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0llDjEX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCBC13213E
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531160; cv=none; b=tAsdO1O3zOT3EQVGC+EjaLib3gxIFgwWCPo7vOuKFYuykrEqzpyzc5sztAKy37cjd3IFqZZEByBl+eLsWBeFXrKVIegefp9TnbVqVoHnF2OoBMwviWQDQgTGFLI6waUbiq4XBCMaXmzfRPRjuEe0NFcsGUKchY1Um6FhFci732g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531160; c=relaxed/simple;
	bh=VJ1FoAQDtmwf9+bLW28pJiAalcZcTQe1SD1baohBxKE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvcBUTiXBENfdUKc/bq17x0hUX/Vsqa1vVlNFfFRFxY1sAljUYDDcH5W75quf4hzLy7seYfC2jFTFSpZWdciXRhErYGg/auUPGFoBLnFMKajir4Lr0qNHRzCmx4TH4Lq2s9WCB+u6cWaIuhBFt8jF1FbH6Hgn0GcenKgXg7Bo2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0llDjEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0E9C4CEE4;
	Thu, 24 Apr 2025 21:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531159;
	bh=VJ1FoAQDtmwf9+bLW28pJiAalcZcTQe1SD1baohBxKE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=q0llDjEXYisJI/7LPcna6S/qPotQVVWZitnyaBS+XAdkdGRLkk8trGEe+lJQmR+EM
	 UALMl8fhIr4e3+oPvbbx2uZP5KCeV6OUhVjF19UnNVTd6hC3QWjZAtx4IKDvImDN7A
	 FufAsSynSfg7UIo72Ui7u6EoZYHUpLf4aj2EflqpfdVSCqfDUfayZWsdcxZEr6vEZY
	 0E8SB7jjJ1KoueLPUWpTlOeKgfg9iA2unRNQSmhRIypmqks9XAHWonJGM53/AhGRPT
	 vJxjLdrMQCowA9tZnCsgvSASfd3pawUwBCj/CJpmOrIsKM2hi0pQvpEUnzAMeAEgyG
	 FJUfhz/qY7JaA==
Date: Thu, 24 Apr 2025 14:45:59 -0700
Subject: [PATCH 2/5] libext2fs: make unix_io cache size configurable
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065546.1161238.2653341081512215032.stgit@frogsfrogsfrogs>
In-Reply-To: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
References: <174553065491.1161238.812958177319322832.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make it so that we can reconfigure the unix IO manager cache size.
fuse2fs might want more than 32 blocks.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |  127 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 7 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 207a8e63b77fd4..f8be1fe6f8d2c0 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -91,7 +91,7 @@ struct unix_cache {
 	unsigned		write_err:1;
 };
 
-#define CACHE_SIZE 8
+#define DEFAULT_CACHE_SIZE 8
 #define WRITE_DIRECT_SIZE 4	/* Must be smaller than CACHE_SIZE */
 #define READ_DIRECT_SIZE 4	/* Should be smaller than CACHE_SIZE */
 
@@ -102,7 +102,8 @@ struct unix_private_data {
 	int	align;
 	int	access_time;
 	ext2_loff_t offset;
-	struct unix_cache cache[CACHE_SIZE];
+	struct unix_cache *cache;
+	unsigned int cache_size;
 	void	*bounce;
 	struct struct_io_stats io_stats;
 #ifdef HAVE_PTHREAD
@@ -476,7 +477,7 @@ static errcode_t alloc_cache(io_channel channel,
 	int			i;
 
 	data->access_time = 0;
-	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		cache->block = 0;
 		cache->access_time = 0;
 		cache->dirty = 0;
@@ -502,7 +503,7 @@ static void free_cache(struct unix_private_data *data)
 	int			i;
 
 	data->access_time = 0;
-	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		cache->block = 0;
 		cache->access_time = 0;
 		cache->dirty = 0;
@@ -528,7 +529,7 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
 	int			i;
 
 	unused_cache = oldest_cache = 0;
-	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		if (!cache->in_use) {
 			if (!unused_cache)
 				unused_cache = cache;
@@ -592,7 +593,7 @@ static errcode_t flush_cached_blocks(io_channel channel,
 
 	if ((flags & FLUSH_NOLOCK) == 0)
 		mutex_lock(data, CACHE_MTX);
-	for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 		if (!cache->in_use || !cache->dirty)
 			continue;
 		retval = raw_write_blk(channel, data,
@@ -616,7 +617,7 @@ static errcode_t flush_cached_blocks(io_channel channel,
 		if ((flags & FLUSH_NOLOCK) == 0)
 			mutex_lock(data, CACHE_MTX);
 		errors_found = 0;
-		for (i=0, cache = data->cache; i < CACHE_SIZE; i++, cache++) {
+		for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
 			if (!cache->in_use || !cache->write_err)
 				continue;
 			errors_found = 1;
@@ -648,6 +649,89 @@ static errcode_t flush_cached_blocks(io_channel channel,
 	}
 	return retval2;
 }
+
+/* Shrink the cache buffers */
+static errcode_t shrink_cache(io_channel channel,
+			      struct unix_private_data *data,
+			      unsigned int new_size)
+{
+	struct unix_cache	*cache, *new_cache;
+	int			i;
+	errcode_t		retval;
+
+	mutex_lock(data, CACHE_MTX);
+
+	retval = flush_cached_blocks(channel, data,
+			FLUSH_INVALIDATE | FLUSH_NOLOCK);
+	if (retval)
+		goto unlock;
+
+	for (i = new_size, cache = data->cache + new_size;
+	     i < data->cache_size;
+	     i++, cache++) {
+		cache->block = 0;
+		cache->access_time = 0;
+		cache->dirty = 0;
+		cache->in_use = 0;
+		if (cache->buf)
+			ext2fs_free_mem(&cache->buf);
+	}
+
+	new_cache = realloc(data->cache, new_size * sizeof(struct unix_cache));
+	if (!new_cache) {
+		retval = EXT2_ET_NO_MEMORY;
+		goto unlock;
+	}
+
+	data->cache = new_cache;
+	data->cache_size = new_size;
+
+unlock:
+	mutex_unlock(data, CACHE_MTX);
+	return retval;
+}
+
+/* Grow the cache buffers */
+static errcode_t grow_cache(io_channel channel,
+			    struct unix_private_data *data,
+			    unsigned int new_size)
+{
+	struct unix_cache	*cache, *new_cache;
+	int			i;
+	errcode_t		retval;
+
+	mutex_lock(data, CACHE_MTX);
+
+	retval = flush_cached_blocks(channel, data,
+			FLUSH_INVALIDATE | FLUSH_NOLOCK);
+	if (retval)
+		goto unlock;
+
+	new_cache = realloc(data->cache, new_size * sizeof(struct unix_cache));
+	if (!new_cache) {
+		retval = EXT2_ET_NO_MEMORY;
+		goto unlock;
+	}
+
+	for (i = data->cache_size, cache = new_cache + data->cache_size;
+	     i < new_size;
+	     i++, cache++) {
+		cache->block = 0;
+		cache->access_time = 0;
+		cache->dirty = 0;
+		cache->in_use = 0;
+		retval = io_channel_alloc_buf(channel, 0, &cache->buf);
+		if (retval)
+			goto unlock;
+	}
+
+	data->cache = new_cache;
+	data->cache_size = new_size;
+
+unlock:
+	mutex_unlock(data, CACHE_MTX);
+	return retval;
+}
 #endif /* NO_IO_CACHE */
 
 #ifdef __linux__
@@ -743,6 +827,13 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	data->flags = flags;
 	data->dev = fd;
 
+	data->cache_size = DEFAULT_CACHE_SIZE;
+	data->cache = calloc(DEFAULT_CACHE_SIZE, sizeof(struct unix_cache));
+	if (!data->cache) {
+		retval = EXT2_ET_NO_MEMORY;
+		goto cleanup;
+	}
+
 #if defined(O_DIRECT)
 	if (flags & IO_FLAG_DIRECT_IO)
 		io->align = ext2fs_get_dio_alignment(data->dev);
@@ -869,6 +960,8 @@ static errcode_t unix_open_channel(const char *name, int fd,
 		if (data->dev >= 0)
 			close(data->dev);
 		free_cache(data);
+		if (data->cache)
+			free(data->cache);
 		ext2fs_free_mem(&data);
 	}
 	if (io) {
@@ -953,6 +1046,7 @@ static errcode_t unix_close(io_channel channel)
 	if (close(data->dev) < 0)
 		retval = errno;
 	free_cache(data);
+	free(data->cache);
 #ifdef HAVE_PTHREAD
 	if (data->flags & IO_FLAG_THREADS) {
 		pthread_mutex_destroy(&data->cache_mutex);
@@ -1308,6 +1402,25 @@ static errcode_t unix_set_option(io_channel channel, const char *option,
 		}
 		return EXT2_ET_INVALID_ARGUMENT;
 	}
+#ifndef NO_IO_CACHE
+	if (!strcmp(option, "cache_blocks")) {
+		unsigned long long	size;
+
+		if (!arg)
+			return EXT2_ET_INVALID_ARGUMENT;
+
+		errno = 0;
+		size = strtoll(arg, NULL, 0);
+		if (errno || size == 0 || size > INT32_MAX)
+			return EXT2_ET_INVALID_ARGUMENT;
+
+		if (data->cache_size == size)
+			return 0;
+		if (data->cache_size > size)
+			return shrink_cache(channel, data, size);
+		return grow_cache(channel, data, size);
+	}
+#endif
 	return EXT2_ET_INVALID_ARGUMENT;
 }
 


