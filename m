Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DFDBA150
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2019 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfIVHFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 22 Sep 2019 03:05:23 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:42780 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727621AbfIVHFX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 22 Sep 2019 03:05:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0Td15.Q0_1569135917;
Received: from localhost(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Td15.Q0_1569135917)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 22 Sep 2019 15:05:19 +0800
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
To:     linux-ext4@vger.kernel.org
Subject: [RFC 2/2] ext4: add async_checkpoint mount option
Date:   Sun, 22 Sep 2019 15:04:59 +0800
Message-Id: <20190922070459.39797-3-xiaoguang.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20190922070459.39797-1-xiaoguang.wang@linux.alibaba.com>
References: <20190922070459.39797-1-xiaoguang.wang@linux.alibaba.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Since now jbd2 supports doing transactions checkpoint asynchronously
and initiatively when free journal space is lower than user specified
threshold, here add a new mount option "async_checkpoint" for users
to enable or disable this jbd2 feature.

Usage:
    # with default threshold 50%
    sudo mount -o async_checkpoint /dev/nvme0n1 mntpoint

    # user specifies a threshold 30%
    sudo mount -o async_checkpoint=30 /dev/nvme0n1 mntpoint

    # do a remount to enable this feature with default threshold 50%
    sudo mount -o remount,async_checkpoint /dev/nvme0n1

    # do a remount to enable this feature with threshold 30%
    sudo mount -o remount,async_checkpoint=30 /dev/nvme0n1

    # disable this feature
    sudo mount -o remount,noasync_checkpoint /dev/nvme0n1

I have used fs_mark to have performance tests:
fs_mark -d mntpoint/testdir/ -D 16 -t 32 -n 500000 -s 4096 -S $sync_mode -N 256 -k
here sync_mode would be 0, 1, 2, 3, 4, 5 and 6, and transactions commit info comes
from /proc/fs/jbd2/nvme0n1-8/info.

Please also refer to fs_mark's README  for what sync_mode means.

Test 1: sync_mod = 0
  without patch:
    Average Files/sec:      96898.0
    177 transactions (177 requested), each up to 65536 block
  with patch:
    Average Files/sec:      97727.0
    177 transactions (177 requested), each up to 65536 blocks
About 0.8% improvement, not obvious.

Test 2: sync_mod = 1
  without patch:
    Average Files/sec:      46780.0
    1210422 transactions (1210422 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      49510.0
    1053905 transactions (1053905 requested), each up to 65536 blocks
About 5.8% improvement, and the number of transactions are decreased.

Test 3: sync_mod = 2
  without patch:
    Average Files/sec:      71072.0
    190 transactions (190 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      72464.0
    189 transactions (189 requested), each up to 65536 blocks
About 1.9% improvement.

Test 4: sync_mod = 3
  without patch:
    Average Files/sec:      61977.0
    282973 transactions (282973 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      70962.0
    88148 transactions (88148 requested), each up to 65536 blocks
About 14.4% improvement, it's much obvious, and the number of
transactions are decreased greatly.

Test 5: sync_mod = 4
  without patch:
    Average Files/sec:      69796.0
    190 transactions (190 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      70708.0
    189 transactions (189 requested), each up to 65536 blocks
About 1.3% improvement, not obvious.

Test 6: sync_mod = 5
  without patch:
    Average Files/sec:      61523.0
    411394 transactions (411394 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      66785.0
    280367 transactions (280367 requested), each up to 65536 blocks
About 8.5% improvement, it's obvious, and the number of
transactions are decreased greatly.

Test 7: sync_mod = 6
  without patch:
    Average Files/sec:      70129.0
    189 transactions (189 requested), each up to 65536 blocks
  with patch:
    Average Files/sec:      69194.0
    190 transactions (190 requested), each up to 65536 blocks
About 1.3% performance regression, it's not obvious.

From above tests, we can see that in most cases, async checkpoint
will give some performance improvement.

Signed-off-by: Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
---
 fs/ext4/ext4.h  |  2 ++
 fs/ext4/super.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 1cb6785..f53a64d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1123,6 +1123,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT_JOURNAL_CHECKSUM	0x800000 /* Journal checksums */
 #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT	0x1000000 /* Journal Async Commit */
 #define EXT4_MOUNT_WARN_ON_ERROR	0x2000000 /* Trigger WARN_ON on error */
+#define EXT4_MOUNT_JOURNAL_ASYNC_CHECKPOINT	0x4000000 /* Journal Async Checkpoint */
 #define EXT4_MOUNT_DELALLOC		0x8000000 /* Delalloc support */
 #define EXT4_MOUNT_DATA_ERR_ABORT	0x10000000 /* Abort on file data write */
 #define EXT4_MOUNT_BLOCK_VALIDITY	0x20000000 /* Block validity checking */
@@ -1411,6 +1412,7 @@ struct ext4_sb_info {
 	struct mutex s_orphan_lock;
 	unsigned long s_ext4_flags;		/* Ext4 superblock flags */
 	unsigned long s_commit_interval;
+	unsigned int s_async_checkponit_thresh;
 	u32 s_max_batch_time;
 	u32 s_min_batch_time;
 	struct block_device *journal_bdev;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4079605..ae21338 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -54,6 +54,7 @@
 #include "acl.h"
 #include "mballoc.h"
 #include "fsmap.h"
+#include <linux/jbd2.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ext4.h>
@@ -1455,6 +1456,7 @@ enum {
 	Opt_dioread_nolock, Opt_dioread_lock,
 	Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
+	Opt_async_checkpoint, Opt_noasync_checkpoint,
 };
 
 static const match_table_t tokens = {
@@ -1546,6 +1548,9 @@ enum {
 	{Opt_removed, "reservation"},	/* mount option from ext2/3 */
 	{Opt_removed, "noreservation"}, /* mount option from ext2/3 */
 	{Opt_removed, "journal=%u"},	/* mount option from ext2/3 */
+	{Opt_async_checkpoint, "async_checkpoint=%u"},
+	{Opt_async_checkpoint, "async_checkpoint"},
+	{Opt_noasync_checkpoint, "noasync_checkpoint"},
 	{Opt_err, NULL},
 };
 
@@ -1751,6 +1756,9 @@ static int clear_qf_name(struct super_block *sb, int qtype)
 	{Opt_max_dir_size_kb, 0, MOPT_GTE0},
 	{Opt_test_dummy_encryption, 0, MOPT_GTE0},
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
+	{Opt_async_checkpoint, 0, MOPT_GTE0},
+	{Opt_noasync_checkpoint, EXT4_MOUNT_JOURNAL_ASYNC_CHECKPOINT,
+		MOPT_CLEAR},
 	{Opt_err, 0, 0}
 };
 
@@ -2016,6 +2024,11 @@ static int handle_mount_opt(struct super_block *sb, char *opt, int token,
 		sbi->s_mount_opt |= m->mount_opt;
 	} else if (token == Opt_data_err_ignore) {
 		sbi->s_mount_opt &= ~m->mount_opt;
+	} else if (token == Opt_async_checkpoint) {
+		set_opt(sb, JOURNAL_ASYNC_CHECKPOINT);
+		if (!args->from)
+			arg = JBD2_DEFAULT_ASYCN_CHECKPOINT_THRESH;
+		sbi->s_async_checkponit_thresh = arg;
 	} else {
 		if (!args->from)
 			arg = 1;
@@ -2234,6 +2247,11 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PUTS("data_err=abort");
 	if (DUMMY_ENCRYPTION_ENABLED(sbi))
 		SEQ_OPTS_PUTS("test_dummy_encryption");
+	if (test_opt(sb, JOURNAL_ASYNC_CHECKPOINT) && (nodefs ||
+	    (sbi->s_async_checkponit_thresh !=
+	    JBD2_DEFAULT_ASYCN_CHECKPOINT_THRESH)))
+		SEQ_OPTS_PRINT("async_checkpoint=%u",
+			       sbi->s_async_checkponit_thresh);
 
 	ext4_show_quota_options(seq, sb);
 	return 0;
@@ -4700,6 +4718,38 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
 	write_unlock(&journal->j_state_lock);
 }
 
+static int ext4_init_journal_async_checkpoint(struct super_block *sb,
+			journal_t *journal)
+{
+	struct workqueue_struct *wq;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+
+	wq = alloc_workqueue("jbd2-checkpoint-wq",
+			     WQ_MEM_RECLAIM | WQ_UNBOUND, 1);
+	if (!wq) {
+		pr_err("%s: failed to create workqueue\n", __func__);
+		return -ENOMEM;
+	}
+	INIT_WORK(&journal->j_checkpoint_work, jbd2_log_do_checkpoint_async);
+
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_ASYNC_CHECKPOINT;
+	journal->j_checkpoint_wq = wq;
+	journal->j_async_checkpoint_thresh =
+			sbi->s_async_checkponit_thresh;
+	journal->j_async_checkpoint_run = 0;
+	write_unlock(&journal->j_state_lock);
+	return 0;
+}
+
+static void ext4_destroy_journal_async_checkpoint(journal_t *journal)
+{
+	write_lock(&journal->j_state_lock);
+	journal->j_flags &= ~JBD2_ASYNC_CHECKPOINT;
+	write_unlock(&journal->j_state_lock);
+	jbd2_journal_destroy_async_checkpoint_wq(journal);
+}
+
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					     unsigned int journal_inum)
 {
@@ -4737,6 +4787,7 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 {
 	struct inode *journal_inode;
 	journal_t *journal;
+	int ret;
 
 	BUG_ON(!ext4_has_feature_journal(sb));
 
@@ -4752,6 +4803,11 @@ static journal_t *ext4_get_journal(struct super_block *sb,
 	}
 	journal->j_private = sb;
 	ext4_init_journal_params(sb, journal);
+	ret = ext4_init_journal_async_checkpoint(sb, journal);
+	if (ret) {
+		jbd2_journal_destroy(journal);
+		return NULL;
+	}
 	return journal;
 }
 
@@ -4767,6 +4823,7 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	unsigned long offset;
 	struct ext4_super_block *es;
 	struct block_device *bdev;
+	int ret;
 
 	BUG_ON(!ext4_has_feature_journal(sb));
 
@@ -4841,6 +4898,10 @@ static journal_t *ext4_get_dev_journal(struct super_block *sb,
 	}
 	EXT4_SB(sb)->journal_bdev = bdev;
 	ext4_init_journal_params(sb, journal);
+	ret = ext4_init_journal_async_checkpoint(sb, journal);
+	if (ret)
+		goto out_journal;
+
 	return journal;
 
 out_journal:
@@ -5471,6 +5532,16 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 #endif
 
+	if ((old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_ASYNC_CHECKPOINT) &&
+	    !test_opt(sb, JOURNAL_ASYNC_CHECKPOINT))
+		ext4_destroy_journal_async_checkpoint(sbi->s_journal);
+	else if (!(old_opts.s_mount_opt & EXT4_MOUNT_JOURNAL_ASYNC_CHECKPOINT) &&
+	    test_opt(sb, JOURNAL_ASYNC_CHECKPOINT)) {
+		err = ext4_init_journal_async_checkpoint(sb, sbi->s_journal);
+		if (err)
+			goto restore_opts;
+	}
+
 	*flags = (*flags & ~SB_LAZYTIME) | (sb->s_flags & SB_LAZYTIME);
 	ext4_msg(sb, KERN_INFO, "re-mounted. Opts: %s", orig_data);
 	kfree(orig_data);
-- 
1.8.3.1

