Return-Path: <linux-ext4+bounces-5795-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1429F8AAC
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 04:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12792188A1D2
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B193BB48;
	Fri, 20 Dec 2024 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RGcQdH4w"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B646918641
	for <linux-ext4@vger.kernel.org>; Fri, 20 Dec 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734666391; cv=none; b=ZfoyO+HonzxP3//MBxskRGYXveQSzmt4OQzfzdRYMDtb8d6PHuFHknqKdJjlL47uK+TW4yJxat+X5rRAzN+sc0NJ7XUcXMzqHbECiaOJjLG4rrdO+krc904pb1ZcYL/NXJ4MMvPWT8C7U4rtCcEYzKNK24TzIiHsnW4usP1QgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734666391; c=relaxed/simple;
	bh=RE+73w8222oSZAST9t1x13ETpjuLRjO+n4gVipAXvZA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sxa3KYU7gmi6BurSabYZQu5epEvXxVl7DT8x3Pb93nbrpekUAs6kjJ9aR7B34Yd2LSzVBCWGyaiE2Muv4ZMGbBzfn7u9S9kKD0WTId31YExkgXmx0ofEer/E/ODV0sBVOw0xfjRbmP4I+NHD+P4JCHlxx7TTOyigdo2q2ehj+Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RGcQdH4w; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sarthakkukreti.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-728eda1754eso2102169b3a.2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Dec 2024 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734666389; x=1735271189; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GWORy8/wFQU8P1QVtY5SXf+TsuhH732H7iICYc/uHfE=;
        b=RGcQdH4wxgM+9br+aX23M5kdPkGsaL4jfn1UGNSMCNbgST8JfihJMBKYoJJV8zNH7a
         RLnqtrvam6b4+K1eyzl5vcJgzA1IjUFdujrLEhzHZAIwYUjEg9sl7aLtLzrTTRu2yT5O
         Z9c8WOO3FsQ2Z3LOKc8C2UIzCzL49S03dt8qivvGwxPySQLdrTEjFgVN841nOBH9oORL
         bRrWrTKmHxYVgM4HAsLRqipzRSqR5+0soE6ygXdHPm7esK/ZrPBOTvHw3WL4l0US6+p8
         jSy1v048mfOKoP2be4oL047QF9gWX89baxv0SqmzCLgL2qscAahmuotSMjjmxGxxOT4Q
         hx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734666389; x=1735271189;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWORy8/wFQU8P1QVtY5SXf+TsuhH732H7iICYc/uHfE=;
        b=WSqGjbq9Q4cxCgWwy6z/ctVOngt+tbbUI5ErqGMCH0tJlsVuoaBriH8dpQUXFIAzy9
         RveC6UFwSa29R/d2kcMWh7QQaP7u/rebxeTKilZKoqIfhGdYu778rpqT+IG2cI6G/ECi
         8v3/VLORJZNIEXywAsaSfcgNjQVrHJ+UHvZEer/c+brdsFs+4zEFmgDTAcjfAopAzC4L
         9dcNxIq7U1iNWcBI+N2TNM+Cfpd+mHUndptEuwJ9ksPVCuO1vYjUjFlB4C4oH23nRKHD
         fv4Wk+Vu+h+EwuFE38N2N+tRSYOcSMOePoYGqO/ZmEtkLBLr+cVm7eTBncmcPpWRqClC
         qA9g==
X-Gm-Message-State: AOJu0Yz7+VGpL9UDt9//C1O3Z5mPqhzjZpWfW5MwLmT3LiGhtZx7uND5
	ngnLjZ2f3AWytbHfJwwlydlao2Zdj2dVCsuWSmje/YAryuc1Gdh3D0CmmUWWGrZUnQsEUckZNew
	omO3KPMppripG5jr83035qnYMMSScNjuSBX5PD0D6azlXTB6zUz4H6pbpepdW1q89MWR8dAttt7
	utJQ7MjkJgVp2TaAyTXzNufqbmC26ZdTHrh3pbOf2iAPu3qwCRn/3WeK/8oDI2be3ErC24ZVbct
	XzUqDq/
X-Google-Smtp-Source: AGHT+IGE4cgPET2apFfSsP/hIUsJmAi5bsO7KOfvtOsfPypkMQmt5OweiJ2QouN/5HnhurNZvn3yWzSJsH8Ams51D2ebwA==
X-Received: from pfbbd10.prod.google.com ([2002:a05:6a00:278a:b0:728:e508:8a48])
 (user=sarthakkukreti job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1706:b0:726:f7c9:7b36 with SMTP id d2e1a72fcca58-72abdd7bacdmr1883003b3a.8.1734666388909;
 Thu, 19 Dec 2024 19:46:28 -0800 (PST)
Date: Thu, 19 Dec 2024 19:46:13 -0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241220034613.3624898-1-sarthakkukreti@google.com>
Subject: [PATCH v2] fallocate: Add support for fixed goal extent allocations
From: Sarthak Kukreti <sarthakkukreti@google.com>
To: linux-ext4@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Sarthak Kukreti <sarthakkukreti@google.com>
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

Changes from v1 (https://lists.openwall.net/linux-ext4/2024/12/12/38):
- s/EXT2_NEWRANGE_EXACT_GOAL/EXT2_NEWRANGE_FIXED_GOAL

---
 lib/ext2fs/alloc.c     |  2 +-
 lib/ext2fs/ext2fs.h    |  3 ++-
 lib/ext2fs/fallocate.c | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/lib/ext2fs/alloc.c b/lib/ext2fs/alloc.c
index 3fd92167..ba5b1c5e 100644
--- a/lib/ext2fs/alloc.c
+++ b/lib/ext2fs/alloc.c
@@ -390,7 +390,7 @@ no_blocks:
 /*
  * Starting at _goal_, scan around the filesystem to find a run of free blocks
  * that's at least _len_ blocks long.  Possible flags:
- * - EXT2_NEWRANGE_EXACT_GOAL: The range of blocks must start at _goal_.
+ * - EXT2_NEWRANGE_FIXED_GOAL: The range of blocks must start at _goal_.
  * - EXT2_NEWRANGE_MIN_LENGTH: do not return a allocation shorter than _len_.
  * - EXT2_NEWRANGE_ZERO_BLOCKS: Zero blocks pblk to pblk+plen before returning.
  *
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
2.47.1.613.gc27f4b7a9f-goog


