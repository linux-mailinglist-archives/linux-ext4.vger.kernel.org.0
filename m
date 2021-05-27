Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28E7393011
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhE0NtB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 09:49:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2504 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhE0Nsz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 09:48:55 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FrTZc006nzYr8G;
        Thu, 27 May 2021 21:44:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 27
 May 2021 21:47:19 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [RFC PATCH v3 7/8] ext4: remove bdev_try_to_free_page() callback
Date:   Thu, 27 May 2021 21:56:40 +0800
Message-ID: <20210527135641.420514-8-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210527135641.420514-1-yi.zhang@huawei.com>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After we introduce a jbd2 shrinker to release checkpointed buffer's
journal head, we could free buffer without bdev_try_to_free_page()
under memory pressure. So this patch remove the whole
bdev_try_to_free_page() callback directly. It also remove many
use-after-free issues relate to it together.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf6d0085e1b7..b778236d06e6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1442,26 +1442,6 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
 	return ext4_write_inode(inode, &wbc);
 }
 
-/*
- * Try to release metadata pages (indirect blocks, directories) which are
- * mapped via the block device.  Since these pages could have journal heads
- * which would prevent try_to_free_buffers() from freeing them, we must use
- * jbd2 layer's try_to_free_buffers() function to release them.
- */
-static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
-				 gfp_t wait)
-{
-	journal_t *journal = EXT4_SB(sb)->s_journal;
-
-	WARN_ON(PageChecked(page));
-	if (!page_has_buffers(page))
-		return 0;
-	if (journal)
-		return jbd2_journal_try_to_free_buffers(journal, page);
-
-	return try_to_free_buffers(page);
-}
-
 #ifdef CONFIG_FS_ENCRYPTION
 static int ext4_get_context(struct inode *inode, void *ctx, size_t len)
 {
@@ -1656,7 +1636,6 @@ static const struct super_operations ext4_sops = {
 	.quota_write	= ext4_quota_write,
 	.get_dquots	= ext4_get_dquots,
 #endif
-	.bdev_try_to_free_page = bdev_try_to_free_page,
 };
 
 static const struct export_operations ext4_export_ops = {
-- 
2.25.4

