Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D133A3F15F2
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Aug 2021 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhHSJOc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Aug 2021 05:14:32 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34164 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229804AbhHSJO3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 19 Aug 2021 05:14:29 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Uk0e9q-_1629364431;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uk0e9q-_1629364431)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 19 Aug 2021 17:13:52 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] ext4: fix reserved space counter leakage
Date:   Thu, 19 Aug 2021 17:13:51 +0800
Message-Id: <20210819091351.19297-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When ext4_es_insert_delayed_block() returns error, e.g., ENOMEM,
previously reserved space is not released as the error handling,
in which case @s_dirtyclusters_counter is left over. Since this delayed
extent failes to be inserted into extent status tree, when inode is
written back, the extra @s_dirtyclusters_counter won't be subtracted and
remains there forever.

This can leads to /sys/fs/ext4/<dev>/delayed_allocation_blocks remains
non-zero even when syncfs is executed on the filesystem.

Fixes: 51865fda28e5 ("ext4: let ext4 maintain extent status tree")
Cc: <stable@vger.kernel.org>
Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/ext4/inode.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 82087657860b..7f15da370281 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1650,6 +1650,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret;
 	bool allocated = false;
+	bool reserved = false;
 
 	/*
 	 * If the cluster containing lblk is shared with a delayed,
@@ -1666,6 +1667,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 		ret = ext4_da_reserve_space(inode);
 		if (ret != 0)   /* ENOSPC */
 			goto errout;
+		reserved = true;
 	} else {   /* bigalloc */
 		if (!ext4_es_scan_clu(inode, &ext4_es_is_delonly, lblk)) {
 			if (!ext4_es_scan_clu(inode,
@@ -1678,6 +1680,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 					ret = ext4_da_reserve_space(inode);
 					if (ret != 0)   /* ENOSPC */
 						goto errout;
+					reserved = true;
 				} else {
 					allocated = true;
 				}
@@ -1688,6 +1691,8 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	}
 
 	ret = ext4_es_insert_delayed_block(inode, lblk, allocated);
+	if (ret && reserved)
+		ext4_da_release_space(inode, 1);
 
 errout:
 	return ret;
-- 
2.27.0

