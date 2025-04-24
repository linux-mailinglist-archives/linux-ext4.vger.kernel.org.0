Return-Path: <linux-ext4+bounces-7482-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F553A9BA14
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 394641BA528A
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7E2222C5;
	Thu, 24 Apr 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1eB65uF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC90214A7A
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531082; cv=none; b=P3Nhrs9i3nZ3obb6msmNvdO+rgbxudUWTpqopT7PsBJldZLdbwKp1IvOTzN/itYkowMSD+a5aX0NLBIUM0cv/Nyrd+VNOFLdKhvGyES25qp8ZLaMYiGd1EOkulSiCTttmzZZ58Lnp8Qc3FPcFHFO5ScDoqbGyUWLvB/1bQf7zPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531082; c=relaxed/simple;
	bh=Qx8Q1UUgJaI0Agsx5pkcLh6uhI10QloDedS//70Vq8I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNW4uc57fx2+inKRjUsXy3sjhQqEMGYGM6fnQYzNZiWB8xLVeJdd1Y1sOM45Vk6PZ2Uwyi6K/47hejqPxuc+UXgkw9EEvqjVD6ljJ7oVrKnHMCXwDy/BhQZUDB+sV6676qNyHSVXoL/TN3UlCXaU0rpvGDfrn4iKpU+V/wAN0pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1eB65uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A20C4CEE3;
	Thu, 24 Apr 2025 21:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531081;
	bh=Qx8Q1UUgJaI0Agsx5pkcLh6uhI10QloDedS//70Vq8I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=O1eB65uF9X0hruodcO+kfSi8RN1YFTJIWLszW1xT16iF4nzJPQ2/lHH6wEmOqFOsV
	 GVWzM8Oo8NkQf6gDV9RWDLMPUTkU3pfn6fNVLRYsgUdt2zIDC6hM0K0pdpT3MUxMzj
	 Bxsm9+whRo0tvvxMBMYe/e2H5Br9nDct25ZBCb8XyYBRx6EishjYisAFp7s/rMgDQD
	 0mfERa6TwQw1zBt0IRyGsf9DGihFhsG+Ry6Z1FNmeO8mpRbCoSv9+kCo7vxzdfOiRe
	 QAmMNzIwM1rUYtHK6gXHm6k5i1L7cNhBRvG/7GlTcED3Qzq1e8LfE2Dr7hANZ+T77V
	 8dt/5VDVDSIDw==
Date: Thu, 24 Apr 2025 14:44:41 -0700
Subject: [PATCH 15/16] fuse2fs: fix FITRIM validation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065195.1160461.15575039465292160279.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Fix the validation here to match the kernel, and report the number of
blocks trimmed.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 420fbfd5db5969..5a6b607ead9b4b 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -3206,17 +3206,27 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 {
 	ext2_filsys fs = ff->fs;
 	struct fstrim_range *fr = data;
-	blk64_t start, end, max_blocks, b, cleared;
+	blk64_t start, end, max_blocks, b, cleared, minlen;
+	blk64_t max_blks = ext2fs_blocks_count(fs->super);
 	errcode_t err = 0;
 
+	if (!fs_writeable(fs))
+		return -EROFS;
+
 	start = fr->start / fs->blocksize;
 	end = (fr->start + fr->len - 1) / fs->blocksize;
-	dbg_printf(ff, "%s: start=%llu end=%llu\n", __func__, start, end);
+	minlen = fr->minlen / fs->blocksize;
+
+	if (EXT2FS_NUM_B2C(fs, minlen) > EXT2_CLUSTERS_PER_GROUP(fs->super) ||
+	    start >= max_blks ||
+	    fr->len < fs->blocksize)
+		return -EINVAL;
+
+	dbg_printf(ff, "%s: start=%llu end=%llu minlen=%llu\n", __func__,
+		   start, end, minlen);
 
 	if (start < fs->super->s_first_data_block)
 		start = fs->super->s_first_data_block;
-	if (start >= ext2fs_blocks_count(fs->super))
-		start = ext2fs_blocks_count(fs->super) - 1;
 
 	if (end < fs->super->s_first_data_block)
 		end = fs->super->s_first_data_block;
@@ -3230,17 +3240,23 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	while (start <= end) {
 		err = ext2fs_find_first_zero_block_bitmap2(fs->block_map,
 							   start, end, &start);
-		if (err == ENOENT)
-			return 0;
-		else if (err)
+		switch (err) {
+		case 0:
+			break;
+		case ENOENT:
+			/* no free blocks found, so we're done */
+			err = 0;
+			goto out;
+		default:
 			return translate_error(fs, fh->ino, err);
+		}
 
 		b = start + max_blocks < end ? start + max_blocks : end;
 		err =  ext2fs_find_first_set_block_bitmap2(fs->block_map,
 							   start, b, &b);
 		if (err && err != ENOENT)
 			return translate_error(fs, fh->ino, err);
-		if (b - start >= fr->minlen) {
+		if (b - start >= minlen) {
 			err = io_channel_discard(fs->io, start, b - start);
 			if (err)
 				return translate_error(fs, fh->ino, err);
@@ -3250,6 +3266,8 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 		start = b + 1;
 	}
 
+out:
+	fr->len = cleared;
 	return err;
 }
 #endif /* FITRIM */


