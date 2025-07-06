Return-Path: <linux-ext4+bounces-8833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F325AFA72F
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 20:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C21E3A865B
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Jul 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A3313D503;
	Sun,  6 Jul 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXd8/oJ5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC1846F
	for <linux-ext4@vger.kernel.org>; Sun,  6 Jul 2025 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751826692; cv=none; b=M9OVtKD5bYwkYAFC8tYqhH7Vir8vZgyo4gvLt6zdSQ4sq2e0EM5hTnCv64DFmp1jS7YSExl0G3CYaw478KPsf9bkNlAVsJzXsPtxj6NJKeAMX+WcbTYQNkWw8QrBscsbDjnkEHGqGw5woK6bsVDMOyr16OUahgPD0BrAy+GiYvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751826692; c=relaxed/simple;
	bh=Kwnx58q251cyabG0S8SkDeaDtjZ8GmcH9EHSHQxXat0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Flqd7VsRxJR/tFG+jg0wHzmXiefzvNaSG4iVlbVfDtXqzsbxAp9oMvnlwPrLa4VuBUf9JbB2YbxEBINV20mY3jCv3Tt75nEU+JKKtdGu/s+Y+mtLb3hOAKSR4xTqvc7NoqTkIxcQHXgqKeCQHM1iXXPI80DOsdSSBU42WQej+AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXd8/oJ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6370CC4CEED;
	Sun,  6 Jul 2025 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751826692;
	bh=Kwnx58q251cyabG0S8SkDeaDtjZ8GmcH9EHSHQxXat0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UXd8/oJ5abE3r43R7vuABpGCMA3LDItWSr8c6H/zN2WKy+VLvlDWn17V+Lh7a+49M
	 mjxrOIx202OPOlegxncLiNecmMC65Hcbt+bk5T0NjVNdbfBerXX2H7YPoTDcQbuDUV
	 bN5DUStyewpNJ5wf2yAeg4VJ66nb/fdXlKdUURhWU3WDcEC+sub4NO7X8efPxIZX6r
	 Icyak+xtQSoKNwzCkFto5sI+gsfqSkrDktrTKl6Vslb6owBfKT0k5+jxgXz+jFGeVY
	 Zzi4iQqUnx+lW8BLp62R+++mjfVcZ8oo+l1a9ZblpRmjioauPmU76LxPBQwVrrMrxI
	 51Io+YgYn7GqA==
Date: Sun, 06 Jul 2025 11:31:31 -0700
Subject: [PATCH 3/8] fuse2fs: refactor uid/gid setting
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175182663023.1984706.1635443008190304976.stgit@frogsfrogsfrogs>
In-Reply-To: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
References: <175182662934.1984706.3737778061161342509.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Don't open-code the uid and gid update logic.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index d209bc790fbd36..86fef7765e5e46 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1053,6 +1053,18 @@ static int propagate_default_acls(struct fuse2fs *ff, ext2_ino_t parent,
 	return ret;
 }
 
+static inline void fuse2fs_set_uid(struct ext2_inode_large *inode, uid_t uid)
+{
+	inode->i_uid = uid;
+	ext2fs_set_i_uid_high(*inode, uid >> 16);
+}
+
+static inline void fuse2fs_set_gid(struct ext2_inode_large *inode, gid_t gid)
+{
+	inode->i_gid = gid;
+	ext2fs_set_i_gid_high(*inode, gid >> 16);
+}
+
 static int op_mknod(const char *path, mode_t mode, dev_t dev)
 {
 	struct fuse_context *ctxt = fuse_get_context();
@@ -1145,10 +1157,8 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	inode.i_links_count = 1;
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
-	inode.i_uid = ctxt->uid;
-	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
-	inode.i_gid = ctxt->gid;
-	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
+	fuse2fs_set_uid(&inode, ctxt->uid);
+	fuse2fs_set_gid(&inode, ctxt->gid);
 
 	err = ext2fs_write_new_inode(fs, child, EXT2_INODE(&inode));
 	if (err) {
@@ -1262,10 +1272,8 @@ static int op_mkdir(const char *path, mode_t mode)
 		goto out2;
 	}
 
-	inode.i_uid = ctxt->uid;
-	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
-	inode.i_gid = ctxt->gid;
-	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
+	fuse2fs_set_uid(&inode, ctxt->uid);
+	fuse2fs_set_gid(&inode, ctxt->gid);
 	inode.i_mode = LINUX_S_IFDIR | (mode & ~S_ISUID) |
 		       parent_sgid;
 	inode.i_generation = ff->next_generation++;
@@ -1691,10 +1699,8 @@ static int op_symlink(const char *src, const char *dest)
 		goto out2;
 	}
 
-	inode.i_uid = ctxt->uid;
-	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
-	inode.i_gid = ctxt->gid;
-	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
+	fuse2fs_set_uid(&inode, ctxt->uid);
+	fuse2fs_set_gid(&inode, ctxt->gid);
 	inode.i_generation = ff->next_generation++;
 	init_times(&inode);
 
@@ -2243,8 +2249,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 			ret = -EPERM;
 			goto out;
 		}
-		inode.i_uid = owner;
-		ext2fs_set_i_uid_high(inode, owner >> 16);
+		fuse2fs_set_uid(&inode, owner);
 	}
 
 	if (group != (gid_t) ~0) {
@@ -2256,8 +2261,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group
 		}
 
 		/* XXX: We /should/ check group membership but FUSE */
-		inode.i_gid = group;
-		ext2fs_set_i_gid_high(inode, group >> 16);
+		fuse2fs_set_gid(&inode, group);
 	}
 
 	ret = update_ctime(fs, ino, &inode);
@@ -3300,10 +3304,8 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	inode.i_links_count = 1;
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
-	inode.i_uid = ctxt->uid;
-	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
-	inode.i_gid = ctxt->gid;
-	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
+	fuse2fs_set_uid(&inode, ctxt->uid);
+	fuse2fs_set_gid(&inode, ctxt->gid);
 	if (ext2fs_has_feature_extents(fs->super)) {
 		ext2_extent_handle_t handle;
 


