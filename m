Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6182475F5BD
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jul 2023 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjGXMOF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jul 2023 08:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGXMOA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jul 2023 08:14:00 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F229E61;
        Mon, 24 Jul 2023 05:13:59 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R8fCJ2fnqzHqdQ;
        Mon, 24 Jul 2023 20:11:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 20:13:56 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <ritesh.list@gmail.com>, <ojaswin@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH v2 3/3] ext4: avoid overlapping preallocations due to overflow
Date:   Mon, 24 Jul 2023 20:10:59 +0800
Message-ID: <20230724121059.11834-4-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230724121059.11834-1-libaokun1@huawei.com>
References: <20230724121059.11834-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Let's say we want to allocate 2 blocks starting from 4294966386, after
predicting the file size, start is aligned to 4294965248, len is changed
to 2048, then end = start + size = 0x100000000. Since end is of
type ext4_lblk_t, i.e. uint, end is truncated to 0.

This causes (pa->pa_lstart >= end) to always hold when checking if the
current extent to be allocated crosses already preallocated blocks, so the
resulting ac_g_ex may cross already preallocated blocks. Hence we convert
the end type to loff_t and use pa_logical_end() to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/mballoc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 86bce870dc5a..78a4a24e2f57 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4222,12 +4222,13 @@ ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_
 
 static inline void
 ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
-			  ext4_lblk_t start, ext4_lblk_t end)
+			  ext4_lblk_t start, loff_t end)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_prealloc_space *tmp_pa;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end;
+	ext4_lblk_t tmp_pa_start;
+	loff_t tmp_pa_end;
 	struct rb_node *iter;
 
 	read_lock(&ei->i_prealloc_lock);
@@ -4236,7 +4237,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted == 0)
@@ -4258,14 +4259,14 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
  */
 static inline void
 ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
-			  ext4_lblk_t *start, ext4_lblk_t *end)
+			  ext4_lblk_t *start, loff_t *end)
 {
 	struct ext4_inode_info *ei = EXT4_I(ac->ac_inode);
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_prealloc_space *tmp_pa = NULL, *left_pa = NULL, *right_pa = NULL;
 	struct rb_node *iter;
-	ext4_lblk_t new_start, new_end;
-	ext4_lblk_t tmp_pa_start, tmp_pa_end, left_pa_end = -1, right_pa_start = -1;
+	ext4_lblk_t new_start, tmp_pa_start, right_pa_start = -1;
+	loff_t new_end, tmp_pa_end, left_pa_end = -1;
 
 	new_start = *start;
 	new_end = *end;
@@ -4284,7 +4285,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		/* PA must not overlap original request */
 		spin_lock(&tmp_pa->pa_lock);
@@ -4364,8 +4365,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	}
 
 	if (left_pa) {
-		left_pa_end =
-			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
+		left_pa_end = pa_logical_end(sbi, left_pa);
 		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
 	}
 
@@ -4404,8 +4404,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	ext4_lblk_t end;
-	loff_t size, start_off;
+	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 
-- 
2.31.1

