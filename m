Return-Path: <linux-ext4+bounces-4476-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4C990B0D
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B854AB241AE
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A9C219490;
	Fri,  4 Oct 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kr6lfbfN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B10F1DACB0;
	Fri,  4 Oct 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065931; cv=none; b=h2O32DvYOiaAm1Os8dqw2g+PiWy3m4dmLj2kgmm6OcGtliJlDejfgLNVcwybupawRgWcNHMS+qIWTRuvJmBhhDTSA0/n+QSJYR2+GzUopcuSN3oWQjcg8IRBusIqzv+DiWOpMpeJDgEKBrkjT5eGHinunN9QKNlT2uiM85BFDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065931; c=relaxed/simple;
	bh=0dY/Rn2LCkVFNFRPdOEhLz+OBcsB+K2jKeSvCLpQWm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jl6O7Nfqcgpp1p3XsjlFNH0GuyJ4U1n5yB+dHoBoGUDT0bZK/5I2umNt5NRULLBKb7PJn8eUZuq2XnqxU7iDKDIwFEEHaZelccOi51PMXh1dcEkyVfvgOk1gimvehd/J1t5i7rKlN48QtfQ5VO40QETpUCHCSLTnfyduGPnGvDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kr6lfbfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AD0C4CECE;
	Fri,  4 Oct 2024 18:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728065931;
	bh=0dY/Rn2LCkVFNFRPdOEhLz+OBcsB+K2jKeSvCLpQWm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kr6lfbfN6g7kv+9F78abtHCqoCjf29R130tQBWlUfRa8VSOl0PL0Z9UK/UbEldd96
	 KUFOjACjC+BgW4KgmtxVACT+r8r0VF6fO+rgkICTQj2FQq6wl6sFdqCNiol2/06cHl
	 d/7Ivz3OGl4JyHs1/mpwsvBGR9nD6jAKjUGT/0LUM2TNvXfsJSsAtROT/tBmEYoB9U
	 s9Fi3iBPSccqfcXFU5HSLEl3Nms9lo2HcyNa5ZK6OsVQVzBpLvrj882w7bh07Xbo39
	 m1CjOAYiM0BGeA4Xpq6DRJ26j2CMb21B8QqG7ygkM8SJeIDMhcTVZjxpRqyXXRAHBD
	 AEAajx0fsSIwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 12/76] ext4: avoid use-after-free in ext4_ext_show_leaf()
Date: Fri,  4 Oct 2024 14:16:29 -0400
Message-ID: <20241004181828.3669209-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004181828.3669209-1-sashal@kernel.org>
References: <20241004181828.3669209-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.2
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 4e2524ba2ca5f54bdbb9e5153bea00421ef653f5 ]

In ext4_find_extent(), path may be freed by error or be reallocated, so
using a previously saved *ppath may have been freed and thus may trigger
use-after-free, as follows:

ext4_split_extent
  path = *ppath;
  ext4_split_extent_at(ppath)
  path = ext4_find_extent(ppath)
  ext4_split_extent_at(ppath)
    // ext4_find_extent fails to free path
    // but zeroout succeeds
  ext4_ext_show_leaf(inode, path)
    eh = path[depth].p_hdr
    // path use-after-free !!!

Similar to ext4_split_extent_at(), we use *ppath directly as an input to
ext4_ext_show_leaf(). Fix a spelling error by the way.

Same problem in ext4_ext_handle_unwritten_extents(). Since 'path' is only
used in ext4_ext_show_leaf(), remove 'path' and use *ppath directly.

This issue is triggered only when EXT_DEBUG is defined and therefore does
not affect functionality.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-5-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335c..7954430f886d8 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3287,7 +3287,7 @@ static int ext4_split_extent_at(handle_t *handle,
 }
 
 /*
- * ext4_split_extents() splits an extent and mark extent which is covered
+ * ext4_split_extent() splits an extent and mark extent which is covered
  * by @map as split_flags indicates
  *
  * It may result in splitting the extent into multiple extents (up to three)
@@ -3363,7 +3363,7 @@ static int ext4_split_extent(handle_t *handle,
 			goto out;
 	}
 
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out:
 	return err ? err : allocated;
 }
@@ -3828,14 +3828,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 			struct ext4_ext_path **ppath, int flags,
 			unsigned int allocated, ext4_fsblk_t newblock)
 {
-	struct ext4_ext_path __maybe_unused *path = *ppath;
 	int ret = 0;
 	int err = 0;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
 		  (unsigned long long)map->m_lblk, map->m_len, flags,
 		  allocated);
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 
 	/*
 	 * When writing into unwritten space, we should not fail to
@@ -3932,7 +3931,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	if (allocated > map->m_len)
 		allocated = map->m_len;
 	map->m_len = allocated;
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out2:
 	return err ? err : allocated;
 }
-- 
2.43.0


