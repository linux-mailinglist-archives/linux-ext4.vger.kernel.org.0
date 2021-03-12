Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFBF6338639
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Mar 2021 07:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbhCLGwF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Mar 2021 01:52:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13148 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhCLGvk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Mar 2021 01:51:40 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DxbyS4x8nzmVqY;
        Fri, 12 Mar 2021 14:49:20 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 12 Mar 2021
 14:51:28 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <luoshijie1@huawei.com>
Subject: [PATCH] ext4: fix potential error in ext4_do_update_inode
Date:   Fri, 12 Mar 2021 01:50:51 -0500
Message-ID: <20210312065051.36314-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If set_large_file = 1 and errors occur in ext4_handle_dirty_metadata(),
the error code will be overridden, go to out_brelse to avoid this
situation.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/ext4/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 650c5acd2f2d..8074ae0e976d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5026,7 +5026,7 @@ static int ext4_do_update_inode(handle_t *handle,
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	struct buffer_head *bh = iloc->bh;
 	struct super_block *sb = inode->i_sb;
-	int err = 0, rc, block;
+	int err = 0, block;
 	int need_datasync = 0, set_large_file = 0;
 	uid_t i_uid;
 	gid_t i_gid;
@@ -5138,9 +5138,9 @@ static int ext4_do_update_inode(handle_t *handle,
 					      bh->b_data);
 
 	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
-	rc = ext4_handle_dirty_metadata(handle, NULL, bh);
-	if (!err)
-		err = rc;
+	err = ext4_handle_dirty_metadata(handle, NULL, bh);
+	if (err)
+		goto out_brelse;
 	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
 	if (set_large_file) {
 		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
-- 
2.19.1

