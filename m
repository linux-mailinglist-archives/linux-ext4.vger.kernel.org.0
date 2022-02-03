Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE54A7F14
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 06:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiBCF0i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 00:26:38 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33109 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229872AbiBCF0h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 00:26:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V3UBDaW_1643865995;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V3UBDaW_1643865995)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Feb 2022 13:26:35 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mm/fs: remove variable bdi set but not used
Date:   Thu,  3 Feb 2022 13:26:33 +0800
Message-Id: <20220203052633.54000-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The code that uses the pointer 'bdi' has been removed in commit:
'37c32ade079f000c8e539730f254b14fae0d3b49' and inode_to_bdi() doesn't
change 'inode', so the declaration and assignment of 'bdi' can be removed.

Eliminate the following clang warning:
fs/ext2/ialloc.c:173:27: warning: variable 'bdi' set but not used

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ext2/ialloc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
index d632764da240..998dd2ac8008 100644
--- a/fs/ext2/ialloc.c
+++ b/fs/ext2/ialloc.c
@@ -170,9 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
 	unsigned long offset;
 	unsigned long block;
 	struct ext2_group_desc * gdp;
-	struct backing_dev_info *bdi;
-
-	bdi = inode_to_bdi(inode);
 
 	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
 	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
-- 
2.20.1.7.g153144c

