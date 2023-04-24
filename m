Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156206EC3FB
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Apr 2023 05:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDXDjo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Apr 2023 23:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXDjn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Apr 2023 23:39:43 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E87A2136;
        Sun, 23 Apr 2023 20:39:42 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q4W4R4LZTz17VvH;
        Mon, 24 Apr 2023 11:35:51 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 24 Apr
 2023 11:39:40 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v4 02/12] ext4: add a new helper to check if es must be kept
Date:   Mon, 24 Apr 2023 11:38:36 +0800
Message-ID: <20230424033846.4732-3-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230424033846.4732-1-libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the extent status tree, we have extents which we can just drop without
issues and extents we must not drop - this depends on the extent's status
- currently ext4_es_is_delayed() extents must stay, others may be dropped.

A helper function is added to help determine if the current extent can
be dropped, although only ext4_es_is_delayed() extents cannot be dropped
currently.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/extents_status.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7bc221038c6c..573723b23d19 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -448,6 +448,19 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
+/*
+ * Returns true if we cannot fail to allocate memory for this extent_status
+ * entry and cannot reclaim it until its status changes.
+ */
+static inline bool ext4_es_must_keep(struct extent_status *es)
+{
+	/* fiemap, bigalloc, and seek_data/hole need to use it. */
+	if (ext4_es_is_delayed(es))
+		return true;
+
+	return false;
+}
+
 static struct extent_status *
 ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 		     ext4_fsblk_t pblk)
@@ -460,10 +473,8 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 	es->es_len = len;
 	es->es_pblk = pblk;
 
-	/*
-	 * We don't count delayed extent because we never try to reclaim them
-	 */
-	if (!ext4_es_is_delayed(es)) {
+	/* We never try to reclaim a must kept extent, so we don't count it. */
+	if (!ext4_es_must_keep(es)) {
 		if (!EXT4_I(inode)->i_es_shk_nr++)
 			ext4_es_list_add(inode);
 		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
@@ -481,8 +492,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 	EXT4_I(inode)->i_es_all_nr--;
 	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
 
-	/* Decrease the shrink counter when this es is not delayed */
-	if (!ext4_es_is_delayed(es)) {
+	/* Decrease the shrink counter when we can reclaim the extent. */
+	if (!ext4_es_must_keep(es)) {
 		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
 		if (!--EXT4_I(inode)->i_es_shk_nr)
 			ext4_es_list_del(inode);
@@ -853,7 +864,7 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
 					  128, EXT4_I(inode)))
 		goto retry;
-	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
+	if (err == -ENOMEM && !ext4_es_must_keep(&newes))
 		err = 0;
 
 	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
@@ -1706,11 +1717,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
 
 		(*nr_to_scan)--;
 		node = rb_next(&es->rb_node);
-		/*
-		 * We can't reclaim delayed extent from status tree because
-		 * fiemap, bigallic, and seek_data/hole need to use it.
-		 */
-		if (ext4_es_is_delayed(es))
+
+		if (ext4_es_must_keep(es))
 			goto next;
 		if (ext4_es_is_referenced(es)) {
 			ext4_es_clear_referenced(es);
@@ -1774,7 +1782,7 @@ void ext4_clear_inode_es(struct inode *inode)
 	while (node) {
 		es = rb_entry(node, struct extent_status, rb_node);
 		node = rb_next(node);
-		if (!ext4_es_is_delayed(es)) {
+		if (!ext4_es_must_keep(es)) {
 			rb_erase(&es->rb_node, &tree->root);
 			ext4_es_free_extent(inode, es);
 		}
-- 
2.31.1

