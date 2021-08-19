Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0003F13C1
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhHSGrO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 02:47:14 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8043 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhHSGrN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Aug 2021 02:47:13 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqwJy2fSdzYqdQ;
        Thu, 19 Aug 2021 14:46:10 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggeme752-chm.china.huawei.com
 (10.3.19.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 19
 Aug 2021 14:46:35 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 3/4] ext4: don't return error if huge_file feature mismatch
Date:   Thu, 19 Aug 2021 14:57:03 +0800
Message-ID: <20210819065704.1248402-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819065704.1248402-1-yi.zhang@huawei.com>
References: <20210819065704.1248402-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_inode_blocks_set(), huge_file feature should exist when setting
i_blocks beyond a 32 bit variable could be represented, return EFBIG if
not. This error should never happen in theory since sb->s_maxbytes should
not have allowed this, and we have already init sb->s_maxbytes according
to this feature in ext4_fill_super(). So switch to use WARN_ON_ONCE
instead.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index eae1b2d0b550..d0d7a5295bf9 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4902,9 +4902,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	return ERR_PTR(ret);
 }
 
-static int ext4_inode_blocks_set(handle_t *handle,
-				struct ext4_inode *raw_inode,
-				struct ext4_inode_info *ei)
+static void ext4_inode_blocks_set(handle_t *handle,
+				  struct ext4_inode *raw_inode,
+				  struct ext4_inode_info *ei)
 {
 	struct inode *inode = &(ei->vfs_inode);
 	u64 i_blocks = READ_ONCE(inode->i_blocks);
@@ -4918,10 +4918,15 @@ static int ext4_inode_blocks_set(handle_t *handle,
 		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
 		raw_inode->i_blocks_high = 0;
 		ext4_clear_inode_flag(inode, EXT4_INODE_HUGE_FILE);
-		return 0;
+		return;
 	}
-	if (!ext4_has_feature_huge_file(sb))
-		return -EFBIG;
+
+	/*
+	 * This should never happen since sb->s_maxbytes should not have
+	 * allowed this, which was set according to the huge_file feature
+	 * in ext4_fill_super().
+	 */
+	WARN_ON_ONCE(!ext4_has_feature_huge_file(sb));
 
 	if (i_blocks <= 0xffffffffffffULL) {
 		/*
@@ -4938,7 +4943,6 @@ static int ext4_inode_blocks_set(handle_t *handle,
 		raw_inode->i_blocks_lo   = cpu_to_le32(i_blocks);
 		raw_inode->i_blocks_high = cpu_to_le16(i_blocks >> 32);
 	}
-	return 0;
 }
 
 static void __ext4_update_other_inode_time(struct super_block *sb,
@@ -5029,11 +5033,7 @@ static int ext4_do_update_inode(handle_t *handle,
 	if (ext4_test_inode_state(inode, EXT4_STATE_NEW))
 		memset(raw_inode, 0, EXT4_SB(inode->i_sb)->s_inode_size);
 
-	err = ext4_inode_blocks_set(handle, raw_inode, ei);
-	if (err) {
-		spin_unlock(&ei->i_raw_lock);
-		goto out_brelse;
-	}
+	ext4_inode_blocks_set(handle, raw_inode, ei);
 
 	raw_inode->i_mode = cpu_to_le16(inode->i_mode);
 	i_uid = i_uid_read(inode);
-- 
2.31.1

