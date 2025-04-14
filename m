Return-Path: <linux-ext4+bounces-7241-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EC8A8890E
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 18:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC741884D40
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Apr 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA0A24728A;
	Mon, 14 Apr 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDYEvRW2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2F118AE2
	for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744649686; cv=none; b=W9H8Hv5KOEIfkYZF5UukqilELK7cxV00FQmIQLwx+gHtvSyzEQR3DYmHjEeZP3m1Yv+3T8sHRJ7fnhOdbHlGPTFaluQyyss3Kru/rbgzBo1i7VBdPRJxjk8KZYCHnA075ABezuzz9S4HGORzb77CkJ3wJSGqMo3KAWZnr0O+uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744649686; c=relaxed/simple;
	bh=EH6PMD0VTmF+k1DX31wfbqVjlJ9SP/SJGxt4zUX06iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O931To7BPF6bN7p6LBgi4pvAaq+k3y+oiRGIDqIk+s6+atOnApXNSKPpKX5eR+kC2qxoGiPn09RL/MfIiwM5+tZ8Q5gLZOgq+tMsgTY60AqKuAHpIXU87nzH+sR6C2T5ulM6doRtIqhKrB9zkzJ360q3yczZgjGuFh7knwKMGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDYEvRW2; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af523f4511fso3994237a12.0
        for <linux-ext4@vger.kernel.org>; Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744649684; x=1745254484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9k3rOc3UZ1yvrH1piHMIhaWY9r9584cVJHbVmZZrIgA=;
        b=XDYEvRW2CtnHSq/HISr+fCsHkkhUl7UGixHwT0eVTcM9RrjMy5f0l75CIYvllfpjZu
         2G83nd6VuWakE4PqG6pOS2XFP3mtmFFvw8+k15I4ee8WHCiCHbMdPnNI1N+yJT+whDl0
         QbWyQzhPhBBb5t8I3PUzJcmqsZf1sj0NHQBjvmx5ODUMLEpOyvHF2DRWRidqiMJmlmSi
         gzQ3EVajnTsvcZe2CMYybuoJJOgLoxQKfxzhdXYwgC0EUCjuZ40v0FWWqBT9y6YUyf8t
         SfmogUSDLSbLzkqUsoe6oJa2ZgLkGqUJ2qh5eM0tCI7mqUNGfus3OUWY+XoE7gZxpRCV
         ruZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744649684; x=1745254484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9k3rOc3UZ1yvrH1piHMIhaWY9r9584cVJHbVmZZrIgA=;
        b=Xouq2kfwPD7ovzJWb6zUKgulOl8vLd+EfejdQWoNyk3P1xGZ95nOJsoi9qwGw1pDoZ
         udW+19e/TfI0mCrBSOeUp2gGMD+nVLIrpHPUG7NEUjqV8XNUGVKTWKNNCzjeOkJOccwi
         qDdBjnZuD461vCdxSsY71eNaeXlFfRtEof936tKFnBTgXlgQH0WDABt9Bx9KWTFHMtH5
         d0Vu0x5gW47lCBJWlV7A208k3QHqzmqHZU/MAmiYKh4HTfNNl8ZYeOOXQA7cmikeu1rg
         HiWkmKa6NS9yfLQxnOsnTD97KPP+A+TDkb3ApXqezY1mDcPTJlNgBcQsspOTQkeuXWpg
         Wljg==
X-Gm-Message-State: AOJu0YxXGJwC8muri3I29APf1Z3H6B8fgQPxV2i+cZd83WHNgd0MoDB5
	wr3/TVr5FqvOXLadv6tkzIQ7nBfybagflMzm7IL4KnQgZ+O4p/zqmlWq0QcG
X-Gm-Gg: ASbGnctoJ67hQYSWDy9CHo6xTmo0YEUAZvIbbq5hxrRauElDecdnLT/+A8tSKfESOc3
	y39UK6hKb6owco5GCEYdw0PnqHczBqNkoR3ShcVdTLv4HwckuoTWUQrT/94aSD5BDkvk1Bl9zxn
	L/pMh/akzwg6/LDVThn7qeTZbBUBmNE9qbfk1Xe9j9B8jt1E2FVi6QxzWD8xWeRxttUnOyaw6Jo
	VvwtxvRGYd+A5J0+2hRAivxZOMKvS1ltRksc7lmTEBAv42D/lcHmOfWkFIdQhOZLSSXgonZL/TE
	JZ1OxUPUweKPM8zb1i9f3k/OT60LadL5u2Mc3kNTBQKwME6yKr/FtHC0xt3CbsgekqLONBvgkEM
	52kQHYmcaAtLTH1VfmO9zk/hhBwogi7jkkFmfkp5I3KBy
X-Google-Smtp-Source: AGHT+IGaR9KhsjSg1nEVkF+xczH+2GtqFzDbZh5b/TSB+7P/t1D1u/tGbJbimtlB70VDVVQi/F6Jrg==
X-Received: by 2002:a17:90b:50ce:b0:2ee:aed6:9ec2 with SMTP id 98e67ed59e1d1-3082363a243mr23835991a91.14.1744649684028;
        Mon, 14 Apr 2025 09:54:44 -0700 (PDT)
Received: from harshads.c.googlers.com.com (121.61.83.34.bc.googleusercontent.com. [34.83.61.121])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-306dd1717cesm11543107a91.31.2025.04.14.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 09:54:43 -0700 (PDT)
From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	jack@suse.cz,
	harshads@google.com,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v8 1/9] ext4: convert i_fc_lock to spinlock
Date: Mon, 14 Apr 2025 16:54:08 +0000
Message-ID: <20250414165416.1404856-2-harshadshirwadkar@gmail.com>
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
index 5a20e9cd7184..79dfb57a7046 100644
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
index da4263a14a20..63859ec6d91d 100644
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
index 8122d4ffb3b5..2cf92657fdcd 100644
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
2.49.0.604.gff1f9ca942-goog


