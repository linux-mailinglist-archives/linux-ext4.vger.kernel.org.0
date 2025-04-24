Return-Path: <linux-ext4+bounces-7486-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D281A9BA19
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6A2C175487
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC131F03EC;
	Thu, 24 Apr 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNAlBwCy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329E13213E
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531144; cv=none; b=Zg3AJJ97767BdTmC4FHDCC4e9mJlEgmMtGCpjonhaY6/17/Ye6qgdFVdbmLfFijk67Z1x10aEXW6CUcPDDboBBZ9+7h3ov5P/RmYInACmMv1pTwTGXrT5aE7eBu3Yjhsdqt2xR6lDVWyfBE1UHf3U0P5Pg/JKmperUoInImg8OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531144; c=relaxed/simple;
	bh=VMYu/lQxJ3K8WQRmJME1lhKTHM+nE6qq+8Ps8ndUPd0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9m9nJAmQhdo9uupp8dNUUKU7CCodhOIs1znzqajZAL97F8ktBpD+qCiXgyR6IP3VPVDMSO5+8urVAGyFQCoPwZndyEaRZXNRw2ZlHN9CdTOU1Js0c57bNcclpwrrLQbRDjoyxPu+FLdbTSkjdglmJTwpcv/a+GiqeO1EKQpMmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNAlBwCy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5013BC4CEE3;
	Thu, 24 Apr 2025 21:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531144;
	bh=VMYu/lQxJ3K8WQRmJME1lhKTHM+nE6qq+8Ps8ndUPd0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hNAlBwCyFMyQXXeCNVgKOVc3w02KaK0ZOq0Tio+sMRD0J/9knItHnd0T85q6TSTNM
	 rZNIi6uxzE8eJNoWSONjkxXK+AcZ322/cvWH+1MvKS7HZWomynypB55BqgEOO354gk
	 FS1ltihwLYW7ZjHy7EzGCwKDdylaUgDGiJGJxkor6cg/vGWxqF6yeAqolteLu3RY8L
	 Ggu3upYWyLdvQoFJ+Kr3PM1gM9XPnF86dxKuvi1lwRAg1i5ALYHrkNA6RwN5KTY0fb
	 7ZnDm6UxrMXQ5FDE278yCFECRQvoyhiOcCkzt3vTf7c49MmSwwp9yu7W9FbmpJdO03
	 WASSMa3MTk/uw==
Date: Thu, 24 Apr 2025 14:45:43 -0700
Subject: [PATCH 1/5] fuse2fs: report cache hits and misses at unmount time
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065528.1161238.4178228996070898927.stgit@frogsfrogsfrogs>
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

Log the IO cache's hit and miss quantities at unmount time.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2_io.h |    2 ++
 lib/ext2fs/unix_io.c |    4 +++-
 misc/fuse2fs.c       |   13 +++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2_io.h b/lib/ext2fs/ext2_io.h
index 27eaaf1be35442..39a4e8fcf6b515 100644
--- a/lib/ext2fs/ext2_io.h
+++ b/lib/ext2fs/ext2_io.h
@@ -71,6 +71,8 @@ struct struct_io_stats {
 	int			reserved;
 	unsigned long long	bytes_read;
 	unsigned long long	bytes_written;
+	unsigned long long	cache_hits;
+	unsigned long long	cache_misses;
 };
 
 struct struct_io_manager {
diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 4b4f25a494f8c6..207a8e63b77fd4 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -536,6 +536,7 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
 		}
 		if (cache->block == block) {
 			cache->access_time = ++data->access_time;
+			data->io_stats.cache_hits++;
 			return cache;
 		}
 		if (!oldest_cache ||
@@ -544,6 +545,7 @@ static struct unix_cache *find_cached_block(struct unix_private_data *data,
 	}
 	if (eldest)
 		*eldest = (unused_cache) ? unused_cache : oldest_cache;
+	data->io_stats.cache_misses++;
 	return 0;
 }
 
@@ -737,7 +739,7 @@ static errcode_t unix_open_channel(const char *name, int fd,
 
 	memset(data, 0, sizeof(struct unix_private_data));
 	data->magic = EXT2_ET_MAGIC_UNIX_IO_CHANNEL;
-	data->io_stats.num_fields = 2;
+	data->io_stats.num_fields = 4;
 	data->flags = flags;
 	data->dev = fd;
 
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 8451cabfb19110..7f1e7556b9204e 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -604,6 +604,19 @@ static void op_destroy(void *p EXT2FS_ATTR((unused)))
 			translate_error(fs, 0, err);
 	}
 
+	if (ff->debug && fs->io->manager->get_stats) {
+		io_stats stats = NULL;
+
+		fs->io->manager->get_stats(fs->io, &stats);
+		dbg_printf(ff, "read: %lluk\n",  stats->bytes_read >> 10);
+		dbg_printf(ff, "write: %lluk\n", stats->bytes_written >> 10);
+		dbg_printf(ff, "hits: %llu\n",   stats->cache_hits);
+		dbg_printf(ff, "misses: %llu\n", stats->cache_misses);
+		dbg_printf(ff, "hit_ratio: %.1f%%\n",
+				(100.0 * stats->cache_hits) /
+				(stats->cache_hits + stats->cache_misses));
+	}
+
 	if (ff->kernel) {
 		char uuid[UUID_STR_SIZE];
 


