Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AEA7CB42C
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjJPUMf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbjJPULo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD9AF7;
        Mon, 16 Oct 2023 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fi8Eq6tU4+7e9/mXSea+NKjhkEdSISChyP52Lf5yEEA=; b=AtFTdGQ4o7OhxTEzHtog4nTY2s
        Czbj4V3RFqns4xEx2QtWuyeAPYvlbrv2EkTmoe+YqvgbHn7bkTxc9Dlu3UepTZ0fhwMKh5IAPpEBU
        eenTAv9RPASKjXekhb65QbKhjEfcGTIIGd9BsXSOyZOImKZY8GbaFxWj784tnAeC/9fzDTKUV5bq/
        /T+7/2eNdv7bS7256cWCmIOja+6QXmkQJR03TkzwwSpq5PJB0P8SWRwYG5Mmpn6GCmv62sYKNhGWq
        sbbiLNEdiVMVnJxQvoM6Cb9t54mQuF8YhRDyQlhDEsRG9CVSxNYfB/JRj8xEqscF41zFU9EMYO4Ib
        UPxlizag==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvo-0085aW-Rw; Mon, 16 Oct 2023 20:11:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 03/27] mpage: Convert map_buffer_to_folio() to folio_create_empty_buffers()
Date:   Mon, 16 Oct 2023 21:10:50 +0100
Message-Id: <20231016201114.1928083-4-willy@infradead.org>
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

Saves a folio->page->folio conversion.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/mpage.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/mpage.c b/fs/mpage.c
index 242e213ee064..964a6efe594d 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -119,8 +119,7 @@ static void map_buffer_to_folio(struct folio *folio, struct buffer_head *bh,
 			folio_mark_uptodate(folio);
 			return;
 		}
-		create_empty_buffers(&folio->page, i_blocksize(inode), 0);
-		head = folio_buffers(folio);
+		head = folio_create_empty_buffers(folio, i_blocksize(inode), 0);
 	}
 
 	page_bh = head;
-- 
2.40.1

