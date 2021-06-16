Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275F43A9842
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhFPK7T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 06:59:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35754 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhFPK7M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Jun 2021 06:59:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D40861FD47;
        Wed, 16 Jun 2021 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623841024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qtK0xxHxaujtC4VIuhzpcZ1tkGwhP3WecV9yeaARhg=;
        b=LLedbOwFiV37w8YT7VXK7bUCfWWYIJNDi+EIhOlMj9JUokeEVwALSApgMoOzWadBFzSLIm
        /YuR/76RUFaPNVnRp9FDuxL+H8KABwva76irCPHS4JziTVEsZ1WjvLskeLAtC5vBa+jwhk
        GqFrQ+9n0DVJCYM0W/eH6rlQZy3VYdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623841024;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qtK0xxHxaujtC4VIuhzpcZ1tkGwhP3WecV9yeaARhg=;
        b=DDH7+wWtn+VgmtFPIYUDDIptSJ6gb4uTNdx1wO6qQFUK+2XuDSivNQH+DnyANsRLMVRPob
        fZsIASG56uPUU6DQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C1B0FA3BB3;
        Wed, 16 Jun 2021 10:57:04 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5778D1F2CBC; Wed, 16 Jun 2021 12:57:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] ext4: Improve scalability of ext4 orphan file handling
Date:   Wed, 16 Jun 2021 12:56:55 +0200
Message-Id: <20210616105655.5129-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210616105655.5129-1-jack@suse.cz>
References: <20210616105655.5129-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7316; h=from:subject; bh=vffqIcgiKhklEeeCUotstx6DTbnKQ8WplOKQZWohiCQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBgydj2C9L7VHgmF1hrCZCMTuslwIXLQgX2a9Lw+zqA tcAxo6yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYMnY9gAKCRCcnaoHP2RA2QFYB/ 0U5S0cxoV+QxyklMj5QcPLJ1ga6TEn2b2K5OGsIxZ8DDRNF57q+LZIN+E0SOLpGaoyUFYljXy7yqF4 gBvU6ZOq0rmyqDYkRGqPeQO6CwnG1FjWp+Za9PaObiWx0affejdF8KxPHt8ZWRaVNIMLbjrbYf5ip0 NzZ4DpERjudYbvpbWetgw2QUh/AFEsxaUpJxOMCgJv2RxHnq/AxH1AxC2qYj7muhVyz7g6UUDldugr YG10OjlYD+B8OjJblw1Glu7fu2wtq9UU8jzePLQMVm9pzjI0ZSCiZx3J90w6ndNPc6p3M+PwekcdV/ DreCopgB2xJA0C7cGI4tLBljVu0Xoo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Even though the length of the critical section when adding / removing
orphaned inodes was significantly reduced by using orphan file, the
contention of lock protecting orphan file still appears high in profiles
for truncate / unlink intensive workloads with high number of threads.

This patch makes handling of orphan file completely lockless. Also to
reduce conflicts between CPUs different CPUs start searching for empty
slot in orphan file in different blocks.

Performance comparison of locked orphan file handling, lockless orphan
file handling, and completely disabled orphan inode handling
from 80 CPU Xeon Server with 526 GB of RAM, filesystem located on
SAS SSD disk, average of 5 runs:

stress-orphan (microbenchmark truncating files byte-by-byte from N
processes in parallel)

Threads Time            Time            Time
        Orphan locked   Orphan lockless No orphan
  1       0.945600       0.939400        0.891200
  2       1.331800       1.246600        1.174400
  4       1.995000       1.780600        1.713200
  8       6.424200       4.900000        4.106000
 16      14.937600       8.516400        8.138000
 32      33.038200      24.565600       24.002200
 64      60.823600      39.844600       38.440200
128     122.941400      70.950400       69.315000

So we can see that with lockless orphan file handling, addition /
deletion of orphaned inodes got almost completely out of picture even
for a microbenchmark stressing it.

For reaim creat_clo workload on ramdisk there are also noticeable gains
(average of 5 runs):

Clients         Vanilla (ops/s)        Patched (ops/s)
creat_clo-1     14705.88 (   0.00%)    14354.07 *  -2.39%*
creat_clo-3     27108.43 (   0.00%)    28301.89 (   4.40%)
creat_clo-5     37406.48 (   0.00%)    45180.73 *  20.78%*
creat_clo-7     41338.58 (   0.00%)    54687.50 *  32.29%*
creat_clo-9     45226.13 (   0.00%)    62937.07 *  39.16%*
creat_clo-11    44000.00 (   0.00%)    65088.76 *  47.93%*
creat_clo-13    36516.85 (   0.00%)    68661.97 *  88.03%*
creat_clo-15    30864.20 (   0.00%)    69551.78 * 125.35%*
creat_clo-17    27478.45 (   0.00%)    67729.08 * 146.48%*
creat_clo-19    25000.00 (   0.00%)    61621.62 * 146.49%*
creat_clo-21    18772.35 (   0.00%)    63829.79 * 240.02%*
creat_clo-23    16698.94 (   0.00%)    61938.96 * 270.92%*
creat_clo-25    14973.05 (   0.00%)    56947.61 * 280.33%*
creat_clo-27    16436.69 (   0.00%)    65008.03 * 295.51%*
creat_clo-29    13949.01 (   0.00%)    69047.62 * 395.00%*
creat_clo-31    14283.52 (   0.00%)    67982.45 * 375.95%*

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h   |  3 +--
 fs/ext4/orphan.c | 55 +++++++++++++++++++++++++++---------------------
 2 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 83298c0b6dae..d08927e19b76 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1480,7 +1480,7 @@ static inline int ext4_inodes_per_orphan_block(struct super_block *sb)
 }
 
 struct ext4_orphan_block {
-	int ob_free_entries;	/* Number of free orphan entries in block */
+	atomic_t ob_free_entries;	/* Number of free orphan entries in block */
 	struct buffer_head *ob_bh;	/* Buffer for orphan block */
 };
 
@@ -1488,7 +1488,6 @@ struct ext4_orphan_block {
  * Info about orphan file.
  */
 struct ext4_orphan_info {
-	spinlock_t of_lock;
 	int of_blocks;			/* Number of orphan blocks in a file */
 	__u32 of_csum_seed;		/* Checksum seed for orphan file */
 	struct ext4_orphan_block *of_binfo;	/* Array with info about orphan
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index ac22667b7fd5..010222cde4f7 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -10,16 +10,30 @@
 
 static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
 {
-	int i, j;
+	int i, j, start;
 	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
 	int ret = 0;
+	bool found = false;
 	__le32 *bdata;
 	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
 
-	spin_lock(&oi->of_lock);
-	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
-	if (i == oi->of_blocks) {
-		spin_unlock(&oi->of_lock);
+	/*
+	 * Find block with free orphan entry. Use CPU number for a naive hash
+	 * for a search start in the orphan file
+	 */
+	start = raw_smp_processor_id()*13 % oi->of_blocks;
+	i = start;
+	do {
+		if (atomic_dec_if_positive(&oi->of_binfo[i].ob_free_entries)
+		    >= 0) {
+			found = true;
+			break;
+		}
+		if (++i >= oi->of_blocks)
+			i = 0;
+	} while (i != start);
+
+	if (!found) {
 		/*
 		 * For now we don't grow or shrink orphan file. We just use
 		 * whatever was allocated at mke2fs time. The additional
@@ -28,28 +42,24 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
 		 */
 		return -ENOSPC;
 	}
-	oi->of_binfo[i].ob_free_entries--;
-	spin_unlock(&oi->of_lock);
 
-	/*
-	 * Get access to orphan block. We have dropped of_lock but since we
-	 * have decremented number of free entries we are guaranteed free entry
-	 * in our block.
-	 */
 	ret = ext4_journal_get_write_access(handle, inode->i_sb,
 				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
 	if (ret)
 		return ret;
 
 	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
-	spin_lock(&oi->of_lock);
 	/* Find empty slot in a block */
-	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
-	BUG_ON(j == inodes_per_ob);
-	bdata[j] = cpu_to_le32(inode->i_ino);
+	j = 0;
+	do {
+		while (bdata[j]) {
+			if (++j >= inodes_per_ob)
+				j = 0;
+		}
+	} while (cmpxchg(&bdata[j], 0, cpu_to_le32(inode->i_ino)) != 0);
+
 	EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
 	ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
-	spin_unlock(&oi->of_lock);
 
 	return ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[i].ob_bh);
 }
@@ -178,10 +188,8 @@ static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
 		goto out;
 
 	bdata = (__le32 *)(oi->of_binfo[blk].ob_bh->b_data);
-	spin_lock(&oi->of_lock);
 	bdata[off] = 0;
-	oi->of_binfo[blk].ob_free_entries++;
-	spin_unlock(&oi->of_lock);
+	atomic_inc(&oi->of_binfo[blk].ob_free_entries);
 	ret = ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[blk].ob_bh);
 out:
 	ext4_clear_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
@@ -534,8 +542,6 @@ int ext4_init_orphan_info(struct super_block *sb)
 	struct ext4_orphan_block_tail *ot;
 	ino_t orphan_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_orphan_file_inum);
 
-	spin_lock_init(&oi->of_lock);
-
 	if (!ext4_has_feature_orphan_file(sb))
 		return 0;
 
@@ -579,7 +585,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 		for (j = 0; j < inodes_per_ob; j++)
 			if (bdata[j] == 0)
 				free++;
-		oi->of_binfo[i].ob_free_entries = free;
+		atomic_set(&oi->of_binfo[i].ob_free_entries, free);
 	}
 	iput(inode);
 	return 0;
@@ -601,7 +607,8 @@ int ext4_orphan_file_empty(struct super_block *sb)
 	if (!ext4_has_feature_orphan_file(sb))
 		return 1;
 	for (i = 0; i < oi->of_blocks; i++)
-		if (oi->of_binfo[i].ob_free_entries != inodes_per_ob)
+		if (atomic_read(&oi->of_binfo[i].ob_free_entries) !=
+		    inodes_per_ob)
 			return 0;
 	return 1;
 }
-- 
2.26.2

