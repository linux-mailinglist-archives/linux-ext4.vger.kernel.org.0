Return-Path: <linux-ext4+bounces-11563-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21321C3D9CB
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10A464E540E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA682F657E;
	Thu,  6 Nov 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ej9tn1jz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9255F273D68
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468329; cv=none; b=WJ3dUIfdue7bq/Up+BxpVSZKx+ItbS2d76hrLldYX7lAP3T7JNz750PiYBOy2Ay/8YLIC2dX3Tl0x3SPd7F6FqmNJhKvjpmO5wm/VtQGdtBPUthQpi0Ha2irms+PX/btEFlIYg720tps0lJrPYG0axEz0X/ZmGhYQpYryf/Ck0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468329; c=relaxed/simple;
	bh=6nR/knrnsFkm2TOimUGIeoCqQMcpi356eD3Qp5WUf0c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqAdhIkdniFX9xN5h0Zf8064cWhCyNqkV+Cw3Gvr597ixRHamk6+adY+nmcNm2HQ4NO55aTI916V2BHDdMPMBWGsBqDg6eOGiLGE/FqquVV4oxSlrDh8ti13V9piG/JTUMKIJlCQbWMOW1omnkCH3eu4cXZANirKnV8SvppnIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ej9tn1jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C984C4CEF7;
	Thu,  6 Nov 2025 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468329;
	bh=6nR/knrnsFkm2TOimUGIeoCqQMcpi356eD3Qp5WUf0c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ej9tn1jzFaIRMX410ARk0fHzYT3WrMGJvkk2A+2kXDyExlxsV5VbacxBbU2ktquFW
	 TipxMhg94ur1JgoFURHmWDHlnopvH9jACqufYyyb6HoPYAS22DHOuqdh1c0b1P6zTm
	 dxoC+Gz1xKBtJuXCCUjLrs2p5ZGZdIVzojA+VHBlRLQNz90PgHgAFkkRHHvvQUxQYU
	 +ntqGqKSbOd6EsAalNVdCabvZEL8pGGFrmK/05WmoRkqjD7gjtLvvY6AcpZMFBdP6C
	 U5MgZRxWyTBkfsgWUBnRS4pbpzS7c1g5cgRVHKhZEf3qRQQ/yDm2pveAqTBk39ku8s
	 2UeWLbMeJK0Nw==
Date: Thu, 06 Nov 2025 14:32:08 -0800
Subject: [PATCH 04/19] libext2fs: refactor aligned MMP buffer allocation
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793699.2862242.1893342981035270584.stgit@frogsfrogsfrogs>
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

Hoist the code that allocates an MMP buffer into a separate helper.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h          |    1 +
 debian/libext2fs2t64.symbols |    1 +
 lib/ext2fs/dupfs.c           |    5 +----
 lib/ext2fs/mmp.c             |   12 ++++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index dec48b80d341db..c4fcb10bea0fb9 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1861,6 +1861,7 @@ errcode_t ext2fs_mmp_update(ext2_filsys fs);
 errcode_t ext2fs_mmp_update2(ext2_filsys fs, int immediately);
 errcode_t ext2fs_mmp_stop(ext2_filsys fs);
 unsigned ext2fs_mmp_new_seq(void);
+errcode_t ext2fs_mmp_get_mem(ext2_filsys fs, void **ptr);
 
 /* read_bb.c */
 extern errcode_t ext2fs_read_bb_inode(ext2_filsys fs,
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index 01f4f269a2660e..affe4c27d4e791 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -448,6 +448,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  ext2fs_mmp_clear@Base 1.42
  ext2fs_mmp_csum_set@Base 1.43
  ext2fs_mmp_csum_verify@Base 1.43
+ ext2fs_mmp_get_mem@Base 1.47.4
  ext2fs_mmp_init@Base 1.42
  ext2fs_mmp_new_seq@Base 1.42
  ext2fs_mmp_read@Base 1.42
diff --git a/lib/ext2fs/dupfs.c b/lib/ext2fs/dupfs.c
index 02721e1a574a1f..0fd4e6c67afb5d 100644
--- a/lib/ext2fs/dupfs.c
+++ b/lib/ext2fs/dupfs.c
@@ -104,10 +104,7 @@ errcode_t ext2fs_dup_handle(ext2_filsys src, ext2_filsys *dest)
 		}
 	}
 	if (src->mmp_cmp) {
-		int align = ext2fs_get_dio_alignment(src->mmp_fd);
-
-		retval = ext2fs_get_memalign(src->blocksize, align,
-					     &fs->mmp_cmp);
+		retval = ext2fs_mmp_get_mem(src, &fs->mmp_cmp);
 		if (retval)
 			goto errout;
 		memcpy(fs->mmp_cmp, src->mmp_cmp, src->blocksize);
diff --git a/lib/ext2fs/mmp.c b/lib/ext2fs/mmp.c
index 6337852c3f6700..41ef4e3e2aa6c5 100644
--- a/lib/ext2fs/mmp.c
+++ b/lib/ext2fs/mmp.c
@@ -41,6 +41,13 @@
 #endif
 #endif
 
+errcode_t ext2fs_mmp_get_mem(ext2_filsys fs, void **ptr)
+{
+	int align = ext2fs_get_dio_alignment(fs->mmp_fd);
+
+	return ext2fs_get_memalign(fs->blocksize, align, ptr);
+}
+
 errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 {
 #ifdef CONFIG_MMP
@@ -78,10 +85,7 @@ errcode_t ext2fs_mmp_read(ext2_filsys fs, blk64_t mmp_blk, void *buf)
 	}
 
 	if (fs->mmp_cmp == NULL) {
-		int align = ext2fs_get_dio_alignment(fs->mmp_fd);
-
-		retval = ext2fs_get_memalign(fs->blocksize, align,
-					     &fs->mmp_cmp);
+		retval = ext2fs_mmp_get_mem(fs, &fs->mmp_cmp);
 		if (retval)
 			return retval;
 	}


