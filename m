Return-Path: <linux-ext4+bounces-11689-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92BC42205
	for <lists+linux-ext4@lfdr.de>; Sat, 08 Nov 2025 01:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F356B1897F30
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Nov 2025 00:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30266202961;
	Sat,  8 Nov 2025 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtssR7WL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A7034D38B
	for <linux-ext4@vger.kernel.org>; Sat,  8 Nov 2025 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762561543; cv=none; b=DCnBiXV3VMsyXQ/A6vZNMaEjM8+mknzjVfQF7+VbhxKrax1QLHAJGzl5nvl4mhNhxne6H0XNDjBBCkLUrA0dRqTzJhXl8e/8RY4Vc8onSeXBYJnaSZsMUkl3v1i7Yb8/3wgsufsTY8Ex50mlt9gf3l/O0fkBooYX8W0dlzUHEL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762561543; c=relaxed/simple;
	bh=T6TAd5/oQs8gxDEHt7fntLYTqCkQQ7yD9KyOuIezDVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0G9ZpdczebGuioiYhW4BSlspxmmpma7uuTWVvBfnLPP3ku0rSyFbVTJpDtediwqTbsnFhp4e0tr6kTGESP2fxfyJjrR2vT51jTKsubfc+sEyFa+6TfD6z2HYqfNHbDT8KVzkF5gVKi64cnuikA2EGz/DpuMrgLWj9WCw8m0eXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtssR7WL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60222C4CEF8;
	Sat,  8 Nov 2025 00:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762561543;
	bh=T6TAd5/oQs8gxDEHt7fntLYTqCkQQ7yD9KyOuIezDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rtssR7WLCBI6VGqt3GuLLSEiOyIefPYuDn8RDtWXvllNiTkhOZa/PvfZrtz4QOUti
	 lvvnDHqTFE6eI7VuF2UcojpDK1HPnJNCXjrGVCPRjIDCJyC5YzXqaDdbsh4YlBwrJL
	 wmLh1TzPxpycXaf+WuEhof6eGXTUHtJpGWZzpQq8O9vjWHS8iHJxQOSQGQ/ill88yp
	 UEZh9fbSH+TONhlC0VsMCg5jH/dKLPFnCEbBwYD21D5DSRa9jOUyxlRDmi1sHM2qVD
	 iG8Q/PeDXGDx3EXPV1wr834svn9lVyxnhXH7h/rk+Lx8rla/i8Qu8VMPI5IBI0Km5T
	 oNq97qOFnc/Pg==
Date: Fri, 7 Nov 2025 16:25:42 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 04/23] fuse4fs: namespace some helpers
Message-ID: <20251108002542.GN196391@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
 <176246795639.2864310.2926261571911454655.stgit@frogsfrogsfrogs>
 <aQ2pVgns-GwNFnW6@amir-ThinkPad-T480>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ2pVgns-GwNFnW6@amir-ThinkPad-T480>

On Fri, Nov 07, 2025 at 09:09:58AM +0100, Amir Goldstein wrote:
> On Thu, Nov 06, 2025 at 02:44:07PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Prepend "fuse4fs_" to all helper functions that take a struct fuse4fs
> > object pointer.
> > 
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fuse4fs/fuse4fs.c |  177 +++++++++++++++++++++++++++--------------------------
> >  1 file changed, 90 insertions(+), 87 deletions(-)
> > 
> > 
> > diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
> > index daf22e0fe7fde5..2ef5ad60163639 100644
> > --- a/fuse4fs/fuse4fs.c
> > +++ b/fuse4fs/fuse4fs.c
> > @@ -2,6 +2,7 @@
> >   * fuse4fs.c - FUSE low-level server for e2fsprogs.
> >   *
> >   * Copyright (C) 2014-2025 Oracle.
> > + * Copyright (C) 2025 CTERA Networks.
> 
> I think this belongs to next patch :)

Moved; thanks for the feedback!

--D

> Thanks,
> Amir.
> 
> >   *
> >   * %Begin-Header%
> >   * This file may be redistributed under the terms of the GNU Public
> > @@ -852,7 +853,7 @@ static int ext2_file_type(unsigned int mode)
> >  	return 0;
> >  }
> >  
> > -static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
> > +static int fuse4fs_can_allocate(struct fuse4fs *ff, blk64_t num)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	blk64_t reserved;
> > @@ -879,21 +880,22 @@ static int fs_can_allocate(struct fuse4fs *ff, blk64_t num)
> >  	return ext2fs_free_blocks_count(fs->super) > reserved + num;
> >  }
> >  
> > -static int fuse4fs_is_writeable(struct fuse4fs *ff)
> > +static int fuse4fs_is_writeable(const struct fuse4fs *ff)
> >  {
> >  	return ff->opstate == F4OP_WRITABLE &&
> >  		(ff->fs->super->s_error_count == 0);
> >  }
> >  
> > -static inline int is_superuser(struct fuse4fs *ff, struct fuse_context *ctxt)
> > +static inline int fuse4fs_is_superuser(struct fuse4fs *ff,
> > +				       const struct fuse_context *ctxt)
> >  {
> >  	if (ff->fakeroot)
> >  		return 1;
> >  	return ctxt->uid == 0;
> >  }
> >  
> > -static inline int want_check_owner(struct fuse4fs *ff,
> > -				   struct fuse_context *ctxt)
> > +static inline int fuse4fs_want_check_owner(struct fuse4fs *ff,
> > +					   const struct fuse_context *ctxt)
> >  {
> >  	/*
> >  	 * The kernel is responsible for access control, so we allow anything
> > @@ -901,14 +903,14 @@ static inline int want_check_owner(struct fuse4fs *ff,
> >  	 */
> >  	if (ff->kernel)
> >  		return 0;
> > -	return !is_superuser(ff, ctxt);
> > +	return !fuse4fs_is_superuser(ff, ctxt);
> >  }
> >  
> >  /* Test for append permission */
> >  #define A_OK	16
> >  
> > -static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
> > -			       const struct ext2_inode *inode, int mask)
> > +static int fuse4fs_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
> > +				 const struct ext2_inode *inode, int mask)
> >  {
> >  	EXT2FS_BUILD_BUG_ON((A_OK & (R_OK | W_OK | X_OK | F_OK)) != 0);
> >  
> > @@ -936,7 +938,7 @@ static int check_iflags_access(struct fuse4fs *ff, ext2_ino_t ino,
> >  	return 0;
> >  }
> >  
> > -static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
> > +static int fuse4fs_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
> >  {
> >  	struct fuse_context *ctxt = fuse_get_context();
> >  	ext2_filsys fs = ff->fs;
> > @@ -968,7 +970,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
> >  	if (mask == 0)
> >  		return 0;
> >  
> > -	ret = check_iflags_access(ff, ino, &inode, mask);
> > +	ret = fuse4fs_iflags_access(ff, ino, &inode, mask);
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -977,7 +979,7 @@ static int check_inum_access(struct fuse4fs *ff, ext2_ino_t ino, int mask)
> >  		return 0;
> >  
> >  	/* Figure out what root's allowed to do */
> > -	if (is_superuser(ff, ctxt)) {
> > +	if (fuse4fs_is_superuser(ff, ctxt)) {
> >  		/* Non-file access always ok */
> >  		if (!LINUX_S_ISREG(inode.i_mode))
> >  			return 0;
> > @@ -1783,8 +1785,8 @@ static int op_readlink(const char *path, char *buf, size_t len)
> >  	return ret;
> >  }
> >  
> > -static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
> > -		      void **value, size_t *value_len)
> > +static int fuse4fs_getxattr(struct fuse4fs *ff, ext2_ino_t ino,
> > +			    const char *name, void **value, size_t *value_len)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	struct ext2_xattr_handle *h;
> > @@ -1814,8 +1816,8 @@ static int __getxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
> >  	return ret;
> >  }
> >  
> > -static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
> > -		      void *value, size_t valuelen)
> > +static int fuse4fs_setxattr(struct fuse4fs *ff, ext2_ino_t ino,
> > +			    const char *name, void *value, size_t valuelen)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	struct ext2_xattr_handle *h;
> > @@ -1845,8 +1847,8 @@ static int __setxattr(struct fuse4fs *ff, ext2_ino_t ino, const char *name,
> >  	return ret;
> >  }
> >  
> > -static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
> > -				  ext2_ino_t child, mode_t mode)
> > +static int fuse4fs_propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
> > +					  ext2_ino_t child, mode_t mode)
> >  {
> >  	void *def;
> >  	size_t deflen;
> > @@ -1855,8 +1857,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
> >  	if (!ff->acl || S_ISDIR(mode))
> >  		return 0;
> >  
> > -	ret = __getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
> > -			 &deflen);
> > +	ret = fuse4fs_getxattr(ff, parent, XATTR_NAME_POSIX_ACL_DEFAULT, &def,
> > +			       &deflen);
> >  	switch (ret) {
> >  	case -ENODATA:
> >  	case -ENOENT:
> > @@ -1868,7 +1870,8 @@ static int propagate_default_acls(struct fuse4fs *ff, ext2_ino_t parent,
> >  		return ret;
> >  	}
> >  
> > -	ret = __setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def, deflen);
> > +	ret = fuse4fs_setxattr(ff, child, XATTR_NAME_POSIX_ACL_DEFAULT, def,
> > +			       deflen);
> >  	ext2fs_free_mem(&def);
> >  	return ret;
> >  }
> > @@ -1997,7 +2000,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
> >  	*node_name = 0;
> >  
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 2)) {
> > +	if (!fuse4fs_can_allocate(ff, 2)) {
> >  		ret = -ENOSPC;
> >  		goto out2;
> >  	}
> > @@ -2009,7 +2012,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, parent, A_OK | W_OK);
> > +	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2079,7 +2082,7 @@ static int op_mknod(const char *path, mode_t mode, dev_t dev)
> >  
> >  	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
> >  
> > -	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
> > +	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2127,7 +2130,7 @@ static int op_mkdir(const char *path, mode_t mode)
> >  	*node_name = 0;
> >  
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 1)) {
> > +	if (!fuse4fs_can_allocate(ff, 1)) {
> >  		ret = -ENOSPC;
> >  		goto out2;
> >  	}
> > @@ -2139,7 +2142,7 @@ static int op_mkdir(const char *path, mode_t mode)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, parent, A_OK | W_OK);
> > +	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2212,7 +2215,7 @@ static int op_mkdir(const char *path, mode_t mode)
> >  		goto out3;
> >  	}
> >  
> > -	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
> > +	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
> >  	if (ret)
> >  		goto out3;
> >  
> > @@ -2253,7 +2256,7 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
> >  		base_name = filename;
> >  	}
> >  
> > -	ret = check_inum_access(ff, dir, W_OK);
> > +	ret = fuse4fs_inum_access(ff, dir, W_OK);
> >  	if (ret) {
> >  		free(filename);
> >  		return ret;
> > @@ -2275,8 +2278,8 @@ static int fuse4fs_unlink(struct fuse4fs *ff, const char *path,
> >  	return 0;
> >  }
> >  
> > -static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
> > -			    struct ext2_inode_large *inode)
> > +static int fuse4fs_remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
> > +				    struct ext2_inode_large *inode)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	struct ext2_xattr_handle *h;
> > @@ -2320,7 +2323,7 @@ static int remove_ea_inodes(struct fuse4fs *ff, ext2_ino_t ino,
> >  	return 0;
> >  }
> >  
> > -static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
> > +static int fuse4fs_remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	errcode_t err;
> > @@ -2366,7 +2369,7 @@ static int remove_inode(struct fuse4fs *ff, ext2_ino_t ino)
> >  		goto write_out;
> >  
> >  	if (ext2fs_has_feature_ea_inode(fs->super)) {
> > -		ret = remove_ea_inodes(ff, ino, &inode);
> > +		ret = fuse4fs_remove_ea_inodes(ff, ino, &inode);
> >  		if (ret)
> >  			return ret;
> >  	}
> > @@ -2407,7 +2410,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
> >  		goto out;
> >  	}
> >  
> > -	ret = check_inum_access(ff, ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -2415,7 +2418,7 @@ static int __op_unlink(struct fuse4fs *ff, const char *path)
> >  	if (ret)
> >  		goto out;
> >  
> > -	ret = remove_inode(ff, ino);
> > +	ret = fuse4fs_remove_inode(ff, ino);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -2483,7 +2486,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
> >  	}
> >  	dbg_printf(ff, "%s: rmdir path=%s ino=%d\n", __func__, path, child);
> >  
> > -	ret = check_inum_access(ff, child, W_OK);
> > +	ret = fuse4fs_inum_access(ff, child, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -2502,7 +2505,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
> >  		goto out;
> >  	}
> >  
> > -	ret = check_inum_access(ff, rds.parent, W_OK);
> > +	ret = fuse4fs_inum_access(ff, rds.parent, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -2514,7 +2517,7 @@ static int __op_rmdir(struct fuse4fs *ff, const char *path)
> >  	ret = fuse4fs_unlink(ff, path, &parent);
> >  	if (ret)
> >  		goto out;
> > -	ret = remove_inode(ff, child);
> > +	ret = fuse4fs_remove_inode(ff, child);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -2587,7 +2590,7 @@ static int op_symlink(const char *src, const char *dest)
> >  	*node_name = 0;
> >  
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 1)) {
> > +	if (!fuse4fs_can_allocate(ff, 1)) {
> >  		ret = -ENOSPC;
> >  		goto out2;
> >  	}
> > @@ -2599,7 +2602,7 @@ static int op_symlink(const char *src, const char *dest)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, parent, A_OK | W_OK);
> > +	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2746,7 +2749,7 @@ static int op_rename(const char *from, const char *to,
> >  	FUSE4FS_CHECK_CONTEXT(ff);
> >  	dbg_printf(ff, "%s: renaming %s to %s\n", __func__, from, to);
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 5)) {
> > +	if (!fuse4fs_can_allocate(ff, 5)) {
> >  		ret = -ENOSPC;
> >  		goto out;
> >  	}
> > @@ -2772,12 +2775,12 @@ static int op_rename(const char *from, const char *to,
> >  		goto out;
> >  	}
> >  
> > -	ret = check_inum_access(ff, from_ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, from_ino, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> >  	if (to_ino) {
> > -		ret = check_inum_access(ff, to_ino, W_OK);
> > +		ret = fuse4fs_inum_access(ff, to_ino, W_OK);
> >  		if (ret)
> >  			goto out;
> >  	}
> > @@ -2815,7 +2818,7 @@ static int op_rename(const char *from, const char *to,
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, from_dir_ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, from_dir_ino, W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2840,7 +2843,7 @@ static int op_rename(const char *from, const char *to,
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, to_dir_ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, to_dir_ino, W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -2992,7 +2995,7 @@ static int op_link(const char *src, const char *dest)
> >  	*node_name = 0;
> >  
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 2)) {
> > +	if (!fuse4fs_can_allocate(ff, 2)) {
> >  		ret = -ENOSPC;
> >  		goto out2;
> >  	}
> > @@ -3005,7 +3008,7 @@ static int op_link(const char *src, const char *dest)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, parent, A_OK | W_OK);
> > +	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -3021,7 +3024,7 @@ static int op_link(const char *src, const char *dest)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> > +	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -3066,7 +3069,7 @@ static int op_link(const char *src, const char *dest)
> >  }
> >  
> >  /* Obtain group ids of the process that sent us a command(?) */
> > -static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
> > +static int fuse4fs_get_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	errcode_t err;
> > @@ -3111,8 +3114,8 @@ static int get_req_groups(struct fuse4fs *ff, gid_t **gids, size_t *nr_gids)
> >   * that initiated the fuse request?  Returns 1 for yes, 0 for no, or a negative
> >   * errno.
> >   */
> > -static int in_file_group(struct fuse_context *ctxt,
> > -			 const struct ext2_inode_large *inode)
> > +static int fuse4fs_in_file_group(struct fuse_context *ctxt,
> > +				 const struct ext2_inode_large *inode)
> >  {
> >  	struct fuse4fs *ff = fuse4fs_get();
> >  	gid_t *gids = NULL;
> > @@ -3124,7 +3127,7 @@ static int in_file_group(struct fuse_context *ctxt,
> >  	if (ctxt->gid == gid)
> >  		return 1;
> >  
> > -	ret = get_req_groups(ff, &gids, &nr_gids);
> > +	ret = fuse4fs_get_groups(ff, &gids, &nr_gids);
> >  	if (ret == -ENOENT) {
> >  		/* magic return code for "could not get caller group info" */
> >  		return 0;
> > @@ -3167,11 +3170,11 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
> >  		goto out;
> >  	}
> >  
> > -	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> > +	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > -	if (want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
> > +	if (fuse4fs_want_check_owner(ff, ctxt) && ctxt->uid != inode_uid(inode)) {
> >  		ret = -EPERM;
> >  		goto out;
> >  	}
> > @@ -3181,8 +3184,8 @@ static int op_chmod(const char *path, mode_t mode, struct fuse_file_info *fi)
> >  	 * of the user's groups, but FUSE only tells us about the primary
> >  	 * group.
> >  	 */
> > -	if (!is_superuser(ff, ctxt)) {
> > -		ret = in_file_group(ctxt, &inode);
> > +	if (!fuse4fs_is_superuser(ff, ctxt)) {
> > +		ret = fuse4fs_in_file_group(ctxt, &inode);
> >  		if (ret < 0)
> >  			goto out;
> >  
> > @@ -3236,14 +3239,14 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
> >  		goto out;
> >  	}
> >  
> > -	ret = check_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> > +	ret = fuse4fs_iflags_access(ff, ino, EXT2_INODE(&inode), W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> >  	/* FUSE seems to feed us ~0 to mean "don't change" */
> >  	if (owner != (uid_t) ~0) {
> >  		/* Only root gets to change UID. */
> > -		if (want_check_owner(ff, ctxt) &&
> > +		if (fuse4fs_want_check_owner(ff, ctxt) &&
> >  		    !(inode_uid(inode) == ctxt->uid && owner == ctxt->uid)) {
> >  			ret = -EPERM;
> >  			goto out;
> > @@ -3253,7 +3256,7 @@ static int op_chown(const char *path, uid_t owner, gid_t group,
> >  
> >  	if (group != (gid_t) ~0) {
> >  		/* Only root or the owner get to change GID. */
> > -		if (want_check_owner(ff, ctxt) &&
> > +		if (fuse4fs_want_check_owner(ff, ctxt) &&
> >  		    inode_uid(inode) != ctxt->uid) {
> >  			ret = -EPERM;
> >  			goto out;
> > @@ -3363,7 +3366,7 @@ static int op_truncate(const char *path, off_t len, struct fuse_file_info *fi)
> >  		goto out;
> >  	dbg_printf(ff, "%s: ino=%d len=%jd\n", __func__, ino, (intmax_t) len);
> >  
> > -	ret = check_inum_access(ff, ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -3445,7 +3448,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
> >  	}
> >  	dbg_printf(ff, "%s: ino=%d\n", __func__, file->ino);
> >  
> > -	ret = check_inum_access(ff, file->ino, check);
> > +	ret = fuse4fs_inum_access(ff, file->ino, check);
> >  	if (ret) {
> >  		/*
> >  		 * In a regular (Linux) fs driver, the kernel will open
> > @@ -3457,7 +3460,7 @@ static int __op_open(struct fuse4fs *ff, const char *path,
> >  		 * also employ undocumented hacks (see above).
> >  		 */
> >  		if (check == R_OK) {
> > -			ret = check_inum_access(ff, file->ino, X_OK);
> > +			ret = fuse4fs_inum_access(ff, file->ino, X_OK);
> >  			if (ret)
> >  				goto out;
> >  			check = X_OK;
> > @@ -3568,7 +3571,7 @@ static int op_write(const char *path EXT2FS_ATTR((unused)),
> >  		goto out;
> >  	}
> >  
> > -	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
> > +	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len))) {
> >  		ret = -ENOSPC;
> >  		goto out;
> >  	}
> > @@ -3768,11 +3771,11 @@ static int op_getxattr(const char *path, const char *key, char *value,
> >  	}
> >  	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
> >  
> > -	ret = check_inum_access(ff, ino, R_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, R_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > -	ret = __getxattr(ff, ino, key, &ptr, &plen);
> > +	ret = fuse4fs_getxattr(ff, ino, key, &ptr, &plen);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -3838,7 +3841,7 @@ static int op_listxattr(const char *path, char *names, size_t len)
> >  	}
> >  	dbg_printf(ff, "%s: ino=%d\n", __func__, ino);
> >  
> > -	ret = check_inum_access(ff, ino, R_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, R_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -3919,7 +3922,7 @@ static int op_setxattr(const char *path EXT2FS_ATTR((unused)),
> >  	}
> >  	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
> >  
> > -	ret = check_inum_access(ff, ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, W_OK);
> >  	if (ret == -EACCES) {
> >  		ret = -EPERM;
> >  		goto out;
> > @@ -4008,7 +4011,7 @@ static int op_removexattr(const char *path, const char *key)
> >  		goto out;
> >  	}
> >  
> > -	if (!fs_can_allocate(ff, 1)) {
> > +	if (!fuse4fs_can_allocate(ff, 1)) {
> >  		ret = -ENOSPC;
> >  		goto out;
> >  	}
> > @@ -4020,7 +4023,7 @@ static int op_removexattr(const char *path, const char *key)
> >  	}
> >  	dbg_printf(ff, "%s: ino=%d name=%s\n", __func__, ino, key);
> >  
> > -	ret = check_inum_access(ff, ino, W_OK);
> > +	ret = fuse4fs_inum_access(ff, ino, W_OK);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -4207,7 +4210,7 @@ static int op_access(const char *path, int mask)
> >  		goto out;
> >  	}
> >  
> > -	ret = check_inum_access(ff, ino, mask);
> > +	ret = fuse4fs_inum_access(ff, ino, mask);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -4247,7 +4250,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
> >  	*node_name = 0;
> >  
> >  	fs = fuse4fs_start(ff);
> > -	if (!fs_can_allocate(ff, 1)) {
> > +	if (!fuse4fs_can_allocate(ff, 1)) {
> >  		ret = -ENOSPC;
> >  		goto out2;
> >  	}
> > @@ -4259,7 +4262,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
> >  		goto out2;
> >  	}
> >  
> > -	ret = check_inum_access(ff, parent, A_OK | W_OK);
> > +	ret = fuse4fs_inum_access(ff, parent, A_OK | W_OK);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -4326,7 +4329,7 @@ static int op_create(const char *path, mode_t mode, struct fuse_file_info *fp)
> >  
> >  	ext2fs_inode_alloc_stats2(fs, child, 1, 0);
> >  
> > -	ret = propagate_default_acls(ff, parent, child, inode.i_mode);
> > +	ret = fuse4fs_propagate_default_acls(ff, parent, child, inode.i_mode);
> >  	if (ret)
> >  		goto out2;
> >  
> > @@ -4374,7 +4377,7 @@ static int op_utimens(const char *path, const struct timespec ctv[2],
> >  	 */
> >  	if (ctv[0].tv_nsec == UTIME_NOW && ctv[1].tv_nsec == UTIME_NOW)
> >  		access |= A_OK;
> > -	ret = check_inum_access(ff, ino, access);
> > +	ret = fuse4fs_inum_access(ff, ino, access);
> >  	if (ret)
> >  		goto out;
> >  
> > @@ -4459,7 +4462,7 @@ static int ioctl_setflags(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
> >  	if (err)
> >  		return translate_error(fs, fh->ino, err);
> >  
> > -	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> > +	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> >  		return -EPERM;
> >  
> >  	ret = set_iflags(&inode, flags);
> > @@ -4508,7 +4511,7 @@ static int ioctl_setversion(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
> >  	if (err)
> >  		return translate_error(fs, fh->ino, err);
> >  
> > -	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> > +	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> >  		return -EPERM;
> >  
> >  	inode.i_generation = generation;
> > @@ -4633,7 +4636,7 @@ static int ioctl_fssetxattr(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
> >  	if (err)
> >  		return translate_error(fs, fh->ino, err);
> >  
> > -	if (want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> > +	if (fuse4fs_want_check_owner(ff, ctxt) && inode_uid(inode) != ctxt->uid)
> >  		return -EPERM;
> >  
> >  	ret = set_xflags(&inode, fsx->fsx_xflags);
> > @@ -4762,7 +4765,7 @@ static int ioctl_shutdown(struct fuse4fs *ff, struct fuse4fs_file_handle *fh,
> >  	struct fuse_context *ctxt = fuse_get_context();
> >  	ext2_filsys fs = ff->fs;
> >  
> > -	if (!is_superuser(ff, ctxt))
> > +	if (!fuse4fs_is_superuser(ff, ctxt))
> >  		return -EPERM;
> >  
> >  	err_printf(ff, "%s.\n", _("shut down requested"));
> > @@ -4884,7 +4887,7 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
> >  		   (unsigned long long)len,
> >  		   (unsigned long long)start,
> >  		   (unsigned long long)end);
> > -	if (!fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
> > +	if (!fuse4fs_can_allocate(ff, FUSE4FS_B_TO_FSB(ff, len)))
> >  		return -ENOSPC;
> >  
> >  	err = fuse4fs_read_inode(fs, fh->ino, &inode);
> > @@ -4927,9 +4930,9 @@ static int fuse4fs_allocate_range(struct fuse4fs *ff,
> >  	return err;
> >  }
> >  
> > -static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
> > -				    struct ext2_inode_large *inode,
> > -				    off_t offset, off_t len, char **buf)
> > +static errcode_t fuse4fs_zero_middle(struct fuse4fs *ff, ext2_ino_t ino,
> > +				     struct ext2_inode_large *inode,
> > +				     off_t offset, off_t len, char **buf)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	blk64_t blk;
> > @@ -4963,9 +4966,9 @@ static errcode_t clean_block_middle(struct fuse4fs *ff, ext2_ino_t ino,
> >  	return io_channel_write_blk64(fs->io, blk, 1, *buf);
> >  }
> >  
> > -static errcode_t clean_block_edge(struct fuse4fs *ff, ext2_ino_t ino,
> > -				  struct ext2_inode_large *inode, off_t offset,
> > -				  int clean_before, char **buf)
> > +static errcode_t fuse4fs_zero_edge(struct fuse4fs *ff, ext2_ino_t ino,
> > +				   struct ext2_inode_large *inode, off_t offset,
> > +				   int clean_before, char **buf)
> >  {
> >  	ext2_filsys fs = ff->fs;
> >  	blk64_t blk;
> > @@ -5056,13 +5059,13 @@ static int fuse4fs_punch_range(struct fuse4fs *ff,
> >  
> >  	/* Zero everything before the first block and after the last block */
> >  	if (FUSE4FS_B_TO_FSBT(ff, offset) == FUSE4FS_B_TO_FSBT(ff, offset + len))
> > -		err = clean_block_middle(ff, fh->ino, &inode, offset,
> > +		err = fuse4fs_zero_middle(ff, fh->ino, &inode, offset,
> >  					 len, &buf);
> >  	else {
> > -		err = clean_block_edge(ff, fh->ino, &inode, offset, 0, &buf);
> > +		err = fuse4fs_zero_edge(ff, fh->ino, &inode, offset, 0, &buf);
> >  		if (!err)
> > -			err = clean_block_edge(ff, fh->ino, &inode,
> > -					       offset + len, 1, &buf);
> > +			err = fuse4fs_zero_edge(ff, fh->ino, &inode,
> > +						offset + len, 1, &buf);
> >  	}
> >  	if (buf)
> >  		ext2fs_free_mem(&buf);
> > 

