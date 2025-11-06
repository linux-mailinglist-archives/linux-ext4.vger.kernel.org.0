Return-Path: <linux-ext4+bounces-11560-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819FC3D9C0
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FD2189123E
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FD62E8E08;
	Thu,  6 Nov 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDUiDhUV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C59B199949
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468281; cv=none; b=mrBRe4qr0I29k5fIXc8IBQZNEBduIKN/BfQzEmvSejk+0ZFliarXX6mqFhX8GEMX3JNG50FMzOy7gfoK6kY2eBxRVdOccMKWvgI/ZFoX5kWDifUuX6sO4J7KNQiqtF/6BAVKbI0nAXlITvxSswBRitWebj/lS/JZSrXrUV8D3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468281; c=relaxed/simple;
	bh=654/DacJSC32SupGfmuULh0BHjmOLQtF6iBChICeG24=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXMDWAGScR1NvaY6ac/6EpRCTui4Wb+ePBGM8J/P0cY3fJahUbs5AHtzSC1Nhs11PsiGasjmUovMqaCvF4ljBWI70b987+gTd48SUULwv7t+7F7txUlP7sF3P3ZVQsevw2M4vqEVIl4uduoGLL/VPxxUYpQmgKOVM4ZddmWoM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDUiDhUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DE2C4CEF7;
	Thu,  6 Nov 2025 22:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468281;
	bh=654/DacJSC32SupGfmuULh0BHjmOLQtF6iBChICeG24=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=lDUiDhUVNUu3uxVlQwZvhBOPcbfaxemdhCrbaDEueer3BwQQRAIztA7g4sC4U1yNB
	 FY1gSGfBSoDxX58kzaZhyn9Cx2Ay8lXqnCi0QVDtDvgVsgZ5O760WCOdy4dv7Ghr8u
	 ZX99bkiz/uGOxnvnU0WpYTSoscvj9mhl1swmTe6pPmv+A5moSXz0HSQy9HXu+PFOQv
	 8idvZTuWITwVoXGFyWabwyGTFsMfnDXswpf6D/wj3FIrB8d8pXiSdNa+BGeD0cLc/L
	 hdDh0mcIseltMTLFUbh+JIU93SQRupom7wRUD6quV0FQFo1HMADz8PidqyigJn9wvd
	 nq22Zo3X7HLvQ==
Date: Thu, 06 Nov 2025 14:31:20 -0800
Subject: [PATCH 01/19] libext2fs: initialize htree when expanding directory
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246793645.2862242.1032124733438679877.stgit@frogsfrogsfrogs>
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

Teach ext2fs_link to initialize the htree when we're expanding a
directory beyond the first block.  This brings fuse2fs' behavior in line
with the kernel and dramatically improves performance.  It also is the
start of a bunch of bug fixing for ext4/045.  This is a straight port of
fs/ext4/namei.c.

This patch is needed for the next patch, which fixes the dir_nlink
functionality, because apparently the two features are intertwined.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/link.c |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)


diff --git a/lib/ext2fs/link.c b/lib/ext2fs/link.c
index 1697da39f8855f..83d3ea7d00c3ed 100644
--- a/lib/ext2fs/link.c
+++ b/lib/ext2fs/link.c
@@ -599,6 +599,237 @@ static errcode_t dx_link(ext2_filsys fs, ext2_ino_t dir,
 	return retval;
 }
 
+struct fake_dirent
+{
+	__le32 inode;
+	__le16 rec_len;
+	__u8 name_len;
+	__u8 file_type;
+};
+
+/*
+ * dx_root_info is laid out so that if it should somehow get overlaid by a
+ * dirent the two low bits of the hash version will be zero.  Therefore, the
+ * hash version mod 4 should never be 0.  Sincerely, the paranoia department.
+ */
+
+struct dx_root
+{
+	struct fake_dirent dot;
+	char dot_name[4];
+	struct fake_dirent dotdot;
+	char dotdot_name[4];
+	struct ext2_dx_root_info info;
+	struct ext2_dx_entry entries[];
+};
+
+static int check_dx_root(ext2_filsys fs, ext2_ino_t ino, struct dx_root *root)
+{
+	struct fake_dirent *fde;
+	char *error_msg;
+	unsigned int rlen;
+	char *blockend = (char *)root + fs->blocksize;
+
+	fde = &root->dot;
+	if (fde->name_len != 1) {
+		error_msg = "invalid name_len for '.'";
+		goto corrupted;
+	}
+	if (strncmp(root->dot_name, ".", fde->name_len)) {
+		error_msg = "invalid name for '.'";
+		goto corrupted;
+	}
+
+	ext2fs_get_rec_len(fs, (struct ext2_dir_entry *)fde, &rlen);
+	if ((char *)fde + rlen >= blockend) {
+		error_msg = "invalid rec_len for '.'";
+		goto corrupted;
+	}
+
+	fde = &root->dotdot;
+	if (fde->name_len != 2) {
+		error_msg = "invalid name_len for '..'";
+		goto corrupted;
+	}
+	if (strncmp(root->dotdot_name, "..", fde->name_len)) {
+		error_msg = "invalid name for '..'";
+		goto corrupted;
+	}
+	ext2fs_get_rec_len(fs, (struct ext2_dir_entry *)fde, &rlen);
+	if ((char *)fde + rlen >= blockend) {
+		error_msg = "invalid rec_len for '..'";
+		goto corrupted;
+	}
+
+	return 1;
+
+corrupted:
+	fprintf(stderr, "Corrupt dir %u: %s, running e2fsck is recommended\n",
+			 ino, error_msg);
+	return 0;
+}
+
+static inline struct ext2_dir_entry *
+ext2fs_next_entry(ext2_filsys fs, struct ext2_dir_entry *p)
+{
+	unsigned int rlen;
+
+	ext2fs_get_rec_len(fs, p, &rlen);
+	return (struct ext2_dir_entry *)((char *)p + rlen);
+}
+
+static inline void dx_set_block(struct ext2_dx_entry *entry, unsigned value)
+{
+	entry->block = ext2fs_cpu_to_le32(value);
+}
+
+static inline void dx_set_count(struct ext2_dx_entry *entries, unsigned value)
+{
+	((struct ext2_dx_countlimit *) entries)->count = ext2fs_cpu_to_le16(value);
+}
+
+static inline void dx_set_limit(struct ext2_dx_entry *entries, unsigned value)
+{
+	((struct ext2_dx_countlimit *) entries)->limit = ext2fs_cpu_to_le16(value);
+}
+
+static inline unsigned dx_root_limit(ext2_filsys fs, unsigned infosize)
+{
+	unsigned int entry_space = fs->blocksize -
+			ext2fs_dir_rec_len(1, 0) -
+			ext2fs_dir_rec_len(2, 0) - infosize;
+
+	if (ext2fs_has_feature_metadata_csum(fs->super))
+		entry_space -= sizeof(struct ext2_dx_tail);
+	return entry_space / sizeof(struct ext2_dx_entry);
+}
+
+/*
+ * This converts a one block unindexed directory to a 3 block indexed
+ * directory, and adds the dentry to the indexed directory.  Returns 0 if the
+ * index was not created; EAGAIN if it was; or an errcode_t on error.
+ */
+static errcode_t try_make_indexed_dir(ext2_filsys fs, ext2_ino_t dir,
+				      const char *name, ext2_ino_t ino,
+				      int flags)
+{
+	struct ext2_inode inode;
+	char *buf0, *buf1, *top;
+	struct dx_root *root;
+	struct ext2_dx_entry *entries;
+	struct fake_dirent *fde;
+	struct ext2_dir_entry *de, *de2;
+	blk64_t pblk0, pblk1;
+	unsigned int len;
+	const unsigned int blocksize = fs->blocksize;
+	int csum_size = 0;
+	errcode_t retval;
+
+	retval = ext2fs_read_inode(fs, dir, &inode);
+	if (retval)
+		return retval;
+
+	if (inode.i_size > fs->blocksize || (inode.i_flags & EXT2_INDEX_FL))
+		return 0;
+
+	if (ext2fs_has_feature_metadata_csum(fs->super))
+		csum_size = sizeof(struct ext2_dir_entry_tail);
+
+	retval = ext2fs_get_mem(blocksize, &buf0);
+	if (retval)
+		return retval;
+
+	retval = ext2fs_get_mem(blocksize, &buf1);
+	if (retval)
+		goto out_buf0;
+
+	retval = ext2fs_bmap2(fs, dir, &inode, NULL, 0, 0, NULL, &pblk0);
+	if (retval)
+		goto out_buf1;
+
+	retval = ext2fs_read_dir_block4(fs, pblk0, buf0, 0, dir);
+	if (retval)
+		goto out_buf1;
+
+	root = (struct dx_root *)buf0;
+	if (!check_dx_root(fs, dir, root)) {
+		retval = EXT2_ET_DIR_CORRUPTED;
+		goto out_buf1;
+	}
+
+	/* The 0th block becomes the root, move the dirents out */
+	fde = &root->dotdot;
+	de = ext2fs_next_entry(fs, (struct ext2_dir_entry *)fde);
+	len = ((char *) root) + (blocksize - csum_size) - (char *) de;
+
+	/* Allocate new block for the 0th block's dirents */
+	retval = ext2fs_bmap2(fs, dir, &inode, NULL, BMAP_ALLOC | BMAP_ZERO, 1,
+			      NULL, &pblk1);
+	if (retval)
+		goto out_buf1;
+
+	memcpy(buf1, de, len);
+	memset(de, 0, len); /* wipe old data */
+
+	de = (struct ext2_dir_entry *)buf1;
+	top = buf1 + len;
+	while ((char *)(de2 = ext2fs_next_entry(fs, de)) < top) {
+#if 0
+		if (ext4_check_dir_entry(dir, NULL, de, bh2, buf1, len,
+					(char *)de - buf1)) {
+			retval = EXT2_ET_DIR_CORRUPTED;
+			goto out_buf1;
+		}
+#endif
+		de = de2;
+	}
+	retval = ext2fs_set_rec_len(fs,
+			buf1 + (blocksize - csum_size) - (char *) de, de);
+	if (retval)
+		goto out_buf1;
+
+	if (csum_size)
+		ext2fs_initialize_dirent_tail(fs,
+				EXT2_DIRENT_TAIL(buf1, fs->blocksize));
+
+	/* Initialize the root; the dot dirents already exist */
+	de = (struct ext2_dir_entry *) (&root->dotdot);
+	retval = ext2fs_set_rec_len(fs, blocksize - ext2fs_dir_rec_len(2, 0),
+				    de);
+	memset (&root->info, 0, sizeof(root->info));
+	root->info.info_length = sizeof(root->info);
+	if (ext4_hash_in_dirent(&inode))
+		root->info.hash_version = EXT2_HASH_SIPHASH;
+	else
+		root->info.hash_version = fs->super->s_def_hash_version;
+
+	entries = root->entries;
+	dx_set_block(entries, 1);
+	dx_set_count(entries, 1);
+	dx_set_limit(entries, dx_root_limit(fs, sizeof(root->info)));
+
+	retval = ext2fs_write_dir_block4(fs, pblk1, buf1, 0, dir);
+	if (retval)
+		goto out_buf1;
+
+	retval = ext2fs_write_dir_block4(fs, pblk0, buf0, 0, dir);
+	if (retval)
+		goto out_buf1;
+
+	inode.i_flags |= EXT2_INDEX_FL;
+	inode.i_size += fs->blocksize;
+	retval = ext2fs_write_inode(fs, dir, &inode);
+	if (retval)
+		goto out_buf1;
+
+	retval = EAGAIN;
+out_buf1:
+	ext2fs_free_mem(&buf1);
+out_buf0:
+	ext2fs_free_mem(&buf0);
+	return retval;
+}
+
 /*
  * Note: the low 3 bits of the flags field are used as the directory
  * entry filetype.
@@ -671,6 +902,16 @@ errcode_t ext2fs_link(ext2_filsys fs, ext2_ino_t dir, const char *name,
 	if (!ls.done) {
 		if (!(flags & EXT2FS_LINK_EXPAND))
 			return EXT2_ET_DIR_NO_SPACE;
+
+		if (ext2fs_has_feature_dir_index(fs->super)) {
+			retval = try_make_indexed_dir(fs, dir, name, ino,
+						      flags);
+			if (retval == EAGAIN)
+				goto retry;
+			if (retval)
+				return retval;
+		}
+
 		retval = ext2fs_expand_dir(fs, dir);
 		if (retval)
 			return retval;


