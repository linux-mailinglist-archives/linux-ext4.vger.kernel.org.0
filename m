Return-Path: <linux-ext4+bounces-9269-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4065CB1B43F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 15:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D5F18A42BC
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Aug 2025 13:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84187276059;
	Tue,  5 Aug 2025 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0zgwUWF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E74B2749F8;
	Tue,  5 Aug 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399438; cv=none; b=DwwYPlCdSWDLtWOZSXd+Av/TyX8G7EzCzYqUHN5zkrMTotOYZhNVd6wi0owPF4vEn76WkFoVo86Uum9uU+hWRf3j1AbVLxoKVHAsklxU7uBmQ2MTdaD4DItJXKL9cVUYrnlWD/Z1Uuh/WwP1KFmZ04xFe+OGYgMRPPCEkQIYdIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399438; c=relaxed/simple;
	bh=Wpa1Pd2sU1RyHS8bDSx//SJZnplORfSm5q5SQzW4zZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YsoEzWXS3M7s1qCLiwTu/8mrQwrnIvUf/H1TQwaNLyr0GAgcEyWPxNmel2FFETETGhHrXQwqhGzbSqfcJSHH2mIuPaI8SzRCslwc0BoCNZyMnNjCBjsDhPsgLueIieO+u3B/05kpSdyF+OixaiWo0wj1OBvLGFU+fQHtiehQSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0zgwUWF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF9FC4CEF0;
	Tue,  5 Aug 2025 13:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399436;
	bh=Wpa1Pd2sU1RyHS8bDSx//SJZnplORfSm5q5SQzW4zZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0zgwUWFKdw/S0dbQHUnTLum31JbfRbSlOyUnnRs9EFjJrjN7TUHMi2y99lE3HH4R
	 mOaGGTaoAQ3IDxL6Q9pG0cRQrfyIAD8R0STNcladtowbVQV0tgiDJDCKmT7AFlVnSM
	 2hoUALR+WIYPdAr0OBMHmAEQjNLvfFVUukc3XsTpoCgD1OqlBTEDp5Ubb2qjvWGRaB
	 5ZQp8Uu4ps2IxT/mS/ZBIFQTKuaF7z/W3s1EyvAvEh2CBRKbge5npfELF+pAh3p2yu
	 S82erzS71ZCTr3N/JqYnHBdJaSvkwUxDvz2/Ep01I5RAUHIpisVnmJTOyXMcMCHlUk
	 EX/qV2X5uVGUg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Joseph Qi <jiangqi903@gmail.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16] ext4: limit the maximum folio order
Date: Tue,  5 Aug 2025 09:08:57 -0400
Message-Id: <20250805130945.471732-22-sashal@kernel.org>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit b12f423d598fd874df9ecfb2436789d582fda8e6 ]

In environments with a page size of 64KB, the maximum size of a folio
can reach up to 128MB. Consequently, during the write-back of folios,
the 'rsv_blocks' will be overestimated to 1,577, which can make
pressure on the journal space where the journal is small. This can
easily exceed the limit of a single transaction. Besides, an excessively
large folio is meaningless and will instead increase the overhead of
traversing the bhs within the folio. Therefore, limit the maximum order
of a folio to 2048 filesystem blocks.

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Reported-by: Joseph Qi <jiangqi903@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/CA+G9fYsyYQ3ZL4xaSg1-Tt5Evto7Zd+hgNWZEa9cQLbahA1+xg@mail.gmail.com/
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250707140814.542883-12-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

## Bug Fix Nature
The commit fixes a critical issue where ext4 could exhaust journal space
on systems with 64KB page sizes. The commit message explicitly states:
"Consequently, during the write-back of folios, the 'rsv_blocks' will be
overestimated to 1,577, which can make pressure on the journal space
where the journal is small. This can easily exceed the limit of a single
transaction."

## Real-World Impact
1. **Reported by multiple users**: The commit includes two Reported-by
   tags and a Closes link to a bug report, indicating this is affecting
   real users in production environments
2. **Specific environment failure**: The issue manifests on systems with
   64KB page sizes (common on ARM64 systems), where large folios can
   reach 128MB, causing journal transaction limits to be exceeded

## Minimal and Safe Fix
The fix is clean and contained:
1. **Limited scope**: Changes only affect folio order calculation for
   ext4 filesystems
2. **Conservative approach**: Limits maximum folio order to 2048
   filesystem blocks using the formula `(11 + (i)->i_blkbits -
   PAGE_SHIFT)`
3. **Function refactoring**: Converts `ext4_should_enable_large_folio()`
   from public to static and introduces `ext4_set_inode_mapping_order()`
   as a wrapper, maintaining clean interfaces

## Code Analysis
The changes show:
- Introduction of `EXT4_MAX_PAGECACHE_ORDER()` macro that caps folio
  size
- New function `ext4_set_inode_mapping_order()` using
  `mapping_set_folio_order_range()` instead of the previous
  `mapping_set_large_folios()`
- Updates to both inode allocation (fs/ext4/ialloc.c) and inode
  retrieval (fs/ext4/inode.c) paths

## Stability Considerations
1. **No new features**: This is purely a bug fix that prevents journal
   exhaustion
2. **Backward compatible**: The change doesn't break existing
   functionality
3. **Tested**: Has "Tested-by" tag from Joseph Qi
4. **Reviewed**: Has "Reviewed-by" tag from Jan Kara (experienced
   filesystem maintainer)

## Timeline Context
The large folio support was recently enabled in ext4 (commit
7ac67301e82f from May 2025), and this fix addresses a
regression/oversight in that implementation for systems with large page
sizes. This makes it critical to backport alongside or shortly after the
large folio enablement if that feature is backported.

The fix prevents potential filesystem hangs or write failures on
affected systems, making it an important stability fix for stable
kernels.

 fs/ext4/ext4.h   |  2 +-
 fs/ext4/ialloc.c |  3 +--
 fs/ext4/inode.c  | 22 +++++++++++++++++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 18373de980f2..fe3366e98493 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3020,7 +3020,7 @@ int ext4_walk_page_buffers(handle_t *handle,
 				     struct buffer_head *bh));
 int do_journal_get_write_access(handle_t *handle, struct inode *inode,
 				struct buffer_head *bh);
-bool ext4_should_enable_large_folio(struct inode *inode);
+void ext4_set_inode_mapping_order(struct inode *inode);
 #define FALL_BACK_TO_NONDELALLOC 1
 #define CONVERT_INLINE_DATA	 2
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 79aa3df8d019..df4051613b29 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1335,8 +1335,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_should_enable_large_folio(inode))
-		mapping_set_large_folios(inode->i_mapping);
+	ext4_set_inode_mapping_order(inode);
 
 	ext4_update_inode_fsync_trans(handle, inode, 1);
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..4f4fa62a3bff 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5106,7 +5106,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return -EFSCORRUPTED;
 }
 
-bool ext4_should_enable_large_folio(struct inode *inode)
+static bool ext4_should_enable_large_folio(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 
@@ -5123,6 +5123,22 @@ bool ext4_should_enable_large_folio(struct inode *inode)
 	return true;
 }
 
+/*
+ * Limit the maximum folio order to 2048 blocks to prevent overestimation
+ * of reserve handle credits during the folio writeback in environments
+ * where the PAGE_SIZE exceeds 4KB.
+ */
+#define EXT4_MAX_PAGECACHE_ORDER(i)		\
+		umin(MAX_PAGECACHE_ORDER, (11 + (i)->i_blkbits - PAGE_SHIFT))
+void ext4_set_inode_mapping_order(struct inode *inode)
+{
+	if (!ext4_should_enable_large_folio(inode))
+		return;
+
+	mapping_set_folio_order_range(inode->i_mapping, 0,
+				      EXT4_MAX_PAGECACHE_ORDER(inode));
+}
+
 struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 			  ext4_iget_flags flags, const char *function,
 			  unsigned int line)
@@ -5440,8 +5456,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 		ret = -EFSCORRUPTED;
 		goto bad_inode;
 	}
-	if (ext4_should_enable_large_folio(inode))
-		mapping_set_large_folios(inode->i_mapping);
+
+	ext4_set_inode_mapping_order(inode);
 
 	ret = check_igot_inode(inode, flags, function, line);
 	/*
-- 
2.39.5


