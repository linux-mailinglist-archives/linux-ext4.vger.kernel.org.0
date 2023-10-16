Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A47CB3F7
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjJPULp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjJPUL1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1EB0;
        Mon, 16 Oct 2023 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wNJ6b01vEtFMSPcOquC5V/v8dm5R6nJkPliQzhkY6h8=; b=wFCkULMjXDtf6VBDU0ratgV1wJ
        XXz8QdpLn71DnWCQNUHkvC2z6lMX2mtfoIlnuM7DRNPEQqxoMN8z/T7zr9yIzHqjb+4Ci2l6mG/g6
        +8IF0oeP4lVAsdPIicw46Ih6TxgW95+0aqORvtej8Dbl2apjcV7S/zdlDIkEs+Ii5mA69YlyfOPlJ
        pH8zQpWVPIViHAlgz1qNKS88BRxnkCAohcoEqzw+FLRQB+GeyEnnxEcGz3QwbcPGUDkzUK6PLzV5z
        QlYnAxCq8pzNo6nJlTao0cjMXhX4IYjkOZej0brAiLVimSWFd+0wuE184BBeqNZfbckNkA39/H779
        LRMVPZhg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvp-0085ai-BR; Mon, 16 Oct 2023 20:11:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 08/27] gfs2: Convert gfs2_getjdatabuf to use a folio
Date:   Mon, 16 Oct 2023 21:10:55 +0100
Message-Id: <20231016201114.1928083-9-willy@infradead.org>
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

Use the folio APIs, saving four hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/meta_io.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index f1fac1b45059..f6d40d51f5ed 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -400,26 +400,20 @@ static struct buffer_head *gfs2_getjdatabuf(struct gfs2_inode *ip, u64 blkno)
 {
 	struct address_space *mapping = ip->i_inode.i_mapping;
 	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	unsigned int shift = PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift;
 	unsigned long index = blkno >> shift; /* convert block to page */
 	unsigned int bufnum = blkno - (index << shift);
 
-	page = find_get_page_flags(mapping, index, FGP_LOCK|FGP_ACCESSED);
-	if (!page)
-		return NULL;
-	if (!page_has_buffers(page)) {
-		unlock_page(page);
-		put_page(page);
+	folio = __filemap_get_folio(mapping, index, FGP_LOCK | FGP_ACCESSED, 0);
+	if (IS_ERR(folio))
 		return NULL;
-	}
-	/* Locate header for our buffer within our page */
-	for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
-		/* Do nothing */;
-	get_bh(bh);
-	unlock_page(page);
-	put_page(page);
+	bh = folio_buffers(folio);
+	if (bh)
+		bh = get_nth_bh(bh, bufnum);
+	folio_unlock(folio);
+	folio_put(folio);
 	return bh;
 }
 
-- 
2.40.1

