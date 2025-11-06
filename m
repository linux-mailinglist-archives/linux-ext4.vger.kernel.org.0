Return-Path: <linux-ext4+bounces-11624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF28EC3DACE
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97C543B1363
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E15A2C15A0;
	Thu,  6 Nov 2025 22:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sv5adklq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455A26CE2D
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469288; cv=none; b=QOtkcmzfdEM9F8lj5nO7amnfX+j9RpC4GTwNoznwcyWLSv4IHqTL+4Sbx1cVXX+YSKwrt656NuDoDMNU29lcn9yl+DxysONhUkOi90TvHXUabnyh6McXgPTYWxa4bH3VTTxoVpJ4uwD9SFTHjNT2YeDDkO8ML+2j5pl69ZMn+zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469288; c=relaxed/simple;
	bh=KvqWPjlj11bFkTpAokJOkR+U2+kh8A6q1UKTR/HxZO4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j3bsDmxqj+p0i0P+7HF7z8UshzPMfS5zvU6A6BBrzRtTbLWnp+G+pWkurAlHprTe/Z4xowSp/PRz/IsWnbd0pYTKmJ20x6IWobcS/4nfvUkBWnYrQZrwtw8/TsH4VO/XyzS3PA7TPpmbc6rT3zHq0vvrUrzS6GvjLHS2OZ7sZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sv5adklq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C2BC4CEF7;
	Thu,  6 Nov 2025 22:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469288;
	bh=KvqWPjlj11bFkTpAokJOkR+U2+kh8A6q1UKTR/HxZO4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=sv5adklq0VkMiqg1eFRPIFRQ+ON8On638CYedwWu1CqdkqZfNxgN0UAFOc69iuwVT
	 6JdQFaL7zkqsHHjb5CW4S0tPhvz/YAx56T99K/TyfEAKbQ9hxZcyu20I0R2WnqZSwI
	 BgN4CBKR3RDCO3EORHTgViw6tzQO0MfEMkbduGOEVZmN3k88cZPBlyi8SdZrRwQoYp
	 40Dy4l1lbVo95NHymiPbWkg/iDG5HXNWjU6Okk6jC7vzqBZJ9ebMOe1WNDzRLnrM63
	 Zm9gh7G0x7eir2m2LDOgZpxZyTo3X/+BzIOViYPDw/zFN28AcfZFvgtheNaeq/u01l
	 h7oBSRojNuuvQ==
Date: Thu, 06 Nov 2025 14:48:07 -0800
Subject: [PATCH 19/23] cache: implement automatic shrinking
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795908.2864310.4023008384897404874.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Shrink the cache whenever maxcount has been expanded beyond its initial
value, we release a cached object to one of the mru lists and the number
of objects sitting on the mru is enough to drop the cache count down a
level.  This enables a cache to reduce its memory consumption after a
spike in which reclamation wasn't possible.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   20 +++++++--
 lib/support/cache.c |  119 ++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 129 insertions(+), 10 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 32b99b5fe733e3..c7c8298c115d50 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -16,7 +16,11 @@
  */
 #define CACHE_MISCOMPARE_PURGE	(1 << 0)
 
-#define CACHE_FLAGS_ALL		(CACHE_MISCOMPARE_PURGE)
+/* Automatically shrink the cache's max_count when possible. */
+#define CACHE_AUTO_SHRINK	(1 << 1)
+
+#define CACHE_FLAGS_ALL		(CACHE_MISCOMPARE_PURGE | \
+				 CACHE_AUTO_SHRINK)
 
 /*
  * cache object campare return values
@@ -69,12 +73,18 @@ typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
 typedef int (*cache_node_get_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_put_t)(struct cache *c, struct cache_node *cn);
 typedef unsigned int (*cache_node_resize_t)(const struct cache *c,
-					    unsigned int curr_size);
+					    unsigned int curr_size,
+					    int dir);
 
 static inline unsigned int cache_gradual_resize(const struct cache *cache,
-						unsigned int curr_size)
+						unsigned int curr_size,
+						int dir)
 {
-	return curr_size * 5 / 4;
+	if (dir < 0)
+		return curr_size * 9 / 10;
+	else if (dir > 0)
+		return curr_size * 5 / 4;
+	return curr_size;
 }
 
 struct cache_operations {
@@ -113,6 +123,7 @@ struct cache_node {
 
 struct cache {
 	int			c_flags;	/* behavioural flags */
+	unsigned int		c_orig_max;	/* original max cache nodes */
 	unsigned int		c_maxcount;	/* max cache nodes */
 	unsigned int		c_count;	/* count of nodes */
 	pthread_mutex_t		c_mutex;	/* node count mutex */
@@ -145,6 +156,7 @@ void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
+void cache_shrink(struct cache *cache);
 
 void cache_set_maxcount(struct cache *cache, unsigned int maxcount);
 int cache_set_flag(struct cache *cache, int flags);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 99044248b85d38..3a9e276f11af72 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -53,6 +53,7 @@ cache_init(
 	cache->c_hits = 0;
 	cache->c_misses = 0;
 	cache->c_maxcount = maxcount;
+	cache->c_orig_max = maxcount;
 	cache->hash = cache_operations->hash;
 	cache->alloc = cache_operations->alloc;
 	cache->flush = cache_operations->flush;
@@ -93,6 +94,7 @@ cache_set_maxcount(
 	unsigned int		maxcount)
 {
 	pthread_mutex_lock(&cache->c_mutex);
+	cache->c_orig_max = maxcount;
 	cache->c_maxcount = maxcount;
 	pthread_mutex_unlock(&cache->c_mutex);
 }
@@ -123,7 +125,7 @@ cache_expand(
 
 	pthread_mutex_lock(&cache->c_mutex);
 	if (cache->resize)
-		new_size = cache->resize(cache, cache->c_maxcount);
+		new_size = cache->resize(cache, cache->c_maxcount, 1);
 	if (new_size <= cache->c_maxcount)
 		new_size = cache->c_maxcount * 2;
 #ifdef CACHE_DEBUG
@@ -254,7 +256,8 @@ static unsigned int
 cache_shake(
 	struct cache *		cache,
 	unsigned int		priority,
-	bool			purge)
+	bool			purge,
+	unsigned int		nr_to_shake)
 {
 	struct cache_mru	*mru;
 	struct cache_hash	*hash;
@@ -302,7 +305,7 @@ cache_shake(
 		pthread_mutex_unlock(&node->cn_mutex);
 
 		count++;
-		if (!purge && count == CACHE_SHAKE_COUNT)
+		if (!purge && count == nr_to_shake)
 			break;
 	}
 	pthread_mutex_unlock(&mru->cm_mutex);
@@ -315,7 +318,7 @@ cache_shake(
 		pthread_mutex_unlock(&cache->c_mutex);
 	}
 
-	return (count == CACHE_SHAKE_COUNT) ? priority : ++priority;
+	return (count == nr_to_shake) ? priority : ++priority;
 }
 
 /*
@@ -505,7 +508,7 @@ cache_node_get(
 		node = cache_node_allocate(cache, key);
 		if (node)
 			break;
-		priority = cache_shake(cache, priority, false);
+		priority = cache_shake(cache, priority, false, CACHE_SHAKE_COUNT);
 		/*
 		 * We start at 0; if we free CACHE_SHAKE_COUNT we get
 		 * back the same priority, if not we get back priority+1.
@@ -535,12 +538,112 @@ cache_node_get(
 	return 1;
 }
 
+static unsigned int cache_mru_count(const struct cache *cache)
+{
+	const struct cache_mru	*mru = cache->c_mrus;
+	unsigned int		mru_count = 0;
+	unsigned int		i;
+
+	for (i = 0; i < CACHE_NR_PRIORITIES; i++, mru++)
+		mru_count += mru->cm_count;
+
+	return mru_count;
+}
+
+
+void cache_shrink(struct cache *cache)
+{
+	unsigned int		mru_count = 0;
+	unsigned int		threshold = 0;
+	unsigned int		priority = 0;
+	unsigned int		new_size;
+
+	pthread_mutex_lock(&cache->c_mutex);
+	/* Don't shrink below the original cache size */
+	if (cache->c_maxcount <= cache->c_orig_max)
+		goto out_unlock;
+
+	mru_count = cache_mru_count(cache);
+
+	/*
+	 * If there's not even a batch of nodes on the MRU to try to free,
+	 * don't bother with the rest.
+	 */
+	if (mru_count < CACHE_SHAKE_COUNT)
+		goto out_unlock;
+
+	/*
+	 * Figure out the next step down in size, but don't go below the
+	 * original size.
+	 */
+	if (cache->resize)
+		new_size = cache->resize(cache, cache->c_maxcount, -1);
+	else
+		new_size = cache->c_maxcount / 2;
+	if (new_size >= cache->c_maxcount)
+		goto out_unlock;
+	if (new_size < cache->c_orig_max)
+		new_size = cache->c_orig_max;
+
+	/*
+	 * If we can't purge enough nodes to get the node count below new_size,
+	 * don't resize the cache.
+	 */
+	if (cache->c_count - mru_count >= new_size)
+		goto out_unlock;
+
+#ifdef CACHE_DEBUG
+	fprintf(stderr, "decreasing cache max size from %u to %u (currently %u)\n",
+		cache->c_maxcount, new_size, cache->c_count);
+#endif
+	cache->c_maxcount = new_size;
+
+	/* Try to reduce the number of cached objects. */
+	do {
+		unsigned int new_priority;
+
+		/*
+		 * The threshold is the amount we need to purge to get c_count
+		 * below the new maxcount.  Try to free some objects off the
+		 * MRU.  Drop c_mutex because cache_shake will take it.
+		 */
+		threshold = cache->c_count - new_size;
+		pthread_mutex_unlock(&cache->c_mutex);
+
+		new_priority = cache_shake(cache, priority, false, threshold);
+
+		/* Either we made no progress or we ran out of MRU levels */
+		if (new_priority == priority ||
+		    new_priority > CACHE_MAX_PRIORITY)
+			return;
+		priority = new_priority;
+
+		pthread_mutex_lock(&cache->c_mutex);
+		/*
+		 * Someone could have walked in and changed the cache maxsize
+		 * again while we had the lock dropped.  If that happened, stop
+		 * clearing.
+		 */
+		if (cache->c_maxcount != new_size)
+			goto out_unlock;
+
+		mru_count = cache_mru_count(cache);
+		if (cache->c_count - mru_count >= new_size)
+			goto out_unlock;
+	} while (1);
+
+out_unlock:
+	pthread_mutex_unlock(&cache->c_mutex);
+	return;
+}
+
 void
 cache_node_put(
 	struct cache *		cache,
 	struct cache_node *	node)
 {
 	struct cache_mru *	mru;
+	bool was_put = false;
 
 	pthread_mutex_lock(&node->cn_mutex);
 #ifdef CACHE_DEBUG
@@ -556,6 +659,7 @@ cache_node_put(
 	}
 #endif
 	node->cn_count--;
+	was_put = (node->cn_count == 0);
 
 	if (node->cn_count == 0 && cache->put)
 		cache->put(cache, node);
@@ -569,6 +673,9 @@ cache_node_put(
 	}
 
 	pthread_mutex_unlock(&node->cn_mutex);
+
+	if (was_put && (cache->c_flags & CACHE_AUTO_SHRINK))
+		cache_shrink(cache);
 }
 
 void
@@ -660,7 +767,7 @@ cache_purge(
 	int			i;
 
 	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++)
-		cache_shake(cache, i, true);
+		cache_shake(cache, i, true, CACHE_SHAKE_COUNT);
 
 #ifdef CACHE_DEBUG
 	if (cache->c_count != 0) {


