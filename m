Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D61479DE20
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbjIMCNd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbjIMCNd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:33 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4271717
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:28 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-655dccc9977so23548606d6.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571208; x=1695176008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CEWWu9NG4kLmMJBB33RF7/cWJeZIEp1GmXw8YLYn5Y=;
        b=V+AJlA6mXg7ch2rTIv6JeVUQxO4zvPvggxcScsKgJC+RIBEZac5lx0xNgpmx5BNLTL
         WUQNbBh6oTuAIPaQ+W6l4anORHddkdoy4UHj4GWRAXsjzMKwJESAo+InUdUArVkqqyq8
         wZ/v5ZL9zbvL3b074zSOaLIqr9IoI2VvR+LtAC1ktB/74DQV0slYonxMGSi5q3EymJQq
         21oyaLyFITgu6teh4exoPIptKA01g3z0rikn4wq0n2/Iz0/iKVuVI6D2gvUhHyids8s1
         FzKRusWB3gRWeq91CvAtx1vGS8IIHKQG+DtK6EK2HQ4fHdXuGE2K+Wlj6AZMhkI1aXhb
         C9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571208; x=1695176008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CEWWu9NG4kLmMJBB33RF7/cWJeZIEp1GmXw8YLYn5Y=;
        b=htif2CPZLID9mf1tehQkPWcjyADJ8YA2SsLaT8DcJBiw5nHBlIIk/Jno0eMuqZWuaZ
         5hywE55Co5qnJfxLrTLmw6O8tiSSKI9QvEKGP5yKxF+4Lw45dt1Uk8s5chS5XtHi2WjW
         yQBDpwGPmpvE/Ia6SnXo+SBkbt4irfBYPllZdc/g+b9b5LI8XGjDwLMIhmOT85rw/NA9
         ECcAGk+lw58jVJa+T6cnHjGcsS4WAeqDcm3D/I6yZxn3UvCbccM0317Z8jAJIwcoU73e
         WluNB1Ee+2CpbLi1S+s5yikbmx6IJIvHAJlRU41dv7DnD6HcGtCGczjhdib8W7FTtaMa
         zX3Q==
X-Gm-Message-State: AOJu0Yyfq/0B+1PGcwD05F8K0Jjkie7+wPfYLJ4OcAENSID3ON2t2ZPO
        30nr6fB+QVCAeoLoLfrfRuEiyxeT3ts=
X-Google-Smtp-Source: AGHT+IHTI7mzr+s4M3Rj1BifblzKv4F6J1xk6ITIu+4ebrAYW4QbCFltyUIvLu228HSpn5O69qIy9g==
X-Received: by 2002:a0c:eed1:0:b0:641:8df1:79e3 with SMTP id h17-20020a0ceed1000000b006418df179e3mr1335800qvs.29.1694571207847;
        Tue, 12 Sep 2023 19:13:27 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:27 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 5/6] ext4: simplify and improve efficiency of cluster removal code
Date:   Tue, 12 Sep 2023 22:11:47 -0400
Message-Id: <20230913021148.1181646-6-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rework the code in ext4_remove_space to further improve readability.
Explicitly separate the code used for bigalloc and non-bigalloc file
systems, take a clearer approach to bigalloc processing, and rewrite
the comments.  Take advantage of the new start_lclu and end_lclu
components in struct partial_cluster to minimize the number of checks
made for pending reservations and to maximize the number of blocks that
can be freed in a single operation when processing an extent.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/extents.c | 153 ++++++++++++++++++++++++++++------------------
 1 file changed, 92 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a0c9e37ef804..542d25d17f65 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2444,9 +2444,17 @@ static void free_partial_cluster(handle_t *handle, struct inode *inode,
 	 * flag forces ext4_free_blocks() to defer reserved and allocated
 	 * space accounting to this function.  This avoids potential difficult
 	 * to handle ENOSPC conditions when the file system is near exhaustion.
+	 *
+	 * A check for a pending reservation is only necessary if the partial
+	 * cluster matches the cluster at the beginning or the end of the
+	 * space to be removed.  All other pending reservations are
+	 * removed by ext4_ext_remove_extent() before ext4_ext_remove_space()
+	 * is called.
 	 */
-	if (ext4_is_pending(inode, partial->lblk))
-		flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
+	if (EXT4_B2C(sbi, partial->lblk) == partial->start_lclu ||
+	    EXT4_B2C(sbi, partial->lblk) == partial->end_lclu)
+		if (ext4_is_pending(inode, partial->lblk))
+			flags |= EXT4_FREE_BLOCKS_RERESERVE_CLUSTER;
 
 	ext4_free_blocks(handle, inode, NULL, EXT4_C2B(sbi, partial->pclu),
 			 sbi->s_cluster_ratio, flags);
@@ -2464,6 +2472,16 @@ static void free_partial_cluster(handle_t *handle, struct inode *inode,
 	}
 }
 
+/**
+ * ext4_remove_blocks() - frees a range of blocks found in a specified extent
+ *
+ * @handle: journal handle for current transaction
+ * @inode: file containing block range
+ * @ex: extent containing block range
+ * @partial: partial cluster tracking info for bigalloc
+ * @from: start of block range
+ * @to: end of block range
+ */
 static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 			      struct ext4_extent *ex,
 			      struct partial_cluster *partial,
@@ -2471,17 +2489,17 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	unsigned short ee_len = ext4_ext_get_actual_len(ex);
-	ext4_fsblk_t last_pblk, pblk;
-	ext4_lblk_t num;
+	ext4_lblk_t ee_block = le32_to_cpu(ex->ee_block);
+	ext4_fsblk_t ee_pblock = ext4_ext_pblock(ex);
+	ext4_fsblk_t pblk;
+	ext4_lblk_t nclus, nblks = 0;
 	int flags;
 
 	/* only extent tail removal is allowed */
-	if (from < le32_to_cpu(ex->ee_block) ||
-	    to != le32_to_cpu(ex->ee_block) + ee_len - 1) {
-		ext4_error(sbi->s_sb,
-			   "strange request: removal(2) %u-%u from %u:%u",
-			   from, to, le32_to_cpu(ex->ee_block), ee_len);
-		return 0;
+	if (unlikely(from < ee_block || to != ee_block + ee_len - 1)) {
+		EXT4_ERROR_INODE(inode, "extent tail required: from %u to %u ee_block %u ee_len %u",
+				 from, to, ee_block, ee_len);
+		return -EFSCORRUPTED;
 	}
 
 #ifdef EXTENTS_STATS
@@ -2499,76 +2517,89 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 
 	trace_ext4_remove_blocks(inode, ex, from, to, partial);
 
+	/* initial processing for the simple non-bigalloc case */
+	if (sbi->s_cluster_ratio == 1) {
+		pblk = ee_pblock + from - ee_block;
+		nblks = to - from + 1;
+		goto free_blocks;
+	}
+
+	/* initial bigalloc processing until free_blocks: below */
+
 	/*
-	 * if we have a partial cluster, and it's different from the
-	 * cluster of the last block in the extent, we free it
+	 * If there's a partial cluster which differs from the last cluster
+	 * in the block range, free it and/or clear it.  Any partial that
+	 * remains will correspond to the last cluster in the range.
 	 */
-	last_pblk = ext4_ext_pblock(ex) + ee_len - 1;
 	if (partial->state != none &&
-		EXT4_B2C(sbi, partial->lblk) != EXT4_B2C(sbi, to)) {
+	    EXT4_B2C(sbi, partial->lblk) > EXT4_B2C(sbi, to)) {
 		if (partial->state == free)
 			free_partial_cluster(handle, inode, partial);
 		partial->state = none;
 	}
 
-	num = le32_to_cpu(ex->ee_block) + ee_len - from;
-	pblk = ext4_ext_pblock(ex) + ee_len - num;
+	/* calculate the number of clusters covering the block range */
+	nclus = EXT4_B2C(sbi, to) - EXT4_B2C(sbi, from) + 1;
 
 	/*
-	 * We free the partial cluster at the end of the extent (if any),
-	 * unless the cluster is used by another extent (partial_cluster
-	 * state is keep).  If a partial cluster exists here, it must be
-	 * shared with the last block in the extent.
+	 * The range does not end on a cluster boundary, but contains the
+	 * first block of its last cluster.  If the last cluster is also
+	 * the last cluster or first cluster of the space to be removed
+	 * free it and/or clear it, noting that it's been processed.
+	 * Otherwise, for improved efficiency free it below along with
+	 * any other clusters wholly contained within the range.
 	 */
-
-	/* partial, left end cluster aligned, right end unaligned */
-	if ((EXT4_LBLK_COFF(sbi, to) != sbi->s_cluster_ratio - 1) &&
-	    (EXT4_LBLK_CMASK(sbi, to) >= from) &&
-	    (partial->state != keep)) {
-		if (partial->state == none) {
-			partial->pclu = EXT4_B2C(sbi, last_pblk);
-			partial->lblk = to;
-			partial->state = free;
+	if (to != EXT4_LBLK_CFILL(sbi, to) &&
+	    from <= EXT4_LBLK_CMASK(sbi, to)) {
+		if (EXT4_B2C(sbi, to) == partial->end_lclu ||
+		    EXT4_B2C(sbi, to) == partial->start_lclu) {
+			if (partial->state == none) {
+				partial->lblk = to;
+				pblk = ee_pblock + ee_len - 1;
+				partial->pclu = EXT4_B2C(sbi, pblk);
+				partial->state = free;
+			}
+			if (partial->state == free)
+				free_partial_cluster(handle, inode, partial);
+			nclus--;
+		} else {
+			if (partial->state == keep)
+				nclus--;
 		}
-		free_partial_cluster(handle, inode, partial);
 		partial->state = none;
 	}
 
-	flags = get_default_free_blocks_flags(inode);
-	flags |= EXT4_FREE_BLOCKS_NOFREE_LAST_CLUSTER;
-
 	/*
-	 * For bigalloc file systems, we never free a partial cluster
-	 * at the beginning of the extent.  Instead, we check to see if we
-	 * need to free it on a subsequent call to ext4_remove_blocks,
-	 * or at the end of ext4_ext_rm_leaf or ext4_ext_remove_space.
+	 * The range's first cluster (which could also be its last cluster)
+	 * does not begin on a cluster boundary.  If the range begins with
+	 * the extent's first block, record the cluster as a partial if it
+	 * hasn't already been set.  Otherwise, clear the partial because
+	 * the beginning of the space to be removed has been reached.
 	 */
-	flags |= EXT4_FREE_BLOCKS_NOFREE_FIRST_CLUSTER;
-	ext4_free_blocks(handle, inode, NULL, pblk, num, flags);
+	if (nclus && EXT4_LBLK_COFF(sbi, from) != 0) {
+		if (from == ee_block) {
+			if (partial->state == none) {
+				partial->lblk = from;
+				partial->pclu = EXT4_B2C(sbi, ee_pblock);
+				partial->state = free;
+			}
+		} else {
+			partial->state = none;
+		}
+		nclus--;
+	}
 
-	/* reset the partial cluster if we've freed past it */
-	if (partial->state != none &&
-	    EXT4_B2C(sbi, partial->lblk) != EXT4_B2C(sbi, from))
-		partial->state = none;
+	/* free remaining clusters contained within the range */
+	if (nclus) {
+		pblk = ee_pblock + from - ee_block + (sbi->s_cluster_ratio - 1);
+		pblk = EXT4_PBLK_CMASK(sbi, pblk);
+		nblks = nclus << sbi->s_cluster_bits;
+	}
 
-	/*
-	 * If we've freed the entire extent but the beginning is not left
-	 * cluster aligned and is not marked as ineligible for freeing we
-	 * record the partial cluster at the beginning of the extent.  It
-	 * wasn't freed by the preceding ext4_free_blocks() call, and we
-	 * need to look farther to the left to determine if it's to be freed
-	 * (not shared with another extent). Else, reset the partial
-	 * cluster - we're either  done freeing or the beginning of the
-	 * extent is left cluster aligned.
-	 */
-	if (EXT4_LBLK_COFF(sbi, from) && num == ee_len) {
-		if (partial->state == none) {
-			partial->pclu = EXT4_B2C(sbi, pblk);
-			partial->lblk = from;
-			partial->state = free;
-		}
-	} else {
-		partial->state = none;
+free_blocks:
+	if (nblks) {
+		flags = get_default_free_blocks_flags(inode);
+		ext4_free_blocks(handle, inode, NULL, pblk, nblks, flags);
 	}
 
 	return 0;
-- 
2.30.2

