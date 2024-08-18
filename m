Return-Path: <linux-ext4+bounces-3760-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2E4955AB9
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 06:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085891F216DB
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 04:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABF4B674;
	Sun, 18 Aug 2024 04:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM7AltTg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC808BFC
	for <linux-ext4@vger.kernel.org>; Sun, 18 Aug 2024 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723953858; cv=none; b=FC82eIB9SvfNIno6SXlwqPnO2TfII6hpK00zkJV/ASO2YOdmrHMKopTnhbB6MQBIC5UIaikpdpPQwOWKAOsDppNGUkmm1Gy9if4tcyD5De7Osxl24F8Nt++yO4ttkQAzVfsZT7MMOnCBHGWJVe1GBq12/0SCNVDLkpRPW5sgPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723953858; c=relaxed/simple;
	bh=EtWvHugrUxNT4sdu1Z+EtMn5bYwRm40HZ9CSW33o400=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2F1hA1VkCTmYbAflb4EWEkrh3ky4Nmox9Pv37RXScwyY+YV83sjOHv235nAkBeYtGTzkFK3SwY/Wtzk4Nspqm6etSWbj/Go9hr/BBrG7h9I7XRyPr2Bd6BPhaoILuhzJRtlpeGXMIVl3ABNxa1p3YOifYesWAFJA7JTuiyBplI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WM7AltTg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-202318c4f45so4405805ad.0
        for <linux-ext4@vger.kernel.org>; Sat, 17 Aug 2024 21:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723953856; x=1724558656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTSjZi9nNnGl3bGfeswIsdohmH+e95ksi86S/JujCj4=;
        b=WM7AltTgd1Gj5XDiEkgbGF56e9x2vAl1WXqpW6nKWO57wPQIyerM1/AzT5j8zOq+QC
         3XVGtfpYUFECiTz6bDEj0th5i+8+79KfRYECzh/7pngYTvV5Ek2yI0kpajTH2tkOWsHi
         5g3jGwJEZ4zUdateaO5ZgZKazwgrLAbgQs5+ROv53NCmms7uNTvfTHohleEJPffXJqG0
         OR9UncZ0iR9FrTpyYEccbB08ZijJRBkhiHSnLyfKdgWz9KShugbXPEzwvZYEbdD59leb
         c2kWoFrYTQ5wltjGHsJHhv5cK9C8jSqEb+A8+MEDOQPo2NOvrdEOFzY+x/Ivz/k3wIod
         S5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723953856; x=1724558656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTSjZi9nNnGl3bGfeswIsdohmH+e95ksi86S/JujCj4=;
        b=gTMKxPv8TdkgDRqueYTfmoIDjOOnN0woHhBcSrpmjDaorZbAptfI5zy/h6i6uoU0Ua
         CuerQjDOPQCQq643QeCJ5XX/5DS/xVcJkitxzfF2zh5DaoyEd/eTLxkxFdtFAvsCvSSq
         7MW5lY/CtjpVtOiDhuI13CtUIPRu2IHKC1eyC/1wWBEbKsJSZv7ar2HL/KKaqQh0acK5
         4f6Zgtb4wy5CvL6ObND521MQ3P9pTt4pnR2lZ3FoWpjb9noNKVjpd/f/ivwLnGceJFbG
         pRV8Zyab+33gOxxuaCb+uWML/c0AkuwSJrNlUCkSiPZEdi6xbOgpvJw8tuoumvK3L+8W
         QVlg==
X-Gm-Message-State: AOJu0YzADPXRfkxZRSS7yXy0FHi5dHpuypLNMqadgcT8kh98j8PaH1ze
	EstITMsxN7kr64Iid4j3Deyk2PIGjKUAmXKS4+TZhi1HnFJeG4v4sPz7tQpnXJM=
X-Google-Smtp-Source: AGHT+IH7MiN9IBTkCzOF8UOZ+32Y6kCXAIEsMxQjPUuyLx80dG4rarnCMCgP50UO1VwNUf0CBBXaBg==
X-Received: by 2002:a17:902:d4c9:b0:1f8:67e4:3985 with SMTP id d9443c01a7336-20203f3297fmr83327995ad.49.1723953856054;
        Sat, 17 Aug 2024 21:04:16 -0700 (PDT)
Received: from harshads.c.googlers.com.com (27.179.83.34.bc.googleusercontent.com. [34.83.179.27])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f0375649sm45138235ad.124.2024.08.17.21.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 21:04:15 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v7 1/9] ext4: convert i_fc_lock to spinlock
Date: Sun, 18 Aug 2024 04:03:48 +0000
Message-ID: <20240818040356.241684-3-harshadshirwadkar@gmail.com>
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


