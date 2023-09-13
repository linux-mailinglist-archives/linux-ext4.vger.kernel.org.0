Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C62679DE1B
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Sep 2023 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238129AbjIMCNU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Sep 2023 22:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjIMCNT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Sep 2023 22:13:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63045170A
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:15 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-64a5bc53646so39073036d6.2
        for <linux-ext4@vger.kernel.org>; Tue, 12 Sep 2023 19:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694571194; x=1695175994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c0srBTHnIt364VZybNxfWbIBlVY+m4+LTt6UDorVH4=;
        b=q6osPttgvLlWMLh/x3SUhf70P5Z/bXpSnM1fHhP/R6QwvfktIUvmTEB2kuJQmSJXa2
         p2FXxU6bGnBHAjguMOuTZezrqKLxHM9LXr6zswKpcM1DbZRj54AgIE1NlDs9CgqwrNUf
         Oeiei1UCvxs4M4Z9eEYBzjuLaPY712sEHT1xVdEBHmMbAbh4jgxUB57Zs+JzfmyUm1H1
         lwgF+trE/nETYVjMnfkY7hOe/OF/+7QiGr3KLzKRYDPIfEtbnkqpyTf1ZO0KJJYsm9tC
         qORtyaockVVLAeMdDFWxn0ZWKgG1+ACQt2bs6khuUfVeNtmT8rBrsTWSYT+dQ3zd+J0c
         jUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694571194; x=1695175994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c0srBTHnIt364VZybNxfWbIBlVY+m4+LTt6UDorVH4=;
        b=TEzCjBeiECuBh9K30BvFYYjiXaoGSkwfp/peh6g2zcBqBB3EsPPNtWvMfBAQxskMwU
         mLbL62HONcddVxQdDHXWIfTPFtIIGMo8A/IX2cSStbC6rgzyNaGvyEXH3hpNI1+Wdpmy
         ocOOEXQt8nIdTDEbdlLY81UwCk3DA9Oe5KR4uqDVaTmkn7ZWKpq6FbmYjbBLOCJ1kYZX
         SK+3MRVw9ffAoPceQd6S2/oasZwZff03SMS52aFUh4r+1BZOm6pO/b+Qkqvj6DW92YFX
         nKhvunJz1CVLCWYa4wLn+c/OS7zfFIh5jEV+GJtF295MAzW1GKstIo42G42KwBHyUTr/
         xrdw==
X-Gm-Message-State: AOJu0YwU0Da2/CnkuKL1kCdkKxSUehhgQHnkgyDg6MMEGKtSSVqO/Jpx
        Xa87sZFz2fhk+lJkOtIQcchNs96v2wA=
X-Google-Smtp-Source: AGHT+IHmE/c3fLu8/51CZiqZM1qtlKYsZbrhB30JcKRzZxSNU+FArdMa8AWWi/BFlgvKeTJewfi4Dw==
X-Received: by 2002:a0c:f594:0:b0:647:14eb:f99c with SMTP id k20-20020a0cf594000000b0064714ebf99cmr1381074qvm.14.1694571194210;
        Tue, 12 Sep 2023 19:13:14 -0700 (PDT)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id c8-20020a0cf2c8000000b0064f778c8165sm4016055qvm.64.2023.09.12.19.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 19:13:13 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH 2/6] ext4: rework partial cluster definition and related tracepoints
Date:   Tue, 12 Sep 2023 22:11:44 -0400
Message-Id: <20230913021148.1181646-3-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230913021148.1181646-1-enwlinux@gmail.com>
References: <20230913021148.1181646-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Rework the partial cluster definition to use more obvious state values
and document the relationship between states and valid lblk and pclu
values.  Add entries for the first and last clusters delimiting the
space to be removed to enable optimizations in future patches.  Rework
the tracepoints containing partial clusters to produce a more readable
output format.  Add a tracepoint for free_partial_cluster().

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4_extents.h      |  19 ++++--
 fs/ext4/extents.c           |  50 +++++++--------
 include/trace/events/ext4.h | 119 ++++++++++++++++++++++++++----------
 3 files changed, 125 insertions(+), 63 deletions(-)

diff --git a/fs/ext4/ext4_extents.h b/fs/ext4/ext4_extents.h
index 26435f3a3094..06c2ce31dbcd 100644
--- a/fs/ext4/ext4_extents.h
+++ b/fs/ext4/ext4_extents.h
@@ -121,15 +121,22 @@ struct ext4_ext_path {
 
 /*
  * Used to record a portion of a cluster found at the beginning or end
- * of an extent while traversing the extent tree during space removal.
- * A partial cluster may be removed if it does not contain blocks shared
- * with extents that aren't being deleted (tofree state).  Otherwise,
- * it cannot be removed (nofree state).
+ * of an extent while traversing the extent tree when removing space.
+ * In the "none" state, no partial cluster is being tracked and both
+ * lblk and pclu values are invalid.
+ * In the "free" state, a partial cluster that is a possible candidate
+ * to be freed is being tracked, and both lblk and pclu values are valid.
+ * In the "keep" state, a partial cluster that must not be freed is being
+ * tracked, the lblk value is valid and the pclu value is not valid.
+ * start_lclu and end_lclu are the logical clusters at the start and end
+ * of the space to be removed.
  */
 struct partial_cluster {
-	ext4_fsblk_t pclu;  /* physical cluster number */
+	enum {none, free, keep} state;
 	ext4_lblk_t lblk;   /* logical block number within logical cluster */
-	enum {initial, tofree, nofree} state;
+	ext4_fsblk_t pclu;  /* physical cluster number */
+	ext4_lblk_t start_lclu;
+	ext4_lblk_t end_lclu;
 };
 
 /*
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9470502b886a..0c52218fb171 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2436,6 +2436,8 @@ static void free_partial_cluster(handle_t *handle, struct inode *inode,
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	int flags = get_default_free_blocks_flags(inode);
 
+	trace_free_partial_cluster(inode, partial);
+
 	/*
 	 * When the partial cluster contains at least one delayed and
 	 * unwritten block (has pending reservation), the RERESERVE_CLUSTER
@@ -2502,11 +2504,11 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	 * cluster of the last block in the extent, we free it
 	 */
 	last_pblk = ext4_ext_pblock(ex) + ee_len - 1;
-	if (partial->state != initial &&
+	if (partial->state != none &&
 	    partial->pclu != EXT4_B2C(sbi, last_pblk)) {
-		if (partial->state == tofree)
+		if (partial->state == free)
 			free_partial_cluster(handle, inode, partial);
-		partial->state = initial;
+		partial->state = none;
 	}
 
 	num = le32_to_cpu(ex->ee_block) + ee_len - from;
@@ -2515,21 +2517,21 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	/*
 	 * We free the partial cluster at the end of the extent (if any),
 	 * unless the cluster is used by another extent (partial_cluster
-	 * state is nofree).  If a partial cluster exists here, it must be
+	 * state is keep).  If a partial cluster exists here, it must be
 	 * shared with the last block in the extent.
 	 */
 
 	/* partial, left end cluster aligned, right end unaligned */
 	if ((EXT4_LBLK_COFF(sbi, to) != sbi->s_cluster_ratio - 1) &&
 	    (EXT4_LBLK_CMASK(sbi, to) >= from) &&
-	    (partial->state != nofree)) {
-		if (partial->state == initial) {
+	    (partial->state != keep)) {
+		if (partial->state == none) {
 			partial->pclu = EXT4_B2C(sbi, last_pblk);
 			partial->lblk = to;
-			partial->state = tofree;
+			partial->state = free;
 		}
 		free_partial_cluster(handle, inode, partial);
-		partial->state = initial;
+		partial->state = none;
 	}
 
 	flags = get_default_free_blocks_flags(inode);
@@ -2545,8 +2547,8 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	ext4_free_blocks(handle, inode, NULL, pblk, num, flags);
 
 	/* reset the partial cluster if we've freed past it */
-	if (partial->state != initial && partial->pclu != EXT4_B2C(sbi, pblk))
-		partial->state = initial;
+	if (partial->state != none && partial->pclu != EXT4_B2C(sbi, pblk))
+		partial->state = none;
 
 	/*
 	 * If we've freed the entire extent but the beginning is not left
@@ -2559,13 +2561,13 @@ static int ext4_remove_blocks(handle_t *handle, struct inode *inode,
 	 * extent is left cluster aligned.
 	 */
 	if (EXT4_LBLK_COFF(sbi, from) && num == ee_len) {
-		if (partial->state == initial) {
+		if (partial->state == none) {
 			partial->pclu = EXT4_B2C(sbi, pblk);
 			partial->lblk = from;
-			partial->state = tofree;
+			partial->state = free;
 		}
 	} else {
-		partial->state = initial;
+		partial->state = none;
 	}
 
 	return 0;
@@ -2649,7 +2651,7 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 			if (sbi->s_cluster_ratio > 1) {
 				pblk = ext4_ext_pblock(ex);
 				partial->pclu = EXT4_B2C(sbi, pblk);
-				partial->state = nofree;
+				partial->state = keep;
 			}
 			ex--;
 			ex_ee_block = le32_to_cpu(ex->ee_block);
@@ -2764,11 +2766,11 @@ ext4_ext_rm_leaf(handle_t *handle, struct inode *inode,
 	 * the case where the last block in that extent is outside the space
 	 * to be removed but might be shared with the partial cluster.
 	 */
-	if (partial->state == tofree && ex >= EXT_FIRST_EXTENT(eh)) {
+	if (partial->state == free && ex >= EXT_FIRST_EXTENT(eh)) {
 		pblk = ext4_ext_pblock(ex) + ex_ee_len - 1;
 		if (partial->pclu != EXT4_B2C(sbi, pblk))
 			free_partial_cluster(handle, inode, partial);
-		partial->state = initial;
+		partial->state = none;
 	}
 
 	/* if this leaf is free, then we should
@@ -2813,7 +2815,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 
 	partial.pclu = 0;
 	partial.lblk = 0;
-	partial.state = initial;
+	partial.state = none;
 
 	ext_debug(inode, "truncate since %u to %u\n", start, end);
 
@@ -2878,7 +2880,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			if (sbi->s_cluster_ratio > 1) {
 				pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
 				partial.pclu = EXT4_B2C(sbi, pblk);
-				partial.state = nofree;
+				partial.state = keep;
 			}
 
 			/*
@@ -2893,15 +2895,15 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				goto out;
 
 		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
-			   partial.state == initial) {
+			   partial.state == none) {
 			/*
 			 * If we're punching, there's an extent to the right.
 			 * If the partial cluster hasn't been set, set it to
-			 * that extent's first cluster and its state to nofree
+			 * that extent's first cluster and its state to keep
 			 * so it won't be freed should it contain blocks to be
-			 * removed. If it's already set (tofree/nofree), we're
+			 * removed. If it's already set (free/keep), we're
 			 * retrying and keep the original partial cluster info
-			 * so a cluster marked tofree as a result of earlier
+			 * so a cluster marked free as a result of earlier
 			 * extent removal is not lost.
 			 */
 			lblk = ex_end + 1;
@@ -2911,7 +2913,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				goto out;
 			if (pblk) {
 				partial.pclu = EXT4_B2C(sbi, pblk);
-				partial.state = nofree;
+				partial.state = keep;
 			}
 		}
 	}
@@ -3027,7 +3029,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	 * been traversed to the beginning of the file, so it is not
 	 * shared with another extent
 	 */
-	if (partial.state == tofree && err == 0)
+	if (partial.state == free && err == 0)
 		free_partial_cluster(handle, inode, &partial);
 
 	/* TODO: flexible tree reduction should be here */
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..b474ded2623d 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -95,6 +95,16 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
 	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
 
+TRACE_DEFINE_ENUM(none);
+TRACE_DEFINE_ENUM(free);
+TRACE_DEFINE_ENUM(keep);
+
+#define show_partial_cluster_state(state)	\
+	__print_symbolic(state,			\
+			{ none,	"none"},	\
+			{ free,	"free"},	\
+			{ keep,	"keep"})
+
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_JOURNAL_FLAG_CHANGE);
@@ -1984,6 +1994,42 @@ TRACE_EVENT(ext4_ext_show_extent,
 		  (unsigned short) __entry->len)
 );
 
+TRACE_EVENT(free_partial_cluster,
+	TP_PROTO(struct inode *inode, struct partial_cluster *pc),
+
+	TP_ARGS(inode, pc),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__field(	int,		pc_state	)
+		__field(	ext4_lblk_t,	pc_lblk		)
+		__field(	ext4_fsblk_t,	pc_pclu		)
+		__field(	ext4_lblk_t,	pc_start_lclu	)
+		__field(	ext4_lblk_t,	pc_end_lclu	)
+	),
+
+	TP_fast_assign(
+		__entry->dev		= inode->i_sb->s_dev;
+		__entry->ino		= inode->i_ino;
+		__entry->pc_state	= pc->state;
+		__entry->pc_lblk	= pc->lblk;
+		__entry->pc_pclu	= pc->pclu;
+		__entry->pc_start_lclu	= pc->start_lclu;
+		__entry->pc_end_lclu	= pc->end_lclu;
+	),
+
+	TP_printk("dev %d,%d ino %lu partial "
+		  "[state %s lblk %u pclu %lld start_lclu %u end_lclu %u]",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino,
+		  show_partial_cluster_state(__entry->pc_state),
+		  (unsigned int) __entry->pc_lblk,
+		  (long long) __entry->pc_pclu,
+		  (unsigned int) __entry->pc_start_lclu,
+		  (unsigned int) __entry->pc_end_lclu)
+);
+
 TRACE_EVENT(ext4_remove_blocks,
 	TP_PROTO(struct inode *inode, struct ext4_extent *ex,
 		 ext4_lblk_t from, ext4_fsblk_t to,
@@ -1992,16 +2038,18 @@ TRACE_EVENT(ext4_remove_blocks,
 	TP_ARGS(inode, ex, from, to, pc),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,		dev	)
-		__field(	ino_t,		ino	)
-		__field(	ext4_lblk_t,	from	)
-		__field(	ext4_lblk_t,	to	)
-		__field(	ext4_fsblk_t,	ee_pblk	)
-		__field(	ext4_lblk_t,	ee_lblk	)
-		__field(	unsigned short,	ee_len	)
-		__field(	ext4_fsblk_t,	pc_pclu	)
-		__field(	ext4_lblk_t,	pc_lblk	)
-		__field(	int,		pc_state)
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__field(	ext4_lblk_t,	from		)
+		__field(	ext4_lblk_t,	to		)
+		__field(	ext4_fsblk_t,	ee_pblk		)
+		__field(	ext4_lblk_t,	ee_lblk		)
+		__field(	unsigned short,	ee_len		)
+		__field(	int,		pc_state	)
+		__field(	ext4_lblk_t,	pc_lblk		)
+		__field(	ext4_fsblk_t,	pc_pclu		)
+		__field(	ext4_lblk_t,	pc_start_lclu	)
+		__field(	ext4_lblk_t,	pc_end_lclu	)
 	),
 
 	TP_fast_assign(
@@ -2012,13 +2060,16 @@ TRACE_EVENT(ext4_remove_blocks,
 		__entry->ee_pblk	= ext4_ext_pblock(ex);
 		__entry->ee_lblk	= le32_to_cpu(ex->ee_block);
 		__entry->ee_len		= ext4_ext_get_actual_len(ex);
-		__entry->pc_pclu	= pc->pclu;
-		__entry->pc_lblk	= pc->lblk;
 		__entry->pc_state	= pc->state;
+		__entry->pc_lblk	= pc->lblk;
+		__entry->pc_pclu	= pc->pclu;
+		__entry->pc_start_lclu	= pc->start_lclu;
+		__entry->pc_end_lclu	= pc->end_lclu;
 	),
 
-	TP_printk("dev %d,%d ino %lu extent [%u(%llu), %u]"
-		  "from %u to %u partial [pclu %lld lblk %u state %d]",
+	TP_printk("dev %d,%d ino %lu extent [%u(%llu), %u] "
+		  "from %u to %u partial "
+		  "[state %s lblk %u pclu %lld start_lclu %u end_lclu %u]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned) __entry->ee_lblk,
@@ -2026,9 +2077,11 @@ TRACE_EVENT(ext4_remove_blocks,
 		  (unsigned short) __entry->ee_len,
 		  (unsigned) __entry->from,
 		  (unsigned) __entry->to,
-		  (long long) __entry->pc_pclu,
+		  show_partial_cluster_state(__entry->pc_state),
 		  (unsigned int) __entry->pc_lblk,
-		  (int) __entry->pc_state)
+		  (long long) __entry->pc_pclu,
+		  (unsigned int) __entry->pc_start_lclu,
+		  (unsigned int) __entry->pc_end_lclu)
 );
 
 TRACE_EVENT(ext4_ext_rm_leaf,
@@ -2045,9 +2098,9 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 		__field(	ext4_lblk_t,	ee_lblk	)
 		__field(	ext4_fsblk_t,	ee_pblk	)
 		__field(	short,		ee_len	)
-		__field(	ext4_fsblk_t,	pc_pclu	)
-		__field(	ext4_lblk_t,	pc_lblk	)
 		__field(	int,		pc_state)
+		__field(	ext4_lblk_t,	pc_lblk	)
+		__field(	ext4_fsblk_t,	pc_pclu	)
 	),
 
 	TP_fast_assign(
@@ -2057,22 +2110,22 @@ TRACE_EVENT(ext4_ext_rm_leaf,
 		__entry->ee_lblk	= le32_to_cpu(ex->ee_block);
 		__entry->ee_pblk	= ext4_ext_pblock(ex);
 		__entry->ee_len		= ext4_ext_get_actual_len(ex);
-		__entry->pc_pclu	= pc->pclu;
-		__entry->pc_lblk	= pc->lblk;
 		__entry->pc_state	= pc->state;
+		__entry->pc_lblk	= pc->lblk;
+		__entry->pc_pclu	= pc->pclu;
 	),
 
-	TP_printk("dev %d,%d ino %lu start_lblk %u last_extent [%u(%llu), %u]"
-		  "partial [pclu %lld lblk %u state %d]",
+	TP_printk("dev %d,%d ino %lu start_lblk %u last_extent [%u(%llu), %u] "
+		  "partial [state %s lblk %u pclu %lld]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned) __entry->start,
 		  (unsigned) __entry->ee_lblk,
 		  (unsigned long long) __entry->ee_pblk,
 		  (unsigned short) __entry->ee_len,
-		  (long long) __entry->pc_pclu,
+		  show_partial_cluster_state(__entry->pc_state),
 		  (unsigned int) __entry->pc_lblk,
-		  (int) __entry->pc_state)
+		  (long long) __entry->pc_pclu)
 );
 
 TRACE_EVENT(ext4_ext_rm_idx,
@@ -2120,7 +2173,7 @@ TRACE_EVENT(ext4_ext_remove_space,
 		__entry->depth	= depth;
 	),
 
-	TP_printk("dev %d,%d ino %lu since %u end %u depth %d",
+	TP_printk("dev %d,%d ino %lu start %u end %u depth %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned) __entry->start,
@@ -2140,9 +2193,9 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 		__field(	ext4_lblk_t,	start		)
 		__field(	ext4_lblk_t,	end		)
 		__field(	int,		depth		)
-		__field(	ext4_fsblk_t,	pc_pclu		)
-		__field(	ext4_lblk_t,	pc_lblk		)
 		__field(	int,		pc_state	)
+		__field(	ext4_lblk_t,	pc_lblk		)
+		__field(	ext4_fsblk_t,	pc_pclu		)
 		__field(	unsigned short,	eh_entries	)
 	),
 
@@ -2152,23 +2205,23 @@ TRACE_EVENT(ext4_ext_remove_space_done,
 		__entry->start		= start;
 		__entry->end		= end;
 		__entry->depth		= depth;
-		__entry->pc_pclu	= pc->pclu;
-		__entry->pc_lblk	= pc->lblk;
 		__entry->pc_state	= pc->state;
+		__entry->pc_lblk	= pc->lblk;
+		__entry->pc_pclu	= pc->pclu;
 		__entry->eh_entries	= le16_to_cpu(eh_entries);
 	),
 
-	TP_printk("dev %d,%d ino %lu since %u end %u depth %d "
-		  "partial [pclu %lld lblk %u state %d] "
+	TP_printk("dev %d,%d ino %lu start %u end %u depth %d "
+		  "partial [state %s lblk %u pclu %lld] "
 		  "remaining_entries %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  (unsigned) __entry->start,
 		  (unsigned) __entry->end,
 		  __entry->depth,
-		  (long long) __entry->pc_pclu,
+		  show_partial_cluster_state(__entry->pc_state),
 		  (unsigned int) __entry->pc_lblk,
-		  (int) __entry->pc_state,
+		  (long long) __entry->pc_pclu,
 		  (unsigned short) __entry->eh_entries)
 );
 
-- 
2.30.2

