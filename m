Return-Path: <linux-ext4+bounces-8103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39512ABFFD2
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 937EE4E4EEF
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1EC239E62;
	Wed, 21 May 2025 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5iaKo4H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4881754B
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867271; cv=none; b=jXcnX8urO19ip79X6z8eqFNjuGK/+lYmLpuUJp/Dc7IBjad8okQzIrOS8raKCZDpusU/NKjZB16pGkVaH6OJAmw43hM/pm7i34TGedX6HQqgyWpFScTYsVvjqTdaDQxxn+FM6cdTY1FD+s+dpyRo1kBkwAnqrtUBcIw3nkWQAtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867271; c=relaxed/simple;
	bh=WtgfZo35m1N8zQFSEmYM1yMfkHoSUZziziB4NEb3GpY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFeUie7QP4J0bZutOaEWcDyi2ZkIoDuU7omBmTb5sWWcndaEi/80ehDARmPshpff3aCdFNgWg6qeyzm7UqEuI1errfcG3oBLoWZMI37YXf0hzkyNsD4an4z4mwMIMOnKXJMnS3Q+DtZJ+1P0u5a9cw2DPfoc4jgycsRINeMqRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5iaKo4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B68C4CEE4;
	Wed, 21 May 2025 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867271;
	bh=WtgfZo35m1N8zQFSEmYM1yMfkHoSUZziziB4NEb3GpY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=s5iaKo4H8s+tAT6IkwP9D8vT0qPI9vhES9SEnRpK7EnpAa7nziMT/rkOrNDphL0+L
	 FkzpozzeFP9+1AfEL5F/hylZ89JH9QrEdMD9Ea/mrPEzN3q3GPtTZm20HlLZIMruVj
	 wEb7iKhSNOu0binM9aAIpYMiqtSWROlbyB8OoWfLOOooLmAmpLFGZw38s5sVl2Hw/0
	 yB0d6bjXrxiDA7r5tFMMtJ/pn7e8QvsctxBgC/M9DwNtRRYhn/VjJWtxHqsPRsuxQb
	 FgJtaBFPgZXgNCcKR5MZ/ZjqgnwE4blN9NDWN3OYm1vEFIrYX21XgI3Dzms5GAuvFA
	 aXoP3RaXKQKFQ==
Date: Wed, 21 May 2025 15:41:11 -0700
Subject: [PATCH 24/29] fuse2fs: fix return value handling
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786677978.1383760.8801097477278077188.stgit@frogsfrogsfrogs>
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

For the xattr functions, don't obliterate the return value of the file
system operation with an error code coming from ext2fs_xattrs_close
failing.  Granted, it doesn't ever fail (right now!) so this is mostly
just preening.

Also fix the obsolete op_truncate not to squash error returns.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 28b77d367cf705..a630d93f5f48a8 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2529,7 +2529,7 @@ static int op_getxattr(const char *path, const char *key, char *value,
 	ext2fs_free_mem(&ptr);
 out2:
 	err = ext2fs_xattrs_close(&h);
-	if (err)
+	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -2627,7 +2627,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
 	ret = bufsz;
 out2:
 	err = ext2fs_xattrs_close(&h);
-	if (err)
+	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -2817,7 +2817,7 @@ static int op_removexattr(const char *path, const char *key)
 	ret = update_ctime(fs, ino, NULL);
 out2:
 	err = ext2fs_xattrs_close(&h);
-	if (err)
+	if (err && !ret)
 		ret = translate_error(fs, ino, err);
 out:
 	pthread_mutex_unlock(&ff->bfl);
@@ -3129,7 +3129,7 @@ static int op_ftruncate(const char *path EXT2FS_ATTR((unused)),
 
 out:
 	pthread_mutex_unlock(&ff->bfl);
-	return 0;
+	return ret;
 }
 
 static int op_fgetattr(const char *path EXT2FS_ATTR((unused)),


