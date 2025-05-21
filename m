Return-Path: <linux-ext4+bounces-8102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941AFABFFD0
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8777A600B
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E707239E62;
	Wed, 21 May 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUQY2pGF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9291754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867256; cv=none; b=jtdsuRo9uXmYn2gHHlVXikd5rA++cKVM18V+B8kqUK3ZhqV7SSg8mU5fsO+LXF9dOp4D4vJjNF9mkhBSWyUjXCZcJNkgi0NG7ItJtOjzshSlzeUOYOh2C2jslKg6QKqfNLoICxr/r/ybZ6Gz2gWNXzF6E7dTJ+0d1Z5Ph2aP4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867256; c=relaxed/simple;
	bh=ZVeFSRawH7G8s0KBlTVpNzLnOShuhgzz82JyMbE9DJY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c15EcDLSaRx8a6RIqb27uDB2Qv6ZHTVFkSUaUj/9MF2JbGRm8UsrxFcGYJRkiRJK1cTqkoDaXaQf6NglCZxx97aNKo1T0v9EOnX21T7OZjvvX0lRJZJAEVA4aufQkkqDEg+m9wImaPHqKI2ZSrHsEOOzPeQx1QQNLreRzV5tN/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUQY2pGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063EAC4CEE4;
	Wed, 21 May 2025 22:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867256;
	bh=ZVeFSRawH7G8s0KBlTVpNzLnOShuhgzz82JyMbE9DJY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=OUQY2pGFyyyQ4Q6k5HDBiPTyqpH/sxJMicYDMY7E5BKn+dnEqM47iRzfoNJ9n6q2K
	 HYklKDuUp1fgrkeCOiAUQIiEFXpqUkJ9u4CbNJV8762mA+W0xSEb93oFZuBjq3EN3F
	 Hl90E4w50F/P6LGmC90VLH2DSkM13tWpW1DwE5iDyR3U8EggGBBhllVNCm0EMQJoEH
	 Kj1OgAhzHHGkKcqrTzndFqmreFUCHXdbFfTpItGODSDXJxJ98tlcFYuSfB7MNiZINi
	 EvgHWDl3yx0z2LMK2/8uUEfRSFC8V2JchY4Wj3ctk2R+7bX2j6XgS7MRb+Y1ztTXQ5
	 WBo20GbSZ55+w==
Date: Wed, 21 May 2025 15:40:55 -0700
Subject: [PATCH 23/29] fuse2fs: check for supported xattr name prefixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677959.1383760.12099114841852662650.stgit@frogsfrogsfrogs>
In-Reply-To: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
References: <174786677421.1383760.15289906755026332870.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Ignore any xattr calls for name prefixes that the kernel doesn't also
support.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fsP.h |    3 +++
 misc/fuse2fs.c       |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)


diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index d1f2105e9813ca..428081c9e2ff38 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -214,4 +214,7 @@ typedef void (*ext2_exit_fn)(void *);
 errcode_t ext2fs_add_exit_fn(ext2_exit_fn fn, void *data);
 errcode_t ext2fs_remove_exit_fn(ext2_exit_fn fn, void *data);
 
+#define ARRAY_SIZE(array)			\
+        (sizeof(array) / sizeof(array[0]))
+
 #define EXT2FS_BUILD_BUG_ON(cond) ((void)sizeof(char[1 - 2*!!(cond)]))
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 74bbe661a417e5..28b77d367cf705 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2443,6 +2443,27 @@ static int op_statfs(const char *path EXT2FS_ATTR((unused)),
 	return 0;
 }
 
+static const char *valid_xattr_prefixes[] = {
+	"user.",
+	"trusted.",
+	"security.",
+	"gnu.",
+	"system.",
+};
+
+static int validate_xattr_name(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(valid_xattr_prefixes); i++) {
+		if (!strncmp(name, valid_xattr_prefixes[i],
+					strlen(valid_xattr_prefixes[i])))
+			return 1;
+	}
+
+	return 0;
+}
+
 static int op_getxattr(const char *path, const char *key, char *value,
 		       size_t len)
 {
@@ -2456,6 +2477,9 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	errcode_t err;
 	int ret = 0;
 
+	if (!validate_xattr_name(key))
+		return -ENODATA;
+
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
@@ -2626,6 +2650,9 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
 	if (flags & ~(XATTR_CREATE | XATTR_REPLACE))
 		return -EOPNOTSUPP;
 
+	if (!validate_xattr_name(key))
+		return -EINVAL;
+
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);
@@ -2714,6 +2741,16 @@ static int op_removexattr(const char *path, const char *key)
 	errcode_t err;
 	int ret = 0;
 
+	/*
+	 * Once in a while libfuse gives us a no-name xattr to delete as part
+	 * of clearing ACLs.  Just pretend we cleared them.
+	 */
+	if (key[0] == 0)
+		return 0;
+
+	if (!validate_xattr_name(key))
+		return -ENODATA;
+
 	FUSE2FS_CHECK_CONTEXT(ff);
 	fs = ff->fs;
 	pthread_mutex_lock(&ff->bfl);


