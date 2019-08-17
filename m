Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B526912B4
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Aug 2019 21:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbfHQTbp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 17 Aug 2019 15:31:45 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43181 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfHQTbp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 17 Aug 2019 15:31:45 -0400
Received: by mail-qk1-f193.google.com with SMTP id m2so7530663qkd.10
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2019 12:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cOuMhkSHodKfI2lllDnKSPKbjbQ0uuEc2RF+reic13w=;
        b=rDn24lS7+JyGMDNi3fyhzbmWKCTRxtTIfUyJ+KyoikSFOylTtvq/+c/wa2IPAcbt1g
         USMX38Obpk7qA5n531gtsvuiOW8xniCmGSbV1w44lJW2gDDkxqT3KGAEzeDKjcfHocXo
         XwFq+2b1FphJr6fu5t+Bkgyrq7abOQq5Jgl0izECyJW9d9o6IF9VDVBUZWi7YDdx9Sc1
         7CnpH1I1gKo3d7geSzOINdNmayCWS0rAsOKa0Iz7aRCrdeRvlgKTQIVw/0KDfyoDlUta
         awSOuwbpSzpiFlHV9Ilgq39wv2b4XB79NYbe034a2mz9W++oX+1Y1/lAnEz+fp+9Af6N
         jdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cOuMhkSHodKfI2lllDnKSPKbjbQ0uuEc2RF+reic13w=;
        b=lBOhAEXUeTFy+NP1RS3UUTi363rJm0Vl6pwouiig0XSTxt/gVNBEi+BLArPCTaj2nX
         nbEHZvXCYbn62P+vVWuo3n8Ama+hGXGxe/Rw9Md5GgzQ8uUL050j4AvvDH+e2XITPuQ0
         8Nuhbyh6F8nhdC/sqITbwOFXpdZm+ueCaGSEVhXZB/PxNNwAaz55ifhFTzQ3eM+7ujfM
         lXuYW+GHNsJ+bSWPnOkkrETxBmxFVE7kVVw/Zt/taJyCg5r1z6h24LzwgO86EzbR9AcP
         n5sT4r5e22+Wg0gNNQP8kRx//nbvP/exioCz23F8xtqrZJ24YpUAbhnzSgYpy/lSAQJN
         GM9w==
X-Gm-Message-State: APjAAAUowBUV4TTp4Lr3j63DIZeXBjbll03Fr75LRqtQSwXiE83DtPMN
        MxXyBOTvM5XTBfYYq0/LllUkiohd
X-Google-Smtp-Source: APXvYqzeEDgqPCmzUnRjnkP4fWgX7kko/2+lbit3Z4TPoSebJL+vHspRhfbhY26Gkv/hVFWJzo4jpQ==
X-Received: by 2002:ae9:e412:: with SMTP id q18mr14389702qkc.318.1566070300956;
        Sat, 17 Aug 2019 12:31:40 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id o18sm4994125qtt.4.2019.08.17.12.31.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Aug 2019 12:31:40 -0700 (PDT)
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] ext4: rework reserved cluster accounting when invalidating pages
Date:   Sat, 17 Aug 2019 15:31:03 -0400
Message-Id: <20190817193103.28912-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The goal of this patch is to remove two references to the buffer delay
bit in ext4_da_page_release_reservation() as part of a larger effort
to remove all such references from ext4.  These two references are
principally used to reduce the reserved block/cluster count when pages
are invalidated as a result of truncating, punching holes, or
collapsing a block range in a file.  The entire function is removed
and replaced with code in ext4_es_remove_extent() that reduces the
reserved count as a side effect of removing a block range from delayed
and not unwritten extents in the extent status tree as is done when
truncating, punching holes, or collapsing ranges.

The code is written to minimize the number of searches descending from
rb tree roots for scalability.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 fs/ext4/ext4.h           |   3 +
 fs/ext4/extents_status.c | 446 ++++++++++++++++++++++++++++++++++++-----------
 fs/ext4/extents_status.h |   2 -
 fs/ext4/inode.c          |  63 +------
 4 files changed, 353 insertions(+), 161 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bf660aa7a9e0..74cfd28d8561 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -284,6 +284,9 @@ struct ext4_io_submit {
 				  ~((ext4_fsblk_t) (s)->s_cluster_ratio - 1))
 #define EXT4_LBLK_CMASK(s, lblk) ((lblk) &				\
 				  ~((ext4_lblk_t) (s)->s_cluster_ratio - 1))
+/* Fill in the low bits to get the last block of the cluster */
+#define EXT4_LBLK_CFILL(sbi, lblk) ((lblk) |				\
+				    ((ext4_lblk_t) (sbi)->s_cluster_ratio - 1))
 /* Get the cluster offset */
 #define EXT4_PBLK_COFF(s, pblk) ((pblk) &				\
 				 ((ext4_fsblk_t) (s)->s_cluster_ratio - 1))
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7521de2dcf3a..ea9cebfea0d4 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -146,7 +146,7 @@ static struct kmem_cache *ext4_pending_cachep;
 
 static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end);
+			      ext4_lblk_t end, int *reserved);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
@@ -836,7 +836,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_es_insert_extent_check(inode, &newes);
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end);
+	err = __es_remove_extent(inode, lblk, end, NULL);
 	if (err != 0)
 		goto error;
 retry:
@@ -958,8 +958,322 @@ int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 	return found;
 }
 
+struct rsvd_count {
+	int ndelonly;
+	bool first_do_lblk_found;
+	ext4_lblk_t first_do_lblk;
+	ext4_lblk_t last_do_lblk;
+	struct extent_status *left_es;
+	bool partial;
+	ext4_lblk_t lclu;
+};
+
+/*
+ * init_rsvd - initialize reserved count data before removing block range
+ *	       in file from extent status tree
+ *
+ * @inode - file containing range
+ * @lblk - first block in range
+ * @es - pointer to first extent in range
+ * @rc - pointer to reserved count data
+ *
+ * Assumes es is not NULL
+ */
+static void init_rsvd(struct inode *inode, ext4_lblk_t lblk,
+		      struct extent_status *es, struct rsvd_count *rc)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct rb_node *node;
+
+	rc->ndelonly = 0;
+
+	/*
+	 * for bigalloc, note the first delonly block in the range has not
+	 * been found, record the extent containing the block to the left of
+	 * the region to be removed, if any, and note that there's no partial
+	 * cluster to track
+	 */
+	if (sbi->s_cluster_ratio > 1) {
+		rc->first_do_lblk_found = false;
+		if (lblk > es->es_lblk) {
+			rc->left_es = es;
+		} else {
+			node = rb_prev(&es->rb_node);
+			rc->left_es = node ? rb_entry(node,
+						      struct extent_status,
+						      rb_node) : NULL;
+		}
+		rc->partial = false;
+	}
+}
+
+/*
+ * count_rsvd - count the clusters containing delayed and not unwritten
+ *		(delonly) blocks in a range within an extent and add to
+ *	        the running tally in rsvd_count
+ *
+ * @inode - file containing extent
+ * @lblk - first block in range
+ * @len - length of range in blocks
+ * @es - pointer to extent containing clusters to be counted
+ * @rc - pointer to reserved count data
+ *
+ * Tracks partial clusters found at the beginning and end of extents so
+ * they aren't overcounted when they span adjacent extents
+ */
+static void count_rsvd(struct inode *inode, ext4_lblk_t lblk, long len,
+		       struct extent_status *es, struct rsvd_count *rc)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	ext4_lblk_t i, end, nclu;
+
+	if (!ext4_es_is_delonly(es))
+		return;
+
+	WARN_ON(len <= 0);
+
+	if (sbi->s_cluster_ratio == 1) {
+		rc->ndelonly += (int) len;
+		return;
+	}
+
+	/* bigalloc */
+
+	i = (lblk < es->es_lblk) ? es->es_lblk : lblk;
+	end = lblk + (ext4_lblk_t) len - 1;
+	end = (end > ext4_es_end(es)) ? ext4_es_end(es) : end;
+
+	/* record the first block of the first delonly extent seen */
+	if (rc->first_do_lblk_found == false) {
+		rc->first_do_lblk = i;
+		rc->first_do_lblk_found = true;
+	}
+
+	/* update the last lblk in the region seen so far */
+	rc->last_do_lblk = end;
+
+	/*
+	 * if we're tracking a partial cluster and the current extent
+	 * doesn't start with it, count it and stop tracking
+	 */
+	if (rc->partial && (rc->lclu != EXT4_B2C(sbi, i))) {
+		rc->ndelonly++;
+		rc->partial = false;
+	}
+
+	/*
+	 * if the first cluster doesn't start on a cluster boundary but
+	 * ends on one, count it
+	 */
+	if (EXT4_LBLK_COFF(sbi, i) != 0) {
+		if (end >= EXT4_LBLK_CFILL(sbi, i)) {
+			rc->ndelonly++;
+			rc->partial = false;
+			i = EXT4_LBLK_CFILL(sbi, i) + 1;
+		}
+	}
+
+	/*
+	 * if the current cluster starts on a cluster boundary, count the
+	 * number of whole delonly clusters in the extent
+	 */
+	if ((i + sbi->s_cluster_ratio - 1) <= end) {
+		nclu = (end - i + 1) >> sbi->s_cluster_bits;
+			rc->ndelonly += nclu;
+		i += nclu << sbi->s_cluster_bits;
+	}
+
+	/*
+	 * start tracking a partial cluster if there's a partial at the end
+	 * of the current extent and we're not already tracking one
+	 */
+	if (!rc->partial && i <= end) {
+		rc->partial = true;
+		rc->lclu = EXT4_B2C(sbi, i);
+	}
+}
+
+/*
+ * __pr_tree_search - search for a pending cluster reservation
+ *
+ * @root - root of pending reservation tree
+ * @lclu - logical cluster to search for
+ *
+ * Returns the pending reservation for the cluster identified by @lclu
+ * if found.  If not, returns a reservation for the next cluster if any,
+ * and if not, returns NULL.
+ */
+static struct pending_reservation *__pr_tree_search(struct rb_root *root,
+						    ext4_lblk_t lclu)
+{
+	struct rb_node *node = root->rb_node;
+	struct pending_reservation *pr = NULL;
+
+	while (node) {
+		pr = rb_entry(node, struct pending_reservation, rb_node);
+		if (lclu < pr->lclu)
+			node = node->rb_left;
+		else if (lclu > pr->lclu)
+			node = node->rb_right;
+		else
+			return pr;
+	}
+	if (pr && lclu < pr->lclu)
+		return pr;
+	if (pr && lclu > pr->lclu) {
+		node = rb_next(&pr->rb_node);
+		return node ? rb_entry(node, struct pending_reservation,
+				       rb_node) : NULL;
+	}
+	return NULL;
+}
+
+/*
+ * get_rsvd - calculates and returns the number of cluster reservations to be
+ *	      released when removing a block range from the extent status tree
+ *	      and releases any pending reservations within the range
+ *
+ * @inode - file containing block range
+ * @end - last block in range
+ * @right_es - pointer to extent containing next block beyond end or NULL
+ * @rc - pointer to reserved count data
+ *
+ * The number of reservations to be released is equal to the number of
+ * clusters containing delayed and not unwritten (delonly) blocks within
+ * the range, minus the number of clusters still containing delonly blocks
+ * at the ends of the range, and minus the number of pending reservations
+ * within the range.
+ */
+static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
+			     struct extent_status *right_es,
+			     struct rsvd_count *rc)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct pending_reservation *pr;
+	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
+	struct rb_node *node;
+	ext4_lblk_t first_lclu, last_lclu;
+	bool left_delonly, right_delonly, count_pending;
+	struct extent_status *es;
+
+	if (sbi->s_cluster_ratio > 1) {
+		/* count any remaining partial cluster */
+		if (rc->partial)
+			rc->ndelonly++;
+
+		if (rc->ndelonly == 0)
+			return 0;
+
+		first_lclu = EXT4_B2C(sbi, rc->first_do_lblk);
+		last_lclu = EXT4_B2C(sbi, rc->last_do_lblk);
+
+		/*
+		 * decrease the delonly count by the number of clusters at the
+		 * ends of the range that still contain delonly blocks -
+		 * these clusters still need to be reserved
+		 */
+		left_delonly = right_delonly = false;
+
+		es = rc->left_es;
+		while (es && ext4_es_end(es) >=
+		       EXT4_LBLK_CMASK(sbi, rc->first_do_lblk)) {
+			if (ext4_es_is_delonly(es)) {
+				rc->ndelonly--;
+				left_delonly = true;
+				break;
+			}
+			node = rb_prev(&es->rb_node);
+			if (!node)
+				break;
+			es = rb_entry(node, struct extent_status, rb_node);
+		}
+		if (right_es && (!left_delonly || first_lclu != last_lclu)) {
+			if (end < ext4_es_end(right_es)) {
+				es = right_es;
+			} else {
+				node = rb_next(&right_es->rb_node);
+				es = node ? rb_entry(node, struct extent_status,
+						     rb_node) : NULL;
+			}
+			while (es && es->es_lblk <=
+			       EXT4_LBLK_CFILL(sbi, rc->last_do_lblk)) {
+				if (ext4_es_is_delonly(es)) {
+					rc->ndelonly--;
+					right_delonly = true;
+					break;
+				}
+				node = rb_next(&es->rb_node);
+				if (!node)
+					break;
+				es = rb_entry(node, struct extent_status,
+					      rb_node);
+			}
+		}
+
+		/*
+		 * Determine the block range that should be searched for
+		 * pending reservations, if any.  Clusters on the ends of the
+		 * original removed range containing delonly blocks are
+		 * excluded.  They've already been accounted for and it's not
+		 * possible to determine if an associated pending reservation
+		 * should be released with the information available in the
+		 * extents status tree.
+		 */
+		if (first_lclu == last_lclu) {
+			if (left_delonly | right_delonly)
+				count_pending = false;
+			else
+				count_pending = true;
+		} else {
+			if (left_delonly)
+				first_lclu++;
+			if (right_delonly)
+				last_lclu--;
+			if (first_lclu <= last_lclu)
+				count_pending = true;
+			else
+				count_pending = false;
+		}
+
+		/*
+		 * a pending reservation found between first_lclu and last_lclu
+		 * represents an allocated cluster that contained at least one
+		 * delonly block, so the delonly total must be reduced by one
+		 * for each pending reservation found and released
+		 */
+		if (count_pending) {
+			pr = __pr_tree_search(&tree->root, first_lclu);
+			while (pr && pr->lclu <= last_lclu) {
+				rc->ndelonly--;
+				node = rb_next(&pr->rb_node);
+				rb_erase(&pr->rb_node, &tree->root);
+				kmem_cache_free(ext4_pending_cachep, pr);
+				if (!node)
+					break;
+				pr = rb_entry(node, struct pending_reservation,
+					      rb_node);
+			}
+		}
+	}
+	return rc->ndelonly;
+}
+
+
+/*
+ * __es_remove_extent - removes block range from extent status tree
+ *
+ * @inode - file containing range
+ * @lblk - first block in range
+ * @end - last block in range
+ * @reserved - number of cluster reservations released
+ *
+ * If @reserved is not NULL and delayed allocation is enabled, counts
+ * block/cluster reservations freed by removing range and if bigalloc
+ * enabled cancels pending reservations as needed. Returns 0 on success,
+ * error code on failure.
+ */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end)
+			      ext4_lblk_t end, int *reserved)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -968,9 +1282,14 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
 	int err;
+	bool count_reserved = true;
+	struct rsvd_count rc;
 
+	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
+		count_reserved = false;
 retry:
 	err = 0;
+
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
 		goto out;
@@ -979,6 +1298,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	/* Simply invalidate cache_es. */
 	tree->cache_es = NULL;
+	if (count_reserved)
+		init_rsvd(inode, lblk, es, &rc);
 
 	orig_es.es_lblk = es->es_lblk;
 	orig_es.es_len = es->es_len;
@@ -1020,10 +1341,16 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 				ext4_es_store_pblock(es, block);
 			}
 		}
+		if (count_reserved)
+			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
+				   &orig_es, &rc);
 		goto out;
 	}
 
 	if (len1 > 0) {
+		if (count_reserved)
+			count_rsvd(inode, lblk, orig_es.es_len - len1,
+				   &orig_es, &rc);
 		node = rb_next(&es->rb_node);
 		if (node)
 			es = rb_entry(node, struct extent_status, rb_node);
@@ -1032,6 +1359,8 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	}
 
 	while (es && ext4_es_end(es) <= end) {
+		if (count_reserved)
+			count_rsvd(inode, es->es_lblk, es->es_len, es, &rc);
 		node = rb_next(&es->rb_node);
 		rb_erase(&es->rb_node, &tree->root);
 		ext4_es_free_extent(inode, es);
@@ -1046,6 +1375,9 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		ext4_lblk_t orig_len = es->es_len;
 
 		len1 = ext4_es_end(es) - end;
+		if (count_reserved)
+			count_rsvd(inode, es->es_lblk, orig_len - len1,
+				   es, &rc);
 		es->es_lblk = end + 1;
 		es->es_len = len1;
 		if (ext4_es_is_written(es) || ext4_es_is_unwritten(es)) {
@@ -1054,20 +1386,28 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 		}
 	}
 
+	if (count_reserved)
+		*reserved = get_rsvd(inode, end, es, &rc);
 out:
 	return err;
 }
 
 /*
- * ext4_es_remove_extent() removes a space from a extent status tree.
+ * ext4_es_remove_extent - removes block range from extent status tree
  *
- * Return 0 on success, error code on failure.
+ * @inode - file containing range
+ * @lblk - first block in range
+ * @len - number of blocks to remove
+ *
+ * Reduces block/cluster reservation count and for bigalloc cancels pending
+ * reservations as needed. Returns 0 on success, error code on failure.
  */
 int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 			  ext4_lblk_t len)
 {
 	ext4_lblk_t end;
 	int err = 0;
+	int reserved = 0;
 
 	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
@@ -1085,9 +1425,10 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end);
+	err = __es_remove_extent(inode, lblk, end, &reserved);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	ext4_es_print_tree(inode);
+	ext4_da_release_space(inode, reserved);
 	return err;
 }
 
@@ -1317,6 +1658,7 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
 	es = __es_tree_search(&tree->root, ei->i_es_shrink_lblk);
 	if (!es)
 		goto out_wrap;
+
 	while (*nr_to_scan > 0) {
 		if (es->es_lblk > end) {
 			ei->i_es_shrink_lblk = end + 1;
@@ -1590,7 +1932,7 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk);
+	err = __es_remove_extent(inode, lblk, lblk, NULL);
 	if (err != 0)
 		goto error;
 retry:
@@ -1779,93 +2121,3 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			__remove_pending(inode, last);
 	}
 }
-
-/*
- * ext4_es_remove_blks - remove block range from extents status tree and
- *                       reduce reservation count or cancel pending
- *                       reservation as needed
- *
- * @inode - file containing range
- * @lblk - first block in range
- * @len - number of blocks to remove
- *
- */
-void ext4_es_remove_blks(struct inode *inode, ext4_lblk_t lblk,
-			 ext4_lblk_t len)
-{
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	unsigned int clu_size, reserved = 0;
-	ext4_lblk_t last_lclu, first, length, remainder, last;
-	bool delonly;
-	int err = 0;
-	struct pending_reservation *pr;
-	struct ext4_pending_tree *tree;
-
-	/*
-	 * Process cluster by cluster for bigalloc - there may be up to
-	 * two clusters in a 4k page with a 1k block size and two blocks
-	 * per cluster.  Also necessary for systems with larger page sizes
-	 * and potentially larger block sizes.
-	 */
-	clu_size = sbi->s_cluster_ratio;
-	last_lclu = EXT4_B2C(sbi, lblk + len - 1);
-
-	write_lock(&EXT4_I(inode)->i_es_lock);
-
-	for (first = lblk, remainder = len;
-	     remainder > 0;
-	     first += length, remainder -= length) {
-
-		if (EXT4_B2C(sbi, first) == last_lclu)
-			length = remainder;
-		else
-			length = clu_size - EXT4_LBLK_COFF(sbi, first);
-
-		/*
-		 * The BH_Delay flag, which triggers calls to this function,
-		 * and the contents of the extents status tree can be
-		 * inconsistent due to writepages activity. So, note whether
-		 * the blocks to be removed actually belong to an extent with
-		 * delayed only status.
-		 */
-		delonly = __es_scan_clu(inode, &ext4_es_is_delonly, first);
-
-		/*
-		 * because of the writepages effect, written and unwritten
-		 * blocks could be removed here
-		 */
-		last = first + length - 1;
-		err = __es_remove_extent(inode, first, last);
-		if (err)
-			ext4_warning(inode->i_sb,
-				     "%s: couldn't remove page (err = %d)",
-				     __func__, err);
-
-		/* non-bigalloc case: simply count the cluster for release */
-		if (sbi->s_cluster_ratio == 1 && delonly) {
-			reserved++;
-			continue;
-		}
-
-		/*
-		 * bigalloc case: if all delayed allocated only blocks have
-		 * just been removed from a cluster, either cancel a pending
-		 * reservation if it exists or count a cluster for release
-		 */
-		if (delonly &&
-		    !__es_scan_clu(inode, &ext4_es_is_delonly, first)) {
-			pr = __get_pending(inode, EXT4_B2C(sbi, first));
-			if (pr != NULL) {
-				tree = &EXT4_I(inode)->i_pending_tree;
-				rb_erase(&pr->rb_node, &tree->root);
-				kmem_cache_free(ext4_pending_cachep, pr);
-			} else {
-				reserved++;
-			}
-		}
-	}
-
-	write_unlock(&EXT4_I(inode)->i_es_lock);
-
-	ext4_da_release_space(inode, reserved);
-}
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 131a8b7df265..93a7abfff4af 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -246,7 +246,5 @@ extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 					bool allocated);
 extern unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
 					ext4_lblk_t len);
-extern void ext4_es_remove_blks(struct inode *inode, ext4_lblk_t lblk,
-				ext4_lblk_t len);
 
 #endif /* _EXT4_EXTENTS_STATUS_H */
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 420fe3deed39..bc6b28b26f00 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1646,49 +1646,6 @@ void ext4_da_release_space(struct inode *inode, int to_free)
 	dquot_release_reservation_block(inode, EXT4_C2B(sbi, to_free));
 }
 
-static void ext4_da_page_release_reservation(struct page *page,
-					     unsigned int offset,
-					     unsigned int length)
-{
-	int contiguous_blks = 0;
-	struct buffer_head *head, *bh;
-	unsigned int curr_off = 0;
-	struct inode *inode = page->mapping->host;
-	unsigned int stop = offset + length;
-	ext4_fsblk_t lblk;
-
-	BUG_ON(stop > PAGE_SIZE || stop < length);
-
-	head = page_buffers(page);
-	bh = head;
-	do {
-		unsigned int next_off = curr_off + bh->b_size;
-
-		if (next_off > stop)
-			break;
-
-		if ((offset <= curr_off) && (buffer_delay(bh))) {
-			contiguous_blks++;
-			clear_buffer_delay(bh);
-		} else if (contiguous_blks) {
-			lblk = page->index <<
-			       (PAGE_SHIFT - inode->i_blkbits);
-			lblk += (curr_off >> inode->i_blkbits) -
-				contiguous_blks;
-			ext4_es_remove_blks(inode, lblk, contiguous_blks);
-			contiguous_blks = 0;
-		}
-		curr_off = next_off;
-	} while ((bh = bh->b_this_page) != head);
-
-	if (contiguous_blks) {
-		lblk = page->index << (PAGE_SHIFT - inode->i_blkbits);
-		lblk += (curr_off >> inode->i_blkbits) - contiguous_blks;
-		ext4_es_remove_blks(inode, lblk, contiguous_blks);
-	}
-
-}
-
 /*
  * Delayed allocation stuff
  */
@@ -3227,24 +3184,6 @@ static int ext4_da_write_end(struct file *file,
 	return ret ? ret : copied;
 }
 
-static void ext4_da_invalidatepage(struct page *page, unsigned int offset,
-				   unsigned int length)
-{
-	/*
-	 * Drop reserved blocks
-	 */
-	BUG_ON(!PageLocked(page));
-	if (!page_has_buffers(page))
-		goto out;
-
-	ext4_da_page_release_reservation(page, offset, length);
-
-out:
-	ext4_invalidatepage(page, offset, length);
-
-	return;
-}
-
 /*
  * Force all delayed allocation blocks to be allocated for a given inode.
  */
@@ -3985,7 +3924,7 @@ static const struct address_space_operations ext4_da_aops = {
 	.write_end		= ext4_da_write_end,
 	.set_page_dirty		= ext4_set_page_dirty,
 	.bmap			= ext4_bmap,
-	.invalidatepage		= ext4_da_invalidatepage,
+	.invalidatepage		= ext4_invalidatepage,
 	.releasepage		= ext4_releasepage,
 	.direct_IO		= ext4_direct_IO,
 	.migratepage		= buffer_migrate_page,
-- 
2.11.0

