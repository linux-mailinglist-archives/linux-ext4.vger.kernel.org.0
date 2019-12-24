Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26DB7129EE2
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Dec 2019 09:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbfLXIPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 03:15:06 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37881 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfLXIPD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Dec 2019 03:15:03 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so10072355pga.4
        for <linux-ext4@vger.kernel.org>; Tue, 24 Dec 2019 00:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lpd1rPArrPeJjFaR96JDERSrJC9w4eH0xTCNUoNrxqU=;
        b=p9T4t+FCpTN5RpFL/dvzVWENDeoXp+kr32bhHfExuqKVgovvHAmAYNuvpefGA3j4pp
         xG+Kp5P6JFEo62dyKOYjIxZF6tCPMvtrKVqf3lm3zX7yfeH9rScnhRIG1MrJicvvwLxq
         dA3FUmov+cGRF7UJ6jUM8mSev5vyPCFoXNBHLzcbwTnYX7Xoiz0jIjCAk8Vd/4Y8+D4a
         YIOB2IjyWU+5EYSt0T0UmZUwWZtbRIja0qtrp0+59VSFys1s1FZvjV8TyCU3mOOlf9Wz
         /tz1epA0sbZKkLUij75KMoQV7YbnXxsGROvSlv/d5PqriDs79LY8Y9JvhA612EPtaETJ
         qquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lpd1rPArrPeJjFaR96JDERSrJC9w4eH0xTCNUoNrxqU=;
        b=jbqBPjfWa+0a67my0pRbZ3ur0sjgeBTWBWjB19UocrUUL0evXCHBGo8UYtrFhUkNiG
         BHctoHtS+TDPkP/73/+INrhiSU3GPMB4F+DS3eQA2V5ifUitmkh7a2O2nVQlJUiFh9S3
         TGFt4exKguMHGaYnJyC524v4+CtJjgBNXmYRP90NsLmLt8815nLjk19RgvuII3husBVj
         fM9ghfYStI79j8irUELTe6YIgRmVinmECpyJGyVEQ4d7lqC2/HP+OtAHXtBSa5/xmF+U
         GpJxi3opOjkrPIL/EQF35YbLVSZoWjJBH79oXBb96giqjkdI2bRqbqbm2RmTb+sHxJCG
         n/sQ==
X-Gm-Message-State: APjAAAWob/W+VATMOXL/LzGJN6n1kFbO+6pZQsclTHFA67UhhSSnTRWj
        Jh43IMaLOjyTSgeO6BkQkahFEDBp
X-Google-Smtp-Source: APXvYqyflGgJ7oEJrA/5xJc8Syow7zzPSxHnmVZOzIlmhy2tS9/LTXL1FzUyNfENsgRUNerubiLdkw==
X-Received: by 2002:a65:49ca:: with SMTP id t10mr36841866pgs.37.1577175302262;
        Tue, 24 Dec 2019 00:15:02 -0800 (PST)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id f8sm27370781pfn.2.2019.12.24.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 00:15:01 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v4 18/20] ext4: disable certain features in replay path
Date:   Tue, 24 Dec 2019 00:13:22 -0800
Message-Id: <20191224081324.95807-18-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
References: <20191224081324.95807-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
 fs/ext4/inode.c          | 15 ++++++++----
 fs/ext4/mballoc.c        | 22 +++++++++++------
 6 files changed, 92 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 14787065d030..2cf39a6b9f7a 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -360,7 +360,12 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
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
index f371f1f0f914..7c6cdbc63aa6 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -77,7 +77,7 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
 		return ERR_PTR(err);
 
 	journal = EXT4_SB(sb)->s_journal;
-	if (!journal)
+	if (!journal || (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
 		return ext4_get_nojournal();
 	return jbd2__journal_start(journal, blocks, rsv_blocks, GFP_NOFS,
 				   type, line);
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
index f1a1432f9ffa..24a2d7171cd4 100644
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
@@ -287,15 +292,17 @@ void ext4_free_inode(handle_t *handle, struct inode *inode)
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
@@ -871,7 +878,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 	struct inode *ret;
 	ext4_group_t i;
 	ext4_group_t flex_group;
-	struct ext4_group_info *grp;
+	struct ext4_group_info *grp = NULL;
 	int encrypt = 0;
 
 	/* Cannot create files in a deleted directory */
@@ -1009,15 +1016,21 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
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
@@ -1036,7 +1049,7 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
 			goto next_group;
 		}
 
-		if (!handle) {
+		if ((!(sbi->s_mount_state & EXT4_FC_REPLAY)) && !handle) {
 			BUG_ON(nblocks <= 0);
 			handle = __ext4_journal_start_sb(dir->i_sb, line_no,
 							 handle_type, nblocks,
@@ -1140,9 +1153,15 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
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
@@ -1158,7 +1177,8 @@ struct inode *__ext4_new_inode(handle_t *handle, struct inode *dir,
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
index e902000dac51..f8090f5ce5e4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -527,7 +527,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 		return -EFSCORRUPTED;
 
 	/* Lookup extent status tree firstly */
-	if (ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
+	if (!(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) &&
+	    ext4_es_lookup_extent(inode, map->m_lblk, NULL, &es)) {
 		if (ext4_es_is_written(&es) || ext4_es_is_unwritten(&es)) {
 			map->m_pblk = ext4_es_pblock(&es) +
 					map->m_lblk - es.es_lblk;
@@ -969,7 +970,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 	int create = map_flags & EXT4_GET_BLOCKS_CREATE;
 	int err;
 
-	J_ASSERT(handle != NULL || create == 0);
+	J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state | EXT4_FC_REPLAY)
+		 || handle != NULL || create == 0);
 
 	map.m_lblk = block;
 	map.m_len = 1;
@@ -985,7 +987,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
 		return ERR_PTR(-ENOMEM);
 	if (map.m_flags & EXT4_MAP_NEW) {
 		J_ASSERT(create != 0);
-		J_ASSERT(handle != NULL);
+		J_ASSERT((EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
+			 || (handle != NULL));
 
 		/*
 		 * Now that we do not always journal data, we should
@@ -4896,8 +4899,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	}
 
 	if (!ext4_inode_csum_verify(inode, raw_inode, ei)) {
-		ext4_error_inode(inode, function, line, 0,
-				 "iget: checksum invalid");
+
+		if (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))
+			ext4_error_inode(inode, function, line, 0,
+					 "iget: checksum invalid");
 		ret = -EFSBADCRC;
 		goto bad_inode;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 05ca9001f8fa..4f2d611e5a75 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -1449,14 +1449,17 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
 
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
+					      "freeing already freed block "
+					      "(bit %u); block bitmap corrupt.",
+					      block);
+			ext4_mark_group_bitmap_corrupted(
+				sb, e4b->bd_group,
 				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		}
 		mb_regenerate_buddy(e4b);
 		goto done;
 	}
@@ -4088,6 +4091,9 @@ void ext4_discard_preallocations(struct inode *inode)
 		return;
 	}
 
+	if (EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY)
+		return;
+
 	mb_debug(1, "discard preallocation for inode %lu\n", inode->i_ino);
 	trace_ext4_discard_preallocations(inode);
 
@@ -4561,6 +4567,8 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	sb = ar->inode->i_sb;
 	sbi = EXT4_SB(sb);
 
+	WARN_ON(sbi->s_mount_state & EXT4_FC_REPLAY);
+
 	trace_ext4_request_blocks(ar);
 
 	/* Allow to use superuser reservation for quota file */
-- 
2.24.1.735.g03f4e72817-goog

