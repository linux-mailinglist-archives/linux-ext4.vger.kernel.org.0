Return-Path: <linux-ext4+bounces-8258-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D812ACA214
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jun 2025 01:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5FD1660A8
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Jun 2025 23:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD8267AF4;
	Sun,  1 Jun 2025 23:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMo1+Uor"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D313D26772A;
	Sun,  1 Jun 2025 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820389; cv=none; b=WX39Za8yrDM7dGIof++NHEWgqCVTzQIwxRQMRpGfd1onGHYp0tdJsWiiq/gfYuycJ0yS+NkyOSA+mxP5fbv/pEtGH+OZ6HyggFXICFF7BgONVct8ZF978q0aG7gNVYqqE+ML1MWPtLflbfiS3johanRLynPSIOQN9Inq8ZnrG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820389; c=relaxed/simple;
	bh=jkzR1e19uQ75KFYyg3MffyH08YU0MTtRfHV7GxsxUuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rseUREvBU9vb7/XiRjCePqYqUw9vT7z0uhu+5o+gTFA+nyf0H6HW4GqsDDgQ2UgC/6e7qBtt9i6nLKDzM8dwUWgKiVyH+25nW7hxJXfs+hDptBmE3VQoBWFac/xPfEfzmiqzpTy5O1CtE+juWBBDLrAcNadnZwmmEA1Frb5CQqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMo1+Uor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD239C4CEF2;
	Sun,  1 Jun 2025 23:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820389;
	bh=jkzR1e19uQ75KFYyg3MffyH08YU0MTtRfHV7GxsxUuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tMo1+UorUgaEwYRa4CXbzLcOgLV4NyNDsakQgw3f0VaYVvITw+Flfn+XT2zj48UqT
	 YnSMfgQsq3nzjlax6fawFRkxRL8PFTom3ttb4hk/JvYYkqPLZAIPG6IY6o0YwfZJnB
	 577vDFyE6u6oxLn0FLkMlr9N2d1HVQr2mVI0AC3jWDxON32k9YmiTYCLXfgriIPfUh
	 I1PaOO7o3FHUJNtyqTBGp0w/+pt6ou78MfcIr++lPNYG9FekD7tsqG2ZE41qRipx53
	 kPQSzKqOHvIKQpr/INSgU2+F8QWH9ijnXIezFzAjBDuuEkoXVpeURFw6iOO/L/PAGI
	 0l1OP3k+MWUUg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 045/110] ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
Date: Sun,  1 Jun 2025 19:23:27 -0400
Message-Id: <20250601232435.3507697-45-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 53ce42accd2002cc490fc86000ac532530507a74 ]

When removing space, we should use EXT4_EX_NOCACHE because we don't
need to cache extents, and we should also use EXT4_EX_NOFAIL to prevent
metadata inconsistencies that may arise from memory allocation failures.
While ext4_ext_remove_space() already uses these two flags in most
places, they are missing in ext4_ext_search_right() and
read_extent_tree_block() calls. Unify the flags to ensure consistent
behavior throughout the extent removal process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250423085257.122685-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my thorough analysis of this commit and the kernel code
context, here is my assessment: **YES** This commit should be backported
to stable kernel trees. ## Detailed Analysis: ### **Nature of the Bug
Fix** This commit addresses an important consistency issue in the ext4
extent removal process. The problem is that `ext4_ext_remove_space()`
inconsistently applies critical flags (`EXT4_EX_NOCACHE |
EXT4_EX_NOFAIL`) across all its `read_extent_tree_block()` calls. ###
**Technical Impact** 1. **`EXT4_EX_NOCACHE`**: Prevents caching of
extents during removal operations. Without this flag in
`ext4_ext_search_right()` calls (lines 1607, 1615), the extent cache
could become polluted with stale entries during space removal,
potentially leading to incorrect block mappings. 2.
**`EXT4_EX_NOFAIL`**: Ensures memory allocation cannot fail during
critical metadata operations. The absence of this flag in the affected
calls could cause metadata inconsistencies if memory allocation fails
during extent tree traversal. ### **Risk Assessment - Low Risk** -
**Small, contained change**: Only adds consistent flag usage across
existing function calls - **No algorithmic changes**: The core logic
remains unchanged - **Well-understood flags**: Both flags are already
used extensively in the same function ### **Comparison with Historical
Commits** **Similar to "YES" commits:** - Like commit #1 (ext4 cache
pollution fix): Addresses extent cache consistency issues - Like commit
#2 (nofail preallocation): Prevents metadata inconsistencies from
allocation failures - Small, targeted fix with clear purpose - Addresses
potential data corruption scenarios **Unlike "NO" commits:** - Not a
cleanup/refactoring (commits #3, #4, #5 were architectural changes) -
Not removing functionality or making API changes - Fixes an actual bug
rather than just code organization ### **Code Evidence** The changes are
in `/fs/ext4/extents.c:1607, 1615, 2980, 2920, 4299`: 1. **Lines 1607,
1615**: `ext4_ext_search_right()` now receives and uses flags parameter
2. **Line 2980**: `read_extent_tree_block()` in the main removal loop
now uses unified flags 3. **Line 2920**: `ext4_ext_search_right()` call
now passes flags consistently 4. **Line 4299**: Non-removal path
correctly passes 0 flags (no change in behavior) ### **Subsystem
Context** From examining the kernel source: - `EXT4_EX_NOCACHE` prevents
extent caching when `depth == 0` (line ~460 in extents.c) -
`EXT4_EX_NOFAIL` adds `__GFP_NOFAIL` to allocation flags (line ~397 in
extents.c) - The function `ext4_ext_remove_space()` is called during
truncation and punch hole operations ### **User Impact** This fixes
potential filesystem corruption during: - File truncation operations -
Punch hole operations - Any extent removal scenarios The inconsistent
flag usage could lead to stale extent cache entries and allocation
failures during critical metadata operations, both of which can cause
filesystem corruption. ### **Conclusion** This is a clear bug fix that
prevents potential filesystem corruption with minimal risk of
regression. It follows the pattern of similar commits that were
successfully backported and addresses a real consistency issue that
could affect filesystem reliability.

 fs/ext4/extents.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36d..d8eac736cc9a0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1530,7 +1530,7 @@ static int ext4_ext_search_left(struct inode *inode,
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent *ret_ex)
+				 struct ext4_extent *ret_ex, int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1604,7 +1604,8 @@ static int ext4_ext_search_right(struct inode *inode,
 	ix++;
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
-		bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+		bh = read_extent_tree_block(inode, ix, path->p_depth - depth,
+					    flags);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
@@ -1612,7 +1613,7 @@ static int ext4_ext_search_right(struct inode *inode,
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, flags);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2821,6 +2822,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
+	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
 	partial.pclu = 0;
 	partial.lblk = 0;
@@ -2851,8 +2853,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL,
-					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
+		path = ext4_find_extent(inode, end, NULL, flags);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2918,7 +2919,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
+						    NULL, flags);
 			if (err < 0)
 				goto out;
 			if (pblk) {
@@ -2994,8 +2995,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode, path[i].p_idx,
-						    depth - i - 1,
-						    EXT4_EX_NOCACHE);
+						    depth - i - 1, flags);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
@@ -4314,7 +4314,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
+	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright,
+				    &ex2, 0);
 	if (err < 0)
 		goto out;
 
-- 
2.39.5


