Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19176730F8
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 06:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjASFIF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 00:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjASFHA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 00:07:00 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75DA46D44
        for <linux-ext4@vger.kernel.org>; Wed, 18 Jan 2023 21:01:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ny7pD737Rz4f3wTb
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 11:46:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7P4vMhj97D1Bw--.22527S5;
        Thu, 19 Jan 2023 11:46:15 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [RFC PATCH 1/2] jbd2: cycled record log on clean journal logging area
Date:   Thu, 19 Jan 2023 11:45:59 +0800
Message-Id: <20230119034600.3431194-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
References: <20230119034600.3431194-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7P4vMhj97D1Bw--.22527S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4fXryrZFWDuF1kWrykKrg_yoW3AFWrpF
        WkCasxGrWDZr4UXF97JF4kJFWYv3y0yFWUGr9Fk3Zava15Kw1Iv3srtry3tFyDur9Y93W0
        vr18C3srGw1jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbjjg7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

For a newly mounted file system, the journal committing thread always
record log from the beginning of the journal area, no matter whether the
journal is clean or it has just been recovered. It is disadvantageous to
analysis corrupted file system image and locate the file system
inconsistency bugs. When we get a corrupted file system image and want
to find out what has happened, besides lookup the system log, one
effective may is to backtrack the journal log. But we may not always run
e2fsck before each mount and the default fsck -a mode also cannot always
find all inconsistencies, so it could left over some inconsistencies
into the next mount until we detect it. Finally, the transactions in the
journal may probably discontinuous and some relatively new transactions
has been covered, it becomes hard to analyse. So if we could records
transactions continuously between each mounts, we could acquire more
useful info from the journal.

 |Previous mount checkpointed/recovered logs|Current mount logs         |
 |{------}{---}{--------} ... {------}| ... |{======}{========}...000000|

This patch save the head blocknr in the superblock after flushing the
journal or unmounting the file system, let the next mount could continue
to record new transaction behind it. This change is backward compatible
because the old kernel does not care about the head blocknr of the
journal. It is also fine if we mount a clean old image without valid
head blocknr, we fail back to set it to s_first just like before.
Finally, for the case of mount an unclean file system, we could also get
the journal head easily after scanning the journal, it will continue to
record new transaction after the recovered transactions.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c    | 18 ++++++++++++++++--
 fs/jbd2/recovery.c   | 22 +++++++++++++++++-----
 include/linux/jbd2.h |  9 +++++++--
 3 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2696f43e7239..41f0f5625e7c 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1557,8 +1557,21 @@ static int journal_reset(journal_t *journal)
 	journal->j_first = first;
 	journal->j_last = last;
 
-	journal->j_head = journal->j_first;
-	journal->j_tail = journal->j_first;
+	if (journal->j_flags & JBD2_CYCLE_RECORD) {
+		/*
+		 * Disable the cycled recording mode if the journal head block
+		 * number is not correct.
+		 */
+		if (journal->j_head < first || journal->j_head >= last) {
+			printk(KERN_WARNING "JBD2: Incorrect Journal head block %lu, "
+			       "disable journal_cycle_record\n",
+			       journal->j_head);
+			journal->j_head = journal->j_first;
+		}
+	} else {
+		journal->j_head = journal->j_first;
+	}
+	journal->j_tail = journal->j_head;
 	journal->j_free = journal->j_last - journal->j_first;
 
 	journal->j_tail_sequence = journal->j_transaction_sequence;
@@ -1730,6 +1743,7 @@ static void jbd2_mark_journal_empty(journal_t *journal, blk_opf_t write_flags)
 
 	sb->s_sequence = cpu_to_be32(journal->j_tail_sequence);
 	sb->s_start    = cpu_to_be32(0);
+	sb->s_head     = cpu_to_be32(journal->j_head);
 	if (jbd2_has_feature_fast_commit(journal)) {
 		/*
 		 * When journal is clean, no need to commit fast commit flag and
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index 8286a9ec122f..6f6bcb75fffe 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -29,6 +29,7 @@ struct recovery_info
 {
 	tid_t		start_transaction;
 	tid_t		end_transaction;
+	unsigned long	head_block;
 
 	int		nr_replays;
 	int		nr_revokes;
@@ -301,11 +302,11 @@ int jbd2_journal_recover(journal_t *journal)
 	 * is always zero if, and only if, the journal was cleanly
 	 * unmounted.
 	 */
-
 	if (!sb->s_start) {
-		jbd2_debug(1, "No recovery required, last transaction %d\n",
-			  be32_to_cpu(sb->s_sequence));
+		jbd2_debug(1, "No recovery required, last transaction %d, head block %u\n",
+			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
+		journal->j_head = be32_to_cpu(sb->s_head);
 		return 0;
 	}
 
@@ -324,6 +325,9 @@ int jbd2_journal_recover(journal_t *journal)
 	/* Restart the log at the next transaction ID, thus invalidating
 	 * any existing commit records in the log. */
 	journal->j_transaction_sequence = ++info.end_transaction;
+	journal->j_head = info.head_block;
+	jbd2_debug(1, "JBD2: last transaction %d, head block %u\n",
+		  journal->j_transaction_sequence, journal->j_head);
 
 	jbd2_journal_clear_revoke(journal);
 	err2 = sync_blockdev(journal->j_fs_dev);
@@ -364,6 +368,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 	if (err) {
 		printk(KERN_ERR "JBD2: error %d scanning journal\n", err);
 		++journal->j_transaction_sequence;
+		journal->j_head = journal->j_first;
 	} else {
 #ifdef CONFIG_JBD2_DEBUG
 		int dropped = info.end_transaction - 
@@ -373,6 +378,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			  dropped, (dropped == 1) ? "" : "s");
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
+		journal->j_head = info.head_block;
 	}
 
 	journal->j_tail = 0;
@@ -462,7 +468,7 @@ static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
 	unsigned int		first_commit_ID, next_commit_ID;
-	unsigned long		next_log_block;
+	unsigned long		next_log_block, head_block;
 	int			err, success = 0;
 	journal_superblock_t *	sb;
 	journal_header_t *	tmp;
@@ -485,6 +491,7 @@ static int do_one_pass(journal_t *journal,
 	sb = journal->j_superblock;
 	next_commit_ID = be32_to_cpu(sb->s_sequence);
 	next_log_block = be32_to_cpu(sb->s_start);
+	head_block = next_log_block;
 
 	first_commit_ID = next_commit_ID;
 	if (pass == PASS_SCAN)
@@ -809,6 +816,7 @@ static int do_one_pass(journal_t *journal,
 				if (commit_time < last_trans_commit_time)
 					goto ignore_crc_mismatch;
 				info->end_transaction = next_commit_ID;
+				info->head_block = head_block;
 
 				if (!jbd2_has_feature_async_commit(journal)) {
 					journal->j_failed_commit =
@@ -817,8 +825,10 @@ static int do_one_pass(journal_t *journal,
 					break;
 				}
 			}
-			if (pass == PASS_SCAN)
+			if (pass == PASS_SCAN) {
 				last_trans_commit_time = commit_time;
+				head_block = next_log_block;
+			}
 			brelse(bh);
 			next_commit_ID++;
 			continue;
@@ -868,6 +878,8 @@ static int do_one_pass(journal_t *journal,
 	if (pass == PASS_SCAN) {
 		if (!info->end_transaction)
 			info->end_transaction = next_commit_ID;
+		if (!info->head_block)
+			info->head_block = head_block;
 	} else {
 		/* It's really bad news if different passes end up at
 		 * different places (but possible due to IO errors). */
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 2170e0cc279d..d5843ebfa6ed 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -265,8 +265,10 @@ typedef struct journal_superblock_s
 	__u8	s_padding2[3];
 /* 0x0054 */
 	__be32	s_num_fc_blks;		/* Number of fast commit blocks */
-/* 0x0058 */
-	__u32	s_padding[41];
+	__be32	s_head;			/* blocknr of head of log, only uptodate
+					 * while the filesystem is clean */
+/* 0x005C */
+	__u32	s_padding[40];
 	__be32	s_checksum;		/* crc32c(superblock) */
 
 /* 0x0100 */
@@ -1392,6 +1394,9 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
 #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
 						 * data write error in ordered
 						 * mode */
+#define JBD2_CYCLE_RECORD		0x080	/* Journal cycled record log on
+						 * clean and empty filesystem
+						 * logging area */
 #define JBD2_FAST_COMMIT_ONGOING	0x100	/* Fast commit is ongoing */
 #define JBD2_FULL_COMMIT_ONGOING	0x200	/* Full commit is ongoing */
 #define JBD2_JOURNAL_FLUSH_DISCARD	0x0001
-- 
2.31.1

