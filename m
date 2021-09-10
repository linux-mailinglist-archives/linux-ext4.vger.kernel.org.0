Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E299406804
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Sep 2021 09:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhIJHyb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Sep 2021 03:54:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9027 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJHya (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Sep 2021 03:54:30 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H5SlD5Jb0zVr3y;
        Fri, 10 Sep 2021 15:52:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 10
 Sep 2021 15:53:18 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH] ext4: recheck buffer uptodate bit under buffer lock
Date:   Fri, 10 Sep 2021 16:03:16 +0800
Message-ID: <20210910080316.70421-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 8e33fadf945a ("ext4: remove an unnecessary if statement in
__ext4_get_inode_loc()") forget to recheck buffer's uptodate bit again
under buffer lock, which may overwrite the buffer if someone else have
already brought it uptodate and changed it.

Fixes: 8e33fadf945a ("ext4: remove an unnecessary if statement in __ext4_get_inode_loc()")
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d18852d6029c..236adc647eb0 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4340,6 +4340,12 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		goto has_buffer;
 
 	lock_buffer(bh);
+	if (ext4_buffer_uptodate(bh)) {
+		/* Someone brought it uptodate while we waited */
+		unlock_buffer(bh);
+		goto has_buffer;
+	}
+
 	/*
 	 * If we have all information of the inode in memory and this
 	 * is the only valid inode in the block, we need not read the
-- 
2.31.1

