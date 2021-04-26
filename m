Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC3736AB0E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Apr 2021 05:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhDZDYC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Apr 2021 23:24:02 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49152 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhDZDYC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 25 Apr 2021 23:24:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UWk0gtf_1619407399;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UWk0gtf_1619407399)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 26 Apr 2021 11:23:20 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: remove redundant check buffer_uptodate()
Date:   Mon, 26 Apr 2021 11:23:19 +0800
Message-Id: <1619407399-72280-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now set_buffer_uptodate() will test first and then set, so we don't have
to check buffer_uptodate() first, remove it to simplify code.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 fs/ext4/inode.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43..9e02538 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1065,10 +1065,8 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 	    block++, block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (PageUptodate(page)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
-			}
+			if (PageUptodate(page))
+				set_buffer_uptodate(bh);
 			continue;
 		}
 		if (buffer_new(bh))
@@ -1092,8 +1090,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 			}
 		}
 		if (PageUptodate(page)) {
-			if (!buffer_uptodate(bh))
-				set_buffer_uptodate(bh);
+			set_buffer_uptodate(bh);
 			continue;
 		}
 		if (!buffer_uptodate(bh) && !buffer_delay(bh) &&
-- 
1.8.3.1

