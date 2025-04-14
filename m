Return-Path: <linux-ext4+bounces-7245-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D026A88912
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1133716CE38
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0F7289357;
	Mon, 14 Apr 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcRFeTqw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87E8288C8F
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649689; cv=none; b=jZn5S+2mJhLWVgU5n4z0NcvypIR65Gzg0jnXx+ArX27rM0pk/woXE857RNmF7BSpZfHVFnzhCAgiBzwRAxO7Bdu9eZ3NVHEsvF5YcJTc3SF++cs7yxajmJa9PeYZTaWrJF/tTS+V7D8F51OLRsovSf4HvMl9O0Ss9rumxqlrxYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649689; c=relaxed/simple;
	bh=zT+/56q/xv6qQnGWYVCJ5DGW2maPzFy5wAQJnKbMUlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmjCAl2mN4HhJvEp5lCPwAJiZYUYV6A5DJukrlkwfvCjDvGIbV8OG4XHlrht9iGLJRYszMP5yuoTP3wgvFUZFurZKXJGqn6GziYupgTwKe4acKhdIWOqB3IMYE9yalpwCQEAeTNx18Vc5NsO5yRFIgdYXTEhzLfTuysLkX/am/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcRFeTqw; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af590aea813so5187592a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649687; x=1745254487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+8NYPxW2gVewZmy/hiynlluOnZNWDcccm0U9L8vPCc=;
        b=LcRFeTqwlDiRMsIvSiG+kInzY35N0c0zONgtPpSUTmWWocXP5MGvWXQVe38jipTvfI
         vl9r3ZHck4w/4KzAfFu5Tcz6iSHLQciJZZ+lELQ5w+pMdMI/MwSZaJh23tagWRjOw3Qq
         BSbN4GjnOtnGYHldFwUtYkl6mb1vKYW+COGSzTlEiqWQu2uqOY+29fsT+6sOO5FqxMIK
         zSOAfiFjuJvdyK4mIaF4qasSKi2bgNZWEpUHyKtdPv4Ei/Ap5/79ZBkreE0tfu/KHRo7
         HSltYsryFNfp9vmKEOYL1zGzKhlAGhJ7xUinNC+4Sko9/6HPWs63QlL2R02fIw401DtL
         estA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649687; x=1745254487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+8NYPxW2gVewZmy/hiynlluOnZNWDcccm0U9L8vPCc=;
        b=EjUpYg72w3szbg0b0GATHLogQOTQtZVUl95CkgcpKckOMPj2FmoBASf6svwB0BAZqs
         AywnN8oEK/3FSLjn+B8fOMe7NnEG0bWCHxvYpIhCq5ykvrxQPXWNiH4eQahaM1k1dMAL
         wlv6d23SMplDRhF2e+GhE7tXad8/sInC4AeolWzW/RJi9FlwCyJoMqHjVXVZe/bCaxb0
         WePPNsUid/VOLIHHZJZmAa21AMFm9GVZdATXi0LYBGQXR7uBcupfHYjud3bNhfkTfViV
         N0VIc4CvJ+vjPdk7IQtejsCaO+z79TLfa33lRA41jNJR3NrQb4ZBXmtTY3Hp/ct6L+FQ
         UnTw==
X-Gm-Message-State: AOJu0YxQU831rlsNrWE/NZosIRd2L2fsT5SAW9o+6aaYeEicd4qymBf8
	nEADAqESyDMU2iAqxbqQ5oOYQhdVP/VdbcydTzOrqlD0UACpat5tusmHpjHp5+E=
X-Gm-Gg: ASbGncsBTBTCXu4eXlviDlY+XRsQGkkMY6n3X/dqyJZP6tQoYRferem00QHaJvTpzHm
	wx0GtaIfpQV3dfnnmFv0r1u1YAfwRF96qE2XEJsjZFz2eN12XJil9DAWkG6qgJ8gm1K+NYqCn1k
	0HgqHJedCBC45ZBXgvvz12Q2Y6nnsTk+eXVNmqMznevehh+XPGj0o1ag9XN9KivFGmvc+bRkv+5
	jBVMGND8S85isBN8Wt5NS4PdxqTGR94MLcSuur2YZbt4VP2Q9YAZJ+qtmrK1nG2veQrIR3Beu/q
	9XRBG+0YZicMiVU8RyHQu/mNquaGBf86gQ+4R7F6Y/ca+Hf+e9CTJ/ljoA2LZYMjI2265u+QtAp
	yExqZVhoGld/5Ae8Jlji8l27BKOa/X/DG4S+fZ5aBUhi6
X-Google-Smtp-Source: AGHT+IHVnJQ3Bz9JvRHusjSxIW0NsTTXRRNPLn+IqWqXs5mJLftcXm1k0Kl0OjJwBjNVBRJTvOs4wQ==
X-Received: by 2002:a17:90b:390c:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-3084f3b3bffmr137276a91.14.1744649686576;
        Mon, 14 Apr 2025 09:54:46 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:46 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 5/9] ext4: drop i_fc_updates from inode fc info
Date: Mon, 14 Apr 2025 16:54:12 +0000
Message-ID: <20250414165416.1404856-6-harshadshirwadkar@gmail.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 68 -------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 79dfb57a7046..68f40fa1b0eb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1061,9 +1061,6 @@ struct ext4_inode_info {
 	/* End of lblk range that needs to be committed in this fast commit */
 	ext4_lblk_t i_fc_lblk_len;
 
-	/* Number of ongoing updates on this inode */
-	atomic_t  i_fc_updates;
-
 	spinlock_t i_raw_lock;	/* protects updates to the raw inode */
 
 	/* Fast commit wait queue for this inode */
@@ -2925,8 +2922,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 126df97944c0..2b12f5031633 100644
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
2.49.0.604.gff1f9ca942-goog


