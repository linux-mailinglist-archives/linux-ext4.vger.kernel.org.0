Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4DC4EA040
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Mar 2022 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343995AbiC1Tu1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Mar 2022 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiC1TsD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Mar 2022 15:48:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4516E69723;
        Mon, 28 Mar 2022 12:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7B1F612AB;
        Mon, 28 Mar 2022 19:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D6BC3410F;
        Mon, 28 Mar 2022 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648496606;
        bh=zxWq7PkrMpndvDnwYkItpxVvHPTOTfn5VcI31JDhtUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fe1fk9oJfLlvyrxkwzx5Nd+jp8XQkESPuifPE2bREgEVkEnYphbAZo0wAJJ3Z0RcP
         jJe2v3zIa1YlItAye5oEtZg+GIhu2MPPOYPF5EkOC6d7ox3KPWJD+OvjsODx8e0u8S
         2UEQQP9EMUApVb5/ttm+qvoQMR8/vL26sY+ArrfwTkUj7eNgbOalwo4leWSjbG4jTL
         APb6J3rUSSQkbD8AGoNF4NoRqeSwiyhFnLD+DOqTiqHdRrq7BnqpLMKlBP6o8rJlz1
         I94PjTsCLaAIweJ3Ezl9BV8QVkpmEMVgBBgI8d+kRHirqmPJ6lKidq8RzEEpjHcDla
         NFJJiLsxg+6uw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/8] ext4: correct cluster len and clusters changed accounting in ext4_mb_mark_bb
Date:   Mon, 28 Mar 2022 15:43:16 -0400
Message-Id: <20220328194322.1586401-2-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220328194322.1586401-1-sashal@kernel.org>
References: <20220328194322.1586401-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ritesh Harjani <riteshh@linux.ibm.com>

[ Upstream commit a5c0e2fdf7cea535ba03259894dc184e5a4c2800 ]

ext4_mb_mark_bb() currently wrongly calculates cluster len (clen) and
flex_group->free_clusters. This patch fixes that.

Identified based on code review of ext4_mb_mark_bb() function.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/a0b035d536bafa88110b74456853774b64c8ac40.1644992609.git.riteshh@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 110c25824a67..41a115c53bf6 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3320,10 +3320,11 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	ext4_group_t group;
 	ext4_grpblk_t blkoff;
-	int i, clen, err;
+	int i, err;
 	int already;
+	unsigned int clen, clen_changed;
 
-	clen = EXT4_B2C(sbi, len);
+	clen = EXT4_NUM_B2C(sbi, len);
 
 	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
 	bitmap_bh = ext4_read_block_bitmap(sb, group);
@@ -3344,6 +3345,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data) == !state)
 			already++;
 
+	clen_changed = clen - already;
 	if (state)
 		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
 	else
@@ -3356,9 +3358,9 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 						group, gdp));
 	}
 	if (state)
-		clen = ext4_free_group_clusters(sb, gdp) - clen + already;
+		clen = ext4_free_group_clusters(sb, gdp) - clen_changed;
 	else
-		clen = ext4_free_group_clusters(sb, gdp) + clen - already;
+		clen = ext4_free_group_clusters(sb, gdp) + clen_changed;
 
 	ext4_free_group_clusters_set(sb, gdp, clen);
 	ext4_block_bitmap_csum_set(sb, group, gdp, bitmap_bh);
@@ -3368,10 +3370,13 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 
 	if (sbi->s_log_groups_per_flex) {
 		ext4_group_t flex_group = ext4_flex_group(sbi, group);
+		struct flex_groups *fg = sbi_array_rcu_deref(sbi,
+					   s_flex_groups, flex_group);
 
-		atomic64_sub(len,
-			     &sbi_array_rcu_deref(sbi, s_flex_groups,
-						  flex_group)->free_clusters);
+		if (state)
+			atomic64_sub(clen_changed, &fg->free_clusters);
+		else
+			atomic64_add(clen_changed, &fg->free_clusters);
 	}
 
 	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
-- 
2.34.1

