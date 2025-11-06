Return-Path: <linux-ext4+bounces-11619-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E8CC3DAB3
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DE754E41AA
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76941F8723;
	Thu,  6 Nov 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ag94+463"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FF25EFBF
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469208; cv=none; b=KBhMov33kyDkt7/LQE6HwXKTyzze0MMmUF+5UQ7VV7vh7/PSfQgu7aHNnvVa/cOwYIvpC9qftzGH77Uca1RynzOMdjzIOnORvhqKup7LQx6pw13ZOxOIp7t2EjJTHcbltYaczwf5FKlFWaBQ4niH6s4iTqEhJeA150LcYe9ElaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469208; c=relaxed/simple;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1OArpITNyOs5tIj/iovsfOe2x46iN4Ej1iAA6bT/+dfpRTMjeMdPbeidA+wdUMGTDRSdpaZ3plyiSIoKwNysUeD5BPkhDTzuLOWYUKJYS7SNdC3eG53DyLN/Ml7AIpvI06O7xqA7AKDaEPjmJLh7kpjbqiBkilXMwnm2aFN4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ag94+463; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41246C4CEFB;
	Thu,  6 Nov 2025 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469208;
	bh=aw5UAvLigAFqFRWoV49nbLcHSrNIh7VKEPXDktH0A84=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ag94+463GuS36P7xcW2kgORnCCWP/+w/ItSJgAwRUDa1yFKNqhLGhCl2lOFcXqKtf
	 WpyucPaW+2i5yFoH5nNqUmL3JaIroMDDaSyreNO6oF8Bjk/9teC/ez/ogxM90snm/e
	 fEgM1LLn3gLXLwD1AxbQYldxLtTTMi1cpfA8d6kd68p3GYwOpPGPTGcDgypxaoLAA6
	 Cxucf+Wz48YBa6lGa54rDJ6foNXhqCtBsW9X7j3dFOu9eVwSRLett2ouHvbPnUFVFb
	 b7mvzq23UmA38MK8R6ORQbjg6nE/EQMucSxv16sLb4jjXTs25hVz5bmY3Y7xk3nqa8
	 MWcpqVSToBS/Q==
Date: Thu, 06 Nov 2025 14:46:47 -0800
Subject: [PATCH 14/23] cache: return results of a cache flush
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795821.2864310.15346407169072543317.stgit@frogsfrogsfrogs>
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

Modify cache_flush to return whether or not there were errors whilst
flushing the cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    4 ++--
 lib/support/cache.c |   11 +++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index e8f1c82ef7869c..8d39ca5c02a285 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -58,7 +58,7 @@ typedef void *cache_key_t;
 
 typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn, void *d);
 typedef struct cache_node * (*cache_node_alloc_t)(struct cache *c, cache_key_t k);
-typedef int (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
+typedef bool (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_relse_t)(struct cache *c, struct cache_node *cn);
 typedef unsigned int (*cache_node_hash_t)(cache_key_t, unsigned int,
 					  unsigned int);
@@ -132,7 +132,7 @@ int cache_init(int flags, unsigned int size,
 void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
-void cache_flush(struct cache *);
+bool cache_flush(struct cache *cache);
 
 int cache_node_get(struct cache *, cache_key_t, struct cache_node **);
 void cache_node_put(struct cache *, struct cache_node *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 49568ffa6de2e4..fa07b4ad8222d2 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -631,18 +631,19 @@ cache_purge(
 }
 
 /*
- * Flush all nodes in the cache to disk.
+ * Flush all nodes in the cache to disk.  Returns true if the flush succeeded.
  */
-void
+bool
 cache_flush(
 	struct cache		*cache)
 {
 	struct cache_hash	*hash;
 	struct cache_node	*node;
 	int			i;
+	bool			still_dirty = false;
 
 	if (!cache->flush)
-		return;
+		return true;
 
 	for (i = 0; i < cache->c_hashsize; i++) {
 		hash = &cache->c_hash[i];
@@ -650,11 +651,13 @@ cache_flush(
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(node, &hash->ch_list, cn_hash) {
 			pthread_mutex_lock(&node->cn_mutex);
-			cache->flush(cache, node);
+			still_dirty |= cache->flush(cache, node);
 			pthread_mutex_unlock(&node->cn_mutex);
 		}
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
+
+	return !still_dirty;
 }
 
 #define	HASH_REPORT	(3 * HASH_CACHE_RATIO)


