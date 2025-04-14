Return-Path: <linux-ext4+bounces-7248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC54A88915
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ADC3A5A3F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28FE28936C;
	Mon, 14 Apr 2025 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6no5T0s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9A318AE2
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649691; cv=none; b=hkFYMZBwQsLH3F41qzv6CcBMQwiILPzI2NgxvbQ6Di5XHXt/p9Sfio54LDYD2+c702rBEceNzpKmJPYwucPBuOE+erug7BtU620U1Am8/oRss+qYFIJheWXr4Q1l2SdL4ssb15rg+BKlQp/ubUvnXkqHbI2pnKXhIdtsW15YERg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649691; c=relaxed/simple;
	bh=pI+E2qU48BVwEXHuJ59bcCBhbzlryCZwTw6PSVoyjtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3/DleJPe9D327eZDwGcpWQnDyyxbkPco9ZVNNaSHNAO+131USOig/xuDVGVYSr/XcghGo/EaxUIIlqohM3jHdxIN2zga2MTWkSg1TJFOkt2bcLqTBUy5pWpLJlSbzCdnxJtals6Xb4JqQJzAFgFuUgNOzBV6WTmatI7HncXLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6no5T0s; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af908bb32fdso4009011a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649689; x=1745254489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeGYSFDNrLsRCTqa7d4oXd/FeJqMcVYI4xRD7vwkWtI=;
        b=D6no5T0shmHvQimFWEbfgImO1bW/OJExljPptAhbt1O9dtLSuSdG7WLfZa/6L9rJpg
         G2F1130amwG/kiarMQ6m4J/xbtzXBQIUlGpkxx4PqsS/Nn5S9+7xA5m210+hGzPNzgpt
         eLYZ08uW/3kQmtBUcUwXbc/HqzGyGUPNBbspsGiNQgE0IOUP1YxJruViG+ZQ2833GEVx
         Vf/QGanHH+guVyF6+5Cw8mlVpXqGDa6NTuElTXSVJz0DYD/oh5CKoczsvcIXQ/im+bVe
         aKNX/u0nT19cQnWmxRmV9ZRouihBqz5mA1wDMShbLVrO5eaLqulmzZMLBQYJOWFjyLyc
         e+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649689; x=1745254489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TeGYSFDNrLsRCTqa7d4oXd/FeJqMcVYI4xRD7vwkWtI=;
        b=V72icrk/Ow4LAYoP4v7JIi6+TgFjlyle/L7Z+nzKz0gIXbE/CwDQwsjx5A1GBvnI5q
         YuI3kkx5Dq7OQycl/rOA5UzAS2ELbDmYqFaXrqSpqaEQX18Xc5qpHsbpVEGppJBHqYQa
         B3GVT7PQE9G7QSOmQ+qeeis3e80vI5R92lRByfwJ4/OyeXDUPHWCbYghWH/8x0syZXiE
         ExCE8eiSgL7z1ipKD1J/h1G07IcftUifsL8PfogwVoP+AwRuHBTz+W/lIVxwKeMK9bOU
         J4Wy5AP4MUlVCsTTrIUV34WdJS3IbcNhQTxoFx/pU13Brj2s4oLyyDCF1+PidQv8BiPQ
         l1QQ==
X-Gm-Message-State: AOJu0YxrmbpV2BQR171z3ej21xSl/AIcyMRN7Jua1Sf7rMklG93Gv9yX
	wlh4rBkZwqmO8mbmYJNzmoaYude9fGjHrSmC/1IvU99gQI8sd3ydtp5i9P2ANA0=
X-Gm-Gg: ASbGncupgv/+Ivr/wPwCbATzQMasjjaDbuHiW1Heax1pSzmBKAPOWfs+d/9HNOlgwcA
	wJUyJg+a2a7kWb1xnmmE4dleuzfkSj4sGDL/8cE84NDrN6KSxgsLD3XKw8opB6zl6KTToZgs3lS
	LD6q0iZgOADIoTCVB33ZQNWt3yCjrRHo3DvaOljRBPiQ1Et8WzLnZ4YKmwVul6M8cWfh2yvzuxP
	1DNrR3TW18tADnyABhRr9yZvdx0+ojpUj2wglMRMMR4X2SkWVsV/FKZOJEnJ9IUnyqwpkYTljSz
	c1RUMyAx9uU0eg+k6UGVJ9XJh7JgXbtneV6JU78Mx00yxjO/UvfSqA2AYj0FwxljzjE68WvhCpz
	ynwma4qhCvyZQb3fgtosJkabbd007zg/2Xw==
X-Google-Smtp-Source: AGHT+IHMuJuR4G5lN4OHbgLuZUjgopazbhv5Sgmn4ap2KWNoyFH5wGq7FewVgHZaEKZYjgliU2muKQ==
X-Received: by 2002:a17:90b:3bce:b0:2ff:71d2:ee8f with SMTP id 98e67ed59e1d1-3084f36ecf4mr170326a91.13.1744649688749;
        Mon, 14 Apr 2025 09:54:48 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:48 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 8/9] ext4: convert s_fc_lock to mutex type
Date: Mon, 14 Apr 2025 16:54:15 +0000
Message-ID: <20250414165416.1404856-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
References: <20250414165416.1404856-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows us to hold s_fc_lock during kmem_cache_* functions, which
is needed in the following patch.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/fast_commit.c | 68 +++++++++++++++++++++----------------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index faba91321aab..0fd198c740e2 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1754,7 +1754,7 @@ struct ext4_sb_info {
 	 * following fields:
 	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
 	 */
-	spinlock_t s_fc_lock;
+	struct mutex s_fc_lock;
 	struct buffer_head *s_fc_bh;
 	struct ext4_fc_stats s_fc_stats;
 	tid_t s_fc_ineligible_tid;
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3b441452f3cf..89895ba2e011 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -234,9 +234,9 @@ void ext4_fc_del(struct inode *inode)
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
@@ -264,7 +264,7 @@ void ext4_fc_del(struct inode *inode)
 	 * dentry create references, since it is not needed to log it anyways.
 	 */
 	if (list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
@@ -274,7 +274,7 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&fc_dentry->fcd_dilist);
 
 	WARN_ON(!list_empty(&ei->i_fc_dilist));
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
@@ -305,12 +305,12 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
 			has_transaction = false;
 		read_unlock(&sbi->s_journal->j_state_lock);
 	}
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	if (has_transaction && (!is_ineligible || tid_gt(tid, sbi->s_fc_ineligible_tid)))
 		sbi->s_fc_ineligible_tid = tid;
 	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
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
@@ -400,7 +400,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	node->fcd_ino = inode->i_ino;
 	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
@@ -421,7 +421,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 		WARN_ON(!list_empty(&ei->i_fc_dilist));
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	spin_lock(&ei->i_fc_lock);
 
 	return 0;
@@ -947,15 +947,15 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
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
@@ -968,19 +968,19 @@ static int ext4_fc_wait_inode_data_all(journal_t *journal)
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
@@ -1002,12 +1002,12 @@ __releases(&sbi->s_fc_lock)
 	list_for_each_entry_safe(fc_dentry, fc_dentry_n,
 				 &sbi->s_fc_dentry_q[FC_Q_MAIN], fcd_list) {
 		if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
-			spin_unlock(&sbi->s_fc_lock);
+			mutex_unlock(&sbi->s_fc_lock);
 			if (!ext4_fc_add_dentry_tlv(sb, crc, fc_dentry)) {
 				ret = -ENOSPC;
 				goto lock_and_exit;
 			}
-			spin_lock(&sbi->s_fc_lock);
+			mutex_lock(&sbi->s_fc_lock);
 			continue;
 		}
 		/*
@@ -1020,7 +1020,7 @@ __releases(&sbi->s_fc_lock)
 		inode = &ei->vfs_inode;
 		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
 
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 
 		/*
 		 * We first write the inode and then the create dirent. This
@@ -1042,11 +1042,11 @@ __releases(&sbi->s_fc_lock)
 			goto lock_and_exit;
 		}
 
-		spin_lock(&sbi->s_fc_lock);
+		mutex_lock(&sbi->s_fc_lock);
 	}
 	return 0;
 lock_and_exit:
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	return ret;
 }
 
@@ -1066,12 +1066,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
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
@@ -1105,10 +1105,10 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		}
 	}
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		goto out;
 	}
 
@@ -1117,7 +1117,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
 
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		ret = ext4_fc_write_inode_data(inode, &crc);
 		if (ret)
 			goto out;
@@ -1136,9 +1136,9 @@ static int ext4_fc_perform_commit(journal_t *journal)
 #else
 		wake_up_bit(&iter->i_flags, EXT4_STATE_FC_COMMITTING);
 #endif
-		spin_lock(&sbi->s_fc_lock);
+		mutex_lock(&sbi->s_fc_lock);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	ret = ext4_fc_write_tail(sb, crc);
 
@@ -1283,7 +1283,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
 		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
 					struct ext4_inode_info,
@@ -1325,11 +1325,11 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 					     fcd_list);
 		list_del_init(&fc_dentry->fcd_list);
 		list_del_init(&fc_dentry->fcd_dilist);
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 
 		release_dentry_name_snapshot(&fc_dentry->fcd_name);
 		kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
-		spin_lock(&sbi->s_fc_lock);
+		mutex_lock(&sbi->s_fc_lock);
 	}
 
 	list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
@@ -1344,7 +1344,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 
 	if (full)
 		sbi->s_fc_bytes = 0;
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	trace_ext4_fc_stats(sb);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0a4ca1c8e5ce..e1da15499e6f 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4481,7 +4481,7 @@ static void ext4_fast_commit_init(struct super_block *sb)
 	sbi->s_fc_bytes = 0;
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
 	sbi->s_fc_ineligible_tid = 0;
-	spin_lock_init(&sbi->s_fc_lock);
+	mutex_init(&sbi->s_fc_lock);
 	memset(&sbi->s_fc_stats, 0, sizeof(sbi->s_fc_stats));
 	sbi->s_fc_replay_state.fc_regions = NULL;
 	sbi->s_fc_replay_state.fc_regions_size = 0;
-- 
2.49.0.604.gff1f9ca942-goog


