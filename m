Return-Path: <linux-ext4+bounces-11561-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B91C3D9C5
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01503B0E69
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093133FBA7;
	Thu,  6 Nov 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqWsP2Au"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CB12DBF4B
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468297; cv=none; b=Nyjvdk2XAWhJymb7U0D0DocKaaXnktpUK3PkBqwRcT75gmloGgRnPZswZtwR0PIjU0XiOAfYJtMq0TlGcwmteuIV6fl0xsByyAWH3JHoqyL+cNGZGO3+eOc8tl1fDCwsLVq5ebGEiplxiuqoWkzPKmxlzMNwau6mW1oIh2whj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468297; c=relaxed/simple;
	bh=UdVXQ3zSGGIFMNmWcKcAkLNqPA0TQrIS+IeKbQavYkg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Us2eGaWtyVevTxSR85CphgGB5zvc1ibwWRS7msA3Zx8GmkQcGKQg3Qze1bY0fOKHBefg4G/J4DU8NBpOzfm+4uCO1qTdqGYfEC0zHx+yhjW6IiwGlAx26o/AVPIjyaTewNRbehQDJAJ2J/xCQ0OVCrFNKSeHG4l9FAKyTFvjdR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqWsP2Au; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF5AC113D0;
	Thu,  6 Nov 2025 22:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468297;
	bh=UdVXQ3zSGGIFMNmWcKcAkLNqPA0TQrIS+IeKbQavYkg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=hqWsP2AuJKD6iPi1z+kSSL8Axoy43T9PxLonfXcaXWO3YAqay46yq2EGWS2dOXTIH
	 YKWwAIh2ebne7DCiEy/i8s9Xl4bIrk43ObHofeF/fze6l/Zar6KzuE3vJn3yL2fYYb
	 2yWil6AgaIC6gDOfIPPNGZ1McM1IogNszONR4XwCZF2+mhPK1sCK1yUctk3xnhJW83
	 0hxAj/+Ysx6IoD4PBPTyXbcJiE6ppUKdR4iJM/j1yxU1IRWWf7275mphrwsly6STFS
	 4BjxzxA5VXheVdE9afosfJ5NiIJ9sUFtzjYQ3GWnPjCcq+jUcm+OkquuKPgNSauESE
	 mjOhCeJWPmD1g==
Date: Thu, 06 Nov 2025 14:31:36 -0800
Subject: [PATCH 02/19] libext2fs: create link count adjustment helpers for
 dir_nlink
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176246793663.2862242.16511721570975301138.stgit@frogsfrogsfrogs>
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

Create some helpers to deal with link count adjustments for directories
on dir_nlink filesystems that become large enough to have an htree
index.  In other words, fix the problem that creating a new child
subdirectory can overflow the link count of the parent directory.

The unused library functions created by this patch will be used in the
next patch to fix problems with fuse2fs.

Cc: <linux-ext4@vger.kernel.org> # v1.40
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/ext2fs.h          |    5 ++++
 debian/libext2fs2t64.symbols |    5 ++++
 lib/ext2fs/link.c            |   49 ++++++++++++++++++++++++++++++++++++++++++
 lib/ext2fs/mkdir.c           |    2 +-
 4 files changed, 60 insertions(+), 1 deletion(-)


diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index bb2170b78d6308..dec48b80d341db 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1840,6 +1840,11 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t dir, const char *name,
 		      ext2_ino_t ino, int flags);
 errcode_t ext2fs_unlink(ext2_filsys fs, ext2_ino_t dir, const char *name,
 			ext2_ino_t ino, int flags);
+int ext2fs_dir_is_dx(ext2_filsys fs, const struct ext2_inode *inode);
+void ext2fs_inc_nlink(ext2_filsys fs, struct ext2_inode *inode);
+void ext2fs_dec_nlink(struct ext2_inode *inode);
+int ext2fs_dir_link_max(ext2_filsys fs, struct ext2_inode_large *inode);
+int ext2fs_dir_link_empty(struct ext2_inode *inode);
 
 /* symlink.c */
 errcode_t ext2fs_symlink(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t ino,
diff --git a/debian/libext2fs2t64.symbols b/debian/libext2fs2t64.symbols
index b4d80161f1e1b4..01f4f269a2660e 100644
--- a/debian/libext2fs2t64.symbols
+++ b/debian/libext2fs2t64.symbols
@@ -173,6 +173,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  ext2fs_dblist_iterate@Base 1.37
  ext2fs_dblist_sort2@Base 1.42
  ext2fs_dblist_sort@Base 1.37
+ ext2fs_dec_nlink@Base 1.47.4
  ext2fs_decode_extent@Base 1.46.0
  ext2fs_default_journal_size@Base 1.40
  ext2fs_default_orphan_file_blocks@Base 1.47.0
@@ -182,6 +183,9 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  ext2fs_dir_block_csum_verify@Base 1.43
  ext2fs_dir_iterate2@Base 1.37
  ext2fs_dir_iterate@Base 1.37
+ ext2fs_dir_is_dx@Base 1.47.4
+ ext2fs_dir_link_empty@Base 1.47.4
+ ext2fs_dir_link_max@Base 1.47.4
  ext2fs_dirent_csum_verify@Base 1.43
  ext2fs_dirent_file_type@Base 1.43
  ext2fs_dirent_has_tail@Base 1.43
@@ -376,6 +380,7 @@ libext2fs.so.2 libext2fs2t64 #MINVER#
  ext2fs_image_inode_write@Base 1.37
  ext2fs_image_super_read@Base 1.37
  ext2fs_image_super_write@Base 1.37
+ ext2fs_inc_nlink@Base 1.47.4
  ext2fs_init_csum_seed@Base 1.43
  ext2fs_init_dblist@Base 1.37
  ext2fs_initialize@Base 1.37
diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
index 83d3ea7d00c3ed..eccbf0d23b5d6c 100644
--- a/lib/ext2fs/link.c
+++ b/lib/ext2fs/link.c
@@ -919,3 +919,52 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t dir, const char *name,
 	}
 	return 0;
 }
+
+/* Does this directory have an htree index? */
+int ext2fs_dir_is_dx(ext2_filsys fs, const struct ext2_inode *inode)
+{
+	return ext2fs_has_feature_dir_index(fs->super) &&
+		S_ISDIR(inode->i_mode) && (inode->i_flags & EXT2_INDEX_FL);
+}
+
+/*
+ * Set directory link count to 1 if nlinks > EXT2_LINK_MAX, or if nlinks == 2
+ * since this indicates that nlinks count was previously 1 to avoid overflowing
+ * the 16-bit i_links_count field on disk.  Directories with i_nlink == 1 mean
+ * that subdirectory link counts are not being maintained accurately.
+ *
+ * The caller has already checked for i_nlink overflow in case the DIR_LINK
+ * feature is not enabled and returned -EMLINK.  The is_dx() check is a proxy
+ * for checking S_ISDIR(inode) (since the INODE_INDEX feature will not be set
+ * on regular files) and to avoid creating huge/slow non-HTREE directories.
+ */
+void ext2fs_inc_nlink(ext2_filsys fs, struct ext2_inode *inode)
+{
+	inode->i_links_count++;
+
+	if (ext2fs_dir_is_dx(fs, inode) &&
+	    (inode->i_links_count > EXT2_LINK_MAX || inode->i_links_count == 2))
+		inode->i_links_count = 1;
+}
+
+/*
+ * If a directory had nlink == 1, then we should let it be 1. This indicates
+ * directory has >EXT2_LINK_MAX subdirs.
+ */
+void ext2fs_dec_nlink(struct ext2_inode *inode)
+{
+	if (!S_ISDIR(inode->i_mode) || inode->i_links_count > 2)
+		inode->i_links_count--;
+}
+
+int ext2fs_dir_link_max(ext2_filsys fs, struct ext2_inode_large *inode)
+{
+	return inode->i_links_count >= EXT2_LINK_MAX &&
+	       !(ext2fs_dir_is_dx(fs, EXT2_INODE(inode)) &&
+		 ext2fs_has_feature_dir_nlink(fs->super));
+}
+
+int ext2fs_dir_link_empty(struct ext2_inode *inode)
+{
+	return inode->i_links_count == 2 || inode->i_links_count == 1;
+}
diff --git a/lib/ext2fs/mkdir.c b/lib/ext2fs/mkdir.c
index 45f6e9e27164d2..c0a08c88560bd2 100644
--- a/lib/ext2fs/mkdir.c
+++ b/lib/ext2fs/mkdir.c
@@ -182,7 +182,7 @@ errcode_t ext2fs_mkdir2(ext2_filsys fs, ext2_ino_t parent, ext2_ino_t ino,
 		retval = ext2fs_read_inode(fs, parent, &parent_inode);
 		if (retval)
 			goto cleanup;
-		parent_inode.i_links_count++;
+		ext2fs_inc_nlink(fs, &parent_inode);
 		retval = ext2fs_write_inode(fs, parent, &parent_inode);
 		if (retval)
 			goto cleanup;


