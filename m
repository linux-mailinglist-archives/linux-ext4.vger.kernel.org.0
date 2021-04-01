Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D60D6350FBC
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Apr 2021 09:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbhDAHDd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Apr 2021 03:03:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15428 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbhDAHDO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Apr 2021 03:03:14 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9vHC37BrzjXj7;
        Thu,  1 Apr 2021 15:01:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 15:03:03 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Yang Guo <guoyang2@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [PATCH] ext4: Delete redundant uptodate check for buffer
Date:   Thu, 1 Apr 2021 15:03:30 +0800
Message-ID: <1617260610-29770-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Yang Guo <guoyang2@huawei.com>

The buffer uptodate state has been checked in function set_buffer_uptodate,
there is no need use buffer_uptodate before calling set_buffer_uptodate and
delete it.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Signed-off-by: Yang Guo <guoyang2@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 fs/ext4/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0948a43f1b3d..32fa3ad38797 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1066,8 +1066,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
 			if (PageUptodate(page)) {
-				if (!buffer_uptodate(bh))
-					set_buffer_uptodate(bh);
+				set_buffer_uptodate(bh);
 			}
 			continue;
 		}
@@ -1092,8 +1091,7 @@ static int ext4_block_write_begin(struct page *page, loff_t pos, unsigned len,
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
2.7.4

