Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EDA553D35
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jun 2022 23:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356404AbiFUVAG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jun 2022 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355772AbiFUU67 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jun 2022 16:58:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA592F3B1;
        Tue, 21 Jun 2022 13:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6444B81B31;
        Tue, 21 Jun 2022 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC3C36AE5;
        Tue, 21 Jun 2022 20:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844699;
        bh=/dsJUZBO8NycqZTVjAkJb1HLromYytPVjT/q+n/KWX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lu3qylz7wifdfAF7uDwQOAi7i1t3MF1pVhqXY0Mnn0JJmwl+6PIrjYrt3Bb15L4vE
         u8BqB14pT5cShtXeXk1qDIZHY3GbgCeMgsBFNzLe+VvTUYFbvPL/FSo4Eg/jgs/3Oe
         ArDEw8GG68nHjwnJx2fYi+Jd1eSaZiW3TEn7vJKX7M7jtcFxskAoLwLPqysm+UYuw8
         gQdnrsjgCcHXOFmwPs555UjKe9wIlfTJ9nsoRnPS25zu7KlBr5KHyaUpV5Mv8NcPfO
         1TEe+OsE/3GfgaxBhgHxK0SsYbF4cavhvHSv3S/NVxlpZZiYt+JQNcmtCjMAY0UH0S
         QNO4kTO2Eo8EA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/7] ext4: correct the judgment of BUG in ext4_mb_normalize_request
Date:   Tue, 21 Jun 2022 16:51:29 -0400
Message-Id: <20220621205130.250874-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205130.250874-1-sashal@kernel.org>
References: <20220621205130.250874-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit cf4ff938b47fc5c00b0ccce53a3b50eca9b32281 ]

ext4_mb_normalize_request() can move logical start of allocated blocks
to reduce fragmentation and better utilize preallocation. However logical
block requested as a start of allocation (ac->ac_o_ex.fe_logical) should
always be covered by allocated blocks so we should check that by
modifying and to or in the assertion.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
Link: https://lore.kernel.org/r/20220528110017.354175-3-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/mballoc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index db8243627b08..0f7cbb59419b 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3242,7 +3242,22 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
 	}
 	rcu_read_unlock();
 
-	if (start + size <= ac->ac_o_ex.fe_logical &&
+	/*
+	 * In this function "start" and "size" are normalized for better
+	 * alignment and length such that we could preallocate more blocks.
+	 * This normalization is done such that original request of
+	 * ac->ac_o_ex.fe_logical & fe_len should always lie within "start" and
+	 * "size" boundaries.
+	 * (Note fe_len can be relaxed since FS block allocation API does not
+	 * provide gurantee on number of contiguous blocks allocation since that
+	 * depends upon free space left, etc).
+	 * In case of inode pa, later we use the allocated blocks
+	 * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
+	 * range of goal/best blocks [start, size] to put it at the
+	 * ac_o_ex.fe_logical extent of this inode.
+	 * (See ext4_mb_use_inode_pa() for more details)
+	 */
+	if (start + size <= ac->ac_o_ex.fe_logical ||
 			start > ac->ac_o_ex.fe_logical) {
 		ext4_msg(ac->ac_sb, KERN_ERR,
 			 "start %lu, size %lu, fe_logical %lu",
-- 
2.35.1

