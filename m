Return-Path: <linux-ext4+bounces-9056-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF387B096BC
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 00:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881EC1C463BD
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Jul 2025 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D20221FA4;
	Thu, 17 Jul 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r61SRYts"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29C3597E
	for <linux-ext4@vger.kernel.org>; Thu, 17 Jul 2025 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752789700; cv=none; b=NBRv7+1oQR6z2qK/Dh/2ZZ01DwfoABOpuGSnxV5/eY2exNGQXkCPE5rt2kiufCSwm2mgyxpEYfZy86cZl8jrcqu6OGbEFT3K+VQRu4ySfZ/Lqpmq9fN7c9sZL86QsvYhSOb4zwE4PBiFo+YpX/Ww0OiNe0hv3YNszcRBuev6PkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752789700; c=relaxed/simple;
	bh=d41LvhScys0Uu0XIYHPX7hVU/qGZ+XCdcf+7sRVC1E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCLpydBHwaQKBVXr1SxGjlx64mcPnyFBSP93nwTEz+tlLM/hpZsZNGLzqNUnob3sRapcr7HoNTAVI/bhZ8iyZkTM+pJtQagaRXbb2lZr+10sBZyTlQOtA5OPApoUQptvM1lKhDrZmOkCn7NVQDJiZHmL4eyCB6OPVj5gV96PaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r61SRYts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25252C4CEE3;
	Thu, 17 Jul 2025 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752789700;
	bh=d41LvhScys0Uu0XIYHPX7hVU/qGZ+XCdcf+7sRVC1E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r61SRYtsENZa3f/Wpy9iuh79T1tRkkd5O7xqsO2HGRkpwbTOLLdz+u4lv6qZHGOYL
	 jOHwZnJaehroxvSLJBEMyOIgzVeUOQ++4+8wGFgp0dh2A59/YAoPQDQWADCfzJECeE
	 a8WPjK8iB9Q22l4uisT09Puk+F/HQWT+hrNiFkwpFY8dh8toV3gjBlr4AYaBPtZlNd
	 CGTj7B/LXXzyNF9A5QBH7FS0xRXEUfOu6nPxOLy/oUl0xMU1M2Wm1YzsLC4bqGWOt8
	 /jAaiOkI+OnpD5jDWY9jREHybl48ptcVg5ln1F30cR2fiqxtjg2jT5IkAjTpCLN45R
	 2iLLUs19nzVLg==
Date: Thu, 17 Jul 2025 15:01:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 17/8] fuse2fs: fix punch-out range calculation in
 fuse2fs_punch_range
Message-ID: <20250717220139.GM2672022@frogsfrogsfrogs>
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
and instead zeroes the entire file:

--- a/tests/generic/008.out      2025-07-15 14:45:14.937058680 -0700
+++ b/tests/generic/008.out.bad        2025-07-16 13:31:03.909315508 -0700
@@ -4,10 +4,7 @@
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 1024/1024 bytes at offset 1024
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-00000000:  00 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  .AAAAAAAAAAAAAAA
-00000010:  41 41 41 41 41 41 41 41 41 41 41 41 41 41 41 41  AAAAAAAAAAAAAAAA
-*
-00000400:  42 42 42 42 42 42 42 42 42 42 42 42 42 42 42 42  BBBBBBBBBBBBBBBB
+00000000:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 *
 read 2048/2048 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

Looking at the fuse2fs debugging output, the reason why is obvious:

FUSE2FS (sda): op_fallocate: ino=50 mode=0x10 start=0x0 end=0x1
FUSE2FS (sda): fuse2fs_punch_range: ino=50 mode=0x11 offset=0x0 len=0x1 start=0 end=0

start and end are both zero, so we call ext2fs_punch with those
arguments.  ext2fs_punch interprets [start, end] as a closed interval
and removes block 0, which is not what we asked for!

The computation of end is also too subtle -- the dividend is the
expression (0 + 1 - 4096) which produces a negative number because off_t
is defined to be long long, at least on amd64 Linux.  We rely on the
behavior that dividing a negative dividend by a positive divisor
produces a quotient of zero.

Really what we should do here is round offset up to the next fsblock
and offset+len down to the nearest fsblock.  The first quantity is the
first byte of the range to punch and the second quantity is the next
byte past the range to punch.  Using those as the basis to compute start
and end, the punch should only happen if start < end, and we should pass
[start, end - 1] to ext2fs_punch because it expects a closed interval.

Improve the comments here so that I don't have to work all this out
again the next time I read through here.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 6155dff6645ff6..cee9e657c36767 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -124,6 +124,28 @@
 
 static ext2_filsys global_fs; /* Try not to use this directly */
 
+static inline uint64_t round_up(uint64_t b, unsigned int align)
+{
+	unsigned int m;
+
+	if (align == 0)
+		return b;
+	m = b % align;
+	if (m)
+		b += align - m;
+	return b;
+}
+
+static inline uint64_t round_down(uint64_t b, unsigned int align)
+{
+	unsigned int m;
+
+	if (align == 0)
+		return b;
+	m = b % align;
+	return b - m;
+}
+
 #define dbg_printf(fuse2fs, format, ...) \
 	while ((fuse2fs)->debug) { \
 		printf("FUSE2FS (%s): " format, (fuse2fs)->shortdev, ##__VA_ARGS__); \
@@ -4095,11 +4117,18 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (!(mode & FL_KEEP_SIZE_FLAG))
 		return -EINVAL;
 
-	/* Punch out a bunch of blocks */
-	start = FUSE2FS_B_TO_FSB(ff, offset);
-	end = (offset + len - fs->blocksize) / fs->blocksize;
-	dbg_printf(ff, "%s: ino=%d mode=0x%x start=%llu end=%llu\n", __func__,
-		   fh->ino, mode, start, end);
+	/*
+	 * Unmap out all full blocks in the middle of the range being punched.
+	 * The start of the unmap range should be the first byte of the first
+	 * fsblock that starts within the range.  The end of the range should
+	 * be the next byte after the last fsblock to end in the range.
+	 */
+	start = FUSE2FS_B_TO_FSBT(ff, round_up(offset, fs->blocksize));
+	end = FUSE2FS_B_TO_FSBT(ff, round_down(offset + len, fs->blocksize));
+
+	dbg_printf(ff,
+ "%s: ino=%d mode=0x%x offset=0x%jx len=0x%jx start=0x%llx end=0x%llx\n",
+		   __func__, fh->ino, mode, offset, len, start, end);
 
 	err = fuse2fs_read_inode(fs, fh->ino, &inode);
 	if (err)
@@ -4120,10 +4149,14 @@ static int punch_helper(struct fuse_file_info *fp, int mode, off_t offset,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	/* Unmap full blocks in the middle */
-	if (start <= end) {
+	/*
+	 * Unmap full blocks in the middle, which is to say that start - end
+	 * must be at least one fsblock.  ext2fs_punch takes a closed interval
+	 * as its argument, so we pass [start, end - 1].
+	 */
+	if (start < end) {
 		err = ext2fs_punch(fs, fh->ino, EXT2_INODE(&inode),
-				   NULL, start, end);
+				   NULL, start, end - 1);
 		if (err)
 			return translate_error(fs, fh->ino, err);
 	}

