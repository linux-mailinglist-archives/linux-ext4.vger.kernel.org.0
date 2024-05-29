Return-Path: <linux-ext4+bounces-2684-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE7B8D29DA
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 03:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F162847E1
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 01:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28FF15A874;
	Wed, 29 May 2024 01:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvbU0z7x"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF3632
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945648; cv=none; b=o8c0jV8h6zSMAtLU6XPAmuicrGu9jiwlu7UtNAJVO6ULhu5PDsRJxmnjkkUHQAW3WgoF7ar3h15yY8ej/pCl3cyyRDgDEX45icKFImmXnxkIJVIG1l4/SK38zRkjAeqMDOQ9bQE1GvXSvKpITkcONQPt+m7taO5aYuNMG6Ak0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945648; c=relaxed/simple;
	bh=6ClwghjqacipfUFIlG3kmDQoRHL1C7vIWkmmhUb9uqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJUOqz+N7oaI+Floj/Gp1Fc1i8Qu5fyi2+E4VQEy2x0HmPgpte+TxcnOIqmIgRE5391FZmRYYJSPg2fi7giBNq7nHjozXh92ZZdE+AwomyOc8QF2eyoPs8rfX2bfPM4dgClQKZQaocQZ+DNpE+wDDnkMDA6hTxucaPY/WmKdi2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvbU0z7x; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2bf5ee192b1so297034a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 28 May 2024 18:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716945645; x=1717550445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hK37RO54JishXQn1liveQo1Ra2HinNn7lcYyS3kqgSY=;
        b=lvbU0z7xgyQd/b0Sh9AYU0GBK3W10Ly73L2prw6S0gWLFwKbRPCj1Mnm15iljV1A6u
         3RbX4zC/S9/jed58HtbMIE3/M4NA1UjJHUfe55ojDxaKFN4t0zhPWHke2I70D3qFHcur
         ww7BApGPlaPjsoYP379RW9hAav6UWRDBl5TznqWpqzm7GlU+eOV9yiFQhbsQcOPzgsaR
         QS2B9tMl3QYGTs8unVpn7Pz8GYKG3wO4CLtg4qbue97Mz+nj3Qs+exjwOlSz7e0X6AtD
         cwz1H/LZshtmQC4pOlfFFvIVpFBSxNBCLn7BUWS6bodwOdziYzdvCnJhwt3etQz05MGm
         4AmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716945645; x=1717550445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK37RO54JishXQn1liveQo1Ra2HinNn7lcYyS3kqgSY=;
        b=kXqa2ml/g+z4a66o7aa4TVN6OzKnrWHFdDapk1kH/OPiBzJ2lZNe45iazDqBC+p73+
         0KmjqKKHQF9BkAXn+ris483/TcHEcuTfnvTfbyDH6EAk4u6tyZpgCKX1LU5b3bbFZJzd
         IO7M0kunaFktSJTXMeeUgMKdujeI2FxdDnJiq/X/qQiV18BSxCPUI6wlzFG8cJwadpHu
         QQgp7+gvr25DIWJh2Jl7yuAgdeaxnJ2oKcswXUm/D6OINYjDJjHSL8bQX+xvHZwIX1SQ
         wSLnbplJHSbbOILjcw3J3fQfZ1/+xGMNJ2EfgMsrfEtei0ECSBZGpRTtNGZIpx7Zpavs
         Fksw==
X-Gm-Message-State: AOJu0YxihlHLpdTMhh0KcjM4/XRVjcZs43MP4RedJl9bRO2EBm9/A6ob
	5UY8xVBp0zh2scoAbwUqSpIJ0b1z43b2Fw7/pL5cyCsBX0oG8jQd5r4/uyX/
X-Google-Smtp-Source: AGHT+IFRRMtfrXuxrklmKfn8HEw5BHPUEH0FwngM2J0eT+HmQ91v/+frObL4uoSwcCssCssFomBrkg==
X-Received: by 2002:a17:90a:d512:b0:2bf:9eb3:cea7 with SMTP id 98e67ed59e1d1-2c02ec1f042mr881841a91.24.1716945645092;
        Tue, 28 May 2024 18:20:45 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.85.168.34.bc.googleusercontent.com. [34.168.85.34])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2bde008a188sm10139388a91.53.2024.05.28.18.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 18:20:44 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	saukad@google.com,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v6 01/10] ext4: convert i_fc_lock to spinlock
Date: Wed, 29 May 2024 01:19:54 +0000
Message-ID: <20240529012003.4006535-2-harshadshirwadkar@gmail.com>
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
2.45.1.288.g0e0cd299f1-goog


