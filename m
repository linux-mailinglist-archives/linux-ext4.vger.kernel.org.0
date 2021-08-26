Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B973F881F
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 14:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhHZMys (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Aug 2021 08:54:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14423 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241694AbhHZMys (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Aug 2021 08:54:48 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GwN3h1WyczbdBc;
        Thu, 26 Aug 2021 20:50:08 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 26
 Aug 2021 20:53:58 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v4 1/6] ext4: move inode eio simulation behind io completeion
Date:   Thu, 26 Aug 2021 21:04:07 +0800
Message-ID: <20210826130412.3921207-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826130412.3921207-1-yi.zhang@huawei.com>
References: <20210826130412.3921207-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

No EIO simulation is required if the buffer is uptodate, so move the
simulation behind read bio completeion just like inode/block bitmap
simulation does.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d8de607849df..eb2526a35254 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4330,8 +4330,6 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
-	if (ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO))
-		goto simulate_eio;
 	if (!buffer_uptodate(bh)) {
 		lock_buffer(bh);
 
@@ -4418,8 +4416,8 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 		ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
+		ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
 		if (!buffer_uptodate(bh)) {
-		simulate_eio:
 			if (ret_block)
 				*ret_block = block;
 			brelse(bh);
-- 
2.31.1

