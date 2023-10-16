Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DF57CB3FC
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjJPULq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbjJPUL1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E77CFB;
        Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1MRD3/MDyXo+/XqOlq/B5TtIgREACynS4klWCDOin7o=; b=F6beEH1hsFbpnEX6mH5J+/m/Qg
        WzIDy18lFCUyXAfnl6LKWrxfsN1CiVBS7YS8hD7F75LWuAQhlPSvLtE7Vf1rCMud58l8hopJpm5X3
        XmfJaHI5B0GjIw1LoCheBWV5ZliP1tGc0zB/95whyQxPLSOJv3StefjuPAMOv6BRoI2/QbR2sVj69
        5ZwdtrWaAnQYpANja0fycQcWPpgPSsiT8RR9tFk1uU6UyLYXe6ev4C46Ku9N33dOJs2gi/El0sXPM
        QyzxkoGusiCPgWiddmYkFKFpavqEWcra1cT6cu8NY5yGvyOH3EMQ8VodshzLkg3CrJrb3faXplMbU
        ne7P8hjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvp-0085av-GT; Mon, 16 Oct 2023 20:11:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 09/27] gfs2: Convert gfs2_write_buf_to_page() to use a folio
Date:   Mon, 16 Oct 2023 21:10:56 +0100
Message-Id: <20231016201114.1928083-10-willy@infradead.org>
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

Remove several folio->page->folio conversions.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 6affd261a754..e45654ee4f4d 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -760,7 +760,7 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_quota_inode);
 	struct inode *inode = &ip->i_inode;
 	struct address_space *mapping = inode->i_mapping;
-	struct page *page;
+	struct folio *folio;
 	struct buffer_head *bh;
 	u64 blk;
 	unsigned bsize = sdp->sd_sb.sb_bsize, bnum = 0, boff = 0;
@@ -769,15 +769,15 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 	blk = index << (PAGE_SHIFT - sdp->sd_sb.sb_bsize_shift);
 	boff = off % bsize;
 
-	page = grab_cache_page(mapping, index);
-	if (!page)
-		return -ENOMEM;
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, bsize, 0);
+	folio = filemap_grab_folio(mapping, index);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+	bh = folio_buffers(folio);
+	if (!bh)
+		bh = folio_create_empty_buffers(folio, bsize, 0);
 
-	bh = page_buffers(page);
-	for(;;) {
-		/* Find the beginning block within the page */
+	for (;;) {
+		/* Find the beginning block within the folio */
 		if (pg_off >= ((bnum * bsize) + bsize)) {
 			bh = bh->b_this_page;
 			bnum++;
@@ -790,9 +790,10 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 				goto unlock_out;
 			/* If it's a newly allocated disk block, zero it */
 			if (buffer_new(bh))
-				zero_user(page, bnum * bsize, bh->b_size);
+				folio_zero_range(folio, bnum * bsize,
+						bh->b_size);
 		}
-		if (PageUptodate(page))
+		if (folio_test_uptodate(folio))
 			set_buffer_uptodate(bh);
 		if (bh_read(bh, REQ_META | REQ_PRIO) < 0)
 			goto unlock_out;
@@ -808,17 +809,17 @@ static int gfs2_write_buf_to_page(struct gfs2_sbd *sdp, unsigned long index,
 		break;
 	}
 
-	/* Write to the page, now that we have setup the buffer(s) */
-	memcpy_to_page(page, off, buf, bytes);
-	flush_dcache_page(page);
-	unlock_page(page);
-	put_page(page);
+	/* Write to the folio, now that we have setup the buffer(s) */
+	memcpy_to_folio(folio, off, buf, bytes);
+	flush_dcache_folio(folio);
+	folio_unlock(folio);
+	folio_put(folio);
 
 	return 0;
 
 unlock_out:
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return -EIO;
 }
 
-- 
2.40.1

