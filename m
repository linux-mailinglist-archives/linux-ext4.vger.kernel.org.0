Return-Path: <linux-ext4+bounces-11615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6BC3DAA4
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62D9334FCDF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5BB1F8723;
	Thu,  6 Nov 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+m9dJvn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7012C21CB
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469144; cv=none; b=k7Ay25LWAzpWxEuNH2THSI45WF/Hi3gLNCdkgEaJ1Xg8RgQOPMaQKKBwZReUhXRGJxj3yY0XrlNB2IPk5pjv4DJIi//glWN9Sn7dkL1nVVAjKSTAEhnqGGb9rKV6owAS8CrP1DytdY207zIYgBx6KU9urNzr+TzZqYbCuPimKpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469144; c=relaxed/simple;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QhV/JEH/ARHSMj4Pj8byX8+DVd8adXIPxRHC3tnl+qN0Ms+1ld5L1MA0/v2qU5NsdxTcXvXxQOL7C7PrlBhgM1JcINYm8f86C+h9K30I1Hp5/2qnym3mdN179LVuYOgIqULkpAJ3Y+mjTbsH4ZJJ5E6zAuqPUbfzoaYZCyYQgI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+m9dJvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9B7C16AAE;
	Thu,  6 Nov 2025 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469144;
	bh=zTTGSumEzu7+K3Aspedwr4YQ4+8FhoBobNCJVV73dYI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=q+m9dJvnbbvoIvPpPkuu16OQTaOuf8IOMTLtb+Kfy2OrpJXGIThRp+X9crLFPLb+/
	 unClu+E0Qp3SlsVsRbnug/fTGuar6fjOsOtN7NRwEsSY8/MkU5u64/ZsHG2UL3soYh
	 LHrm7WSwzSpXaWz7ktAH46Seu+T8gUby8Ab+kf9XLCPA7a97tqK76IAnJ1MW8kPU6M
	 6XHHUvpaS/3L3rDmp8r7fyPLnalPO/xMr3UB2Kap1Om2D1YOC++6xeCtqTreA7eRp6
	 ap0q1rO5IP6T/IEMkAc2rsXg61AzeWMx63vM3dLn+tjG28f5XRidFHWZ9pOkyb5Rec
	 Whxq+/R3VrDsQ==
Date: Thu, 06 Nov 2025 14:45:43 -0800
Subject: [PATCH 10/23] cache: embed struct cache in the owner
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795748.2864310.3588411214964514986.stgit@frogsfrogsfrogs>
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

It'll be easier to embed a struct cache into the object that owns the
cache rather than passing pointers around.  This is the prelude to the
next patch, which will enable cache functions to walk back to the owning
struct.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   10 ++++++++--
 lib/support/cache.c |   38 ++++++++++++++++++++------------------
 2 files changed, 28 insertions(+), 20 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 16b17a9b7a1a51..993f1385dedcee 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -122,8 +122,14 @@ struct cache {
 	unsigned int 		c_max;		/* max nodes ever used */
 };
 
-struct cache *cache_init(int, unsigned int, const struct cache_operations *);
-void cache_destroy(struct cache *);
+static inline bool cache_initialized(const struct cache *cache)
+{
+	return cache->hash != NULL;
+}
+
+int cache_init(int flags, unsigned int size,
+	       const struct cache_operations *ops, struct cache *cache);
+void cache_destroy(struct cache *cache);
 void cache_walk(struct cache *, cache_walk_t);
 void cache_purge(struct cache *);
 void cache_flush(struct cache *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index d8f8231ac36d28..8b4f9f03c3899b 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -12,6 +12,7 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <errno.h>
 
 #include "list.h"
 #include "cache.h"
@@ -33,23 +34,18 @@
 
 static unsigned int cache_generic_bulkrelse(struct cache *, struct list_head *);
 
-struct cache *
+int
 cache_init(
 	int			flags,
 	unsigned int		hashsize,
-	const struct cache_operations	*cache_operations)
+	const struct cache_operations	*cache_operations,
+	struct cache		*cache)
 {
-	struct cache *		cache;
 	unsigned int		i, maxcount;
 
 	maxcount = hashsize * HASH_CACHE_RATIO;
 
-	if (!(cache = malloc(sizeof(struct cache))))
-		return NULL;
-	if (!(cache->c_hash = calloc(hashsize, sizeof(struct cache_hash)))) {
-		free(cache);
-		return NULL;
-	}
+	memset(cache, 0, sizeof(*cache));
 
 	cache->c_flags = flags;
 	cache->c_count = 0;
@@ -57,8 +53,6 @@ cache_init(
 	cache->c_hits = 0;
 	cache->c_misses = 0;
 	cache->c_maxcount = maxcount;
-	cache->c_hashsize = hashsize;
-	cache->c_hashshift = fls(hashsize) - 1;
 	cache->hash = cache_operations->hash;
 	cache->alloc = cache_operations->alloc;
 	cache->flush = cache_operations->flush;
@@ -70,18 +64,26 @@ cache_init(
 	cache->put = cache_operations->put;
 	pthread_mutex_init(&cache->c_mutex, NULL);
 
+	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
+		list_head_init(&cache->c_mrus[i].cm_list);
+		cache->c_mrus[i].cm_count = 0;
+		pthread_mutex_init(&cache->c_mrus[i].cm_mutex, NULL);
+	}
+
+	cache->c_hash = calloc(hashsize, sizeof(struct cache_hash));
+	if (!cache->c_hash)
+		return ENOMEM;
+
+	cache->c_hashsize = hashsize;
+	cache->c_hashshift = fls(hashsize) - 1;
+
 	for (i = 0; i < hashsize; i++) {
 		list_head_init(&cache->c_hash[i].ch_list);
 		cache->c_hash[i].ch_count = 0;
 		pthread_mutex_init(&cache->c_hash[i].ch_mutex, NULL);
 	}
 
-	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
-		list_head_init(&cache->c_mrus[i].cm_list);
-		cache->c_mrus[i].cm_count = 0;
-		pthread_mutex_init(&cache->c_mrus[i].cm_mutex, NULL);
-	}
-	return cache;
+	return 0;
 }
 
 static void
@@ -153,7 +155,7 @@ cache_destroy(
 	}
 	pthread_mutex_destroy(&cache->c_mutex);
 	free(cache->c_hash);
-	free(cache);
+	memset(cache, 0, sizeof(*cache));
 }
 
 static unsigned int


