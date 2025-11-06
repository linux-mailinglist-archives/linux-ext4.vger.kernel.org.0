Return-Path: <linux-ext4+bounces-11621-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF12C3DAC5
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 87BC54E55E8
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAFB30F955;
	Thu,  6 Nov 2025 22:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYwA6+Tv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF52A303CAF
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469240; cv=none; b=diLyfrhC8C2y9Z7iguIRgmLPgcBV/WnEeK6aymT9IMLy+j284uRlSi0FHvwCGDRZRRYA1b4BxZ1OmzaKT3hfg51sAS5SbCcVNvJ9ncq0N4GxqON5huVVhbrfRhO2ORJJ2bUgpwCeGNENspMDf9zPweaiyVmE0wpKE9cerAE4fEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469240; c=relaxed/simple;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPrh+f2KgCe4DIOtA2HX8LgQsfZeI7zl73lGHd5v4qi/1xB4o4oRkupwP/vDF7uXih1XkJK/PVwjkq+wBjCTqiUFHAO18R5B2W5zecpbVfuOTf30hO6RC2wP7mphHqaf/zF3EE3+PMnT4iR1dLgwBw+LPw+JHEtAM+ugAmKFvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYwA6+Tv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D7AC4CEF7;
	Thu,  6 Nov 2025 22:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469240;
	bh=D37ShS265+TRIyJOHXbxdya2eyUUS95H8eaOyLDCoAU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YYwA6+Tv5nbu38URp4rWh2K31XuzRkaRG+qy/yjZoXTz8XytofkZ7M/pfqx29adsA
	 xvj5xBjWO4yD1fpBHisPKjnwnlxGSSc4S70v7LmaKw80YhvuM/SMTMr/sAlt9fInE5
	 Mrgfk4O4bf99wki8KakiTdvHyR0FXQZ8LKEwjqyMNk3yLIXqc2APxaw8wpYxJNCw3z
	 9Do8x+NArSlPkp1xvmNQcVb/pUf/N5jM5i0/jens0u0SjoQyNMd3QQraxY3BPdcalC
	 LKrKDSzJd2Qi6eNXQbEOp4K8zdcZeg5CyfvpeP7re+VXpBK5j9HKmsH9ZzdTweHqZe
	 O395NHTqfoO4g==
Date: Thu, 06 Nov 2025 14:47:19 -0800
Subject: [PATCH 16/23] cache: support gradual expansion
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795854.2864310.13874767630428530819.stgit@frogsfrogsfrogs>
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

It's probably not a good idea to expand the cache size by powers of two
beyond some random limit, so let the users figure that out if they want
to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |   10 ++++++++++
 lib/support/cache.c |   12 ++++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 98b2182d49a6e0..ae37945c545f46 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -66,6 +66,14 @@ typedef int (*cache_node_compare_t)(struct cache_node *, cache_key_t);
 typedef unsigned int (*cache_bulk_relse_t)(struct cache *, struct list_head *);
 typedef int (*cache_node_get_t)(struct cache *c, struct cache_node *cn);
 typedef void (*cache_node_put_t)(struct cache *c, struct cache_node *cn);
+typedef unsigned int (*cache_node_resize_t)(const struct cache *c,
+					    unsigned int curr_size);
+
+static inline unsigned int cache_gradual_resize(const struct cache *cache,
+						unsigned int curr_size)
+{
+	return curr_size * 5 / 4;
+}
 
 struct cache_operations {
 	cache_node_hash_t	hash;
@@ -76,6 +84,7 @@ struct cache_operations {
 	cache_bulk_relse_t	bulkrelse;	/* optional */
 	cache_node_get_t	get;		/* optional */
 	cache_node_put_t	put;		/* optional */
+	cache_node_resize_t	resize;		/* optional */
 };
 
 struct cache_hash {
@@ -113,6 +122,7 @@ struct cache {
 	cache_bulk_relse_t	bulkrelse;	/* bulk release routine */
 	cache_node_get_t	get;		/* prepare cache node after get */
 	cache_node_put_t	put;		/* prepare to put cache node */
+	cache_node_resize_t	resize;		/* compute new maxcount */
 	unsigned int		c_hashsize;	/* hash bucket count */
 	unsigned int		c_hashshift;	/* hash key shift */
 	struct cache_hash	*c_hash;	/* hash table buckets */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 9da6c59b3b6391..dbaddc1bd36d3d 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -62,6 +62,7 @@ cache_init(
 		cache_operations->bulkrelse : cache_generic_bulkrelse;
 	cache->get = cache_operations->get;
 	cache->put = cache_operations->put;
+	cache->resize = cache_operations->resize;
 	pthread_mutex_init(&cache->c_mutex, NULL);
 
 	for (i = 0; i <= CACHE_DIRTY_PRIORITY; i++) {
@@ -90,11 +91,18 @@ static void
 cache_expand(
 	struct cache *		cache)
 {
+	unsigned int		new_size = 0;
+
 	pthread_mutex_lock(&cache->c_mutex);
+	if (cache->resize)
+		new_size = cache->resize(cache, cache->c_maxcount);
+	if (new_size <= cache->c_maxcount)
+		new_size = cache->c_maxcount * 2;
 #ifdef CACHE_DEBUG
-	fprintf(stderr, "doubling cache size to %d\n", 2 * cache->c_maxcount);
+	fprintf(stderr, "increasing cache max size from %u to %u\n",
+			cache->c_maxcount, new_size);
 #endif
-	cache->c_maxcount *= 2;
+	cache->c_maxcount = new_size;
 	pthread_mutex_unlock(&cache->c_mutex);
 }
 


