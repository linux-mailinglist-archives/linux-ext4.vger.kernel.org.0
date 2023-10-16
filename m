Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9BB7CB40B
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbjJPUL6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjJPUL2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C136114;
        Mon, 16 Oct 2023 13:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+TzVgId1jqCDDfMgeb9joeaqRyXGlOXTb427eLXo+nM=; b=ARI10CJ76QxL1jRsJIHG5ZCDeB
        uheFpCFmr9g/LYv/NxEJd9ysDQSiosCZOUQt/iYLYHSalrRhu7vs8M/JfZP4p9UxZ6Oaglk5IACSj
        KE1sybHOP6NcGyPTQSEdBFm77oMCS7RKOXk3Qb7R0GBF4ThuKvcQKuYzT0SR9biRp7ugcMfXlV5Ge
        gm5yysrbN39FGTZ/I019lbl8W0fQ4Hp16NoZBjH/vDzacMyEXbIgIvWJL9yJhbQQz7j9h55IQvZqU
        q37RxSUraAjjDWLtDyc/BJvpFxgrfLfeUEjn91i3BY3pUZ4fiEj3ybV8mwM2E+stOr365gBRzQ1Ha
        dc9v6GcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvp-0085aa-00; Mon, 16 Oct 2023 20:11:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 04/27] ext4: Convert to folio_create_empty_buffers
Date:   Mon, 16 Oct 2023 21:10:51 +0100
Message-Id: <20231016201114.1928083-5-willy@infradead.org>
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

Remove an unnecessary folio->page->folio conversion and take advantage
of the new return value from folio_create_empty_buffers().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/ext4/inode.c       | 14 +++++---------
 fs/ext4/move_extent.c | 11 +++++------
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index a6838f54ae91..31c8f2641870 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1032,10 +1032,8 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 	BUG_ON(from > to);
 
 	head = folio_buffers(folio);
-	if (!head) {
-		create_empty_buffers(&folio->page, blocksize, 0);
-		head = folio_buffers(folio);
-	}
+	if (!head)
+		head = folio_create_empty_buffers(folio, blocksize, 0);
 	bbits = ilog2(blocksize);
 	block = (sector_t)folio->index << (PAGE_SHIFT - bbits);
 
@@ -1165,7 +1163,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	 * starting the handle.
 	 */
 	if (!folio_buffers(folio))
-		create_empty_buffers(&folio->page, inode->i_sb->s_blocksize, 0);
+		folio_create_empty_buffers(folio, inode->i_sb->s_blocksize, 0);
 
 	folio_unlock(folio);
 
@@ -3655,10 +3653,8 @@ static int __ext4_block_zero_page_range(handle_t *handle,
 	iblock = index << (PAGE_SHIFT - inode->i_sb->s_blocksize_bits);
 
 	bh = folio_buffers(folio);
-	if (!bh) {
-		create_empty_buffers(&folio->page, blocksize, 0);
-		bh = folio_buffers(folio);
-	}
+	if (!bh)
+		bh = folio_create_empty_buffers(folio, blocksize, 0);
 
 	/* Find the buffer that contains "offset" */
 	pos = blocksize;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 18a9e7c47975..7fe448fb948b 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -183,10 +183,8 @@ mext_page_mkuptodate(struct folio *folio, unsigned from, unsigned to)
 
 	blocksize = i_blocksize(inode);
 	head = folio_buffers(folio);
-	if (!head) {
-		create_empty_buffers(&folio->page, blocksize, 0);
-		head = folio_buffers(folio);
-	}
+	if (!head)
+		head = folio_create_empty_buffers(folio, blocksize, 0);
 
 	block = (sector_t)folio->index << (PAGE_SHIFT - inode->i_blkbits);
 	for (bh = head, block_start = 0; bh != head || !block_start;
@@ -380,9 +378,10 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	}
 	/* Perform all necessary steps similar write_begin()/write_end()
 	 * but keeping in mind that i_size will not change */
-	if (!folio_buffers(folio[0]))
-		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
 	bh = folio_buffers(folio[0]);
+	if (!bh)
+		bh = folio_create_empty_buffers(folio[0],
+				1 << orig_inode->i_blkbits, 0);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
 	for (i = 0; i < block_len_in_page; i++) {
-- 
2.40.1

