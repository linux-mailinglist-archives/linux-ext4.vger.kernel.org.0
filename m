Return-Path: <linux-ext4+bounces-1358-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EA285F9A6
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 14:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CB11F26DE1
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 13:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C300D1474A4;
	Thu, 22 Feb 2024 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTlLi/s9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C35FB91;
	Thu, 22 Feb 2024 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608199; cv=none; b=Yt0hFUd3YsWXa6dDCSqRpdO4ZKyuO3DCR2SJ06k1n3heTr+i1ovEKI6TrLfIq5aCpiknmve4iSXJ/X7SzHmCZPxn+3rAERjbg5OFYgp8yO7fdK8eoB15xNQz7pf1WbbR8AgX6N+GJLY8kla2ce2TrUfcoF/i9x1VwRh1HdvcsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608199; c=relaxed/simple;
	bh=+dzTQv/4NufVCAW9A2AycclCHqgrOwd1oNc90SVydO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CW6zEr6x4my3ryxl7rJuL2Dww8yjvMHE3MYKHGDmuuBuYSdAnNQfXQTF8SniIUsDGsQLHFGDyKIW7M+kD8il7S0rXDZEh7YMTPe7QhJIj2quDy0NxEHTh3y4V6k4i9jQ+ZMnT/hjGwbRLU4kPXk3TT+UgukxZjT9QGcrDjpLPnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTlLi/s9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79265C433C7;
	Thu, 22 Feb 2024 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708608198;
	bh=+dzTQv/4NufVCAW9A2AycclCHqgrOwd1oNc90SVydO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTlLi/s9Ba9nnFhPLf2yDYKfEzeogoUHSuu61zgyrk7yB5z9IdXjOdZQ6kikVfmZJ
	 WnAKPmjCqLUE8dg98MEq+pOIRTC07zciPAGyLIs8ooBcIkcutlo4zjdIP2yZkSLrJR
	 QkOcAxuMA7H2HCVsAGZ8egUi6YnzSXO7R4sjGDy8PrdikOp+Kre1gDnBHDXfK/IoJ3
	 nWrWvXtyeg2UrhVCxsbkmD+z5AvCMSSXgG8fs6v2CwnH8omO7/PWv0fYbdJ703u3iR
	 XD0NWSlXv0kMvHlMcNRT7xlJ8B2eO4VNH6jmc1cQz7p0BcdgH3WtK5qFQu2DpL1zBQ
	 5RpcglbpgsVXg==
From: Christian Brauner <brauner@kernel.org>
To: Luis Henriques <lhenriques@suse.de>,
	Zorro Lang <zlang@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] vfs: fix check for tmpfile support
Date: Thu, 22 Feb 2024 14:23:06 +0100
Message-ID: <20240222-mango-batterie-505564cecb69@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87jzmxisqm.fsf@suse.de>
References: <87jzmxisqm.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310; i=brauner@kernel.org; h=from:subject:message-id; bh=+dzTQv/4NufVCAW9A2AycclCHqgrOwd1oNc90SVydO4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaRe99p9gPfWrPqZFZMN5k9vq1l4ZpJGOFcHd9Z3Ho602 Jc3PzdLd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykSZLhf27sqn0bdoUpxeuo 8Z/w+Zf3U2RCXI+Ag4y2FI+q+9eL9gz/nUxDLPIdt9rvvOtRz1wlELZZP65cxvHh648zYv9Vn41 nAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

When ext4 is used with quota support the test fails with EINVAL because
it is run after we idmapped the mount. If the caller's fs{g,u}ids aren't
mapped then we fail and log a misleading error. Move the checks for
tmpfile support right at the beginning of the test in all tests.

Reported-by: Luis Henriques <lhenriques@suse.de>
Link: https://lore.kernel.org/r/20240222-knast-reifen-953312ce17a9@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 547182fe..e490f3d7 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -3815,6 +3815,8 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -3838,8 +3840,6 @@ int tcore_setgid_create_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -3991,6 +3991,8 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -4014,8 +4016,6 @@ int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7715,6 +7715,8 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -7738,8 +7740,6 @@ static int setgid_create_umask_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -7929,6 +7929,8 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -7952,8 +7954,6 @@ static int setgid_create_umask_idmapped_in_userns(const struct vfstest_info *inf
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	/*
 	 * Below we verify that setgid inheritance for a newly created file or
 	 * directory works correctly. As part of this we need to verify that
@@ -8163,6 +8163,8 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -8186,8 +8188,6 @@ static int setgid_create_acl_idmapped(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");
@@ -8518,6 +8518,8 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
 	/* Changing mount properties on a detached mount. */
 	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
 	if (attr.userns_fd < 0) {
@@ -8541,8 +8543,6 @@ static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
 		goto out;
 	}
 
-	supported = openat_tmpfile_supported(open_tree_fd);
-
 	/*
 	 * Below we verify that setgid inheritance for a newly created file or
 	 * directory works correctly. As part of this we need to verify that
-- 
2.43.0


