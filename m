Return-Path: <linux-ext4+bounces-3758-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DFE955AB7
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1773A1C20AAB
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C38E8F40;
	Sun, 18 Aug 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUpE/8Sl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4B423BB
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953857; cv=none; b=BHPYNlvSTwLrig8IXUS0wUQeXJp8hu9QyxmeACKv3SXg0cXFGMCUny6dGENDrSdfywjsr8PcyyqCo1tKF828s73t4SkbZXMu4bmrJSgvDIJ2ZRbyQfxYFwBuEr/hFP5JeFMgcGzD8HMk4kt0cyqduT2GC0DXak/2iCf7MmU8fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953857; c=relaxed/simple;
	bh=EtWvHugrUxNT4sdu1Z+EtMn5bYwRm40HZ9CSW33o400=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=egQRlRj2Fpi5WqM467SD5KwVTa6Rd+oMPrQHk0t6agmTWMeq/UA8xllFV2ZZ7PHNcwN/7sJWHQdPtNnwLov/3BuNal+UiOTfN1s30di3P9nm49m0CZHw3lyD06HBQI88uZcqABmOpxc5F/bqIk3G4DCiY3dmveM0J3h3Q/n6L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUpE/8Sl; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-201d5af11a4so31154195ad.3
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953855; x=1724558655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GTSjZi9nNnGl3bGfeswIsdohmH+e95ksi86S/JujCj4=;
        b=GUpE/8SlIRKW1Q3NHasRT/GKG3RcPiK3zAt/AVk6vmvE8nhOYRQBLQzQoDx0/a82VV
         KT5K2D+o+1Aa6mARMoz//fpxUNn2wHY6AiCPHbnB/BxwLBRQ/LpGYH7JKhDN3Py4K5aT
         PKMqEo6BW0+0y9JA1Lm4dbU4TD2zwpctKFvF1aFjuS9iVcg4LN1o3+XMPhgCNvQcxRNF
         txTilcQmkkt3Nkut4QGDf/TLsHySLq56ZKRN/zYjVMdtPq18Nbz3CGyqchMDcFrpGjYg
         2kZEQ4AJXRtOFlL/MHTz5IOHBG7aSkq9+d5fV/QV6AQa6nOdFne/d8RrVSflE5/A3vXu
         bm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953855; x=1724558655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTSjZi9nNnGl3bGfeswIsdohmH+e95ksi86S/JujCj4=;
        b=bDIAJO1bNqqiN6ppxUjfmQRHOV0pT1m0mWZwAZI/G4Etay6xawU0WoOvidKH7lVUmG
         gmFeo+RfwscAUZaH8eM4jTwXICjN1y/wIs+NgLWYLHnujyYYRu90b9QFU+MI4ijuoH3J
         iOAZarvmhq6QDAy38ecfcgZd+vj54kKVjl/aPLIAwtO9nw2cSlFTAu9NIkZQpjuwdq4/
         PoMOuwVp9aqEb10sXGpS6ZSfQD/8IF3DaeI9/g+Ybai17uBd9kLywGpt1Sc7a/SMCq/c
         byFm4lYFEeFNslIai1pjGwxzWKaXQkz1FtFwKZ6z295x5Mpe/AUWFY2DoOyltRf0400T
         BAig==
X-Gm-Message-State: AOJu0Yyv+6v96sn/1dGgWAlmLgneDDef1WA4ZsPWYmgLc+fkSW2TyWAm
	DR1n4HyLuqdD+0CDhkwU+zD8pKJvJL5RxD5inlr8iJeKhVOobcoFQeDz3elD
X-Google-Smtp-Source: AGHT+IGaffgR5ZIdnyy2HcB6CGOBCiE5hOOA97NKdOd6pan/2bo162VIjWTOciT4Fz7+u7Pdy0tamg==
X-Received: by 2002:a17:902:e5ce:b0:1fd:6bfa:f59 with SMTP id d9443c01a7336-20203e9087bmr75144295ad.19.1723953854307;
        Sat, 17 Aug 2024 21:04:14 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:13 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH] ext4: convert i_fc_lock to spinlock
Date: Sun, 18 Aug 2024 04:03:46 +0000
Message-ID: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 24 +++++++++++-------------
 fs/ext4/super.c       |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 08acd1522..51ae1785a 100644
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
index 3926a05ec..8731728cc 100644
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
 
@@ -902,15 +900,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
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
index e72145c4a..d37944839 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1423,7 +1423,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	atomic_set(&ei->i_unwritten, 0);
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.46.0.184.g6999bdac58-goog


