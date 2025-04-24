Return-Path: <linux-ext4+bounces-7488-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3049A9BA1C
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 421E7925A52
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726D61BD9E3;
	Thu, 24 Apr 2025 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caXZ+NhE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C5A13213E
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531179; cv=none; b=CCp3znbp+CakkcWieGJxYDYS3eLqNEF+Y5NgCWCVBtXpVDX0X6jG8M/+1DT0UN8acanFSEgMi28yZpBVCX2c6prz0XAO34tLm1ux6iTasRgOMNU4xGi4nSin8v2jTCqUZykgYdOS8Wq0YhrwGe5nU5LZohbSQIlkG9LJJiva44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531179; c=relaxed/simple;
	bh=vZaO3J2KFiQBNPGQtmiiGbjBDPOFXmAarW4ZEthvwMM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAQLt7qUDiUxCTOYfvpGy+z4vIhjJlsV5JSdh/ehbhXfW9QaBln0tRYx6Z6NWXgUBvU1PkhqWDXA1485oaPs5sDQfRMJlWunQuWoJNprdsboQCvISAeSGxi7peE0ty/jHRY5+3GZjjvFxLEdW0RiHnFpjfuH+dAXWbJZmKv/HXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caXZ+NhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE1FC4CEE3;
	Thu, 24 Apr 2025 21:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531178;
	bh=vZaO3J2KFiQBNPGQtmiiGbjBDPOFXmAarW4ZEthvwMM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=caXZ+NhERxxRrwgrPN5nF/NO6MDgQVoyPUaK6tpJI+V3YsezHCldI0MA5okKtBHTF
	 dGgFgu0CEJkxr1D1rwsupnDPfx1wDu2Ng8KryBcb7dNq99oNLV+8mb3PzJjQ/co5br
	 GjqtBtR2GZEgS5Meum66AWM6Xkg+Nivq1gCzcYGp5GxBE4Iv2QzOZQzImtHbvHMbzR
	 +F0eXbsCTCtxt1YuRZmO2HLHMf4n6ELwYON+uY3EW4nwIbu1iYkY7yXYQ23G9Qga8O
	 Qq6rN9ERuzXq0wt0ZTlvc/jjoeShJgNAO2x519U8lOzfPEWeLQhUA0Zkf4Z4Z9PcVL
	 zlmCe6iZ5cU8g==
Date: Thu, 24 Apr 2025 14:46:15 -0700
Subject: [PATCH 3/5] libext2fs: use hashing for cache lookups in unix IO
 manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065563.1161238.5896022194303080059.stgit@frogsfrogsfrogs>
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

Use a hash to avoid the linear scan.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index f8be1fe6f8d2c0..7078f3e2e30175 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -75,6 +75,40 @@
 #include "ext2fs.h"
 #include "ext2fsP.h"
 
+static inline int fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x = (x & 0xffffu) << 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x = (x & 0xffffffu) << 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x = (x & 0xfffffffu) << 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x = (x & 0x3fffffffu) << 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		r -= 1;
+	}
+	return r;
+}
+
+/* Get high bit set out of 32-bit argument, -1 if none set */
+static inline int highbit32(uint32_t v)
+{
+	return fls(v) - 1;
+}
+
 /*
  * For checking structure magic numbers...
  */
@@ -104,6 +138,7 @@ struct unix_private_data {
 	ext2_loff_t offset;
 	struct unix_cache *cache;
 	unsigned int cache_size;
+	unsigned int cache_hash_shift;
 	void	*bounce;
 	struct struct_io_stats io_stats;
 #ifdef HAVE_PTHREAD
@@ -516,6 +551,27 @@ static void free_cache(struct unix_private_data *data)
 }
 
 #ifndef NO_IO_CACHE
+
+/*  2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1 */
+#define GOLDEN_RATIO_PRIME	0x9e37fffffffc0001UL
+#define CACHE_LINE_SIZE		64
+
+/* buffer cache hashing function, crudely stolen from xfsprogs */
+unsigned int
+cache_hash(struct unix_private_data *data, blk64_t blkno)
+{
+	uint64_t	hashval = blkno;
+	uint64_t	tmp;
+
+	/* the default cache size is small, just do a linear scan */
+	if (data->cache_size <= DEFAULT_CACHE_SIZE)
+		return 0;
+
+	tmp = hashval ^ (GOLDEN_RATIO_PRIME + hashval) / CACHE_LINE_SIZE;
+	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> data->cache_hash_shift);
+	return tmp % data->cache_size;
+}
+
 /*
  * Try to find a block in the cache.  If the block is not found, and
  * eldest is a non-zero pointer, then fill in eldest with the cache
@@ -526,10 +582,30 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
 					    struct unix_cache **eldest)
 {
 	struct unix_cache	*cache, *unused_cache, *oldest_cache;
+	unsigned int		hash = cache_hash(data, block);
 	int			i;
 
 	unused_cache = oldest_cache = 0;
-	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
+	/* walk [hash..] cache elements */
+	for (i = hash, cache = data->cache + hash;
+	     i < data->cache_size;
+	     i++, cache++) {
+		if (!cache->in_use) {
+			if (!unused_cache)
+				unused_cache = cache;
+			continue;
+		}
+		if (cache->block == block) {
+			cache->access_time = ++data->access_time;
+			data->io_stats.cache_hits++;
+			return cache;
+		}
+		if (!oldest_cache ||
+		    (cache->access_time < oldest_cache->access_time))
+			oldest_cache = cache;
+	}
+	/* walk [..hash] since we didnt find a good slot yet */
+	for (i = 0, cache = data->cache; i < hash; i++, cache++) {
 		if (!cache->in_use) {
 			if (!unused_cache)
 				unused_cache = cache;
@@ -685,6 +761,7 @@ static errcode_t shrink_cache(io_channel channel,
 
 	data->cache = new_cache;
 	data->cache_size = new_size;
+	data->cache_hash_shift = highbit32(data->cache_size);
 
 unlock:
 	mutex_unlock(data, CACHE_MTX);
@@ -727,6 +804,7 @@ static errcode_t grow_cache(io_channel channel,
 
 	data->cache = new_cache;
 	data->cache_size = new_size;
+	data->cache_hash_shift = highbit32(data->cache_size);
 
 unlock:
 	mutex_unlock(data, CACHE_MTX);
@@ -828,6 +906,7 @@ static errcode_t unix_open_channel(const char *name, int fd,
 	data->dev = fd;
 
 	data->cache_size = DEFAULT_CACHE_SIZE;
+	data->cache_hash_shift = highbit32(data->cache_size);
 	data->cache = calloc(DEFAULT_CACHE_SIZE, sizeof(struct unix_cache));
 	if (!data->cache) {
 		retval = EXT2_ET_NO_MEMORY;


