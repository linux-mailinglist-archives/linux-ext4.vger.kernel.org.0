Return-Path: <linux-ext4+bounces-12233-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19400CAE79F
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 01:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA1A33086CD4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3F521ABB1;
	Tue,  9 Dec 2025 00:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2IiGgCH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F91FE46D;
	Tue,  9 Dec 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239401; cv=none; b=Iw7hZCH4K0TbbLNvML1f2YhPjPZm9lm60689VYDLiDgzn5mHeHhJ6a8SzUDNXqSEdT6mdBOAUHyqtWlbxQhdhQ/hhI2ApeD7TLT4ZkxKszBxpE81gvkS2EjjzJsh2rmk6+Futs62+fC+TxXKuFkdWmGZ0YhTkAfBUgSfeputIzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239401; c=relaxed/simple;
	bh=Rh5T24gHp56T5+pc8Y3Rj0uE8gPFKqUYZ477cBxXgy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hc2fPKwpS31ltNUoz9sKfkW5VMLcmEW+0KD6xOoqWxdxaCg9Di1uh3CEuqV9KI+2dcBL4rMcVpERM3mRJKcIv331nyRE76kjJqyq1PWuy88pVLalXB/nPiAs73Q/oSQFkEQU4RfaK7tTZDmy7tG8ohfgP6HpkRv79a8sgFiMUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2IiGgCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010AEC4CEF1;
	Tue,  9 Dec 2025 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765239400;
	bh=Rh5T24gHp56T5+pc8Y3Rj0uE8gPFKqUYZ477cBxXgy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P2IiGgCHr3Mt18bZ/NEHj46SMa+CXmt7J6lbM+m1hKBs7Ifx8aO/hkC3KR4wF0Q/N
	 FRp15rCSXqzw7l8V7zl78mYZXAkCdEEUO71M4aR+RtdgVMpAxdl9/hwKgzWZTlzSpQ
	 pwM0zfHYjPGIXwxNLNN5C7KaQGgK49O6L4uQZEcr6RlY6FBnXJLYUcDDl3LVXxst8n
	 pLk9l1IUMaQccK9dZdTJi+zU8dSa8gqKQ7CsNqzEp+T9+MycznltDZe0JnkEMTcvux
	 37kFlNr2BeZ7T0JeIzNd+tlGYy2Xq1NhqJQCeDaSrDQNHnFMNhVXybjjoa24QD0FHj
	 Rt0QPVKgwpEjA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhihao Cheng <chengzhihao1@huawei.com>,
	Baokun Li <libaokun1@huawei.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] ext4: remove page offset calculation in ext4_block_zero_page_range()
Date: Mon,  8 Dec 2025 19:14:56 -0500
Message-ID: <20251209001610.611575-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209001610.611575-1-sashal@kernel.org>
References: <20251209001610.611575-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit 5835b1339e33549d9e7342fae56243b4fcd758c9 ]

For bs <= ps scenarios, calculating the offset within the block is
sufficient. For bs > ps, an initial page offset calculation can lead to
incorrect behavior. Thus this redundant calculation has been removed.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Message-ID: <20251121090654.631996-2-libaokun@huaweicloud.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: ext4_block_zero_page_range() page offset calculation
fix

### 1. COMMIT MESSAGE ANALYSIS

The commit removes a page offset calculation in
`ext4_block_zero_page_range()`. Key points from the message:
- For bs <= ps (block size <= page size): calculating block offset alone
  is sufficient
- For bs > ps (block size > page size): the page offset calculation
  leads to "incorrect behavior"
- The calculation is described as "redundant"

**Notable tags:**
- Multiple `Reviewed-by:` tags including **Jan Kara** (ext4 maintainer)
  and other ext4 experts
- **No `Cc: stable@vger.kernel.org`** tag
- **No `Fixes:` tag**

### 2. CODE CHANGE ANALYSIS

```c
- unsigned offset = from & (PAGE_SIZE-1);
        unsigned blocksize = inode->i_sb->s_blocksize;
- unsigned max = blocksize - (offset & (blocksize - 1));
+       unsigned int max = blocksize - (from & (blocksize - 1));
```

**The Bug:**
The old code first calculates `offset = from & (PAGE_SIZE-1)` (offset
within the page), then uses this to calculate the remaining bytes in the
block.

For **bs > ps** (e.g., 16K blocks on 4K pages):
- `offset` gets truncated to 0-4095 range (page offset)
- When calculating `offset & (blocksize - 1)`, the higher bits of the
  block offset are lost
- Example: `from = 5000` with 8K blocks → `offset = 904` (wrong), should
  use `5000 & 8191 = 5000`
- This results in calculating the wrong `max` value for how much data to
  zero

**Impact:** This function is called during truncate operations to zero
partial blocks. A wrong `max` calculation could:
- Zero the wrong range of data (data corruption)
- Not zero enough data (potential data leak of old file contents)

### 3. CLASSIFICATION

- **Type:** Bug fix (incorrect calculation for bs > ps configurations)
- **Subsystem:** ext4 filesystem (critical)
- **Not a feature addition** - purely corrective

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 3 (removes 2 lines, modifies 1)
- **Files touched:** 1 (fs/ext4/inode.c)
- **Complexity:** Very low - simple arithmetic correction
- **Risk:** Very low
  - For bs > ps: Fixes the bug
  - For bs <= ps: Mathematically equivalent behavior (no change)

### 5. USER IMPACT

- **Who's affected:** Users with bs > ps ext4 configurations (large
  block filesystems)
- **Severity:** Potential data corruption during truncate operations -
  HIGH severity for affected users
- **Configuration rarity:** bs > ps is less common but becoming more
  relevant for large storage
- **For normal configurations (bs <= ps):** No behavior change, just
  cleaner code

### 6. STABILITY INDICATORS

- **Reviewed-by:** Jan Kara (ext4 maintainer), Zhang Yi, Ojaswin Mujoo -
  strong expert review
- **Sign-offs:** Multiple Huawei engineers plus Ted Ts'o (ext4
  maintainer)

### 7. DEPENDENCY CHECK

The fix is self-contained. It only changes how the `max` variable is
calculated using local variables. No dependencies on other commits.

### CONCERNS

1. **No explicit stable tag** - Maintainers didn't explicitly request
   stable backport
2. **No Fixes: tag** - Can't trace when the bug was introduced
3. **bs > ps support** is relatively recent, so older stable kernels may
   not benefit
4. **Vague description** - "incorrect behavior" isn't specific about
   user-visible symptoms

### RISK VS BENEFIT

**Benefits:**
- Fixes a real bug that could cause data corruption in ext4
- Trivially correct fix (just use `from` directly instead of page-
  truncated offset)
- Zero risk of regression for bs <= ps (same behavior)
- Expert reviewed by ext4 maintainers

**Risks:**
- Minimal - the fix is mathematically obvious
- Only changes behavior for bs > ps where the old behavior was wrong

### CONCLUSION

This is a correctness fix for ext4 filesystem that addresses a real bug
in bs > ps configurations. The change is:
- Small and surgical (3 lines)
- Obviously correct (direct calculation vs. lossy intermediate step)
- Low risk (no behavior change for common configurations)
- Expert reviewed by multiple ext4 maintainers

However, the lack of explicit `Cc: stable` or `Fixes:` tags suggests the
maintainers may not have considered this critical for stable. The bs >
ps feature is also relatively new, limiting which stable kernels would
benefit.

Given that it fixes a potential data corruption issue in a critical
filesystem with minimal risk, and the fix has been thoroughly reviewed,
it is a reasonable candidate for backporting to stable kernels that
support bs > ps ext4 configurations.

**YES**

 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47ce..0742039c53a77 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4157,9 +4157,8 @@ static int ext4_block_zero_page_range(handle_t *handle,
 		struct address_space *mapping, loff_t from, loff_t length)
 {
 	struct inode *inode = mapping->host;
-	unsigned offset = from & (PAGE_SIZE-1);
 	unsigned blocksize = inode->i_sb->s_blocksize;
-	unsigned max = blocksize - (offset & (blocksize - 1));
+	unsigned int max = blocksize - (from & (blocksize - 1));
 
 	/*
 	 * correct length if it does not fall between
-- 
2.51.0


