Return-Path: <linux-ext4+bounces-11628-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823A2C3DADA
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99F41885885
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE163074BE;
	Thu,  6 Nov 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzL3OtvK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201D27CCEE
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469353; cv=none; b=h4W3AaqJV/aNd1GZykQgHmVL3hXFSGK7UXuLchWFVB1m8hAcsSkuCN9L2tpNie5oEcAOnp8g8KBVsHzBQq3i8i1us0VJtEdbI7nEnTxHcT8envNIHpo3r0poA+9Vu7UPtGCxK/JwC32OoKt9lr3k77qd7+mfh/flU4scqpnVqhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469353; c=relaxed/simple;
	bh=o1WyOzcKGWiL2Oncyn3tdl88091+ou7QK1nmjgLgD2w=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pe2dDTUriaA5HGWnKsFvQ4VkoV+sphq2Ss9loBFldsj9MxhtbY2ZkDsuAXPlS0T23BBty5SKZ7A52xUV5bBbEixxbvkHkYPkWXX/7aU7MD4Wr5ah7OcxoIqUAbr9Cb+O8GAC+aqT+ltCO92PWel8m1uvCxuasvoNY6wobCoGktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzL3OtvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD5CC4CEFB;
	Thu,  6 Nov 2025 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469352;
	bh=o1WyOzcKGWiL2Oncyn3tdl88091+ou7QK1nmjgLgD2w=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kzL3OtvKH+MufVcg6UBTwTQaw5XDFhllL21Nj4WM9VSnV9XS+BtMPxKRULrWA4xVp
	 7S+ceSbpyP3WyVfCI7ej7Lz7QqEZineo2epWSoARKPaDO29Z0cplXQJAhPyK/JcFJh
	 rL7S26Z/u9R6ZY+FTk4XPh6Sb7I2C4BrZzSjCXOlLJFNutkL6eGiQdlg85VHcbX6OF
	 35z6yb8w/MmwnMXV5S1fAVJWeePcKNfnpCKYJZTaRCTSNIW39I5nQLvhckqS25Krni
	 d3H8TJL3I/zdt7k7nrveGibX5Q0delvEVG9dUexYyj1sdvCn5Ozhp4Ro5ajmfhgqkU
	 15OloCJunH2Eg==
Date: Thu, 06 Nov 2025 14:49:11 -0800
Subject: [PATCH 23/23] fuse4fs: create incore reverse orphan list
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795981.2864310.10507487668310606588.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create an incore orphan list so that removing open unlinked inodes
doesn't take forever.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |  178 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 174 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 7db09ed93fdf1f..609e23bd916cc0 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -358,10 +358,20 @@ static inline int u_log2(unsigned int arg)
 	return l;
 }
 
+/* inode is not on unlinked list */
+#define FUSE4FS_NULL_INO	((ext2_ino_t)~0ULL)
+
 struct fuse4fs_inode {
 	struct cache_node	i_cnode;
 	ext2_ino_t		i_ino;
 	unsigned int		i_open_count;
+
+	/*
+	 * FUSE4FS_NULL_INO: inode is not on the orphan list
+	 * 0: inode is the first on the orphan list
+	 * otherwise: inode is in the middle of the list
+	 */
+	ext2_ino_t		i_prev_orphan;
 };
 
 struct fuse4fs_ikey {
@@ -403,12 +413,15 @@ static struct cache_node *icache_alloc(struct cache *c, cache_key_t key)
 		return NULL;
 
 	fi->i_ino = ikey->i_ino;
+	fi->i_prev_orphan = FUSE4FS_NULL_INO;
 	return &fi->i_cnode;
 }
 
 static bool icache_flush(struct cache *c, struct cache_node *node)
 {
-	return false;
+	struct fuse4fs_inode *fi = ICNODE(node);
+
+	return fi->i_prev_orphan != FUSE4FS_NULL_INO;
 }
 
 static void icache_relse(struct cache *c, struct cache_node *node)
@@ -2428,10 +2441,31 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 				  struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
+	ext2_ino_t orphan_ino = fs->super->s_last_orphan;
+	errcode_t err;
 
 	dbg_printf(ff, "%s: orphan ino=%d dtime=%d next=%d\n",
 		   __func__, ino, inode->i_dtime, fs->super->s_last_orphan);
 
+	/* Make the first orphan on the list point back to us */
+	if (orphan_ino != 0) {
+		err = fuse4fs_iget(ff, orphan_ino, &fi);
+		if (err)
+			return translate_error(fs, orphan_ino, err);
+
+		fi->i_prev_orphan = ino;
+		fuse4fs_iput(ff, fi);
+	}
+
+	/* Add ourselves to the head of the orphan list */
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	fi->i_prev_orphan = 0;
+	fuse4fs_iput(ff, fi);
+
 	inode->i_dtime = fs->super->s_last_orphan;
 	fs->super->s_last_orphan = ino;
 	ext2fs_mark_super_dirty(fs);
@@ -2439,24 +2473,158 @@ static int fuse4fs_add_to_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 	return 0;
 }
 
+/*
+ * Given the orphan list excerpt: prev_orphan -> ino -> next_orphan, set
+ * next_orphan's backpointer to ino's backpointer (prev_orphan), having removed
+ * ino from the orphan list.
+ */
+static int fuse4fs_update_next_orphan_backlink(struct fuse4fs *ff,
+					       ext2_ino_t prev_orphan,
+					       ext2_ino_t ino,
+					       ext2_ino_t next_orphan)
+{
+	struct fuse4fs_inode *fi;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_iget(ff, next_orphan, &fi);
+	if (err)
+		return translate_error(ff->fs, next_orphan, err);
+
+	dbg_printf(ff, "%s: ino=%d cached next=%d nextprev=%d prev=%d\n",
+		   __func__, ino, next_orphan, fi->i_prev_orphan,
+		   prev_orphan);
+
+	if (fi->i_prev_orphan != ino) {
+		ret = translate_error(ff->fs, next_orphan,
+				      EXT2_ET_FILESYSTEM_CORRUPTED);
+		goto out_iput;
+	}
+
+	fi->i_prev_orphan = prev_orphan;
+out_iput:
+	fuse4fs_iput(ff, fi);
+	return ret;
+}
+
+/*
+ * Remove ino from the orphan list the fast way.  Returns 1 for success, 0 if
+ * it didn't do anything, or a negative errno.
+ */
+static int fuse4fs_fast_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
+					    struct ext2_inode_large *inode)
+{
+	struct ext2_inode_large orphan;
+	ext2_filsys fs = ff->fs;
+	struct fuse4fs_inode *fi;
+	ext2_ino_t prev_orphan;
+	ext2_ino_t next_orphan = 0;
+	errcode_t err;
+	int ret = 0;
+
+	err = fuse4fs_iget(ff, ino, &fi);
+	if (err)
+		return translate_error(fs, ino, err);
+
+	prev_orphan = fi->i_prev_orphan;
+	switch (prev_orphan) {
+	case 0:
+		/* First inode in the list */
+		dbg_printf(ff, "%s: ino=%d cached superblock\n", __func__, ino);
+
+		fs->super->s_last_orphan = inode->i_dtime;
+		next_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+		ext2fs_mark_super_dirty(fs);
+		fi->i_prev_orphan = FUSE4FS_NULL_INO;
+		break;
+	case FUSE4FS_NULL_INO:
+		/* unknown */
+		dbg_printf(ff, "%s: ino=%d broken list??\n", __func__, ino);
+		ret = 0;
+		goto out_iput;
+	default:
+		/* We're in the middle of the list */
+		err = fuse4fs_read_inode(fs, prev_orphan, &orphan);
+		if (err) {
+			ret = translate_error(fs, prev_orphan, err);
+			goto out_iput;
+		}
+
+		dbg_printf(ff,
+ "%s: ino=%d cached prev=%d prevnext=%d next=%d\n",
+			   __func__, ino, prev_orphan, orphan.i_dtime,
+			   inode->i_dtime);
+
+		if (orphan.i_dtime != ino) {
+			ret = translate_error(fs, prev_orphan,
+					      EXT2_ET_FILESYSTEM_CORRUPTED);
+			goto out_iput;
+		}
+
+		fi->i_prev_orphan = FUSE4FS_NULL_INO;
+		orphan.i_dtime = inode->i_dtime;
+		next_orphan = inode->i_dtime;
+		inode->i_dtime = 0;
+
+		err = fuse4fs_write_inode(fs, prev_orphan, &orphan);
+		if (err) {
+			ret = translate_error(fs, prev_orphan, err);
+			goto out_iput;
+		}
+
+		break;
+	}
+
+	/*
+	 * Make the next orphaned inode point back to the our own previous list
+	 * entry
+	 */
+	if (next_orphan != 0) {
+		ret = fuse4fs_update_next_orphan_backlink(ff, prev_orphan, ino,
+							  next_orphan);
+		if (ret)
+			goto out_iput;
+	}
+	ret = 1;
+
+out_iput:
+	fuse4fs_iput(ff, fi);
+	return ret;
+}
+
 static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 				       struct ext2_inode_large *inode)
 {
 	ext2_filsys fs = ff->fs;
 	ext2_ino_t prev_orphan;
+	ext2_ino_t next_orphan;
 	errcode_t err;
+	int ret;
 
 	dbg_printf(ff, "%s: super=%d ino=%d next=%d\n",
 		   __func__, fs->super->s_last_orphan, ino, inode->i_dtime);
 
-	/* If we're lucky, the ondisk superblock points to us */
+	/*
+	 * Fast way: use the incore list, which doesn't include any orphans
+	 * that were already on the superblock when we mounted.
+	 */
+	ret = fuse4fs_fast_remove_from_orphans(ff, ino, inode);
+	if (ret < 0)
+		return ret;
+	if (ret == 1)
+		return 0;
+
+	/* Slow way: If we're lucky, the ondisk superblock points to us */
 	if (fs->super->s_last_orphan == ino) {
 		dbg_printf(ff, "%s: superblock\n", __func__);
 
+		next_orphan = inode->i_dtime;
 		fs->super->s_last_orphan = inode->i_dtime;
 		inode->i_dtime = 0;
 		ext2fs_mark_super_dirty(fs);
-		return 0;
+		return fuse4fs_update_next_orphan_backlink(ff, 0, ino,
+							   next_orphan);
 	}
 
 	/* Otherwise walk the ondisk orphan list. */
@@ -2476,6 +2644,7 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			dbg_printf(ff, "%s: prev=%d\n",
 				   __func__, prev_orphan);
 
+			next_orphan = inode->i_dtime;
 			orphan.i_dtime = inode->i_dtime;
 			inode->i_dtime = 0;
 
@@ -2483,7 +2652,8 @@ static int fuse4fs_remove_from_orphans(struct fuse4fs *ff, ext2_ino_t ino,
 			if (err)
 				return translate_error(fs, prev_orphan, err);
 
-			return 0;
+			return fuse4fs_update_next_orphan_backlink(ff,
+					prev_orphan, ino, next_orphan);
 		}
 
 		dbg_printf(ff, "%s: orphan=%d next=%d\n",


