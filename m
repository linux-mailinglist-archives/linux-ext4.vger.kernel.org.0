Return-Path: <linux-ext4+bounces-11084-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F217C097F8
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 18:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93F833A7AE4
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Oct 2025 16:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A59302752;
	Sat, 25 Oct 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pwl9V1JP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823852D24B7;
	Sat, 25 Oct 2025 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409296; cv=none; b=BzTB6be7Jtq9AaMTzIoFBesMswRHrLEGux+WulxskjglkGcAp/aC9OMHBt2ku6iBZ0kKQkFVxXqwLMSKxZDMinCROlqzGhsY/VR7j2AROiXLhfsX0zndAPusSX1+KcpC/WFJFt5OChX9dWdHRJ/d0Ye2EkGmj4YochrXi+VE+zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409296; c=relaxed/simple;
	bh=egU86SA9mAUyXclVs49FsqQ0ABKOM0Z4E5Cqe7moi2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nC2bSSwR9u4IvhKmaihjHDx/5sT2k9SBcB+iQIlffJ17UNyMbI6nIwbcyz7bdS6d4I5lLVl6NH3ujQPcUzZu+0CCVIJD4Kh5Jce2myAjz1Jw450n5yyvqKdS0OvfON6Ckxe28WwjEPw5kU6c0u8aKifO1IcA+mOqtVirwkIezkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pwl9V1JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1F9C2BC9E;
	Sat, 25 Oct 2025 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409296;
	bh=egU86SA9mAUyXclVs49FsqQ0ABKOM0Z4E5Cqe7moi2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pwl9V1JP8jJWmYrb1Xrxzum9/PuoAEJFKX2Fi5s4ZSSTp7qTtJRkkTmZcvH/wg/cA
	 WpTZZCGIdFhLcRUztd/XYldcUash4h8jFnEuyXN0mbDG1LJqKFC2vjzb4zbxcas1+e
	 gBtXSNbNkRyB58XvIgHGVqoi7U1FnD3l7re1sMjwQKMhkOHs3DHamieGicghfNN+lF
	 8Ydtn3ahXo5hIeCDYOyyaBEFKYG7n7U3LN3MWBH1urYIpZD2Dv1KtE7b6FKkDlTIpK
	 SkHK6fmloy3Wte5/39mUsV05kRToGcZTfMnXkmY95fmKuV4wAvTU1hsUJ0NL/k2thP
	 BGc7Iki03Wo4w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: chuguangqing <chuguangqing@inspur.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.10] fs: ext4: change GFP_KERNEL to GFP_NOFS to avoid deadlock
Date: Sat, 25 Oct 2025 11:58:17 -0400
Message-ID: <20251025160905.3857885-266-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: chuguangqing <chuguangqing@inspur.com>

[ Upstream commit 1534f72dc2a11ded38b0e0268fbcc0ca24e9fd4a ]

The parent function ext4_xattr_inode_lookup_create already uses GFP_NOFS for memory alloction, so the function ext4_xattr_inode_cache_find should use same gfp_flag.

Signed-off-by: chuguangqing <chuguangqing@inspur.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
- In `fs/ext4/xattr.c:1538` the patch switches the `kvmalloc(value_len,
  …)` allocation in `ext4_xattr_inode_cache_find()` from `GFP_KERNEL` to
  `GFP_NOFS`. This path runs while `ext4_xattr_set_handle()` already
  holds the xattr write lock and has an active jbd2 handle that set
  `PF_MEMALLOC_NOFS` (see `fs/ext4/xattr.c:2342` and the `WARN_ON_ONCE`
  directly above the allocation at `fs/ext4/xattr.c:1528`). Keeping
  `__GFP_FS` in this context lets direct reclaim re-enter ext4 and wait
  on the same locks, producing the deadlocks and lockdep splats the
  warning is trying to highlight.
- The new flag matches the rest of the call chain:
  `ext4_xattr_inode_lookup_create()` subsequently inserts into the
  mbcache with `GFP_NOFS` (`fs/ext4/xattr.c:1604`), so this change makes
  the cache lookup/allocation path consistent and eliminates the only
  remaining `GFP_KERNEL` allocation while the NOFS guard is active.
- This is a one-line, well-scoped bug fix that simply narrows allocator
  context; it cannot change behaviour outside the reclaim path, but it
  removes a real hang risk seen under memory pressure during xattr
  updates. There are no prerequisite refactors or API changes, so the
  patch is safe to carry into stable branches whenever
  `ext4_xattr_inode_cache_find()` exists.

Natural next step: after backporting, run the ext4 xattr fstests (e.g.
generic/030, generic/031) under memory pressure to confirm the deadlock
no longer reproduces.

 fs/ext4/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b0e60a44dae9d..ce7253b3f5499 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1535,7 +1535,7 @@ ext4_xattr_inode_cache_find(struct inode *inode, const void *value,
 	WARN_ON_ONCE(ext4_handle_valid(journal_current_handle()) &&
 		     !(current->flags & PF_MEMALLOC_NOFS));
 
-	ea_data = kvmalloc(value_len, GFP_KERNEL);
+	ea_data = kvmalloc(value_len, GFP_NOFS);
 	if (!ea_data) {
 		mb_cache_entry_put(ea_inode_cache, ce);
 		return NULL;
-- 
2.51.0


