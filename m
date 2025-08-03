Return-Path: <linux-ext4+bounces-9261-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6085FB19644
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 23:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5564818948F1
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Aug 2025 21:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811F321B9C8;
	Sun,  3 Aug 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pV+yLmrW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218542CCC0;
	Sun,  3 Aug 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256159; cv=none; b=RDupOj0FBlZj8x9IPXGzRRM70tV/lRNMDvdrACEwNr+nmr7T3Pbn5QP6f+YRg1ddpLaIqaSViWzeIkSPZdmOKcX4z04Gmdfqq4knS9w6nfA7nNi1qYsnvwytPteJ8+rHEvQTcCKhUlaxazj9a2qAWJfl9LkMFK6a8/3a8UvudUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256159; c=relaxed/simple;
	bh=0MBPMqWo6hflx2hl+W73/KlPIaoharBePp4LsvPQYec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3OfFjOhyWobPdP9oWyLqBHYyZuLQumwcudynSgVxeVXytVKXlLvX0DRa2wbIlbYEQlcLSntnDgyIcGjZWF6iR2Bn6UpI4ZoJRocpPvkCsOVcePgHGwhBQwY5Ik+UcxnyXPX1KVLVXFz3SblTxatVDhofItdUnLeMfSoxzcvOa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pV+yLmrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88791C4CEEB;
	Sun,  3 Aug 2025 21:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256159;
	bh=0MBPMqWo6hflx2hl+W73/KlPIaoharBePp4LsvPQYec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pV+yLmrWgOMYAppzujBbxWa+5Uhq5wnj7oq0gLigHqv3ikOy7q8bjO62eOxRw1Tvt
	 J9I8JSPgufJHhC84FNMogyZtZARdNx+cRiJYeEWChETRuZ6CqMnfOlX/m0q/ZTK4Mp
	 1NLecI63PMTchu4cQHT+XSJ2Q3Wbj2cTnGs707nf5bCezW1v1zUw5PVjoJMeCqhdXn
	 2wCc4Kq0V4g0SfZuPEPdFX//3UZ9D626JZrz3t7ks6WLnW4cH/9JdViCCfVDG0ivEh
	 6J6i0GTpdcIpBqfoUxoScRw/L5zW2Nw1RklW48UJAWUcP8RgMS8ywsjB02+7NLWlXm
	 1FqI7AugjA+eA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Wei Gao <wegao@suse.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/15] ext2: Handle fiemap on empty files to prevent EINVAL
Date: Sun,  3 Aug 2025 17:22:04 -0400
Message-Id: <20250803212206.3548990-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212206.3548990-1-sashal@kernel.org>
References: <20250803212206.3548990-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.189
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
index 333fa62661d5..85b6a76378ee 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -856,9 +856,19 @@ int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
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


