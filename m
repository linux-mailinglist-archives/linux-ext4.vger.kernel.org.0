Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119ED6F7633
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 22:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEDUGF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 16:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjEDUER (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 16:04:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415D2270C;
        Thu,  4 May 2023 12:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7E3A6387F;
        Thu,  4 May 2023 19:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFEAC433AC;
        Thu,  4 May 2023 19:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229873;
        bh=rMS9q24w4lb+9uHRN1AtecaROo2SJMGKvnqIcxFAX3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgwpg5efcyISMIxmdQHMEQdEhVe+tljYNm+6qvTKlCYjto2I+kUP80YThI2hJXp3M
         byIKaiii7fe1xCMwWV0cY7mFfhEYnYzu01sko/QyLHkn4NtXOJHYidFSOJlShuJ0HF
         N840d9VhsMsBfbZ48IQnDz0JFUedxzev2MCt0F3zKAHQM373Htg9//xZfymJujBz3K
         R3U5qgkO6SczTwfq60d7+BP4xpPIuapqstL+yKKcSLppVmoj1mVX4LFJKG94XhiHrh
         V+jPmREL+0JKGe2MxN9e9kq0vcLwfruQ/49/QDP38c0Zt77KpfYfK8faJR8MsDhnTD
         3Z8lRNDkl0bww==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/18] ext4: Fix best extent lstart adjustment logic in ext4_mb_new_inode_pa()
Date:   Thu,  4 May 2023 15:50:34 -0400
Message-Id: <20230504195042.3808716-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504195042.3808716-1-sashal@kernel.org>
References: <20230504195042.3808716-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ojaswin Mujoo <ojaswin@linux.ibm.com>

[ Upstream commit 93cdf49f6eca5e23f6546b8f28457b2e6a6961d9 ]

When the length of best extent found is less than the length of goal extent
we need to make sure that the best extent atleast covers the start of the
original request. This is done by adjusting the ac_b_ex.fe_logical (logical
start) of the extent.

While doing so, the current logic sometimes results in the best extent's
logical range overflowing the goal extent. Since this best extent is later
added to the inode preallocation list, we have a possibility of introducing
overlapping preallocations. This is discussed in detail here [1].

As per Jan's suggestion, to fix this, replace the existing logic with the
below logic for adjusting best extent as it keeps fragmentation in check
while ensuring logical range of best extent doesn't overflow out of goal
extent:

1. Check if best extent can be kept at end of goal range and still cover
   original start.
2. Else, check if best extent can be kept at start of goal range and still
   cover original start.
3. Else, keep the best extent at start of original request.

Also, add a few extra BUG_ONs that might help catch errors faster.

[1] https://lore.kernel.org/r/Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/f96aca6d415b36d1f90db86c1a8cd7e2e9d7ab0e.1679731817.git.ojaswin@linux.ibm.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 49 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index f61e8eabd7966..6454e97b66a3e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3378,6 +3378,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
 	BUG_ON(start < pa->pa_pstart);
 	BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
 	BUG_ON(pa->pa_free < len);
+	BUG_ON(ac->ac_b_ex.fe_len <= 0);
 	pa->pa_free -= len;
 
 	mb_debug(1, "use %llu/%u from inode pa %p\n", start, len, pa);
@@ -3682,10 +3683,8 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		return -ENOMEM;
 
 	if (ac->ac_b_ex.fe_len < ac->ac_g_ex.fe_len) {
-		int winl;
-		int wins;
-		int win;
-		int offs;
+		int new_bex_start;
+		int new_bex_end;
 
 		/* we can't allocate as much as normalizer wants.
 		 * so, found space must get proper lstart
@@ -3693,26 +3692,40 @@ ext4_mb_new_inode_pa(struct ext4_allocation_context *ac)
 		BUG_ON(ac->ac_g_ex.fe_logical > ac->ac_o_ex.fe_logical);
 		BUG_ON(ac->ac_g_ex.fe_len < ac->ac_o_ex.fe_len);
 
-		/* we're limited by original request in that
-		 * logical block must be covered any way
-		 * winl is window we can move our chunk within */
-		winl = ac->ac_o_ex.fe_logical - ac->ac_g_ex.fe_logical;
+		/*
+		 * Use the below logic for adjusting best extent as it keeps
+		 * fragmentation in check while ensuring logical range of best
+		 * extent doesn't overflow out of goal extent:
+		 *
+		 * 1. Check if best ex can be kept at end of goal and still
+		 *    cover original start
+		 * 2. Else, check if best ex can be kept at start of goal and
+		 *    still cover original start
+		 * 3. Else, keep the best ex at start of original request.
+		 */
+		new_bex_end = ac->ac_g_ex.fe_logical +
+			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
+		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical >= new_bex_start)
+			goto adjust_bex;
 
-		/* also, we should cover whole original request */
-		wins = EXT4_C2B(sbi, ac->ac_b_ex.fe_len - ac->ac_o_ex.fe_len);
+		new_bex_start = ac->ac_g_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
+		if (ac->ac_o_ex.fe_logical < new_bex_end)
+			goto adjust_bex;
 
-		/* the smallest one defines real window */
-		win = min(winl, wins);
+		new_bex_start = ac->ac_o_ex.fe_logical;
+		new_bex_end =
+			new_bex_start + EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
 
-		offs = ac->ac_o_ex.fe_logical %
-			EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
-		if (offs && offs < win)
-			win = offs;
+adjust_bex:
+		ac->ac_b_ex.fe_logical = new_bex_start;
 
-		ac->ac_b_ex.fe_logical = ac->ac_o_ex.fe_logical -
-			EXT4_NUM_B2C(sbi, win);
 		BUG_ON(ac->ac_o_ex.fe_logical < ac->ac_b_ex.fe_logical);
 		BUG_ON(ac->ac_o_ex.fe_len > ac->ac_b_ex.fe_len);
+		BUG_ON(new_bex_end > (ac->ac_g_ex.fe_logical +
+				      EXT4_C2B(sbi, ac->ac_g_ex.fe_len)));
 	}
 
 	/* preallocation can change ac_b_ex, thus we store actually
-- 
2.39.2

