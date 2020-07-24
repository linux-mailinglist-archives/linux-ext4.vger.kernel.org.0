Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E1F22BC76
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jul 2020 05:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGXDay (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jul 2020 23:30:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbgGXDay (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jul 2020 23:30:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6EA336ED2EADCCFCC7B6;
        Fri, 24 Jul 2020 11:30:52 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 24 Jul 2020
 11:30:48 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <riteshh@linux.ibm.com>
Subject: [PATCH v2] ext4: remove some redundant function declarations
Date:   Thu, 23 Jul 2020 23:29:54 -0400
Message-ID: <20200724032954.22097-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ext4 update feature functions do not exist now, remove these useless
function declarations.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ext4.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..196b52c75422 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2924,12 +2924,6 @@ do {									\
 
 #endif
 
-extern int ext4_update_compat_feature(handle_t *handle, struct super_block *sb,
-					__u32 compat);
-extern int ext4_update_rocompat_feature(handle_t *handle,
-					struct super_block *sb,	__u32 rocompat);
-extern int ext4_update_incompat_feature(handle_t *handle,
-					struct super_block *sb,	__u32 incompat);
 extern ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
 				      struct ext4_group_desc *bg);
 extern ext4_fsblk_t ext4_inode_bitmap(struct super_block *sb,
-- 
2.19.1

