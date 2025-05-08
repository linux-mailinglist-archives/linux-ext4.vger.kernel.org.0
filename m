Return-Path: <linux-ext4+bounces-7776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E63CAB01F5
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7071BA78F1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDBA2874F3;
	Thu,  8 May 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/fdAbfY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2163D286D70
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727179; cv=none; b=PBz44EBu5TtkMBM+pUS1ZCWWv3SYzlNc47/dHtcU+ErDkAjURkt7COyMFG6alZd5zuxzSreMG3wH1FHSovplJRrlHyL6AxBxUKpJkBiWTtd6aXboMPEulD9xTFc+kexVm8kUuqAXpc4uHW1XWuk3lCKUwFMwqtfFYkrJh9euUzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727179; c=relaxed/simple;
	bh=/UK6aAhx8ljycKMSL2mOqg03MO6erx/hycf6kZAJS0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6u9nikucH6/b1Nx2PTAfomdypPiFEorW/Ya3B6hKdxMKszYOzLM7nSxwyUcpUoBK6QAvVJNguIdbge+X2JnzfEPX6sRVbVfV4Rwednb4Aoegd0ihKBI4osAuBiUqvZ+WKqT5hgdL3XWPP+uo+xoQ8DDlCjLYR+wJzu/sXP5ddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/fdAbfY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e70a9c6bdso22079935ad.3
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727177; x=1747331977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiZ3IPvnOLD6bjPHFC0LENkY3LPdBb7EPB2/lZuSe4E=;
        b=j/fdAbfYJaVS7hLHVtA4/mnEcUpvOgJRty8HCs12/dqJCZi65BYMR1we6TeSr+lYcY
         VLnuWgFsO5JVn5OjIuJbEcLBYiTmer8Lv8nXe3IpyJqzBy0A4hX275h8U9WyQbGt8hsL
         tpZX2e1pT7go+B4ctF/9MdJEDSvVea2LuEi8EwKimCCcy1Xrz6b568laAOMkIT9Sf3Gz
         0NyE9POdtfkhhGiy9fovqdqpt4jRPLadp7MCn1Gaz2BxapOvwojYI4gqQahccuZ6tejZ
         SP3D39ylBEjYal7y2FvvsoocHd90F+OOhfWUXK6Ac5yADoAd7gvkwIpNCCoIECeBq3jA
         hr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727177; x=1747331977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OiZ3IPvnOLD6bjPHFC0LENkY3LPdBb7EPB2/lZuSe4E=;
        b=lBGkPPhjyUNRwaokQQebqZuINDLq9bA0Iw1OVjAtVLxbjET/vXC8I+yilNAX94zvmq
         pvJ67QGgN1A0O/F7I6VtOjxIhbqw+C3UsTSOYSlLAEPyMZxeL1AkdAdtBCOr0vYuUYIE
         H6YDPyNSUB5PQkYEzwwkHmlLyRWUa2OtaoZFps8I69NjhAE/mhlKqwXwfCpy9P4+0CpX
         KaSHTCpiyc8b/orYYOAnBt+AkpnkR4kcuWQECDdxYDQr3NvmHnSvERdQGXjRr/hbVUbn
         ya/oKc7wGzmlV3YM6fCs3/Vj4Zi0HsVtlUX3l9/V0dysoCGZ+dxR3gBFys+XclcbGh0p
         9ziw==
X-Gm-Message-State: AOJu0YwhG4GyaXWwxM1sSZfWDkPZhhvWMJHVRDBsBGwIi53iKWxa8gvU
	G4BzHwS7nTpwHTpyZzvIAv2u/xX+pXbCWZynulOIXcAn4GFG+jombPSN+ZZCF6A=
X-Gm-Gg: ASbGnct6J9/1X6rjqF/AejHV8YjEgUI+cuKcNH8U7ineL04ng3Ul5R1MY78Ug8KnWiW
	F9W52U37JGxyOrqbubqagKomEX1rGB7ZJwqQ/fSJcnWpBxBdG/cqHszVCglpiidLBLThocsZUj1
	HLnYODcLWlKX5VbEPTcVf8mv5YvFEvNd2EbTC6Im6F2GBaMmJNgp7ieLvip8PaQk6rEwD+y2rYp
	9JrysXMk/APn0sr7T6quZcdIKHdL8TMCw5p78mGw8bXDDFm13PXQQqk2SSOVgO0bHNDur90hc26
	42eVCzyz9UsYXtRQmjZgmv4aLjkbRU1mr8xo6kxBVPWtWxyvdGBuq3USDWxWZwOGLnpQp76vc8/
	Dlf9kRFiWF82DQqdg4zdrYdBAOdbYp78oqVGahHcCm7JRUlU=
X-Google-Smtp-Source: AGHT+IH3N6nyyLq0WSBQvjeqJlnw7cZarCZysfEtFvWeY7lO2Wyh24QMpflEZKGGQEPsg/zyI1YvuQ==
X-Received: by 2002:a17:902:e747:b0:22e:5e70:b2d3 with SMTP id d9443c01a7336-22fc8afeec8mr4226315ad.1.1746727176663;
        Thu, 08 May 2025 10:59:36 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:36 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 8/9] ext4: convert s_fc_lock to mutex type
Date: Thu,  8 May 2025 17:59:07 +0000
Message-ID: <20250508175908.1004880-9-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.49.0.1045.g170613ef41-goog
In-Reply-To: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
References: <20250508175908.1004880-1-harshadshirwadkar@gmail.com>
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
 fs/ext4/fast_commit.c | 60 +++++++++++++++++++++----------------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 3987c5bf2..052d7afee 100644
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
index 5f6a8ec24..eb888e522 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -238,9 +238,9 @@ void ext4_fc_del(struct inode *inode)
 	if (ext4_fc_disabled(inode->i_sb))
 		return;
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
@@ -275,9 +275,9 @@ void ext4_fc_del(struct inode *inode)
 #endif
 		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
 		if (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
-			spin_unlock(&sbi->s_fc_lock);
+			mutex_unlock(&sbi->s_fc_lock);
 			schedule();
-			spin_lock(&sbi->s_fc_lock);
+			mutex_lock(&sbi->s_fc_lock);
 		}
 		finish_wait(wq, &wait.wq_entry);
 	}
@@ -288,7 +288,7 @@ void ext4_fc_del(struct inode *inode)
 	 * dentry create references, since it is not needed to log it anyways.
 	 */
 	if (list_empty(&ei->i_fc_dilist)) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		return;
 	}
 
@@ -298,7 +298,7 @@ void ext4_fc_del(struct inode *inode)
 	list_del_init(&fc_dentry->fcd_dilist);
 
 	WARN_ON(!list_empty(&ei->i_fc_dilist));
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	release_dentry_name_snapshot(&fc_dentry->fcd_name);
 	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
@@ -329,12 +329,12 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
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
@@ -373,14 +373,14 @@ static int ext4_fc_track_template(
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
@@ -424,7 +424,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	node->fcd_ino = inode->i_ino;
 	take_dentry_name_snapshot(&node->fcd_name, dentry);
 	INIT_LIST_HEAD(&node->fcd_dilist);
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
 		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
 		list_add_tail(&node->fcd_list,
@@ -445,7 +445,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 		WARN_ON(!list_empty(&ei->i_fc_dilist));
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	spin_lock(&ei->i_fc_lock);
 
 	return 0;
@@ -1000,12 +1000,12 @@ __releases(&sbi->s_fc_lock)
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
@@ -1018,7 +1018,7 @@ __releases(&sbi->s_fc_lock)
 		inode = &ei->vfs_inode;
 		WARN_ON(inode->i_ino != fc_dentry->fcd_ino);
 
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 
 		/*
 		 * We first write the inode and then the create dirent. This
@@ -1040,11 +1040,11 @@ __releases(&sbi->s_fc_lock)
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
 
@@ -1064,12 +1064,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * EXT4_STATE_FC_FLUSHING_DATA. This prevents these inodes from being
 	 * freed until the data flush is over.
 	 */
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_FLUSHING_DATA);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	/* Step 2: Flush data for all the eligible inodes. */
 	ret = ext4_fc_flush_data(journal);
@@ -1079,7 +1079,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * any error from step 2. This ensures that waiters waiting on
 	 * EXT4_STATE_FC_FLUSHING_DATA can resume.
 	 */
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_clear_inode_state(&iter->vfs_inode,
 				       EXT4_STATE_FC_FLUSHING_DATA);
@@ -1096,7 +1096,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * prepare_to_wait() in ext4_fc_del().
 	 */
 	smp_mb();
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 
 	/*
 	 * If we encountered error in Step 2, return it now after clearing
@@ -1113,12 +1113,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	 * previous handles are now drained. We now mark the inodes on the
 	 * commit queue as being committed.
 	 */
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&iter->vfs_inode,
 				     EXT4_STATE_FC_COMMITTING);
 	}
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	jbd2_journal_unlock_updates(journal);
 
 	/*
@@ -1146,10 +1146,10 @@ static int ext4_fc_perform_commit(journal_t *journal)
 	}
 
 	/* Step 6.2: Now write all the dentry updates. */
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	ret = ext4_fc_commit_dentry_updates(journal, &crc);
 	if (ret) {
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		goto out;
 	}
 
@@ -1159,7 +1159,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
 
-		spin_unlock(&sbi->s_fc_lock);
+		mutex_unlock(&sbi->s_fc_lock);
 		ret = ext4_fc_write_inode_data(inode, &crc);
 		if (ret)
 			goto out;
@@ -1311,7 +1311,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 	trace_ext4_fc_cleanup(journal, full, tid);
 	jbd2_fc_release_bufs(journal);
 
-	spin_lock(&sbi->s_fc_lock);
+	mutex_lock(&sbi->s_fc_lock);
 	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
 		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
 					struct ext4_inode_info,
@@ -1353,11 +1353,11 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
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
@@ -1372,7 +1372,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
 
 	if (full)
 		sbi->s_fc_bytes = 0;
-	spin_unlock(&sbi->s_fc_lock);
+	mutex_unlock(&sbi->s_fc_lock);
 	trace_ext4_fc_stats(sb);
 }
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 356a96269..5bd81dd97 100644
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
2.49.0.1045.g170613ef41-goog


