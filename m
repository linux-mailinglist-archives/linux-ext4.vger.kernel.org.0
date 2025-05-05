Return-Path: <linux-ext4+bounces-7699-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD75AAB1F0
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4A04A761F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF59379A5B;
	Tue,  6 May 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfUWDlLb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4022D47D4;
	Mon,  5 May 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485647; cv=none; b=QtaFD20fycSacrBEgAxrJClQt/3BoIuewQRFh9Xulhqq36BLsp4pLjToA1Zly3WYC6D9mPqEVzgy6CHMt99Fq2C06+4ih9x+HDjA6Hc7FNIRLZV7EgO7A0j82x+XRXPy3UB2YEYQVOeTxwff9sHcOCEBoMaZlYb7fCFtc92+BhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485647; c=relaxed/simple;
	bh=8a8lKG343Ye79VxVqSMDe+cPcdo5ypZNXs3TqFfTx5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EpYX4ZlkLXEBQGPXvFWj/+IJF93tjW9e7ZI1+cHi0fBmZ79o/K6D4vF1Cf5xI1yS9sug+z/OxOo0G7AVc9XvF5uM/G1/rsAEEBxzUbhkO3FoW8xoHIZVbyVR+lG7S31CqZCxsl7C8qKsjMX3aC1an7dD5Wf2TEsf/R4pP1gSUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfUWDlLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF35C4CEEE;
	Mon,  5 May 2025 22:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485646;
	bh=8a8lKG343Ye79VxVqSMDe+cPcdo5ypZNXs3TqFfTx5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZfUWDlLbqzUUAXLRZibib9bIFWtbKE9CKOD2zWMkwo+xMXx+YUqmyDLRZpTFE1VQY
	 Bd4TCzDnkqeFgEvN0vxFZMRDeIewDQq8ltKWkCVXuRFi2ZD51Py5oe42qduqJspe+f
	 EoS2NQwP5XJYBC2nP+q9kUIL8K8KxmPFmfS3GMq6kVRaqBMSiFrvm59zvGy2BD4g+R
	 d5pdVZQPWevIK2DFJ/x7R71CAGe5/Y/nMDFUsA+3srCGSTjmthQ0tvM++G4kiIO+Ul
	 T3b62ag/GXZAJNpysUSTV6K4ZZwZlJ9xxzO6hYv0LKQ118ii2yLrpi7TsZv1jaNy8t
	 YplOQTPZE0Nhg==
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
Subject: [PATCH AUTOSEL 6.12 403/486] ext4: don't write back data before punch hole in nojournal mode
Date: Mon,  5 May 2025 18:37:59 -0400
Message-Id: <20250505223922.2682012-403-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 487d9aec56c9d..819be57bb4ecf 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3933,17 +3933,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
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
@@ -4005,8 +3994,11 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
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


