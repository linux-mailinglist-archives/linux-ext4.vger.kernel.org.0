Return-Path: <linux-ext4+bounces-8080-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554DABFF9B
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6F41B64BF0
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A2B23958D;
	Wed, 21 May 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaiTSkIY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878A12B9A9
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866911; cv=none; b=AcPGnoJlnb6oJJ70FyvW9VZcMu0yaPIf7okUnPSe8rqALuJrrvW0rvYTdgNBTiL9+9S+TBKi+j3xr7WFlGeNf4Pg4eBRDZrXwa/ksv8Q5MfndIOL4bYHypv/ZzpJ0FxPnCOG5zhZ78esLRmx7uhY1aRg7MasL4xLmOAvascNtw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866911; c=relaxed/simple;
	bh=lSetTrbUEw8qBiaVzFHvl9u0uTp8ynRndthHNuDIiZo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AkiBcKREGsKxjPZ7B1m39cnF2fzuJwM+a/LjWZ2akdCVQtOpw5AC6yRu4UfWweitCo6TzoMn1n4q/cE23Hm/Mq8py/MHBIXixUYL8n9EhsfGn62dEPNtFzOjGVPeMkYubnkGVJj+Tu4iFVEQqmOI2Nl0YHzFKRjPQOR0y7J71Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaiTSkIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19B0C4CEE4;
	Wed, 21 May 2025 22:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747866911;
	bh=lSetTrbUEw8qBiaVzFHvl9u0uTp8ynRndthHNuDIiZo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jaiTSkIYwA6yS+auxNk46mvNWp7JZUCzIY9IQFIt/v6t6jNZVUa3aAU9W+MvDuoWs
	 00D2jJoyTKTqvUaXC/RnOmVhPWbpuLuImV0dQ2evxznp5lr7QMQLQludr9oadJel1v
	 WGtvamKffaSdu5a7fksvf37V3pDWh1Y1lIiHGD9nXQJiPInei786GlJXbK21+Ka08d
	 kei5XTHAMSK8AZaVialQ4WMpPXnNST3MOGy0qfSpZdZr2IlRYkGCk5FHJFxKgLNCOJ
	 zYds/9o8VgpXyG/mKADuhYKVfHGSfYbQ231teuxDa9Y0ttVF2+BcthPSLIgwNIQQ3M
	 e7XPCHm4m8jxA==
Date: Wed, 21 May 2025 15:35:10 -0700
Subject: [PATCH 01/29] libext2fs: fix unix io manager invalidation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677566.1383760.15330012260577982100.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

flush_cached_blocks does not invalidate clean blocks from the block
cache.  From reading all the call sites, it looks like they all actually
want the cache to be empty on successful return, so adjust the
implementation to do this.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |   30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index dbe748d9c43583..b98c44a84bb0af 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -670,20 +670,24 @@ static errcode_t flush_cached_blocks(io_channel channel,
 	if ((flags & FLUSH_NOLOCK) == 0)
 		mutex_lock(data, CACHE_MTX);
 	for (i=0, cache = data->cache; i < data->cache_size; i++, cache++) {
-		if (!cache->in_use || !cache->dirty)
+		if (!cache->in_use)
 			continue;
-		retval = raw_write_blk(channel, data,
-				       cache->block, 1, cache->buf,
-				       RAW_WRITE_NO_HANDLER);
-		if (retval) {
-			cache->write_err = 1;
-			errors_found = 1;
-			retval2 = retval;
-		} else {
-			cache->dirty = 0;
-			cache->write_err = 0;
-			if (flags & FLUSH_INVALIDATE)
-				cache->in_use = 0;
+		if (cache->dirty) {
+			retval = raw_write_blk(channel, data,
+					       cache->block, 1, cache->buf,
+					       RAW_WRITE_NO_HANDLER);
+			if (retval) {
+				cache->write_err = 1;
+				errors_found = 1;
+				retval2 = retval;
+			} else {
+				cache->dirty = 0;
+				cache->write_err = 0;
+				if (flags & FLUSH_INVALIDATE)
+					cache->in_use = 0;
+			}
+		} else if (flags & FLUSH_INVALIDATE) {
+			cache->in_use = 0;
 		}
 	}
 	if ((flags & FLUSH_NOLOCK) == 0)


