Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3516B3592FD
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 05:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhDIDW4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 23:22:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16105 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhDIDWy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 23:22:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FGk0W00hTz1BGRq
        for <linux-ext4@vger.kernel.org>; Fri,  9 Apr 2021 11:20:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Fri, 9 Apr 2021
 11:22:29 +0800
From:   Jack Qiu <jack.qiu@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack.qiu@huawei.com>
Subject: [PATCH -next] ext4: fix trailing whitespace
Date:   Fri, 9 Apr 2021 12:20:35 +0800
Message-ID: <20210409042035.15516-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Made suggested modifications from checkpatch in reference to ERROR:
 trailing whitespace

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/ext4/balloc.c  | 2 +-
 fs/ext4/mballoc.c | 2 +-
 fs/ext4/namei.c   | 6 +++---
 fs/ext4/super.c   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 74a5172c2d83..9dc6e74b265c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -239,7 +239,7 @@ unsigned ext4_free_clusters_after_init(struct super_block *sb,
 				       ext4_group_t block_group,
 				       struct ext4_group_desc *gdp)
 {
-	return num_clusters_in_group(sb, block_group) -
+	return num_clusters_in_group(sb, block_group) -
 		ext4_num_overhead_clusters(sb, block_group, gdp);
 }

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf4fc84..1e39ff5cdde2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2590,7 +2590,7 @@ int ext4_mb_alloc_groupinfo(struct super_block *sb, ext4_group_t ngroups)
 	sbi->s_group_info_size = size / sizeof(*sbi->s_group_info);
 	if (old_groupinfo)
 		ext4_kvfree_array_rcu(old_groupinfo);
-	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
+	ext4_debug("allocated s_groupinfo array for %d meta_bg's\n",
 		   sbi->s_group_info_size);
 	return 0;
 }
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 883e2a7cd4ab..996b89b406c5 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2139,10 +2139,10 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,

 	retval = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
 	if (retval)
-		goto out_frames;	
+		goto out_frames;
 	retval = ext4_handle_dirty_dirblock(handle, dir, bh2);
 	if (retval)
-		goto out_frames;	
+		goto out_frames;

 	de = do_split(handle,dir, &bh2, frame, &fname->hinfo);
 	if (IS_ERR(de)) {
@@ -3372,7 +3372,7 @@ static int ext4_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 		 * for transaction commit if we are running out of space
 		 * and thus we deadlock. So we have to stop transaction now
 		 * and restart it when symlink contents is written.
-		 *
+		 *
 		 * To keep fs consistent in case of crash, we have to put inode
 		 * to orphan list in the mean time.
 		 */
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b9693680463a..675f5de6ac06 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4996,7 +4996,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 			ext4_journal_commit_callback;

 	block = ext4_count_free_clusters(sb);
-	ext4_free_blocks_count_set(sbi->s_es,
+	ext4_free_blocks_count_set(sbi->s_es,
 				   EXT4_C2B(sbi, block));
 	err = percpu_counter_init(&sbi->s_freeclusters_counter, block,
 				  GFP_KERNEL);
--
2.17.1

