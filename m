Return-Path: <linux-ext4+bounces-8115-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C540ABFFEA
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0991BC4942
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8ED239E9B;
	Wed, 21 May 2025 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHoEzaG/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F9239E87
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867461; cv=none; b=fOt6zQ2dMTTf8KLqElEQVIvb6jSbg4ACzqWfJROWcbs4Z8khLPS2nPkVPJrNgm7RXIPRnLR4qcup1XyWBoP0oklU+mU8czWCb5PuuiZiVLN6wvwamtd7b5eLoKEG3h3US9/1IPggK9Z+w2T2HuI6LtHGFjjp0+fq7BjgB4z/CJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867461; c=relaxed/simple;
	bh=O7zQxdgE3FvJZPoXyUEdx5yD7UHw3jjN9Noc3CK/T+M=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmXilo4AY3EseUPONCGVXim0UJ++uVsOSlVv3CAmV9UIDFJoC1DLzh5G8kNWeQBijnTCKkabJbPEOe1v8550NNhGJy3dmsZy2Agtr1+toRS5JVfD34Hln+EBEANa1dnRs70xhWaXqP9SpdRRxgJtvaVdLQDwhZD7H33AyTI0R6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHoEzaG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8012BC4CEE4;
	Wed, 21 May 2025 22:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867460;
	bh=O7zQxdgE3FvJZPoXyUEdx5yD7UHw3jjN9Noc3CK/T+M=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ZHoEzaG/lmnyvbpaeIzl08SY9ZF2zHhoYTmj1RdoU4sPBf4k0fFNaOl01aoqte2rZ
	 V5Jvl0kcK7J71wjbQPNoE4SLAWhrkJCyDz4wkBuek7TaiuZFzLGMJU7T6rI3Cy/LL+
	 CioaF4V5anYxEH3IcQkIpC7ED8AHjYUVBKam97QLitUg2Fdz0nCCEAcbsg70UFFiIw
	 qo16zcGPuOF6TKA2cXfjj8xlxh3bAcpy1ebDMT2sfGKtckk3h50dOmpbnWSb90274V
	 j0U6y+y8sznRRy4aZFkFhwOAvGSJMLNDRsMHCU/lK8DbrZlA8IWBU5+GxJqlAkuPaW
	 oqhKYmD4pUxaA==
Date: Wed, 21 May 2025 15:44:20 -0700
Subject: [PATCH 4/7] fuse2fs: implement dirsync mode
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678471.1385038.12860188625256645865.stgit@frogsfrogsfrogs>
In-Reply-To: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
References: <174786678371.1385038.908946555361173764.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement dirsync so that we only perform full metadata flushes on
directory updates when the sysadmin explicitly wants it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index fc338058835360..6fae10e9473ea5 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -162,6 +162,7 @@ struct fuse2fs {
 	uint8_t kernel;
 	uint8_t directio;
 	uint8_t acl;
+	uint8_t dirsync;
 
 	int blocklog;
 	unsigned int blockmask;
@@ -1471,6 +1472,13 @@ static int __op_unlink(struct fuse2fs *ff, const char *path)
 	ret = remove_inode(ff, ino);
 	if (ret)
 		goto out;
+
+	/* Flush the whole mess out */
+	if (ff->dirsync) {
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
 out:
 	return ret;
 }
@@ -1591,6 +1599,13 @@ static int __op_rmdir(struct fuse2fs *ff, const char *path)
 		}
 	}
 
+	/* Flush the whole mess out */
+	if (ff->dirsync) {
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
+
 out:
 	return ret;
 }
@@ -1963,9 +1978,11 @@ static int op_rename(const char *from, const char *to
 		goto out2;
 
 	/* Flush the whole mess out */
-	err = ext2fs_flush2(fs, 0);
-	if (err)
-		ret = translate_error(fs, 0, err);
+	if (ff->dirsync) {
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
 
 out2:
 	free(temp_from);
@@ -2072,6 +2089,13 @@ static int op_link(const char *src, const char *dest)
 	if (ret)
 		goto out2;
 
+	/* Flush the whole mess out */
+	if (ff->dirsync) {
+		err = ext2fs_flush2(fs, 0);
+		if (err)
+			ret = translate_error(fs, 0, err);
+	}
+
 out2:
 	pthread_mutex_unlock(&ff->bfl);
 out:
@@ -4256,6 +4280,7 @@ enum {
 	FUSE2FS_HELP,
 	FUSE2FS_HELPFULL,
 	FUSE2FS_CACHE_SIZE,
+	FUSE2FS_DIRSYNC,
 };
 
 #define FUSE2FS_OPT(t, p, v) { t, offsetof(struct fuse2fs, p), v }
@@ -4281,6 +4306,7 @@ static struct fuse_opt fuse2fs_opts[] = {
 	FUSE_OPT_KEY("noblock_validity", FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("nodelalloc",	FUSE2FS_IGNORED),
 	FUSE_OPT_KEY("cache_size=%s",	FUSE2FS_CACHE_SIZE),
+	FUSE_OPT_KEY("dirsync",		FUSE2FS_DIRSYNC),
 
 	FUSE_OPT_KEY("-V",             FUSE2FS_VERSION),
 	FUSE_OPT_KEY("--version",      FUSE2FS_VERSION),
@@ -4297,6 +4323,10 @@ static int fuse2fs_opt_proc(void *data, const char *arg,
 	struct fuse2fs *ff = data;
 
 	switch (key) {
+	case FUSE2FS_DIRSYNC:
+		ff->dirsync = 1;
+		/* pass through to libfuse */
+		return 1;
 	case FUSE_OPT_KEY_NONOPT:
 		if (!ff->device) {
 			ff->device = strdup(arg);


