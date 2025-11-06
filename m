Return-Path: <linux-ext4+bounces-11617-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9020AC3DAAE
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0323A4B72
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27762C2366;
	Thu,  6 Nov 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m63OqOxG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8679421CFF6
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469176; cv=none; b=UjwMloOMDmOUbgXSh8mMqwV2NwyNLX1XFZSb18TuHAuXejKKj146QeCO6c4qjHTXDoBr8j5UNa+1RvkIFM40sWBoje1Ck5iXc0GUv8/vohYdU3pSHCFlOlvlQrZf8hZrfmnjobMFrpq2NSl6GPC0eLanrocNwXRLNsy0elTst/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469176; c=relaxed/simple;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nH+tlEfR1CcxizFS1OxtFsjXlBNxTgm5j2T6JeXq/EYU5Pe7kwUravIOY+Yf5UqjcCHcOo+rggPBDiX5tHMCILjfc2HrYoPsyBeJyMD7/vJ3xnWNBdHeM9WzudFNUoUmcSEfCribZ2EQCapAF+iGDhaMCxiLCZs0H9H3RkKRLSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m63OqOxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D219C4CEF7;
	Thu,  6 Nov 2025 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469176;
	bh=kH3tS7Hq5CGgPHb5lxqLbD4Ht7mOLKTOsTO5tt7a/CA=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=m63OqOxGyBrVEwc4s4I9qS5XVNvPvtfmGqdD6+fS8LB+Okl8KiCyfAr/HP6+FQkZo
	 plgIiLW20LGZVOnl23znl2a1aClA/YZg+VuwwqWGX1XNplqxITLP4Cffe/yQOgi2+R
	 pzS9EULXa6md4j8sm1sOWen0etEEkiH0XVD805AmnWXkMcZLB97WJN0kCnLJ2vtZ96
	 uMKOneRajgGWzhRStgl8RA5aVoL01+ACteVyojBhE+IXHW+asAbIVXbChNz2TjGsI3
	 8AZMu0g3p13FrJmCSuK8wC60mKLrWVV5pjHpgYzic7pK94qAwVYfds4zXvcuAcfPNj
	 bSbVxG09Y1HsA==
Date: Thu, 06 Nov 2025 14:46:15 -0800
Subject: [PATCH 12/23] cache: pass a private data pointer through cache_walk
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795785.2864310.10287646279477652018.stgit@frogsfrogsfrogs>
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

Allow cache_walk callers to pass a pointer to the callback function.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    4 ++--
 lib/support/cache.c |   10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 0168fdca027896..b18b6d3325e9ad 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -56,7 +56,7 @@ struct cache_node;
 
 typedef void *cache_key_t;
 
-typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn);
+typedef void (*cache_walk_t)(struct cache *c, struct cache_node *cn, void *d);
 typedef struct cache_node * (*cache_node_alloc_t)(struct cache *c, cache_key_t k);
 typedef int (*cache_node_flush_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_relse_t)(struct cache *c, struct cache_node *cn);
@@ -130,7 +130,7 @@ static inline bool cache_initialized(const struct cache *cache)
 int cache_init(int flags, unsigned int size,
 	       const struct cache_operations *ops, struct cache *cache);
 void cache_destroy(struct cache *cache);
-void cache_walk(struct cache *, cache_walk_t);
+void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 void cache_flush(struct cache *);
 
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 2e2e36ccc3ef78..606acd5453cf10 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -101,7 +101,8 @@ cache_expand(
 void
 cache_walk(
 	struct cache		*cache,
-	cache_walk_t		visit)
+	cache_walk_t		visit,
+	void			*data)
 {
 	struct cache_hash	*hash;
 	struct cache_node	*pos;
@@ -111,7 +112,7 @@ cache_walk(
 		hash = &cache->c_hash[i];
 		pthread_mutex_lock(&hash->ch_mutex);
 		list_for_each_entry(pos, &hash->ch_list, cn_hash)
-			visit(cache, pos);
+			visit(cache, pos, data);
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
 }
@@ -126,7 +127,8 @@ cache_walk(
 static void
 cache_zero_check(
 	struct cache		*cache,
-	struct cache_node	*node)
+	struct cache_node	*node,
+	void			*data)
 {
 	if (node->cn_count > 0) {
 		fprintf(stderr, "%s: refcount is %u, not zero (node=%p)\n",
@@ -134,7 +136,7 @@ cache_zero_check(
 		cache_abort();
 	}
 }
-#define cache_destroy_check(c)	cache_walk((c), cache_zero_check)
+#define cache_destroy_check(c)	cache_walk((c), cache_zero_check, NULL)
 #else
 #define cache_destroy_check(c)	do { } while (0)
 #endif


