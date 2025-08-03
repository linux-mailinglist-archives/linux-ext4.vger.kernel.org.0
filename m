Return-Path: <linux-ext4+bounces-9260-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B0BB1962C
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 23:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7BB57A0F51
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 21:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC0221280;
	Sun,  3 Aug 2025 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQnOpBF+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C205502;
	Sun,  3 Aug 2025 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256120; cv=none; b=Y6pGLFERq9w1UN4P6CzPtaa38UHQAtvxKzsV703yKEKbCwJiWIVuPROvxS7ZqeagEUkwMydh2IsuU9AX34zp4RWMNRr3gFnZBrdjFs11ErzPWRInDf8IrnmxO5348WsF9JgWp3wIQ3Xsrw5csqooCXk8fB4FCPIWaLVLPy4Tkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256120; c=relaxed/simple;
	bh=yLs+Xo690comw1LoWUvj81s9RThv69OGjwhLOBSOFbk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DO5IDCWRI+vNbVd883FWIREkoxslu0MJbiUfeivRtUyE9EETklIKqo6RnvW5gq9MiS1Qm8TM5GceA6avqFIGFxEZf3/+DviQpqBvcGfjkYpwZ219U11CUKuIYGLWtWaWUkSGCngxqY25x7lOzl84cpE3DKL/AJbIe4lnY5zAhkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQnOpBF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F189C4CEEB;
	Sun,  3 Aug 2025 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256120;
	bh=yLs+Xo690comw1LoWUvj81s9RThv69OGjwhLOBSOFbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vQnOpBF+VTwQZdNNTzj6Kz5vZRgSByopEXG9qK2aH+KCVRbhPL5APULzYeUIeBQcM
	 mI5CXIdR2x9l6bbgpq0H2NVT8/4e8luQakZmBiP9BGRd6dUTDG6gfIo6PQYXuSKcbp
	 BGqEDCkxDB0s4B+3jilkB5QPuiA82LIHhqJI7BhEO+4t6C7Stl7gy8Eo79zR9ckVMi
	 SP0yIJSZXyxn8TNwdu3Fa1XVNKvH4R2+HKsdhfGJ1zXvKDLTHIoj7g2Rw7hKXGfktd
	 eJKAI4bkVyYDtRoLT3TvyvgfJ5oX16BUBscRHSCZTDRt4xM/NSJr2CfIiIiSi7BEv7
	 6zSQ/Bt8lg4Ag==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wei Gao <wegao@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 14/16] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Sun,  3 Aug 2025 17:21:24 -0400
Message-Id: <20250803212127.3548367-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212127.3548367-1-sashal@kernel.org>
References: <20250803212127.3548367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.147
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
index 5a32fcd55183..430ccd983491 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -860,9 +860,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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


