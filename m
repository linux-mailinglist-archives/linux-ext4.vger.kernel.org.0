Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC16F623989
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 03:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiKJCFR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 21:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiKJCEj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 21:04:39 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197E2632
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 18:04:38 -0800 (PST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N74s24DnkzmVlG;
        Thu, 10 Nov 2022 10:04:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 10:04:36 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 12/12] ext4: remove simulate fail facility
Date:   Thu, 10 Nov 2022 10:25:58 +0800
Message-ID: <20221110022558.7844-13-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221110022558.7844-1-yi.zhang@huawei.com>
References: <20221110022558.7844-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that we have fault injection support for ext4, it could replace
current simulate fail facility entirely, so this patch remove all
ext4_simulate_fail() interface and supports.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/balloc.c |  4 +---
 fs/ext4/ext4.h   | 38 --------------------------------------
 fs/ext4/ialloc.c |  4 +---
 fs/ext4/inode.c  |  6 ++----
 fs/ext4/namei.c  | 10 +++-------
 fs/ext4/sysfs.c  |  6 ------
 6 files changed, 7 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index ff5c90f4386d..999e66d9dc45 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -384,8 +384,7 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 	if (buffer_verified(bh))
 		goto verified;
 	if (unlikely(!ext4_block_bitmap_csum_verify(sb, block_group,
-						    desc, bh) ||
-		     ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_CRC))) {
+						    desc, bh))) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "bg %u: bad block bitmap checksum", block_group);
 		ext4_mark_group_bitmap_corrupted(sb, block_group,
@@ -537,7 +536,6 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 	if (!desc)
 		return -EFSCORRUPTED;
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		ext4_error_err(sb, EIO, "Cannot read block bitmap - "
 			       "block_group = %u, block_bitmap = %llu",
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 96b805992ea5..74b5b36c39d3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1849,9 +1849,6 @@ struct ext4_sb_info {
 	struct percpu_rw_semaphore s_writepages_rwsem;
 	struct dax_device *s_daxdev;
 	u64 s_dax_part_off;
-#ifdef CONFIG_EXT4_DEBUG
-	unsigned long s_simulate_fail;
-#endif
 #ifdef CONFIG_EXT4_FAULT_INJECTION
 	struct ext4_fault_attr s_fault_attr;
 #endif
@@ -1966,41 +1963,6 @@ static inline int ext4_test_mount_flag(struct super_block *sb, int bit)
 	return test_bit(bit, &EXT4_SB(sb)->s_mount_flags);
 }
 
-
-/*
- * Simulate_fail codes
- */
-#define EXT4_SIM_BBITMAP_EIO	1
-#define EXT4_SIM_BBITMAP_CRC	2
-#define EXT4_SIM_IBITMAP_EIO	3
-#define EXT4_SIM_IBITMAP_CRC	4
-#define EXT4_SIM_INODE_EIO	5
-#define EXT4_SIM_INODE_CRC	6
-#define EXT4_SIM_DIRBLOCK_EIO	7
-#define EXT4_SIM_DIRBLOCK_CRC	8
-
-static inline bool ext4_simulate_fail(struct super_block *sb,
-				     unsigned long code)
-{
-#ifdef CONFIG_EXT4_DEBUG
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-
-	if (unlikely(sbi->s_simulate_fail == code)) {
-		sbi->s_simulate_fail = 0;
-		return true;
-	}
-#endif
-	return false;
-}
-
-static inline void ext4_simulate_fail_bh(struct super_block *sb,
-					 struct buffer_head *bh,
-					 unsigned long code)
-{
-	if (!IS_ERR(bh) && ext4_simulate_fail(sb, code))
-		clear_buffer_uptodate(bh);
-}
-
 /*
  * Error number codes for s_{first,last}_error_errno
  *
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e299aa80a718..a45f0c0aaa3a 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -99,8 +99,7 @@ static int ext4_validate_inode_bitmap(struct super_block *sb,
 		goto verified;
 	blk = ext4_inode_bitmap(sb, desc);
 	if (!ext4_inode_bitmap_csum_verify(sb, block_group, desc, bh,
-					   EXT4_INODES_PER_GROUP(sb) / 8) ||
-	    ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_CRC)) {
+					   EXT4_INODES_PER_GROUP(sb) / 8)) {
 		ext4_unlock_group(sb, block_group);
 		ext4_error(sb, "Corrupt inode bitmap - block_group = %u, "
 			   "inode_bitmap = %llu", block_group, blk);
@@ -200,7 +199,6 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 		goto read_err;
 	}
 	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		err = -EIO;
 		goto read_err;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 8c611ad6dac1..20546338bc2a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4578,7 +4578,6 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
 	blk_finish_plug(&plug);
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
 	if (!buffer_uptodate(bh))
 		goto err;
 has_buffer:
@@ -4835,9 +4834,8 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 					      sizeof(gen));
 	}
 
-	if ((!ext4_inode_csum_verify(inode, raw_inode, ei) ||
-	    ext4_simulate_fail(sb, EXT4_SIM_INODE_CRC)) &&
-	     (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))) {
+	if (!ext4_inode_csum_verify(inode, raw_inode, ei) &&
+	    (!(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY))) {
 		ext4_error_inode_err(inode, function, line, 0,
 				EFSBADCRC, "iget: checksum invalid");
 		ret = -EFSBADCRC;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index fa754f1ba4a6..e410e4c0357a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -138,9 +138,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		return ERR_PTR(-EFSCORRUPTED);
 	}
 
-	if (ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_EIO))
-		bh = ERR_PTR(-EIO);
-	else if (ext4_fault_dirblock_io(inode, block))
+	if (ext4_fault_dirblock_io(inode, block))
 		bh = ERR_PTR(-EIO);
 	else
 		bh = ext4_bread(NULL, inode, block, 0);
@@ -187,8 +185,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 	 * caller is sure it should be an index block.
 	 */
 	if (is_dx_block && type == INDEX) {
-		if (ext4_dx_csum_verify(inode, dirent) &&
-		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
+		if (ext4_dx_csum_verify(inode, dirent))
 			set_buffer_verified(bh);
 		else {
 			ext4_error_inode_err(inode, func, line, block,
@@ -199,8 +196,7 @@ static struct buffer_head *__ext4_read_dirblock(struct inode *inode,
 		}
 	}
 	if (!is_dx_block) {
-		if (ext4_dirblock_csum_verify(inode, bh) &&
-		    !ext4_simulate_fail(inode->i_sb, EXT4_SIM_DIRBLOCK_CRC))
+		if (ext4_dirblock_csum_verify(inode, bh))
 			set_buffer_verified(bh);
 		else {
 			ext4_error_inode_err(inode, func, line, block,
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index da725e128c89..11fc508de336 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -227,9 +227,6 @@ EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.int
 EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
 EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
-#ifdef CONFIG_EXT4_DEBUG
-EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
-#endif
 EXT4_RO_ATTR_SBI_ATOMIC(warning_count, s_warning_count);
 EXT4_RO_ATTR_SBI_ATOMIC(msg_count, s_msg_count);
 EXT4_RO_ATTR_ES_UI(errors_count, s_error_count);
@@ -294,9 +291,6 @@ static struct attribute *ext4_attrs[] = {
 	ATTR_LIST(first_error_time),
 	ATTR_LIST(last_error_time),
 	ATTR_LIST(journal_task),
-#ifdef CONFIG_EXT4_DEBUG
-	ATTR_LIST(simulate_fail),
-#endif
 	ATTR_LIST(mb_prefetch),
 	ATTR_LIST(mb_prefetch_limit),
 	ATTR_LIST(last_trim_minblks),
-- 
2.31.1

