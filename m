Return-Path: <linux-ext4+bounces-5204-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CEC9CF024
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76491F28088
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Nov 2024 15:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5D71E3DF5;
	Fri, 15 Nov 2024 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="AXCiI72B"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8B1E32D9
	for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 15:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731684698; cv=none; b=DcbBYdNgKYwpNTz6/lBgNScRml8g1CjRzTWSRVhAeoMUFT7x2ofIaFPpjIG6e/Fw6ov3GYdd7Rg7NgML8Q3KetsIn8+XrUJ+N4wdSvB/y0VHTdqWssr2sC0aJ2EGgKdFjusu18WAaXr++6tByTAECekyCwn6hiaFKFK1AeVWjfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731684698; c=relaxed/simple;
	bh=H9nsrZEmtioQe0BKAHTXHDlGAW6hpO1KDpAnJR9Ml0E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ii7oLIlQf57DCqx4PPwUBlj8o/23EdgY6zJ9UQScuHdyuy0DFKsvIyiYFUKaK327RPLEXwjjw2E+cGP/ftjMH2w84Dp8bP7uuEWKo7mdBx3sIpC9aO5CMuYzG10fsm9ZH9l8ObftXRVl6uuxZ/lQ2K1hb0PcZ6T8g9b617MvEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=AXCiI72B; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e3cdbc25a0so21873357b3.2
        for <linux-ext4@vger.kernel.org>; Fri, 15 Nov 2024 07:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731684696; x=1732289496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc94RDUI6NSDstxP0CCSGWYRtQ6KzVO9XtXkr+KxT+s=;
        b=AXCiI72BDqzMrERluzYVURX3g74nTjGCIeOuJaulp1LjjHrRNRlYxNH2YINQIIUJuX
         N6+jZsmmRcHoKUNZOO3c13Z47fzaXl/83sEJs/cU4HZWUpUpN/ghmXxgtmKFgT7iRjr8
         dDi4I2BcYkK/jRlAvdnbkLA6uFMTAHzMHKL9UkhwNPoAenc6k5utFYaqYtGQJhE1q1X4
         KR6+gKSUWedvc/EQJWpCP52KYVDLmV1y99fo1PMaP4cudinaT0A+tfj2JOazzsSO35Ge
         ZjerUTjcxgh+8qYl/Zcj0f1GT6M3IrghHZIpUtyF3OOrUP092bwvIAfKIk7bnR+fEdgS
         gPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731684696; x=1732289496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fc94RDUI6NSDstxP0CCSGWYRtQ6KzVO9XtXkr+KxT+s=;
        b=n6q2xYarjqXmF5RTQrQWtG+SXwx/FQerycJPuIlEA7LfoGmnu2FtqccSKev8hM71WI
         HlUo6yLlV2VELixKyXVWbAhRWSzbAtM3LfE+8oNvl6w8b90eVicU1tt0XKhZxtR5vw+T
         B+/BKZ0uSA4zJdu8omkw82EcLyZlwPPP+L9C2yuFaHbKh/M7eyTd7YZByWPiNmrYEzwf
         4cHSV3C4d6IZaTRhtlu7qdUpfYAb+M3JHrYffuNn0GJL/c3WNSviorebtoFScqHKQCx7
         RGGhf1d+0Y01cNts6RY47ss2zhWH5OPYvvf7IY7Jw88R0ES9CxXap7E4muEGT3B5R49O
         k3BA==
X-Forwarded-Encrypted: i=1; AJvYcCUzx5v1Yxsx8bYTWny1LCucus+dNZfifw3DQH0NDsChw2rs+Zl/YQtDoKAmBGO7m2AmAcyExrlgtTem@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/exPoWJC693LPcryHqntolpOM043YRRn5sRKldGDOH9dDcWxx
	Vi2vc1nLVkFE34oML2P5MgwWTxu7zbPqGqlsLDG4pdzXh25ffA60+fHFUbhLAQw=
X-Google-Smtp-Source: AGHT+IF/6XDeCM5HdGyZ+bKpb7CwsA0grIiF+sgXOFU/Ezrvf0/YQwsV5K3Q/P9oh37dfkgoQYNabg==
X-Received: by 2002:a05:690c:610f:b0:6e3:31e8:7155 with SMTP id 00721157ae682-6ee55ef7f91mr39398227b3.40.1731684696301;
        Fri, 15 Nov 2024 07:31:36 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee6dfe1a17sm202557b3.64.2024.11.15.07.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:31:35 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v8 09/19] fsnotify: generate pre-content permission event on truncate
Date: Fri, 15 Nov 2024 10:30:22 -0500
Message-ID: <23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731684329.git.josef@toxicpanda.com>
References: <cover.1731684329.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Generate FS_PRE_ACCESS event before truncate, without sb_writers held.

Move the security hooks also before sb_start_write() to conform with
other security hooks (e.g. in write, fallocate).

The event will have a range info of the page surrounding the new size
to provide an opportunity to fill the conetnt at the end of file before
truncating to non-page aligned size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c                | 31 +++++++++++++++++++++----------
 include/linux/fsnotify.h | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 1a9483872e1f..d11d373dca80 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -81,14 +81,18 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	error = mnt_want_write(path->mnt);
-	if (error)
-		goto out;
-
 	idmap = mnt_idmap(path->mnt);
 	error = inode_permission(idmap, inode, MAY_WRITE);
 	if (error)
-		goto mnt_drop_write_and_out;
+		return error;
+
+	error = fsnotify_truncate_perm(path, length);
+	if (error)
+		return error;
+
+	error = mnt_want_write(path->mnt);
+	if (error)
+		return error;
 
 	error = -EPERM;
 	if (IS_APPEND(inode))
@@ -114,7 +118,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	put_write_access(inode);
 mnt_drop_write_and_out:
 	mnt_drop_write(path->mnt);
-out:
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
@@ -175,11 +179,18 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(file)))
 		return -EPERM;
-	sb_start_write(inode->i_sb);
+
 	error = security_file_truncate(file);
-	if (!error)
-		error = do_truncate(file_mnt_idmap(file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, file);
+	if (error)
+		return error;
+
+	error = fsnotify_truncate_perm(&file->f_path, length);
+	if (error)
+		return error;
+
+	sb_start_write(inode->i_sb);
+	error = do_truncate(file_mnt_idmap(file), dentry, length,
+			    ATTR_MTIME | ATTR_CTIME, file);
 	sb_end_write(inode->i_sb);
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index ce189b4778a5..08893429a818 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -217,6 +217,21 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	struct inode *inode = d_inode(path->dentry);
+
+	if (!(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
+	    !fsnotify_sb_has_priority_watchers(inode->i_sb,
+					       FSNOTIFY_PRIO_PRE_CONTENT))
+		return 0;
+
+	return fsnotify_pre_content(path, &length, 0);
+}
+
 /*
  * fsnotify_file_perm - permission hook before file access (unknown range)
  */
@@ -255,6 +270,11 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return 0;
 }
 
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return 0;
+}
+
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
-- 
2.43.0


