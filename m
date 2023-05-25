Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651FC710C3E
	for <lists+linux-ext4@lfdr.de>; Thu, 25 May 2023 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236025AbjEYMmQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 May 2023 08:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbjEYMmO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 May 2023 08:42:14 -0400
X-Greylist: delayed 381 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 25 May 2023 05:42:11 PDT
Received: from out-3.mta0.migadu.com (out-3.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B7122
        for <linux-ext4@vger.kernel.org>; Thu, 25 May 2023 05:42:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685018151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2e4+8OlS4boi41pbaMcAVvSEwWjZ6g6pbFyN6KESlQE=;
        b=aQXTbKupSzklSRYEs1n8RF/DRqKaJM1amsLHiMUtYuOcVQ0zviEUnFgwcTE1P9zoXAS4iG
        Wz+U32eBL13U677DV4A/yVgomSkdDJ7e/TmlCX1zYYe6HndyZYh5m+5nzBWPMkmJZvV6X0
        XE4rvi8dxPivRtGr5ab1iVnLnLPsCHs=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/2] ext4: make ext4_mb_release_group_pa returns void
Date:   Thu, 25 May 2023 20:35:37 +0800
Message-Id: <20230525123537.22543-3-guoqing.jiang@linux.dev>
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

It is always return 0 and no one check the return value too.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 fs/ext4/mballoc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5fabb34869bf..ae8e6d107347 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5029,7 +5029,7 @@ ext4_mb_release_inode_pa(struct ext4_buddy *e4b, struct buffer_head *bitmap_bh,
 	return 0;
 }
 
-static noinline_for_stack int
+static noinline_for_stack void
 ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 				struct ext4_prealloc_space *pa)
 {
@@ -5043,13 +5043,11 @@ ext4_mb_release_group_pa(struct ext4_buddy *e4b,
 	if (unlikely(group != e4b->bd_group && pa->pa_len != 0)) {
 		ext4_warning(sb, "bad group: expected %u, group %u, pa_start %llu",
 			     e4b->bd_group, group, pa->pa_pstart);
-		return 0;
+		return;
 	}
 	mb_free_blocks(pa->pa_inode, e4b, bit, pa->pa_len);
 	atomic_add(pa->pa_len, &EXT4_SB(sb)->s_mb_discarded);
 	trace_ext4_mballoc_discard(sb, NULL, group, bit, pa->pa_len);
-
-	return 0;
 }
 
 /*
-- 
2.35.3

