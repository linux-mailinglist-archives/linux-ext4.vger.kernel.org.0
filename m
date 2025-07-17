Return-Path: <linux-ext4+bounces-9055-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB48B096BB
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 00:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C340916E6C3
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 22:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CD221FA4;
	Thu, 17 Jul 2025 22:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeqZFXTx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188873597E
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 22:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789678; cv=none; b=uoI4Rh09SkJoQJlvJpt/AMAwwa/7hMvz/wcxtZ+Ed8eITqeeDCbtbqaYx/bSAli6XkbbpGlGT/V4gtPfQN0QnHsijHFCUHwyEJIYyj+FrXNcTQA3HjDYoP7G62SV2gA9XDjALOBCF5+ItTVilE9P6wryhf9KxfeQSe42M4pALbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789678; c=relaxed/simple;
	bh=CZoAU1G6zyrGaMij6mSwXVihPyU2F6QaxpEZEkfgTBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdjKe4mAVnIxfE8AjYa3egu40FmKdl2/DeV+NtKv8rCOh2/pru51EDJod5i7ASZte4h+4t/NKnFaBAEYj0ESBWCY7GCtiQ+InNDQrzF0muIx1f/jLxi99lPSj+bk06PFzJE43QQQUqY4Y9j8X73qOKi5WiJ1YBfGzLWuiNMBZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeqZFXTx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B63C4CEF0;
	Thu, 17 Jul 2025 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752789675;
	bh=CZoAU1G6zyrGaMij6mSwXVihPyU2F6QaxpEZEkfgTBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeqZFXTxiSaqVWniiU3AYhfDdnl6AHUrFF0PD+UdHNUKuNpjw8iT1Q7sxHadM7RvH
	 9sRDyqEl9Fuo0+yPLn3fWCSOmXvhpHSrRcRuNIdGQ3qXWY75sd+FCXG2yFrGHvL0Z7
	 uYNko5O5S/NItJ40ryKct1tYHfxBUjIyABimoFVk95bqpWTBB/s09mfzqqU0WgNmfS
	 NrIqbda4tAzF2O+OBpMtAvrqwjVk5+afAHfO8YYu0N6xH4+7UeWyqovyclG9ET6H2z
	 P8UMM9MIKFh30wgumI0CZU5Q/DqlbQ33Z6AD4LO5EAKVgD4OZF+9jyfc2Z8RwRQMVc
	 lBgex2D81YPKA==
Date: Thu, 17 Jul 2025 15:01:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 16/8] fuse2fs: fix clean_block_middle when punching byte 0 of
 a block
Message-ID: <20250717220114.GL2672022@frogsfrogsfrogs>
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

In non-iomap mode, generic/008 tries to fzero the first byte of a block
and fails:

--- a/tests/generic/008.out      2025-07-15 14:45:14.937058680 -0700
+++ b/tests/generic/008.out.bad        2025-07-16 11:43:42.427989360 -0700
@@ -4,8 +4,7 @@
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 1024
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
-00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
+00000000:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
 *
 00000400:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
 *

Here we can clearly see that the first byte of the block has not been
zeroed, even though that's what the caller wanted us to do.  This is due
to an incorrect check of the residue variable that was most likely copy
pasted from clean_block_edge years ago.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index bff303a10e7186..6155dff6645ff6 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -4007,14 +4007,10 @@ static errcode_t clean_block_middle(struct fuse2fs *ff, ext2_ino_t ino,
 {
 	ext2_filsys fs = ff->fs;
 	blk64_t blk;
-	off_t residue;
+	off_t residue = FUSE2FS_OFF_IN_FSB(ff, offset);
 	int retflags;
 	errcode_t err;
 
-	residue = FUSE2FS_OFF_IN_FSB(ff, offset);
-	if (residue == 0)
-		return 0;
-
 	if (!*buf) {
 		err = ext2fs_get_mem(fs->blocksize, buf);
 		if (err)

