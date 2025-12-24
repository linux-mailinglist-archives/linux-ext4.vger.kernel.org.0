Return-Path: <linux-ext4+bounces-12507-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDD9CDB441
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 04:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F282C306D6C2
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 03:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0E232863C;
	Wed, 24 Dec 2025 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="brtp0Izh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35E626C38C;
	Wed, 24 Dec 2025 03:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766547017; cv=pass; b=cfLAdpaI9hfl+cIaUC2v97rOdY8yWBc76z2o8NAYOjTHV51x3aKI0fL68qtWJEYFnkrtNj9o3g6i0DxcYrbHpDSdflAPDSB7pVD2pXLuGMO2rhB7JCtjWHhZ0peUh1tbTZZsAT5LV/SbRo84WW2ud1l1240veXwSGQ9nfr3UeT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766547017; c=relaxed/simple;
	bh=A0Jyk5pPhhQN6/ChW+iz+62JUe4CUq50QOs2wl4q4lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pR1I2dasnpFzRB5KkKss7eqaEShBGMOE57138/PrWSx5Fv8z1WiqclviV8PlxMVK4F+fcpzWgg0qgc8a3oYhVMTIhMHKPRC62EYTGYll466T4zEb2ljnsghCq5T4dYXPAsu97DUOHEQKDE+8vVd+E5Llmaqa7uqDLQtHTcWKQ14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=brtp0Izh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
ARC-Seal: i=1; a=rsa-sha256; t=1766546994; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EDb9Yo/SnHfxSPmTL7iVvGe7MpmM40IcayYoPA75xFAK5U9kOjp5kP2ERHoDiBuKmMLVadJ9DH9EjkzVjR5X/A/K/V73PdgsC6/RGnoVbuh1aLi3XqYKjLdkj0jJYTTmtTrf8OL+3hou81GzccJCFn5KdfQcA6dC4fwSLD1ZFLI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766546994; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NnsX2rVatC7xZIBojk2Z56MPR5EvFO9457C+sYqCewo=; 
	b=OCUYvIPYh3PMMgvrvlltT3ld2AE3baNYVyBjtMhRxgu06GMRE9TpB97NrHy2GTmWYlzlXCyVe5JyH0CMvOA3bS05iP4FQr8MaPuScySoXlcaNjMjvlGn8ej9XVfTb07pziym3DaF3L//Dg6zjzfX/+8Xb1WtcrY2LGuANwcWTgU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766546993;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NnsX2rVatC7xZIBojk2Z56MPR5EvFO9457C+sYqCewo=;
	b=brtp0IzhW+W/5r12ct+mgq28SpHqeiHVdq3shPW39rCeDp/K83pQIVoL+Pw4b3WP
	+WTXe2d+gNE0nkxAD8AhFOfdB9z+xQoxoDuPFNw5G1XCWOPTzVleqThgrEtvc9o/z5v
	J2GbvHarQ+VbqLhT23xZfOt+YDnRgI+TMiMQZyQk=
Received: by mx.zohomail.com with SMTPS id 176654699153232.284918122682825;
	Tue, 23 Dec 2025 19:29:51 -0800 (PST)
From: Li Chen <me@linux.beauty>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Li Chen <me@linux.beauty>
Subject: [RFC v3 2/2] ext4: fast commit: fix s_fc_lock vs i_data_sem inversion
Date: Wed, 24 Dec 2025 11:29:42 +0800
Message-ID: <20251224032943.134063-3-me@linux.beauty>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224032943.134063-1-me@linux.beauty>
References: <20251224032943.134063-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

lockdep reports a possible deadlock due to lock order inversion:

     CPU0                    CPU1
     ----                    ----
lock(&sbi->s_fc_lock);
                             lock(&ei->i_data_sem);
                             lock(&sbi->s_fc_lock);
rlock(&ei->i_data_sem);

ext4_fc_perform_commit() held s_fc_lock while writing fast commit blocks.
This can write the journal inode, whose mapping can call ext4_map_blocks()
and take i_data_sem. At the same time, metadata update paths can hold
i_data_sem and call ext4_fc_track_inode(), which takes s_fc_lock.

Drop s_fc_lock before the log writing step. Keep inode and dentry state
stable by using EXT4_STATE_FC_COMMITTING for synchronization: ext4_fc_del()
waits for COMMITTING, and inodes referenced only from create dentry updates
are also marked COMMITTING and woken up on cleanup.

Signed-off-by: Li Chen <me@linux.beauty>
---
 fs/ext4/fast_commit.c | 79 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 60 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b0c458082997..aa209f1d3d36 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -244,23 +244,26 @@ void ext4_fc_del(struct inode *inode)
 		return;
 	}
 
-	/*
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
-	 */
-	WARN_ON(ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)
-		&& !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE));
+	/* Don't race with fast commit processing of this inode. */
+	while (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+#if (BITS_PER_LONG < 64)
+		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_state_flags,
+				   EXT4_STATE_FC_COMMITTING);
+#else
+		DEFINE_WAIT_BIT(wait, &ei->i_flags,
+				EXT4_STATE_FC_COMMITTING);
+		wq = bit_waitqueue(&ei->i_flags, EXT4_STATE_FC_COMMITTING);
+#endif
+		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
+		if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
+			mutex_unlock(&sbi->s_fc_lock);
+			schedule();
+			mutex_lock(&sbi->s_fc_lock);
+		}
+		finish_wait(wq, &wait.wq_entry);
+	}
 	while (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
 #if (BITS_PER_LONG < 64)
 		DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
@@ -1108,6 +1111,27 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_COMMITTING);
 	}
+	/*
+	 * Also mark inodes referenced by create dentry updates. These inodes are
+	 * tracked via i_fc_dilist and might not be on s_fc_q[MAIN].
+	 */
+	{
+		struct ext4_fc_dentry_update *fc_dentry;
+		struct ext4_inode_info *ei;
+
+		list_for_each_entry(fc_dentry, &sbi->s_fc_dentry_q[FC_Q_MAIN],
+				    fcd_list) {
+			if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT)
+				continue;
+			if (list_empty(&fc_dentry->fcd_dilist))
+				continue;
+			ei = list_first_entry(&fc_dentry->fcd_dilist,
+					      struct ext4_inode_info,
+					      i_fc_dilist);
+			ext4_set_inode_state(&ei->vfs_inode,
+					     EXT4_STATE_FC_COMMITTING);
+		}
+	}
 	mutex_unlock(&sbi->s_fc_lock);
 	jbd2_journal_unlock_updates(journal);
 
@@ -1137,7 +1161,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 
 	/* Step 6.2: Now write all the dentry updates. */
-	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret)
 		goto out;
@@ -1159,7 +1182,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
-	mutex_unlock(&sbi->s_fc_lock);
 	memalloc_nofs_restore(nofs);
 	blk_finish_plug(&plug);
 	return ret;
@@ -1342,6 +1364,25 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     struct ext4_fc_dentry_update,
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
+		if (fc_dentry->fcd_op == EXT4_FC_TAG_CREAT &&
+		    !list_empty(&fc_dentry->fcd_dilist)) {
+			ei = list_first_entry(&fc_dentry->fcd_dilist,
+					      struct ext4_inode_info,
+					      i_fc_dilist);
+			ext4_clear_inode_state(&ei->vfs_inode,
+					       EXT4_STATE_FC_COMMITTING);
+			/*
+			 * Make sure clearing of EXT4_STATE_FC_COMMITTING is
+			 * visible before we send the wakeup. Pairs with implicit
+			 * barrier in prepare_to_wait() in ext4_fc_track_inode().
+			 */
+			smp_mb();
+#if (BITS_PER_LONG < 64)
+			wake_up_bit(&ei->i_state_flags, EXT4_STATE_FC_COMMITTING);
+#else
+			wake_up_bit(&ei->i_flags, EXT4_STATE_FC_COMMITTING);
+#endif
+		}
 		list_del_init(&fc_dentry->fcd_dilist);
 
 		release_dentry_name_snapshot(&fc_dentry->fcd_name);
-- 
2.52.0


