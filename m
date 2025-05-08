Return-Path: <linux-ext4+bounces-7771-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A435AB01F8
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 20:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B797BABB1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04803286D67;
	Thu,  8 May 2025 17:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJ1GdKR8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEE4286D56
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727177; cv=none; b=LiaWkule5h392mW8+wr4hEkjztvT7+6XlYnv7toUDnQI2O0JY2WAvyTPyZK+iqu4Fwg19ELLLPOPGvnwcmODjVH9qeV5bANoFLJmT//MTnCFnnI0OxICTjxfCth+ShM1u7Dzz1j9WZHAjZcUc3yENpOSiuVpX4RtgOrZSe7YLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727177; c=relaxed/simple;
	bh=x0YJJ08B0/DY3wqb9g0trv1BYi9N2GTWQu1oJb0rgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlkFohIf4d/YQLV8yDK6+lxSLMUgO9fhqgWAHzqmD7na5wqc7tGFOfsz821QUFQJaLec/LjFDerlUT4FUstLYuRfrnvBtfECIqtMUSDXWlbZK/eeAZuUz8pBL/dEtPk26+0uBefBiV2FNQTqmKq3Q8gIDANPWrISaXqhrjfOk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJ1GdKR8; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b170c99aa49so875156a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727175; x=1747331975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOvVBJYrnMiNzk7zUHBiRwItkfw8ANCuqE/C1Bp2rf4=;
        b=WJ1GdKR8tf31iB8qVd9kLDEdxDxRxhzHbcrk9rQmthdMnZxGJqT/N6lyEoqAalQjWz
         15RRx/v4WWc0KeCwxvjXIc883FqnXRLNHHalhd8OF4t61/FoXTYz0JUYFd/wCwj8WMTb
         QLtkL9MwA10OsLwFOw/q2R5xOcsa2Rr63mBAUo2WJXqUpMUsOGjdvpXar+VAb3wX27c7
         18p5+zyXUf5+hKKyX/nO6gYv8t/OzVzKai4xqVOJRZOKE7jOiYKXN4zLvt0KjsUpqDcD
         R6swItT2Vzw9xmttEOzDGK1XS5xziK8da4u9IiSljS6fweuXt9utODkSeFH5GDn1I4bu
         3N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727175; x=1747331975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOvVBJYrnMiNzk7zUHBiRwItkfw8ANCuqE/C1Bp2rf4=;
        b=OGCFB4j1/6RQFYs1wF6DR70B74S5GeYIp0stgzaylR+bwRo/UV5kwCCoTRJn8enDW4
         X2mmfBKAD9h2H+E2+1DolYkn8dSrM/QAxNfWhIkPI5lzSdm19sZGRflUlZTxKUCltHpW
         2aUjTbSAPVaGdtTR7VgeWas6cSgyKSz6ToYxXF5VolkwuiYJiFqODytT8RrF1/7RGajD
         jtC0cEt0rDyEm7scl+k1k/osl5zXvtTWVw+fXA7ygxZmlr+O+zDyaS4m4Ncsa88c5qgF
         M7CmP8y47JNLEHtQPTqjV+yuadU2z4SoBrQik42EvI/Al6KatugKvpWCuMEzF8AJgdCZ
         F6lQ==
X-Gm-Message-State: AOJu0YxJPEVBg0qDdY23CvJJtpLR3lrCnOsymNwGaSv0rMnb2ihCYqF+
	m1JSF+Zi/k/hSvE0YdHNRYh0OhvFpKCsXuw6u9hOPLpLUWDWWY/kTc96RKYwwFI=
X-Gm-Gg: ASbGncsUUP16OYzwmdOGdv5jLrDm4Pt4jRhOXZTUWQsBRE3TRcjWc7vlOwPQf+OUYZh
	Ge343I0t7TIcStv6CdmlE2/hPIz0553sVKFCYS9ZdKk99LYwcy6ZLUUiGE20Q8/miwWsq2UStXn
	/A4WSnxPYMxA+EPUnGIMsnEZ7ReO75DBID2BlrFn1wzRSY9vBF2X7CJVfTfBdQG5sfr9zFXJufe
	iOxkMNQo79ETNxEFjUQ9aNXh9Laozazi9dgJT8WaTzMdVhFq5G9KZkp5IvO7SYXcUZ1xn7N2Mew
	BYKX0UOyyn9oAk9gO4pwFTY078G2kCwQAtwTvn02ZvbHqISsZg+pbqN480TjiqLsatnXXnxn+tZ
	Kie67wl4vpX+9LoU94ae19PEEjjHSsEZkqhHP
X-Google-Smtp-Source: AGHT+IE03OLAqxYdyFHhVN8TaXGRy1rMHBRzYj3T8YGBirkECS/YV6dVgYo4eez55Bbgr/L1JtBbTA==
X-Received: by 2002:a17:903:988:b0:220:c63b:d93c with SMTP id d9443c01a7336-22fc91aca1emr4166395ad.44.1746727175121;
        Thu, 08 May 2025 10:59:35 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:34 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 5/9] ext4: drop i_fc_updates from inode fc info
Date: Thu,  8 May 2025 17:59:04 +0000
Message-ID: <20250508175908.1004880-6-harshadshirwadkar@gmail.com>
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

The new logic introduced in this series does not require tracking number
of active handles open on an inode. So, drop it.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h        |  5 ----
 fs/ext4/fast_commit.c | 68 -------------------------------------------
 2 files changed, 73 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 493d9ac7a..0cb34a06e 100644
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
@@ -2926,8 +2923,6 @@ void __ext4_fc_track_create(handle_t *handle, struct inode *inode,
 void ext4_fc_track_create(handle_t *handle, struct dentry *dentry);
 void ext4_fc_track_inode(handle_t *handle, struct inode *inode);
 void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handle);
-void ext4_fc_start_update(struct inode *inode);
-void ext4_fc_stop_update(struct inode *inode);
 void ext4_fc_del(struct inode *inode);
 bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
 void ext4_fc_replay_cleanup(struct super_block *sb);
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index a2cb4d965..f2e8a5f22 100644
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
2.49.0.1045.g170613ef41-goog


