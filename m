Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414F16F75EB
	for <lists+linux-ext4@lfdr.de>; Thu,  4 May 2023 22:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjEDUCw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 May 2023 16:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEDUCD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 May 2023 16:02:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CBB93C0;
        Thu,  4 May 2023 12:51:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E96E63827;
        Thu,  4 May 2023 19:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91352C433EF;
        Thu,  4 May 2023 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229812;
        bh=87kDSNdz+yn5gFGofybi143XxloqY9/1QSbIS8dmNnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DDgnwxwVZ5BOpuOls3UYmaPabmB/p8VPisW8xmKMKyCdKpL8Yvwu3H5yxcAMY8AgC
         kU9UfZukPRqqyASfM54ZPmFeIlhB8zrFSvJq6jclgfzWqVAdqKxXAuiJUnaKoAWRSm
         pZMR6Bs3MGJzg45QUZBwTHb/DZ7qXnz4E81lIqYVwsKdoWgSVFoepRsDIm4Int0n4R
         PPF0k+7C9Cg2ZpVycrTKK3bwanb0qSX4hkrStX8Naez91NMVhK1Id+Tjk6Kr8sbVHL
         XEqeSLZnC5i7uALlck8fMFa7G2WMpRw1T1TM2teUXulBNdW48zjqpft10zKjEJVxjp
         CyOF0b8ihW51Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kemeng Shi <shikemeng@huaweicloud.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 13/24] ext4: set goal start correctly in ext4_mb_normalize_request
Date:   Thu,  4 May 2023 15:49:26 -0400
Message-Id: <20230504194937.3808414-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194937.3808414-1-sashal@kernel.org>
References: <20230504194937.3808414-1-sashal@kernel.org>
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

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit b07ffe6927c75d99af534d685282ea188d9f71a6 ]

We need to set ac_g_ex to notify the goal start used in
ext4_mb_find_by_goal. Set ac_g_ex instead of ac_f_ex in
ext4_mb_normalize_request.
Besides we should assure goal start is in range [first_data_block,
blocks_count) as ext4_mb_initialize_context does.

[ Added a check to make sure size is less than ar->pright; otherwise
  we could end up passing an underflowed value of ar->pright - size to
  ext4_get_group_no_and_offset(), which will trigger a BUG_ON later on.
  - TYT ]

Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20230303172120.3800725-2-shikemeng@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 843840c2aced9..6785b4653d1d2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3439,6 +3439,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
+	struct ext4_super_block *es = sbi->s_es;
 	int bsbits, max;
 	ext4_lblk_t end;
 	loff_t size, start_off;
@@ -3619,18 +3620,21 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
 
 	/* define goal start in order to merge */
-	if (ar->pright && (ar->lright == (start + size))) {
+	if (ar->pright && (ar->lright == (start + size)) &&
+	    ar->pright >= size &&
+	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {
 		/* merge to the right */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
-	if (ar->pleft && (ar->lleft + 1 == start)) {
+	if (ar->pleft && (ar->lleft + 1 == start) &&
+	    ar->pleft + 1 < ext4_blocks_count(es)) {
 		/* merge to the left */
 		ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
-						&ac->ac_f_ex.fe_group,
-						&ac->ac_f_ex.fe_start);
+						&ac->ac_g_ex.fe_group,
+						&ac->ac_g_ex.fe_start);
 		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
 	}
 
-- 
2.39.2

