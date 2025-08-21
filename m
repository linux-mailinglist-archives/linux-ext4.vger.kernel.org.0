Return-Path: <linux-ext4+bounces-9512-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508DB30602
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2E877A14C2
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D773128AA;
	Thu, 21 Aug 2025 20:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="mQ1e+6TL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6B38B66D
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807636; cv=none; b=j5b1o/5JL3oteAz8/37zykN/Wihi1G3/kWE9z0IDrYlxqK4rnOGT7MgDrgTFSx7NTKSx+4tTILlGA1cgnt+YhVgB4GrX3JuH9LKemzVQXgivTM3iHgyEyqfWXZOYUyPJebXfjOeJ9TUsxCna17yNwM3D/nutI8mB9/qALydFeik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807636; c=relaxed/simple;
	bh=k08C8v+dbri2Td95rFSblahs5058v4x4Pk8rcv0fBIU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvLYbbw3wgek3dUvy7NwEpgOuBY3bP36gU7dYUcidrMfmd2qlWXpaDI0Tg/lX8BckKbcXAy7xyH8GiCshBnLIHFKsoxhCEvz1KzJsPfurrc022Dar75xZoNLI0ith5GIAz3Y3pT954QyJGSd79+AQAGRCPtP7JuaGq30B9s3uxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=mQ1e+6TL; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e933af9f8b5so1148148276.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807632; x=1756412432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1kpIKHN/ijHuvWafJ0jJ7li2TFJSTYw3gzfhNZtJgk=;
        b=mQ1e+6TLE7QVd89PjmHqFK+sa8azvf4fGwngHCjwbUGrQIyZ18C7n9JlQWSKPUipp7
         OreE26cEjc++5/SoaDO+nzUxDVodQE1uzWOgbowA1/NzKN3cnQH0JEahXSgeCFsBmsDi
         XEvzfgsaJN8IuCnbyTGSZfcOPQ+uyQnceu4uXa9DK5NtvZDSpMa6qakDI6fsNgUzC9gp
         OgAjg94TL1qa8uUREv/cpmNOOzVgV9NDBU7r+rpLQt609LRD+z9NBWRQLNlHbnMo4/cj
         NWnb9OgL/AAZEeTNB7x919t7+Hos8Zk2xgyUXpsKC27X8u4MFjgUXkE1jvKUa18RAoZN
         aXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807632; x=1756412432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1kpIKHN/ijHuvWafJ0jJ7li2TFJSTYw3gzfhNZtJgk=;
        b=fxAKmD8GB6ULPBbi0hUq5KUP7DFx8F2fNsgE5jQAAqzOOfr+XRbmzAREkR8JjOBkAD
         qd1FkoULKlTBDbxIZ9nFffz231muQ9x4LCiQ0HXITpE2TRKC021PeJOXkBTkYo23tDa+
         7d8DsygFUvNNWXerAM0a6lXj4J+sH3V+IJVZHzo3ZKGIH+rZzO4ZwDY34DQjwjZRLoWX
         XEwpdMM9Q+8crb3tnppXz1cAlGDDttTnKBXsQ7lIImja28jd8WNV8yXViwiA+KFE3Z7F
         YimQVdLUvruOe339ZTUYqOCTAkct9geAimU1IGlrLDbrd2ieWJT6w+UISnQW2Ja3KvAz
         zC/g==
X-Forwarded-Encrypted: i=1; AJvYcCXBtiOq3b0frE4FuQQGgSERJ7GZ9F9yXktXMrEuvn9JMG7ps+CnrfAYk5/GCFDSngUNK9Y7ydQ8i/eU@vger.kernel.org
X-Gm-Message-State: AOJu0YxaYL/0z4Qo7ImBs8ZTDj4QhKege4JxYOGeDU6UspqUObCmv4KS
	g6Y/rSOZ+p9tEZU0PRpHkbjXqD3/VwxUKh6Vg5hnzqHBn/g55DNYi2O34QNQPnM5tB8=
X-Gm-Gg: ASbGnctKC/C/VpQSpnkSCHCd/J97V7PG+7Y6M5erwq9/lr7fWo8MqcGM7dbPeruSFnO
	PdcZ7usJzbWhFvw/FsvQC4bNmVo/C+OzPIZgIWRtLkPrueL7aErheSO8tfeNAwF1idf+kc/6D4E
	OUEeyshv3cYyjP8jLSOHExQ0DD2p1B4CoONEkJlDMbHywS7Z3uIYSzPFU1gQmk21HvL7v8vxQ1W
	2izhM5Jmgd/oEFSHqzKqvdhJe7G4/Dv/E1z+vYV6ED1DOiHcQRLWylyaXxi4wJlvJGIvrzwJEal
	njiMyUbGdJaG1wb+o3rM2uMDKvx0eigC+uAfYYgEi3Y4rXC0tJZJ8O0CnArWiepnXm3ZcEEQPkk
	EjL8m63mL66Z3nJEnf/6pq18J0EIk2tR/nhpJpytNNDmK6M1/Sw081aKDm7mILCeXva3qfA==
X-Google-Smtp-Source: AGHT+IHUz11rC+SEDiUMFpURAl6bZ0Q/kqeBOcps7ePJ17GgLV0wAujubaZOcSSL45YNyD4XEPUBLQ==
X-Received: by 2002:a05:6902:3309:b0:e91:7c31:f70f with SMTP id 3f1490d57ef6-e951c32c9b3mr867244276.29.1755807631868;
        Thu, 21 Aug 2025 13:20:31 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e94df639cbbsm3261267276.36.2025.08.21.13.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 11/50] fs: hold an i_obj_count when we have an i_count reference
Date: Thu, 21 Aug 2025 16:18:22 -0400
Message-ID: <af798c04abfb7e25ced350a451bd80c031fc11a6.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
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
 fs/inode.c         | 29 +++++++++++------------------
 include/linux/fs.h |  1 +
 4 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 784bd48b4da9..bbbcd96e8f5c 100644
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
index 2b0d26a58a5a..d2e1fb1a0787 100644
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
index 12e2e01aae0c..16acad5583fc 100644
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
@@ -1945,6 +1931,11 @@ void iput(struct inode *inode)
 retry:
 	if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
 		if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
+			/*
+			 * Increment i_count directly as we still have our
+			 * i_obj_count reference still. This is temporary and
+			 * will go away in a future patch.
+			 */
 			atomic_inc(&inode->i_count);
 			spin_unlock(&inode->i_lock);
 			trace_writeback_lazytime_iput(inode);
@@ -1953,6 +1944,7 @@ void iput(struct inode *inode)
 		}
 		iput_final(inode);
 	}
+	iobj_put(inode);
 }
 EXPORT_SYMBOL(iput);
 
@@ -1960,13 +1952,14 @@ EXPORT_SYMBOL(iput);
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
index e741dc453c2c..b2048fd9c300 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3381,6 +3381,7 @@ static inline void iobj_get(struct inode *inode)
  */
 static inline void __iget(struct inode *inode)
 {
+	iobj_get(inode);
 	atomic_inc(&inode->i_count);
 }
 
-- 
2.49.0


