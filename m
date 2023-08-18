Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5FA781428
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 22:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379917AbjHRULn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 16:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379906AbjHRUL2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 16:11:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F833C06;
        Fri, 18 Aug 2023 13:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=aH+qLlXmi6Mu8cnnrdpopb39pScOb0FKN7BCVxrCCHA=; b=gYHYvzrCCnh/rDCROjqEyLCQNi
        e0sUN3GStRSGY/jwPY1gztsgx2yXrJ3tc/acgC1bjP/jknjChx/z+CNqF2V6561iZEH3toj0Eow28
        soZ37aZ90VB0j1qWBn35K/dYek2fYaHOJvsFdgWzL28DkifKLyEpoA1oYDbOFvrFNPKPWalvSMW1s
        gFqalmZtE8nrvpiWMPzDrwuslXNFtE9FJScDsbMEt0OS2am2hRDMBcAe/M77gfTmEHNfOMpn0A4nq
        zdNAiDyGtO9z+PUSKGRQ0JGfzqSXpDisZ4BRI8LlJyZyY7krltXNFGCWMSebaujBjsgG29f81+XMp
        FFbZFA+g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX5ob-00BPiR-7F; Fri, 18 Aug 2023 20:11:25 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Jan Kara <jack@suse.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-ext4@vger.kernel.org, linux-docs@vger.kernel.org
Subject: [PATCH] ext2: Fix kernel-doc warnings
Date:   Fri, 18 Aug 2023 21:11:21 +0100
Message-Id: <20230818201121.2720451-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Document a few parameters of ext2_alloc_blocks().  Redo the
alloc_new_reservation() and find_next_reservable_window() kernel-doc
entirely.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ext2/balloc.c | 101 +++++++++++++++++++++--------------------------
 fs/ext2/inode.c  |  16 +++++---
 2 files changed, 56 insertions(+), 61 deletions(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index c8049c90323d..72c9f7f5918e 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -716,36 +716,34 @@ ext2_try_to_allocate(struct super_block *sb, int group,
 }
 
 /**
- * 	find_next_reservable_window():
- *		find a reservable space within the given range.
- *		It does not allocate the reservation window for now:
- *		alloc_new_reservation() will do the work later.
+ * find_next_reservable_window - Find a reservable space within the given range.
+ * @search_head: The list to search.
+ * @my_rsv: The reservation we're currently using.
+ * @sb: The super block.
+ * @start_block: The first block we consider to start the real search from
+ * @last_block: The maximum block number that our goal reservable space
+ *	could start from.
  *
- * 	@search_head: the head of the searching list;
- *		This is not necessarily the list head of the whole filesystem
+ * It does not allocate the reservation window: alloc_new_reservation()
+ * will do the work later.
  *
- *		We have both head and start_block to assist the search
- *		for the reservable space. The list starts from head,
- *		but we will shift to the place where start_block is,
- *		then start from there, when looking for a reservable space.
+ * We search the given range, rather than the whole reservation double
+ * linked list, (start_block, last_block) to find a free region that is
+ * of my size and has not been reserved.
  *
- *	@sb: the super block.
+ * @search_head is not necessarily the list head of the whole filesystem.
+ * We have both head and @start_block to assist the search for the
+ * reservable space. The list starts from head, but we will shift to
+ * the place where start_block is, then start from there, when looking
+ * for a reservable space.
  *
- * 	@start_block: the first block we consider to start the real search from
- *
- * 	@last_block:
- *		the maximum block number that our goal reservable space
- *		could start from. This is normally the last block in this
- *		group. The search will end when we found the start of next
- *		possible reservable space is out of this boundary.
- *		This could handle the cross boundary reservation window
- *		request.
- *
- * 	basically we search from the given range, rather than the whole
- * 	reservation double linked list, (start_block, last_block)
- * 	to find a free region that is of my size and has not
- * 	been reserved.
+ * @last_block is normally the last block in this group. The search will end
+ * when we found the start of next possible reservable space is out
+ * of this boundary.  This could handle the cross boundary reservation
+ * window request.
  *
+ * Return: -1 if we could not find a range of sufficient size.  If we could,
+ * return 0 and fill in @my_rsv with the range information.
  */
 static int find_next_reservable_window(
 				struct ext2_reserve_window_node *search_head,
@@ -833,41 +831,34 @@ static int find_next_reservable_window(
 }
 
 /**
- * 	alloc_new_reservation()--allocate a new reservation window
- *
- *		To make a new reservation, we search part of the filesystem
- *		reservation list (the list that inside the group). We try to
- *		allocate a new reservation window near the allocation goal,
- *		or the beginning of the group, if there is no goal.
- *
- *		We first find a reservable space after the goal, then from
- *		there, we check the bitmap for the first free block after
- *		it. If there is no free block until the end of group, then the
- *		whole group is full, we failed. Otherwise, check if the free
- *		block is inside the expected reservable space, if so, we
- *		succeed.
- *		If the first free block is outside the reservable space, then
- *		start from the first free block, we search for next available
- *		space, and go on.
- *
- *	on succeed, a new reservation will be found and inserted into the list
- *	It contains at least one free block, and it does not overlap with other
- *	reservation windows.
+ * alloc_new_reservation - Allocate a new reservation window.
+ * @my_rsv: The reservation we're currently using.
+ * @grp_goal: The goal block relative to the start of the group.
+ * @sb: The super block.
+ * @group: The group we are trying to allocate in.
+ * @bitmap_bh: The block group block bitmap.
  *
- *	failed: we failed to find a reservation window in this group
+ * To make a new reservation, we search part of the filesystem reservation
+ * list (the list inside the group). We try to allocate a new
+ * reservation window near @grp_goal, or the beginning of the
+ * group, if @grp_goal is negative.
  *
- *	@my_rsv: the reservation
+ * We first find a reservable space after the goal, then from there,
+ * we check the bitmap for the first free block after it. If there is
+ * no free block until the end of group, then the whole group is full,
+ * we failed. Otherwise, check if the free block is inside the expected
+ * reservable space, if so, we succeed.
  *
- *	@grp_goal: The goal (group-relative).  It is where the search for a
- *		free reservable space should start from.
- *		if we have a goal(goal >0 ), then start from there,
- *		no goal(goal = -1), we start from the first block
- *		of the group.
+ * If the first free block is outside the reservable space, then start
+ * from the first free block, we search for next available space, and
+ * go on.
  *
- *	@sb: the super block
- *	@group: the group we are trying to allocate in
- *	@bitmap_bh: the block group block bitmap
+ * on succeed, a new reservation will be found and inserted into the
+ * list. It contains at least one free block, and it does not overlap
+ * with other reservation windows.
  *
+ * Return: 0 on success, -1 if we failed to find a reservation window
+ * in this group
  */
 static int alloc_new_reservation(struct ext2_reserve_window_node *my_rsv,
 		ext2_grpblk_t grp_goal, struct super_block *sb,
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index acbab27fe957..693ba36ca9cd 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -385,12 +385,16 @@ ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
 }
 
 /**
- *	ext2_alloc_blocks: multiple allocate blocks needed for a branch
- *	@indirect_blks: the number of blocks need to allocate for indirect
- *			blocks
- *	@blks: the number of blocks need to allocate for direct blocks
- *	@new_blocks: on return it will store the new block numbers for
- *	the indirect blocks(if needed) and the first direct block,
+ * ext2_alloc_blocks: Allocate multiple blocks needed for a branch.
+ * @inode: Owner.
+ * @goal: Preferred place for allocation.
+ * @indirect_blks: The number of blocks needed to allocate for indirect blocks.
+ * @blks: The number of blocks need to allocate for direct blocks.
+ * @new_blocks: On return it will store the new block numbers for
+ *	the indirect blocks(if needed) and the first direct block.
+ * @err: Error pointer.
+ *
+ * Return: Number of blocks allocated.
  */
 static int ext2_alloc_blocks(struct inode *inode,
 			ext2_fsblk_t goal, int indirect_blks, int blks,
-- 
2.40.1

