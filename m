Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712211E1C0A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 May 2020 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgEZHT1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 May 2020 03:19:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51102 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731390AbgEZHTZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 May 2020 03:19:25 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EE67C3D061007B2BE599;
        Tue, 26 May 2020 15:19:14 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 15:19:07 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH 01/10] ext4: move inode eio simulation behind io completeion
Date:   Tue, 26 May 2020 15:17:45 +0800
Message-ID: <20200526071754.33819-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200526071754.33819-1-yi.zhang@huawei.com>
References: <20200526071754.33819-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Current EIO simulation of reading inode from disk isn't accurate since
it will not submit bio if the inode buffer is uptodate. Move this
simulation behind read bio completeion just like inode/block bitmap EIO
simulation does.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2a4aae6acdcb..e0f7e824b3b9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4279,8 +4279,6 @@ static int __ext4_get_inode_loc(struct inode *inode,
 	bh = sb_getblk(sb, block);
 	if (unlikely(!bh))
 		return -ENOMEM;
-	if (ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO))
-		goto simulate_eio;
 	if (!buffer_uptodate(bh)) {
 		lock_buffer(bh);
 
@@ -4378,8 +4376,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
 		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
 		blk_finish_plug(&plug);
 		wait_on_buffer(bh);
+		ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
 		if (!buffer_uptodate(bh)) {
-		simulate_eio:
 			ext4_error_inode_block(inode, block, EIO,
 					       "unable to read itable block");
 			brelse(bh);
-- 
2.21.3

