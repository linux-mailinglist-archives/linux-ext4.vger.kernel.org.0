Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADEE3BBE77
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhGEOxr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 10:53:47 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45581 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231843AbhGEOxq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 10:53:46 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 165EooiP000952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 5 Jul 2021 10:50:50 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D520215C3C91; Mon,  5 Jul 2021 10:50:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Zhang Yi <yi.zhang@huawei.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2] ext4: inline jbd2_journal_[un]register_shrinker()
Date:   Mon,  5 Jul 2021 10:50:25 -0400
Message-Id: <20210705145025.3363130-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <3acc3ee6-3a3d-3b26-7580-b20955270913@huawei.com>
References: <3acc3ee6-3a3d-3b26-7580-b20955270913@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The function jbd2_journal_unregister_shrinker() was getting called
twice when the file system was getting unmounted.  On Power and ARM
platforms this was causing kernel crash when unmounting the file
system, when a percpu_counter was destroyed twice.

Fix this by removing jbd2_journal_[un]register_shrinker() functions,
and inlining the shrinker setup and teardown into
journal_init_common() and jbd2_journal_destroy().  This means that
ext4 and ocfs2 now no longer need to know about registering and
unregistering jbd2's shrinker.

Also, while we're at it, rename the percpu counter from
j_jh_shrink_count to j_checkpoint_jh_count, since this makes it
clearer what this counter is intended to track.

Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c      |   8 ---
 fs/jbd2/checkpoint.c |   4 +-
 fs/jbd2/journal.c    | 149 +++++++++++++++++--------------------------
 include/linux/jbd2.h |   6 +-
 4 files changed, 64 insertions(+), 103 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b8ff0399e171..dfa09a277b56 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1184,7 +1184,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_unregister_sysfs(sb);
 
 	if (sbi->s_journal) {
-		jbd2_journal_unregister_shrinker(sbi->s_journal);
 		aborted = is_journal_aborted(sbi->s_journal);
 		err = jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
@@ -5176,7 +5175,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->s_ea_block_cache = NULL;
 
 	if (sbi->s_journal) {
-		jbd2_journal_unregister_shrinker(sbi->s_journal);
 		jbd2_journal_destroy(sbi->s_journal);
 		sbi->s_journal = NULL;
 	}
@@ -5502,12 +5500,6 @@ static int ext4_load_journal(struct super_block *sb,
 		ext4_commit_super(sb);
 	}
 
-	err = jbd2_journal_register_shrinker(journal);
-	if (err) {
-		EXT4_SB(sb)->s_journal = NULL;
-		goto err_out;
-	}
-
 	return 0;
 
 err_out:
diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 51d1eb2ffeb9..746132998c57 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -701,7 +701,7 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
 
 	__buffer_unlink(jh);
 	jh->b_cp_transaction = NULL;
-	percpu_counter_dec(&journal->j_jh_shrink_count);
+	percpu_counter_dec(&journal->j_checkpoint_jh_count);
 	jbd2_journal_put_journal_head(jh);
 
 	/* Is this transaction empty? */
@@ -764,7 +764,7 @@ void __jbd2_journal_insert_checkpoint(struct journal_head *jh,
 		jh->b_cpnext->b_cpprev = jh;
 	}
 	transaction->t_checkpoint_list = jh;
-	percpu_counter_inc(&transaction->t_journal->j_jh_shrink_count);
+	percpu_counter_inc(&transaction->t_journal->j_checkpoint_jh_count);
 }
 
 /*
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 152880c298ca..35302bc192eb 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1283,6 +1283,48 @@ static int jbd2_min_tag_size(void)
 	return sizeof(journal_block_tag_t) - 4;
 }
 
+/**
+ * jbd2_journal_shrink_scan()
+ *
+ * Scan the checkpointed buffer on the checkpoint list and release the
+ * journal_head.
+ */
+static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
+					      struct shrink_control *sc)
+{
+	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	unsigned long nr_to_scan = sc->nr_to_scan;
+	unsigned long nr_shrunk;
+	unsigned long count;
+
+	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
+	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
+
+	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
+
+	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
+	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
+
+	return nr_shrunk;
+}
+
+/**
+ * jbd2_journal_shrink_count()
+ *
+ * Count the number of checkpoint buffers on the checkpoint list.
+ */
+static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
+					       struct shrink_control *sc)
+{
+	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
+	unsigned long count;
+
+	count = percpu_counter_read_positive(&journal->j_checkpoint_jh_count);
+	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
+
+	return count;
+}
+
 /*
  * Management for journal control blocks: functions to create and
  * destroy journal_t structures, and to initialise and read existing
@@ -1361,9 +1403,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_sb_buffer = bh;
 	journal->j_superblock = (journal_superblock_t *)bh->b_data;
 
+	journal->j_shrink_transaction = NULL;
+	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
+	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
+	journal->j_shrinker.seeks = DEFAULT_SEEKS;
+	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
+
+	if (percpu_counter_init(&journal->j_checkpoint_jh_count, 0, GFP_KERNEL))
+		goto err_cleanup;
+
+	if (register_shrinker(&journal->j_shrinker)) {
+		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
+		goto err_cleanup;
+	}
 	return journal;
 
 err_cleanup:
+	brelse(journal->j_sb_buffer);
 	kfree(journal->j_wbuf);
 	jbd2_journal_destroy_revoke(journal);
 	kfree(journal);
@@ -2050,93 +2106,6 @@ int jbd2_journal_load(journal_t *journal)
 	return -EIO;
 }
 
-/**
- * jbd2_journal_shrink_scan()
- *
- * Scan the checkpointed buffer on the checkpoint list and release the
- * journal_head.
- */
-static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
-					      struct shrink_control *sc)
-{
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
-	unsigned long nr_to_scan = sc->nr_to_scan;
-	unsigned long nr_shrunk;
-	unsigned long count;
-
-	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
-	trace_jbd2_shrink_scan_enter(journal, sc->nr_to_scan, count);
-
-	nr_shrunk = jbd2_journal_shrink_checkpoint_list(journal, &nr_to_scan);
-
-	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
-	trace_jbd2_shrink_scan_exit(journal, nr_to_scan, nr_shrunk, count);
-
-	return nr_shrunk;
-}
-
-/**
- * jbd2_journal_shrink_count()
- *
- * Count the number of checkpoint buffers on the checkpoint list.
- */
-static unsigned long jbd2_journal_shrink_count(struct shrinker *shrink,
-					       struct shrink_control *sc)
-{
-	journal_t *journal = container_of(shrink, journal_t, j_shrinker);
-	unsigned long count;
-
-	count = percpu_counter_read_positive(&journal->j_jh_shrink_count);
-	trace_jbd2_shrink_count(journal, sc->nr_to_scan, count);
-
-	return count;
-}
-
-/**
- * jbd2_journal_register_shrinker()
- * @journal: Journal to act on.
- *
- * Init a percpu counter to record the checkpointed buffers on the checkpoint
- * list and register a shrinker to release their journal_head.
- */
-int jbd2_journal_register_shrinker(journal_t *journal)
-{
-	int err;
-
-	journal->j_shrink_transaction = NULL;
-
-	err = percpu_counter_init(&journal->j_jh_shrink_count, 0, GFP_KERNEL);
-	if (err)
-		return err;
-
-	journal->j_shrinker.scan_objects = jbd2_journal_shrink_scan;
-	journal->j_shrinker.count_objects = jbd2_journal_shrink_count;
-	journal->j_shrinker.seeks = DEFAULT_SEEKS;
-	journal->j_shrinker.batch = journal->j_max_transaction_buffers;
-
-	err = register_shrinker(&journal->j_shrinker);
-	if (err) {
-		percpu_counter_destroy(&journal->j_jh_shrink_count);
-		return err;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(jbd2_journal_register_shrinker);
-
-/**
- * jbd2_journal_unregister_shrinker()
- * @journal: Journal to act on.
- *
- * Unregister the checkpointed buffer shrinker and destroy the percpu counter.
- */
-void jbd2_journal_unregister_shrinker(journal_t *journal)
-{
-	percpu_counter_destroy(&journal->j_jh_shrink_count);
-	unregister_shrinker(&journal->j_shrinker);
-}
-EXPORT_SYMBOL(jbd2_journal_unregister_shrinker);
-
 /**
  * jbd2_journal_destroy() - Release a journal_t structure.
  * @journal: Journal to act on.
@@ -2209,8 +2178,10 @@ int jbd2_journal_destroy(journal_t *journal)
 		brelse(journal->j_sb_buffer);
 	}
 
-	jbd2_journal_unregister_shrinker(journal);
-
+	if (journal->j_shrinker.flags & SHRINKER_REGISTERED) {
+		percpu_counter_destroy(&journal->j_checkpoint_jh_count);
+		unregister_shrinker(&journal->j_shrinker);
+	}
 	if (journal->j_proc_entry)
 		jbd2_stats_proc_exit(journal);
 	iput(journal->j_inode);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 6cc035321562..fd933c45281a 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -918,11 +918,11 @@ struct journal_s
 	struct shrinker		j_shrinker;
 
 	/**
-	 * @j_jh_shrink_count:
+	 * @j_checkpoint_jh_count:
 	 *
 	 * Number of journal buffers on the checkpoint list. [j_list_lock]
 	 */
-	struct percpu_counter	j_jh_shrink_count;
+	struct percpu_counter	j_checkpoint_jh_count;
 
 	/**
 	 * @j_shrink_transaction:
@@ -1556,8 +1556,6 @@ extern int	   jbd2_journal_set_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern void	   jbd2_journal_clear_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
-extern int	   jbd2_journal_register_shrinker(journal_t *journal);
-extern void	   jbd2_journal_unregister_shrinker(journal_t *journal);
 extern int	   jbd2_journal_load       (journal_t *journal);
 extern int	   jbd2_journal_destroy    (journal_t *);
 extern int	   jbd2_journal_recover    (journal_t *journal);
-- 
2.31.0

