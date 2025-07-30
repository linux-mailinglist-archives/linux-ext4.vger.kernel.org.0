Return-Path: <linux-ext4+bounces-9241-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9F1B1656C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 19:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C4717D18C
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jul 2025 17:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804A2DFA26;
	Wed, 30 Jul 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGi9Uz/E"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5E72DF3D9
	for <linux-ext4@vger.kernel.org>; Wed, 30 Jul 2025 17:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896205; cv=none; b=ZOBsJ4GRUhS5nbaTDrBmYvrzy/zIuPMAduoqq4iBJ7yPjInLC8M1pEyTPdyYi9MQ3BVNQvjlVP0NMPJwJ1VtGeX8t1z9ipqd16+tOXvrQOk/oNHR+XhArqLHZbhcS27mk3Ne+JczGeOFbCJeMeEWy66teADIzEk7A/u/0ipCwME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896205; c=relaxed/simple;
	bh=yXJaQpy9wNYQ6zuuNpj8XVtbpwvtlQ0kHoIWmLeHG48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/4r1x1P2tIDAH5wn/Zh9oo8CnTk06Z0XRBWFzzty+sE686D/F0cylmHuymG7MI/QTDv+hD1dLsyJeG2JJ/9osEnuM5Pk3/BC3CKlVc/9gDRgkMBNIPbuvWMtONblltNMQBjLGrNzDXoYBP4Axl+QJ6Vt5kqUamWDYQK7g6RQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGi9Uz/E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F39CC4CEE3;
	Wed, 30 Jul 2025 17:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753896205;
	bh=yXJaQpy9wNYQ6zuuNpj8XVtbpwvtlQ0kHoIWmLeHG48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGi9Uz/E0NY3mriIkQZu12Fs39VvIGffQLmeGbvUDx9SN1KAzeNRgY2pLEV7U0pCK
	 JFj0T8DQCoilo4ziwriRI9fEcICyo+sEQ9uIxWUQ9+PZjvyFNx2pxAgmu9jB5nS59V
	 i5RcdosAd6gmYhZiPovetHCA/YzE8cQ/BMdAEvfCHdmT4f+7tiXDEF6F3sqcjkFytd
	 uBHFN7ZOnMzcPl6INveAXgoYYsnBt5U6jld0EF2R0ePccEmLH2ZPHKQbTAA9Rj20nE
	 Uocimrn2us6MmRoJ45GdQfp1e1x+steXAWtDER4/LC1YFf+EnJw8B35zck5tQwm23T
	 5B42+3tESdYOQ==
Date: Wed, 30 Jul 2025 10:23:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 21/8] fuse2fs: fix block parameter truncation on 32-bit
Message-ID: <20250730172324.GR2672022@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Use the blk64_t variants of the io channel read/write methods when we
have to do partial block zeroing for hole punching because otherwise
we corrupt large 64-bit filesystems on 32-bit fuse2fs due to integer
truncation.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c6b1684f53e2e4..4d42a634bf377b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4168,13 +4168,13 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 	if (!blk || (retflags & BMAP_RET_UNINIT))
 		return 0;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_blk64(fs->io, blk, 1, *buf);
 	if (err)
 		return err;
 
 	memset(*buf + residue, 0, len);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_blk64(fs->io, blk, 1, *buf);
 }
 
 static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
@@ -4202,7 +4202,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	if (err)
 		return err;
 
-	err = io_channel_read_blk(fs->io, blk, 1, *buf);
+	err = io_channel_read_blk64(fs->io, blk, 1, *buf);
 	if (err)
 		return err;
 	if (!blk || (retflags & BMAP_RET_UNINIT))
@@ -4213,7 +4213,7 @@ static errcode_t clean_block_edge(struct fuse2fs *ff, ext2_ino_t ino,
 	else
 		memset(*buf + residue, 0, fs->blocksize - residue);
 
-	return io_channel_write_blk(fs->io, blk, 1, *buf);
+	return io_channel_write_blk64(fs->io, blk, 1, *buf);
 }
 
 static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,

