Return-Path: <linux-ext4+bounces-9674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD8DB36EED
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3ED984798
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB40F3728A5;
	Tue, 26 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XpDFxbyd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A3372897
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222923; cv=none; b=K6QfSFdns1Ecmkdga59kdxM7aXD4uqWz79veiF91PSFjvZ2yFMn8gJjdWB+hu8uzwmEMCXx8Qruatzsc05+/KUqydoy4xksP7wmvcBDcs0DB3OY4ehvtgk4miD1C+j4vUTzt+9EeK3GEr43UuATvjl0SVi4c0TX6ELFKprFQCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222923; c=relaxed/simple;
	bh=x/P8Cjn6xKiJXGrsigp8xgvpHvnh9KytdZNfO6zYuv0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HynLiIgGqz61Wh2gKOnYhqsaNJoHhq1TVZuYqu+gNxEqnnjBxpl2v02ShcWJpFmELxlxLHb9jk2MD8nnMpuUUTY41qNLPBHvEDrg2XZis2tp0zMvgDK/J3XGqaKp9WA0eInnC48P8zSc00YC7lf/bHoU7CHhphcGtlurKZuPrac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XpDFxbyd; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96c77b8ff5so1849523276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222919; x=1756827719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/81j1YCnOxnHbfolqn0xMe1+eHodvsQacYEmtt2fzCc=;
        b=XpDFxbydrlhfwIQZOvJptQv2w8AH3/msxiKTOjc1/O/lOLxZnUAIPigzuikFjpSNua
         V9Hkg1XTyRcrazMvJAIdiWt2QT3LKu/45WdvMzmjnAALqin58+au/2YKZe66JUK+JVOS
         nVRy5oLUtxl4SUknXsK7SXozPKHISUBw67zthjZj/IVKv+ZO+WdN6oF02oAo9z4VMkaY
         wGA/MjD0Iflq6RMnl+enAzzbJd3oWf01bAShtK3Qudrs3VSMLwTT6YiqtSBcvMg2NXm1
         BTQEgiE9LnR+ZSlH4lh4Joy017AXkYjWKeMmki7V3wh6T3Tuw593bhtHKzpu089d6t7j
         BDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222919; x=1756827719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/81j1YCnOxnHbfolqn0xMe1+eHodvsQacYEmtt2fzCc=;
        b=Xp7lVki9ocCKODG96LRZIsJxNYwFZl6xAO0KK+CyH9J5+TEQHjbqWrzyaVqJpa9cJz
         kUDhINlfhsDdgmDFU3aWs0J7yWlFOTDFCw+4OrnfKuywmXvpGRVfZsr/iMIVsk672qhO
         gLbFJor6Gb1WDRAKTKjD3C4X/ydxcE4OMMlEyaaBYqWCxcR3nuG35Y7WQAMwJmi6qma0
         EofSrkwUoO3yfD9zZJc0e9OjpiDWBoAR3XkguMN9u8xLC9vTYg6VzQp8To/BRv1ejVDP
         9MpzvYrst8lMokAtC2/yuoszupA257nPn65jKhcKB+nYaLt2orUbO60kiqqTENCTeRw6
         kMsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3Er2F6y48cpvAVLbYInxcMjIIH6YK9c8aRKOVchj1bnaCC3lrGiJOZyPq7XWsMR6NZVvZcL639JNc@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7KS8JaAOHVzIMzDEFBveWBy939UTQRPufhYlnImBlYuMmiOe
	Hx3SHQnKhu7pMP4IZRQZ+iEGLVk9MVUulUZ1Hsox/+vxwgcZdiaAAlpbtY/Rd3PVm6g=
X-Gm-Gg: ASbGnctSLohsYaeeOAscLg66jUyzeXc03EKVmk0sL8AYUwznU+otZAKpAb8QftP0PuF
	3HzU6fW9pQrmkaJ61z5kCskrpb6cEokoQbuyONFA3Mgs2GAFv12O8UNvTB5smJlg/yJ7vKr8j1h
	UO82jvO/riAhPuzq+aaVE4CN3PksWKCd2Faz2Ady5WtuURMtAe4b5WJSlirEBKZy1A3lBbnyxKN
	5ZKdXG9sNeXpCVrI5VgFhXqQV393cVh1z86xdAR7EiJsLj+n4U5XBz4T1QQRvoxdgH2MeJO6Nn9
	VUHBWiWvhUZegU7W3LpCzK5h4vO4mCD1uBdrf+u3XmsI+4d+jwi8oiAbt4ewsoxYqkSeaAObKYJ
	hxy+nIhNMnwYvDUGQUxdVPHX/+8iX0OcuOx61LoSoFcA9Jq3zKQuQiT7LeF+hMju4HQ9McQ==
X-Google-Smtp-Source: AGHT+IEx9ifdcnJ6mvofN7F5PBW8h5lKAWe/5eS/sDxKyvd2J9YLXqDlzGvcoCWaDdRAub5TwP+68Q==
X-Received: by 2002:a05:6902:20ca:b0:e95:1ce2:5c77 with SMTP id 3f1490d57ef6-e951ce25df7mr19070918276.47.1756222919410;
        Tue, 26 Aug 2025 08:41:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96dbdb8453sm850596276.20.2025.08.26.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 48/54] fs: remove some spurious I_FREEING references in inode.c
Date: Tue, 26 Aug 2025 11:39:48 -0400
Message-ID: <da562975b6a07b1cc8341a6374ca82cd453d986c.1756222465.git.josef@toxicpanda.com>
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

Now that we have the i_count reference count rules set so that we only
go into these evict paths with a 0 count, update the sanity checks to
check that instead of I_FREEING.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index eb74f7b5e967..da38c9fbb9a7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -858,7 +858,7 @@ void clear_inode(struct inode *inode)
 	 */
 	xa_unlock_irq(&inode->i_data.i_pages);
 	BUG_ON(!list_empty(&inode->i_data.i_private_list));
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(icount_read(inode) != 0);
 	BUG_ON(inode->i_state & I_CLEAR);
 	BUG_ON(!list_empty(&inode->i_wb_list));
 	/* don't need i_lock here, no concurrent mods to i_state */
@@ -871,19 +871,19 @@ EXPORT_SYMBOL(clear_inode);
  * to. We remove any pages still attached to the inode and wait for any IO that
  * is still in progress before finally destroying the inode.
  *
- * An inode must already be marked I_FREEING so that we avoid the inode being
+ * An inode must already have an i_count of 0 so that we avoid the inode being
  * moved back onto lists if we race with other code that manipulates the lists
  * (e.g. writeback_single_inode). The caller is responsible for setting this.
  *
  * An inode must already be removed from the LRU list before being evicted from
- * the cache. This should occur atomically with setting the I_FREEING state
- * flag, so no inodes here should ever be on the LRU when being evicted.
+ * the cache. This should always be the case as the LRU list holds an i_count
+ * reference on the inode, and we only evict inodes with an i_count of 0.
  */
 static void evict(struct inode *inode)
 {
 	const struct super_operations *op = inode->i_sb->s_op;
 
-	BUG_ON(!(inode->i_state & I_FREEING));
+	BUG_ON(icount_read(inode) != 0);
 	BUG_ON(!list_empty(&inode->i_lru));
 
 	if (!list_empty(&inode->i_io_list))
@@ -897,8 +897,8 @@ static void evict(struct inode *inode)
 	/*
 	 * Wait for flusher thread to be done with the inode so that filesystem
 	 * does not start destroying it while writeback is still running. Since
-	 * the inode has I_FREEING set, flusher thread won't start new work on
-	 * the inode.  We just have to wait for running writeback to finish.
+	 * the inode has a 0 i_count, flusher thread won't start new work on the
+	 * inode.  We just have to wait for running writeback to finish.
 	 */
 	inode_wait_for_writeback(inode);
 	spin_unlock(&inode->i_lock);
-- 
2.49.0


