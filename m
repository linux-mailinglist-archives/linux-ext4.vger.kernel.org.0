Return-Path: <linux-ext4+bounces-7477-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E04A9BA0F
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 23:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F06179370
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Apr 2025 21:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF1B21FF2C;
	Thu, 24 Apr 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQCIWPdV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F103198851
	for <linux-ext4@vger.kernel.org>; Thu, 24 Apr 2025 21:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531004; cv=none; b=hKraNupSbzqVaiu8cRXLgrJhEtnA//LxrwAsz3SGho5PXfaAyWG3WxFJ3DaT5zePFXpr09RZt7PIocB3Fj1PhLUiKm0yPClp2o5ER57ZikJZK4UjCI2Xrhp5u3q/b27yVhbcCqWs0CTY/g17MY6SyhQLjHgNCB0mqaa1tbBG+DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531004; c=relaxed/simple;
	bh=+Awq1YT89VTAg6ap62FaTcQtIg1BtLcGTpp3WzJUxOI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA9J1NO8OSYvvg3sGayO6yEbuzdUpWS25Rff6jqAP2j65fYjQ8+M5bVc9CRf9Luv+yVQ+lgh2oCuuwl1EyVJyZBRWv+Sug6hm4IPRuJx6FTgg7luABTeahuZiHij0L9UipTFIUQYOK0mz2WUMu1RyUvHTexMAi8r++jXp0R9B5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQCIWPdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC830C4CEE3;
	Thu, 24 Apr 2025 21:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745531003;
	bh=+Awq1YT89VTAg6ap62FaTcQtIg1BtLcGTpp3WzJUxOI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=IQCIWPdVGVJRPzvJCkuF7MvVHJUsZsOj+/PT/krCrhU548HJzpnxfX8bMujMJggCU
	 IG7WA0aymXuHbXMy81xnbaY6CSUtFAQk/CSXJwxEVGI6sedM8IbRnzNliA7lDap0sK
	 d8+Hkab/RHA0Evm/ghiOeDvofg7isWFInW6w6c3kwE78wQnbxxMdtCM2GE5VekhYVB
	 t46Z1JJSk+KjoE+bSTs9UbYk5OFsOitWdBKM/7SiJbK3HAs/IDsB8y0qXMbGBZG7Kg
	 WfhXn8ct2cF4oEJFbT36QWzq5DRUG65KCmrbWNIabplheYd1BfAk7Pz9qIlz/0tffp
	 QsJKdk9u/1b/g==
Date: Thu, 24 Apr 2025 14:43:23 -0700
Subject: [PATCH 10/16] fuse2fs: support getting and setting via struct fsxattr
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174553065105.1160461.8046224721957766466.stgit@frogsfrogsfrogs>
In-Reply-To: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
References: <174553064857.1160461.865616278603382583.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Support querying xfs file attributes in fuse2fs so that the vfs
getattr/setattr functions continue to work.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |  178 ++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 153 insertions(+), 25 deletions(-)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 9e416e8af77e1b..6066984fa7f6e0 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -2953,31 +2953,41 @@ static int op_utimens(const char *path, const struct timespec ctv[2]
 	return ret;
 }
 
-#ifdef SUPPORT_I_FLAGS
-static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
-			  void *data)
-{
-	ext2_filsys fs = ff->fs;
-	errcode_t err;
-	struct ext2_inode_large inode;
-
-	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
-	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
-	memset(&inode, 0, sizeof(inode));
-	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
-				     sizeof(inode));
-	if (err)
-		return translate_error(fs, fh->ino, err);
-
-	*(__u32 *)data = inode.i_flags & EXT2_FL_USER_VISIBLE;
-	return 0;
-}
-
 #define FUSE2FS_MODIFIABLE_IFLAGS \
 	(EXT2_IMMUTABLE_FL | EXT2_APPEND_FL | EXT2_NODUMP_FL | \
 	 EXT2_NOATIME_FL | EXT3_JOURNAL_DATA_FL | EXT2_DIRSYNC_FL | \
 	 EXT2_TOPDIR_FL)
 
+static inline int set_iflags(struct ext2_inode_large *inode, __u32 iflags)
+{
+	if ((inode->i_flags ^ iflags) & ~FUSE2FS_MODIFIABLE_IFLAGS)
+		return -EINVAL;
+
+	inode->i_flags = (inode->i_flags & ~FUSE2FS_MODIFIABLE_IFLAGS) |
+			 (iflags & FUSE2FS_MODIFIABLE_IFLAGS);
+	return 0;
+}
+
+#ifdef SUPPORT_I_FLAGS
+static int ioctl_getflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
+			  void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+
+	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	memset(&inode, 0, sizeof(inode));
+	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+				     sizeof(inode));
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	*(__u32 *)data = inode.i_flags & EXT2_FL_USER_VISIBLE;
+	return 0;
+}
+
 static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 			  void *data)
 {
@@ -2999,11 +3009,9 @@ static int ioctl_setflags(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
 		return -EPERM;
 
-	if ((inode.i_flags ^ flags) & ~FUSE2FS_MODIFIABLE_IFLAGS)
-		return -EINVAL;
-
-	inode.i_flags = (inode.i_flags & ~FUSE2FS_MODIFIABLE_IFLAGS) |
-			(flags & FUSE2FS_MODIFIABLE_IFLAGS);
+	ret = set_iflags(&inode, flags);
+	if (ret)
+		return ret;
 
 	ret = update_ctime(fs, fh->ino, &inode);
 	if (ret)
@@ -3072,6 +3080,118 @@ static int ioctl_setversion(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 }
 #endif /* SUPPORT_I_FLAGS */
 
+#ifdef FS_IOC_FSGETXATTR
+static __u32 iflags_to_fsxflags(__u32 iflags)
+{
+	__u32 xflags = 0;
+
+	if (iflags & FS_SYNC_FL)
+		xflags |= FS_XFLAG_SYNC;
+	if (iflags & FS_IMMUTABLE_FL)
+		xflags |= FS_XFLAG_IMMUTABLE;
+	if (iflags & FS_APPEND_FL)
+		xflags |= FS_XFLAG_APPEND;
+	if (iflags & FS_NODUMP_FL)
+		xflags |= FS_XFLAG_NODUMP;
+	if (iflags & FS_NOATIME_FL)
+		xflags |= FS_XFLAG_NOATIME;
+	if (iflags & FS_DAX_FL)
+		xflags |= FS_XFLAG_DAX;
+	if (iflags & FS_PROJINHERIT_FL)
+		xflags |= FS_XFLAG_PROJINHERIT;
+	return xflags;
+}
+
+static int ioctl_fsgetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	struct fsxattr *fsx = data;
+	unsigned int inode_size;
+
+	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	memset(&inode, 0, sizeof(inode));
+	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+				     sizeof(inode));
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	memset(fsx, 0, sizeof(*fsx));
+	inode_size = EXT2_GOOD_OLD_INODE_SIZE + inode.i_extra_isize;
+	if (ext2fs_inode_includes(inode_size, i_projid))
+		fsx->fsx_projid = inode_projid(inode);
+	fsx->fsx_xflags = iflags_to_fsxflags(inode.i_flags);
+	return 0;
+}
+
+static __u32 fsxflags_to_iflags(__u32 xflags)
+{
+	__u32 iflags = 0;
+
+	if (xflags & FS_XFLAG_IMMUTABLE)
+		iflags |= FS_IMMUTABLE_FL;
+	if (xflags & FS_XFLAG_APPEND)
+		iflags |= FS_APPEND_FL;
+	if (xflags & FS_XFLAG_SYNC)
+		iflags |= FS_SYNC_FL;
+	if (xflags & FS_XFLAG_NOATIME)
+		iflags |= FS_NOATIME_FL;
+	if (xflags & FS_XFLAG_NODUMP)
+		iflags |= FS_NODUMP_FL;
+	if (xflags & FS_XFLAG_DAX)
+		iflags |= FS_DAX_FL;
+	if (xflags & FS_XFLAG_PROJINHERIT)
+		iflags |= FS_PROJINHERIT_FL;
+	return iflags;
+}
+
+static int ioctl_fssetxattr(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
+			    void *data)
+{
+	ext2_filsys fs = ff->fs;
+	errcode_t err;
+	struct ext2_inode_large inode;
+	int ret;
+	struct fuse_context *ctxt = fuse_get_context();
+	struct fsxattr *fsx = data;
+	__u32 flags = fsxflags_to_iflags(fsx->fsx_xflags);
+	unsigned int inode_size;
+
+	FUSE2FS_CHECK_MAGIC(fs, fh, FUSE2FS_FILE_MAGIC);
+	dbg_printf(ff, "%s: ino=%d\n", __func__, fh->ino);
+	memset(&inode, 0, sizeof(inode));
+	err = ext2fs_read_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+				     sizeof(inode));
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	if (!ff->fakeroot && ctxt->uid != 0 && inode_uid(inode) != ctxt->uid)
+		return -EPERM;
+
+	ret = set_iflags(&inode, flags);
+	if (ret)
+		return ret;
+
+	inode_size = EXT2_GOOD_OLD_INODE_SIZE + inode.i_extra_isize;
+	if (ext2fs_inode_includes(inode_size, i_projid))
+		inode.i_projid = fsx->fsx_projid;
+
+	ret = update_ctime(fs, fh->ino, &inode);
+	if (ret)
+		return ret;
+
+	err = ext2fs_write_inode_full(fs, fh->ino, (struct ext2_inode *)&inode,
+				      sizeof(inode));
+	if (err)
+		return translate_error(fs, fh->ino, err);
+
+	return 0;
+}
+#endif /* FS_IOC_FSGETXATTR */
+
 #ifdef FITRIM
 static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
 			void *data)
@@ -3160,6 +3280,14 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
 		ret = ioctl_setversion(ff, fh, data);
 		break;
 #endif
+#ifdef FS_IOC_FSGETXATTR
+	case FS_IOC_FSGETXATTR:
+		ret = ioctl_fsgetxattr(ff, fh, data);
+		break;
+	case FS_IOC_FSSETXATTR:
+		ret = ioctl_fssetxattr(ff, fh, data);
+		break;
+#endif
 #ifdef FITRIM
 	case FITRIM:
 		ret = ioctl_fitrim(ff, fh, data);


