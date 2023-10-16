Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D917CB3C6
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjJPUL1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjJPULZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2A4F5;
        Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7mXlnt1yRIMT4o+dXNcAaQaKhOKfQBuaGyVOIxKhilk=; b=mLOzLL1MAsvOzcF2Nfxy8DlEW9
        KqVXhXbvURDI6XFJEenJqK0xoOqPMXJEMTTYt/w7KPuNhXf7hgVbqU/yzVTnj8xqbKKYZ848lsrsp
        sWgSDaoVJ2u8Anm+cyMry3h+5JJKok7IPEz8XLRLV4sfjpfbCNMgvhKxmhNb4iPeOmLfw8HqfPCo+
        GaJeKn092L2S/NhRc+Y2qApEy0Pjv+69uUInXENTG1ES3OdYfpt8uiWZNcUBxnCXVKwyn1Qdwglc0
        dbUvBa4yfk0P8B0Pb4n9DSwIp/QZfxMHVsF52xzmuXxasjuojFnh6avfilIZeDJZt3kFLNOw1jzpj
        k7rRI1sg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvp-0085bA-PH; Mon, 16 Oct 2023 20:11:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 11/27] nilfs2: Convert nilfs_grab_buffer() to use a folio
Date:   Mon, 16 Oct 2023 21:10:58 +0100
Message-Id: <20231016201114.1928083-12-willy@infradead.org>
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
 fs/nilfs2/page.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index b4e54d079b7d..1c075bd906c9 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -25,19 +25,19 @@
 	(BIT(BH_Uptodate) | BIT(BH_Mapped) | BIT(BH_NILFS_Node) |	\
 	 BIT(BH_NILFS_Volatile) | BIT(BH_NILFS_Checked))
 
-static struct buffer_head *
-__nilfs_get_page_block(struct page *page, unsigned long block, pgoff_t index,
-		       int blkbits, unsigned long b_state)
+static struct buffer_head *__nilfs_get_folio_block(struct folio *folio,
+		unsigned long block, pgoff_t index, int blkbits,
+		unsigned long b_state)
 
 {
 	unsigned long first_block;
-	struct buffer_head *bh;
+	struct buffer_head *bh = folio_buffers(folio);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << blkbits, b_state);
+	if (!bh)
+		bh = folio_create_empty_buffers(folio, 1 << blkbits, b_state);
 
 	first_block = (unsigned long)index << (PAGE_SHIFT - blkbits);
-	bh = nilfs_page_get_nth_block(page, block - first_block);
+	bh = get_nth_bh(bh, block - first_block);
 
 	touch_buffer(bh);
 	wait_on_buffer(bh);
@@ -51,17 +51,17 @@ struct buffer_head *nilfs_grab_buffer(struct inode *inode,
 {
 	int blkbits = inode->i_blkbits;
 	pgoff_t index = blkoff >> (PAGE_SHIFT - blkbits);
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 
-	page = grab_cache_page(mapping, index);
-	if (unlikely(!page))
+	folio = filemap_grab_folio(mapping, index);
+	if (IS_ERR(folio))
 		return NULL;
 
-	bh = __nilfs_get_page_block(page, blkoff, index, blkbits, b_state);
+	bh = __nilfs_get_folio_block(folio, blkoff, index, blkbits, b_state);
 	if (unlikely(!bh)) {
-		unlock_page(page);
-		put_page(page);
+		folio_unlock(folio);
+		folio_put(folio);
 		return NULL;
 	}
 	return bh;
-- 
2.40.1

