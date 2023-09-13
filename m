Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BEF79DE1C
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjIMCNP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjIMCNO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:14 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816D4170A
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:10 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-414e78cdc11so45169561cf.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571189; x=1695175989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OapwWx/t3lT2N+8gp3EblGetgQPjPbXlcwuuYoaFp/c=;
        b=rKG/2tJ+gQrMyzT+truPVuJ3maTjmn5bj5cjSB9iAdVzw9702JBOse4YGtWJhqNVZY
         5PkbH83Hq5zAd08b/JcJwTJJmnxbo80Lvb2ZtojKuVfqP7/I9+k9katjpY2zusXFEjJi
         WKVZfbhQSjNM1n2PN73n+74fgsUJAKXyrs5Ms9hE1Xw2y0xgBZtALxno/I+uW1ur9DAW
         FbkFLY6VPYAYIRQFeYdu8wm2pd2N05GsusJ7Kz2fsP492kGpsUViOv+08vnp5SqyF09t
         PV/+BB5lpt9EHB2e+4xWYf3KOJOJX2xHdUWQcs6ck7xesJmU42V2w3wmRp0cXraptYnf
         WZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571189; x=1695175989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OapwWx/t3lT2N+8gp3EblGetgQPjPbXlcwuuYoaFp/c=;
        b=QunQKOCY0VlYd5fylaCYNaigiS7W+RfRAWZzZJ1s8Xlj0iwLBEV++VBWgy399/aAiE
         VwuiPx91PyjII3cQQuheasAXBYn5SoV1aKgLizZJKJ+7EycSKsZF55rOWkrbS5Tb8wmm
         awL0dvyYuptUNyP/0WngaUjNEN+enC9v/feCccj3v9irjCRv2wOk7qVU4klnv81azRWr
         tPaFdQYwIheBTFkxdlys3gw1FhC08EJQ9xYh5gTpgn1iDW6vTekIJBq15i++3PrZzmhj
         2t2tyI/G0gMGqyjEmy1F3tuq/9rqotOSzGNDYDpPJqIWrA5p/SjW1xOd7RRQeWcgi4qM
         5dcQ==
X-Gm-Message-State: AOJu0Yy5ioOGG94g6KKr7ZqDxXHysyluVeheBWREYdBOrHItoglIo2aX
        1osP19c8py959UdzRtw1npNaOCPXunY=
X-Google-Smtp-Source: AGHT+IGa6Hq3pPUVdcb6ooAU1cM9RAUyaE5D8r+jRGePxE+eCyspCPRGJNqapym4XjyGq7eijVTWqg==
X-Received: by 2002:a0c:fd45:0:b0:64a:87c8:6376 with SMTP id j5-20020a0cfd45000000b0064a87c86376mr1056074qvs.33.1694571189456;
        Tue, 12 Sep 2023 19:13:09 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:09 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 1/6] ext4: consolidate code used to free clusters
Date:   Tue, 12 Sep 2023 22:11:43 -0400
Message-Id: <20230913021148.1181646-2-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The code used to free clusters when removing a block range from an extent
tree belonging to a bigalloc file system is duplicated in several places.
Collect it into a single function for improved readability.  Fold
ext4_rereserve_cluster into that function, as it has only one call site
after consolidation and contains a small amount of code.  Improve comments
where clusters are freed and clean up the header for ext4_ext_rm_leaf().

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 146 ++++++++++++++++++++--------------------------
 1 file changed, 64 insertions(+), 82 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 202c76996b62..9470502b886a 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2420,35 +2420,46 @@ static inline int get_default_free_blocks_flags(struct inode *inode)
 	return 0;
 }
 
-/*
- * ext4_rereserve_cluster - increment the reserved cluster count when
- *                          freeing a cluster with a pending reservation
- *
- * @inode - file containing the cluster
- * @lblk - logical block in cluster to be reserved
+/**
+ * free_partial_cluster() - frees all the allocated blocks contained in a
+ *                          partial cluster and rereserves space for delayed
+ *                          allocated blocks it contains
  *
- * Increments the reserved cluster count and adjusts quota in a bigalloc
- * file system when freeing a partial cluster containing at least one
- * delayed and unwritten block.  A partial cluster meeting that
- * requirement will have a pending reservation.  If so, the
- * RERESERVE_CLUSTER flag is used when calling ext4_free_blocks() to
- * defer reserved and allocated space accounting to a subsequent call
- * to this function.
+ * @handle: journal handle for current transaction
+ * @inode: file containing the partial cluster
+ * @partial: partial cluster to be freed
  */
-static void ext4_rereserve_cluster(struct inode *inode, ext4_lblk_t lblk)
+static void free_partial_cluster(handle_t *handle, struct inode *inode,
+				 struct partial_cluster *partial)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	int flags = get_default_free_blocks_flags(inode);
+
+	/*
+	 * When the partial cluster contains at least one delayed and
+	 * unwritten block (has pending reservation), the RERESERVE_CLUSTER
+	 * flag forces ext4_free_blocks() to defer reserved and allocated
+	 * space accounting to this function.  This avoids potential difficult
+	 * to handle ENOSPC conditions when the file system is near exhaustion.
+	 */
+	if (ext4_is_pending(inode, partial->lblk))
+		flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
+
+	ext4_free_blocks(handle, inode, NULL, EXT4_C2B(sbi, partial->pclu),
+			 sbi->s_cluster_ratio, flags);
 
-	dquot_reclaim_block(inode, EXT4_C2B(sbi, 1));
+	if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER) {
+		dquot_reclaim_block(inode, EXT4_C2B(sbi, 1));
 
-	spin_lock(&ei->i_block_reservation_lock);
-	ei->i_reserved_data_blocks++;
-	percpu_counter_add(&sbi->s_dirtyclusters_counter, 1);
-	spin_unlock(&ei->i_block_reservation_lock);
+		spin_lock(&ei->i_block_reservation_lock);
+		ei->i_reserved_data_blocks++;
+		percpu_counter_add(&sbi->s_dirtyclusters_counter, 1);
+		spin_unlock(&ei->i_block_reservation_lock);
 
-	percpu_counter_add(&sbi->s_freeclusters_counter, 1);
-	ext4_remove_pending(inode, lblk);
+		percpu_counter_add(&sbi->s_freeclusters_counter, 1);
+		ext4_remove_pending(inode, partial->lblk);
+	}
 }
 
 static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
@@ -2491,19 +2502,10 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	 * cluster of the last block in the extent, we free it
 	 */
 	last_pblk = ext4_ext_pblock(ex) + ee_len - 1;
-
 	if (partial->state != initial &&
 	    partial->pclu != EXT4_B2C(sbi, last_pblk)) {
-		if (partial->state == tofree) {
-			flags = get_default_free_blocks_flags(inode);
-			if (ext4_is_pending(inode, partial->lblk))
-				flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
-			ext4_free_blocks(handle, inode, NULL,
-					 EXT4_C2B(sbi, partial->pclu),
-					 sbi->s_cluster_ratio, flags);
-			if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER)
-				ext4_rereserve_cluster(inode, partial->lblk);
-		}
+		if (partial->state == tofree)
+			free_partial_cluster(handle, inode, partial);
 		partial->state = initial;
 	}
 
@@ -2516,23 +2518,21 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	 * state is nofree).  If a partial cluster exists here, it must be
 	 * shared with the last block in the extent.
 	 */
-	flags = get_default_free_blocks_flags(inode);
 
 	/* partial, left end cluster aligned, right end unaligned */
 	if ((EXT4_LBLK_COFF(sbi, to) != sbi->s_cluster_ratio - 1) &&
 	    (EXT4_LBLK_CMASK(sbi, to) >= from) &&
 	    (partial->state != nofree)) {
-		if (ext4_is_pending(inode, to))
-			flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
-		ext4_free_blocks(handle, inode, NULL,
-				 EXT4_PBLK_CMASK(sbi, last_pblk),
-				 sbi->s_cluster_ratio, flags);
-		if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER)
-			ext4_rereserve_cluster(inode, to);
+		if (partial->state == initial) {
+			partial->pclu = EXT4_B2C(sbi, last_pblk);
+			partial->lblk = to;
+			partial->state = tofree;
+		}
+		free_partial_cluster(handle, inode, partial);
 		partial->state = initial;
-		flags = get_default_free_blocks_flags(inode);
 	}
 
+	flags = get_default_free_blocks_flags(inode);
 	flags |= EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER;
 
 	/*
@@ -2571,20 +2571,17 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	return 0;
 }
 
-/*
- * ext4_ext_rm_leaf() Removes the extents associated with the
- * blocks appearing between "start" and "end".  Both "start"
- * and "end" must appear in the same extent or EIO is returned.
+/**
+ * ext4_ext_rm_leaf() - Removes the extents associated with the blocks
+ *                      appearing between "start" and "end"
  *
  * @handle: The journal handle
- * @inode:  The files inode
- * @path:   The path to the leaf
- * @partial_cluster: The cluster which we'll have to free if all extents
- *                   has been released from it.  However, if this value is
- *                   negative, it's a cluster just to the right of the
- *                   punched region and it must not be freed.
- * @start:  The first block to remove
- * @end:   The last block to remove
+ * @inode: The file's inode
+ * @path:  The path to the leaf
+ * @partial: Information used to determine whether a cluster in a bigalloc
+ *           file system should be freed as extents are removed
+ * @start: The first block to remove
+ * @end: The last block to remove
  */
 static int
 ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
@@ -2759,24 +2756,18 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 
 	/*
 	 * If there's a partial cluster and at least one extent remains in
-	 * the leaf, free the partial cluster if it isn't shared with the
-	 * current extent.  If it is shared with the current extent
-	 * we reset the partial cluster because we've reached the start of the
-	 * truncated/punched region and we're done removing blocks.
+	 * the leaf, free the partial if it isn't shared with the next
+	 * extent.  Otherwise, clear it - the beginning of the space to be
+	 * removed has been reached.  If no extent remains in the leaf,
+	 * ext4_ext_remove_space() will always read in the next leaf (if any)
+	 * containing the next adjacent extent, allowing this code to handle
+	 * the case where the last block in that extent is outside the space
+	 * to be removed but might be shared with the partial cluster.
 	 */
 	if (partial->state == tofree && ex >= EXT_FIRST_EXTENT(eh)) {
 		pblk = ext4_ext_pblock(ex) + ex_ee_len - 1;
-		if (partial->pclu != EXT4_B2C(sbi, pblk)) {
-			int flags = get_default_free_blocks_flags(inode);
-
-			if (ext4_is_pending(inode, partial->lblk))
-				flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
-			ext4_free_blocks(handle, inode, NULL,
-					 EXT4_C2B(sbi, partial->pclu),
-					 sbi->s_cluster_ratio, flags);
-			if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER)
-				ext4_rereserve_cluster(inode, partial->lblk);
-		}
+		if (partial->pclu != EXT4_B2C(sbi, pblk))
+			free_partial_cluster(handle, inode, partial);
 		partial->state = initial;
 	}
 
@@ -3032,21 +3023,12 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 					 path->p_hdr->eh_entries);
 
 	/*
-	 * if there's a partial cluster and we have removed the first extent
-	 * in the file, then we also free the partial cluster, if any
+	 * if a partial cluster still remains here the extent tree has
+	 * been traversed to the beginning of the file, so it is not
+	 * shared with another extent
 	 */
-	if (partial.state == tofree && err == 0) {
-		int flags = get_default_free_blocks_flags(inode);
-
-		if (ext4_is_pending(inode, partial.lblk))
-			flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
-		ext4_free_blocks(handle, inode, NULL,
-				 EXT4_C2B(sbi, partial.pclu),
-				 sbi->s_cluster_ratio, flags);
-		if (flags & EXT4_FREE_BLOCKS_RERESERVE_CLUSTER)
-			ext4_rereserve_cluster(inode, partial.lblk);
-		partial.state = initial;
-	}
+	if (partial.state == tofree && err == 0)
+		free_partial_cluster(handle, inode, &partial);
 
 	/* TODO: flexible tree reduction should be here */
 	if (path->p_hdr->eh_entries == 0) {
-- 
2.30.2

