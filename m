Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE127CB3E3
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjJPULj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjJPUL0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E881FC;
        Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=hkFmO69yPLA3lrHUTcCDRb/XpyIM9MLoIhqVDeYMT6U=; b=dyibn8wk9YnVZbYsz3Lm7UaEUX
        3cvmVMuAX8fTYmL+3PgVglDlVv5YZOzlVEwnLwnLGPDbS7yvvcDCQt0sbhvRLALYwrvW3IPHd8fj8
        YN2jxmzcOTAZt/CDrVVxW8+E7sp6Hi8ApI1CoOQA7MqtpadNHUzSaqo0MQWtiT2PfUd6MlheSZfBF
        21aGISlFg5iTBUfA6Dg2JzDKM7gslD0mYyzgSZj2Deq+c+UpmxTgF6sKufuZQNxuhzsVoqBxqGO6I
        N7HPIl9G0hTKsqYFq8mJzQPJ/JOmdKn7rEvcF0pnmtDESno9U7x2sImjw7qPiLdUFeqjS13rH+rYQ
        oqNJZ3ZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvp-0085b4-KM; Mon, 16 Oct 2023 20:11:17 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v2 10/27] nilfs2: Convert nilfs_mdt_freeze_buffer to use a folio
Date:   Mon, 16 Oct 2023 21:10:57 +0100
Message-Id: <20231016201114.1928083-11-willy@infradead.org>
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
 fs/nilfs2/mdt.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 19c8158605ed..db2260d6e44d 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -560,17 +560,19 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 {
 	struct nilfs_shadow_map *shadow = NILFS_MDT(inode)->mi_shadow;
 	struct buffer_head *bh_frozen;
-	struct page *page;
+	struct folio *folio;
 	int blkbits = inode->i_blkbits;
 
-	page = grab_cache_page(shadow->inode->i_mapping, bh->b_folio->index);
-	if (!page)
-		return -ENOMEM;
+	folio = filemap_grab_folio(shadow->inode->i_mapping,
+			bh->b_folio->index);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
-	if (!page_has_buffers(page))
-		create_empty_buffers(page, 1 << blkbits, 0);
+	bh_frozen = folio_buffers(folio);
+	if (!bh_frozen)
+		bh_frozen = folio_create_empty_buffers(folio, 1 << blkbits, 0);
 
-	bh_frozen = nilfs_page_get_nth_block(page, bh_offset(bh) >> blkbits);
+	bh_frozen = get_nth_bh(bh_frozen, bh_offset(bh) >> blkbits);
 
 	if (!buffer_uptodate(bh_frozen))
 		nilfs_copy_buffer(bh_frozen, bh);
@@ -582,8 +584,8 @@ int nilfs_mdt_freeze_buffer(struct inode *inode, struct buffer_head *bh)
 		brelse(bh_frozen); /* already frozen */
 	}
 
-	unlock_page(page);
-	put_page(page);
+	folio_unlock(folio);
+	folio_put(folio);
 	return 0;
 }
 
-- 
2.40.1

