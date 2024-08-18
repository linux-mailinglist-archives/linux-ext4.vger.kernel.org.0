Return-Path: <linux-ext4+bounces-3764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20A7955ABD
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65648B2115D
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C83DD517;
	Sun, 18 Aug 2024 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAuzFlJt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D079479
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953862; cv=none; b=AlbLb2ap0tpHAr0C/3kPJ3iwFI/sYjdeOuS2/ixyljqEFrMHpznKizojvVlXoTZ1MiL6pulHk9UI0Ke/qmZG65jgjqTWnrehSYdSU0pjke+ac+7PecepsAy/v7E7YUDfcsQDGKXSrri8gIU8/yFA45pEBNFLOJrf2J63eErJ8YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953862; c=relaxed/simple;
	bh=txtsiM20Uhl52ZBBWLZh1m75l0AUGdoVtt9fLSI4dQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isfSFVN35sb6BfGfIY4Ar9qAaDtzXXNzV51c4kQ1POANsIt0aa4E9lEuTCboVzrhaNmgAlxpmZxVQuXumzZ6F83Kl2tklmPHuyhm2cibTbgicxo4aw+8umVav9OsezvrWGswjpayQIjlSitNWKjeQW9GyGeUruQ/dkDvHdLPRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAuzFlJt; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202146e93f6so16101485ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953860; x=1724558660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhMAO5WRN6ROa6PD7MjAvnb0SivHJRfG0HUVNNaYq5I=;
        b=mAuzFlJtLr937nnbCbMBiBV2RcJUm6vDB9lux9S93DXXG8Ofww49+nElV9U2/StLYd
         wFk8d5Ve1vdOXQuMxQB9e69eWDG/JaZJWdNsCMNEtHzwXpg8TkszOitfj7OFVS6SN8U4
         VbiHivjQPlbryoUcdtdtbAtb9ehEiYpMBlUrgVsYVKZSn+ffRljQUQRXQgw1AN+Z8w1t
         6eTAikPV3nobhYbCcWRqjFi8AulWXbSrlGXPOe7XwtsHCnDEKuzPgf5QRu6IAeT9BJop
         UFiGYYco7mH03iCRP0cL9iwFNYGBDXhY+7QUpkiuL28OAqg+czxjG/SEkMFoiIybNibU
         vkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953860; x=1724558660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhMAO5WRN6ROa6PD7MjAvnb0SivHJRfG0HUVNNaYq5I=;
        b=CwCWxbydIG3DwVH+e354lyXFsy4kVSQNH82MU6YkpiC5FQX1OIGJGWIkvxixtOiTGw
         j6LxmEi+IDetkPs6OFhsbmSKPVeY5dWJrONzAY+RX7aa3pDzmu8osYzvWR5w0l8vhIXv
         fCInwnXUsE/swAauiULXczr5EOGyj7Bf5wvRlb9+AFxB3AcjXfZ8AYD7bvhvsUBFDrNb
         3Wp41ePyup5X/GXZQktsA1JC3pdiqij1V3SJd+UI2IG9KcYZqAUfz/g/TR70BzTh4TPZ
         RFwHWSWtjcRgKUihSxtS4gwzJduPcXiSgEeWQNmZdkG0djqfQb9LrntQcx7HLn047GUW
         kclw==
X-Gm-Message-State: AOJu0YwSWVf6OTmyLH0BCqI8CfLbkdRBW1e6GZ4lkrUF4LokMSEJNMfh
	zy4WBQ6Cb7tr3gi+9Hex5vn/wlKfL+ImBFJbrRbaH7CHN44999Zne7fmBfdkV9s=
X-Google-Smtp-Source: AGHT+IFskFzCmAtOFj7xZYod+TY9evde/Z8y/WOAqOy8TM8jLyG8E1I4L96juoFqMA97+PJOqRTgrg==
X-Received: by 2002:a17:902:c946:b0:202:1bea:ec95 with SMTP id d9443c01a7336-2021beaf13amr39941505ad.15.1723953860245;
        Sat, 17 Aug 2024 21:04:20 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:19 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 5/9] ext4: drop i_fc_updates from inode fc info
Date: Sun, 18 Aug 2024 04:03:52 +0000
Message-ID: <20240818040356.241684-7-harshadshirwadkar@gmail.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 68 -------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 51ae1785a..03734c523 100644
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
 
@@ -2912,8 +2909,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 7a35234ce..1b0540f13 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -202,32 +202,6 @@ void ext4_fc_init_inode(struct inode *inode)
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
@@ -236,48 +210,6 @@ static bool ext4_fc_disabled(struct super_block *sb)
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
2.46.0.184.g6999bdac58-goog


