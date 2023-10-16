Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6F17CB406
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjJPULy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjJPUL1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C15106;
        Mon, 16 Oct 2023 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=oWqn2JXFKP4TLO9EIFStc+ZKIjdbaY7Lskcv1xTeMOQ=; b=XgF2LHYyFYj9Silu4DTI6Jb+wI
        7S9nhoWN66LOn+Rfb6K+sBhOfU3VhpvXHa9P8+zTX5j0KmQEeTSGHNCREGJGaYMSkVAnDWmMEn6C5
        +Mt13RnLUw55kRTGG1PaECz0gzT+9tpmxPPsasOHuo2D2zkicFr5Tfelmpc0wm0F6/B6pMZcSgs+p
        JYPw5sIxZOepG9MEVyJ+BRmQBv9YNrAsraxb1RoeKPegGVnd7yx6WtPkx7UO8K+VcG6Cqlg9pnyUw
        3C86CPWTo1X2bVzt0tMFwzFJbqQfzyfRyLWDvcDtJH4MbsUbcq7l1pkTnRjut2d5RsPHXxhdDpDJ6
        HvEgR2lg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvr-0085cs-JA; Mon, 16 Oct 2023 20:11:19 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 24/27] ufs: Use ufs_get_locked_folio() in ufs_alloc_lastblock()
Date:   Mon, 16 Oct 2023 21:11:11 +0100
Message-Id: <20231016201114.1928083-25-willy@infradead.org>
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

Switch to the folio APIs, saving one folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/ufs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/fs/ufs/inode.c b/fs/ufs/inode.c
index 338e4b97312f..ebce93b08281 100644
--- a/fs/ufs/inode.c
+++ b/fs/ufs/inode.c
@@ -1063,7 +1063,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	unsigned i, end;
 	sector_t lastfrag;
-	struct page *lastpage;
+	struct folio *folio;
 	struct buffer_head *bh;
 	u64 phys64;
 
@@ -1074,18 +1074,17 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 
 	lastfrag--;
 
-	lastpage = ufs_get_locked_page(mapping, lastfrag >>
+	folio = ufs_get_locked_folio(mapping, lastfrag >>
 				       (PAGE_SHIFT - inode->i_blkbits));
-       if (IS_ERR(lastpage)) {
-               err = -EIO;
-               goto out;
-       }
-
-       end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
-       bh = page_buffers(lastpage);
-       for (i = 0; i < end; ++i)
-               bh = bh->b_this_page;
+	if (IS_ERR(folio)) {
+		err = -EIO;
+		goto out;
+	}
 
+	end = lastfrag & ((1 << (PAGE_SHIFT - inode->i_blkbits)) - 1);
+	bh = folio_buffers(folio);
+	for (i = 0; i < end; ++i)
+		bh = bh->b_this_page;
 
        err = ufs_getfrag_block(inode, lastfrag, bh, 1);
 
@@ -1101,7 +1100,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 		*/
 	       set_buffer_uptodate(bh);
 	       mark_buffer_dirty(bh);
-	       set_page_dirty(lastpage);
+		folio_mark_dirty(folio);
        }
 
        if (lastfrag >= UFS_IND_FRAGMENT) {
@@ -1119,7 +1118,7 @@ static int ufs_alloc_lastblock(struct inode *inode, loff_t size)
 	       }
        }
 out_unlock:
-       ufs_put_locked_page(lastpage);
+       ufs_put_locked_folio(folio);
 out:
        return err;
 }
-- 
2.40.1

