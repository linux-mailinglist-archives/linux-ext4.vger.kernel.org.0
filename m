Return-Path: <linux-ext4+bounces-3310-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 567B8934164
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107F7281EDE
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jul 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CBF183076;
	Wed, 17 Jul 2024 17:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O6zNBnn4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5D183062
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jul 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721236954; cv=none; b=TQoV1KqnIFBKvrgmEE+IzTA2S+MTPJpYnPUdEe0TJrjkEAISICPjTxdzWjLI9CXGM+vKGA/rGGOw7EKwLBPv5nKUl7m6gSnNjcnppZsitWzaDjrvjItzu6DJbLwhq+lo8fz+y00pkpKayqG7m52NLxP2K6SQA86X1HcvK4lNjbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721236954; c=relaxed/simple;
	bh=w1NPe9WcILqvBMR79gBUkgBg/mpRAjlzexIbZk8XiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jX907CUKfqJzQFaTCvZcuRqFvQI0KeHO4CUcBW9FNnXaCs1Jggm4TB4YMtvXtcFC26pqF9D8KiyxRxg2NNRJfsD4h9yzmUrznBTTXWeoDsPcJKk2ZAZcUXJJj/a/2e+1lX63QYajzOkUv2EJQFsuDGGy+toNA2QEgN9HJIQXakI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O6zNBnn4; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721236948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K106XqbcYfH8ci1Y+fSU8zpOaaksHSItrgPnvgG054c=;
	b=O6zNBnn42JkMAoaTew959hYqfNDCCnwiSf+sFN4v67msWI0CF3PKnjg5U94CyApPmaNA0C
	fTXsE1iPfiSEZ8gfR8FHs1vvK4l+8GT/UawNrDvfQynAILAyZEga2gINsHNXXqfLDkC5Vb
	Ar5tljMKDzk890b0zEzDK4Zotija7B0=
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: jack@suse.cz
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH v5] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Wed, 17 Jul 2024 18:22:20 +0100
Message-ID: <20240717172220.14201-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When a full journal commit is on-going, any fast commit has to be enqueued
into a different queue: FC_Q_STAGING instead of FC_Q_MAIN.  This enqueueing
is done only once, i.e. if an inode is already queued in a previous fast
commit entry it won't be enqueued again.  However, if a full commit starts
_after_ the inode is enqueued into FC_Q_MAIN, the next fast commit needs to
be done into FC_Q_STAGING.  And this is not being done in function
ext4_fc_track_template().

This patch fixes the issue by re-enqueuing an inode into the STAGING queue
during the fast commit clean-up callback when doing a full commit.  However,
to prevent a race with a fast-commit, the clean-up callback has to be called
with the journal locked.

This bug was found using fstest generic/047.  This test creates several 32k
bytes files, sync'ing each of them after it's creation, and then shutting
down the filesystem.  Some data may be loss in this operation; for example a
file may have it's size truncated to zero.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
Hi!

And here's another attempt to fix this bug.  The most significant change is
that now it doesn't assume a 'special' meaning for a tid of '0'.  Which is
a wrong assumption as Jan has shown.

I've also added a Suggested-by: tag, although Jan pretty much owns this
patch -- I have simply tested it and sent it out!

 fs/ext4/fast_commit.c | 15 ++++++++++++++-
 fs/jbd2/journal.c     |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3926a05eceee..df71fd5b1fed 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1288,8 +1288,21 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 		list_del_init(&iter->i_fc_list);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
-		if (tid_geq(tid, iter->i_sync_tid))
+		if (tid_geq(tid, iter->i_sync_tid)) {
 			ext4_fc_reset_inode(&iter->vfs_inode);
+		} else if (full) {
+			/*
+			 * We are called after a full commit, inode has been
+			 * modified while the commit was running. Re-enqueue
+			 * the inode into STAGING, which will then be splice
+			 * back into MAIN. This cannot happen during
+			 * fastcommit because the journal is locked all the
+			 * time in that case (and tid doesn't increase so
+			 * tid check above isn't reliable).
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
+		}
 		/* Make sure EXT4_STATE_FC_COMMITTING bit is clear */
 		smp_mb();
 #if (BITS_PER_LONG < 64)
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1ebf2393bfb7..291a431f8aaf 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -740,9 +740,9 @@ EXPORT_SYMBOL(jbd2_fc_begin_commit);
  */
 static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
 {
-	jbd2_journal_unlock_updates(journal);
 	if (journal->j_fc_cleanup_callback)
 		journal->j_fc_cleanup_callback(journal, 0, tid);
+	jbd2_journal_unlock_updates(journal);
 	write_lock(&journal->j_state_lock);
 	journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
 	if (fallback)

