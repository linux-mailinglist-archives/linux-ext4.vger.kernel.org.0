Return-Path: <linux-ext4+bounces-9508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A6B30637
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30E26AE7CA2
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1947370580;
	Thu, 21 Aug 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="ute/rt2a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92D372167
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807629; cv=none; b=Dd+efL00Q9JXDy6pDZES66zDX0AkmlZNpdqU36d6FLIrVLAKswqMa1mtBA95GtKmSXLFcjamH8/gzwTls9vp7xKBAclgXw3OYsxB5lo7R/RplIqfsmr1WX10mCW/dAq93HFy1P3Y8dre4bRr+EaqAjwEL4brVXu2Ufy9pL5vM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807629; c=relaxed/simple;
	bh=79hNy8MLLzEWxtQB4sKNaWyskip03chASXjDy5oeEVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIuWVZ+LIXZM4cjE1T2vGrZZHRn05EeDBhsgSHbkwxnIHmCGGBhHOJHs0jVFszR6MiuyrKoGvZml0+2PtUYHBk5eJtQkIL9a/9tkeWajI905dNq5c7gEogVR1VwjOgTE5vm2d4GO73hoK7dDTVtkqbgoECCDKcVBSp73wfTSFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=ute/rt2a; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e934c8f9757so1389982276.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807626; x=1756412426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=ute/rt2aDrIGbZcCD4LoRaErKtNRZOnwRe0tj73h6Uh6wBt09gFyfS/b+nr5VTrHRM
         jdjYrsHb9aizSdiPtxJVHryfIZOUzkn87zPRqYAq+K0hTuwI2KIe+d6AL2RHHxFmWjgp
         MDZwbUO1v7gEpLVagg0/apRbDMBjjdbsNvSjZkHOkpGRnZRMZ4/+ubFnpmObjsxFR51T
         LcFRDS6cb9uyvV5QZOB+NA8lyg3YSLW1rqv8ylfL4DfMwWfbG2xVo4FP9AyCF41kfH66
         kwrft+1sGQl0g5Niz8Pvx4ZmvYk4EdBSTpYybUhSzpeT3hEs1yilEbdxHSJLrW5JrGDP
         s1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807626; x=1756412426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQfgrNdLLZc/kRK8PuHP6T1NoeMFhCjwF6aVkuwb+Vw=;
        b=NqmTJ/8z6ZuLtWwWZlqvxbELXq+blOGcf93WJhw+QdhY9SLVrFOWDgG/WamnqHcdZz
         FRXIniNYzZRj8yN0fn+LdVlh2dN8PkDYZoxf/YH9jBarTKu7wjIRiyHgffM+S4lRvbgT
         gKcmT9wBzMREMaT0Vr6zte9HdCKhRc7P9Dz+NwpRDnoHVm+BxM+rdJ5PYYI66JHJLPoW
         wCN/OkiqyjXAkExnAngtSvdO3tCg3Z/UhhcvALTsl4AN5NvxHhIk46FrFaJX5OgorufH
         OHihmEVfyVXyT5RwVmL2xH1AgSPmWPngXI0aloGGEdYkwiSAKla2q+bn6rYAoXA7Kkou
         FQsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHYljlwcS8hIoaAXe7snh94sLMQmIgBhzgNH43OHdlU/7buaEyIbVBA5foNuhR1ST6YouGcJaSPulE@vger.kernel.org
X-Gm-Message-State: AOJu0YyOrT9waR/p5EW70jvZSLtIjlnOVmvYqmUvFQepIfXqfchves9r
	7ZwohWQa/at6GOQi+7K6LoCGcJZL04dwXvTM1Okih6o08fHvWFSeGoZQ9b2yychPrHY=
X-Gm-Gg: ASbGncvzyvkSj0gH9FB2dg97AftMWfTyGt7GAOEWRJwDzJEm4xlHCuhZqz79P/gtqsh
	8Yan893Z656Xx+x1rIxwE1oCLK3qETLmlEatr4+S09h8p/Y5ohTkpTz33svkBgReiSkTnTV733E
	NuSBUAediw4SgkZSHTLRadKlqeqHvhL/TloXJA9XzD+kkuoicG3c7GnGI8upxu2POLg7+oQQX+k
	jTj/neBKGsw4LJsMZaPpynuZnkMc7rE1wheG80tLDsyxLoZufqybOETa9EL1/+jKiQ0LPnrhN6Q
	0kqU8xHtF2P/WGWczn08y7ZSVNKeBBKQ37VVz8o00P1cNFNGVIk2rGUyoqszm0PvT880jrZ94ZX
	p0PFw7zjHSZ5mmUoo8tfIi2DF6WUAWGQyFjGJ3yF4lBEADQ8Y/fWYK56t3yM=
X-Google-Smtp-Source: AGHT+IH6qMUNtcjMenDwwsBm6WjRZG6TyRrHXTaa6FiUieFXv2EqpL/3ycbYTymZg5Nc7D4WJE0sWg==
X-Received: by 2002:a05:690c:b06:b0:702:52af:7168 with SMTP id 00721157ae682-71fdc2be3eemr6737757b3.2.1755807625992;
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fa8224c2csm19078567b3.16.2025.08.21.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:25 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 07/50] fs: hold an i_obj_count reference while on the hashtable
Date: Thu, 21 Aug 2025 16:18:18 -0400
Message-ID: <56fd237584c36a1afd72b429a1d8fbf4049268cf.1755806649.git.josef@toxicpanda.com>
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

While the inode is on the hashtable we need to hold a reference to the
object itself.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 454770393fef..1ff46d9417de 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -667,6 +667,7 @@ void __insert_inode_hash(struct inode *inode, unsigned long hashval)
 
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	hlist_add_head_rcu(&inode->i_hash, b);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
@@ -681,11 +682,16 @@ EXPORT_SYMBOL(__insert_inode_hash);
  */
 void __remove_inode_hash(struct inode *inode)
 {
+	bool putref;
+
 	spin_lock(&inode_hash_lock);
 	spin_lock(&inode->i_lock);
+	putref = !hlist_unhashed(&inode->i_hash) && !hlist_fake(&inode->i_hash);
 	hlist_del_init_rcu(&inode->i_hash);
 	spin_unlock(&inode->i_lock);
 	spin_unlock(&inode_hash_lock);
+	if (putref)
+		iobj_put(inode);
 }
 EXPORT_SYMBOL(__remove_inode_hash);
 
@@ -1314,6 +1320,7 @@ struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
 	 * caller is responsible for filling in the contents
 	 */
 	spin_lock(&inode->i_lock);
+	iobj_get(inode);
 	inode->i_state |= I_NEW;
 	hlist_add_head_rcu(&inode->i_hash, head);
 	spin_unlock(&inode->i_lock);
@@ -1451,6 +1458,7 @@ struct inode *iget_locked(struct super_block *sb, unsigned long ino)
 		if (!old) {
 			inode->i_ino = ino;
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state = I_NEW;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
@@ -1803,6 +1811,7 @@ int insert_inode_locked(struct inode *inode)
 		}
 		if (likely(!old)) {
 			spin_lock(&inode->i_lock);
+			iobj_get(inode);
 			inode->i_state |= I_NEW | I_CREATING;
 			hlist_add_head_rcu(&inode->i_hash, head);
 			spin_unlock(&inode->i_lock);
-- 
2.49.0


