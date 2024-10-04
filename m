Return-Path: <linux-ext4+bounces-4497-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFF1990ED9
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A680B28CAB
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58EFE1DE2B8;
	Fri,  4 Oct 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEgaQ9vT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA91DE2A9;
	Fri,  4 Oct 2024 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066549; cv=none; b=B5H22sMvy/B3dQ/wgjh3zyJgGgqly2w73tJpLHuoEf510n9eib8QpkOeowxA1fOMF3a936MxGgbnmEQCYZXUjFobN9IVbZAlyJ57JYtGiYnMwwbEaB/GUsr8V/BWxC2trP8f/kwni1IcZpV5SMz+TMoE5Gum+j2azm2YJOJgM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066549; c=relaxed/simple;
	bh=7JAGd2FdWK2mfdAyFxwQJPr1XAo1toDa7D3LgXsCG4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSQ5VUBXR9yRvtJCm5DlDSidwYv84LIlLb87gW7E7/FV/wk1Gdw6sYybopyf9vS7z7LIQYcABquQ7mfJk5IdyDs0pcrJ8KFL9FhI1CDRmSlu39QgEdBokOTpUPTMjUDZsRBth74LRkjKWC3DMp2P9iBH2+HGagc1B1Pd7f+e3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEgaQ9vT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66A5C4CECD;
	Fri,  4 Oct 2024 18:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066548;
	bh=7JAGd2FdWK2mfdAyFxwQJPr1XAo1toDa7D3LgXsCG4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IEgaQ9vToaX6OpFP6pehCAcEa5Ht4ht9ggYtmTZMNx9+H3Pc8VRMMYHsz+4Rk9E7j
	 NHDrFzv96I9SnapMVgBIZYDrXNoFyA3ICCTpx5pGb2dgHH+TsCK825GGbXA0ZNJD8Q
	 GusNOwEn3nJ6FcsDOnseH7YHwBteEWFXyGeQ4nIpWGMPMk9bYZ1cpoYxnYxtSzHGzv
	 WpuEE0bCoTm7CHjK1YYPAi4XrmqFra9QfdYWVK8lUBLTW3PV3wH9FkEFYmF0UFlDtm
	 a0WFM1VfL6tXryzxCz4NLmUeHoWuQSfECAJ+LiWMPHV8mM2Tnao3FJECJ2boG2DLwg
	 /QkzY3NC3WUig==
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
Subject: [PATCH AUTOSEL 5.15 07/31] ext4: avoid use-after-free in ext4_ext_show_leaf()
Date: Fri,  4 Oct 2024 14:28:15 -0400
Message-ID: <20241004182854.3674661-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182854.3674661-1-sashal@kernel.org>
References: <20241004182854.3674661-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.167
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
index a3869e9c71b91..1e52f90ddee43 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3288,7 +3288,7 @@ static int ext4_split_extent_at(handle_t *handle,
 }
 
 /*
- * ext4_split_extents() splits an extent and mark extent which is covered
+ * ext4_split_extent() splits an extent and mark extent which is covered
  * by @map as split_flags indicates
  *
  * It may result in splitting the extent into multiple extents (up to three)
@@ -3365,7 +3365,7 @@ static int ext4_split_extent(handle_t *handle,
 			goto out;
 	}
 
-	ext4_ext_show_leaf(inode, path);
+	ext4_ext_show_leaf(inode, *ppath);
 out:
 	return err ? err : allocated;
 }
@@ -3831,14 +3831,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
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
@@ -3935,7 +3934,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
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


