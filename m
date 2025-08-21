Return-Path: <linux-ext4+bounces-9541-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08988B306DC
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED9E1D25B24
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6B139194D;
	Thu, 21 Aug 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0xrRm3+m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C62391930
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807679; cv=none; b=evVzHcIk6oM/f0s/DYxaZ+heCa3YSPJQOtA3h3EvZKYxMcLVEwcEAu8Fi+BStM2Umm+oJ6GvG4sw6G7Qk2YjITpRGScg3EGbPR464vcDOI5JpQQshhWdShpwFh+RpQ3XzzCdVgzCb9+ReARFXSg/fcXXdsu2pZjpfO2U8zyr/0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807679; c=relaxed/simple;
	bh=l9LGL5YoR+E74x5+N/Eq/UXBXN/oa7FDffUkNr02mvs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWka60U5qu8DufSIuKJguVQtkYIOLvqgOjmaTaX0yvgNGGOlL0E9ejBvg+dlLnu8nRK5p6znygTnU1DX8wLq56lyohdmH+n3pGTsS/6C3ZEBz0fLOSzRuKSkfMDJw238bEscQhv8j7Jpu3ENG7ZV4F0eD7wcvW7oP13wxFojCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0xrRm3+m; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60157747so12174247b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807677; x=1756412477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=0xrRm3+mKVWYP/+dwHCORPrPDAjir0w4zx3zLOwCTKGB+pDuowu8CcuA5AxVOv7AqE
         ObUCrRWYbHPjdlD7w1VFDcTl//pv/aFW9Jno7uOXMn7wT+eE/IaC6jiT5zPtEfaJKfiK
         eEGADrUX3oa9tvHvMGYVQO1HkMGWO4JBOoLFeQN0iadnnQzovw2YRSnWeFPhsf5pzT5R
         SEyLTBVJIC2ruab/aGzXU1f6Tmiu4rh3sFMIfCUH71vtcz8PAHxkOe/0wFDUQY0Yva8w
         IKGvY9VZ2FnDHM+zLKW9puN/37D3jJbayuFX5g9yNhpI5VgQkyVRlFg9mh6/k92Y6TiF
         2ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807677; x=1756412477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A8xX7Mkw85UitdhfeCIWR7erYk+tgthiF9HNGtDW90=;
        b=LL0Bst+REHbbLg1RcmSkjGMLxTo5JVvhb0X5mvRICUBEJ2Mbwy4BLK1J2Dv05vyE6a
         GlTUDWRlvGxLi70o+AKI9zDU3dQH6k9LqxxpAxo9aCWO9VwAM6Iz/J/77bWzzhxr2JfI
         6tG9p64x/ge41QNgenpN/x/wQj/Hcrb/1QFMPCrQKbhiGQREZ7zLwvyMLNJFYwRGIZHh
         E0pQ4kWZVIPA1bOIKUJRWX1iKUiAUG4FsQGNhtkWj1QRpcltEq07nnLjZoPU+Tb5SBye
         UlTPZOQmdFjjEK8fVpO+pFWzkf9HTA4atN93QXlIFiPzAccO9rW+5mPTrTWJ32xHpQqW
         Jl/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJEdUOXONzdDF/fDYWqdxK3Co4i/+yP9/sbJo6sGdYokpRBt4TXpYq2SKTGL0B+Wvkej2m9i90gV45@vger.kernel.org
X-Gm-Message-State: AOJu0Yxve3XFl59A7qUL7T09che9Q9VA6rq7YYli38hqa5Z12+gGVx5C
	QWky33QwxM70hKQoKSRf5g/IhU/wpl6sV6wwflFNsxy+Kg0CaqHTB8hwH5x0U2w82+E6cxvBLBt
	K0q5L4kOEmA==
X-Gm-Gg: ASbGnctXekt4ICzpdaD1wFOo6maf3PY00AOdW5+YJhwp4u6scHJckEZlJYmtIMuJxdA
	PY2eOtWLeTRWa0wfs8zTV3zPv5Lk5Ip5rwvF9ieRVPofctXHI1sZkM1rLp6H4Gh8xqIqRmkDCBD
	aIlsQhD0lt3g6opNrd82YrXn08DgvW0hV6z3NCLlnhvKMa+3xlTUqH3jO9hiz5QCsAou4RIs00R
	jnE3HWilDskzL9i0x6RWFjTH/TzXw2kyDRoF2zO3xirF35CwzHh+Ii9+nLsW5oFQ+akoapUEYA9
	s5Dy35/QUpiOMeAKWD+nwXB7akggCsLUXKQFiSD3AwOWwZV7wnxM4dMtTlsMysxJCDZLH8MGXvf
	4/mLJfJvPgX+QJLywZ8cXjbIe60YRj4WtNTIGivMikWEMJLSaW7CoaD0iX0U=
X-Google-Smtp-Source: AGHT+IEslmPaAmy8j7deq0G6NJW1ig6p7tgKnrmQqRmoW4yzMeUV0UVc/9ZPvIEXnYkUv+t0w0Cs7g==
X-Received: by 2002:a05:690c:e0e:b0:71f:9a36:d33b with SMTP id 00721157ae682-71fdc412c54mr7580807b3.45.1755807676808;
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e0b039dsm46055887b3.59.2025.08.21.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:16 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 40/50] landlock: remove I_FREEING|I_WILL_FREE check
Date: Thu, 21 Aug 2025 16:18:51 -0400
Message-ID: <e54edfc39b9b19fe8ff8c4c7e8b5fe06caa78fc9.1755806649.git.josef@toxicpanda.com>
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

We have the reference count that we can use to see if the inode is
alive.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 security/landlock/fs.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 570f851dc469..fc7e577b56e1 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1280,23 +1280,8 @@ static void hook_sb_delete(struct super_block *const sb)
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		struct landlock_object *object;
 
-		/* Only handles referenced inodes. */
-		if (!refcount_read(&inode->i_count))
-			continue;
-
-		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
-		 */
 		spin_lock(&inode->i_lock);
-		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
-		 */
-		if (inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW)) {
+		if (inode->i_state & I_NEW) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -1308,10 +1293,11 @@ static void hook_sb_delete(struct super_block *const sb)
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
 
+		if (!igrab(inode))
+			continue;
+
 		/*
 		 * If there is no concurrent release_inode() ongoing, then we
 		 * are in charge of calling iput() on this inode, otherwise we
-- 
2.49.0


