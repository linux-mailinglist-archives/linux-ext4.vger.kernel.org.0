Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD96C2E5D
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733126AbfJAHmL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:42:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43234 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733122AbfJAHmK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:42:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id v27so8986182pgk.10
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Csn8HpR/P0PMdXdUgWwjueiLxukgFLG05NBTuNCefSw=;
        b=bon4WKyKVHx9BysRxpZ/ELethKosuUF+XD0xDIUwR+swWjBpHbdVw85jXQWG4vIVBm
         5benvb+lIlTmt3xiYw7QHS9ZJv/RoAKW3tEtYtav2q2GuMJuABQ7W4La3LVC5Csv1qJ1
         Ss2hNq6crXODm7yX2jgomgnwmeukI9MOFvi9MLN1a2WF1IE9CYARDQAbNx4Fot4xxx/v
         S4fgEJQQElr/8RPrsf7qdyt+PGK2UQiFd9fLzihMjGZxdgGoU6gpbOpeOWsaDlA6VsBB
         iz9QYl7djMQlsCsjVJKYtde3XVKj98e1yyaLHbHJfSdYR+TPEUTN1ZP1SmhxNgzAUpun
         1Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Csn8HpR/P0PMdXdUgWwjueiLxukgFLG05NBTuNCefSw=;
        b=OrRh7OsyjesViX3Udzn2GKCdobLFB9a/U6CmdtDyGRAuNyvFr3KmAZjIa3yv0K4Zxd
         0A6O/ctqTjehyZ0LcJw4LTkSHxHRGCgUvgzFFxpyCVtNYz0wFlk/OC8YJbDR8fDtvFe4
         /aWNAAVUEG+9JrZ+VHnWVHSvBQbgMPhsv0I+aDGRJXZRS0Gj9hG9WEgpTrLqBsRk99/B
         pjjnW2huG6z6c2JEcxgAX5t1htvawcW261tlIf01dlED5Vz4ipS6oKtyFWxcA1PBajJO
         NVdFCJnR+/CxFlrrb2kc4NsMBH1npjA4rcjJzu4MS3DmG67y3HBD9AyfiJpLUhK2m6AO
         RbRQ==
X-Gm-Message-State: APjAAAUP4jv8lCNjsA7p+mrdeuoCKnXZH3J1nzCeF88fipHdCITl8UhV
        wvNoyoCvl/nFR2qJsCeY64CzzeEugdg=
X-Google-Smtp-Source: APXvYqyf0wJHFndjU8F5yRrBPNwgwqU+0xr4gd9y94q8+W/9OnjnXQ04/GWYWJTry651RiTEE3ryoQ==
X-Received: by 2002:a63:6c89:: with SMTP id h131mr29302173pgc.322.1569915729025;
        Tue, 01 Oct 2019 00:42:09 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id q13sm2287668pjq.0.2019.10.01.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 00:42:08 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v3 11/13] ext4: add support for asynchronous fast commits
Date:   Tue,  1 Oct 2019 00:41:00 -0700
Message-Id: <20191001074101.256523-12-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Until this patch, fast commits could only be invoked by jbd2 thread.
This patch allows file system to perform fast commit in an async manner
without involving jbd2 thread. This makes fast commits even faster as
it gets rid of the time spent in context switching to jbd2 thread. In
order to avoid race between jbd2 thread and async fast commits, we add
new jbd2 APIs that allow file systems to indicate their intent of
performing an async fast commit.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  3 ++
 fs/ext4/ext4_jbd2.c   | 74 +++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/fsync.c       |  7 ++--
 fs/jbd2/commit.c      | 11 +++++++
 fs/jbd2/journal.c     | 59 ++++++++++++++++++++++++++++++++++
 fs/jbd2/transaction.c |  2 ++
 include/linux/jbd2.h  | 10 ++++++
 7 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index cd5b567d8ca8..a8a481c5ffa4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2716,6 +2716,9 @@ extern int ext4_group_extend(struct super_block *sb,
 extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
 
 /* super.c */
+int ext4_fc_async_commit(journal_t *journal, tid_t commit_tid,
+			 tid_t commit_subtid, struct inode *inode,
+			 struct dentry *dentry);
 extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 					 sector_t block, int op_flags);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 12d6e70bf676..cf796268322b 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -1144,6 +1144,80 @@ static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
 	return ret;
 }
 
+int ext4_fc_async_commit(journal_t *journal, tid_t commit_tid,
+			 tid_t commit_subtid, struct inode *inode,
+			 struct dentry *dentry)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct super_block *sb = inode->i_sb;
+	struct buffer_head *bh;
+	int ret;
+
+	if (!ext4_should_fast_commit(sb))
+		return jbd2_complete_transaction(journal, commit_tid);
+
+	read_lock(&ei->i_fc.fc_lock);
+	if (ei->i_fc.fc_tid != commit_tid) {
+		read_unlock(&ei->i_fc.fc_lock);
+		return 0;
+	}
+	read_unlock(&ei->i_fc.fc_lock);
+
+	if (ext4_is_inode_fc_ineligible(inode))
+		return jbd2_complete_transaction(journal, commit_tid);
+
+	if (jbd2_commit_check(journal, commit_tid, commit_subtid))
+		return 0;
+
+	ret = jbd2_start_async_fc(journal, commit_tid);
+	if (ret)
+		return jbd2_fc_complete_commit(journal, commit_tid,
+					       commit_subtid);
+
+	trace_ext4_journal_fc_commit_cb_start(sb);
+
+	ret = jbd2_submit_inode_data(journal, ei->jinode);
+	if (ret)
+		goto out;
+
+	ret = jbd2_map_fc_buf(journal, &bh);
+	if (ret) {
+		jbd2_stop_async_fc(journal, commit_tid);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "map_fc_buf");
+		return jbd2_complete_transaction(journal, commit_tid);
+
+	}
+
+	ret = ext4_fc_write_inode(journal, bh, inode, commit_tid,
+				  commit_subtid, 1, dentry);
+
+	if (ret < 0) {
+		brelse(bh);
+		jbd2_stop_async_fc(journal, commit_tid);
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "fc_write_inode");
+		return jbd2_complete_transaction(journal, commit_tid);
+	}
+	lock_buffer(bh);
+	clear_buffer_dirty(bh);
+	set_buffer_uptodate(bh);
+	bh->b_end_io = ext4_end_buffer_io_sync;
+	submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
+
+	jbd2_stop_async_fc(journal, commit_tid);
+	wait_on_buffer(bh);
+	if (unlikely(!buffer_uptodate(bh))) {
+		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "IO");
+		return -EIO;
+	}
+
+out:
+	trace_ext4_journal_fc_commit_cb_stop(sb,
+					     ret < 0 ? 0 : ret,
+					     ret >= 0 ? "success" : "fail");
+	wake_up(&journal->j_wait_async_fc);
+	return ret;
+}
+
 void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
 {
 	if (ext4_should_fast_commit(sb)) {
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..5bbfc55e1756 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -98,7 +98,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	struct ext4_inode_info *ei = EXT4_I(inode);
 	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 	int ret = 0, err;
-	tid_t commit_tid;
+	tid_t commit_tid, commit_subtid;
 	bool needs_barrier = false;
 
 	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
@@ -148,10 +148,13 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	}
 
 	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
+	commit_subtid = datasync ? ei->i_datasync_subtid : ei->i_sync_subtid;
+
 	if (journal->j_flags & JBD2_BARRIER &&
 	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
 		needs_barrier = true;
-	ret = jbd2_complete_transaction(journal, commit_tid);
+	ret = ext4_fc_async_commit(journal, commit_tid, commit_subtid,
+				   inode, file->f_path.dentry);
 	if (needs_barrier) {
 	issue_flush:
 		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index e85f51e1cc70..18cb70fa2421 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -452,6 +452,17 @@ void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
 
 	write_lock(&journal->j_state_lock);
 	full_commit = journal->j_do_full_commit;
+	journal->j_running_transaction->t_async_fc_allowed = false;
+	while (journal->j_running_transaction->t_async_fc_ongoing) {
+		DEFINE_WAIT(wait);
+
+		prepare_to_wait(&journal->j_wait_async_fc, &wait,
+				TASK_UNINTERRUPTIBLE);
+		write_unlock(&journal->j_state_lock);
+		schedule();
+		write_lock(&journal->j_state_lock);
+		finish_wait(&journal->j_wait_async_fc, &wait);
+	}
 	write_unlock(&journal->j_state_lock);
 
 	/* Let file-system try its own fast commit */
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e0684212384d..81daa2cff67f 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -794,6 +794,64 @@ int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid)
 	return 0;
 }
 
+int jbd2_start_async_fc(journal_t *journal, tid_t tid)
+{
+	transaction_t *txn;
+	int ret = -EINVAL;
+
+	if (!journal->j_running_transaction)
+		return ret;
+
+	if (journal->j_running_transaction->t_tid != tid)
+		return ret;
+
+	txn = journal->j_running_transaction;
+	write_lock(&journal->j_state_lock);
+	while (txn->t_state == T_RUNNING) {
+		DEFINE_WAIT(wait);
+
+		if (txn->t_async_fc_allowed) {
+			if (!txn->t_async_fc_ongoing) {
+				txn->t_async_fc_ongoing = true;
+				ret = 0;
+				break;
+			}
+			prepare_to_wait(&journal->j_wait_async_fc,
+					&wait, TASK_UNINTERRUPTIBLE);
+			write_unlock(&journal->j_state_lock);
+			schedule();
+			write_lock(&journal->j_state_lock);
+			finish_wait(&journal->j_wait_async_fc, &wait);
+		} else {
+			ret = -ECANCELED;
+			break;
+		}
+	}
+	write_unlock(&journal->j_state_lock);
+
+	return ret;
+}
+
+int jbd2_stop_async_fc(journal_t *journal, tid_t tid)
+{
+	transaction_t *txn;
+
+	if (!journal->j_running_transaction)
+		return -EINVAL;
+
+	if (journal->j_running_transaction->t_tid != tid)
+		return -EINVAL;
+
+	txn = journal->j_running_transaction;
+	write_lock(&journal->j_state_lock);
+	J_ASSERT(txn->t_state == T_RUNNING);
+	txn->t_async_fc_ongoing = false;
+	txn->t_subtid++;
+	write_unlock(&journal->j_state_lock);
+	return 0;
+
+}
+
 /* Return 1 when transaction with given tid has already committed. */
 int jbd2_transaction_committed(journal_t *journal, tid_t tid)
 {
@@ -1308,6 +1366,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_commit);
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
+	init_waitqueue_head(&journal->j_wait_async_fc);
 	mutex_init(&journal->j_barrier);
 	mutex_init(&journal->j_checkpoint_mutex);
 	spin_lock_init(&journal->j_revoke_lock);
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index ce7f03cfd90b..f17f813b5610 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -103,6 +103,8 @@ static void jbd2_get_transaction(journal_t *journal,
 	transaction->t_max_wait = 0;
 	transaction->t_start = jiffies;
 	transaction->t_requested = 0;
+	transaction->t_async_fc_allowed = true;
+	transaction->t_async_fc_ongoing = false;
 }
 
 /*
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 312103fc9581..5610f16de919 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -604,6 +604,7 @@ struct transaction_s
 		T_FINISHED
 	}			t_state;
 
+	bool t_async_fc_allowed, t_async_fc_ongoing;
 	/*
 	 * Where in the log does this transaction's commit start? [no locking]
 	 */
@@ -869,6 +870,13 @@ struct journal_s
 	 */
 	wait_queue_head_t	j_wait_reserved;
 
+	/**
+	 * @j_wait_async_fc:
+	 *
+	 * Wait queue to wait for completion of async fast commits.
+	 */
+	wait_queue_head_t	j_wait_async_fc;
+
 	/**
 	 * @j_checkpoint_mutex:
 	 *
@@ -1594,6 +1602,8 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid);
 int jbd2_log_do_checkpoint(journal_t *journal);
 int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
 int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid);
+int jbd2_start_async_fc(journal_t *journal, tid_t tid);
+int jbd2_stop_async_fc(journal_t *journal, tid_t tid);
 
 void __jbd2_log_wait_for_space(journal_t *journal);
 extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
-- 
2.23.0.444.g18eeb5a265-goog

