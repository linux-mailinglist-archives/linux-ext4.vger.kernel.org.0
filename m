Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5512BB50C
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 20:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgKTTQk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 14:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732200AbgKTTQj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 14:16:39 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B7EC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:39 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id t37so8031409pga.7
        for <linux-ext4@vger.kernel.org>; Fri, 20 Nov 2020 11:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wt3jsceFNkLIQh4mBUjcPZa+ba6zcRcGDtdcaOK1uP0=;
        b=Z+qYsOTwYIXF2a4v+jDahjBf5GcHACIHJ6zKhQg7LK1eoHRh1RA2FOYlEq+50wkZT6
         B2KxbUADKMsWPejlofK2jeckE7pej+8x76poHkhVjV7YqXD4iUogD6K7LN499YQk+tro
         4mFbUbBgM0Bpj3pbVYT6Ee9YRbwyMMn3BAqUR4oFnSiy3dgrYagBoTlMPWOjfqA1ysvC
         uiA+VDYRQBnzm1LU5pspLFgBybG4HRbu8nUXkJV8kg6WWWly0fSjpLAazVWypR4wDP4e
         KljDFugaxOSwwPo3J6wEGND3Ok+CM+5dDtM7tMWr98DSRbPPRdtTa+Q61h+LgqRIjWLz
         SWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt3jsceFNkLIQh4mBUjcPZa+ba6zcRcGDtdcaOK1uP0=;
        b=YdIrBsu6nbfE31JZdWn7RGEraSxQOuNqxaln0ib4d9h6AYuG+E+axFrESFYfWbzj6Q
         ah1SZbJMhIgbQVq3MH6d51Y5EEmh67MjoO73za2I9dcFssHe8geKImqOslTEKGKQzPUI
         SufBVozx29pvM34TVKHvIzrR7qK78Cz/vFpkcwRocMmys9RCI1BNQ7qvVlxS73RaWMvk
         7WMI8f9N0wzT7g56YgIlsIPBVYIo8PGpCMwCdy0nNl0Ct3b0zzMUgGaXpt1C5kN/91JE
         /GX5hhRHRVhsNw81puSUdgBfjI0CMurr6YiwBkqH5lpnv7LfW+bI6GhGGe+kAUoHfLVb
         qvUg==
X-Gm-Message-State: AOAM532rj+x1L0iHweBc2JOjq1jgbzV3WbM6gBuQtFLz7EYAQHfIyYLY
        Hd/5MCVPq9xNEdE++YDjuy2lz0EE3jI=
X-Google-Smtp-Source: ABdhPJxfQTExM4nTdn0J/IzJeUbIt4TJ49hfHMmOPqqjB1jDv+tD7rjyWrRACxyKO+Xr60PGLTBvyw==
X-Received: by 2002:a63:1918:: with SMTP id z24mr18211314pgl.367.1605899798538;
        Fri, 20 Nov 2020 11:16:38 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id o9sm4370480pjr.2.2020.11.20.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:16:37 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 12/15] e2fsck: add replay for add_range, del_range, and inode tags
Date:   Fri, 20 Nov 2020 11:16:03 -0800
Message-Id: <20201120191606.2224881-13-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add replay for inode's extent trees and inode itself.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 e2fsck/journal.c | 341 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 341 insertions(+)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 9f4c4a70..ccd70186 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -378,6 +378,219 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 out_err:
 	return ret;
 }
+
+#define ex_end(__ex) ((__ex)->e_lblk + (__ex)->e_len - 1)
+#define ex_pend(__ex) ((__ex)->e_pblk + (__ex)->e_len - 1)
+
+static int make_room(struct extent_list *list, int i)
+{
+	int ret;
+
+	if (list->count == list->size) {
+		unsigned int new_size = (list->size + 341) *
+					sizeof(struct ext2fs_extent);
+		ret = ext2fs_resize_mem(0, new_size, &list->extents);
+		if (ret)
+			return ret;
+		list->size += 341;
+	}
+
+	memmove(&list->extents[i + 1], &list->extents[i],
+			sizeof(list->extents[0]) * (list->count - i));
+	list->count++;
+	return 0;
+}
+
+static int ex_compar(const void *arg1, const void *arg2)
+{
+	struct ext2fs_extent *ex1 = (struct ext2fs_extent *)arg1;
+	struct ext2fs_extent *ex2 = (struct ext2fs_extent *)arg2;
+
+	if (ex1->e_lblk < ex2->e_lblk)
+		return -1;
+	if (ex1->e_lblk > ex2->e_lblk)
+		return 1;
+	return ex1->e_len - ex2->e_len;
+}
+
+static int ex_len_compar(const void *arg1, const void *arg2)
+{
+	struct ext2fs_extent *ex1 = (struct ext2fs_extent *)arg1;
+	struct ext2fs_extent *ex2 = (struct ext2fs_extent *)arg2;
+
+	if (ex1->e_len < ex2->e_len)
+		return 1;
+
+	if (ex1->e_lblk > ex2->e_lblk)
+		return -1;
+
+	return 0;
+}
+
+static void ex_sort_and_merge(e2fsck_t ctx, struct extent_list *list)
+{
+	blk64_t ex_end;
+	int i, j;
+
+	if (list->count < 2)
+		return;
+
+	/*
+	 * Reverse sort by length, that way we strip off all the 0 length
+	 * extents
+	 */
+	qsort(list->extents, list->count, sizeof(struct ext2fs_extent),
+		ex_len_compar);
+
+	for (i = 0; i < list->count; i++) {
+		if (list->extents[i].e_len == 0) {
+			list->count = i;
+			break;
+		}
+	}
+
+	/* Now sort by logical offset */
+	qsort(list->extents, list->count, sizeof(list->extents[0]),
+		ex_compar);
+
+	/* Merge adjacent extents if they are logically and physically contiguous */
+	i = 0;
+	while (i < list->count - 1) {
+		if (ex_end(&list->extents[i]) + 1 != list->extents[i + 1].e_lblk ||
+			ex_pend(&list->extents[i]) + 1 != list->extents[i + 1].e_pblk ||
+			(list->extents[i].e_flags & EXT2_EXTENT_FLAGS_UNINIT) !=
+				(list->extents[i + 1].e_flags & EXT2_EXTENT_FLAGS_UNINIT)) {
+			i++;
+			continue;
+		}
+
+		list->extents[i].e_len += list->extents[i + 1].e_len;
+		for (j = i + 1; j < list->count - 1; j++)
+			list->extents[j] = list->extents[j + 1];
+		list->count--;
+	}
+}
+
+/* must free blocks that are released */
+static int ext2fs_modify_extent_list(e2fsck_t ctx, struct extent_list *list,
+					struct ext2fs_extent *ex, int del)
+{
+	int ret;
+	int i, offset;
+	struct ext2fs_extent add_ex = *ex, add_ex2;
+
+	/* First let's create a hole from ex->e_lblk of length ex->e_len */
+	for (i = 0; i < list->count; i++) {
+		if (ex_end(&list->extents[i]) < add_ex.e_lblk)
+			continue;
+
+		/* Case 1: No overlap */
+		if (list->extents[i].e_lblk > ex_end(&add_ex))
+			break;
+		/*
+		 * Unmark all the blocks in bb now. All the blocks get marked
+		 * before we exit this function.
+		 */
+		ext2fs_unmark_block_bitmap_range2(ctx->fs->block_map,
+			list->extents[i].e_pblk, list->extents[i].e_len);
+		/* Case 2: Split */
+		if (list->extents[i].e_lblk < add_ex.e_lblk &&
+			ex_end(&list->extents[i]) > ex_end(&add_ex)) {
+			ret = make_room(list, i + 1);
+			if (ret)
+				return ret;
+			list->extents[i + 1] = list->extents[i];
+			offset = ex_end(&add_ex) + 1 - list->extents[i].e_lblk;
+			list->extents[i + 1].e_lblk += offset;
+			list->extents[i + 1].e_pblk += offset;
+			list->extents[i + 1].e_len -= offset;
+			list->extents[i].e_len =
+				add_ex.e_lblk - list->extents[i].e_lblk;
+			break;
+		}
+
+		/* Case 3: Exact overlap */
+		if (add_ex.e_lblk <= list->extents[i].e_lblk  &&
+			ex_end(&list->extents[i]) <= ex_end(&add_ex)) {
+
+			list->extents[i].e_len = 0;
+			continue;
+		}
+
+		/* Case 4: Partial overlap */
+		if (ex_end(&list->extents[i]) > ex_end(&add_ex)) {
+			offset = ex_end(&add_ex) + 1 - list->extents[i].e_lblk;
+			list->extents[i].e_lblk += offset;
+			list->extents[i].e_pblk += offset;
+			list->extents[i].e_len -= offset;
+			break;
+		}
+
+		if (ex_end(&add_ex) >= ex_end(&list->extents[i])) {
+			list->extents[i].e_len =
+				max(add_ex.e_lblk - list->extents[i].e_lblk,
+					0);
+		}
+	}
+
+	if (add_ex.e_len && !del) {
+		make_room(list, list->count);
+		list->extents[list->count - 1] = add_ex;
+	}
+
+	ex_sort_and_merge(ctx, list);
+
+	/* Mark all occupied blocks allocated */
+	for (i = 0; i < list->count; i++)
+		ext2fs_mark_block_bitmap_range2(ctx->fs->block_map,
+			list->extents[i].e_pblk, list->extents[i].e_len);
+	ext2fs_mark_bb_dirty(ctx->fs);
+
+	return 0;
+}
+
+static int ext2fs_add_extent_to_list(e2fsck_t ctx, struct extent_list *list,
+					struct ext2fs_extent *ex)
+{
+	return ext2fs_modify_extent_list(ctx, list, ex, 0 /* add */);
+}
+
+static int ext2fs_del_extent_to_list(e2fsck_t ctx, struct extent_list *list,
+					struct ext2fs_extent *ex)
+{
+	return ext2fs_modify_extent_list(ctx, list, ex, 1 /* delete */);
+}
+
+static int e2fsck_fc_read_extents(e2fsck_t ctx, int ino)
+{
+	struct extent_list *extent_list = &ctx->fc_replay_state.fc_extent_list;
+
+	if (extent_list->ino == ino)
+		return 0;
+
+	extent_list->ino = ino;
+	return e2fsck_read_extents(ctx, extent_list);
+}
+
+/*
+ * Flush extents in replay state on disk. @ino is the inode that is going
+ * to be processed next. So, we hold back flushing of the extent list
+ * if the next inode that's going to be processed is same as the one with
+ * cached extents in our replay state. That allows us to gather multiple extents
+ * for the inode so that we can flush all of them at once and it also saves us
+ * from continuously growing and shrinking the extent tree.
+ */
+static void e2fsck_fc_flush_extents(e2fsck_t ctx, int ino)
+{
+	struct extent_list *extent_list = &ctx->fc_replay_state.fc_extent_list;
+
+	if (extent_list->ino == ino || extent_list->ino == 0)
+		return;
+	e2fsck_rewrite_extent_tree(ctx, extent_list);
+	ext2fs_free_mem(&extent_list->extents);
+	memset(extent_list, 0, sizeof(*extent_list));
+}
+
 /* Helper struct for dentry replay routines */
 struct dentry_info_args {
 	int parent_ino, dname_len, ino, inode_len;
@@ -414,6 +627,7 @@ static int ext4_fc_handle_unlink(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	ext2_filsys fs = ctx->fs;
 
 	tl_to_darg(&darg, tl);
+	e2fsck_fc_flush_extents(ctx, darg.ino);
 	ext2fs_unlink(ctx->fs, darg.parent_ino, darg.dname, darg.ino, 0);
 	/* It's okay if the above call fails */
 	free(darg.dname);
@@ -427,6 +641,8 @@ static int ext4_fc_handle_link_and_create(e2fsck_t ctx, struct ext4_fc_tl *tl)
 	int ret, filetype, mode;
 
 	tl_to_darg(&darg, tl);
+
+	e2fsck_fc_flush_extents(ctx, 0);
 	ret = ext2fs_read_inode(fs, darg.ino,
 					(struct ext2_inode *)&inode_large);
 	if (ret)
@@ -467,6 +683,124 @@ out:
 	return ret;
 
 }
+
+/* This function fixes the i_blocks field in the replayed indoe */
+static void ext4_fc_replay_fixup_iblocks(struct ext2_inode_large *ondisk_inode,
+	struct ext2_inode_large *fc_inode)
+{
+	if (le32_to_cpu(ondisk_inode->i_flags) & EXT4_EXTENTS_FL) {
+		struct ext3_extent_header *eh;
+
+		eh = (struct ext3_extent_header *)(&ondisk_inode->i_block[0]);
+		if (eh->eh_magic != EXT3_EXT_MAGIC) {
+			memset(eh, 0, sizeof(*eh));
+			eh->eh_magic = EXT3_EXT_MAGIC;
+			eh->eh_max = cpu_to_le16(
+				(sizeof(ondisk_inode->i_block) -
+					sizeof(struct ext3_extent_header)) /
+					sizeof(struct ext3_extent));
+		}
+	} else if (le32_to_cpu(ondisk_inode->i_flags) & EXT4_INLINE_DATA_FL) {
+		memcpy(ondisk_inode->i_block, fc_inode->i_block,
+			sizeof(fc_inode->i_block));
+	}
+}
+
+static int ext4_fc_handle_inode(e2fsck_t ctx, struct ext4_fc_tl *tl)
+{
+	struct ext4_fc_inode *fc_inode;
+	struct ext2_inode_large *inode = NULL;
+	int ino, inode_len = EXT2_GOOD_OLD_INODE_SIZE, ret;
+	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
+
+	fc_inode = (struct ext4_fc_inode *)ext4_fc_tag_val(tl);
+	ino = le32_to_cpu(fc_inode->fc_ino);
+
+	if (EXT2_INODE_SIZE(ctx->fs->super) > EXT2_GOOD_OLD_INODE_SIZE)
+		inode_len += ext2fs_le16_to_cpu(
+			((struct ext2_inode_large *)fc_inode->fc_raw_inode)
+				->i_extra_isize);
+	ret = ext2fs_get_mem(inode_len, &inode);
+	if (ret)
+		return ret;
+	e2fsck_fc_flush_extents(ctx, ino);
+
+	ret = ext2fs_read_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
+					inode_len);
+	if (ret)
+		goto out;
+	memcpy(inode, fc_inode->fc_raw_inode,
+		offsetof(struct ext2_inode_large, i_block));
+	memcpy(&inode->i_generation,
+		&((struct ext2_inode_large *)(fc_inode->fc_raw_inode))->i_generation,
+		inode_len - offsetof(struct ext2_inode_large, i_generation));
+	ext4_fc_replay_fixup_iblocks(inode,
+		(struct ext2_inode_large *)fc_inode->fc_raw_inode);
+	ext2fs_iblk_set(ctx->fs, EXT2_INODE(inode),
+		ext2fs_count_blocks(ctx->fs, ino, EXT2_INODE(inode)));
+
+	ext2fs_inode_csum_set(ctx->fs, ino, inode);
+
+	ret = ext2fs_write_inode_full(ctx->fs, ino, (struct ext2_inode *)inode,
+					inode_len);
+	if (inode->i_links_count)
+		ext2fs_mark_inode_bitmap2(ctx->fs->inode_map, ino);
+	else
+		ext2fs_unmark_inode_bitmap2(ctx->fs->inode_map, ino);
+	ext2fs_mark_ib_dirty(ctx->fs);
+
+out:
+	ext2fs_free_mem(&inode);
+	return ret;
+}
+
+/*
+ * Handle add extent replay tag.
+ */
+static int ext4_fc_handle_add_extent(e2fsck_t ctx, struct ext4_fc_tl *tl)
+{
+	struct ext2fs_extent extent;
+	struct ext4_fc_add_range *add_range;
+	struct ext4_fc_del_range *del_range;
+	int ret = 0, ino;
+
+	add_range = (struct ext4_fc_add_range *)ext4_fc_tag_val(tl);
+	ino = le32_to_cpu(add_range->fc_ino);
+	e2fsck_fc_flush_extents(ctx, ino);
+
+	ret = e2fsck_fc_read_extents(ctx, ino);
+	if (ret)
+		return ret;
+	memset(&extent, 0, sizeof(extent));
+	ext2fs_convert_extent(&extent, (struct ext3_extent *)(
+				add_range->fc_ex));
+	return ext2fs_add_extent_to_list(ctx,
+		&ctx->fc_replay_state.fc_extent_list, &extent);
+}
+
+/*
+ * Handle delete logical range replay tag.
+ */
+static int ext4_fc_handle_del_range(e2fsck_t ctx, struct ext4_fc_tl *tl)
+{
+	struct ext2fs_extent extent;
+	struct ext4_fc_del_range *del_range;
+	int ret, ino;
+
+	del_range = (struct ext4_fc_del_range *)ext4_fc_tag_val(tl);
+	ino = le32_to_cpu(del_range->fc_ino);
+	e2fsck_fc_flush_extents(ctx, ino);
+
+	memset(&extent, 0, sizeof(extent));
+	extent.e_lblk = ext2fs_le32_to_cpu(del_range->fc_lblk);
+	extent.e_len = ext2fs_le16_to_cpu(del_range->fc_len);
+	ret = e2fsck_fc_read_extents(ctx, ino);
+	if (ret)
+		return ret;
+	return ext2fs_del_extent_to_list(ctx,
+		&ctx->fc_replay_state.fc_extent_list, &extent);
+}
+
 /*
  * Main recovery path entry point. This function returns JBD2_FC_REPLAY_CONTINUE
  * to indicate that it is expecting more fast commit blocks. It returns
@@ -530,9 +864,16 @@ static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 			ret = ext4_fc_handle_unlink(ctx, tl);
 			break;
 		case EXT4_FC_TAG_ADD_RANGE:
+			ret = ext4_fc_handle_add_extent(ctx, tl);
+			break;
 		case EXT4_FC_TAG_DEL_RANGE:
+			ret = ext4_fc_handle_del_range(ctx, tl);
+			break;
 		case EXT4_FC_TAG_INODE:
+			ret = ext4_fc_handle_inode(ctx, tl);
+			break;
 		case EXT4_FC_TAG_TAIL:
+			e2fsck_fc_flush_extents(ctx, 0);
 		case EXT4_FC_TAG_PAD:
 		case EXT4_FC_TAG_HEAD:
 			break;
-- 
2.29.2.454.gaff20da3a2-goog

