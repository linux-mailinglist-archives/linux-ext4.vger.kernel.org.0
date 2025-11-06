Return-Path: <linux-ext4+bounces-11618-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961DC3DAB6
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AAB1884FC7
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A892BFC8F;
	Thu,  6 Nov 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsJU8wTF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769382248B4
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469192; cv=none; b=i5FuE+aJ0CzII9dokPzCqTZ7mK6HDw0UzGwvnAWjFvSyDr3eIxldqn1FcIqmHhKTTIZ68/j2wKohHU24Qh0lLx116tFKCoPumWqq1uBql/bCngcyGEyMY+5aqpFDKhIAtBZaZRRzPGiit53ie9PWEF5mNjDnD5DRdyypqyx2QH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469192; c=relaxed/simple;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qJ4bnLSL2szMtB4GF9157I8PA1DDn5am0qKlDJcpz5lZ0+qUauj1TNNucgyChdmMYYI2PjZzXZHGzkAvzh39ALGk8Y4ZOiBFHB0G8zghhGPZ6mZr4dtlvBCTs/MKaBRIVbLVRi3bus180nu+YdfrtcyRhbSppyUNB/6SjkwOcmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsJU8wTF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42396C116C6;
	Thu,  6 Nov 2025 22:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469192;
	bh=Zy/lgbaMNU/aksDpuurbkD6dJt6D+7X3gyD4CGi6WJw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=LsJU8wTFX20kTEg5FWdpFk0Aqj2ynMmymQnWexojnZdYq/sDDZT/2hN0c0Pokv/US
	 zQKPb9H2i57mH1F+vfhVJMi7DqHO6WuxmV6PITFXXi0PC8ZHfd4UNKJnUOiFxCg12O
	 fz+xqgQMGAVwF3/Tc6Bo8tKD5Rau5OoOB+HzjSkRBvTmIvM6vWvpTAJda5htAPwVQ3
	 ZKFKPNbmA5M0Oaf9a9hkYeGJ/vRe3f0t0tNmWdtBHu0S//Bd5wmnehR75IXhXd6OWn
	 +cVe2+oJWX0u+IkXj2mh/C2d7D4IGhpg+fXIRljtehV0XCoLAAs4WqL1YSaX8Wv3On
	 lqLsDEi+c2b/w==
Date: Thu, 06 Nov 2025 14:46:31 -0800
Subject: [PATCH 13/23] cache: add a helper to grab a new refcount for a
 cache_node
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795803.2864310.11146301563573138273.stgit@frogsfrogsfrogs>
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

Create a helper to bump the refcount of a cache node.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    1 +
 lib/support/cache.c |   57 +++++++++++++++++++++++++++++----------------------
 2 files changed, 33 insertions(+), 25 deletions(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index b18b6d3325e9ad..e8f1c82ef7869c 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -141,5 +141,6 @@ int cache_node_get_priority(struct cache_node *);
 int cache_node_purge(struct cache *, cache_key_t, struct cache_node *);
 void cache_report(FILE *fp, const char *, struct cache *);
 int cache_overflowed(struct cache *);
+struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node);
 
 #endif	/* __CACHE_H__ */
diff --git a/lib/support/cache.c b/lib/support/cache.c
index 606acd5453cf10..49568ffa6de2e4 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -362,6 +362,35 @@ __cache_node_purge(
 	return 0;
 }
 
+/* Grab a new refcount to the cache node object.  Caller must hold cn_mutex. */
+struct cache_node *cache_node_grab(struct cache *cache, struct cache_node *node)
+{
+	struct cache_mru *mru;
+
+	if (node->cn_count == 0 && cache->get) {
+		int err = cache->get(cache, node);
+		if (err)
+			return NULL;
+	}
+	if (node->cn_count == 0) {
+		ASSERT(node->cn_priority >= 0);
+		ASSERT(!list_empty(&node->cn_mru));
+		mru = &cache->c_mrus[node->cn_priority];
+		pthread_mutex_lock(&mru->cm_mutex);
+		mru->cm_count--;
+		list_del_init(&node->cn_mru);
+		pthread_mutex_unlock(&mru->cm_mutex);
+		if (node->cn_old_priority != -1) {
+			ASSERT(node->cn_priority ==
+					CACHE_DIRTY_PRIORITY);
+			node->cn_priority = node->cn_old_priority;
+			node->cn_old_priority = -1;
+		}
+	}
+	node->cn_count++;
+	return node;
+}
+
 /*
  * Lookup in the cache hash table.  With any luck we'll get a cache
  * hit, in which case this will all be over quickly and painlessly.
@@ -377,7 +406,6 @@ cache_node_get(
 	struct cache_node	**nodep)
 {
 	struct cache_hash	*hash;
-	struct cache_mru	*mru;
 	struct cache_node	*node = NULL, *n;
 	unsigned int		hashidx;
 	int			priority = 0;
@@ -411,31 +439,10 @@ cache_node_get(
 			 * from its MRU list, and update stats.
 			 */
 			pthread_mutex_lock(&node->cn_mutex);
-
-			if (node->cn_count == 0 && cache->get) {
-				int err = cache->get(cache, node);
-				if (err) {
-					pthread_mutex_unlock(&node->cn_mutex);
-					goto next_object;
-				}
+			if (!cache_node_grab(cache, node)) {
+				pthread_mutex_unlock(&node->cn_mutex);
+				goto next_object;
 			}
-			if (node->cn_count == 0) {
-				ASSERT(node->cn_priority >= 0);
-				ASSERT(!list_empty(&node->cn_mru));
-				mru = &cache->c_mrus[node->cn_priority];
-				pthread_mutex_lock(&mru->cm_mutex);
-				mru->cm_count--;
-				list_del_init(&node->cn_mru);
-				pthread_mutex_unlock(&mru->cm_mutex);
-				if (node->cn_old_priority != -1) {
-					ASSERT(node->cn_priority ==
-							CACHE_DIRTY_PRIORITY);
-					node->cn_priority = node->cn_old_priority;
-					node->cn_old_priority = -1;
-				}
-			}
-			node->cn_count++;
-
 			pthread_mutex_unlock(&node->cn_mutex);
 			pthread_mutex_unlock(&hash->ch_mutex);
 


