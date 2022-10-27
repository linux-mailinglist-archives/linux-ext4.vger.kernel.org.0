Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D560EE81
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Oct 2022 05:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiJ0DZl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Oct 2022 23:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0DZg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Oct 2022 23:25:36 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A575238682
        for <linux-ext4@vger.kernel.org>; Wed, 26 Oct 2022 20:25:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666841132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aRCigekfpx85T4zCTIHfLREdwNm1SN2MRRzRbiwnRxY=;
        b=U/dUCHtobZBGtLg22Y59eWCPDyy9enoX5CgnIodEs1q8ZD1QTQuFyWCQgXig9cKAxtoqkC
        R37TmEHBZup4Pi+Pp5MuY0b2h47067MO9ziYWsrQP9eQ4+yYRPt4FEgkOEqlSABooOaQVV
        mypCGIBr+cR358oUKMEv96jNsqT7gDc=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: make ext4_mb_initialize_context return void
Date:   Thu, 27 Oct 2022 11:24:35 +0800
Message-Id: <20221027032435.27374-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Change the return type to void since it always return 0, and no need
to do the checking in ext4_mb_new_blocks.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/ext4/mballoc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dad93059945..5b2ae37a8b80 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5204,7 +5204,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
 	mutex_lock(&ac->ac_lg->lg_mutex);
 }
 
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 				struct ext4_allocation_request *ar)
 {
@@ -5253,8 +5253,6 @@ ext4_mb_initialize_context(struct ext4_allocation_context *ac,
 			(unsigned) ar->lleft, (unsigned) ar->pleft,
 			(unsigned) ar->lright, (unsigned) ar->pright,
 			inode_is_open_for_write(ar->inode) ? "" : "non-");
-	return 0;
-
 }
 
 static noinline_for_stack void
@@ -5591,11 +5589,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 		goto out;
 	}
 
-	*errp = ext4_mb_initialize_context(ac, ar);
-	if (*errp) {
-		ar->len = 0;
-		goto out;
-	}
+	ext4_mb_initialize_context(ac, ar);
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
 	seq = this_cpu_read(discard_pa_seq);
-- 
2.31.1

