Return-Path: <linux-ext4+bounces-2636-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556148CD112
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 13:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEEF1F21321
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2024 11:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CE146A84;
	Thu, 23 May 2024 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oL5myX0a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1177D1465A6
	for <linux-ext4@vger.kernel.org>; Thu, 23 May 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716462987; cv=none; b=RJdvJXF6WqnXVph0Uk6lVwPLyF2kJxik1ZzA0si8ENNlYAnD/5wijKJwPtXOT560pmNNv+zlpC09Oz5ROCW50c7fL0u492geaNMgjoiJOH8ppBhoARMOVYlrNmOkQCFVn4K/rZegm6IQXbsbZiDev3Nk01tTMGG/UyqlWcwhmwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716462987; c=relaxed/simple;
	bh=NtWHZ0S6uruFC/CoeNcH7BzMxeAQxoesFu6LY3wrFvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fW/XPi8vaUQLfEz2He9u1CIZYA1rukkLEF/dk7HdFWFtvBMGREN+mtH3zNOhvudARYZYXrPDTN/EedtL9LW0y5csEe+6LJVhz/PHbHDsgeI+6oGVUFdSAaC9e01e8lhtdGrK8uycmRwMQyBnHMhOD8vR6bNTHxYUfefcmGLgqoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oL5myX0a; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716462983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rXeNfA493tYgxtMQKHtku9ZfX9GDeRnviC1JlvIusEI=;
	b=oL5myX0akLeu28dNXLuCXviIdU85moWLY/axN+6K/ezP8uvxYpAI9O7+pEvGIPuYYayRrr
	cid50YYRVnidbC/3qyJCL7cYBseBxso9qItaFS3W+IfHRpvnFvpDBaJikFuD8vhRmsP7aI
	QhRJORjhuBVyDtNNP+nRLHwEHzmTfBA=
X-Envelope-To: jack@suse.cz
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: harshadshirwadkar@gmail.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-ext4@vger.kernel.org
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
Subject: [PATCH v2] ext4: fix fast commit inode enqueueing during a full journal commit
Date: Thu, 23 May 2024 12:16:18 +0100
Message-ID: <20240523111618.17012-1-luis.henriques@linux.dev>
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

This patch fixes the issue by flagging an inode that is already enqueued in
either queues.  Later, during the fast commit clean-up callback, if the
inode has a tid that is bigger than the one being handled, that inode is
re-enqueued into STAGING and the spliced back into MAIN.

This bug was found using fstest generic/047.  This test creates several 32k
bytes files, sync'ing each of them after it's creation, and then shutting
down the filesystem.  Some data may be loss in this operation; for example a
file may have it's size truncated to zero.

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
Hi!

(Now Cc'ing Harshad, as I should have done in the initial RFC.)

This v2 is a complete different solution, hinted by Jan Kara.  I hope my
understanding of his suggestion is correct.  Also, I've dropped the second
patch as it didn't made sense, as Jan also pointed out.

Finally, I haven't yet done a review of Harshad's patchset [1] (hope to
get to it soon), but a quick test shows the issue is still present there.
The good news is that patch can be trivially applied on top of it.

[1] https://lore.kernel.org/all/20240520055153.136091-1-harshadshirwadkar@gmail.com

Cheers,
--
Luis

 fs/ext4/ext4.h        | 11 ++++++++++-
 fs/ext4/fast_commit.c | 11 +++++++++++
 fs/ext4/super.c       |  1 +
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..4c308c18c3da 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1062,9 +1062,18 @@ struct ext4_inode_info {
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
-	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
+	/*
+	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len,
+	 * i_fc_next
+	 */
 	struct mutex i_fc_lock;
 
+	/*
+	 * Used to flag an inode as part of the next fast commit; will be
+	 * reset during fast commit clean-up
+	 */
+	tid_t i_fc_next;
+
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
 	 * in memory.  During truncate, i_size is set to the new size by
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..bfdf249f0783 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -402,6 +402,8 @@ static int ext4_fc_track_template(
 				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
+	else
+		ei->i_fc_next = tid;
 	spin_unlock(&sbi->s_fc_lock);
 
 	return ret;
@@ -1280,6 +1282,15 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
 		list_del_init(&iter->i_fc_list);
+		if (iter->i_fc_next == tid)
+			iter->i_fc_next = 0;
+		else if (iter->i_fc_next > tid)
+			/*
+			 * re-enqueue inode into STAGING, which will later be
+			 * splice back into MAIN
+			 */
+			list_add_tail(&EXT4_I(&iter->vfs_inode)->i_fc_list,
+				      &sbi->s_fc_q[FC_Q_STAGING]);
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_COMMITTING);
 		if (iter->i_sync_tid <= tid)
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 893ab80dafba..56f416656d96 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1437,6 +1437,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
 	mutex_init(&ei->i_fc_lock);
+	ei->i_fc_next = 0;
 	return &ei->vfs_inode;
 }
 

