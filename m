Return-Path: <linux-ext4+bounces-5605-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F79EFF89
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 23:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FECD188D7A8
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2024 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7F1DE2C1;
	Thu, 12 Dec 2024 22:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SA9hZYRC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBA61AD9ED
	for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734043804; cv=none; b=rNH5sHcxbouaXYWuwgTnFXPziWyQrJ4SwWBI21+46IYZ7+lTJ6gSQpFs64wi96SuJNOF2x47/UgwQBJqN/PjN3ATTbovsR+eopWX+uEnccdJujfVBM/8Gs3ERg/rPv0V5OJOKNHHDi6kLhtK0rleGqaJPIPg41PV+ipOKWGblYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734043804; c=relaxed/simple;
	bh=G/FV7agR9bxAOaKCQ+51I4SnB6CYxS8tMu1TiggOWgo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T6im22VpWEXQUHG3ykZgK1uzx4QimnQ7kTUS5UvseofyzCaOf/xjGTlEXFgAS9mc5uKtkbWX8ox1/+CTj01GoDmPPTiVzalfP9jld1BMgpjqljl2r9KBXwy8PzlkXdpM8MWbFPlxPcQesfCcruk5/YcGqLsS5xa45kUm75Fr3gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SA9hZYRC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee9f66cb12so1083959a91.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2024 14:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734043802; x=1734648602; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JNwhu1pE/bLqAV1dlV+7XfKl5QR9MpvKolsp0o8IeY4=;
        b=SA9hZYRCJGmYBBGFTbquEo9DD1v/v4TxNjee8N3acNzywWpxzxuXtJnYoyC5V0BYVB
         XUCdXNnM75v7hpPbxwIc8dC5rohvUrub2rqzICtu6jMoHGQsv5WVxUrakZdDRoxDu2/0
         GlT0ekHq7QyMbOUu/PUZDIO+Xut7I/wJr/YaR291e5UtVDFyxaurjWmt0qXQ8iMNPIq8
         BP7MF8/tae+XTE85H8N7pCRwcLyS0KTgSq7+ZGudFX4PuNsMTg1XnU2JWOl9pW4W+/C5
         YiMt0vkG98Qb8x1luTbi2w0gSXv9SGFVRTHDqlnR3jkND5R83kI5M5lLN1EyTpBKAgq2
         m89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734043802; x=1734648602;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JNwhu1pE/bLqAV1dlV+7XfKl5QR9MpvKolsp0o8IeY4=;
        b=p3kWTCkMG0J9KmyBvK7iXwNeOrlQ5xAUE3xQ77nSY/f72q+d38BYqHEQmR5Vne5bAZ
         0suBKO8M0rQ/+4yqcrheyrf/xdRBPxfB0g+VbCN/tZkPFspY8q8A/csrKmw/aVQQ2ehZ
         8lpC1PCfYBCpRDPGG94i8lVaWKgLwPbo75eMM17BPYMsjwTqFIjoq9cH5TEonIGAwlkC
         OFlPE4hNq8+DQwBeY6pmUaJS7Hre7KQ5bTP4FAsq9YQ8LYuSMeTYUgMHLUrf/i9xvIpF
         /U7AU0iC4g9RCicq4IkSPpEj6lyjhCDOSjm8YR+7ltQtVrLkH81T616sc5N4KkAHnvnF
         sH+g==
X-Gm-Message-State: AOJu0YyD44WcbS6fQmS5rkCRtfGTEPnF0xsjfPThCRi6d8Ge88Lbs+M/
	5E1g7Zz7N3hK+KBY9K5oO1wUCDdSFd0wgbRJ0Cyb8xE1c5HG4Iy2whbA1lq1icW+5TMWyCX1RP1
	cXLZYKBGqX4ibLWJ6bVqGIJ00uj1TPrJ7Gpsn++EPPW75HdGBZaVXl1GXoFqqmMsL020kQR10VK
	pAsBRV2VOVeM6hFFkvzEQn6SYiNA2B+w5c9TnhH8PmZJeis6LxIPvZtpyzRNMjM/h/9kDsTiL7f
	XZwKsfO
X-Google-Smtp-Source: AGHT+IFdnfYHYYd8JyqpRzTVX/jxElSsvkkU6UEbDc6Q7UgPTJ6nCQyPQl4sPCawhuifiCm81CClKS4KYCSvOXAoK4yOtQ==
X-Received: from pjh7.prod.google.com ([2002:a17:90b:3f87:b0:2ef:a732:f48d])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5444:b0:2ee:a04b:92d3 with SMTP id 98e67ed59e1d1-2f2901b4011mr592034a91.34.1734043802345;
 Thu, 12 Dec 2024 14:50:02 -0800 (PST)
Date: Thu, 12 Dec 2024 14:49:58 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212224958.62905-1-sarthakkukreti@google.com>
Subject: [PATCH] fallocate: Add support for fixed goal extent allocations
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: linux-ext4@vger.kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, "Theodore Ts'o" <tytso@mit.edu>, 
	Sarthak Kukreti <sarthakkukreti@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a new flag to add support for fixed goal allocations in
ext_falloc_helper. For fixed goal allocations, omit merging extents and
return an error unless the exact extent is found.

Use case:
On ChromiumOS, we'd like to add the capability of resetting a filesystem
while preserving a set of files in-place. This will be used during
filesystem reset flows where everything apart from select files (which
contain system applications) should be removed: the combined size of the
files can exceed the amount of available space in other
partitions/memory. The reset process will look something like:

1. Reset code dumps the FIEMAP of the set of preserved files into a
file.
2. Mkfs.ext4 is called on the filesystem with -E nodiscard.
3. Post mkfs, the reset code will utilize ext2fs_fallocate w/
EXT2_FALLOCATE_FIXED_GOAL | EXT2_FALLOCATE_FORCE_INIT on the extent list
created in step 1.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
---
 lib/ext2fs/ext2fs.h    |  3 ++-
 lib/ext2fs/fallocate.c | 21 +++++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 6e87829f..313c5981 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1446,7 +1446,8 @@ extern errcode_t ext2fs_decode_extent(struct ext2fs_extent *to, void *from,
 #define EXT2_FALLOCATE_FORCE_INIT	(0x2)
 #define EXT2_FALLOCATE_FORCE_UNINIT	(0x4)
 #define EXT2_FALLOCATE_INIT_BEYOND_EOF	(0x8)
-#define EXT2_FALLOCATE_ALL_FLAGS	(0xF)
+#define EXT2_FALLOCATE_FIXED_GOAL	(0x10)
+#define EXT2_FALLOCATE_ALL_FLAGS	(0x1F)
 errcode_t ext2fs_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
 			   struct ext2_inode *inode, blk64_t goal,
 			   blk64_t start, blk64_t len);
diff --git a/lib/ext2fs/fallocate.c b/lib/ext2fs/fallocate.c
index 5cde7d5c..20aa9c9f 100644
--- a/lib/ext2fs/fallocate.c
+++ b/lib/ext2fs/fallocate.c
@@ -103,7 +103,7 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
 				   blk64_t alloc_goal)
 {
 	struct ext2fs_extent	newex, ex;
-	int			op;
+	int			op, new_range_flags = 0;
 	blk64_t			fillable, pblk, plen, x, y;
 	blk64_t			eof_blk = 0, cluster_fill = 0;
 	errcode_t		err;
@@ -132,6 +132,9 @@ static errcode_t ext_falloc_helper(ext2_filsys fs,
 	max_uninit_len = EXT_UNINIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
 	max_init_len = EXT_INIT_MAX_LEN & ~EXT2FS_CLUSTER_MASK(fs);
 
+	if (flags & EXT2_FALLOCATE_FIXED_GOAL)
+		goto no_implied;
+
 	/* We must lengthen the left extent to the end of the cluster */
 	if (left_ext && EXT2FS_CLUSTER_RATIO(fs) > 1) {
 		/* How many more blocks can be attached to left_ext? */
@@ -605,12 +608,15 @@ no_implied:
 		max_extent_len = max_uninit_len;
 		newex.e_flags = EXT2_EXTENT_FLAGS_UNINIT;
 	}
+
+	if (flags & EXT2_FALLOCATE_FIXED_GOAL)
+		new_range_flags = EXT2_NEWRANGE_FIXED_GOAL | EXT2_NEWRANGE_MIN_LENGTH;
 	pblk = alloc_goal;
 	y = range_len;
 	for (x = 0; x < y;) {
 		cluster_fill = newex.e_lblk & EXT2FS_CLUSTER_MASK(fs);
 		fillable = min(range_len + cluster_fill, max_extent_len);
-		err = ext2fs_new_range(fs, 0, pblk & ~EXT2FS_CLUSTER_MASK(fs),
+		err = ext2fs_new_range(fs, new_range_flags, pblk & ~EXT2FS_CLUSTER_MASK(fs),
 				       fillable,
 				       NULL, &pblk, &plen);
 		if (err)
@@ -681,6 +687,16 @@ static errcode_t extent_fallocate(ext2_filsys fs, int flags, ext2_ino_t ino,
 	if (err)
 		return err;
 
+	/*
+	 * For fixed goal allocations, let the allocations fail iff we can't
+	 * find the exact goal extent.
+	 */
+	if (flags & EXT2_FALLOCATE_FIXED_GOAL) {
+		err = ext_falloc_helper(fs, flags, ino, inode, handle, NULL,
+					NULL, start, len, goal);
+		goto errout;
+	}
+
 	/*
 	 * Find the extent closest to the start of the alloc range.  We don't
 	 * check the return value because _goto() sets the current node to the
@@ -796,6 +812,7 @@ errout:
  * - EXT2_FALLOCATE_FORCE_INIT: Create only initialized extents.
  * - EXT2_FALLOCATE_FORCE_UNINIT: Create only uninitialized extents.
  * - EXT2_FALLOCATE_INIT_BEYOND_EOF: Create extents beyond EOF.
+ * - EXT2_FALLOCATE_FIXED_GOAL: Ensure range starts at goal.
  *
  * If neither FORCE_INIT nor FORCE_UNINIT are specified, this function will
  * try to expand any extents it finds, zeroing blocks as necessary.
-- 
2.47.0.rc1.288.g06298d1525-goog

