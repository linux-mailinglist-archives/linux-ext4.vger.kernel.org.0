Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD864067F
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Dec 2022 13:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbiLBMNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Dec 2022 07:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiLBMNH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Dec 2022 07:13:07 -0500
X-Greylist: delayed 525 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Dec 2022 04:13:06 PST
Received: from out-64.mta0.migadu.com (out-64.mta0.migadu.com [IPv6:2001:41d0:1004:224b::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093852CDD7
        for <linux-ext4@vger.kernel.org>; Fri,  2 Dec 2022 04:13:05 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669982658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ha/pnWpmCN4U/dhNkQWRAml/R07xL0rfPwqlb/e/+Dw=;
        b=DoAeT+gjiMzofj1ovIt+8/IlEyI/vo8dEXYM8T3B+IIqZg44vRTjJ8RIu2eaNSrgyztpq4
        Be72Fmurf5mfTM+dBeEU3ToIF+YqeA+YoAr6/6uiWqaGuQYI6W6fs1EKWGAMHqitplcZyV
        CEKmbvWi7/4dy6w60cBvNqyJzpjsVlQ=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, ojaswin@linux.ibm.com
Subject: [PATCH V2] ext4: make ext4_mb_initialize_context return void
Date:   Fri,  2 Dec 2022 20:04:09 +0800
Message-Id: <20221202120409.24098-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Change the return type to void since it always return 0, and no need
to do the checking in ext4_mb_new_blocks.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
V2 changes:
1. collect tag from Ojaswin, thanks!

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
2.35.3

