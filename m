Return-Path: <linux-ext4+bounces-9046-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238C2B09008
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 17:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EDBA6055C
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 14:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE1D2F8C21;
	Thu, 17 Jul 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZw8B0+C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF6299A8E
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764391; cv=none; b=e+JK8xxWplB84+E8toz2LM9tesmKQdqKu6w5qcDPfJFV+myO4iqIUeIJn0lz6Zpn0fX/YkusFmvXXw1KMvbuANRjB10qmtxldGKAynpj6noGsJWwbvWB+XOOdOBoaoM6J4RJ52limAz/K2OF875kNI5Vl9mP9wEq/xouSXUSbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764391; c=relaxed/simple;
	bh=sbEEuLzwAYN/x60aPYMTT1tkQfGiyX/Svae8WcVM8Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WywBa2BKrgYGiJhCp3sE6LoqetEE+xcHpjT7/c4Pa/pjiIzsHutKaDpg1UgUsmt5MVtj0B4XogSe4Ux/gRpp94eZ4Toahseej+zenKx4v99krIdxYBbD2Nj5mc8gvM7U+MgEjqs1e79gjorgYWeSMJc4Rcr2EcMuM98U9aJLq7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZw8B0+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8D03C4CEE3;
	Thu, 17 Jul 2025 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764390;
	bh=sbEEuLzwAYN/x60aPYMTT1tkQfGiyX/Svae8WcVM8Oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rZw8B0+CjJVoO1sCQhVyylhIXrG0jorPopV2emkgocfGSRh86RYYkVLjF8F6yErVz
	 ZDibWfAi8LUuQG7nDj78CpVtwB2kIJaF525Szuoo7PCod58yBPq0EC2c3fInd/18Mc
	 zyZp1H4Fq/5P6D1nbgYjdZpS6NgLEtq6jeVABVK4FUWcfrU62VG8WQCnuc7RJj3zu5
	 h5whrwtpUm2/H7YssFRd+Y+5o7FnEEMULHwa9Cq5/m5lS9Fx4GDkQGQei8xUp5EYzS
	 PgY7z1sfQW3EdTGVJ43nxmULi8mWWqNMf1YRYCav9bJ7dub+DreS6HOJsciilwoBUn
	 C0M17r+uty0cw==
Date: Thu, 17 Jul 2025 07:59:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 15/8] libext2fs: fix data corruption when writing to inline
 data files
Message-ID: <20250717145950.GJ2672022@frogsfrogsfrogs>
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

Fix various bugs in ext2fs_file_write_inline_data:

 - "count = nbytes - pos" makes no sense since nbytes is already a
   length value and results in short writes if pos > 0.
 - Pass the correct file size to ext2fs_inline_data_set because count
   will not be the file size if pos > 0.
 - Simplify the decision to increase the file size.
 - Don't let a huge write corrupt memory beyond file->buf.
 - Zero the buffer between isize and pos if we're doing a sparse write
   past EOF.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 54e880b870f7fe ("libext2fs: handle inline data in read/write function")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/fileio.c |   27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index 900002c5295682..3a36e9e7fff43b 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -349,31 +349,42 @@ ext2fs_file_write_inline_data(ext2_file_t file, const void *buf,
 			      unsigned int nbytes, unsigned int *written)
 {
 	ext2_filsys fs;
+	uint64_t old_isize = EXT2_I_SIZE(&file->inode);
+	uint64_t new_isize = old_isize;
 	errcode_t retval;
-	unsigned int count = 0;
 	size_t size;
 
+	if (file->pos + nbytes > old_isize)
+		new_isize = file->pos + nbytes;
+
 	fs = file->fs;
 	retval = ext2fs_inline_data_get(fs, file->ino, &file->inode,
 					file->buf, &size);
 	if (retval)
 		return retval;
 
-	if (file->pos < size) {
-		count = nbytes - file->pos;
-		memcpy(file->buf + file->pos, buf, count);
+	/*
+	 * Only try to set new inline data if it won't go past the end of
+	 * @file->buf; if there's not enough space in the ondisk inode, we'll
+	 * jump out to the expand code.
+	 */
+	if (new_isize < fs->blocksize) {
+		if (file->pos > old_isize)
+			memset(file->buf + old_isize, 0, file->pos - old_isize);
+
+		memcpy(file->buf + file->pos, buf, nbytes);
 
 		retval = ext2fs_inline_data_set(fs, file->ino, &file->inode,
-						file->buf, count);
+						file->buf, new_isize);
 		if (retval == EXT2_ET_INLINE_DATA_NO_SPACE)
 			goto expand;
 		if (retval)
 			return retval;
 
-		file->pos += count;
+		file->pos += nbytes;
 
 		/* Update inode size */
-		if (count != 0 && EXT2_I_SIZE(&file->inode) < file->pos) {
+		if (old_isize < new_isize) {
 			errcode_t	rc;
 
 			rc = ext2fs_file_set_size2(file, file->pos);
@@ -382,7 +393,7 @@ ext2fs_file_write_inline_data(ext2_file_t file, const void *buf,
 		}
 
 		if (written)
-			*written = count;
+			*written = nbytes;
 		return 0;
 	}
 

