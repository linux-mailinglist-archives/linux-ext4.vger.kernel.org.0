Return-Path: <linux-ext4+bounces-7663-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8968BAA8F2E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 11:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0308D168D2E
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142281E51E5;
	Mon,  5 May 2025 09:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P4R6sZ3g"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B72156C69
	for <linux-ext4@vger.kernel.org>; Mon,  5 May 2025 09:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436570; cv=none; b=MliSlXS7Sif4ttei6k/p42BW+ko/WIXrQfiqIKKKOcaNgVL3oMrxBZFvg9FRrMwvx/lYwjKhKLVmrHDwLR2NiPWRkRprTUKrlplBP5AXyRY/smeOP2JU0ADKR3jFFNpCgTI3RAu6QCUEHjJT7aGKu/OBZEJsv5+5MFGCJYuyGAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436570; c=relaxed/simple;
	bh=800qkm1ZJPeRts+UieLnmCMfBGLAn/aDGED33a/nX+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jOgj4efJ5eWwW1oz3vPjeL1hHYUpQKY3YT2LK+yb4UOShNg8PnksbyvZr6M08O3ZgeMAsup4MJ+W0Y5atcobifeKo/5UA914Yy4mWnrML9EMiVuY4KnyIyXt/dyroxt9PoclRqAY7Qcq1fokHd8E0DRv/cJn+U/H4Tpgj0AzggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P4R6sZ3g; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ijRSIezkQEO5KhciJUerezkzsZ1JIeIIZ/6fHPLykys=; b=P4R6sZ3gAJvvT2CBwqpuZykFe+
	sOWNvFinEjOSiVNYIMb+WEAIhxbCv6tYM+pJ7h/lip0rfn5YmWfYKkysDY3TefsYXKZvtF5FzdQic
	KBffrsyzNFHn2FLqfoNaW+6T75/BoeIxKi+EbvVw/OTMp2yz5uZwaf2zMvBwySVjUt7oA+StKfCzZ
	Io8LfP+6w9cYD4pN1tF0RP8jytE75sJ23r0b3sMAA/d9lyeMegKy6XfY9rckPAKecjYbJLl4K+t1A
	4lAas1NoF5S2FyE/heHRsxVJfy7g6uNPAlkPUwd/SyEjO13JLcBFgHvHqPdLzRIcH67kLjHP2XGIg
	COpOgWjA==;
Received: from 2a02-8389-2341-5b80-c9f7-77ec-522e-47ca.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:c9f7:77ec:522e:47ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBrvk-00000006tDA-0BWn;
	Mon, 05 May 2025 09:16:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: use writeback_iter in ext4_journalled_submit_inode_data_buffers
Date: Mon,  5 May 2025 11:16:04 +0200
Message-ID: <20250505091604.3449879-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use writeback_iter directly instead of write_cache_pages for a nicer
code structure and less indirect calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/super.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 181934499624..6a0a3493ee43 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -508,21 +508,9 @@ static void ext4_journal_commit_callback(journal_t *journal, transaction_t *txn)
 	ext4_maybe_update_superblock(sb);
 }
 
-/*
- * This writepage callback for write_cache_pages()
- * takes care of a few cases after page cleaning.
- *
- * write_cache_pages() already checks for dirty pages
- * and calls clear_page_dirty_for_io(), which we want,
- * to write protect the pages.
- *
- * However, we may have to redirty a page (see below.)
- */
-static int ext4_journalled_writepage_callback(struct folio *folio,
-					      struct writeback_control *wbc,
-					      void *data)
+static bool ext4_journalled_writepage_needs_redirty(struct jbd2_inode *jinode,
+		struct folio *folio)
 {
-	transaction_t *transaction = (transaction_t *) data;
 	struct buffer_head *bh, *head;
 	struct journal_head *jh;
 
@@ -543,15 +531,12 @@ static int ext4_journalled_writepage_callback(struct folio *folio,
 		 */
 		jh = bh2jh(bh);
 		if (buffer_dirty(bh) ||
-		    (jh && (jh->b_transaction != transaction ||
-			    jh->b_next_transaction))) {
-			folio_redirty_for_writepage(wbc, folio);
-			goto out;
-		}
+		    (jh && (jh->b_transaction != jinode->i_transaction ||
+			    jh->b_next_transaction)))
+			return true;
 	} while ((bh = bh->b_this_page) != head);
 
-out:
-	return AOP_WRITEPAGE_ACTIVATE;
+	return false;
 }
 
 static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
@@ -563,10 +548,23 @@ static int ext4_journalled_submit_inode_data_buffers(struct jbd2_inode *jinode)
 		.range_start = jinode->i_dirty_start,
 		.range_end = jinode->i_dirty_end,
         };
+	struct folio *folio = NULL;
+	int error;
 
-	return write_cache_pages(mapping, &wbc,
-				 ext4_journalled_writepage_callback,
-				 jinode->i_transaction);
+	/*
+	 * writeback_iter() already checks for dirty pages and calls
+	 * folio_clear_dirty_for_io(), which we want to write protect the
+	 * folios.
+	 *
+	 * However, we may have to redirty a folio sometimes.
+	 */
+	while ((folio = writeback_iter(mapping, &wbc, folio, &error))) {
+		if (ext4_journalled_writepage_needs_redirty(jinode, folio))
+			folio_redirty_for_writepage(&wbc, folio);
+		folio_unlock(folio);
+	}
+
+	return error;
 }
 
 static int ext4_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
-- 
2.47.2


