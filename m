Return-Path: <linux-ext4+bounces-11569-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31548C3D9DD
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01893A6EE6
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6988730DED7;
	Thu,  6 Nov 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhlm5io7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC052FBDFA
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468425; cv=none; b=lUQlQ2CulisTNwka5Kmd4k/AC5pTQVeGnwK9COlH+/LCG/wshDMx58xEpwTO+DyPyeuRgQXg+8Tkkz1m8wPoXzz2QxRkB6Bbkus5dZSVK4abOjhjYLr2NEoTV9f93JXhS/pszeZetpTw+467iRdBARGbTQHvKwxkxUbKmMu2mpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468425; c=relaxed/simple;
	bh=9k9T61FxKCRkwrh7WhS1tkL4gfH6J81j8cHZxZYsYzE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5b/QsqugnSaq9WvpuPw2dpHbzhthWi6D7zlK1MOEJ5bpguwWHeiCyLhye5Tun274p8FZvbpYLWRA7emZZhQfoFtP99GriPgrMc1PP/aV6C5DhXM7wbbEMO8+PfEep77e0w6rvrEg4G4XM/8wN/ZzVTkQFMpIPYSbErRZGqxQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhlm5io7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A05C4CEF7;
	Thu,  6 Nov 2025 22:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468424;
	bh=9k9T61FxKCRkwrh7WhS1tkL4gfH6J81j8cHZxZYsYzE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=uhlm5io7QfL7ZchoYa9OUCcvCS/GI8nDsjU+1ukxjnKp3fseFbrTYtb3BtLhEfuTL
	 8iigf4cHjlJo3ZVzZkE3CgvAxeIPPYfLvZSUsPNWrxSC89apF6t8C6IZpVKKYxsHxF
	 uTNgWu0jEra6jRjrmdvtjRev0oH0I2J1/8zPoxfSoFEBSvx8KERSLrfFkL6ZffB9zX
	 M5f2IUYBv/NVyPABtzdx1NAno8kr6rh26dlpy8fth8JTo7SjU+W45lx9qv8LpB1KGu
	 n96PKr/qm7kpvCkI5Hr1LBIPmErLN1JjFFPA2GCqWuvijmmAZtmv7OLNPi5GC1gOE8
	 oXajgiQpBl1WQ==
Date: Thu, 06 Nov 2025 14:33:44 -0800
Subject: [PATCH 10/19] fuse2fs: implement readdirplus
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793809.2862242.16758268369729874701.stgit@frogsfrogsfrogs>
In-Reply-To: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
References: <176246793541.2862242.16879509838698966689.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Implement "readdirplus", which I think means that we return full stat
information for directory entries as part of the readdir results.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 1f52d7e4e37713..16492d54f7ed1d 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3443,6 +3443,9 @@ struct readdir_iter {
 	fuse_fill_dir_t func;
 
 	struct fuse2fs *ff;
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	enum fuse_readdir_flags flags;
+#endif
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
@@ -3493,8 +3496,23 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
 	if (i->startpos >= i->dirpos)
 		return 0;
 
-	dbg_printf(i->ff, "READDIR %u dirpos %llu\n", i->nr++,
+	dbg_printf(i->ff, "READDIR%s %u dirpos %llu\n",
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+			i->flags == FUSE_READDIR_PLUS ? "PLUS" : "",
+#else
+			"",
+#endif
+			i->nr++,
 			(unsigned long long)i->dirpos);
+
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	if (i->flags == FUSE_READDIR_PLUS) {
+		ret = stat_inode(i->fs, dirent->inode, &stat);
+		if (ret)
+			return DIRENT_ABORT;
+	}
+#endif
+
 	memcpy(namebuf, dirent->name, dirent->name_len & 0xFF);
 	namebuf[dirent->name_len & 0xFF] = 0;
 	ret = i->func(i->buf, namebuf, &stat, i->dirpos
@@ -3513,7 +3531,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
+			, enum fuse_readdir_flags flags
 #endif
 			)
 {
@@ -3526,6 +3544,9 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		.ff = ff,
 		.dirpos = 0,
 		.startpos = offset,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+		.flags = flags,
+#endif
 	};
 	int ret = 0;
 


