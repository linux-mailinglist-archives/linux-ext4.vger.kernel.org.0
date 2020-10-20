Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372B22932AF
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Oct 2020 03:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgJTBcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 21:32:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15235 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728702AbgJTBcb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Oct 2020 21:32:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C39A9DA67446B305636C;
        Tue, 20 Oct 2020 09:32:28 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 20 Oct 2020 09:32:20 +0800
From:   Luo Meng <luomeng12@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <luomeng12@huawei.com>
Subject: [PATCH] ext4: fix invalid inode checksum
Date:   Tue, 20 Oct 2020 09:36:31 +0800
Message-ID: <20201020013631.3796673-1-luomeng12@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

During the stability test, there are some errors:
  ext4_lookup:1590: inode #6967: comm fsstress: iget: checksum invalid.

If the inode->i_iblocks too big and doesn't set huge file flag, checksum
will not be recalculated when update the inode information to it's buffer.
If other inode marks the buffer dirty, then the inconsistent inode will
be flushed to disk.

Fix this problem by checking i_blocks in advance.

Signed-off-by: Luo Meng <luomeng12@huawei.com>
---
 fs/ext4/inode.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bf596467c234..fe53774b8b6c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4971,6 +4971,12 @@ static int ext4_do_update_inode(handle_t *handle,
 	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
 		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
 
+	err = ext4_inode_blocks_set(handle, raw_inode, ei);
+	if (err) {
+		spin_unlock(&ei->i_raw_lock);
+		goto out_brelse;
+	}
+
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	i_uid = i_uid_read(inode);
 	i_gid = i_gid_read(inode);
@@ -5004,11 +5010,6 @@ static int ext4_do_update_inode(handle_t *handle,
 	EXT4_INODE_SET_XTIME(i_atime, inode, raw_inode);
 	EXT4_EINODE_SET_XTIME(i_crtime, ei, raw_inode);
 
-	err = ext4_inode_blocks_set(handle, raw_inode, ei);
-	if (err) {
-		spin_unlock(&ei->i_raw_lock);
-		goto out_brelse;
-	}
 	raw_inode->i_dtime = cpu_to_le32(ei->i_dtime);
 	raw_inode->i_flags = cpu_to_le32(ei->i_flags & 0xFFFFFFFF);
 	if (likely(!test_opt2(inode->i_sb, HURD_COMPAT)))
-- 
2.25.4

