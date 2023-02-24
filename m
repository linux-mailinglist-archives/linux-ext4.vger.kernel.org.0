Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C836A2504
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Feb 2023 00:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjBXXZj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Feb 2023 18:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBXXZj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Feb 2023 18:25:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBA263DE2
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 15:25:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 224F9B81D5A
        for <linux-ext4@vger.kernel.org>; Fri, 24 Feb 2023 23:25:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D87C4339B;
        Fri, 24 Feb 2023 23:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677281135;
        bh=6luuhQSD+ajKK9CmlBCDc0zCfnP0G4oE/imS8DvMI7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=FxQD/uarTwtsPK8dN6rJwN9Kdc+VPPP69xqTmxUP1bflotxYLCgY1MMeRyAOLlH9g
         G9mSP2Ec7MFBtXzG3v61l/gN31EX5QFuK8f577eQvpo1W+XwAGeDPV3/QkIvXoikIb
         6pOxpOsW8S9aTzsj2w03RTk2yKHNugqqUt/QA1krgnGtcgMkeadAQifuFMkmLGU/HZ
         xE7G3lE6AxZFAADc3OIzlVatx0NJ/f4pAGHY+9r6LDvjgFdYvFY4w+pZfjy1uQl5Qh
         ePd0oVsAij3G62irSRPN6dcqTQjIU1f7ZvQbPJnyWqihJ3DLRM/4AXl/696TUTkQxs
         +8G+Vwgf38/WQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     fsverity@lists.linux.dev
Cc:     linux-ext4@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] fs/buffer.c: use b_folio for fsverity work
Date:   Fri, 24 Feb 2023 15:25:30 -0800
Message-Id: <20230224232530.98440-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Use b_folio now that it exists.  This removes an unnecessary call to
compound_head().  No actual change in behavior.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/buffer.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9e1e2add541e..034bece27163 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -308,20 +308,19 @@ static void verify_bh(struct work_struct *work)
 	struct buffer_head *bh = ctx->bh;
 	bool valid;
 
-	valid = fsverity_verify_blocks(page_folio(bh->b_page), bh->b_size,
-				       bh_offset(bh));
+	valid = fsverity_verify_blocks(bh->b_folio, bh->b_size, bh_offset(bh));
 	end_buffer_async_read(bh, valid);
 	kfree(ctx);
 }
 
 static bool need_fsverity(struct buffer_head *bh)
 {
-	struct page *page = bh->b_page;
-	struct inode *inode = page->mapping->host;
+	struct folio *folio = bh->b_folio;
+	struct inode *inode = folio->mapping->host;
 
 	return fsverity_active(inode) &&
 		/* needed by ext4 */
-		page->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
+		folio->index < DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 }
 
 static void decrypt_bh(struct work_struct *work)
-- 
2.39.2

