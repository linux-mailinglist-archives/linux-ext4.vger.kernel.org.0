Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3BD128322
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2019 21:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfLTURg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Dec 2019 15:17:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56855 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727402AbfLTURg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Dec 2019 15:17:36 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBKKHVtX017957
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Dec 2019 15:17:32 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 59CEA420822; Fri, 20 Dec 2019 15:17:31 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] fuse2fs: add support for 32-bit uids and gids
Date:   Fri, 20 Dec 2019 15:17:24 -0500
Message-Id: <20191220201724.264430-2-tytso@mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220201724.264430-1-tytso@mit.edu>
References: <20191220201724.264430-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Previously, uids were truncated at 16 bits because we weren't properly
handling i_uid_high and i_gid_high.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/fuse2fs.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index be2cd1db..94cd5f67 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -648,8 +648,8 @@ static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 	dbg_printf("access ino=%d mask=e%s%s%s perms=0%o fuid=%d fgid=%d "
 		   "uid=%d gid=%d\n", ino,
 		   (mask & R_OK ? "r" : ""), (mask & W_OK ? "w" : ""),
-		   (mask & X_OK ? "x" : ""), perms, inode.i_uid, inode.i_gid,
-		   ctxt->uid, ctxt->gid);
+		   (mask & X_OK ? "x" : ""), perms, inode_uid(inode),
+		   inode_gid(inode), ctxt->uid, ctxt->gid);
 
 	/* existence check */
 	if (mask == 0)
@@ -679,14 +679,14 @@ static int check_inum_access(ext2_filsys fs, ext2_ino_t ino, mode_t mask)
 	}
 
 	/* allow owner, if perms match */
-	if (inode.i_uid == ctxt->uid) {
+	if (inode_uid(inode) == ctxt->uid) {
 		if ((mask & (perms >> 6)) == mask)
 			return 0;
 		return -EACCES;
 	}
 
 	/* allow group, if perms match */
-	if (inode.i_gid == ctxt->gid) {
+	if (inode_gid(inode) == ctxt->gid) {
 		if ((mask & (perms >> 3)) == mask)
 			return 0;
 		return -EACCES;
@@ -790,8 +790,8 @@ static int stat_inode(ext2_filsys fs, ext2_ino_t ino, struct stat *statbuf)
 	statbuf->st_ino = ino;
 	statbuf->st_mode = inode.i_mode;
 	statbuf->st_nlink = inode.i_links_count;
-	statbuf->st_uid = inode.i_uid;
-	statbuf->st_gid = inode.i_gid;
+	statbuf->st_uid = inode_uid(inode);
+	statbuf->st_gid = inode_gid(inode);
 	statbuf->st_size = EXT2_I_SIZE(&inode);
 	statbuf->st_blksize = fs->blocksize;
 	statbuf->st_blocks = blocks_from_inode(fs, &inode);
@@ -1014,7 +1014,9 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
 	inode.i_uid = ctxt->uid;
+	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
+	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 
 	err = ext2fs_write_new_inode(fs, child, (struct ext2_inode *)&inode);
 	if (err) {
@@ -1138,7 +1140,9 @@ static int op_mkdir(const char *path, mode_t mode)
 	}
 
 	inode.i_uid = ctxt->uid;
+	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
+	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 	inode.i_mode = LINUX_S_IFDIR | (mode & ~(S_ISUID | fs->umask)) |
 		       parent_sgid;
 	inode.i_generation = ff->next_generation++;
@@ -1511,7 +1515,9 @@ static int op_symlink(const char *src, const char *dest)
 	}
 
 	inode.i_uid = ctxt->uid;
+	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
+	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 	inode.i_generation = ff->next_generation++;
 
 	err = ext2fs_write_inode_full(fs, child, (struct ext2_inode *)&inode,
@@ -1907,7 +1913,7 @@ static int op_chmod(const char *path, mode_t mode)
 		goto out;
 	}
 
-	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->uid != inode.i_uid) {
+	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->uid != inode_uid(inode)) {
 		ret = -EPERM;
 		goto out;
 	}
@@ -1917,7 +1923,7 @@ static int op_chmod(const char *path, mode_t mode)
 	 * of the user's groups, but FUSE only tells us about the primary
 	 * group.
 	 */
-	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->gid != inode.i_gid)
+	if (!ff->fakeroot && ctxt->uid != 0 && ctxt->gid != inode_gid(inode))
 		mode &= ~S_ISGID;
 
 	inode.i_mode &= ~0xFFF;
@@ -1971,22 +1977,25 @@ static int op_chown(const char *path, uid_t owner, gid_t group)
 	if (owner != (uid_t) ~0) {
 		/* Only root gets to change UID. */
 		if (!ff->fakeroot && ctxt->uid != 0 &&
-		    !(inode.i_uid == ctxt->uid && owner == ctxt->uid)) {
+		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
 			ret = -EPERM;
 			goto out;
 		}
 		inode.i_uid = owner;
+		ext2fs_set_i_uid_high(inode, owner >> 16);
 	}
 
 	if (group != (gid_t) ~0) {
 		/* Only root or the owner get to change GID. */
-		if (!ff->fakeroot && ctxt->uid != 0 && inode.i_uid != ctxt->uid) {
+		if (!ff->fakeroot && ctxt->uid != 0 &&
+		    inode_uid(inode) != ctxt->uid) {
 			ret = -EPERM;
 			goto out;
 		}
 
 		/* XXX: We /should/ check group membership but FUSE */
 		inode.i_gid = group;
+		ext2fs_set_i_gid_high(inode, group >> 16);
 	}
 
 	ret = update_ctime(fs, ino, &inode);
@@ -2914,7 +2923,9 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
 	inode.i_extra_isize = sizeof(struct ext2_inode_large) -
 		EXT2_GOOD_OLD_INODE_SIZE;
 	inode.i_uid = ctxt->uid;
+	ext2fs_set_i_uid_high(inode, ctxt->uid >> 16);
 	inode.i_gid = ctxt->gid;
+	ext2fs_set_i_gid_high(inode, ctxt->gid >> 16);
 	if (ext2fs_has_feature_extents(fs->super)) {
 		ext2_extent_handle_t handle;
 
@@ -3132,7 +3143,7 @@ static int ioctl_setflags(ext2_filsys fs, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!ff->fakeroot && ctxt->uid != 0 && inode.i_uid != ctxt->uid)
+	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	if ((inode.i_flags ^ flags) & ~FUSE2FS_MODIFIABLE_IFLAGS)
@@ -3189,7 +3200,7 @@ static int ioctl_setversion(ext2_filsys fs, struct fuse2fs_file_handle *fh,
 	if (err)
 		return translate_error(fs, fh->ino, err);
 
-	if (!ff->fakeroot && ctxt->uid != 0 && inode.i_uid != ctxt->uid)
+	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
 	inode.i_generation = generation;
-- 
2.24.1

