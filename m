Return-Path: <linux-ext4+bounces-3768-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0D0955AC1
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D1DB212D4
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7626B101E6;
	Sun, 18 Aug 2024 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMx7DOCD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589168F6E
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953867; cv=none; b=plYNKtQwgwZYCSGLardxj8qq38UhADmXF9gAVVMGxTr7hyhBMzVJTHQ2l8jYpImie4PLCD6AILc/+in1Y1N5y3gfJwbITZtHmJaYWwN81moUZ812hS4B+jsIVAEaLVx/VLmMJr7SgfcGb3S9DgavER+U77waXB2iVaHzBOXcGgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953867; c=relaxed/simple;
	bh=nam/sHzKfJOlxI4NWlgMeLr1iGCq7p/Tn/9TMk6L1sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ6cP4MV2yqAYFcI4BT5ZDCNEcE1Amz/jNNpFf/+4kIOM9AF+HycDL78YFyzOytRTkHUe4HyAysrCOmy9A9WWmw5QyBaK4LOuFDQag9XEwtLoHa5GLoMSJds7NiLN+uX2MR30Q8V+752OJZ+FqgPTIpZH+32QwOI365+OLkol9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMx7DOCD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021537a8e6so13863565ad.2
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953864; x=1724558664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWjO9kA7p3Bwhao1YgQrEQOOMP5A0f9KQkfCnVpY9hY=;
        b=dMx7DOCDztZKajjnuCWLj/t1c0ADl/Vm926R7alaLrKfS/e5e9t7i3VVLYx+Yst1xD
         k6hIccdlpT1oJTLinX+cUswYsHvc9djWvQWImPAzkdEWzjiAPslg99D/KCAeHXLt/PEH
         0rQ0yFWPZlH8DLITH1bXt/yVsHuoD/PBURvco24D7yACzmd9/g4KPZgN0f4A6EqZuiuN
         khgJB4YvLGOxXAJRQFmZgDs+Tqlr1PgTWsdu8SJxYHX6M+JeMDeYClI0SyemM0AXWcPG
         kIl2QeDjlGtUIgQNxOBzbtZj27TaKC9JInd9CpSBBVDNSbCL6kaGv9VJL3WiG4m97OI1
         fAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953864; x=1724558664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWjO9kA7p3Bwhao1YgQrEQOOMP5A0f9KQkfCnVpY9hY=;
        b=L1PD4zIp6Ii2ZP9BiRx3EhB/cgpq4jggrdqRzeBnyIB/Ou5MfbZim9uPrXBbb5PhGP
         5dBmZAceasf7F6bGe4P5AeHQQ0N2r1fFcZOkeV/ynhbdicaGyOt20dBMOfAb7P4zzYET
         8BCV4+8x0l6tfFn6CNk2p2Ik9yutp0r8VtTY3u+j73pbo2Otel/yC/ZVOWY4E79+RFEp
         4r+me6RwV0CDwLrIhX3NLOXmOyr65/6PZuQfCbLB0vz7B1p49cNqiE6d9kHqwWD7G403
         ofHoZM/sUZdFMLkbbHGd4rUYDWF642NPQkjvygpnDtbJaQ/yDPM/DbMW0NktVCrAo6n2
         xE2A==
X-Gm-Message-State: AOJu0YwES91yBbtK/kY3u99rGxRialvbXaw6tHvTqWlWB3hUl2sUU6Nn
	V0j3TuU6ojdgpJXLh4pF08FvZ0rBUW/L1on0dJK9riVzafhRLNkC9kzjSfvWggQ=
X-Google-Smtp-Source: AGHT+IHQvqoGJAHlGaavEqM1YoqkGZmzFCbCSUQFOOcKHjwNxpC/8xif1GRP+YonupOi7n3Tnynjyg==
X-Received: by 2002:a17:903:2303:b0:1ff:4967:66a with SMTP id d9443c01a7336-20203e88843mr86121165ad.14.1723953864198;
        Sat, 17 Aug 2024 21:04:24 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:23 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 9/9] ext4: hold s_fc_lock while during fast commit
Date: Sun, 18 Aug 2024 04:03:56 +0000
Message-ID: <20240818040356.241684-11-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
In-Reply-To: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Leaving s_fc_lock in between during commit in ext4_fc_perform_commit()
function leaves room for subtle concurrency bugs where ext4_fc_del() may
delete an inode from the fast commit list, leaving list in an inconsistent
state. Also, this patch converts s_fc_lock to mutex type so that it can be
held when kmem_cache_* functions are called.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/fast_commit.c | 91 +++++++++++++++++--------------------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4ecb63f95..a1acd34ff 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1748,7 +1748,7 @@ struct ext4_sb_info {
 	 * following fields:
 	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
 	 */
-	spinlock_t s_fc_lock;
+	struct mutex s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
 	tid_t s_fc_ineligible_tid;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7525450f1..c3627efd9 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -236,9 +236,9 @@ void ext4_fc_del(struct inode *inode)
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+	mutex_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
+		mutex_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
 		return;
 	}
 
@@ -266,7 +266,7 @@ void ext4_fc_del(struct inode *inode)
 	 * dentry create references, since it is not needed to log it anyways.
 	 */
 	if (list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
@@ -276,7 +276,7 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&fc_dentry->fcd_dilist);
 
 	WARN_ON(!list_empty(&ei->i_fc_dilist));
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	if (fc_dentry->fcd_name.name &&
 		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
@@ -306,10 +306,10 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 				sbi->s_journal->j_running_transaction->t_tid : 0;
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
 		sbi->s_fc_ineligible_tid = tid;
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	WARN_ON(reason >= EXT4_FC_REASON_MAX);
 	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
 }
@@ -349,14 +349,14 @@ static int ext4_fc_track_template(
 	if (!enqueue)
 		return ret;
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (list_empty(&EXT4_I(inode)->i_fc_list))
 		list_add_tail(&EXT4_I(inode)->i_fc_list,
 				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
 				&sbi->s_fc_q[FC_Q_STAGING] :
 				&sbi->s_fc_q[FC_Q_MAIN]);
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	return ret;
 }
@@ -414,7 +414,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	}
 	node->fcd_name.len = dentry->d_name.len;
 	INIT_LIST_HEAD(&node->fcd_dilist);
-	spin_lock(&sbi->s_fc_lock);
+	INIT_LIST_HEAD(&node->fcd_list);
+	mutex_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
@@ -435,7 +436,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		WARN_ON(!list_empty(&ei->i_fc_dilist));
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	spin_lock(&ei->i_fc_lock);
 
 	return 0;
@@ -955,15 +956,15 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	struct ext4_inode_info *ei;
 	int ret = 0;
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		ret = jbd2_submit_inode_data(journal, ei->jinode);
 		if (ret)
 			return ret;
-		spin_lock(&sbi->s_fc_lock);
+		mutex_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	return ret;
 }
@@ -976,19 +977,19 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
 	struct ext4_inode_info *pos, *n;
 	int ret = 0;
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		if (!ext4_test_inode_state(&pos->vfs_inode,
 					   EXT4_STATE_FC_COMMITTING))
 			continue;
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 
 		ret = jbd2_wait_inode_data(journal, pos->jinode);
 		if (ret)
 			return ret;
-		spin_lock(&sbi->s_fc_lock);
+		mutex_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	return 0;
 }
@@ -1010,26 +1011,22 @@ __releases(&sbi->s_fc_lock)
 	list_for_each_entry_safe(fc_dentry, fc_dentry_n,
 				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
-			spin_unlock(&sbi->s_fc_lock);
-			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
-				ret = -ENOSPC;
-				goto lock_and_exit;
-			}
-			spin_lock(&sbi->s_fc_lock);
+			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry))
+				return -ENOSPC;
 			continue;
 		}
 		/*
 		 * With fcd_dilist we need not loop in sbi->s_fc_q to get the
-		 * corresponding inode pointer
+		 * corresponding inode. Also, the corresponding inode could have been
+		 * deleted, in which case, we don't need to do anything.
 		 */
-		WARN_ON(list_empty(&fc_dentry->fcd_dilist));
+		if (list_empty(&fc_dentry->fcd_dilist))
+			continue;
 		ei = list_first_entry(&fc_dentry->fcd_dilist,
 				struct ext4_inode_info, i_fc_dilist);
 		inode = &ei->vfs_inode;
 		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
 
-		spin_unlock(&sbi->s_fc_lock);
-
 		/*
 		 * We first write the inode and then the create dirent. This
 		 * allows the recovery code to create an unnamed inode first
@@ -1039,23 +1036,14 @@ __releases(&sbi->s_fc_lock)
 		 */
 		ret = ext4_fc_write_inode(inode, crc);
 		if (ret)
-			goto lock_and_exit;
-
+			return ret;
 		ret = ext4_fc_write_inode_data(inode, crc);
 		if (ret)
-			goto lock_and_exit;
-
-		if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
-			ret = -ENOSPC;
-			goto lock_and_exit;
-		}
-
-		spin_lock(&sbi->s_fc_lock);
+			return ret;
+		if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry))
+			return -ENOSPC;
 	}
 	return 0;
-lock_and_exit:
-	spin_lock(&sbi->s_fc_lock);
-	return ret;
 }
 
 static int ext4_fc_perform_commit(journal_t *journal)
@@ -1074,12 +1062,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * and then lock the journal.
 	 */
 	jbd2_journal_lock_updates(journal);
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_COMMITTING);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	jbd2_journal_unlock_updates(journal);
 
 	ret = ext4_fc_submit_inode_data_all(journal);
@@ -1113,19 +1101,16 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		}
 	}
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
-	if (ret) {
-		spin_unlock(&sbi->s_fc_lock);
+	if (ret)
 		goto out;
-	}
 
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		inode = &iter->vfs_inode;
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
 
-		spin_unlock(&sbi->s_fc_lock);
 		ret = ext4_fc_write_inode_data(inode, &crc);
 		if (ret)
 			goto out;
@@ -1144,13 +1129,11 @@ static int ext4_fc_perform_commit(journal_t *journal)
 #else
 		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
 #endif
-		spin_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
-
 	ret = ext4_fc_write_tail(sb, crc);
 
 out:
+	mutex_unlock(&sbi->s_fc_lock);
 	blk_finish_plug(&plug);
 	return ret;
 }
@@ -1291,7 +1274,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry_safe(iter, iter_n, &sbi->s_fc_q[FC_Q_MAIN],
 				 i_fc_list) {
 		ext4_clear_inode_state(&iter->vfs_inode,
@@ -1318,13 +1301,11 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
 		list_del_init(&fc_dentry->fcd_dilist);
-		spin_unlock(&sbi->s_fc_lock);
 
 		if (fc_dentry->fcd_name.name &&
 			fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
 			kfree(fc_dentry->fcd_name.name);
 		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-		spin_lock(&sbi->s_fc_lock);
 	}
 
 	list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
@@ -1339,7 +1320,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 
 	if (full)
 		sbi->s_fc_bytes = 0;
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	trace_ext4_fc_stats(sb);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4f38a34b0..bef9fd128 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4436,7 +4436,7 @@ static void ext4_fast_commit_init(struct super_block *sb)
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	sbi->s_fc_ineligible_tid = 0;
-	spin_lock_init(&sbi->s_fc_lock);
+	mutex_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
 	sbi->s_fc_replay_state.fc_regions_size = 0;
-- 
2.46.0.184.g6999bdac58-goog


