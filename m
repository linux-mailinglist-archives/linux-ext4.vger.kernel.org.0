Return-Path: <linux-ext4+bounces-9632-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B20B36E1B
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101EE36482F
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A82350825;
	Tue, 26 Aug 2025 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xGobScvO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6D34F499
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222861; cv=none; b=V3JlF+ZxHcSDHfsc5zVd1x51/i/aebUjMhNLN5/Cw6X5FmqsrPzOAr3VtRF3JA+LTZ5VBUCXsA9UwqIZwwY7lxqjhYVNQ/pRVWs3FB4+Ld90cbUQdFTJ9Kz4raQqRLwGBK04zj6OWDD/sXm4vbgE8t8DfOuQtvDReBCYSoHoe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222861; c=relaxed/simple;
	bh=LR7CWXTHq8PxRLgtCmpwYh94UJBJq3AtMLa8nfpVhLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX1Slg7g+ZvsFnYJruhsUTw314GbeYoQ4W2F5Bppy6Px2rS+Gq4mLMaMbrz4vLlNkR0e8qDdOZg9Fi0Mfj4TKg4aDdfa8IRPcLdBsCBtlT7/iOZPphjRe2x5q8jKsA/PzcwDIPeDh54KLmGPx4Vb0Cc8x8TTsZZ5t9v4IsP0GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xGobScvO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60110772so49939447b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222859; x=1756827659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/a4qa/ANgmJB/A00Ci0w/v1yDlD4/6YZQSFqLG2Lykw=;
        b=xGobScvOKjFNjNtKVJ0YWqAXe7M8eSOgx724pEAloiCi1mWxhUIIOC3Bl5UaHcG8Hs
         o5BghR8D7F0/QjZGTPfylyv5nNhYVtglMrwbgdW5fRWq78SLj4kiUc8Dyvu6K/9busW7
         3EuWM3z4+Kyqpao0qjGV69K1GI6tTVR9lXxo7ozCJPICP88baqyw+oN5uSvyD5vRQ82U
         orTQsqnS03EwprlaGHU0TDwqIKGCZ7FluJdpfk+jjsWNKArT9YtpOyv9R+DmoVGfRdKa
         nD0J9Ej5bEp9bnI+kS1RW8OD756lKLyh133p948mm3NZjFo0t/xTm8T9bM+Iq8VbOqnA
         7IWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222859; x=1756827659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a4qa/ANgmJB/A00Ci0w/v1yDlD4/6YZQSFqLG2Lykw=;
        b=qjuy/lj2oNg+MV7ygNVbn8QebFcBQm/58a7Eob8OLxY7pEMSCjuHmxfktmamdRiCrV
         rG3hwbmN1EF+Q/WpVPFizTK9d3ZDScoaG0XA3wYbwfSQiPYfMgXbPtY504Y+rpRZYgUi
         uNL/6TCfEx8Dqp/plN//DYHdonAkfJ+xJf5xnFmYbv9XCr/cTjkax3fpNvhdtD+D9TTv
         lmL6+hWOFvzZGCutpZBGC7vA62TVJwvBZMSSvbUZcwZwveJkEklDeSuL2fHc7T7OC1eE
         4wc9ABCorf668xdZ/fsJ9vVstGQur2BQ4HMGfaZc3fwNhhlza7TctdBL2kNcpPksuHCP
         nQ/g==
X-Forwarded-Encrypted: i=1; AJvYcCWqumUSbQmQa+oky8FcWmp1NcHItHdtyRyeKEGrzlE02gIeB2wYhZvdKR4/A6u+mqswum2mukVSUjUN@vger.kernel.org
X-Gm-Message-State: AOJu0YzGbUIdrovFc6nX22VWx6CzUNYQXAebumUcIvo1znILdwvkyQ9I
	4p8gPA0AEM2Gs8HAJ/IGdmNaaBA+0u/NTtn6UQWyEiFHrgK/mS+ru7xzY+0MX8hyS7M=
X-Gm-Gg: ASbGncu/ZXpr/AsF34y57xPyJEKub/APmf8yPJddmxiwp+li8i7hY2CzAnBf4ULP23t
	ySAmIkRXdyeDJgA9AeT+If7BdDISEwKPwgLcOy5TAyPWf9g5UjhtGXu0eZWitZ1unNX27jVhV7l
	NpebuxKKudjtqDWVPwyZrwDbzZQBtSrrSibdYn7hJoCDaHM3io03VI4ahRFiQWbpVHFJfJCUDv/
	6kN96m1PAJ6K3D1/00PKcpV6DxVccPEQg4+2ebC9QRYKcNHfvB53xkZu8hsH+N4NlShv6lDFiq8
	t6dj1LwpTt5WagEaCff+79pHEoJlUi5IWKy/Iv94UUArNHwzDAUyX1CSadLhoC71C0BfbxCjNwx
	Nw6fPMjiYhJ3unXQyBQLCG/jQVJAvEIU0EgAcurocsvFwkhjQvi6cPk092nm9RdUe+RI0jA==
X-Google-Smtp-Source: AGHT+IEFN3CKkE+Hnj7Gi8IBgNUKfldwmoPTHprUzkt1izn6bJ+Tpqgf5eBYIsK3AJ5tcpghHEF8Yg==
X-Received: by 2002:a05:690c:8691:20b0:71f:f195:808d with SMTP id 00721157ae682-71ff19587d2mr100321947b3.5.1756222858629;
        Tue, 26 Aug 2025 08:40:58 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18b1b7dsm24961717b3.62.2025.08.26.08.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:40:57 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 07/54] fs: hold an i_obj_count reference for the i_io_list
Date: Tue, 26 Aug 2025 11:39:07 -0400
Message-ID: <e9c6b9533098baca9f7967bcb15de23e12b84134.1756222465.git.josef@toxicpanda.com>
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

While the inode is attached to a list with its i_io_list member we need
to hold a reference on the object.

The put is under the i_lock in some cases which could potentially be
unsafe. It isn't currently because we're holding the i_obj_count
throughout the entire lifetime of the inode, so it won't be the last
currently. Subsequent patches will make sure we're holding an
i_obj_count reference while we're manipulating this list to ensure this
continues to be safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fs-writeback.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index cb5e22169808..cf7fab59e4d5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -72,6 +72,14 @@ static inline struct inode *wb_inode(struct list_head *head)
 	return list_entry(head, struct inode, i_io_list);
 }
 
+static inline void inode_delete_from_io_list(struct inode *inode)
+{
+	if (!list_empty(&inode->i_io_list)) {
+		list_del_init(&inode->i_io_list);
+		iobj_put(inode);
+	}
+}
+
 /*
  * Include the creation of the trace points after defining the
  * wb_writeback_work structure and inline functions so that the definition
@@ -123,6 +131,8 @@ static bool inode_io_list_move_locked(struct inode *inode,
 	assert_spin_locked(&inode->i_lock);
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
+	if (list_empty(&inode->i_io_list))
+		iobj_get(inode);
 	list_move(&inode->i_io_list, head);
 
 	/* dirty_time doesn't count as dirty_io until expiration */
@@ -310,7 +320,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	if (wb != &wb->bdi->wb)
 		list_move(&inode->i_io_list, &wb->b_attached);
 	else
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1200,7 +1210,7 @@ static void inode_cgwb_move_to_attached(struct inode *inode,
 	WARN_ON_ONCE(inode->i_state & I_FREEING);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	inode_delete_from_io_list(inode);
 	wb_io_lists_depopulated(wb);
 }
 
@@ -1308,16 +1318,23 @@ void wb_start_background_writeback(struct bdi_writeback *wb)
 void inode_io_list_del(struct inode *inode)
 {
 	struct bdi_writeback *wb;
+	bool drop = false;
 
 	wb = inode_to_wb_and_lock_list(inode);
 	spin_lock(&inode->i_lock);
 
 	inode->i_state &= ~I_SYNC_QUEUED;
-	list_del_init(&inode->i_io_list);
+	if (!list_empty(&inode->i_io_list)) {
+		drop = true;
+		list_del_init(&inode->i_io_list);
+	}
 	wb_io_lists_depopulated(wb);
 
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&wb->list_lock);
+
+	if (drop)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(inode_io_list_del);
 
@@ -1389,7 +1406,7 @@ static void redirty_tail_locked(struct inode *inode, struct bdi_writeback *wb)
 	 * trigger assertions in inode_io_list_move_locked().
 	 */
 	if (inode->i_state & I_FREEING) {
-		list_del_init(&inode->i_io_list);
+		inode_delete_from_io_list(inode);
 		wb_io_lists_depopulated(wb);
 		return;
 	}
-- 
2.49.0


