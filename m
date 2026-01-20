Return-Path: <linux-ext4+bounces-13101-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZxDseCcGktYAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13101-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 08:39:51 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9A452EA5
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jan 2026 08:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA1A260933B
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Jan 2026 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768634218B7;
	Tue, 20 Jan 2026 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="NvPJEYap"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDB63D7D70;
	Tue, 20 Jan 2026 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908404; cv=pass; b=fsQPgUAWqnNrrn5K9V/qmi7YDBTXz9oR2Utwxpa3Ew4kfqGZLieEzJGA7renmJ11sYvBAitIjk4Cu4uzFUPSfIF3MBtErEW/0hWLXSGJ+ne8390J+tw5to5bpNOxunEVNa4YI8k7izjDgHL7w4/u5R2OfcIf5/PpketkWMAItDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908404; c=relaxed/simple;
	bh=bxUU6eS+6sOG1Fyxecxje/jiO3ZgoB+3+tqldvMGRug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5uI7oGG/uifnhNdSASdTN/M6VowgxJ6GxmyXiIOIQ+j20w3iV3eSxvbYw5wXqlDu9qLbvowkisBAYfkMvV1VuAdQ5nm+aCq/7LKf2PmUbg0QJFgtHE4Tk34/i/JyZsrYJkq6yJpfh+BpFxNY+bICcg3oaJATDtj4yFYWKu5hlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=NvPJEYap; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1768908369; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HEFy1BNrturUfItF5xI1zmDEbMLuwiuL6QuhFtY4PVFIx8fc+UZxOUKiXBZsoQp7v+DXHlEJGJz67xNWAQot/M7qlCZNx1oiNrhSs3S/wrbAfI6rZrdSkF3IEk6hY1GDDH9oytykzuOBawfxC6phHSCmkWpnHl2rkaAo6/t4nNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768908369; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HAF1RpwukyGeuc7wGeqNCkIU3/qoXem/XaVka3lV/3c=; 
	b=Qt02LUFVt1KgdfT+ZZOQoXJNh7Q5+LZfsMW/6qeoFK8xsTC1qcaKVhgHwCSC5UF7io2d0NJwxGfQN5sZ4mXoULYPjWA0DWBXEDSiaTO4t8BOKx8TQz0TGrueyDVgcA6NWA6s0ncUKEoutmJH0cYA1wY/VNBQCAlr2BLq9AcwTlQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768908369;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=HAF1RpwukyGeuc7wGeqNCkIU3/qoXem/XaVka3lV/3c=;
	b=NvPJEYap8LC28FX9KnitKVhXKv/T3acOcq57raXhNzdMUxdFfPO3A/FyCqtKVkot
	2YufIyr6E2GAtUpcd6Caaqvx4lib5WWnAlydsxA7q2I43lGjfFPXhHhoN9UtEGDb6fE
	/lF1jL2qaJ+Zm9zEnGdV+1R9XRFjDPjt/HkSei8Q=
Received: by mx.zohomail.com with SMTPS id 1768908366190318.19128356582803;
	Tue, 20 Jan 2026 03:26:06 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: Zhang Yi <yi.zhang@huaweicloud.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v4 3/7] ext4: fast commit: avoid waiting for FC_COMMITTING
Date: Tue, 20 Jan 2026 19:25:32 +0800
Message-ID: <20260120112538.132774-4-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120112538.132774-1-me@linux.beauty>
References: <20260120112538.132774-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.beauty:s=zmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-13101-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux.beauty];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[me@linux.beauty,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.beauty:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: CD9A452EA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ext4_fc_track_inode() can be called while holding i_data_sem (e.g.
fallocate). Waiting for EXT4_STATE_FC_COMMITTING in that case risks an
ABBA deadlock: i_data_sem -> wait(FC_COMMITTING) vs FC_COMMITTING ->
wait(i_data_sem) in the commit task.

Now that fast commit snapshots inode state at commit time, updates during
log writing do not need to block. Drop the wait and lockdep assertion in
ext4_fc_track_inode(), and make ext4_fc_del() wait for FC_COMMITTING so an
inode cannot be removed while the commit thread is still using it.

When an inode is modified during a fast commit, mark it with
EXT4_STATE_FC_REQUEUE so cleanup keeps it queued for the next fast commit.
This is needed because jbd2_fc_end_commit() invokes the cleanup callback
with tid == 0, so tid-based requeue logic would requeue every inode.

Testing: tracepoint ext4:ext4_fc_commit_stop with two fsyncs in the same
transaction. nblks is the number of journal blocks written for that fast
commit. Before this change, the second fsync still wrote almost the same
fast commit log (nblks 10->9), because tid == 0 in jbd2_fc_end_commit()
caused the tid-based requeue logic to keep all inodes queued. After this
change, only inodes modified during the commit are requeued, and the
second fsync wrote a nearly empty fast commit (nblks 10->1).

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/ext4.h        |   1 +
 fs/ext4/fast_commit.c | 111 ++++++++++++++++++++----------------------
 2 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2e1681057196..68a64fa0be92 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2004,6 +2004,7 @@ enum {
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_FC_FLUSHING_DATA,	/* Fast commit flushing data */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_FC_REQUEUE,		/* Inode modified during fast commit */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index d5c28304e818..809170d46167 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -61,9 +61,8 @@
  *     setting "EXT4_STATE_FC_COMMITTING" state, and snapshot the inode state
  *     needed for log writing.
  * [5] Unlock the journal by calling jbd2_journal_unlock_updates(). This allows
- *     starting of new handles. If new handles try to start an update on
- *     any of the inodes that are being committed, ext4_fc_track_inode()
- *     will block until those inodes have finished the fast commit.
+ *     starting of new handles. Updates to inodes being fast committed are
+ *     tracked for requeue rather than blocking.
  * [6] Commit all the directory entry updates in the fast commit space.
  * [7] Commit all the changed inodes in the fast commit space.
  * [8] Write tail tag (this tag ensures the atomicity, please read the following
@@ -217,6 +216,7 @@ void ext4_fc_init_inode(struct inode *inode)
 
 	ext4_fc_reset_inode(inode);
 	ext4_clear_inode_state(inode, EXT4_STATE_FC_COMMITTING);
+	ext4_clear_inode_state(inode, EXT4_STATE_FC_REQUEUE);
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	ei->i_fc_snap = NULL;
@@ -251,22 +251,30 @@ void ext4_fc_del(struct inode *inode)
 	}
 
 	/*
-	 * Since ext4_fc_del is called from ext4_evict_inode while having a
-	 * handle open, there is no need for us to wait here even if a fast
-	 * commit is going on. That is because, if this inode is being
-	 * committed, ext4_mark_inode_dirty would have waited for inode commit
-	 * operation to finish before we come here. So, by the time we come
-	 * here, inode's EXT4_STATE_FC_COMMITTING would have been cleared. So,
-	 * we shouldn't see EXT4_STATE_FC_COMMITTING to be set on this inode
-	 * here.
-	 *
-	 * We may come here without any handles open in the "no_delete" case of
-	 * ext4_evict_inode as well. However, if that happens, we first mark the
-	 * file system as fast commit ineligible anyway. So, even in that case,
-	 * it is okay to remove the inode from the fc list.
+	 * Wait for ongoing fast commit to finish. We cannot remove the inode
+	 * from fast commit lists while it is being committed.
 	 */
-	WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)
-		&& !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE));
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+			ext4_fc_unlock(inode->i_sb, alloc_ctx);
+			schedule();
+			alloc_ctx = ext4_fc_lock(inode->i_sb);
+		}
+		finish_wait(wq, &wait.wq_entry);
+	}
+
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
 #if (BITS_PER_LONG < 64)
 		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
@@ -287,19 +295,22 @@ void ext4_fc_del(struct inode *inode)
 		}
 		finish_wait(wq, &wait.wq_entry);
 	}
+
 	ext4_fc_free_inode_snap(inode);
 	list_del_init(&ei->i_fc_list);
 
 	/*
-	 * Since this inode is getting removed, let's also remove all FC
-	 * dentry create references, since it is not needed to log it anyways.
+	 * Since this inode is getting removed, let's also remove all FC dentry
+	 * create references, since it is not needed to log it anyways.
 	 */
 	if (list_empty(&ei->i_fc_dilist)) {
 		ext4_fc_unlock(inode->i_sb, alloc_ctx);
 		return;
 	}
 
-	fc_dentry = list_first_entry(&ei->i_fc_dilist, struct ext4_fc_dentry_update, fcd_dilist);
+	fc_dentry = list_first_entry(&ei->i_fc_dilist,
+				     struct ext4_fc_dentry_update,
+				     fcd_dilist);
 	WARN_ON(fc_dentry->fcd_op != EXT4_FC_TAG_CREAT);
 	list_del_init(&fc_dentry->fcd_list);
 	list_del_init(&fc_dentry->fcd_dilist);
@@ -371,6 +382,8 @@ static int ext4_fc_track_template(
 
 	tid = handle->h_transaction->t_tid;
 	spin_lock(&ei->i_fc_lock);
+	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
+		ext4_set_inode_state(inode, EXT4_STATE_FC_REQUEUE);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -557,8 +570,6 @@ static int __track_inode(handle_t *handle, struct inode *inode, void *arg,
 
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 {
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	wait_queue_head_t *wq;
 	int ret;
 
 	if (S_ISDIR(inode->i_mode))
@@ -577,29 +588,11 @@ void ext4_fc_track_inode(handle_t *handle, struct inode *inode)
 		return;
 
 	/*
-	 * If we come here, we may sleep while waiting for the inode to
-	 * commit. We shouldn't be holding i_data_sem when we go to sleep since
-	 * the commit path needs to grab the lock while committing the inode.
+	 * Fast commit snapshots inode state at commit time, so there's no need
+	 * to wait for EXT4_STATE_FC_COMMITTING here. If the inode is already
+	 * on the commit queue, ext4_fc_cleanup() will requeue it for the new
+	 * transaction once the current commit finishes.
 	 */
-	lockdep_assert_not_held(&ei->i_data_sem);
-
-	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-#if (BITS_PER_LONG < 64)
-		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_state_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#else
-		DEFINE_WAIT_BIT(wait, &ei->i_flags,
-				EXT4_STATE_FC_COMMITTING);
-		wq = bit_waitqueue(&ei->i_flags,
-				   EXT4_STATE_FC_COMMITTING);
-#endif
-		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
-			schedule();
-		finish_wait(wq, &wait.wq_entry);
-	}
 
 	/*
 	 * From this point on, this inode will not be committed either
@@ -1525,32 +1518,32 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 
 	alloc_ctx = ext4_fc_lock(sb);
 	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
+		bool requeue;
+
 		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
 					struct ext4_inode_info,
 					i_fc_list);
 		list_del_init(&ei->i_fc_list);
 		ext4_fc_free_inode_snap(&ei->vfs_inode);
+		spin_lock(&ei->i_fc_lock);
+		if (full)
+			requeue = !tid_geq(tid, ei->i_sync_tid);
+		else
+			requeue = ext4_test_inode_state(&ei->vfs_inode,
+							EXT4_STATE_FC_REQUEUE);
+		if (!requeue)
+			ext4_fc_reset_inode(&ei->vfs_inode);
+		ext4_clear_inode_state(&ei->vfs_inode, EXT4_STATE_FC_REQUEUE);
 		ext4_clear_inode_state(&ei->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (tid_geq(tid, ei->i_sync_tid)) {
-			ext4_fc_reset_inode(&ei->vfs_inode);
-		} else if (full) {
-			/*
-			 * We are called after a full commit, inode has been
-			 * modified while the commit was running. Re-enqueue
-			 * the inode into STAGING, which will then be splice
-			 * back into MAIN. This cannot happen during
-			 * fastcommit because the journal is locked all the
-			 * time in that case (and tid doesn't increase so
-			 * tid check above isn't reliable).
-			 */
+		spin_unlock(&ei->i_fc_lock);
+		if (requeue)
 			list_add_tail(&ei->i_fc_list,
 				      &sbi->s_fc_q[FC_Q_STAGING]);
-		}
 		/*
 		 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
 		 * visible before we send the wakeup. Pairs with implicit
-		 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+		 * barrier in prepare_to_wait() in ext4_fc_del().
 		 */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
-- 
2.52.0

