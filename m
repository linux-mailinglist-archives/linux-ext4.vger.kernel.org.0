Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3946B6BE557
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 10:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjCQJRq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Mar 2023 05:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbjCQJRo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Mar 2023 05:17:44 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED479BA52
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 02:17:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PdJS574vRz4f3l7d
        for <linux-ext4@vger.kernel.org>; Fri, 17 Mar 2023 17:17:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLMcMBRkQ24kFg--.44440S6;
        Fri, 17 Mar 2023 17:17:27 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v2 2/3] debugfs/e2fsck: update the journal head block after recovery
Date:   Fri, 17 Mar 2023 17:17:15 +0800
Message-Id: <20230317091716.4150992-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230317091716.4150992-1-yi.zhang@huaweicloud.com>
References: <20230317091716.4150992-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLMcMBRkQ24kFg--.44440S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtw48Jr1UuryrKFWkGw1kuFg_yoWxJryfpF
        4DCr98Cryqvw4UZas7JFs8JFWYva4jyFyUWrZFkwnaya15Kwnav348try3tFWDuFnYg3W8
        Zr1rAw1DGw4UK37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUI4E_UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

The s_head parameter is not uptodate if the journal is not empty, so
we need to update it after recovery. We also reset it to the journal
first block if something wrong.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 debugfs/journal.c |  5 ++++-
 e2fsck/journal.c  |  6 +++++-
 e2fsck/recovery.c | 21 +++++++++++++++++----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 5bac0d3b..5bc7552d 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -636,6 +636,7 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	journal->j_tail = ntohl(jsb->s_start);
 	journal->j_first = ntohl(jsb->s_first);
 	journal->j_last = ntohl(jsb->s_maxlen);
+	journal->j_head = ntohl(jsb->s_head);
 
 	return 0;
 }
@@ -650,8 +651,10 @@ static void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
 	else if (fs->flags & EXT2_FLAG_RW) {
 		jsb = journal->j_superblock;
 		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
+		if (reset) {
+			jsb->s_head = htonl(journal->j_head);
 			jsb->s_start = 0; /* this marks the journal as empty */
+		}
 		ext2fs_journal_sb_csum_set(journal, jsb);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index c7868d89..8950446f 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -1378,6 +1378,7 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	journal->j_transaction_sequence = journal->j_tail_sequence;
 	journal->j_tail = ntohl(jsb->s_start);
 	journal->j_first = ntohl(jsb->s_first);
+	journal->j_head = ntohl(jsb->s_head);
 	if (jbd2_has_feature_fast_commit(journal)) {
 		if (ntohl(jsb->s_maxlen) - jbd2_journal_get_num_fc_blks(jsb)
 			< JBD2_MIN_JOURNAL_BLOCKS) {
@@ -1426,6 +1427,7 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	jsb->s_blocksize = htonl(ctx->fs->blocksize);
 	jsb->s_maxlen = htonl(journal->j_total_len);
 	jsb->s_first = htonl(1);
+	jsb->s_head = jsb->s_first;
 
 	/* Initialize the journal sequence number so that there is "no"
 	 * chance we will find old "valid" transactions in the journal.
@@ -1474,8 +1476,10 @@ static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
 	else if (!(ctx->options & E2F_OPT_READONLY)) {
 		jsb = journal->j_superblock;
 		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
+		if (reset) {
+			jsb->s_head = htonl(journal->j_head);
 			jsb->s_start = 0; /* this marks the journal as empty */
+		}
 		e2fsck_journal_sb_csum_set(journal, jsb);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 8ca35271..ea3a7646 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -29,6 +29,7 @@ struct recovery_info
 {
 	tid_t		start_transaction;
 	tid_t		end_transaction;
+	unsigned long	head_block;
 
 	int		nr_replays;
 	int		nr_revokes;
@@ -297,9 +298,10 @@ int jbd2_journal_recover(journal_t *journal)
 	 */
 
 	if (!sb->s_start) {
-		jbd_debug(1, "No recovery required, last transaction %d\n",
-			  be32_to_cpu(sb->s_sequence));
+		jbd_debug(1, "No recovery required, last transaction %d, head block %u\n",
+			  be32_to_cpu(sb->s_sequence), be32_to_cpu(sb->s_head));
 		journal->j_transaction_sequence = be32_to_cpu(sb->s_sequence) + 1;
+		journal->j_head = be32_to_cpu(sb->s_head);
 		return 0;
 	}
 
@@ -318,6 +320,9 @@ int jbd2_journal_recover(journal_t *journal)
 	/* Restart the log at the next transaction ID, thus invalidating
 	 * any existing commit records in the log. */
 	journal->j_transaction_sequence = ++info.end_transaction;
+	journal->j_head = info.head_block;
+	jbd_debug(1, "JBD2: last transaction %d, head block %lu\n",
+		  journal->j_transaction_sequence, journal->j_head);
 
 	jbd2_journal_clear_revoke(journal);
 	err2 = sync_blockdev(journal->j_fs_dev);
@@ -358,6 +363,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 	if (err) {
 		printk(KERN_ERR "JBD2: error %d scanning journal\n", err);
 		++journal->j_transaction_sequence;
+		journal->j_head = journal->j_first;
 	} else {
 #ifdef CONFIG_JBD2_DEBUG
 		int dropped = info.end_transaction - 
@@ -367,6 +373,7 @@ int jbd2_journal_skip_recovery(journal_t *journal)
 			  dropped, (dropped == 1) ? "" : "s");
 #endif
 		journal->j_transaction_sequence = ++info.end_transaction;
+		journal->j_head = info.head_block;
 	}
 
 	journal->j_tail = 0;
@@ -456,7 +463,7 @@ static int do_one_pass(journal_t *journal,
 			struct recovery_info *info, enum passtype pass)
 {
 	unsigned int		first_commit_ID, next_commit_ID;
-	unsigned long		next_log_block;
+	unsigned long		next_log_block, head_block;
 	int			err, success = 0;
 	journal_superblock_t *	sb;
 	journal_header_t *	tmp;
@@ -479,6 +486,7 @@ static int do_one_pass(journal_t *journal,
 	sb = journal->j_superblock;
 	next_commit_ID = be32_to_cpu(sb->s_sequence);
 	next_log_block = be32_to_cpu(sb->s_start);
+	head_block = next_log_block;
 
 	first_commit_ID = next_commit_ID;
 	if (pass == PASS_SCAN)
@@ -804,6 +812,7 @@ static int do_one_pass(journal_t *journal,
 				if (commit_time < last_trans_commit_time)
 					goto ignore_crc_mismatch;
 				info->end_transaction = next_commit_ID;
+				info->head_block = head_block;
 
 				if (!jbd2_has_feature_async_commit(journal)) {
 					journal->j_failed_commit =
@@ -812,8 +821,10 @@ static int do_one_pass(journal_t *journal,
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
@@ -863,6 +874,8 @@ static int do_one_pass(journal_t *journal,
 	if (pass == PASS_SCAN) {
 		if (!info->end_transaction)
 			info->end_transaction = next_commit_ID;
+		if (!info->head_block)
+			info->head_block = head_block;
 	} else {
 		/* It's really bad news if different passes end up at
 		 * different places (but possible due to IO errors). */
-- 
2.31.1

