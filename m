Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465AC18347C
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 16:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgCLPT6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 11:19:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38592 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgCLPT6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Mar 2020 11:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=er2q8QcSmPWEI1Q7D0vL5FjZ8hNU3epCmMKHGb+NMVg=; b=kFBkIhysj6ldfShaJtWN30tMzp
        ScODz0an3nPNP21vxuAJbJ11IuTufijs+9jnzOmoAPbhI6k3RARVOw6REwhBILo9qJ3n0BzNLKt2l
        QO0y22lJ387HO42mIQObI9GD7QWo6cdbMf57ZGJqfe1x2Ce5cLiXZ3SIC04db0DSOhnnu2x6mpw6V
        d2+qtzPbCE0XFOrtRpLG87HXsve2s3Uaiw5Zrsj21J0dIwYMAEVBb4mL1seNn9JE6sT8NZ7rNYyyg
        TNxhZOvU8ACWrmzI/Vn9vbOgUd6KdSGXdJX/H2iX5u6hsOpyMTUPpegnHPm3IKFEnZTpBIOZgjw4X
        TnW2Jmqw==;
Received: from [2001:4bb8:184:5cad:8026:d98c:a056:3e33] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jCPcr-0006Z0-NS; Thu, 12 Mar 2020 15:19:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-ext4@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: [PATCH 06/21] scsi: simplify scsi_bios_ptable
Date:   Thu, 12 Mar 2020 16:19:24 +0100
Message-Id: <20200312151939.645254-7-hch@lst.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200312151939.645254-1-hch@lst.de>
References: <20200312151939.645254-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Use read_mapping_page and kmemdup instead of the odd read_dev_sector and
put_dev_sector helpers from the partitioning code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsicam.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsicam.c b/drivers/scsi/scsicam.c
index e969138051c7..91a9530a4dcb 100644
--- a/drivers/scsi/scsicam.c
+++ b/drivers/scsi/scsicam.c
@@ -35,19 +35,17 @@ static int setsize(unsigned long capacity, unsigned int *cyls, unsigned int *hds
  */
 unsigned char *scsi_bios_ptable(struct block_device *dev)
 {
-	unsigned char *res = kmalloc(66, GFP_KERNEL);
-	if (res) {
-		struct block_device *bdev = dev->bd_contains;
-		Sector sect;
-		void *data = read_dev_sector(bdev, 0, &sect);
-		if (data) {
-			memcpy(res, data + 0x1be, 66);
-			put_dev_sector(sect);
-		} else {
-			kfree(res);
-			res = NULL;
-		}
-	}
+	struct address_space *mapping = dev->bd_contains->bd_inode->i_mapping;
+	unsigned char *res = NULL;
+	struct page *page;
+
+	page = read_mapping_page(mapping, 0, NULL);
+	if (IS_ERR(page))
+		return NULL;
+
+	if (!PageError(page))
+		res = kmemdup(page_address(page) + 0x1be, 66, GFP_KERNEL);
+	put_page(page);
 	return res;
 }
 EXPORT_SYMBOL(scsi_bios_ptable);
-- 
2.24.1

