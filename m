Return-Path: <linux-ext4+bounces-1163-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0C84D539
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 23:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67E1E1C24961
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 22:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2580E143D3F;
	Wed,  7 Feb 2024 21:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+sBacg2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8935D143D2B;
	Wed,  7 Feb 2024 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341248; cv=none; b=jlxsazjGJXnLSo/ZA3EIHNWdpjyhzGe21gRV200/5T8X2oS7cCSEdkH9FEo1zEx9BHSksl+7o7vprm4rXAOVxL4FVxxj5RLM49xEFhJmhSwopjad6L4u9L4mFH5VcZETECdNkuhOc2nvFZy4KOl6wCVCCV3Q7G2KdUJktH51zg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341248; c=relaxed/simple;
	bh=019Flsq0STp6nMZsjkc6v11EwEPmvQAJzAoe8AJWt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ld563jbVK5FI0LxG7k4damyu8gHti8/K2Ze/8rC9ufS2t+n50kcdSaMQzDeC4ATYUK15duTv19luIrHWy+zo7IYaIHOsA//Gl9Wwf3Q0Ry4ktr+Iapwk2qDWABCk/xMP9KhVEnZBcaw2K8RZr00J0LzmXnZ0frK+JXcxhu6uMeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+sBacg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60989C433B1;
	Wed,  7 Feb 2024 21:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341248;
	bh=019Flsq0STp6nMZsjkc6v11EwEPmvQAJzAoe8AJWt2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+sBacg2bYSQRD8XFN24UUtsoo+2f+EIyEoO3E1fi9hLk30TITPA5KaDVIP2GI1pC
	 B7zWO+7tIH4CbLkA5k0UHDkSnY3o5Qy2UQf4tcA0yTQ5/BavSXif25boyWgnPOlbi4
	 ZxZGw/InTNzcmMWnpmBlDAVr4bFEkcfnK9D1bnl0TJvteBBvI86xFZnRcxECHd5crC
	 cOFpOIcvN5apNvlV6C3L616v7iVQkInLxgoS7FLGDzwM39ClCxv4br8RfnP5RUr/OI
	 uO5U7wVijTNr/YZZXEw6AJwYGtCqIHJp4QHmJOM6aTff2Aj8iAZfjOhClKqFYuq/2w
	 EKwmBH/UWSMxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 15/16] ext4: correct the hole length returned by ext4_map_blocks()
Date: Wed,  7 Feb 2024 16:26:55 -0500
Message-ID: <20240207212700.4287-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 6430dea07e85958fa87d0276c0c4388dd51e630b ]

In ext4_map_blocks(), if we can't find a range of mapping in the
extents cache, we are calling ext4_ext_map_blocks() to search the real
path and ext4_ext_determine_hole() to determine the hole range. But if
the querying range was partially or completely overlaped by a delalloc
extent, we can't find it in the real extent path, so the returned hole
length could be incorrect.

Fortunately, ext4_ext_put_gap_in_cache() have already handle delalloc
extent, but it searches start from the expanded hole_start, doesn't
start from the querying range, so the delalloc extent found could not be
the one that overlaped the querying range, plus, it also didn't adjust
the hole length. Let's just remove ext4_ext_put_gap_in_cache(), handle
delalloc and insert adjusted hole extent in ext4_ext_determine_hole().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 111 +++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 41 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 193b13630ac1..68aa8760cb46 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2222,7 +2222,7 @@ static int ext4_fill_es_cache_info(struct inode *inode,
 
 
 /*
- * ext4_ext_determine_hole - determine hole around given block
+ * ext4_ext_find_hole - find hole around given block according to the given path
  * @inode:	inode we lookup in
  * @path:	path in extent tree to @lblk
  * @lblk:	pointer to logical block around which we want to determine hole
@@ -2234,9 +2234,9 @@ static int ext4_fill_es_cache_info(struct inode *inode,
  * The function returns the length of a hole starting at @lblk. We update @lblk
  * to the beginning of the hole if we managed to find it.
  */
-static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
-					   struct ext4_ext_path *path,
-					   ext4_lblk_t *lblk)
+static ext4_lblk_t ext4_ext_find_hole(struct inode *inode,
+				      struct ext4_ext_path *path,
+				      ext4_lblk_t *lblk)
 {
 	int depth = ext_depth(inode);
 	struct ext4_extent *ex;
@@ -2263,30 +2263,6 @@ static ext4_lblk_t ext4_ext_determine_hole(struct inode *inode,
 	return len;
 }
 
-/*
- * ext4_ext_put_gap_in_cache:
- * calculate boundaries of the gap that the requested block fits into
- * and cache this gap
- */
-static void
-ext4_ext_put_gap_in_cache(struct inode *inode, ext4_lblk_t hole_start,
-			  ext4_lblk_t hole_len)
-{
-	struct extent_status es;
-
-	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
-				  hole_start + hole_len - 1, &es);
-	if (es.es_len) {
-		/* There's delayed extent containing lblock? */
-		if (es.es_lblk <= hole_start)
-			return;
-		hole_len = min(es.es_lblk - hole_start, hole_len);
-	}
-	ext_debug(inode, " -> %u:%u\n", hole_start, hole_len);
-	ext4_es_insert_extent(inode, hole_start, hole_len, ~0,
-			      EXTENT_STATUS_HOLE);
-}
-
 /*
  * ext4_ext_rm_idx:
  * removes index from the index block.
@@ -4058,6 +4034,69 @@ static int get_implied_cluster_alloc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Determine hole length around the given logical block, first try to
+ * locate and expand the hole from the given @path, and then adjust it
+ * if it's partially or completely converted to delayed extents, insert
+ * it into the extent cache tree if it's indeed a hole, finally return
+ * the length of the determined extent.
+ */
+static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t lblk)
+{
+	ext4_lblk_t hole_start, len;
+	struct extent_status es;
+
+	hole_start = lblk;
+	len = ext4_ext_find_hole(inode, path, &hole_start);
+again:
+	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
+				  hole_start + len - 1, &es);
+	if (!es.es_len)
+		goto insert_hole;
+
+	/*
+	 * There's a delalloc extent in the hole, handle it if the delalloc
+	 * extent is in front of, behind and straddle the queried range.
+	 */
+	if (lblk >= es.es_lblk + es.es_len) {
+		/*
+		 * The delalloc extent is in front of the queried range,
+		 * find again from the queried start block.
+		 */
+		len -= lblk - hole_start;
+		hole_start = lblk;
+		goto again;
+	} else if (in_range(lblk, es.es_lblk, es.es_len)) {
+		/*
+		 * The delalloc extent containing lblk, it must have been
+		 * added after ext4_map_blocks() checked the extent status
+		 * tree, adjust the length to the delalloc extent's after
+		 * lblk.
+		 */
+		len = es.es_lblk + es.es_len - lblk;
+		return len;
+	} else {
+		/*
+		 * The delalloc extent is partially or completely behind
+		 * the queried range, update hole length until the
+		 * beginning of the delalloc extent.
+		 */
+		len = min(es.es_lblk - hole_start, len);
+	}
+
+insert_hole:
+	/* Put just found gap into cache to speed up subsequent requests */
+	ext_debug(inode, " -> %u:%u\n", hole_start, len);
+	ext4_es_insert_extent(inode, hole_start, len, ~0, EXTENT_STATUS_HOLE);
+
+	/* Update hole_len to reflect hole size after lblk */
+	if (hole_start != lblk)
+		len -= lblk - hole_start;
+
+	return len;
+}
 
 /*
  * Block allocation/map/preallocation routine for extents based files
@@ -4175,22 +4214,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	 * we couldn't try to create block if create flag is zero
 	 */
 	if ((flags & EXT4_GET_BLOCKS_CREATE) == 0) {
-		ext4_lblk_t hole_start, hole_len;
+		ext4_lblk_t len;
 
-		hole_start = map->m_lblk;
-		hole_len = ext4_ext_determine_hole(inode, path, &hole_start);
-		/*
-		 * put just found gap into cache to speed up
-		 * subsequent requests
-		 */
-		ext4_ext_put_gap_in_cache(inode, hole_start, hole_len);
+		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
 
-		/* Update hole_len to reflect hole size after map->m_lblk */
-		if (hole_start != map->m_lblk)
-			hole_len -= map->m_lblk - hole_start;
 		map->m_pblk = 0;
-		map->m_len = min_t(unsigned int, map->m_len, hole_len);
-
+		map->m_len = min_t(unsigned int, map->m_len, len);
 		goto out;
 	}
 
-- 
2.43.0


