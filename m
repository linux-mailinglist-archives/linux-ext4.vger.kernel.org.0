Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A721A2BA1
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgDHV4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 17:56:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44588 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgDHVz7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 17:55:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id b72so3063864pfb.11
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQfvuRpZ4w8iMJngw8IAku8h4fGLGF0RHMC3sZquPto=;
        b=pfYsbtrWoHfk/+7VSHj9p4qahodNc5+ucHaa6mUmtZh0+PEvTZMZKh3OQHYUsGmJkU
         /7y/jR1yeydKM4imyXbE8MgC1GJ8H5pZf+QPvFFzaYWBcR95XrQc9xr83XaPXLDz1ets
         0ow/9RToJmLDgedSZxu+gMwEtqaQvHQY7wCpBnlDMIjS/QCk6Gv9Yi8cC3uIlcC0bM6t
         5Hi/nf7wMZOKMU/CYYhrg9FRggAaQl7K52SYgatB8gkch0UvI5WArWwqndKvjLPUsGCC
         Onb17N3sV0fvtZ9Uxac/Y/yjIcqZqcqEGShp6NpKjmQ+0Y5om0Imc4zfNCo1WOOEC1fw
         Z97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQfvuRpZ4w8iMJngw8IAku8h4fGLGF0RHMC3sZquPto=;
        b=eBVVBpZ637FKBlIZ5NzkmxZL61WppetRGGm67Cb4mU8k/vCLVieyfDlgfQeijo6ZwW
         wA5fdA8rn40r+z3UMnjedXm++2sEel/JWXN7hcRcQKARgCFjyniUVOVkZtQtaB2XbVw3
         t6LZWzby8rWOLJGc2WsHAl7nIDXwsJSdYKInm/pQ/3ySH7rW9kvzA77sLW5zyUCtR7Nt
         6XAKvPEQk0+eTIv3GILvmECW95uehsr+U2GZ2CpukvlH6uYhhdNmPzbLxWJzO9tTjtep
         qlZPBWfzVA6WOdVQ17X5OPPvMBhEZ4J17FK/tdYB9o0uFI9fMcOfCScJZDBeRaitOjgL
         DBlw==
X-Gm-Message-State: AGi0PuaGHwrxPjJd5OPDQJT0UnmTo+0CqhUpJKr+lwlO33tYKvtrkqO6
        xAwJ4eU0LnVKd75rV0cI4fVjA6IB
X-Google-Smtp-Source: APiQypJWgoHyTzVbjJ+a90qbC7zLqzENVN7eb/9boEZJnStTWsCP0VxbzMnHhOH7ias8lMPAxFeMPA==
X-Received: by 2002:a63:e49:: with SMTP id 9mr8556628pgo.182.1586382957187;
        Wed, 08 Apr 2020 14:55:57 -0700 (PDT)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:6271:607:aca0:b6f7])
        by smtp.googlemail.com with ESMTPSA id z7sm450929pju.37.2020.04.08.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 14:55:56 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 18/20] ext4: disable certain features in replay path
Date:   Wed,  8 Apr 2020 14:55:28 -0700
Message-Id: <20200408215530.25649-18-harshads@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200408215530.25649-1-harshads@google.com>
References: <20200408215530.25649-1-harshads@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Replay path uses similar code paths for replaying committed changes.
But since it runs before full initialization of the file system and
also since we don't have to be super careful about performance, we
can and need to disable certain file system features during the replay
path. More specifically, we disable most of the extent status tree
stuff, mballoc and some places where we mark file system with errors.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/balloc.c         |  7 +++++-
 fs/ext4/ext4_jbd2.c      |  2 +-
 fs/ext4/extents_status.c | 24 +++++++++++++++++++
 fs/ext4/ialloc.c         | 52 +++++++++++++++++++++++++++-------------
 fs/ext4/inode.c          | 14 +++++++----
 fs/ext4/mballoc.c        | 21 ++++++++++------
 6 files changed, 90 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 25960bb4fe69..220d818030ef 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -368,7 +368,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index bbba1b067fdf..b9b3833c8fdd 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -101,7 +101,7 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 		return ERR_PTR(err);
 
 	journal = EXT4_SB(sb)->s_journal;
-	if (!journal)
+	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return ext4_get_nojournal();
 	return jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
 				   GFP_NOFS, type, line);
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index d996b44d2265..69c16ac7416e 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -311,6 +311,9 @@ void ext4_es_find_extent_range(struct inode *inode,
 			       ext4_lblk_t lblk, ext4_lblk_t end,
 			       struct extent_status *es)
 {
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return;
+
 	trace_ext4_es_find_extent_range_enter(inode, lblk);
 
 	read_lock(&EXT4_I(inode)->i_es_lock);
@@ -361,6 +364,9 @@ bool ext4_es_scan_range(struct inode *inode,
 {
 	bool ret;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return false;
+
 	read_lock(&EXT4_I(inode)->i_es_lock);
 	ret = __es_scan_range(inode, matching_fn, lblk, end);
 	read_unlock(&EXT4_I(inode)->i_es_lock);
@@ -404,6 +410,9 @@ bool ext4_es_scan_clu(struct inode *inode,
 {
 	bool ret;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return false;
+
 	read_lock(&EXT4_I(inode)->i_es_lock);
 	ret = __es_scan_clu(inode, matching_fn, lblk);
 	read_unlock(&EXT4_I(inode)->i_es_lock);
@@ -812,6 +821,9 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	int err = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
 	es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
 		 lblk, len, pblk, status, inode->i_ino);
 
@@ -873,6 +885,9 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return;
+
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
@@ -908,6 +923,9 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct rb_node *node;
 	int found = 0;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
 	trace_ext4_es_lookup_extent_enter(inode, lblk);
 	es_debug("lookup extent in block %u\n", lblk);
 
@@ -1419,6 +1437,9 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	int err = 0;
 	int reserved = 0;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
 	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
@@ -1969,6 +1990,9 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status newes;
 	int err = 0;
 
+	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
 	es_debug("add [%u/1) delayed to extent status tree of inode %lu\n",
 		 lblk, inode->i_ino);
 
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7ecac922d8a4..3ccdf7834ab6 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -82,7 +82,12 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 				      struct buffer_head *bh)
 {
 	ext4_fsblk_t	blk;
-	struct ext4_group_info *grp = ext4_get_group_info(sb, block_group);
+	struct ext4_group_info *grp;
+
+	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
+		return 0;
+
+	grp = ext4_get_group_info(sb, block_group);
 
 	if (buffer_verified(bh))
 		return 0;
@@ -284,15 +289,17 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
 	bit = (ino - 1) % EXT4_INODES_PER_GROUP(sb);
 	bitmap_bh = ext4_read_inode_bitmap(sb, block_group);
 	/* Don't bother if the inode bitmap is corrupt. */
-	grp = ext4_get_group_info(sb, block_group);
 	if (IS_ERR(bitmap_bh)) {
 		fatal = PTR_ERR(bitmap_bh);
 		bitmap_bh = NULL;
 		goto error_return;
 	}
-	if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
-		fatal = -EFSCORRUPTED;
-		goto error_return;
+	if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
+		grp = ext4_get_group_info(sb, block_group);
+		if (unlikely(EXT4_MB_GRP_IBITMAP_CORRUPT(grp))) {
+			fatal = -EFSCORRUPTED;
+			goto error_return;
+		}
 	}
 
 	BUFFER_TRACE(bitmap_bh, "get_write_access");
@@ -884,7 +891,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	struct inode *ret;
 	ext4_group_t i;
 	ext4_group_t flex_group;
-	struct ext4_group_info *grp;
+	struct ext4_group_info *grp = NULL;
 	int encrypt = 0;
 
 	/* Cannot create files in a deleted directory */
@@ -1022,15 +1029,21 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		if (ext4_free_inodes_count(sb, gdp) == 0)
 			goto next_group;
 
-		grp = ext4_get_group_info(sb, group);
-		/* Skip groups with already-known suspicious inode tables */
-		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
-			goto next_group;
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
+			grp = ext4_get_group_info(sb, group);
+			/*
+			 * Skip groups with already-known suspicious inode
+			 * tables
+			 */
+			if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
+				goto next_group;
+		}
 
 		brelse(inode_bitmap_bh);
 		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
 		/* Skip groups with suspicious inode tables */
-		if (EXT4_MB_GRP_IBITMAP_CORRUPT(grp) ||
+		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
+		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
 		    IS_ERR(inode_bitmap_bh)) {
 			inode_bitmap_bh = NULL;
 			goto next_group;
@@ -1049,7 +1062,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 			goto next_group;
 		}
 
-		if (!handle) {
+		if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) {
 			BUG_ON(nblocks <= 0);
 			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
 				 handle_type, nblocks, 0,
@@ -1153,9 +1166,15 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	/* Update the relevant bg descriptor fields */
 	if (ext4_has_group_desc_csum(sb)) {
 		int free;
-		struct ext4_group_info *grp = ext4_get_group_info(sb, group);
-
-		down_read(&grp->alloc_sem); /* protect vs itable lazyinit */
+		struct ext4_group_info *grp = NULL;
+
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
+			grp = ext4_get_group_info(sb, group);
+			down_read(&grp->alloc_sem); /*
+						     * protect vs itable
+						     * lazyinit
+						     */
+		}
 		ext4_lock_group(sb, group); /* while we modify the bg desc */
 		free = EXT4_INODES_PER_GROUP(sb) -
 			ext4_itable_unused_count(sb, gdp);
@@ -1171,7 +1190,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 		if (ino > free)
 			ext4_itable_unused_set(sb, gdp,
 					(EXT4_INODES_PER_GROUP(sb) - ino));
-		up_read(&grp->alloc_sem);
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY))
+			up_read(&grp->alloc_sem);
 	} else {
 		ext4_lock_group(sb, group);
 	}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b5ca07497bbc..d6e5ffce5cf7 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -508,7 +508,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
+	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -820,7 +821,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
 	int err;
 
-	J_ASSERT(handle != NULL || create == 0);
+	J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state | EXT4_FC_REPLAY)
+		 || handle != NULL || create == 0);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -836,7 +838,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
 		J_ASSERT(create != 0);
-		J_ASSERT(handle != NULL);
+		J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+			 || (handle != NULL));
 
 		/*
 		 * Now that we do not always journal data, we should
@@ -4631,8 +4634,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei) ||
 	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) {
-		ext4_error_inode_err(inode, function, line, 0, EFSBADCRC,
-				     "iget: checksum invalid");
+		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
+			ext4_error_inode_err(inode, function, line, 0,
+					EFSBADCRC, "iget: checksum invalid");
 		ret = -EFSBADCRC;
 		goto bad_inode;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index db08208c1137..d6cdcc3e125c 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1449,14 +1449,16 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
 		blocknr = ext4_group_first_block_no(sb, e4b->bd_group);
 		blocknr += EXT4_C2B(sbi, block);
-		ext4_grp_locked_error(sb, e4b->bd_group,
-				      inode ? inode->i_ino : 0,
-				      blocknr,
-				      "freeing already freed block "
-				      "(bit %u); block bitmap corrupt.",
-				      block);
-		ext4_mark_group_bitmap_corrupted(sb, e4b->bd_group,
+		if (!(sbi->s_mount_state & EXT4_FC_REPLAY)) {
+			ext4_grp_locked_error(sb, e4b->bd_group,
+					      inode ? inode->i_ino : 0,
+					      blocknr,
+					      "freeing already freed block (bit %u); block bitmap corrupt.",
+					      block);
+			ext4_mark_group_bitmap_corrupted(
+				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		}
 		mb_regenerate_buddy(e4b);
 		goto done;
 	}
@@ -4116,6 +4118,9 @@ void ext4_discard_preallocations(struct inode *inode)
 		return;
 	}
 
+	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
+		return;
+
 	mb_debug(1, "discard preallocation for inode %lu\n", inode->i_ino);
 	trace_ext4_discard_preallocations(inode);
 
@@ -4591,6 +4596,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	sb = ar->inode->i_sb;
 	sbi = EXT4_SB(sb);
 
+	WARN_ON(sbi->s_mount_state & EXT4_FC_REPLAY);
+
 	trace_ext4_request_blocks(ar);
 
 	/* Allow to use superuser reservation for quota file */
-- 
2.26.0.110.g2183baf09c-goog

