Return-Path: <linux-ext4+bounces-11622-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA72C3DAC8
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7672034FFCE
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446C9307AD9;
	Thu,  6 Nov 2025 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aWqspwys"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2702C375A
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469256; cv=none; b=Kz1ptjoFuQLHLtoUnd3HVcMtxDWuARNTEHBsnJiobbr0IRfvVvrbd8LVDPb9fVU1gqw9xyShtlmOv+HbXxXKyPJdYEBUc+LoJqV/wH4LvEVRvolGFDUu+ZT8D2uSUhuDfVUhZMgfh5kOnN8uE/vaszdaAXSTWZBG96Xi5KFlLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469256; c=relaxed/simple;
	bh=2NpnFU72Kj1DSCYk2TEQHNNGskzrRjPy58+lvpDEGfE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBwW70Lq8iokonIQiCDxYsawQojpRzRQbQdeLkF2iD3Mr/sSBbB3mmjdOIc8z6s2r2/TST/OxlZ3h97VLe0n5Ti+GB+IXw2utNQbSF3iH5AAnREMLeLarSu569JZYSlWSXLGvxeDgwd1krVQUZ7RTWmW8tZ/EOLZuv1L5IcBxVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aWqspwys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64746C116D0;
	Thu,  6 Nov 2025 22:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469256;
	bh=2NpnFU72Kj1DSCYk2TEQHNNGskzrRjPy58+lvpDEGfE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=aWqspwyshpdygV47VAmPR4C7FOXxwKjpNFLsy5OJUQXkWzx/lbAY9LsLp4dWSsMxJ
	 e2xqJMgbROsbhkXyysxbgcJfKjYkwXlyjRK0qYsVHQmbU1A94GYIkU2CFKZm4X2FXR
	 yvLQVt/dKTvI3nTFUG8/i50+TTz+9jfaMQpTI1iXL8Bec9uGhVOaQ7FoUDyztfP8iF
	 xw8WOjGQm1/Ot9ldBQO+wS6y7xj0WtZ/s1x2HnseurMEr0wLgfZt2chuvCOduvHj67
	 d58/syAFBwsa5q8e394bQsUn2ttlDj5ebS8ds+FVnKir+G9ndTzziVFQ4QUEZDUcW/
	 u7E7+9N3WZZ+w==
Date: Thu, 06 Nov 2025 14:47:35 -0800
Subject: [PATCH 17/23] cache: support updating maxcount and flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795872.2864310.1277365977805843124.stgit@frogsfrogsfrogs>
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

A future patchset will create a new io cache manager that uses the
hashtable in cache.c  It's desirable for fuse4fs to be able to control
the maximum number of buffers in the IO cache, so add a simple API so
that cache users can set a new max item count.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    2 ++
 lib/support/cache.c |   10 ++++++++++
 2 files changed, 12 insertions(+)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index ae37945c545f46..75e61c92a1fd35 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -144,6 +144,8 @@ void cache_walk(struct cache *cache, cache_walk_t fn, void *data);
 void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
 
+void cache_set_maxcount(struct cache *cache, unsigned int maxcount);
+
 /* don't allocate a new node */
 #define CACHE_GET_INCORE	(1U << 0)
 int cache_node_get(struct cache *c, cache_key_t key, unsigned int cgflags,
diff --git a/lib/support/cache.c b/lib/support/cache.c
index dbaddc1bd36d3d..e2f9e722eb2ef1 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -87,6 +87,16 @@ cache_init(
 	return 0;
 }
 
+void
+cache_set_maxcount(
+	struct cache		*cache,
+	unsigned int		maxcount)
+{
+	pthread_mutex_lock(&cache->c_mutex);
+	cache->c_maxcount = maxcount;
+	pthread_mutex_unlock(&cache->c_mutex);
+}
+
 static void
 cache_expand(
 	struct cache *		cache)


