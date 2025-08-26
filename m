Return-Path: <linux-ext4+bounces-9626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C031FB36E01
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF81BA81CA
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01A31985B;
	Tue, 26 Aug 2025 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="YiATo+JU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B972D0C69
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222853; cv=none; b=HrzWIthGgcLl2d2bd5ZI8J2VeAiFwFzXtc/L57VPzP44tlpygfkXdy0zHEIbBWtjrMyFDM4FrUKJuhPdoho0OehxSXhoO7AgvBfhBZJseTbsvDgIT/Ps+o1Gz6yFUQ7OdFe/QQw6yq5aFNieEKTWQZV2yC/yB8nqRxNYWFvHspo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222853; c=relaxed/simple;
	bh=rhD29TyBwq8h5qo5u2gy7an6xEg51+mBGdnf4yae6Ck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSsWAMGPc8alGW5wG8+boQSomjmud9NWPUQo0OcYhYzBNhB0VpCg1nS62wRgFGhIFX+YfPMwi6ODKuSlF/aDP0yDicoeFK33W+B4oCgQ1M1bjx2jstFIgysxp6Aqa+fUnpfCvU8lsZo9c8aYXbp4WsmmQ/XIKJHnKkUQjs0DTFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=YiATo+JU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d60150590so42811617b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222850; x=1756827650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDlvag/bPvz3/QR0n8WmjEY1g52KVkFo1GIvqXUN9Rw=;
        b=YiATo+JUfytMdwA5XJ1U10h1LZSNW/azQhDqlKV0CNKaRGehvSGH8FVygauYcrQ19a
         m3SgAQG7rp/KY5lD3vtAbTqMv2D7BbQOFbPUUGUGqemY3f/BoAGfULPrzGXwrYFQaf5r
         rhRx2qTRj4+j2gRyqjhtwU3koxXqMnE8D/I2jgANz3ZRFpGj/0sDS65B2QSVUReSX9Ij
         vs76oczoPqWpcgsHWRilF75lS9KU7Q0ZlaU1njjg42OZ0HpkY6hsE4rhWuS2YBLD99Yo
         BvEgME3T1GR/KlF4+Q8B2uYq8sWK+LuUQMt/bWzL7CfzmF0ku6qalkak6SYEMBi+gU23
         67FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222850; x=1756827650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDlvag/bPvz3/QR0n8WmjEY1g52KVkFo1GIvqXUN9Rw=;
        b=Sx4cLgtmDQqjj0/q9iiWtLmlXO2oLjb9G5vAeLgmmN5slgrhmFNJDKshddA/DhIvtn
         sMGFS4RryxZj1tTfVgWCp/mzpyRCHjJffEdZKH9/9zMKocAamlMFfY3u78Xpo+y1Qkbj
         IQSQgHJm4xprGwmEpeUUqhVAh/9Gx1pGVNNvdHXHqR3tWjwn9Zr0eznrQUrtZ1pQi5Dh
         W1xOTXHx7zqQnRdsBUiNXrAsyevq92XCufY7tJu6765i8QEJXORrGMtZCu7TKCQjCeCA
         cCfZFFSHkbLbZzpzHS8Pt2lpdkQCPVXD2tlsCdn5htijusGoPLmCxAvoxhjqYL5nw56p
         8NBg==
X-Forwarded-Encrypted: i=1; AJvYcCXbF10ll/pdQ9hIJpgN4tDMrv+0zSbNNVtlm2XN5ARMlfAG2RXbSYQzNNaQR6Z6yCo6+rHjNM1GUfmT@vger.kernel.org
X-Gm-Message-State: AOJu0YxeHF9ZrU7xFitRlgEPr0XORI3jvwjTHp8ayEtugp7geauKm7I+
	8PPndD23s3QmQGeilfx21bX7cLeVeb1xHqrD53Wt3OOLCmaMm+3fKVr33gNqCwSR+8Cqb/6ZMNZ
	MW8td
X-Gm-Gg: ASbGnctYzPVWOM0Q3YcYW+fG0ThBa6epJWxfjg4/XUse+5CxkA7pgy7kN+tzLagSdbN
	8B9FumdvlpI54pqZPB5tEaw0CgAaIm/N4PvxlPHoAj2U/tTBVXnuvrUP6fIHW3ask7BfaCeTOmr
	0M+BlErY6f5ABo3PI6EZyX/ZLsXtmb8LehzXExZff4Vm12fZiYUzy/sMjb3rqaCb0g1VUcFwaiD
	SLYQFGwCrIEnA9DdGVv8DlAARdDeEya2vCX2/UURWfMRL8xErNRxmRFhcYB801F9yxi2Eg5/m92
	TN+Kn4I4rHUaieMLq/9hTyae7XWCPETkaVQghZdXr6nkDGn0p8v9ezROYfDZnwSjTUmmmkQ9wGa
	cww+zE+h9HHtnnY83f7AndiyIwK2/NEKaGFEixAa6L6afCKfsMQMw5jbyeoU=
X-Google-Smtp-Source: AGHT+IH6rdzr5te8aZJDcRA9VKu/Q+xG9a1l6FFd6fjOKS/W/rnmjxFWmlWnyD1bFZbkl+J1artcuQ==
X-Received: by 2002:a05:690c:7344:b0:71f:b944:1053 with SMTP id 00721157ae682-71fdc56bd1fmr188007007b3.54.1756222849495;
        Tue, 26 Aug 2025 08:40:49 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7211b2d1d4esm9733057b3.52.2025.08.26.08.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:48 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 01/54] fs: make the i_state flags an enum
Date: Tue, 26 Aug 2025 11:39:01 -0400
Message-ID: <0da9348da6ece0dce12fccec07b1dd2b8e4cfdab.1756222464.git.josef@toxicpanda.com>
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

Adjusting i_state flags always means updating the values manually. Bring
these forward into the 2020's and make a nice clean macro for defining
the i_state values as an enum, providing __ variants for the cases where
we need the bit position instead of the actual value, and leaving the
actual NAME as the 1U << bit value.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 229 +++++++++++++++++++++++----------------------
 1 file changed, 117 insertions(+), 112 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index a346422f5066..3dbaf1ca1828 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -665,6 +665,122 @@ is_uncached_acl(struct posix_acl *acl)
 #define IOP_MGTIME	0x0020
 #define IOP_CACHED_LINK	0x0040
 
+/*
+ * Inode state bits.  Protected by inode->i_lock
+ *
+ * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
+ * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
+ *
+ * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
+ * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
+ * various stages of removing an inode.
+ *
+ * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
+ *
+ * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
+ *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
+ *			Timestamp updates are the usual cause.
+ * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
+ *			these changes separately from I_DIRTY_SYNC so that we
+ *			don't have to write inode on fdatasync() when only
+ *			e.g. the timestamps have changed.
+ * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
+ * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
+ *			lazytime mount option is enabled.  We keep track of this
+ *			separately from I_DIRTY_SYNC in order to implement
+ *			lazytime.  This gets cleared if I_DIRTY_INODE
+ *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
+ *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
+ *			in place because writeback might already be in progress
+ *			and we don't want to lose the time update
+ * I_NEW		Serves as both a mutex and completion notification.
+ *			New inodes set I_NEW.  If two processes both create
+ *			the same inode, one of them will release its inode and
+ *			wait for I_NEW to be released before returning.
+ *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
+ *			also cause waiting on I_NEW, without I_NEW actually
+ *			being set.  find_inode() uses this to prevent returning
+ *			nearly-dead inodes.
+ * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
+ *			is zero.  I_FREEING must be set when I_WILL_FREE is
+ *			cleared.
+ * I_FREEING		Set when inode is about to be freed but still has dirty
+ *			pages or buffers attached or the inode itself is still
+ *			dirty.
+ * I_CLEAR		Added by clear_inode().  In this state the inode is
+ *			clean and can be destroyed.  Inode keeps I_FREEING.
+ *
+ *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
+ *			prohibited for many purposes.  iget() must wait for
+ *			the inode to be completely released, then create it
+ *			anew.  Other functions will just ignore such inodes,
+ *			if appropriate.  I_NEW is used for waiting.
+ *
+ * I_SYNC		Writeback of inode is running. The bit is set during
+ *			data writeback, and cleared with a wakeup on the bit
+ *			address once it is done. The bit is also used to pin
+ *			the inode in memory for flusher thread.
+ *
+ * I_REFERENCED		Marks the inode as recently references on the LRU list.
+ *
+ * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
+ *			synchronize competing switching instances and to tell
+ *			wb stat updates to grab the i_pages lock.  See
+ *			inode_switch_wbs_work_fn() for details.
+ *
+ * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
+ *			and work dirs among overlayfs mounts.
+ *
+ * I_CREATING		New object's inode in the middle of setting up.
+ *
+ * I_DONTCACHE		Evict inode as soon as it is not used anymore.
+ *
+ * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
+ *			Used to detect that mark_inode_dirty() should not move
+ *			inode between dirty lists.
+ *
+ * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
+ *
+ * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
+ *			i_count.
+ *
+ * Q: What is the difference between I_WILL_FREE and I_FREEING?
+ *
+ * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
+ * upon. There's one free address left.
+ */
+
+enum inode_state_bits {
+	__I_NEW			= 0U,
+	__I_SYNC		= 1U,
+	__I_LRU_ISOLATING	= 2U
+};
+
+enum inode_state_flags_t {
+	I_NEW			= (1U << __I_NEW),
+	I_SYNC			= (1U << __I_SYNC),
+	I_LRU_ISOLATING         = (1U << __I_LRU_ISOLATING),
+	I_DIRTY_SYNC		= (1U << 3),
+	I_DIRTY_DATASYNC	= (1U << 4),
+	I_DIRTY_PAGES		= (1U << 5),
+	I_WILL_FREE		= (1U << 6),
+	I_FREEING		= (1U << 7),
+	I_CLEAR			= (1U << 8),
+	I_REFERENCED		= (1U << 9),
+	I_LINKABLE		= (1U << 10),
+	I_DIRTY_TIME		= (1U << 11),
+	I_WB_SWITCH		= (1U << 12),
+	I_OVL_INUSE		= (1U << 13),
+	I_CREATING		= (1U << 14),
+	I_DONTCACHE		= (1U << 15),
+	I_SYNC_QUEUED		= (1U << 16),
+	I_PINNING_NETFS_WB	= (1U << 17)
+};
+
+#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
+#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
+#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
+
 /*
  * Keep mostly read-only and often accessed (especially for
  * the RCU path lookup and 'stat' data) fields at the beginning
@@ -723,7 +839,7 @@ struct inode {
 #endif
 
 	/* Misc */
-	u32			i_state;
+	enum inode_state_flags_t	i_state;
 	/* 32-bit hole */
 	struct rw_semaphore	i_rwsem;
 
@@ -2483,117 +2599,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 	};
 }
 
-/*
- * Inode state bits.  Protected by inode->i_lock
- *
- * Four bits determine the dirty state of the inode: I_DIRTY_SYNC,
- * I_DIRTY_DATASYNC, I_DIRTY_PAGES, and I_DIRTY_TIME.
- *
- * Four bits define the lifetime of an inode.  Initially, inodes are I_NEW,
- * until that flag is cleared.  I_WILL_FREE, I_FREEING and I_CLEAR are set at
- * various stages of removing an inode.
- *
- * Two bits are used for locking and completion notification, I_NEW and I_SYNC.
- *
- * I_DIRTY_SYNC		Inode is dirty, but doesn't have to be written on
- *			fdatasync() (unless I_DIRTY_DATASYNC is also set).
- *			Timestamp updates are the usual cause.
- * I_DIRTY_DATASYNC	Data-related inode changes pending.  We keep track of
- *			these changes separately from I_DIRTY_SYNC so that we
- *			don't have to write inode on fdatasync() when only
- *			e.g. the timestamps have changed.
- * I_DIRTY_PAGES	Inode has dirty pages.  Inode itself may be clean.
- * I_DIRTY_TIME		The inode itself has dirty timestamps, and the
- *			lazytime mount option is enabled.  We keep track of this
- *			separately from I_DIRTY_SYNC in order to implement
- *			lazytime.  This gets cleared if I_DIRTY_INODE
- *			(I_DIRTY_SYNC and/or I_DIRTY_DATASYNC) gets set. But
- *			I_DIRTY_TIME can still be set if I_DIRTY_SYNC is already
- *			in place because writeback might already be in progress
- *			and we don't want to lose the time update
- * I_NEW		Serves as both a mutex and completion notification.
- *			New inodes set I_NEW.  If two processes both create
- *			the same inode, one of them will release its inode and
- *			wait for I_NEW to be released before returning.
- *			Inodes in I_WILL_FREE, I_FREEING or I_CLEAR state can
- *			also cause waiting on I_NEW, without I_NEW actually
- *			being set.  find_inode() uses this to prevent returning
- *			nearly-dead inodes.
- * I_WILL_FREE		Must be set when calling write_inode_now() if i_count
- *			is zero.  I_FREEING must be set when I_WILL_FREE is
- *			cleared.
- * I_FREEING		Set when inode is about to be freed but still has dirty
- *			pages or buffers attached or the inode itself is still
- *			dirty.
- * I_CLEAR		Added by clear_inode().  In this state the inode is
- *			clean and can be destroyed.  Inode keeps I_FREEING.
- *
- *			Inodes that are I_WILL_FREE, I_FREEING or I_CLEAR are
- *			prohibited for many purposes.  iget() must wait for
- *			the inode to be completely released, then create it
- *			anew.  Other functions will just ignore such inodes,
- *			if appropriate.  I_NEW is used for waiting.
- *
- * I_SYNC		Writeback of inode is running. The bit is set during
- *			data writeback, and cleared with a wakeup on the bit
- *			address once it is done. The bit is also used to pin
- *			the inode in memory for flusher thread.
- *
- * I_REFERENCED		Marks the inode as recently references on the LRU list.
- *
- * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
- *			synchronize competing switching instances and to tell
- *			wb stat updates to grab the i_pages lock.  See
- *			inode_switch_wbs_work_fn() for details.
- *
- * I_OVL_INUSE		Used by overlayfs to get exclusive ownership on upper
- *			and work dirs among overlayfs mounts.
- *
- * I_CREATING		New object's inode in the middle of setting up.
- *
- * I_DONTCACHE		Evict inode as soon as it is not used anymore.
- *
- * I_SYNC_QUEUED	Inode is queued in b_io or b_more_io writeback lists.
- *			Used to detect that mark_inode_dirty() should not move
- * 			inode between dirty lists.
- *
- * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
- *
- * I_LRU_ISOLATING	Inode is pinned being isolated from LRU without holding
- *			i_count.
- *
- * Q: What is the difference between I_WILL_FREE and I_FREEING?
- *
- * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses to wait
- * upon. There's one free address left.
- */
-#define __I_NEW			0
-#define I_NEW			(1 << __I_NEW)
-#define __I_SYNC		1
-#define I_SYNC			(1 << __I_SYNC)
-#define __I_LRU_ISOLATING	2
-#define I_LRU_ISOLATING		(1 << __I_LRU_ISOLATING)
-
-#define I_DIRTY_SYNC		(1 << 3)
-#define I_DIRTY_DATASYNC	(1 << 4)
-#define I_DIRTY_PAGES		(1 << 5)
-#define I_WILL_FREE		(1 << 6)
-#define I_FREEING		(1 << 7)
-#define I_CLEAR			(1 << 8)
-#define I_REFERENCED		(1 << 9)
-#define I_LINKABLE		(1 << 10)
-#define I_DIRTY_TIME		(1 << 11)
-#define I_WB_SWITCH		(1 << 12)
-#define I_OVL_INUSE		(1 << 13)
-#define I_CREATING		(1 << 14)
-#define I_DONTCACHE		(1 << 15)
-#define I_SYNC_QUEUED		(1 << 16)
-#define I_PINNING_NETFS_WB	(1 << 17)
-
-#define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
-#define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-#define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
-
 extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)
 {
-- 
2.49.0


