Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46F3581BA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 13:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhDHL2Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 07:28:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15973 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbhDHL2Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 07:28:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FGJqD16lWzyNc1;
        Thu,  8 Apr 2021 19:26:00 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 8 Apr 2021
 19:28:01 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 3/3] ext4: add rcu to prevent use after free when umount filesystem
Date:   Thu, 8 Apr 2021 19:36:18 +0800
Message-ID: <20210408113618.1033785-4-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210408113618.1033785-1-yi.zhang@huawei.com>
References: <20210408113618.1033785-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There is a race between bdev_try_to_free_page() and
jbd2_journal_destroy() that could end up triggering a use after free
issue about journal.

drop cache                           umount filesystem
bdev_try_to_free_page()
 get journal
 jbd2_journal_try_to_free_buffers()  ext4_put_super()
                                      kfree(journal)
   access journal <-- lead to UAF

The above race also could happens between the bdev_try_to_free_page()
and the error path of ext4_fill_super(). This patch avoid this race by
add rcu protection around accessing sbi->s_journal in
bdev_try_to_free_page() and destroy the journal after an rcu grace
period.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/super.c      | 33 ++++++++++++++++++++++++---------
 fs/jbd2/journal.c    | 30 +++++++++++++++++++++++++++---
 include/linux/jbd2.h | 11 ++++++++++-
 3 files changed, 61 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 02ba47a5bc70..6bbaadc5357b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1150,6 +1150,21 @@ static inline void ext4_quota_off_umount(struct super_block *sb)
 }
 #endif
 
+static int ext4_journal_release(struct ext4_sb_info *sbi)
+{
+	journal_t *journal = sbi->s_journal;
+	int ret;
+
+	ret = jbd2_journal_release(journal);
+	sbi->s_journal = NULL;
+	/*
+	 * Call rcu to prevent racing with bdev_try_to_free_page()
+	 * accessing the journal at the same time.
+	 */
+	call_rcu(&journal->j_rcu, jbd2_journal_release_rcu);
+	return ret;
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1174,11 +1189,9 @@ static void ext4_put_super(struct super_block *sb)
 
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
-		err = jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
-		if ((err < 0) && !aborted) {
+		err = ext4_journal_release(sbi);
+		if ((err < 0) && !aborted)
 			ext4_abort(sb, -err, "Couldn't clean up the journal");
-		}
 	}
 
 	ext4_es_unregister_shrinker(sbi);
@@ -1449,14 +1462,18 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
 static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
 				 gfp_t wait)
 {
-	journal_t *journal = EXT4_SB(sb)->s_journal;
+	journal_t *journal;
 	int ret = 0;
 
 	WARN_ON(PageChecked(page));
 	if (!page_has_buffers(page))
 		return 0;
+
+	rcu_read_lock();
+	journal = READ_ONCE(EXT4_SB(sb)->s_journal);
 	if (journal)
 		ret = jbd2_journal_try_to_free_buffers(journal, page);
+	rcu_read_unlock();
 	if (!ret)
 		return try_to_free_buffers(page);
 	return 0;
@@ -5146,10 +5163,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
 	sbi->s_ea_block_cache = NULL;
 
-	if (sbi->s_journal) {
-		jbd2_journal_destroy(sbi->s_journal);
-		sbi->s_journal = NULL;
-	}
+	if (sbi->s_journal)
+		ext4_journal_release(sbi);
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
 failed_mount3:
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..071caaaa9de1 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -76,6 +76,8 @@ EXPORT_SYMBOL(jbd2_journal_check_available_features);
 EXPORT_SYMBOL(jbd2_journal_set_features);
 EXPORT_SYMBOL(jbd2_journal_load);
 EXPORT_SYMBOL(jbd2_journal_destroy);
+EXPORT_SYMBOL(jbd2_journal_release);
+EXPORT_SYMBOL(jbd2_journal_release_rcu);
 EXPORT_SYMBOL(jbd2_journal_abort);
 EXPORT_SYMBOL(jbd2_journal_errno);
 EXPORT_SYMBOL(jbd2_journal_ack_err);
@@ -1951,14 +1953,14 @@ int jbd2_journal_load(journal_t *journal)
 }
 
 /**
- * jbd2_journal_destroy() - Release a journal_t structure.
+ * jbd2_journal_release() - Release a journal_t structure.
  * @journal: Journal to act on.
  *
  * Release a journal_t structure once it is no longer in use by the
  * journaled object.
  * Return <0 if we couldn't clean up the journal.
  */
-int jbd2_journal_destroy(journal_t *journal)
+int jbd2_journal_release(journal_t *journal)
 {
 	int err = 0;
 
@@ -2021,11 +2023,33 @@ int jbd2_journal_destroy(journal_t *journal)
 		crypto_free_shash(journal->j_chksum_driver);
 	kfree(journal->j_fc_wbuf);
 	kfree(journal->j_wbuf);
-	kfree(journal);
 
 	return err;
 }
 
+/**
+ * jbd2_journal_release_rcu() - Free a journal_t structure.
+ * @rcu: rcu list node relate to the journal want to free.
+ *
+ * Freeing a journal_t structure after a rcu grace period.
+ */
+void jbd2_journal_release_rcu(struct rcu_head *rcu)
+{
+	kfree(container_of(rcu, journal_t, j_rcu));
+}
+
+/**
+ * jbd2_journal_destroy() - Release and free a journal_t structure.
+ * @journal: Journal to act on.
+ *
+ * Release and free a journal_t structure once it is no longer in use
+ * by the journaled object.
+ */
+void jbd2_journal_destroy(journal_t *journal)
+{
+	jbd2_journal_release(journal);
+	kfree(journal);
+}
 
 /**
  * jbd2_journal_check_used_features() - Check if features specified are used.
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 99d3cd051ac3..39a8d04596a2 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1238,6 +1238,13 @@ struct journal_s
 	 */
 	__u32 j_csum_seed;
 
+	/**
+	 * @j_rcu:
+	 *
+	 * Prevent racing between accessing and destroy at the same time.
+	 */
+	struct rcu_head j_rcu;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/**
 	 * @j_trans_commit_map:
@@ -1509,7 +1516,9 @@ extern int	   jbd2_journal_set_features
 extern void	   jbd2_journal_clear_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
 extern int	   jbd2_journal_load       (journal_t *journal);
-extern int	   jbd2_journal_destroy    (journal_t *);
+extern void	   jbd2_journal_destroy    (journal_t *);
+extern int	   jbd2_journal_release    (journal_t *);
+extern void	   jbd2_journal_release_rcu     (struct rcu_head *rcu);
 extern int	   jbd2_journal_recover    (journal_t *journal);
 extern int	   jbd2_journal_wipe       (journal_t *, int);
 extern int	   jbd2_journal_skip_recovery	(journal_t *);
-- 
2.25.4

