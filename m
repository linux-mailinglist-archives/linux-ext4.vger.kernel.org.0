Return-Path: <linux-ext4+bounces-11620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB48C3DAC2
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75CA188B106
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD842E7BDC;
	Thu,  6 Nov 2025 22:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPW84KWD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64272DF14D
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469224; cv=none; b=GFOmXbFnWQ0nWNPW5s6UT0705Exe+2PwUzgjRF+1esRmvDC+2DKL43npHMoB74M1bzGNjtyu42xt905QxMTkNBSnr22+b9jFbSFkRJxWmoSOiMpbZKRqN3EZtUY0xjGX3BJksEwTO90dMNW+m3IymtKwA1egOVZvZBpN2Al/4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469224; c=relaxed/simple;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ptf0Lxd3nqBH5MFJg/cmV+LykHjymqPdHFm5dnRQp90JKikeHdnsTzAYSxKy3vxWP3b6Y9k4YyFL2kBuJOaZ/QHx07WxZ/8fX+DgwKYv0hMv9oI56Wgk+eNlOr1eXFCxHbgHS2leztE6OvQ1WLQxAWccJCbJh0fRtqIE7NqEwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPW84KWD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421C8C4CEF7;
	Thu,  6 Nov 2025 22:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469224;
	bh=gAZrmKolXFCxZ45HJQmM9Ami+wuutg5zgqcKfzdRftc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=MPW84KWDFoL/XR/COvQ9SE94M4KcMP2lRku6AAGVSk3SuGt3NRIr5a7nOtW2f8eyc
	 T4uQ4tyHANzYU1v0XhsqXqKIviD4Utna638U6A4wkN4s0ZwgGKpTe515MeA3g8cMYR
	 XcAyutqoCNdTaSpN2qAO/xvZinMup1Vj224U6yL2LPupNHBX2dbjsnJcVFxKQoVKOP
	 tScs2F2HtWtzNy/PW7OwANAh5MO0fD8qYcIPvTXtPlWxlVfjMqJaXk7t2nE+NxM+4u
	 aDLp+/wSq+RF5+CwW0HO3jFMnqWpgSsBVcY/g04A1SKI00yuqpuAB1fE89QkTGvw9P
	 7C/EnUZzmDXuw==
Date: Thu, 06 Nov 2025 14:47:03 -0800
Subject: [PATCH 15/23] cache: add a "get only if incore" flag to
 cache_node_get
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795837.2864310.7598593892132758178.stgit@frogsfrogsfrogs>
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

Add a new flag to cache_node_get so that callers can specify that they
only want the cache to return an existing cache node, and not create a
new one.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    5 ++++-
 lib/support/cache.c |    7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 8d39ca5c02a285..98b2182d49a6e0 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -134,7 +134,10 @@ void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
 
-int cache_node_get(struct cache *, cache_key_t, struct cache_node **);
+/* don't allocate a new node */
+#define CACHE_GET_INCORE	(1U << 0)
+int cache_node_get(struct cache *c, cache_key_t key, unsigned int cgflags,
+		   struct cache_node **nodep);
 void cache_node_put(struct cache *, struct cache_node *);
 void cache_node_set_priority(struct cache *, struct cache_node *, int);
 int cache_node_get_priority(struct cache_node *);
diff --git a/lib/support/cache.c b/lib/support/cache.c
index fa07b4ad8222d2..9da6c59b3b6391 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -403,6 +403,7 @@ int
 cache_node_get(
 	struct cache		*cache,
 	cache_key_t		key,
+	unsigned int		cgflags,
 	struct cache_node	**nodep)
 {
 	struct cache_hash	*hash;
@@ -456,6 +457,12 @@ cache_node_get(
 			continue;	/* what the hell, gcc? */
 		}
 		pthread_mutex_unlock(&hash->ch_mutex);
+
+		if (cgflags & CACHE_GET_INCORE) {
+			*nodep = NULL;
+			return 0;
+		}
+
 		/*
 		 * not found, allocate a new entry
 		 */


