Return-Path: <linux-ext4+bounces-9270-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7492DB1B471
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC5D1701DC
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F72749E5;
	Tue,  5 Aug 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+SHiPw1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9819278768;
	Tue,  5 Aug 2025 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399482; cv=none; b=fcQbkaU/jdDBqAEAk7gc1aHugzp/uv3K6J5FIy70NEoSNxZfu3/8GiHvFwZRanoY7JeML21s7g0AMMagfjQrZFcKJWeDm0RwbDPrnqkViMzF/HE/4FD41mjo36c4Kl4I+JKD2AzjdQH59Ou+ZY82aOM/XBQulE+CHE5G1gfAFaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399482; c=relaxed/simple;
	bh=2XphjJhZ3No9vA3wznCk3klDKiFZpEzPjrTATkENw8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hKYSwZiVPtPZHhsTaAJANoEcipDNhsKNQPLypmltEl3bNIz+7VNxA4NdhNiOvtB2+ydGWJoXac8lofvkzfpdoyYCKgkSxaTurRjmlfoRaCVMgJ7Rc3KrzUqyQ2KwQ/8qiuulnjBH0DrCr/grN+sRg+0UyAtENjXKhrQzeLQtRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+SHiPw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E50EC4CEF9;
	Tue,  5 Aug 2025 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399482;
	bh=2XphjJhZ3No9vA3wznCk3klDKiFZpEzPjrTATkENw8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D+SHiPw1jWUEe00EHnORyXP2TEPeZAiJ18bjW55NsPLFuAeYb+CB8q20cAD8Qa/nL
	 klAOfCsc37ct07Zl1hP7VyR3gBq8huo9cY94kKOxpHUYKhLhXNiPR8SFPFHHqJ6GJB
	 bHYWJH6KQwFEJ4or10CgGbUx2u2ZyAvP3Y5cxIBpPBFCTsthOEXgK+nuJ+DB+5NXFe
	 gLtQTP/a1Gt19vAc14TF/7w03/Of2MVV+wxlhVIFjocpRvlX6pok+qbZYEK+2IIP+f
	 lbc/48Ca7Zr9VYk4zRSQFREQdBS9wslPzl2m1ErtWrgIRnGoZmaMCi9tuKiGJl/oVZ
	 FOiIShC2qLgyA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-5.4] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
Date: Tue,  5 Aug 2025 09:09:19 -0400
Message-Id: <20250805130945.471732-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250805130945.471732-1-sashal@kernel.org>
References: <20250805130945.471732-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Transfer-Encoding: 8bit

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42 ]

A syzbot fuzzed image triggered a BUG_ON in ext4_update_inline_data()
when an inode had the INLINE_DATA_FL flag set but was missing the
system.data extended attribute.

Since this can happen due to a maiciouly fuzzed file system, we
shouldn't BUG, but rather, report it as a corrupted file system.

Add similar replacements of BUG_ON with EXT4_ERROR_INODE() ii
ext4_create_inline_data() and ext4_inline_data_truncate().

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Critical Bug Fix
1. **Fixes kernel BUG_ON crashes**: The commit replaces three BUG_ON()
   calls with proper error handling using EXT4_ERROR_INODE() and
   returning -EFSCORRUPTED. This prevents kernel panics when
   encountering corrupted filesystem metadata.

2. **Security/Stability improvement**: The issue was found by syzbot
   fuzzing, indicating it can be triggered by maliciously crafted
   filesystems. Converting BUG_ON to error handling prevents denial-of-
   service attacks where a corrupted filesystem image could crash the
   entire system.

## Meets Stable Criteria
1. **Small and contained fix**: The changes are minimal - only replacing
   BUG_ON statements with proper error checks in three locations within
   fs/ext4/inline.c:
   - Line 306 in ext4_create_inline_data()
   - Line 357 in ext4_update_inline_data()
   - Line 1871 in ext4_inline_data_truncate()

2. **Clear bug fix without new features**: This is purely a bug fix that
   handles filesystem corruption gracefully instead of crashing. No new
   functionality is added.

3. **Low regression risk**: The change follows established patterns in
   ext4 - the file already uses EXT4_ERROR_INODE() and -EFSCORRUPTED in
   similar situations (line 168-170). The error handling is consistent
   with how ext4 handles corruption elsewhere in the codebase.

4. **Important for users**: Any user mounting potentially corrupted ext4
   filesystems (from damaged media, malicious sources, or fuzzing) could
   encounter these BUG_ONs. Converting them to proper error handling
   significantly improves system stability.

## Code Analysis
The patch correctly:
- Replaces `BUG_ON(!is.s.not_found)` with a check that reports
  corruption and returns -EFSCORRUPTED when the xattr should be absent
  but is found
- Replaces `BUG_ON(is.s.not_found)` with a check that reports corruption
  when the xattr should exist but is missing
- Uses the same error reporting pattern (EXT4_ERROR_INODE) that ext4
  uses throughout for filesystem corruption cases
- Properly propagates the error up the call chain via the existing error
  handling paths

This is a textbook example of a stable-worthy fix: it addresses a real
crash issue found by fuzzing, uses minimal changes, follows existing
code patterns, and significantly improves system reliability when
dealing with corrupted filesystems.

 fs/ext4/inline.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1bbcdf40824..fa6668126fd7 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -303,7 +303,11 @@ static int ext4_create_inline_data(handle_t *handle,
 	if (error)
 		goto out;
 
-	BUG_ON(!is.s.not_found);
+	if (!is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "unexpected inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 	if (error) {
@@ -354,7 +358,11 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	BUG_ON(is.s.not_found);
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
 	value = kzalloc(len, GFP_NOFS);
@@ -1903,7 +1911,12 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 
-			BUG_ON(is.s.not_found);
+			if (is.s.not_found) {
+				EXT4_ERROR_INODE(inode,
+						 "missing inline data xattr");
+				err = -EFSCORRUPTED;
+				goto out_error;
+			}
 
 			value_len = le32_to_cpu(is.s.here->e_value_size);
 			value = kmalloc(value_len, GFP_NOFS);
-- 
2.39.5


