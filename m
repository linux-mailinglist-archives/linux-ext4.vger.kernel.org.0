Return-Path: <linux-ext4+bounces-4487-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB1B990CF9
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF4E1F20C17
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E316A2019DB;
	Fri,  4 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxFF7u+s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C82019CE;
	Fri,  4 Oct 2024 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066322; cv=none; b=c1tKTejAFuvSFDUqcD1YRyg+yDjoenKT3QM3bgNMVIPsO0mFp70frjrhMc+7Sx0L05J8nibVm6DVA8zgW6zajDnY30B+kgOZdOQiXxJw3nEJtYV1kxCDUqYgOWTmn/rdI04GFtrHEHoudvcR5JFtnp+QCN8IGOLsRobm5XwxOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066322; c=relaxed/simple;
	bh=ABXu1moLoQqk7G5TDlS3pTXM1XjrRttZGTXeQ24IsdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+APQSjxW4Y+Jlpcc0LWvD3IWP44W+m87PeLSJzXmDALi1sPK5sASrO4QBi/9q1YQsa0aXXK98C/KNbTYuzWdAUQ5KjGF0dPM0d523GX3IcauyzVS/5G6/bbtpNq4UwCcbPREvovM4hQXDPgBp2tVeLihj4PqFP4+lLah33ICy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxFF7u+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D64C4CECC;
	Fri,  4 Oct 2024 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066322;
	bh=ABXu1moLoQqk7G5TDlS3pTXM1XjrRttZGTXeQ24IsdU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxFF7u+s48GJIu8AIXerVtamX8keckwqQ+mZtEqxNoBN6Ko2QinzSLzDTEDuOH9D3
	 EtwnQxqczYI2qpbXy4A07BKv+qVUraxN94Ym1Th8KEPZ8L5NZNQlDQHTwOpEnRwP0V
	 W6jP6r/2yEHcCAxOh1koRlTbAfG+RGFrtGTkSc99jqzCXpYPjoBKqdbHOJMB61W0MD
	 4nm2YY72ETy+7RlGu2MWk4yKgRE2XE7GDGlu5dacEbV72p3I869XUIqkPwJShyrlRg
	 gC4XiB1gII1OemUVb5z1uqqV2pQPXKRgxrSIA54ponA8hTELWZjTWzTo+9Q7SO+tk5
	 +vT983yShOHqg==
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
Subject: [PATCH AUTOSEL 6.6 10/58] ext4: avoid use-after-free in ext4_ext_show_leaf()
Date: Fri,  4 Oct 2024 14:23:43 -0400
Message-ID: <20241004182503.3672477-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 448e0ea49b31d..7fead53255fcb 100644
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


