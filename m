Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A58161AE2
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Feb 2020 19:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgBQSs4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Feb 2020 13:48:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48058 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbgBQSqT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Feb 2020 13:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=c1RHQNQxAXbf5ukt2BNF7izx4iTSuNQC5EsGyGLZYjM=; b=PilV6Nbnp5jeR3BGkYdLmIHP+0
        PemIro+LMam5FDrFdQV47s7w0ljGT9Umtu4ajE78hjqlTcMnO1ZqjwyB6UNIiDpsqAq6hVz7y+yPi
        vKmTQ4UgvuffWOVq3liQTyr+/bXLQzOSae98w3a8DvliVoYSYsyupobLHKFqKbEytaDORWEaIpfY7
        yGq4FDarj0LzoQek3vMA3QotZUSztvbszSae+Homo9HXkO747iu2h2BFYhXvrgGzKKpAC9HcZO+MV
        7FkaahGbzj8tYko/oTcUrCmw4CDvwZPp3U1buusRJz9oy83OGg4g6GGuFPxZBmY6G9Mg9MKTI8gFM
        ozQ2KRbA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3lPM-0005BL-1r; Mon, 17 Feb 2020 18:46:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        linux-xfs@vger.kernel.org
Subject: [PATCH v6 12/19] erofs: Convert uncompressed files from readpages to readahead
Date:   Mon, 17 Feb 2020 10:46:01 -0800
Message-Id: <20200217184613.19668-21-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200217184613.19668-1-willy@infradead.org>
References: <20200217184613.19668-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the new readahead operation in erofs

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/erofs/data.c              | 39 +++++++++++++-----------------------
 fs/erofs/zdata.c             |  2 +-
 include/trace/events/erofs.h |  6 +++---
 3 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index fc3a8d8064f8..82ebcee9d178 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -280,47 +280,36 @@ static int erofs_raw_access_readpage(struct file *file, struct page *page)
 	return 0;
 }
 
-static int erofs_raw_access_readpages(struct file *filp,
-				      struct address_space *mapping,
-				      struct list_head *pages,
-				      unsigned int nr_pages)
+static void erofs_raw_access_readahead(struct readahead_control *rac)
 {
 	erofs_off_t last_block;
 	struct bio *bio = NULL;
-	gfp_t gfp = readahead_gfp_mask(mapping);
-	struct page *page = list_last_entry(pages, struct page, lru);
-
-	trace_erofs_readpages(mapping->host, page, nr_pages, true);
+	struct page *page;
 
-	for (; nr_pages; --nr_pages) {
-		page = list_entry(pages->prev, struct page, lru);
+	trace_erofs_readpages(rac->mapping->host, readahead_index(rac),
+			readahead_count(rac), true);
 
+	readahead_for_each(rac, page) {
 		prefetchw(&page->flags);
-		list_del(&page->lru);
 
-		if (!add_to_page_cache_lru(page, mapping, page->index, gfp)) {
-			bio = erofs_read_raw_page(bio, mapping, page,
-						  &last_block, nr_pages, true);
+		bio = erofs_read_raw_page(bio, rac->mapping, page, &last_block,
+				readahead_count(rac), true);
 
-			/* all the page errors are ignored when readahead */
-			if (IS_ERR(bio)) {
-				pr_err("%s, readahead error at page %lu of nid %llu\n",
-				       __func__, page->index,
-				       EROFS_I(mapping->host)->nid);
+		/* all the page errors are ignored when readahead */
+		if (IS_ERR(bio)) {
+			pr_err("%s, readahead error at page %lu of nid %llu\n",
+			       __func__, page->index,
+			       EROFS_I(rac->mapping->host)->nid);
 
-				bio = NULL;
-			}
+			bio = NULL;
 		}
 
-		/* pages could still be locked */
 		put_page(page);
 	}
-	DBG_BUGON(!list_empty(pages));
 
 	/* the rare case (end in gaps) */
 	if (bio)
 		submit_bio(bio);
-	return 0;
 }
 
 static int erofs_get_block(struct inode *inode, sector_t iblock,
@@ -358,7 +347,7 @@ static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
 /* for uncompressed (aligned) files and raw access for other files */
 const struct address_space_operations erofs_raw_access_aops = {
 	.readpage = erofs_raw_access_readpage,
-	.readpages = erofs_raw_access_readpages,
+	.readahead = erofs_raw_access_readahead,
 	.bmap = erofs_bmap,
 };
 
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 80e47f07d946..17f45fcb8c5c 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1315,7 +1315,7 @@ static int z_erofs_readpages(struct file *filp, struct address_space *mapping,
 	struct page *head = NULL;
 	LIST_HEAD(pagepool);
 
-	trace_erofs_readpages(mapping->host, lru_to_page(pages),
+	trace_erofs_readpages(mapping->host, lru_to_page(pages)->index,
 			      nr_pages, false);
 
 	f.headoffset = (erofs_off_t)lru_to_page(pages)->index << PAGE_SHIFT;
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 27f5caa6299a..bf9806fd1306 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -113,10 +113,10 @@ TRACE_EVENT(erofs_readpage,
 
 TRACE_EVENT(erofs_readpages,
 
-	TP_PROTO(struct inode *inode, struct page *page, unsigned int nrpage,
+	TP_PROTO(struct inode *inode, pgoff_t start, unsigned int nrpage,
 		bool raw),
 
-	TP_ARGS(inode, page, nrpage, raw),
+	TP_ARGS(inode, start, nrpage, raw),
 
 	TP_STRUCT__entry(
 		__field(dev_t,		dev	)
@@ -129,7 +129,7 @@ TRACE_EVENT(erofs_readpages,
 	TP_fast_assign(
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->nid	= EROFS_I(inode)->nid;
-		__entry->start	= page->index;
+		__entry->start	= start;
 		__entry->nrpage	= nrpage;
 		__entry->raw	= raw;
 	),
-- 
2.25.0

