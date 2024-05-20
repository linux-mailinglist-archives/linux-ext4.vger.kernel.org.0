Return-Path: <linux-ext4+bounces-2583-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F093A8C98D2
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 07:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A98C1F2166C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 May 2024 05:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7717543;
	Mon, 20 May 2024 05:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh+Bsz6i"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7C12E47
	for <linux-ext4@vger.kernel.org>; Mon, 20 May 2024 05:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716184332; cv=none; b=nWAfcttRo4jIHJzfKnQ6hTAk2Tdt6tCrgqe4FrjF4+0txyjak3TpTeTY/O9NhrCGRjm5HL2xqSJYg1+OiDkhT0B1zcj/ri8GheLcHD1ZSNaO4tLVWlEFAkz+OX413khlX204yCCsIVS/i754426dbA+nMDcbq6RxG+jz4PfXniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716184332; c=relaxed/simple;
	bh=y83VfqzQYNAPwzGoDtCOCHuwHUT+ewOBPMkOIfVkXkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=juiDlzq7OFSyoJ/adH26cW7HLxgpQWWp8lBtpRx+7shtn9Rv87e3LQNxu3lKb9cBsdyfvsU3N7onbE/QKTrtrKavfriYA/87PlrbNI1Qr2qR3c44sfru/jSy/XesjdZnsXnrbPInReg/7vrHDZUh2pexyhEwjqnqpvtiBLHfl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh+Bsz6i; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b27d9fe710so993430eaf.3
        for <linux-ext4@vger.kernel.org>; Sun, 19 May 2024 22:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716184330; x=1716789130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6zF7yy5z+0XBHe4my+2NHx/u8EOplamQxW6XlBoB0w=;
        b=Uh+Bsz6iSRerhbCF+ee4jJ156KY0l9epajtCQZ7/rdf01GS3nXA3w2Bj5aLv0eA3m4
         g4NY6Qb7jCxmm/3pBy5+D16SFPcy8B1kbZMX9R9igFz+ZB1050FYHTZRWRusViU4gwLx
         uAsn5C/CGrAnDxV+crE6tMH48uOu6jUywhF5GMm1n3kUIgiF5CsyWIhh7h56lIsbhUWe
         NOHeDDeexRr0enOXcmT2rOg2MGF2acEUqE30kDwBjLwbsft5svlFYgKf76mAMxz3O3r6
         K6kbrZINhBM9gY8+llRJeO39wWEq3dbm51qRWUNd6UTr619NX1KUhrWITajG8dyvn8AH
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716184330; x=1716789130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S6zF7yy5z+0XBHe4my+2NHx/u8EOplamQxW6XlBoB0w=;
        b=uP9S8yaal+tsiIZ7HTa4QHr9RzbXoJ1Yp8JjeAwjMPQm7x+bUXEDwsXchMRLaAwbEj
         ErfGHIazeGCUA+Vvbb1mOYMWSMyJIAqcDmbR/ab7DmOP6GtakdApd3iab3FKYt86Wjo3
         yG9ee6iUio3Sl7WOmDNnZifo06qXdINz+gXlxC/65prXXCg6DwSuTkEUJ90HYzQq2WhG
         oovVrDVh7qSOeSWh9UjZSwPyF5DvQyKu/a23+7Z7AdL0StuUU3iWtVDHR76zv/o3SB+0
         rII18/ls7yCUqMIvN5V/rMcthwDY52GauR70d6C23A6nOzyM8N0bWjvUiG2rhBVNGdtx
         RBpQ==
X-Gm-Message-State: AOJu0Yw7cz49tH8qO0eA2udtG6JsL5Q8nz5PFsNWs7sKHucde7f54dTd
	x0rTp5XmnXGWqcF5SVKrXIKsns2kMTLKwgGRSQhGBJMilPapH+bh6FAl30lB
X-Google-Smtp-Source: AGHT+IFY2UMTH2z/CpbmnkhHEHxA+CPXpZZICVuIcoJ7yiFPkqvveywW0GW1yEAGC48ZucU+5+9a4A==
X-Received: by 2002:a05:6870:fe96:b0:229:fc1d:1ae with SMTP id 586e51a60fabf-24172bc05femr31779651fac.31.1716184329649;
        Sun, 19 May 2024 22:52:09 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-659f66bf18csm6769297a12.46.2024.05.19.22.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 22:52:09 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 01/10] ext4: convert i_fc_lock to spinlock
Date: Mon, 20 May 2024 05:51:44 +0000
Message-ID: <20240520055153.136091-2-harshadshirwadkar@gmail.com>
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

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 24 +++++++++++-------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 983dad8c07ec..611b8c80d99c 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1062,8 +1062,11 @@ struct ext4_inode_info {
 	/* Fast commit wait queue for this inode */
 	wait_queue_head_t i_fc_wait;
 
-	/* Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len */
-	struct mutex i_fc_lock;
+	/*
+	 * Protect concurrent accesses on i_fc_lblk_start, i_fc_lblk_len
+	 * and inode's EXT4_FC_STATE_COMMITTING state bit.
+	 */
+	spinlock_t i_fc_lock;
 
 	/*
 	 * i_disksize keeps track of what the inode size is ON DISK, not
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 87c009e0c59a..a1aadebfcd66 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -382,7 +382,7 @@ static int ext4_fc_track_template(
 	int ret;
 
 	tid = handle->h_transaction->t_tid;
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -390,7 +390,7 @@ static int ext4_fc_track_template(
 		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(inode, args, update);
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (!enqueue)
 		return ret;
@@ -424,19 +424,19 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (IS_ENCRYPTED(dir)) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
 					NULL);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -EOPNOTSUPP;
 	}
 
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
 
@@ -448,7 +448,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		if (!node->fcd_name.name) {
 			kmem_cache_free(ext4_fc_dentry_cachep, node);
 			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
-			mutex_lock(&ei->i_fc_lock);
+			spin_lock(&ei->i_fc_lock);
 			return -ENOMEM;
 		}
 		memcpy((u8 *)node->fcd_name.name, dentry->d_name.name,
@@ -482,7 +482,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
 	spin_unlock(&sbi->s_fc_lock);
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 
 	return 0;
 }
@@ -614,10 +614,8 @@ static int __track_range(struct inode *inode, void *arg, bool update)
 	struct __track_range_args *__arg =
 		(struct __track_range_args *)arg;
 
-	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb)) {
-		ext4_debug("Special inode %ld being modified\n", inode->i_ino);
+	if (inode->i_ino < EXT4_FIRST_INO(inode->i_sb))
 		return -ECANCELED;
-	}
 
 	oldstart = ei->i_fc_lblk_start;
 
@@ -896,15 +894,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
 	struct ext4_extent *ex;
 	int ret;
 
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (ei->i_fc_lblk_len == 0) {
-		mutex_unlock(&ei->i_fc_lock);
+		spin_unlock(&ei->i_fc_lock);
 		return 0;
 	}
 	old_blk_size = ei->i_fc_lblk_start;
 	new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
 	ei->i_fc_lblk_len = 0;
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	cur_lblk_off = old_blk_size;
 	ext4_debug("will try writing %d to %d for inode %ld\n",
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f9a4a4e89dac..77173ec91e49 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1436,7 +1436,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


