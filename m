Return-Path: <linux-ext4+bounces-7697-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04259AAAF1A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF4877B1B52
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 03:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD5E3B0A0C;
	Mon,  5 May 2025 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLy9c0Xf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B4528152D;
	Mon,  5 May 2025 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486300; cv=none; b=cucn9cSk9+86ykXEZ1CyLU1+Uf4rDkFHDoIFQFrGpgelu46K5T76qsBb1uZH/2OvshWSZpnRxlliiFJiz0rFFVMLhI9NyR2w7/xj2Rp/Qq6I8TK8Z0+jqDg00uqMRsXKO+QRWrMzxlOTTqZklCHLqE6g/nAZfwoEWT6ncXVks9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486300; c=relaxed/simple;
	bh=mEdk8wNwFMaBiA/xZ4GWQaf/cVHfpSJsFqr1MvmX5U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DeYDNNlU4WfofpuSJK0fjUGQl99eRqu1fpfNXi6zGZ8US9nohSVbBsDgkuYWTMdTtNhJaNyxfyurI3Ucx5CdJeSuHbwdrz7v0bZeXo841AekZyyg1B24Lkw1iottLTa4kXCzW76CAShs1cApsYJtLFAj6yJJlo6TG4Pr3Yt/Qs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLy9c0Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B227CC4CEEF;
	Mon,  5 May 2025 23:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486300;
	bh=mEdk8wNwFMaBiA/xZ4GWQaf/cVHfpSJsFqr1MvmX5U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLy9c0Xfxe1ySbGjGK3cYnHEXZmEF/B1xnwdZhnQH97i5rEIM/rkrxJXjSqgoTVrv
	 K1LLv6z2tm2TzWDCsa0nUKwOHPXYgs6Uv5iwRzrmmd48c1UDtnM4J5ZpHldXqIB+4K
	 WRhxSU/kyke5BX8uTkq2cYLyfKV5hNll0Ng1pYO/dpg6y/Pb+Y5J3VwH1zl1ndUOwQ
	 kmMZs+C6nPsXaFgLaEpRD90IpBSUSOA/qR+hOQ0Fx4tY33uh/Xxzd5cVm4Air1sUt6
	 fzgCX3KM/zbeynu6Tq0ttwA4pv1QqXth6deI9eUJ/Kt02P7vtKRr017MUmXKcz4v4K
	 Y6L0Uwiyk+gsw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 246/294] ext4: don't write back data before punch hole in nojournal mode
Date: Mon,  5 May 2025 18:55:46 -0400
Message-Id: <20250505225634.2688578-246-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 43d0105e2c7523cc6b14cad65e2044e829c0a07a ]

There is no need to write back all data before punching a hole in
non-journaled mode since it will be dropped soon after removing space.
Therefore, the call to filemap_write_and_wait_range() can be eliminated.
Besides, similar to ext4_zero_range(), we must address the case of
partially punched folios when block size < page size. It is essential to
remove writable userspace mappings to ensure that the folio can be
faulted again during subsequent mmap write access.

In journaled mode, we need to write dirty pages out before discarding
page cache in case of crash before committing the freeing data
transaction, which could expose old, stale data, even if synchronization
has been performed.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-4-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inode.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d3d28e6587202..456f686136fc5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3946,17 +3946,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
 
-	/*
-	 * Write out all dirty pages to avoid race conditions
-	 * Then release them.
-	 */
-	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY)) {
-		ret = filemap_write_and_wait_range(mapping, offset,
-						   offset + length - 1);
-		if (ret)
-			return ret;
-	}
-
 	inode_lock(inode);
 
 	/* No need to punch hole beyond i_size */
@@ -4018,8 +4007,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ret = ext4_update_disksize_before_punch(inode, offset, length);
 		if (ret)
 			goto out_dio;
-		truncate_pagecache_range(inode, first_block_offset,
-					 last_block_offset);
+
+		ret = ext4_truncate_page_cache_block_range(inode,
+				first_block_offset, last_block_offset + 1);
+		if (ret)
+			goto out_dio;
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-- 
2.39.5


