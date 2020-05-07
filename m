Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0291C9850
	for <lists+linux-ext4@lfdr.de>; Thu,  7 May 2020 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgEGRuj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 May 2020 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGRui (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 May 2020 13:50:38 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDC6C05BD43
        for <linux-ext4@vger.kernel.org>; Thu,  7 May 2020 10:50:38 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h186so6568934qkc.22
        for <linux-ext4@vger.kernel.org>; Thu, 07 May 2020 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=beVSHuxzUgpdwjE8QkS0ewoa+jh68Ra7DMWA+fjxvUw=;
        b=UT2I8ct0X0Qpm0hD6ica2LI2/ujqJHTjmE+k9zzRBW6b7G9AfqpR8lcjWRk6zhZlKd
         yD5SAWv48q9WJ22McOEr/KyN6Cn1ttvJzHsdF1HlDyv4K3Xn01ahgTEEuxhaj7MS7bjO
         9JKAOFhc7tBFCqq8osjlKJwr97wMDaPVfGzjqhlqXdU0LSxmxaDad8OAj09bQIjicgrS
         IbnsnRkEQl3v4d+2mEPQzUAS6hOHONTHVAmDCtYtifttcEJxz3zvd8d7DAMAI3r01u9o
         X5Rr73BAY+G1J6T1LFuGVzYBD1TbE3Ini4AO1gmDmfbOVi9i83WscNBe5qYEPGSu/Hjd
         Oqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=beVSHuxzUgpdwjE8QkS0ewoa+jh68Ra7DMWA+fjxvUw=;
        b=qNptbYopFHsmsbCtvctc+4obIEclrVa9DYq/rl2vY7PKsU+LVVH0dY2QGFEisB+lrO
         E39Gb1DNC83FRmAnx15+lmlfOPW8JPzPsb2Zk1ab7EpsuPj6hKbujD4VhJwWtnf16Xcj
         FJKL4ybAs9nTDd/zW/hrMh6OraMEPmUwVgEgUr4dP44z5+/PqfgpLIFQhPoag0XZ5eKb
         MEkYB3I7p/ZnqLIhGAPtxOutwbM7CB4+w2n8/E53Q3skE6tOEIdP5dU5WnVRdnAJzBqk
         J2IU1xPqbT1CDBS58nRUYiiy6sHRpZ6m6+4sz6tkHeUPA2lQMX0Dm41yDkv7JQgfyhKx
         LDxA==
X-Gm-Message-State: AGi0PubqkO9UZ1pVMOwa0IeEBR6UcTTo0rpBOYnhGObtahkdyC1gPWNx
        t/IjoD1Jm+A0t87Z7vffzJA+681MtEWftmA=
X-Google-Smtp-Source: APiQypKGCB/EbxY8mDJJtKddlzt8v9I3dysx9RTrDtC4yebiC9NAhnf7vJ+o/pOFOS0EelfxwXvco19JdfDZDYw=
X-Received: by 2002:ad4:4e65:: with SMTP id ec5mr14655594qvb.32.1588873837428;
 Thu, 07 May 2020 10:50:37 -0700 (PDT)
Date:   Thu,  7 May 2020 10:50:28 -0700
Message-Id: <20200507175028.15061-1-pendleton@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH] ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
From:   Anna Pendleton <pendleton@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, Anna Pendleton <pendleton@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Theodore Ts'o <tytso@mit.edu>

We can't fail in the truncate path without requiring an fsck.
Add work around for this by using a combination of retry loops
and the __GFP_NOFAIL flag.

From: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Anna Pendleton <pendleton@google.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/extents.c | 43 +++++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 91eb4381cae5..af010f5009e4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -632,6 +632,7 @@ enum {
  */
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
+#define EXT4_EX_NOFAIL				0x10000000
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index f2b577b315a0..c2f665f8109e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -297,11 +297,14 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = *ppath;
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
+	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
+
+	if (nofail)
+		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
 	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
-			EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO |
-			(nofail ? EXT4_GET_BLOCKS_METADATA_NOFAIL:0));
+			flags);
 }
 
 static int
@@ -487,8 +490,12 @@ __read_extent_tree_block(const char *function, unsigned int line,
 {
 	struct buffer_head		*bh;
 	int				err;
+	int				gfp_flags = __GFP_MOVABLE | GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
@@ -838,6 +845,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
+	int gfp_flags = GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
@@ -858,7 +869,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	if (!path) {
 		/* account possible depth increase */
 		path = kcalloc(depth + 2, sizeof(struct ext4_ext_path),
-				GFP_NOFS);
+				gfp_flags);
 		if (unlikely(!path))
 			return ERR_PTR(-ENOMEM);
 		path[0].p_maxdepth = depth + 1;
@@ -1008,9 +1019,13 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
 	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
+	int gfp_flags = GFP_NOFS;
 	int err = 0;
 	size_t ext_size = 0;
 
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
+
 	/* make decision: where to split? */
 	/* FIXME: now decision is simplest: at current extent */
 
@@ -1044,7 +1059,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	 * We need this to handle errors and free blocks
 	 * upon them.
 	 */
-	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), GFP_NOFS);
+	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), gfp_flags);
 	if (!ablocks)
 		return -ENOMEM;
 
@@ -2020,7 +2035,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (next != EXT_MAX_BLOCKS) {
 		ext_debug("next leaf block - %u\n", next);
 		BUG_ON(npath != NULL);
-		npath = ext4_find_extent(inode, next, NULL, 0);
+		npath = ext4_find_extent(inode, next, NULL, gb_flags);
 		if (IS_ERR(npath))
 			return PTR_ERR(npath);
 		BUG_ON(npath->p_depth != path->p_depth);
@@ -2793,7 +2808,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
+		path = ext4_find_extent(inode, end, NULL,
+					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2879,7 +2895,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				le16_to_cpu(path[k].p_hdr->eh_entries)+1;
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
-			       GFP_NOFS);
+			       GFP_NOFS | __GFP_NOFAIL);
 		if (path == NULL) {
 			ext4_journal_stop(handle);
 			return -ENOMEM;
@@ -3300,7 +3316,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
+	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	depth = ext_depth(inode);
@@ -4353,7 +4369,14 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	}
 	if (err)
 		return err;
-	return ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+retry_remove_space:
+	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+	if (err == -ENOMEM) {
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		goto retry_remove_space;
+	}
+	return err;
 }
 
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
-- 
2.26.2.526.g744177e7f7-goog

