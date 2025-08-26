Return-Path: <linux-ext4+bounces-9645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BADB36E5A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A6A5E7B41
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B39935FC18;
	Tue, 26 Aug 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="xhEuwrqL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242B35E4E3
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222882; cv=none; b=q1GH5iKcIRSyqc5xBI8Qvei9Ujii/RF7SZ0ppmmiftWH5C0ObDJhusd8audWnZFoCitCU8WMV/ecXHgic5rUsX450hV+3tCJZn7gwhKOnAD8ieuuuSw2V2BUUxqdUD+9lKMtsqD18bXE1te3bf0BZ0eATxvdV4vL/dhGV+vCaLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222882; c=relaxed/simple;
	bh=6dnduwz2qT/zsskC7epU9otttNGxq+N4PxJFoWXJBUw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRM0S2ugi49i7eqzAOQLA2dcdiwNzdToQiLC+nQZCnDNsABfV4GR9aqxXCEedaonkVdKQonhs0acxUisq+AfWGBLECO/ShG5n5LGAJ+22EDZAA2JOPpL4B86yoTym5g1S0bJAxjAUV1Y6cw0WdZOhkKLDJOcO5dhzKevhjI/g9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=xhEuwrqL; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e96df7ff20eso711399276.1
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222878; x=1756827678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOjvmn46ZQoy8RoAMfUo3jX2UJkpyHzSOm/HJR2z+vw=;
        b=xhEuwrqLkcNIW0HGzHalnj46MA5cS47Ou4R7wQlDNWBfhipWLvRF2jPJBejbqbQ3Oz
         6GrT9LqjTnDJ/A5+jNuWkXj5j9A0rcg1NvR51yKNeytDpBi5MpthpbeU1AUWaiKZ49DP
         ITvGBFHTX13o7KjaYSJ+hBdYFrbs8RYfkbinHkLlIwFIzEypF1bnaqHXurmWXsRMNYlX
         npeFXFVF/tBbmTdlBss+FCDqJEEY1vFVA7OAECSP7YsVxINy916zF68pZ4Gj0C2ZpjC7
         6xPDtdsxytRiM6ex0ZUaU9vj8anwiGqG0NlT4oJHD73mKn7XnHCrXF/mMlsOF46CJGyN
         HsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222878; x=1756827678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FOjvmn46ZQoy8RoAMfUo3jX2UJkpyHzSOm/HJR2z+vw=;
        b=WYDkd/VCPg1uxVvFGkq3YynQpIULSgI8RkuhvXAXyux1OQL3GLHGnqN9fn12GvnnVx
         p+4flJai/gLO7vs83xjJ8zFudITLK+pgD08YfbnTEiuGNxOsprqz3EAeT15h7Yr6+aYK
         Ge9AB6MkRQJhGpvT6kGYQ/4VdtwagjmOgou8Hl2pLDJs5L/mcS20xccfRah/SvXTCgi3
         tzIWiiORDUAGwAxdXNumtLDdiaROtnV0DMCdlsFxnvidN1NuYoHs6Pea3WkzsFazQno/
         jKk0RoYOK6jRhFyzFekp7mA0EhNExKNR24HDrF8tBaRfibKSpTJxZyleJnjuwcyawvEp
         2rIQ==
X-Forwarded-Encrypted: i=1; AJvYcCViL/bUdANrf+WlA23nTbalC0i+X0sv7gG3JglU98Hgd6E/9sJ49l5E8g062kwTmkbnBRMhhk7Mm9qG@vger.kernel.org
X-Gm-Message-State: AOJu0YypY0D33mJa/mrj9/K8L4COcTfQTatV5+QWrO8NRPgXvfqoYNdV
	jBH2B0FKFuTWt+Gztax2ihziEK0EvGjM4KIuNBDIqxWZNkhg6TO5oIEWknpsNlQkjfI=
X-Gm-Gg: ASbGncsVl1XoUbJf+5IPXMhFCaU5JhEoTewFNote1/n8LWZEfERGX/VTUQqARVZao6B
	Gd+dZ26SyYLXA9ScKV9scqo6MxyVYPPAvVvPAJaSYBrN1W1x5W6EZI+qegblWB08NWUQjs/kw2M
	wrBgJ6odrymo+IepsuKLUgpX4sD7VC5ps6pFwqX2KsuxS5XvdR+QS8rskPMhRyqSopVfDaKwbDI
	unSsgRM4oHOq98HgBPUpu6LHIjDA2RYsXlalbRFuBbzHoKTzUVdP4jcHpCrOSrpJoEou47z4k29
	jbMyr1sHkZt4f7/pizIOLGESNLBtzSV2mDML7sHkAaVQg/y4m6NfGylz/9kzYvnoyl472x/CSR1
	1SUAXP5OIlk3ac+NUyQI8ZqA8agX3U2rUioYNdfPBVNX93Rt5Vl2GI3LoyjU5PKCJ/M5ZPw==
X-Google-Smtp-Source: AGHT+IFmbiTjt/bWW0MQRszMVOeUPuSn5IU4QnxuxDXuxPmyIrj4BMhw9mjI5WmiUj6YsTAUM8QvlQ==
X-Received: by 2002:a05:6902:4111:b0:e93:38c1:1fa4 with SMTP id 3f1490d57ef6-e951c2ca5b7mr16610661276.1.1756222877763;
        Tue, 26 Aug 2025 08:41:17 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358904sm3307604276.24.2025.08.26.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 20/54] fs: disallow 0 reference count inodes
Date: Tue, 26 Aug 2025 11:39:20 -0400
Message-ID: <df5eb3f393bd0e7cbae103c204363f709c219678.1756222465.git.josef@toxicpanda.com>
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

Now that we take a full reference for inodes on the LRU, move the logic
to add the inode to the LRU to before we drop our last reference. This
allows us to ensure that if the inode has a reference count it can be
used, and we no longer hold onto inodes that have a 0 reference count.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 61 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9001f809add0..d1668f7fb73e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -598,7 +598,7 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	if (inode->i_state & (I_FREEING | I_WILL_FREE))
 		return;
-	if (icount_read(inode))
+	if (icount_read(inode) != 1)
 		return;
 	if (inode->__i_nlink == 0)
 		return;
@@ -1950,28 +1950,11 @@ EXPORT_SYMBOL(generic_delete_inode);
  * in cache if fs is alive, sync and evict if fs is
  * shutting down.
  */
-static void iput_final(struct inode *inode, bool skip_lru)
+static void iput_final(struct inode *inode, bool drop)
 {
-	struct super_block *sb = inode->i_sb;
-	const struct super_operations *op = inode->i_sb->s_op;
 	unsigned long state;
-	int drop;
 
 	WARN_ON(inode->i_state & I_NEW);
-
-	if (op->drop_inode)
-		drop = op->drop_inode(inode);
-	else
-		drop = generic_drop_inode(inode);
-
-	if (!drop && !skip_lru &&
-	    !(inode->i_state & I_DONTCACHE) &&
-	    (sb->s_flags & SB_ACTIVE)) {
-		__inode_add_lru(inode, true);
-		spin_unlock(&inode->i_lock);
-		return;
-	}
-
 	WARN_ON(!list_empty(&inode->i_lru));
 
 	state = inode->i_state;
@@ -1993,8 +1976,37 @@ static void iput_final(struct inode *inode, bool skip_lru)
 	evict(inode);
 }
 
+static bool maybe_add_lru(struct inode *inode, bool skip_lru)
+{
+	const struct super_operations *op = inode->i_sb->s_op;
+	const struct super_block *sb = inode->i_sb;
+	bool drop = false;
+
+	if (op->drop_inode)
+		drop = op->drop_inode(inode);
+	else
+		drop = generic_drop_inode(inode);
+
+	if (drop)
+		return drop;
+
+	if (skip_lru)
+		return drop;
+
+	if (inode->i_state & I_DONTCACHE)
+		return drop;
+
+	if (!(sb->s_flags & SB_ACTIVE))
+		return drop;
+
+	__inode_add_lru(inode, true);
+	return drop;
+}
+
 static void __iput(struct inode *inode, bool skip_lru)
 {
+	bool drop;
+
 	if (!inode)
 		return;
 	BUG_ON(inode->i_state & I_CLEAR);
@@ -2010,9 +2022,18 @@ static void __iput(struct inode *inode, bool skip_lru)
 	}
 
 	spin_lock(&inode->i_lock);
+
+	/*
+	 * If we want to keep the inode around on an LRU we will grab a ref to
+	 * the inode when we add it to the LRU list, so we can safely drop the
+	 * callers reference after this. If we didn't add the inode to the LRU
+	 * then the refcount will still be 1 and we can do the final iput.
+	 */
+	drop = maybe_add_lru(inode, skip_lru);
+
 	if (atomic_dec_and_test(&inode->i_count)) {
 		/* iput_final() drops i_lock */
-		iput_final(inode, skip_lru);
+		iput_final(inode, drop);
 	} else {
 		spin_unlock(&inode->i_lock);
 	}
-- 
2.49.0


