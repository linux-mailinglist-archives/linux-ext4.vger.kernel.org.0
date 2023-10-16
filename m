Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E87CB3D3
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Oct 2023 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbjJPULd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Oct 2023 16:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjJPUL0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Oct 2023 16:11:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43BF7;
        Mon, 16 Oct 2023 13:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DldHNSAIwDA0NK3BnRq3sFTgOXsGThrmmCtWcfiCecQ=; b=LbBGYz3ijw9HZLmYD1FK68VsKn
        9lkLcjfnwOxts9sRe1eiKLwhR2mVK93Zj2K1mav4r+wBDgOk5zZLpUUlAMhjNvd6yZuXMn5TlW9e7
        D1ZebvowctrS+pZpuJNbA7zRydEzzy9IKk3LCaSEqiksqBwoiCoQx6RhoJ4BRw76ioWqa/u1E6vkz
        2Ch3mL/2sutgWka/bGlWAebVaOd4DPfEWuM9sradV7is6XRwNHhD+acJvExVQuAoaeo5xIqas2rhu
        r6M3OjNjzfqlYmX5ukaU+SVDne4XUv3J3zK7HzCQAJAjwEyz2CtyNvwE8W1UYwMf/u2H9Zf1Egw67
        3EsN2r9w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsTvo-0085aS-LS; Mon, 16 Oct 2023 20:11:16 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev,
        reiserfs-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2 01/27] buffer: Return bool from grow_dev_folio()
Date:   Mon, 16 Oct 2023 21:10:48 +0100
Message-Id: <20231016201114.1928083-2-willy@infradead.org>
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

Rename grow_dev_page() to grow_dev_folio() and make it return a bool.
Document what that bool means; it's more subtle than it first appears.
Also rename the 'failed' label to 'unlock' beacuse it's not exactly
'failed'.  It just hasn't succeeded.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b33cc74e9649..dec41d84044b 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1024,24 +1024,26 @@ static sector_t folio_init_buffers(struct folio *folio,
 }
 
 /*
- * Create the page-cache page that contains the requested block.
+ * Create the page-cache folio that contains the requested block.
  *
  * This is used purely for blockdev mappings.
+ *
+ * Returns false if we have a 'permanent' failure.  Returns true if
+ * we succeeded, or the caller should retry.
  */
-static int
-grow_dev_page(struct block_device *bdev, sector_t block,
+static bool grow_dev_folio(struct block_device *bdev, sector_t block,
 	      pgoff_t index, int size, int sizebits, gfp_t gfp)
 {
 	struct inode *inode = bdev->bd_inode;
 	struct folio *folio;
 	struct buffer_head *bh;
 	sector_t end_block;
-	int ret = 0;
+	bool ret;
 
 	folio = __filemap_get_folio(inode->i_mapping, index,
 			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, gfp);
 	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+		return false;
 
 	bh = folio_buffers(folio);
 	if (bh) {
@@ -1050,14 +1052,17 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 					(sector_t)index << sizebits, size);
 			goto done;
 		}
+
+		/* Caller should retry if this call fails */
+		ret = true;
 		if (!try_to_free_buffers(folio))
-			goto failed;
+			goto unlock;
 	}
 
-	ret = -ENOMEM;
+	ret = false;
 	bh = folio_alloc_buffers(folio, size, gfp | __GFP_ACCOUNT);
 	if (!bh)
-		goto failed;
+		goto unlock;
 
 	/*
 	 * Link the folio to the buffers and initialise them.  Take the
@@ -1070,19 +1075,19 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 			(sector_t)index << sizebits, size);
 	spin_unlock(&inode->i_mapping->private_lock);
 done:
-	ret = (block < end_block) ? 1 : -ENXIO;
-failed:
+	ret = block < end_block;
+unlock:
 	folio_unlock(folio);
 	folio_put(folio);
 	return ret;
 }
 
 /*
- * Create buffers for the specified block device block's page.  If
- * that page was dirty, the buffers are set dirty also.
+ * Create buffers for the specified block device block's folio.  If
+ * that folio was dirty, the buffers are set dirty also.
  */
-static int
-grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
+static bool grow_buffers(struct block_device *bdev, sector_t block,
+		int size, gfp_t gfp)
 {
 	pgoff_t index;
 	int sizebits;
@@ -1099,11 +1104,11 @@ grow_buffers(struct block_device *bdev, sector_t block, int size, gfp_t gfp)
 			"device %pg\n",
 			__func__, (unsigned long long)block,
 			bdev);
-		return -EIO;
+		return false;
 	}
 
-	/* Create a page with the proper size buffers.. */
-	return grow_dev_page(bdev, block, index, size, sizebits, gfp);
+	/* Create a folio with the proper size buffers.. */
+	return grow_dev_folio(bdev, block, index, size, sizebits, gfp);
 }
 
 static struct buffer_head *
-- 
2.40.1

