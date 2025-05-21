Return-Path: <linux-ext4+bounces-8114-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC15BABFFE9
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 457B71BC4A50
	for <lists+linux-ext4@lfdr.de>; Wed, 21 May 2025 22:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6D239E9C;
	Wed, 21 May 2025 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rINOENeQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF1239E85
	for <linux-ext4@vger.kernel.org>; Wed, 21 May 2025 22:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747867445; cv=none; b=lOae9x4i9tsnwrtroQNgHXm3+2vja/9E94gRxd5FILl34xmmbcwW2eK77RRkwpbXj/nYnWvNFYyS0R82SeTSqIhS7zQGI05R2fDtpbinR+EXv3ZaaGtIaQZMMu+Z/l1TFOuvIMWFCVtWkS4+/n8kYTO2f/fGoXropX25dx/97tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747867445; c=relaxed/simple;
	bh=3ToiZVOZ9fEDVkSWE65QhnAXp+tYm2dLxPXseErLnOE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOQaGvxy27TAOUtKEJYwtxwAq6PoHaMOV1XngJaKtlNds3+qJBlRGgpBwTFoxDisDwaoPL/HtM2EG2aHAPmBeAdEzCeyXDJeCdgCfCupX3+fFTKfgqO5HAz2I3xa5oqJvYP7cL2a4Uz2bkZ/Iz9r/Yljqhn1NZU4CFHPUfMI/FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rINOENeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C90C4CEE4;
	Wed, 21 May 2025 22:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747867444;
	bh=3ToiZVOZ9fEDVkSWE65QhnAXp+tYm2dLxPXseErLnOE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=rINOENeQE2pMscWpi//uQuW/nTTwlDJS0zaOvxB9EeDC+f7fjewfEGmJhDADOPPSN
	 6aO2RSzAaFjyQG5pU88yUI2GnYRsNRXOtP5go8X0xa4JcKMafxYgMM+222PhKkqhze
	 TQVn+g+iLwQw8JY0spXQkcefAUuQMpVsEBOJt/TjWln3POhVFDzRcpFzL1Vtl1lOwk
	 yJ5kA84nI2EBvDmfgeeRr9PQ+WcxfwWrsJDfwEgQniwH+rprN74LFL7sZPK4aoDeUm
	 d8eLewowUkTWEAJiHMQSUrNKdE/hAdyncRn5mrA3l8E0xNFYsatUx5wqqs+hiltCVh
	 T0CHp99/vdXcw==
Date: Wed, 21 May 2025 15:44:04 -0700
Subject: [PATCH 3/7] fuse2fs: implement readdirplus
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174786678453.1385038.15146001311548080114.stgit@frogsfrogsfrogs>
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

Implement "readdirplus", which I think means that we return full stat
information for directory entries as part of the readdir results.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 7ffe8a7e5dd4c0..fc338058835360 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3107,6 +3107,9 @@ struct readdir_iter {
 	fuse_fill_dir_t func;
 
 	struct fuse2fs *ff;
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+	enum fuse_readdir_flags flags;
+#endif
 	unsigned int nr;
 	off_t startpos;
 	off_t dirpos;
@@ -3157,8 +3160,23 @@ static int op_readdir_iter(ext2_ino_t dir EXT2FS_ATTR((unused)),
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
@@ -3177,7 +3195,7 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		      off_t offset,
 		      struct fuse_file_info *fp
 #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
-			, enum fuse_readdir_flags flags EXT2FS_ATTR((unused))
+			, enum fuse_readdir_flags flags
 #endif
 			)
 {
@@ -3190,6 +3208,9 @@ static int op_readdir(const char *path EXT2FS_ATTR((unused)),
 		.ff = ff,
 		.dirpos = 0,
 		.startpos = offset,
+#if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
+		.flags = flags,
+#endif
 	};
 	int ret = 0;
 


