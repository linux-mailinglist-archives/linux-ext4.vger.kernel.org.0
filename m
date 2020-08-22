Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B404524E6AC
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 11:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgHVJ0F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 05:26:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10255 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbgHVJ0F (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Aug 2020 05:26:05 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3C95692F018E9B14DDE9;
        Sat, 22 Aug 2020 17:26:04 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 17:25:57 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <adilger.kernel@dilger.ca>, <tytso@mit.edu>,
        <linux-ext4@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH] ext4: Fix unnecessary hold lock when judge jinode in ext4_inode_attach_jinode
Date:   Sat, 22 Aug 2020 17:25:44 +0800
Message-ID: <20200822092544.2306917-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 3a196d81f594..3504b4cec5b8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4100,12 +4100,11 @@ int ext4_inode_attach_jinode(struct inode *inode)
 		return 0;
 
 	jinode = jbd2_alloc_inode(GFP_KERNEL);
+	if (!jinode)
+		return -ENOMEM;
+
 	spin_lock(&inode->i_lock);
 	if (!ei->jinode) {
-		if (!jinode) {
-			spin_unlock(&inode->i_lock);
-			return -ENOMEM;
-		}
 		ei->jinode = jinode;
 		jbd2_journal_init_jbd_inode(ei->jinode, inode);
 		jinode = NULL;
-- 
2.25.4

