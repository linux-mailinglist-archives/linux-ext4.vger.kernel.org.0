Return-Path: <linux-ext4+bounces-9638-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280B7B36E29
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806721BA8C68
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED4435AABC;
	Tue, 26 Aug 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="GNCRS63J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B403356904
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222873; cv=none; b=lMkBinUvgGvE5swbWbnDdatU48NAqTJ/95McPbAV/vNHsJvmVmMOiAGZTbDvbkViQEQjoU4Poqk6s/v3J8tZ9Cltd96GRcgvo6iupw2/DHICUu6pgOHm5Y4QDuVsXZEMGBC5FacxVKSUeLBFJ+I1ODdd/MJGgFd02jQFKKKIxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222873; c=relaxed/simple;
	bh=K/2E6jJOHKbiBNVw4qyhmvX0VNRB3Q1kRWjPnsEz6Qs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjYD7HdyerzJDJvSSE/NVZGe4Ich4RqScZxaU+3Ng4ukrppVV4a9MdVF2iqe5GPTqfbGKu/rT+CBHwVkX5RTURww3+7QZtdor751yMStxw/50ENeOq4eeLg+8ZlRdabEseXrSWxmpYBnsC4zgLHp6FYo/5S5E6sqo/JK2dca7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=GNCRS63J; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d605a70bdso37815527b3.3
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222867; x=1756827667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=GNCRS63J8a9NYmPb/q/1ShkfAfOSsgSqU7FjkpR5hdwPXCuDb/O7olFpxJAurLh7ja
         NFPV5bFN8GZFLBrDuGNaCH29F49cn2mEFXR3DMv0SWcf5ZghO0wbjAbeHvbll3C3VMC+
         cWpR5G/B9VOQsxob+no7avnfUlFBiU7nGvqYTe02GdABSzgAqmkV/izBk5L90W7k7iOr
         vLpbS2kdPwC76UrRTtxMlDiCaHzxN+M4+BPYtSQq8yVp7PYeZQmkceIpzug/pLRsVzbW
         ue6TjDDpEyqyCc3P2VaKxEK4NG1ip70Aephv2CKEENOjxXqv5PFoXhyeCRFKr2A2Kt2J
         eGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222867; x=1756827667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3dSZ2phmUuD6/YyE9yBKEL4BgEi76aqZtdAMW8+MgI=;
        b=D2yEB10+jAAMNv0DRQvKPte0gVzkAtFncDMPA9QTSy1M/Q6O8MKKcb/ssxNjrpv6zz
         VDZAeZ79Yodrdb+ZLXsIUc7iHhqwd6aaJGTMvy81r0G1GWDxA76B1/scBlVr0di7PIwP
         rfOoV9yG48Zt73pRl8oDdI+/fxNLdi11TmNGGZQA9Ev98P9q9GayuiLUzSc3tITZ+3dJ
         p0UhQKsvhTIEQ/EARZti9ZTDj5e8CCO8ePQRtPHXTFlnaDn507idAQc9LU46o19IAuYA
         /lSdFQchExrgu6c8MS2odQs4RnEFUKfvDs/jc24OOWkHmKMQD4/ob8IDKUqKR1v7POLj
         N58g==
X-Forwarded-Encrypted: i=1; AJvYcCUaWQMP4yyE7UrgrclAkatidZc5F99+qf2TYMAp2RdpJX9eJ2WyLcS3N1sThVtcXsDrzuMaefh7iUNw@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqH/En/TOp/ws8tbFQq3Hwgw2Jryf843eL6ut4gEX5rsUG25B
	nj7N27R/uhXf4OBldEAHIJ3+MAE6ppVlS3hNq9n9XtzakqAscgFYxqhEKuatE5VngwU=
X-Gm-Gg: ASbGnctqP8bbkiKkS22kLXQMlgbcluh5VvgaOWznWnhs9N7FGMORAwN7wutYxEbubOv
	htx/AeBxtQpWCr1uBobWWU1ytKAezTALObPMADv58eGNA0pYboqo24eEYg6zfO3gezXOBqXYIc6
	h92UM+v5yMrDbz9tE/qIwgM18pSsU75yLz+bGMr5QleYxOT12N9gR1aHGLJIFqGbHiGYMrPTiZX
	mUfuvLnPNSZiKZdf8Spfmmw5eRQdlRdcdaZ9Y9DDhRHEf6xZRL/LF8uYbXjZl2PMwadAH9fTm7D
	9m5/dKKr0iXQwd8wwrc+Wc9M/p6gRU6AcjN/cNl5Fs7oU3KMxugW9azG8mW6f4YCOVcozjLPZMD
	4CmMsIXqWx6YoIWmY2q25CYgkf7cYttDch+bauoGXZIykvXNTpEHUTgCAqUY=
X-Google-Smtp-Source: AGHT+IHgXLWIa08EKF5iBQbTPMW+F15MA8jv2gb9313joQGOaaJYJEPu1PArCNZdnFyQDIVStDqfzA==
X-Received: by 2002:a05:690c:c1a:b0:719:4421:70b2 with SMTP id 00721157ae682-71fdc2e0f12mr177717567b3.18.1756222867429;
        Tue, 26 Aug 2025 08:41:07 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff6edd00fsm22874937b3.10.2025.08.26.08.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 13/54] fs: hold an i_obj_count when we have an i_count reference
Date: Tue, 26 Aug 2025 11:39:13 -0400
Message-ID: <62383d1029eca5053a2fa320ae51f407c9ae2896.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the start of the semantic changes of inode lifetimes.
Unfortunately we have to do two things in one patch to be properly safe,
but this is the only case where this happens.

First we take and drop an i_obj_count reference every time we get an
i_count reference.  This is because we will be changing the i_count
reference to be the indicator of a "live" inode.

The second thing we do is move the life time of the memory allocation
for the inode under the control of the i_obj_count reference.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c   |  4 +++-
 fs/fs-writeback.c  |  2 --
 fs/inode.c         | 28 +++++++++-------------------
 include/linux/fs.h |  1 +
 4 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ac00554e8479..e16df38e0eef 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3418,8 +3418,10 @@ void btrfs_add_delayed_iput(struct btrfs_inode *inode)
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	unsigned long flags;
 
-	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1))
+	if (atomic_add_unless(&inode->vfs_inode.i_count, -1, 1)) {
+		iobj_put(&inode->vfs_inode);
 		return;
+	}
 
 	WARN_ON_ONCE(test_bit(BTRFS_FS_STATE_NO_DELAYED_IPUT, &fs_info->fs_state));
 	atomic_inc(&fs_info->nr_delayed_iputs);
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 773b276328ec..b83d556d7ffe 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2736,7 +2736,6 @@ static void wait_sb_inodes(struct super_block *sb)
 			continue;
 		}
 		__iget(inode);
-		iobj_get(inode);
 		spin_unlock(&inode->i_lock);
 		rcu_read_unlock();
 
@@ -2750,7 +2749,6 @@ static void wait_sb_inodes(struct super_block *sb)
 		cond_resched();
 
 		iput(inode);
-		iobj_put(inode);
 
 		rcu_read_lock();
 		spin_lock_irq(&sb->s_inode_wblist_lock);
diff --git a/fs/inode.c b/fs/inode.c
index b146b37f7097..ddaf282f7c25 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -527,6 +527,7 @@ static void init_once(void *foo)
  */
 void ihold(struct inode *inode)
 {
+	iobj_get(inode);
 	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
 }
 EXPORT_SYMBOL(ihold);
@@ -843,13 +844,6 @@ static void evict(struct inode *inode)
 	 */
 	inode_wake_up_bit(inode, __I_NEW);
 	BUG_ON(inode->i_state != (I_FREEING | I_CLEAR));
-
-	/*
-	 * refcount_dec_and_test must be used here to avoid the underflow
-	 * warning.
-	 */
-	WARN_ON(!refcount_dec_and_test(&inode->i_obj_count));
-	destroy_inode(inode);
 }
 
 /*
@@ -867,16 +861,8 @@ static void dispose_list(struct list_head *head)
 		inode = list_first_entry(head, struct inode, i_lru);
 		list_del_init(&inode->i_lru);
 
-		/*
-		 * This is going right here for now only because we are
-		 * currently not using the i_obj_count reference for anything,
-		 * and it needs to hit 0 when we call evict().
-		 *
-		 * This will be moved when we change the lifetime rules in a
-		 * future patch.
-		 */
-		iobj_put(inode);
 		evict(inode);
+		iobj_put(inode);
 		cond_resched();
 	}
 }
@@ -1943,8 +1929,10 @@ void iput(struct inode *inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
 
-	if (atomic_add_unless(&inode->i_count, -1, 1))
+	if (atomic_add_unless(&inode->i_count, -1, 1)) {
+		iobj_put(inode);
 		return;
+	}
 
 	if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
 		trace_writeback_lazytime_iput(inode);
@@ -1958,6 +1946,7 @@ void iput(struct inode *inode)
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
+	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
 
@@ -1965,13 +1954,14 @@ EXPORT_SYMBOL(iput);
  *	iobj_put	- put a object reference on an inode
  *	@inode: inode to put
  *
- *	Puts a object reference on an inode.
+ *	Puts a object reference on an inode, free's it if we get to zero.
  */
 void iobj_put(struct inode *inode)
 {
 	if (!inode)
 		return;
-	refcount_dec(&inode->i_obj_count);
+	if (refcount_dec_and_test(&inode->i_obj_count))
+		destroy_inode(inode);
 }
 EXPORT_SYMBOL(iobj_put);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 84f5218755c3..023ad47685be 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3381,6 +3381,7 @@ static inline unsigned int iobj_count_read(const struct inode *inode)
  */
 static inline void __iget(struct inode *inode)
 {
+	iobj_get(inode);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.49.0


