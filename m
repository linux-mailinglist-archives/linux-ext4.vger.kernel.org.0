Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74E20CB67
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jun 2020 03:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgF2BWw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Jun 2020 21:22:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726465AbgF2BWw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 28 Jun 2020 21:22:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51D47B79ECF292AC6EAB;
        Mon, 29 Jun 2020 09:22:50 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Mon, 29 Jun 2020
 09:22:47 +0800
From:   zhengliang <zhengliang6@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>
Subject: [PATCH] ext4: lost matching-pair of trace in ext4_truncate
Date:   Mon, 29 Jun 2020 10:13:41 +0800
Message-ID: <20200629021341.36129-1-zhengliang6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If truncate inline data successfully, it shoule call trace exit.

Signed-off-by: zhengliang <zhengliang6@huawei.com>
---
 fs/ext4/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e416096fc081..6d24ed658e30 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4171,8 +4171,10 @@ int ext4_truncate(struct inode *inode)
 		err = ext4_inline_data_truncate(inode, &has_inline);
 		if (err)
 			return err;
-		if (has_inline)
+		if (has_inline) {
+			trace_ext4_truncate_exit(inode);
 			return 0;
+		}
 	}
 
 	/* If we zero-out tail of the page, we have to create jinode for jbd2 */
-- 
2.17.1

