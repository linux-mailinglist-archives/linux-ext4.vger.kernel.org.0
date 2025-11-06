Return-Path: <linux-ext4+bounces-11623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C57C3DACB
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA281884B5C
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A82345750;
	Thu,  6 Nov 2025 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nfx+1oP9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1873F335064
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469273; cv=none; b=Dk9yV9NoVUOtwuspbcjW7u5bDd1xu2Gtyh89Rq/bJFLqMcoGzzzf7P4QlEnyaCsFvf1E+Ixd+Bq9tYRGw3G4C6kX49VmPa6fawomX0SxtEMKbovYPbyVElzMylY63M9v2ik4V9+0ItEuetPNI25A74KlY3zalo+t+MAbIGee92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469273; c=relaxed/simple;
	bh=mmXZC1oIdA71CGLd+8jW1I3THVkDxw476tvDb1hkCyI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhi5eoa2tb+AJ3GqrZfVWV3aXmMi7c9ETer9eElq/XA6eqWpc+Z7YNSb5TYr4bC0ypBuKDgzQmBexVxT5XdEK8vxXLcFKYRZtTzgoQ3ZBQjKVl5mTHZmRTR3uzWB33We6eeNK5pinI5cuAfBWs8pBYwQ7qAmp2iVLtbYqL4tSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nfx+1oP9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96543C4CEFB;
	Thu,  6 Nov 2025 22:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469272;
	bh=mmXZC1oIdA71CGLd+8jW1I3THVkDxw476tvDb1hkCyI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Nfx+1oP9QUANaOkevuEihVky+ElQEpIyRLRD6xTrlwi+k0+/gTt+DpnvJwihUr0Ux
	 V1gY/sk3hJBKjvZp7yrguIgRXmDTRDr7rsUx/EP1uIac1+WvS9mT5Sgq2ciVEnMggQ
	 Vat8bn9V+oqGlNo8Fkv/uhRfowh12JCCyZWc3apibFDGIhSlmQq8mEWSc9Eggr5Nes
	 bZqPEytNYXi0SAFBb2H7bruELz2fhlhmYaDtUpS7TElGb1IEPNI71iKW5OcyMSr2Wr
	 tBsOfE6RmEFaRW05Gbi6Am32oWVV1k4mhg36gcu9zANe29d2p3LcUBrPiT8m0Tz0ta
	 XYbIv1x7+2QCQ==
Date: Thu, 06 Nov 2025 14:47:51 -0800
Subject: [PATCH 18/23] cache: support channging flags
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795890.2864310.7871055253361068028.stgit@frogsfrogsfrogs>
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

Make it so that we can change the flags in use by a given cache.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/support/cache.h |    4 ++++
 lib/support/cache.c |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+)


diff --git a/lib/support/cache.h b/lib/support/cache.h
index 75e61c92a1fd35..32b99b5fe733e3 100644
--- a/lib/support/cache.h
+++ b/lib/support/cache.h
@@ -16,6 +16,8 @@
  */
 #define CACHE_MISCOMPARE_PURGE	(1 << 0)
 
+#define CACHE_FLAGS_ALL		(CACHE_MISCOMPARE_PURGE)
+
 /*
  * cache object campare return values
  */
@@ -145,6 +147,8 @@ void cache_purge(struct cache *);
 bool cache_flush(struct cache *cache);
 
 void cache_set_maxcount(struct cache *cache, unsigned int maxcount);
+int cache_set_flag(struct cache *cache, int flags);
+int cache_clear_flag(struct cache *cache, int flags);
 
 /* don't allocate a new node */
 #define CACHE_GET_INCORE	(1U << 0)
diff --git a/lib/support/cache.c b/lib/support/cache.c
index e2f9e722eb2ef1..99044248b85d38 100644
--- a/lib/support/cache.c
+++ b/lib/support/cache.c
@@ -97,6 +97,24 @@ cache_set_maxcount(
 	pthread_mutex_unlock(&cache->c_mutex);
 }
 
+int
+cache_set_flag(
+	struct cache		*cache,
+	int			flags)
+{
+	cache->c_flags |= (flags & CACHE_FLAGS_ALL);
+	return 0;
+}
+
+int
+cache_clear_flag(
+	struct cache		*cache,
+	int			flags)
+{
+	cache->c_flags &= ~flags;
+	return 0;
+}
+
 static void
 cache_expand(
 	struct cache *		cache)


