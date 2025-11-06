Return-Path: <linux-ext4+bounces-11614-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F0C3DAA1
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 764EF34FD96
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D586D2BFC8F;
	Thu,  6 Nov 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6GsGsu3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787E5308F27
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469128; cv=none; b=gPbgRm039pYFzs2nrB/fYJIjvGVyvQPk38QV6NOciPw6VftUlOYX9jn5xHrAVlE60vgeWXfQncaXyEHK/6kbtSKXU9IZ8zFRMydF+q5eGsDFSQpAfSB0vu4tbS/QUX2Vx6DHlRoXw8G69+QvFQsmv6beKwJ1jkXSPgYnF6U+7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469128; c=relaxed/simple;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VspUuiqXGOVFVWKdUbnUKNqeSZ+6Zqr0oCdn/LzLo0kvZvmqgJkaJ2uETWewMZEP2//RokS2UT9mIUuOYbgmtFq4P34uD7dgemEvq7REbLtXRptUHjbS8quYld0W51CPWFokliuavxBKZu0jHLIDVc4Sw5jtsPkuUxJgohHFMcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6GsGsu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE34C19422;
	Thu,  6 Nov 2025 22:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469128;
	bh=z7kGfGapJOINdUkRtV0OmOwbB6aP3Hb16I1mgZSR1jc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=A6GsGsu3kjrGZpzCW17nYv3dUw3nLiJBXf3JFLu/BUDYc+MlYniPTfY7ptgeDKMt5
	 LGOgla8ehnRWa7qxoMpI5ELVcxZjKqabqjp6WajD1p/6n0+teVkTDmGS4NIZ2FyeRl
	 0FkFX/Indcd0To98nhEVJNsuia3YF4Tbu/+7AIf7a51HWjNYi/wyhBFDbOOOUTEcA1
	 rugjeT2VrDti/2CpsoJ09qqH6HGWvFTzyy6FrvFKoR2+JUa3H2iuHKkkAjfVLTCyvI
	 W7IAJ/LEYIRk8Fyr6VMaYeq8SyYb+DeEbx6urp5cywPKd53Q5oOIZoMAMNOgWQXp6w
	 O+5OcspYw50LA==
Date: Thu, 06 Nov 2025 14:45:27 -0800
Subject: [PATCH 09/23] cache: use modern list iterator macros
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795730.2864310.11956914504670731265.stgit@frogsfrogsfrogs>
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

Use the list iterator macros from list.h.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.c |   71 +++++++++++++++++----------------------------------
 1 file changed, 24 insertions(+), 47 deletions(-)


diff --git a/lib/support/cache.c b/lib/support/cache.c
index 08e0b484cca298..d8f8231ac36d28 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -98,20 +98,18 @@ cache_expand(
 
 void
 cache_walk(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_walk_t		visit)
 {
-	struct cache_hash *	hash;
-	struct list_head *	head;
-	struct list_head *	pos;
+	struct cache_hash	*hash;
+	struct cache_node	*pos;
 	unsigned int		i;
 
 	for (i = 0; i < cache->c_hashsize; i++) {
 		hash = &cache->c_hash[i];
-		head = &hash->ch_list;
 		pthread_mutex_lock(&hash->ch_mutex);
-		for (pos = head->next; pos != head; pos = pos->next)
-			visit((struct cache_node *)pos);
+		list_for_each_entry(pos, &hash->ch_list, cn_hash)
+			visit(pos);
 		pthread_mutex_unlock(&hash->ch_mutex);
 	}
 }
@@ -218,12 +216,9 @@ cache_shake(
 	bool			purge)
 {
 	struct cache_mru	*mru;
-	struct cache_hash *	hash;
+	struct cache_hash	*hash;
 	struct list_head	temp;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
-	struct cache_node *	node;
+	struct cache_node	*node, *n;
 	unsigned int		count;
 
 	ASSERT(priority <= CACHE_DIRTY_PRIORITY);
@@ -233,13 +228,9 @@ cache_shake(
 	mru = &cache->c_mrus[priority];
 	count = 0;
 	list_head_init(&temp);
-	head = &mru->cm_list;
 
 	pthread_mutex_lock(&mru->cm_mutex);
-	for (pos = head->prev, n = pos->prev; pos != head;
-						pos = n, n = pos->prev) {
-		node = list_entry(pos, struct cache_node, cn_mru);
-
+	list_for_each_entry_safe_reverse(node, n, &mru->cm_list, cn_mru) {
 		if (pthread_mutex_trylock(&node->cn_mutex) != 0)
 			continue;
 
@@ -376,31 +367,25 @@ __cache_node_purge(
  */
 int
 cache_node_get(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_key_t		key,
-	struct cache_node **	nodep)
+	struct cache_node	**nodep)
 {
-	struct cache_node *	node = NULL;
-	struct cache_hash *	hash;
-	struct cache_mru *	mru;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
+	struct cache_hash	*hash;
+	struct cache_mru	*mru;
+	struct cache_node	*node = NULL, *n;
 	unsigned int		hashidx;
 	int			priority = 0;
 	int			purged = 0;
 
 	hashidx = cache->hash(key, cache->c_hashsize, cache->c_hashshift);
 	hash = cache->c_hash + hashidx;
-	head = &hash->ch_list;
 
 	for (;;) {
 		pthread_mutex_lock(&hash->ch_mutex);
-		for (pos = head->next, n = pos->next; pos != head;
-						pos = n, n = pos->next) {
+		list_for_each_entry_safe(node, n, &hash->ch_list, cn_hash) {
 			int result;
 
-			node = list_entry(pos, struct cache_node, cn_hash);
 			result = cache->compare(node, key);
 			switch (result) {
 			case CACHE_HIT:
@@ -568,23 +553,19 @@ cache_node_get_priority(
  */
 int
 cache_node_purge(
-	struct cache *		cache,
+	struct cache		*cache,
 	cache_key_t		key,
-	struct cache_node *	node)
+	struct cache_node	*node)
 {
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct list_head *	n;
-	struct cache_hash *	hash;
+	struct cache_node	*pos, *n;
+	struct cache_hash	*hash;
 	int			count = -1;
 
 	hash = cache->c_hash + cache->hash(key, cache->c_hashsize,
 					   cache->c_hashshift);
-	head = &hash->ch_list;
 	pthread_mutex_lock(&hash->ch_mutex);
-	for (pos = head->next, n = pos->next; pos != head;
-						pos = n, n = pos->next) {
-		if ((struct cache_node *)pos != node)
+	list_for_each_entry_safe(pos, n, &hash->ch_list, cn_hash) {
+		if (pos != node)
 			continue;
 
 		count = __cache_node_purge(cache, node);
@@ -642,12 +623,10 @@ cache_purge(
  */
 void
 cache_flush(
-	struct cache *		cache)
+	struct cache		*cache)
 {
-	struct cache_hash *	hash;
-	struct list_head *	head;
-	struct list_head *	pos;
-	struct cache_node *	node;
+	struct cache_hash	*hash;
+	struct cache_node	*node;
 	int			i;
 
 	if (!cache->flush)
@@ -657,9 +636,7 @@ cache_flush(
 		hash = &cache->c_hash[i];
 
 		pthread_mutex_lock(&hash->ch_mutex);
-		head = &hash->ch_list;
-		for (pos = head->next; pos != head; pos = pos->next) {
-			node = (struct cache_node *)pos;
+		list_for_each_entry(node, &hash->ch_list, cn_hash) {
 			pthread_mutex_lock(&node->cn_mutex);
 			cache->flush(node);
 			pthread_mutex_unlock(&node->cn_mutex);


