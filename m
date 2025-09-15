Return-Path: <linux-ext4+bounces-10069-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C94E6B587AF
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7DD1B257CF
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41512D0C9F;
	Mon, 15 Sep 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Inth87oF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9413E2C029E
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976129; cv=none; b=rk3+xq7ElY25ri60T+e1WdnqiaBauCMGVj0fZls7z1mO2anjb2xBt5yInCu/uSpnacoztYacnewUyc5cY3Ww4DqxE3g/wnYKK93uV8w/Xi7GQPwgpdrgOPfUpS1gaTymZnMIyOSZ8pYlVUUSkNfR04FMUI8WWRTvPR6S4yx4jLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976129; c=relaxed/simple;
	bh=syETBmGU+8eSxtw45BfSSdS4o4bfvmWOUrK0nb2a/bw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnVId0ij82E4y7UMlbTC2ezzLy7Ay9/EJ5rCKb0tKFi2kIZHF65BPfXia8jxVhsqKTl2OVlPAkTcHIbTaKVoUsfdfT7In7JEbmkk8R/Hw24aXxIphiwzha5I14UP5xdG7MWpjucjDjp7TLKYrGpd+rutgMKDOm/SiDAcZhBwk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Inth87oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B18AC4CEF1;
	Mon, 15 Sep 2025 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976129;
	bh=syETBmGU+8eSxtw45BfSSdS4o4bfvmWOUrK0nb2a/bw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Inth87oFgyp+8Uig2/XDU+Jy+eSaegIivvmJbhwREBCxe9mfH2wf+VjOUv0uDoxrD
	 gsrobcGN+GGJiO5m6rB8kQiLrzH84KxLfOmVbcNKd+9bu6YHE5EHG2b8xa2g3PtEpx
	 f6rlFYT6ZpfwERfW5faQElgRF18vr37LTbR4SpYb9fR/u5GiBY438QTqDFrpM8ij6b
	 ke205JFEYAoT90fmd//hv9qfR/Bk85HU9L5IwHs0lKFs5mw/skXxRlVdrfQoSSxlRj
	 U/ylp504VWSYum/yxxOEbOmXTNiC+rUKkFJ9lpo2cGH4lH1A4/x4kPXShoISwYB0eQ
	 lfPTviPfWL8Hw==
Date: Mon, 15 Sep 2025 15:42:08 -0700
Subject: [PATCH 05/11] fuse2fs: implement readdirplus
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175797570103.246189.6386783067562525243.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
References: <175797569966.246189.4996503880732213475.stgit@frogsfrogsfrogs>
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
index efcf10fe731f3e..529e42ef820a90 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3363,6 +3363,9 @@ struct readdir_iter {
 	fuse_fill_dir_t func;
 
 	struct fuse2fs *ff;
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	enum fuse_readdir_flags flags;
+#endif
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
@@ -3413,8 +3416,23 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -3433,7 +3451,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
+			, enum fuse_readdir_flags flags
 #endif
 			)
 {
@@ -3446,6 +3464,9 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		.ff = ff,
 		.dirpos = 0,
 		.startpos = offset,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+		.flags = flags,
+#endif
 	};
 	int ret = 0;
 


