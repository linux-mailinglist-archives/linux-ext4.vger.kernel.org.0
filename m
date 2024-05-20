Return-Path: <linux-ext4+bounces-2586-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1188C98D5
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE321F20D44
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DA61862F;
	Mon, 20 May 2024 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRhpdxSz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D717582
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184334; cv=none; b=BXBaflwNtzmjk4o1CW78DmrrBAx55cpbnr44989Y/qHsZRKIOgASOgRovI5/FOU4QRQTxbI5V29kviTVMqUVb5IS68TepcbmosVqhxgwZ7LGX1ztrAN4SaVOB/XnOXugWu8fAyPvkoL2ndTPZgTonRUrkXYk2n5ewGqzuG6S6SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184334; c=relaxed/simple;
	bh=rpBz9vLAzdaJlOoNeXr7x37dA1Tze6lXs6lufgGxJow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA/DAYpvnq4r9U3VapqiiKYEw7PwADLEEEqOsZK1dw2FD5lD9JLCQnMfFELc8W6SvjABi6RneKWhpBihpw11d0rQfmVtjcKOiq5V+RRRtFhm+nCv0TrPS0TvjvML1zXpsKLRvG0WitBLCpyruUDIgy+3f7zsb/FaJuLKqx5se/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRhpdxSz; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b27369b0e3so1985513eaf.1
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184332; x=1716789132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK0VIVfyHXvS0hL56EprcUWAYoBHbBLb+S/zIHkEoH0=;
        b=ZRhpdxSzBQuBAF+1a5dU8wYeYr4jqcfpYnQ7uwp6L3C9CAxFosCsOUtzBdRakw+IJL
         i3EGNqyfi7eA7I2qNjkwdf95ZUqxQMvrvIRJCyjRl7DIo5zvegL1AEP6h6zYB21SwMKg
         uMrr150ABtHYcmQ2KMN3gkXnmKGbvat5OxfHF8qLfh/bY3NgaKXeCVVQ4Y3kYACvyb72
         EGfnBYNwc2XAZawNvcodZEh/4C6yur50b6TmiR815CWSgQ2n2x1ki/q5nD26RZSokx6x
         Q4rFPZJflQpdAQo048Yw1RXCJYC50ygiJH6OkwtiWpSoQl5K0ioMj1V50nTBK2fnW+mO
         43pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184332; x=1716789132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK0VIVfyHXvS0hL56EprcUWAYoBHbBLb+S/zIHkEoH0=;
        b=MRzsFXp6MB7x1e66BFkVtN/rNMp8Pv2HspJEupQXplPXSA5kjPFRxqJjfc5O//tjYH
         Cy5oIn1qa8177Gj/PwQaL6uoQuEtFlAGRvmooz/UxUiuIwL+aNt+Knt6BWEKjAWOLhi1
         6LKEnH1lD7QMdmJ1O3RjL3JU8a8e+ICp+9+nciUkY6trcTJmKWPyltORBLrM3vzWnC1O
         yS6qcI7oSJFCuDK7y1A+Ppgi/1dkC0HbClDkCxS6IXTf6KbX/hknaJtq5QaJgTrJGZKR
         ReIEc90O1p+0sFj/cIK6V5khUXQY3jsI3zQSBNeSp49VTKmNWh+zrNJHww6w07+b3PnB
         jspQ==
X-Gm-Message-State: AOJu0Yzbdi5Cq9qrc+2F+jAgOxOZjlTwTtNGkSH2FZbdJS61uBe1fY34
	1vnzxIVXn37phmhdion9SJRnZoXI4j2EwI3o/m8O7AWpNpG0VoqeAC/Ham8K
X-Google-Smtp-Source: AGHT+IEyXDDT5efOrydURoPO/BA7BISdT4SW7Z2rSaC6dLlq+a5FE2t5RLr0N/Nrf2sAHSLwgNXauA==
X-Received: by 2002:a05:6358:720d:b0:17e:89bb:e545 with SMTP id e5c5f4694b2df-193bb63f1c8mr2921633355d.19.1716184331748;
        Sun, 19 May 2024 22:52:11 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:11 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/10] ext4: drop i_fc_updates from inode fc info
Date: Mon, 20 May 2024 05:51:48 +0000
Message-ID: <20240520055153.136091-6-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
References: <20240520055153.136091-1-harshadshirwadkar@gmail.com>
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
2.45.0.rc1.225.g2a3ae87e7f-goog


