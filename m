Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE251F34E5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jun 2020 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFIHe0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Jun 2020 03:34:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50938 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbgFIHeZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 9 Jun 2020 03:34:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C626C0C1FF959EC765E;
        Tue,  9 Jun 2020 15:34:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 9 Jun 2020
 15:34:17 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <jack@suse.cz>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH v2] ext4, jbd2: ensure panic by fix a race between jbd2 abort and ext4 error handlers
Date:   Tue, 9 Jun 2020 15:35:40 +0800
Message-ID: <20200609073540.3810702-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the ext4 filesystem with errors=panic, if one process is recording
errno in the superblock when invoking jbd2_journal_abort() due to some
error cases, it could be raced by another __ext4_abort() which is
setting the SB_RDONLY flag but missing panic because errno has not been
recorded.

jbd2_journal_commit_transaction()
 jbd2_journal_abort()
  journal->j_flags |= JBD2_ABORT;
  jbd2_journal_update_sb_errno()
                                    | ext4_journal_check_start()
                                    |  __ext4_abort()
                                    |   sb->s_flags |= SB_RDONLY;
                                    |   if (!JBD2_REC_ERR)
                                    |        return;
  journal->j_flags |= JBD2_REC_ERR;

Finally, it will no longer trigger panic because the filesystem has
already been set read-only. Fix this by introduce j_abort_mutex to make
sure journal abort is completed before panic, and remove JBD2_REC_ERR
flag.

Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Cc: <stable@vger.kernel.org>
---
v1 -> v2:
 - Introduce j_abort_mutex and remove j_record_errno completion.

 fs/ext4/super.c      | 16 +++++-----------
 fs/jbd2/journal.c    | 17 ++++++++++++-----
 include/linux/jbd2.h |  6 +++++-
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9824cd8203e8..8b3771e61c49 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -522,9 +522,6 @@ static void ext4_handle_error(struct super_block *sb)
 		smp_wmb();
 		sb->s_flags |= SB_RDONLY;
 	} else if (test_opt(sb, ERRORS_PANIC)) {
-		if (EXT4_SB(sb)->s_journal &&
-		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
-			return;
 		panic("EXT4-fs (device %s): panic forced after error\n",
 			sb->s_id);
 	}
@@ -725,23 +722,20 @@ void __ext4_abort(struct super_block *sb, const char *function,
 	va_end(args);
 
 	if (sb_rdonly(sb) == 0) {
-		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 		EXT4_SB(sb)->s_mount_flags |= EXT4_MF_FS_ABORTED;
+		if (EXT4_SB(sb)->s_journal)
+			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
+
+		ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 		/*
 		 * Make sure updated value of ->s_mount_flags will be visible
 		 * before ->s_flags update
 		 */
 		smp_wmb();
 		sb->s_flags |= SB_RDONLY;
-		if (EXT4_SB(sb)->s_journal)
-			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
 	}
-	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
-		if (EXT4_SB(sb)->s_journal &&
-		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
-			return;
+	if (test_opt(sb, ERRORS_PANIC) && !system_going_down())
 		panic("EXT4-fs panic from previous error\n");
-	}
 }
 
 void __ext4_msg(struct super_block *sb,
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a49d0e670ddf..e4944436e733 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1140,6 +1140,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	mutex_init(&journal->j_abort_mutex);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
@@ -1402,7 +1403,8 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
 		printk(KERN_ERR "JBD2: Error %d detected when updating "
 		       "journal superblock for %s.\n", ret,
 		       journal->j_devname);
-		jbd2_journal_abort(journal, ret);
+		if (!is_journal_aborted(journal))
+			jbd2_journal_abort(journal, ret);
 	}
 
 	return ret;
@@ -2153,6 +2155,13 @@ void jbd2_journal_abort(journal_t *journal, int errno)
 {
 	transaction_t *transaction;
 
+	/*
+	 * Lock the aborting procedure until everything is done, this avoid
+	 * races between filesystem's error handling flow (e.g. ext4_abort()),
+	 * ensure panic after the error info is written into journal's
+	 * superblock.
+	 */
+	mutex_lock(&journal->j_abort_mutex);
 	/*
 	 * ESHUTDOWN always takes precedence because a file system check
 	 * caused by any other journal abort error is not required after
@@ -2167,6 +2176,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
 			journal->j_errno = errno;
 			jbd2_journal_update_sb_errno(journal);
 		}
+		mutex_unlock(&journal->j_abort_mutex);
 		return;
 	}
 
@@ -2188,10 +2198,7 @@ void jbd2_journal_abort(journal_t *journal, int errno)
 	 * layer could realise that a filesystem check is needed.
 	 */
 	jbd2_journal_update_sb_errno(journal);
-
-	write_lock(&journal->j_state_lock);
-	journal->j_flags |= JBD2_REC_ERR;
-	write_unlock(&journal->j_state_lock);
+	mutex_unlock(&journal->j_abort_mutex);
 }
 
 /**
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index f613d8529863..d56128df2aff 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -765,6 +765,11 @@ struct journal_s
 	 */
 	int			j_errno;
 
+	/**
+	 * @j_abort_mutex: Lock the whole aborting procedure.
+	 */
+	struct mutex		j_abort_mutex;
+
 	/**
 	 * @j_sb_buffer: The first part of the superblock buffer.
 	 */
@@ -1247,7 +1252,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(csum3,		CSUM_V3)
 #define JBD2_ABORT_ON_SYNCDATA_ERR	0x040	/* Abort the journal on file
 						 * data write error in ordered
 						 * mode */
-#define JBD2_REC_ERR	0x080	/* The errno in the sb has been recorded */
 
 /*
  * Function declarations for the journaling transaction and buffer
-- 
2.25.4

