Return-Path: <linux-ext4+bounces-7769-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 887A9AB01F0
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 19:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B94271BA785B
	for <lists+linux-ext4@lfdr.de>; Thu,  8 May 2025 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A3286D50;
	Thu,  8 May 2025 17:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0fFSCgd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF59F2868B9
	for <linux-ext4@vger.kernel.org>; Thu,  8 May 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727175; cv=none; b=ZVDmsCApVqpLd3yVByWAMJRbwC/uiqKkJYdF0N0pFe1bIuTZHb2LUqTu/SUq5O6wCn1wPpEKVTJN+X0paWWtPkL+aQrP0fWJk/Ozo/cKzd0jTOAewTsczLqeHSyGNGKBbwCKJaqXrva+tS5fgXjYEgfh0zJW6DvzhnwK3XsV0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727175; c=relaxed/simple;
	bh=UMhJptDCoxFbOr/DgzplbaSy1iUoHDY7iVhruCdi2Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlx8vQO2FF4x/MLK1tgBZ1OYmcZkh5U9DvhdCANrmVGJQ+GMX8ZvAgbAYisg2W1LweKjjlh/TN4MNaVZ64vYJs6nOGh4XgHZGAPVlx0N5nYwHGK1GhR5M+DA/g4Ejg0/m0C8Mw3hfkukgR/bNpCebg56tP6N1Pd+2d56cjbHOxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0fFSCgd; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22e3b069f23so14544465ad.2
        for <linux-ext4@vger.kernel.org>; Thu, 08 May 2025 10:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746727173; x=1747331973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHYPtr7EGhcmivZjeZ/FSny71tLJ11EFlKC1kKH5xzs=;
        b=G0fFSCgdXv8TDDPnobUPxfMY5eLXSEw7fjdHmBwANzleynSFRydj1aiNgnGCJm6b06
         b4VY4MItJDFcuwcnmqEygCXyVk0SFfm/TQ79X2jynMiUxVRdLk+9YK7NdeOHN1yVv2AH
         w6k9NlEA1+LsAFPnLhw2v9MyY04qq1OQ6VcgNU5BImt7MqWB484x0d6VDgeKCU2z5TPg
         Is1YLMVQm6xeqBAAV3nG6rWc3Wm5d55kRHIXpmx2FmndV7yBtvYnCYJlyEnBQ2b4EGZ8
         q6yd0C7d8U+iyIZ+qilMf76yuDBVqUEGT2buXP/CYw/tV6TGU8TpYAcI7XguZeb1img3
         d8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746727173; x=1747331973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHYPtr7EGhcmivZjeZ/FSny71tLJ11EFlKC1kKH5xzs=;
        b=oTD1AadA+xBkKfa6+rsx/h68KvNhNNpQxwgt4PW8gGi2j6nf8Ff9PrC8asXlNwb3zt
         06DVHGiDTCAZRwOFGD3PQEzHr/RTkmeMtMPLIhep1byWl6rekeJC/P/kQne63vY8sKLm
         P45tOV3CF3FLfQ7HGWIeoekKSQhO/SlOMrfGL3czJxrHC//DNeSxYEjNzwgg90a5QY+0
         J3WMSYvzXAWUuh70q5LQpXZ/czjnTnQ+BL6Q6F9oE3IUwtH5AjuIzN7llobXp6sQ6c7R
         Q6yijGVW3QEhvpeh1nh0WpJ7C7GPZY0SuLDKmX/xZXKHFuvS37A5MLM+n1Gi6f3j3NKt
         aJZQ==
X-Gm-Message-State: AOJu0YwlG3BLgXoPpnb+4UmqqYVvDKmHxhyi59j0rEY2A/6yKeNEkkTP
	fd7ZsAU7Ei4Ktnt2BfO1MXPjnFVacP7Xl7tNtcTwuQmhoDA7nyxf1btquxNk
X-Gm-Gg: ASbGnctxJxg8b5127FjrmANGlMcsGZ7H6FDWa/siDKFIHA6H5r802WThkNEBHNgOQ/G
	6niFWRpZRY0PxyB6vZQXZX/WNlSdG8KihJ8vhgij6GBOqyxtkw7yhO2CQxOJ+GwrY4H//4WIM+X
	3ww88zUbEnf1RNUE0LLwp9nUmY3VW7MwwgW33YSf8UIehhAGvO0H4ETgxxlSPWj9IxWvvBzKcDe
	GaIU6IJ+hu0fyIE3MeFPL5kF/cdOU0CJkp+J16nwVeFlgDn2DjQZgw9fG/inc50vULBO7bwPhvE
	pbKLbN3nXb1eK9ZKTmEbgW/w8tSLFoJUhrvhebrip8lEy7aISPFAFdrG3s3Y6wdH7c9ophQMr+F
	HK2eWmXFEwASP2V6i1lcpqXuKSjAt0/ChoGTO
X-Google-Smtp-Source: AGHT+IFtora0wLy7ObSusPxsaDuQExvi7KgA7S61jDLUJEo97ej42tcShAPCFmLY4tuCNScjgpUxkw==
X-Received: by 2002:a17:902:e94d:b0:224:c46:d166 with SMTP id d9443c01a7336-22fc9185e22mr4356285ad.40.1746727172542;
        Thu, 08 May 2025 10:59:32 -0700 (PDT)
Received: from harshads.c.googlers.com.com (156.242.82.34.bc.googleusercontent.com. [34.82.242.156])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22fc828939asm2153535ad.164.2025.05.08.10.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 10:59:32 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v9 1/9] ext4: convert i_fc_lock to spinlock
Date: Thu,  8 May 2025 17:59:00 +0000
Message-ID: <20250508175908.1004880-2-harshadshirwadkar@gmail.com>
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

Convert ext4_inode_info->i_fc_lock to spinlock to avoid sleeping
in invalid contexts.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 fs/ext4/ext4.h        |  7 +++++--
 fs/ext4/fast_commit.c | 19 +++++++++----------
 fs/ext4/super.c       |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7..79dfb57a7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1069,8 +1069,11 @@ struct ext4_inode_info {
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
index da4263a14..63859ec6d 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -385,7 +385,7 @@ static int ext4_fc_track_template(
 	int ret;
 
 	tid = handle->h_transaction->t_tid;
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 	if (tid == ei->i_sync_tid) {
 		update = true;
 	} else {
@@ -393,8 +393,7 @@ static int ext4_fc_track_template(
 		ei->i_sync_tid = tid;
 	}
 	ret = __fc_track_fn(handle, inode, args, update);
-	mutex_unlock(&ei->i_fc_lock);
-
+	spin_unlock(&ei->i_fc_lock);
 	if (!enqueue)
 		return ret;
 
@@ -428,19 +427,19 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 	struct super_block *sb = inode->i_sb;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	mutex_unlock(&ei->i_fc_lock);
+	spin_unlock(&ei->i_fc_lock);
 
 	if (IS_ENCRYPTED(dir)) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
 					handle);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -EOPNOTSUPP;
 	}
 
 	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
 	if (!node) {
 		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
-		mutex_lock(&ei->i_fc_lock);
+		spin_lock(&ei->i_fc_lock);
 		return -ENOMEM;
 	}
 
@@ -471,7 +470,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
 		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
 	}
 	spin_unlock(&sbi->s_fc_lock);
-	mutex_lock(&ei->i_fc_lock);
+	spin_lock(&ei->i_fc_lock);
 
 	return 0;
 }
@@ -893,15 +892,15 @@ static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
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
index 181934499..ed8166fe2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1415,7 +1415,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_datasync_tid = 0;
 	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
 	ext4_fc_init_inode(&ei->vfs_inode);
-	mutex_init(&ei->i_fc_lock);
+	spin_lock_init(&ei->i_fc_lock);
 	return &ei->vfs_inode;
 }
 
-- 
2.49.0.1045.g170613ef41-goog


