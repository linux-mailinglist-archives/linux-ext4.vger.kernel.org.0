Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2301876C354
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Aug 2023 05:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjHBDIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 23:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjHBDIB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 23:08:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE0010C7
        for <linux-ext4@vger.kernel.org>; Tue,  1 Aug 2023 20:07:58 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RFxf659R0zNmdG;
        Wed,  2 Aug 2023 11:04:30 +0800 (CST)
Received: from ci.huawei.com (10.67.175.89) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 11:07:56 +0800
From:   Cai Xinchen <caixinchen1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <caixinchen1@huawei.com>
Subject: [PATCH -next] ext4: remove unused function declaration
Date:   Wed, 2 Aug 2023 03:00:25 +0000
Message-ID: <20230802030025.173148-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.89]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These functions do not have its function implementation.
So those function declaration is useless. Remove these

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 fs/ext4/ext4.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1e2259d9967d..1c4b04da21fa 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2708,7 +2708,6 @@ extern ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
 extern int ext4_claim_free_clusters(struct ext4_sb_info *sbi,
 				    s64 nclusters, unsigned int flags);
 extern ext4_fsblk_t ext4_count_free_clusters(struct super_block *);
-extern void ext4_check_blocks_bitmap(struct super_block *);
 extern struct ext4_group_desc * ext4_get_group_desc(struct super_block * sb,
 						    ext4_group_t block_group,
 						    struct buffer_head ** bh);
@@ -2864,7 +2863,6 @@ extern void ext4_free_inode(handle_t *, struct inode *);
 extern struct inode * ext4_orphan_get(struct super_block *, unsigned long);
 extern unsigned long ext4_count_free_inodes(struct super_block *);
 extern unsigned long ext4_count_dirs(struct super_block *);
-extern void ext4_check_inodes_bitmap(struct super_block *);
 extern void ext4_mark_bitmap_end(int start_bit, int end_bit, char *bitmap);
 extern int ext4_init_inode_table(struct super_block *sb,
 				 ext4_group_t group, int barrier);
@@ -2907,7 +2905,6 @@ extern int ext4_mb_init(struct super_block *);
 extern int ext4_mb_release(struct super_block *);
 extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
 				struct ext4_allocation_request *, int *);
-extern int ext4_mb_reserve_blocks(struct super_block *, int);
 extern void ext4_discard_preallocations(struct inode *, unsigned int);
 extern int __init ext4_init_mballoc(void);
 extern void ext4_exit_mballoc(void);
@@ -2983,7 +2980,6 @@ extern void ext4_evict_inode(struct inode *);
 extern void ext4_clear_inode(struct inode *);
 extern int  ext4_file_getattr(struct mnt_idmap *, const struct path *,
 			      struct kstat *, u32, unsigned int);
-extern int  ext4_sync_inode(handle_t *, struct inode *);
 extern void ext4_dirty_inode(struct inode *, int);
 extern int ext4_change_inode_journal_flag(struct inode *, int);
 extern int ext4_get_inode_loc(struct inode *, struct ext4_iloc *);
@@ -3531,8 +3527,6 @@ extern loff_t ext4_llseek(struct file *file, loff_t offset, int origin);
 /* inline.c */
 extern int ext4_get_max_inline_size(struct inode *inode);
 extern int ext4_find_inline_data_nolock(struct inode *inode);
-extern int ext4_init_inline_data(handle_t *handle, struct inode *inode,
-				 unsigned int len);
 extern int ext4_destroy_inline_data(handle_t *handle, struct inode *inode);
 
 int ext4_readpage_inline(struct inode *inode, struct folio *folio);
-- 
2.17.1

