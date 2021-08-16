Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390733ED162
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 11:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbhHPJ5s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 05:57:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45368 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbhHPJ5q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 05:57:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 400911FEB6;
        Mon, 16 Aug 2021 09:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629107834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7N0m4fSS49HfM3KLqilegjePPrmVOq14QAu0NjSOqA=;
        b=YnlwnaupGtGAUjc99/XLl7wpAHPWhtCSRQzJlVpQHLuVuOg/UEowT03MTFuGpTzzOFwjFN
        27EVGv1mJ1x9SCFhHCi8sbPC6C/mViW+EW0M5izq9SybRBKr5YkcUpSG0DQw5ybK69rTBP
        +NA1GEbrI2yGkTWtAhxYska6Qs1yveU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629107834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7N0m4fSS49HfM3KLqilegjePPrmVOq14QAu0NjSOqA=;
        b=p8Rju7XbqnXn9TZ+/W32PwG+VcUQjG61fHqzL8JOa0gjf0/ui5sFbeHtCvlI9Fq/vGULAc
        DUAuV34wUneZqHBw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 2F69EA3B94;
        Mon, 16 Aug 2021 09:57:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F19581E0BF2; Mon, 16 Aug 2021 11:57:13 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Lukas Czerner <lczerner@redhat.com>
Subject: [PATCH 5/5] ext4: Improve scalability of ext4 orphan file handling
Date:   Mon, 16 Aug 2021 11:57:08 +0200
Message-Id: <20210816095713.16537-5-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210816093626.18767-1-jack@suse.cz>
References: <20210816093626.18767-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7992; h=from:subject; bh=5Up5JpttnLrEqHAp33U9GcEL4uoTqUrsmPpy4SzZx+o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhGjZzOnkkaL3VTJHPmGxYLfz7Y9PywU4Pm6aedf+u XGTdJWeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYRo2cwAKCRCcnaoHP2RA2QWZB/ 9DC0iit5RQaJu2kmbKffb78u1XopxCvuCm0qj/IWkhUO74mW7E2IctruGtBDpCB+IL95g4iV4cGZMD H78oNOWrNLkya+cfFZPM6+yw8vn3ws2Dpk9lJoO1T5nGN3qoOEtShTa213r9PopSTfv9Q2/o+jS/+B ImAEJqQFUgox1mImwosdZLOvInxYNFo7OFQmcSpyN8wNWDZy3/ddyipjuWjNT/kNFVCMy8EDb03O1H xH0WnGduGlBcdBvRkUrDLErGsas2yNW6eGztzNIMfvom7gMG8j2L0xzamqPYyeLYs6VkISSbEUpm2s wL16Ld9fsq1M6xm4g07JMgsKAXFCpE
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

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h   |  3 +-
 fs/ext4/orphan.c | 77 ++++++++++++++++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 456d6efe6613..5a2cbd0e5bd3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1489,7 +1489,7 @@ static inline int ext4_inodes_per_orphan_block(struct super_block *sb)
 }
 
 struct ext4_orphan_block {
-	int ob_free_entries;	/* Number of free orphan entries in block */
+	atomic_t ob_free_entries;	/* Number of free orphan entries in block */
 	struct buffer_head *ob_bh;	/* Buffer for orphan block */
 };
 
@@ -1497,7 +1497,6 @@ struct ext4_orphan_block {
  * Info about orphan file.
  */
 struct ext4_orphan_info {
-	spinlock_t of_lock;
 	int of_blocks;			/* Number of orphan blocks in a file */
 	__u32 of_csum_seed;		/* Checksum seed for orphan file */
 	struct ext4_orphan_block *of_binfo;	/* Array with info about orphan
diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
index ac928f60234a..53adc8f570a3 100644
--- a/fs/ext4/orphan.c
+++ b/fs/ext4/orphan.c
@@ -10,16 +10,31 @@
 
 static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
 {
-	int i, j;
+	int i, j, start;
 	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
 	int ret = 0;
+	bool found = false;
 	__le32 *bdata;
 	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
+	int looped = 0;
+
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
 
-	spin_lock(&oi->of_lock);
-	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
-	if (i == oi->of_blocks) {
-		spin_unlock(&oi->of_lock);
+	if (!found) {
 		/*
 		 * For now we don't grow or shrink orphan file. We just use
 		 * whatever was allocated at mke2fs time. The additional
@@ -28,28 +43,43 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
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
-	if (ret)
+	if (ret) {
+		atomic_inc(&oi->of_binfo[i].ob_free_entries);
 		return ret;
+	}
 
 	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
-	spin_lock(&oi->of_lock);
 	/* Find empty slot in a block */
-	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
-	BUG_ON(j == inodes_per_ob);
-	bdata[j] = cpu_to_le32(inode->i_ino);
+	j = 0;
+	do {
+		if (looped) {
+			/*
+			 * Did we walk through the block several times without
+			 * finding free entry? It is theoretically possible
+			 * if entries get constantly allocated and freed or
+			 * if the block is corrupted. Avoid indefinite looping
+			 * and bail. We'll use orphan list instead.
+			 */
+			if (looped > 3) {
+				atomic_inc(&oi->of_binfo[i].ob_free_entries);
+				return -ENOSPC;
+			}
+			cond_resched();
+		}
+		while (bdata[j]) {
+			if (++j >= inodes_per_ob) {
+				j = 0;
+				looped++;
+			}
+		}
+	} while (cmpxchg(&bdata[j], (__le32)0, cpu_to_le32(inode->i_ino)) !=
+		 (__le32)0);
+
 	EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
 	ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
-	spin_unlock(&oi->of_lock);
 
 	return ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[i].ob_bh);
 }
@@ -180,10 +210,8 @@ static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
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
@@ -552,8 +580,6 @@ int ext4_init_orphan_info(struct super_block *sb)
 	struct ext4_orphan_block_tail *ot;
 	ino_t orphan_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_orphan_file_inum);
 
-	spin_lock_init(&oi->of_lock);
-
 	if (!ext4_has_feature_orphan_file(sb))
 		return 0;
 
@@ -597,7 +623,7 @@ int ext4_init_orphan_info(struct super_block *sb)
 		for (j = 0; j < inodes_per_ob; j++)
 			if (bdata[j] == 0)
 				free++;
-		oi->of_binfo[i].ob_free_entries = free;
+		atomic_set(&oi->of_binfo[i].ob_free_entries, free);
 	}
 	iput(inode);
 	return 0;
@@ -619,7 +645,8 @@ int ext4_orphan_file_empty(struct super_block *sb)
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

