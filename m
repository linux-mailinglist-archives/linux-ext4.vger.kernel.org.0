Return-Path: <linux-ext4+bounces-9259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA4B19602
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 23:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D536B1742BF
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 21:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B93227BB5;
	Sun,  3 Aug 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMQs/N69"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72B41F55FA;
	Sun,  3 Aug 2025 21:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256079; cv=none; b=XXrtVkaooGB/GPm625nkViZuEGQDVQ4BxiFNyUT15Lxdnk56Z0PDP9y4013a1/XuLdhYa3pC41pAH+Qdbddq1kjVIyJa5IL8dLmq1J8n50lS88tskaLaDUwPoeTLv054alzVNPtx5P+GMnlS9vgn5VSW8M5wsIjuX1qlyHHyI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256079; c=relaxed/simple;
	bh=k0oEe4yRQvrR3IgZDuoW1E+MrNH9vmlphHTyifZ3JJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g2XBNFREMm3lmbkYDs4ElHBRndH8z8BdhkPdZsUTo523PEtrbqqrUy1xnpUxgRMBsFEtumpFYu6uZMSe7StOwr+gtD0eQDJXi1kZVnJJwLR75NNFGNjy//RNpT+G8TaSW2fyAWLOMfdBgUZLNcQpwm7CR3g08/7rHtx7sVewY1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMQs/N69; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09169C4CEEB;
	Sun,  3 Aug 2025 21:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256078;
	bh=k0oEe4yRQvrR3IgZDuoW1E+MrNH9vmlphHTyifZ3JJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMQs/N69UFBgTPtR4UxFNiTESmteAjYqJQ3Eseu/4aS09dXsnu0NNAv+NeQHaVfYu
	 kx8RPWOn3n0wMXuEF5+UKVbNyI3sA/cpjwWkJUXUFhdRIDOHVYarS9xRcc8L4uRFas
	 HgWor66GOdOOwNXi9+Jejihv5Cf+DY6RUuJ9BpbNJApItr2GztGsDwlnAHD9gOC6K+
	 nKWRDZXBk7+j+i9/cx+ck8UWjrVLySMJhhHCjnnTmSf3ysYICKNcth2XtHj/vUxUqD
	 aOtobSmGiZaWlybXwFMIYfuAQi2UG2QFk6ZqAor76k1M98lkzle69gtEr9SWpl/jzR
	 cYv5kv/E6pvCw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wei Gao <wegao@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 20/23] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Sun,  3 Aug 2025 17:20:27 -0400
Message-Id: <20250803212031.3547641-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212031.3547641-1-sashal@kernel.org>
References: <20250803212031.3547641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
Content-Transfer-Encoding: 8bit

From: Wei Gao <wegao@suse.com>

[ Upstream commit a099b09a3342a0b28ea330e405501b5b4d0424b4 ]

Previously, ext2_fiemap would unconditionally apply "len = min_t(u64, len,
i_size_read(inode));", When inode->i_size was 0 (for an empty file), this
would reduce the requested len to 0. Passing len = 0 to iomap_fiemap could
then result in an -EINVAL error, even for valid queries on empty files.

Link: https://github.com/linux-test-project/ltp/issues/1246
Signed-off-by: Wei Gao <wegao@suse.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250613152402.3432135-1-wegao@suse.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis of the commit and its context:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's the
extensive analysis:

**1. Bug Fix Analysis:**
The commit fixes a user-visible bug where `fiemap` operations on empty
files (i_size = 0) could fail with -EINVAL. Looking at the code change
in fs/ext2/inode.c:

- **Before the fix**: `len = min_t(u64, len, i_size_read(inode));` would
  set len to 0 for empty files
- **After the fix**: The code adds a special check:
  ```c
  if (i_size == 0)
  i_size = 1;
  len = min_t(u64, len, i_size);
  ```

This ensures that even for empty files, we pass a non-zero length to
`iomap_fiemap()`.

**2. Root Cause:**
From examining fs/ioctl.c:175-176, I found that `fiemap_prep()`
explicitly returns -EINVAL when len is 0:
```c
if (*len == 0)
    return -EINVAL;
```

This means `iomap_fiemap()` would fail when passed a zero length, which
is exactly what was happening for empty ext2 files.

**3. Impact Assessment:**
- **User-visible impact**: Applications using fiemap on empty ext2 files
  would receive unexpected EINVAL errors
- **Test failure**: The commit references an LTP (Linux Test Project)
  issue (#1246), indicating this breaks existing tests
- **Functional impact**: fiemap is a commonly used interface for
  discovering file extent mappings, and it should work on empty files
  (they simply have no extents)

**4. Fix Quality:**
- **Minimal and contained**: The fix adds only 10 lines of code with a
  clear comment explaining the rationale
- **Safe approach**: Setting i_size to 1 for the length calculation is
  safe because:
  - It only affects the length passed to iomap_fiemap
  - The comment explains this is specifically to avoid EINVAL from
    iomap_fiemap
  - The actual file size remains unchanged
- **No architectural changes**: This is a simple boundary condition fix

**5. Regression Risk:**
- **Low risk**: The change only affects the fiemap path for empty files
- **Well-tested path**: fiemap is a read-only operation
- **Clear boundary**: Only affects files where i_size == 0

**6. Stable Tree Criteria:**
This fix meets all the stable tree criteria:
- Fixes a real bug that users/tests hit
- Small, self-contained change
- No new features or architectural changes
- Clear fix for a specific problem
- Low risk of introducing regressions

**7. Similar Patterns:**
The comment in the fix mentions that "ext2_get_blocks() iterates
unmapped space block by block which is slow" - this suggests the min_t()
optimization is important for performance on large sparse files, but
shouldn't break functionality for empty files.

The fix properly balances maintaining the performance optimization while
ensuring correctness for the edge case of empty files.

 fs/ext2/inode.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 314b415ee518..6ff1f8f29a3c 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -895,9 +895,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	int ret;
+	loff_t i_size;
 
 	inode_lock(inode);
-	len = min_t(u64, len, i_size_read(inode));
+	i_size = i_size_read(inode);
+	/*
+	 * iomap_fiemap() returns EINVAL for 0 length. Make sure we don't trim
+	 * length to 0 but still trim the range as much as possible since
+	 * ext2_get_blocks() iterates unmapped space block by block which is
+	 * slow.
+	 */
+	if (i_size == 0)
+		i_size = 1;
+	len = min_t(u64, len, i_size);
 	ret = iomap_fiemap(inode, fieinfo, start, len, &ext2_iomap_ops);
 	inode_unlock(inode);
 
-- 
2.39.5


