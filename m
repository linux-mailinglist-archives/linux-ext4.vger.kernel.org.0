Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2BD679934F
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Sep 2023 02:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345456AbjIIAYX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 20:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345446AbjIIAYT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 20:24:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2422135;
        Fri,  8 Sep 2023 17:23:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3366C433CD;
        Sat,  9 Sep 2023 00:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694218965;
        bh=CPTp+VSDvg3Xfr/v0b+rpwwljDH5hGkjnZj0/8O5iPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ldf2nSOPUHrtwUBRjqhVW+pxvgS6i+H3CpACwNnDU3QGupuVwtkSZyni/sN/6k2R/
         uPhNwvFXb92oqVZNTieNhAxZotmLwdEYf56WXG06Z9dqlgB84TN4AFS0bIRmdq0j2S
         0GLnA6+SrXDCtvuEAR1M+ntmjPtadDA6VZMO3xvYQoNI6app8WY6Fftp8la8meKco8
         zW4tM4qzoXDQKUuGqMv03zEM3Bxwe1vlaU6FtPZFLz8xsGPCDfk8CyJdRBE9USDIOI
         uXbfFGbYryW3X6/8qOwSu/pcWmBYOJQr2RGchM8bPtXGYjA3b7GRC04l64D8xwJPuD
         OiFZ7pcS5Qkig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 05/11] ext4: avoid overlapping preallocations due to overflow
Date:   Fri,  8 Sep 2023 20:22:25 -0400
Message-Id: <20230909002233.3578213-5-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909002233.3578213-1-sashal@kernel.org>
References: <20230909002233.3578213-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit bedc5d34632c21b5adb8ca7143d4c1f794507e4c ]

Let's say we want to allocate 2 blocks starting from 4294966386, after
predicting the file size, start is aligned to 4294965248, len is changed
to 2048, then end = start + size = 0x100000000. Since end is of
type ext4_lblk_t, i.e. uint, end is truncated to 0.

This causes (pa->pa_lstart >= end) to always hold when checking if the
current extent to be allocated crosses already preallocated blocks, so the
resulting ac_g_ex may cross already preallocated blocks. Hence we convert
the end type to loff_t and use pa_logical_end() to avoid overflow.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230724121059.11834-4-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f17c1573c2a65..6e88f58ec6bb8 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4036,12 +4036,13 @@ ext4_mb_pa_rb_next_iter(ext4_lblk_t new_start, ext4_lblk_t cur_start, struct rb_
 
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
@@ -4050,7 +4051,7 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		spin_lock(&tmp_pa->pa_lock);
 		if (tmp_pa->pa_deleted == 0)
@@ -4072,14 +4073,14 @@ ext4_mb_pa_assert_overlap(struct ext4_allocation_context *ac,
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
@@ -4098,7 +4099,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 		tmp_pa = rb_entry(iter, struct ext4_prealloc_space,
 				  pa_node.inode_node);
 		tmp_pa_start = tmp_pa->pa_lstart;
-		tmp_pa_end = tmp_pa->pa_lstart + EXT4_C2B(sbi, tmp_pa->pa_len);
+		tmp_pa_end = pa_logical_end(sbi, tmp_pa);
 
 		/* PA must not overlap original request */
 		spin_lock(&tmp_pa->pa_lock);
@@ -4178,8 +4179,7 @@ ext4_mb_pa_adjust_overlap(struct ext4_allocation_context *ac,
 	}
 
 	if (left_pa) {
-		left_pa_end =
-			left_pa->pa_lstart + EXT4_C2B(sbi, left_pa->pa_len);
+		left_pa_end = pa_logical_end(sbi, left_pa);
 		BUG_ON(left_pa_end > ac->ac_o_ex.fe_logical);
 	}
 
@@ -4218,8 +4218,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
 	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
-	ext4_lblk_t end;
-	loff_t size, start_off;
+	loff_t size, start_off, end;
 	loff_t orig_size __maybe_unused;
 	ext4_lblk_t start;
 
-- 
2.40.1

