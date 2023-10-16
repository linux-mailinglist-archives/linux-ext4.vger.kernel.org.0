Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFA77CB3C9
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbjJPUL3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjJPUL0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5EFF9;
        Mon, 16 Oct 2023 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=eaiCDWjet90GQNy1+yChdRMV1jDPIZJLwvtj63jJ5Tg=; b=IPeWfE1a6pKBalmfulbCgDbLgg
        naLgWrsTqg99WBPVv0Q/JmcFdOaWg7RiFZpXT1cOMbq+kj9bfUSJckIFLDnZt5vgqFTPPkZJ/bFmi
        kgDL2YNFlqp4BVZaCKESR/jzRc0krGNFv3EtNSfKxaw2AhGVu48YgrC7eNEzCPvaPmXylnPBaslG4
        lD+pkR0VvDZN0716ag7k3r9tJl4vPJYzLkqOge7IUbtFFhaY5RfLEhkvsZ5jT4aKnqcs/oX+OnJFh
        eybeC+CJE0K3Dk9WTIVz53Eg/jBPggPxuHtAUMq5e+r4XzuJ5idWf5UpiqQT5IWTnoKd2hDO8ivVO
        ay39jQyg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvq-0085bS-5a; Mon, 16 Oct 2023 20:11:18 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 14/27] nilfs2: Convert nilfs_mdt_get_frozen_buffer to use a folio
Date:   Mon, 16 Oct 2023 21:11:01 +0100
Message-Id: <20231016201114.1928083-15-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231016201114.1928083-1-willy@infradead.org>
References: <20231016201114.1928083-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Remove a number of folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/mdt.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 11b7cf4acc92..7b754e6494d7 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -592,17 +592,19 @@ nilfs_mdt_get_frozen_buffer(struct inode *inode, struct buffer_head *bh)
 {
 	struct nilfs_shadow_map *shadow = NILFS_MDT(inode)->mi_shadow;
 	struct buffer_head *bh_frozen = NULL;
-	struct page *page;
+	struct folio *folio;
 	int n;
 
-	page = find_lock_page(shadow->inode->i_mapping, bh->b_folio->index);
-	if (page) {
-		if (page_has_buffers(page)) {
+	folio = filemap_lock_folio(shadow->inode->i_mapping,
+			bh->b_folio->index);
+	if (!IS_ERR(folio)) {
+		bh_frozen = folio_buffers(folio);
+		if (bh_frozen) {
 			n = bh_offset(bh) >> inode->i_blkbits;
-			bh_frozen = nilfs_page_get_nth_block(page, n);
+			bh_frozen = get_nth_bh(bh_frozen, n);
 		}
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 	}
 	return bh_frozen;
 }
-- 
2.40.1

