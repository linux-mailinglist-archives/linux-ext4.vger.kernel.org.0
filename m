Return-Path: <linux-ext4+bounces-2687-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 313C48D29DD
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05AD1F26BD4
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64C91E86E;
	Wed, 29 May 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2RYR9OD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF21015A841
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945649; cv=none; b=SLZD6joDzkg17tYIehg7V+YPuH43Fk9ST0VJH30OkwOyzU+IMAfAbeHYIOWYJABsFYXLYEzjZrYEr0Z5l6kkoTqMPFX71J9/MUwu+nlC1K25zBFrUxuC0QEKtCRWgMaJgKf29pRtbxJneFaohT4gAXnPnGX/wkQZT+2aTex24Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945649; c=relaxed/simple;
	bh=Ifn8cMlkb43xQWnu/4e+T3JV04rmE8Wyerjm7Ny33PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgtRIg03j5EoM7C3HUmdxc9dGCLlZwMAaS8sIoHdoEoYXfZlWnCs74tHpg4tkugW4EU1SzJ3WRi4UY6dIfVlBpkfmaN5RMNe5NWjb9EuuC2IoVNssdjbr5hPppbiCglyQhiyRK/uOxSwwRr+ONN988slYUjkZCxebi/Jse3dzAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2RYR9OD; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bfffa3c748so1325543a91.3
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945647; x=1717550447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/S79vAi7iafvt1rSzjw7cX2kBSQxhS+GF6wMgbq7Tg=;
        b=U2RYR9ODubolHUF13DkgOmHgh+KAVQ+hVV9L2XAwxGeQEZ/N81fNXqFlSdAhYUUjfH
         kWNYCDOHpzGVrmTE1hp3IV60gd4Llv6tVv02d3+volvgh6ZZdslqqU/ry96Q2vBV0sna
         tEHZ0FUcaJfV1yEc10AlUEACBNyKHRZjfsneWeHvmIk2409T3iJk3cjqLD2qC1Z/5Pn1
         akJ0MxwEa4lqfLD454hXNGikhM+uy9r++f3K0+A2flVPa8dm9CAi+InMOGQXDaJ0iawm
         0VQZnJc5hmojQwd/i7HmiXcDgmrhQrZsekfX+liTTL6DgUI2MIclJ95Jbt2tzSrXtUmU
         b1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945647; x=1717550447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/S79vAi7iafvt1rSzjw7cX2kBSQxhS+GF6wMgbq7Tg=;
        b=ab7IQBjWaFN4Gd49AKf4DIhM8XzY4gDcsFIzkFynRlJeN6ggmhCvK/xwvSfp1z//3N
         /oA4tNX5xvjfBnwoNzB9VR2upsqcZ6olH+l7mCt2h+MkdwI1c8JcW5cac0QwgSqute3J
         QPs+8kzVJnRG2gVJqS4+DM+K1d2HSh6vGMUbLDvCrF7+ghfSDaPh40ip2XobMibX/8Th
         8KUhg9haYqyrgidw8HlZhMF9N55pXNd7kp/90amrYoCQo/gZ3mJpYUGQcpwOlATp7+Mt
         5BdmUneudFBQ1fH78gEWouwlVeqox0rtpxYvIJllbL1gCx1gpckBvG8hXEzWr4oa6sAq
         YQ/A==
X-Gm-Message-State: AOJu0YxUGM37waw40YV/k4Y7xQZWVXixeoLsavXuG+PwO09n49rEhip+
	z6StC6ZP0kKN9Be/kpigtpuEMwe39zzKEIVZfobmORm4zWSYC6pzzCs7V9IN
X-Google-Smtp-Source: AGHT+IE44ETEkNcdanPT7c/K9pxoYAIw7NX62HGMFfQvw695QYwXKko237U6PAlmUr0uOyeFCag5wg==
X-Received: by 2002:a17:90a:c582:b0:2c0:336f:4bfd with SMTP id 98e67ed59e1d1-2c0336f4cdamr166025a91.44.1716945646947;
        Tue, 28 May 2024 18:20:46 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:46 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v6 05/10] ext4: drop i_fc_updates from inode fc info
Date: Wed, 29 May 2024 01:19:58 +0000
Message-ID: <20240529012003.4006535-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
References: <20240529012003.4006535-1-harshadshirwadkar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 68 -------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 611b8c80d99c..d802040e94df 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1056,9 +1056,6 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
-	/* Number of ongoing updates on this inode */
-	atomic_t  i_fc_updates;
-
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
@@ -2903,8 +2900,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 3aca5b20aac5..ecbbcaf78598 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -201,32 +201,6 @@ void ext4_fc_init_inode(struct inode *inode)
 	INIT_LIST_HEAD(&ei->i_fc_list);
 	INIT_LIST_HEAD(&ei->i_fc_dilist);
 	init_waitqueue_head(&ei->i_fc_wait);
-	atomic_set(&ei->i_fc_updates, 0);
-}
-
-/* This function must be called with sbi->s_fc_lock held. */
-static void ext4_fc_wait_committing_inode(struct inode *inode)
-__releases(&EXT4_SB(inode->i_sb)->s_fc_lock)
-{
-	wait_queue_head_t *wq;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-#if (BITS_PER_LONG < 64)
-	DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
-			EXT4_STATE_FC_COMMITTING);
-	wq = bit_waitqueue(&ei->i_state_flags,
-				EXT4_STATE_FC_COMMITTING);
-#else
-	DEFINE_WAIT_BIT(wait, &ei->i_flags,
-			EXT4_STATE_FC_COMMITTING);
-	wq = bit_waitqueue(&ei->i_flags,
-				EXT4_STATE_FC_COMMITTING);
-#endif
-	lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	schedule();
-	finish_wait(wq, &wait.wq_entry);
 }
 
 static bool ext4_fc_disabled(struct super_block *sb)
@@ -235,48 +209,6 @@ static bool ext4_fc_disabled(struct super_block *sb)
 		(EXT4_SB(sb)->s_mount_state & EXT4_FC_REPLAY));
 }
 
-/*
- * Inform Ext4's fast about start of an inode update
- *
- * This function is called by the high level call VFS callbacks before
- * performing any inode update. This function blocks if there's an ongoing
- * fast commit on the inode in question.
- */
-void ext4_fc_start_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (ext4_fc_disabled(inode->i_sb))
-		return;
-
-restart:
-	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-	if (list_empty(&ei->i_fc_list))
-		goto out;
-
-	if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
-		ext4_fc_wait_committing_inode(inode);
-		goto restart;
-	}
-out:
-	atomic_inc(&ei->i_fc_updates);
-	spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
-}
-
-/*
- * Stop inode update and wake up waiting fast commits if any.
- */
-void ext4_fc_stop_update(struct inode *inode)
-{
-	struct ext4_inode_info *ei = EXT4_I(inode);
-
-	if (ext4_fc_disabled(inode->i_sb))
-		return;
-
-	if (atomic_dec_and_test(&ei->i_fc_updates))
-		wake_up_all(&ei->i_fc_wait);
-}
-
 /*
  * Remove inode from fast commit list. If the inode is being committed
  * we wait until inode commit is done.
-- 
2.45.1.288.g0e0cd299f1-goog


