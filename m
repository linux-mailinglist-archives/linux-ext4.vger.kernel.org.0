Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B94710C3B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 May 2023 14:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjEYMmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 May 2023 08:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjEYMmN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 May 2023 08:42:13 -0400
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C132A12E
        for <linux-ext4@vger.kernel.org>; Thu, 25 May 2023 05:42:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685018150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iIkKw4mJfDwljRhxaU0K6NYTacSH7x6TqjHBNwD3Ht8=;
        b=uWwGy61Bg1UZqjDZPXEbRcaW3xZeyJ7ULtJYteifEsW4jHI7UIuxc3BndvQiQLy4v+jv7N
        go6yxcAFZ6UOEwQije6PYTXzuDO4DPTy6/gg17G/oa+an9lYzikRnrm/9ak3r/gQGkaHOl
        JdNjk+Yx5IiS4qo2CUZDCR+HsrIwzoE=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/2] ext4: cleanup ext4_issue_discard
Date:   Thu, 25 May 2023 20:35:36 +0800
Message-Id: <20230525123537.22543-2-guoqing.jiang@linux.dev>
In-Reply-To: <20230525123537.22543-1-guoqing.jiang@linux.dev>
References: <20230525123537.22543-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We can remove the 'biop' parameter and remove the 'if'
branch in ext4_issue_discard, since all call sites pass
NULL to biop with commit 55cdd0af2bc5 ("ext4: get discard
out of jbd2 commit kthread contex").

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/ext4/mballoc.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7b2e36d103cb..5fabb34869bf 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3604,8 +3604,7 @@ int ext4_mb_release(struct super_block *sb)
 }
 
 static inline int ext4_issue_discard(struct super_block *sb,
-		ext4_group_t block_group, ext4_grpblk_t cluster, int count,
-		struct bio **biop)
+		ext4_group_t block_group, ext4_grpblk_t cluster, int count)
 {
 	ext4_fsblk_t discard_block;
 
@@ -3614,13 +3613,7 @@ static inline int ext4_issue_discard(struct super_block *sb,
 	count = EXT4_C2B(EXT4_SB(sb), count);
 	trace_ext4_discard_blocks(sb,
 			(unsigned long long) discard_block, count);
-	if (biop) {
-		return __blkdev_issue_discard(sb->s_bdev,
-			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
-			(sector_t)count << (sb->s_blocksize_bits - 9),
-			GFP_NOFS, biop);
-	} else
-		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
+	return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
 }
 
 static void ext4_free_data_in_buddy(struct super_block *sb,
@@ -6229,8 +6222,7 @@ static void ext4_mb_clear_bb(handle_t *handle, struct inode *inode,
 		 * them with group lock_held
 		 */
 		if (test_opt(sb, DISCARD)) {
-			err = ext4_issue_discard(sb, block_group, bit, count,
-						 NULL);
+			err = ext4_issue_discard(sb, block_group, bit, count);
 			if (err && err != -EOPNOTSUPP)
 				ext4_msg(sb, KERN_WARNING, "discard request in"
 					 " group:%u block:%d count:%lu failed"
@@ -6568,7 +6560,7 @@ __acquires(bitlock)
 	 */
 	mb_mark_used(e4b, &ex);
 	ext4_unlock_group(sb, group);
-	ret = ext4_issue_discard(sb, group, start, count, NULL);
+	ret = ext4_issue_discard(sb, group, start, count);
 	ext4_lock_group(sb, group);
 	mb_free_blocks(NULL, e4b, start, ex.fe_len);
 	return ret;
-- 
2.35.3

