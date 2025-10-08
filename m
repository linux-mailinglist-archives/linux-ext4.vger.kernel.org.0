Return-Path: <linux-ext4+bounces-10694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36986BC6BC1
	for <lists+linux-ext4@lfdr.de>; Thu, 09 Oct 2025 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310DE19E0A1E
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Oct 2025 22:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BA2C11F9;
	Wed,  8 Oct 2025 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epV1zfrN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F61E25F9
	for <linux-ext4@vger.kernel.org>; Wed,  8 Oct 2025 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759961076; cv=none; b=OpZT07+S3RfR9DOcdvGvNJcZ5knBUn4qAMMQ2IoM5HzOqSmnpx8J3/B6nM9mdlDvhQWq78gQqDNFIjpukhLpDBMAh/BBGdyxD38Y9QE5ClAIv2eeMv36NoljK6h+FvdzDFKSZj44I6WAkT0NEQnVuhf5I1RJtA+oA0G5OFkmQ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759961076; c=relaxed/simple;
	bh=duvYUI29Nzo/23seB5TluWHUuch3xgXPc1ER95J80+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y099MiCsZn/MtOyhbrDinAqN5PJSKpiLHc0E2GEdiWJl9jKQ34nqU2fSdaqZ6vo9srlSva8N02kWtCsp6LDgUj4zQAU6rFsgnOqjgBI6uiQN1D7RCHB+yRHA9wKKQqKsEbC9sDoz/aMJ2vKmlCLzaYcZecUeIgtNLuuQRMb+kPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epV1zfrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98D53C4CEF9;
	Wed,  8 Oct 2025 22:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759961075;
	bh=duvYUI29Nzo/23seB5TluWHUuch3xgXPc1ER95J80+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epV1zfrNdCfzbB+pR8AKzPdsU+Fz9Cfw/kfiEWuXhFiag9m9IZUNvgz6FWHn7I76Q
	 FAGJ1swcr5B21pjZf8B4TNgcUe11Jlnl9S+iR5RuvaPCUN8fIAwuigXCGtWlFNaCBZ
	 KRw9pdiEdkYG+5Z8nObA8NbDQrP6+0An/kBzAJX5MuqDmOeZGEcF8Z2ScHqEeSfMkX
	 iAqjJkTnm5ClGTnI2+Yj4zHXolwsXsK5YN+6fj4creiCKBIqS1WVZl+WESXVuE0+TP
	 ZaYx8iUmIblnnVBm/wbtXkSr6wPxBaE/1F+LkvQ16P26zpLK4cfpwOJIQGP2yrv5iP
	 VgxwmWfuDpJQA==
Date: Wed, 8 Oct 2025 15:04:34 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse2fs: enable the shutdown ioctl
Message-ID: <20251008220434.GA6170@frogsfrogsfrogs>
References: <175798065146.350393.10618193797364129539.stgit@frogsfrogsfrogs>
 <175798065210.350393.10163706639168342705.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175798065210.350393.10163706639168342705.stgit@frogsfrogsfrogs>

On Mon, Sep 15, 2025 at 05:05:35PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Implement a bastardized version of EXT4_IOC_SHUTDOWN, because the people
> who invented the ioctl got the direction wrong, so we can't actually
> read the flags.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  misc/fuse2fs.c |   42 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 38 insertions(+), 4 deletions(-)
> 
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 80d1c79b5cce1c..101f0fa03c397d 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -221,6 +221,7 @@ struct fuse2fs_file_handle {
>  enum fuse2fs_opstate {
>  	F2OP_READONLY,
>  	F2OP_WRITABLE,
> +	F2OP_SHUTDOWN,
>  };
>  
>  /* Main program context */
> @@ -276,7 +277,7 @@ struct fuse2fs {
>  		} \
>  	} while (0)
>  
> -#define __FUSE2FS_CHECK_CONTEXT(ff, retcode) \
> +#define __FUSE2FS_CHECK_CONTEXT(ff, retcode, shutcode) \
>  	do { \
>  		if ((ff) == NULL || (ff)->magic != FUSE2FS_MAGIC) { \
>  			fprintf(stderr, \
> @@ -285,14 +286,17 @@ struct fuse2fs {
>  			fflush(stderr); \
>  			retcode; \
>  		} \
> +		if ((ff)->opstate == F2OP_SHUTDOWN) { \
> +			shutcode; \
> +		} \
>  	} while (0)
>  
>  #define FUSE2FS_CHECK_CONTEXT(ff) \
> -	__FUSE2FS_CHECK_CONTEXT((ff), return -EUCLEAN)
> +	__FUSE2FS_CHECK_CONTEXT((ff), return -EUCLEAN, return -EIO)
>  #define FUSE2FS_CHECK_CONTEXT_RETURN(ff) \
> -	__FUSE2FS_CHECK_CONTEXT((ff), return)
> +	__FUSE2FS_CHECK_CONTEXT((ff), return, return)

This change means that we return early from op_destroy on a shut down
filesystem, which means that on iomap filesystems we don't actually
uphold the requirement that we've closed the block device before
replying to the FUSE_DESTROY message that the kernel gives us during
unmount.  This causes odd regressions on generic/730 and generic/635,
both of which are due to fstests not being able to format a new
filesystem because fuse4fs hasn't quite exited yet.

>  #define FUSE2FS_CHECK_CONTEXT_ABORT(ff) \
> -	__FUSE2FS_CHECK_CONTEXT((ff), abort())
> +	__FUSE2FS_CHECK_CONTEXT((ff), abort(), abort())
>  
>  static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
>  			     const char *func, int line);
> @@ -4566,6 +4570,33 @@ static int ioctl_fitrim(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
>  }
>  #endif /* FITRIM */
>  
> +#ifndef EXT4_IOC_SHUTDOWN
> +# define EXT4_IOC_SHUTDOWN	_IOR('X', 125, __u32)
> +#endif
> +
> +static int ioctl_shutdown(struct fuse2fs *ff, struct fuse2fs_file_handle *fh,
> +			  void *data)
> +{
> +	struct fuse_context *ctxt = fuse_get_context();
> +	ext2_filsys fs = ff->fs;
> +
> +	if (!is_superuser(ff, ctxt))
> +		return -EPERM;
> +
> +	err_printf(ff, "%s.\n", _("shut down requested"));
> +
> +	/*
> +	 * EXT4_IOC_SHUTDOWN inherited the inverted polarity on the ioctl
> +	 * direction from XFS.  Unfortunately, that means we can't implement
> +	 * any of the flags.  Flush whatever is dirty and shut down.
> +	 */
> +	if (ff->opstate == F2OP_WRITABLE)
> +		ext2fs_flush2(fs, 0);
> +	ff->opstate = F2OP_SHUTDOWN;

This needs to clear EXT2_FLAG_RW or else ext2fs_close2() will try to
write the group descriptors/superblock even though the filesystem was
supposedly shut down.

--D

> +
> +	return 0;
> +}
> +
>  #if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
>  static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
>  #if FUSE_VERSION >= FUSE_MAKE_VERSION(3, 0)
> @@ -4612,6 +4643,9 @@ static int op_ioctl(const char *path EXT2FS_ATTR((unused)),
>  		ret = ioctl_fitrim(ff, fh, data);
>  		break;
>  #endif
> +	case EXT4_IOC_SHUTDOWN:
> +		ret = ioctl_shutdown(ff, fh, data);
> +		break;
>  	default:
>  		dbg_printf(ff, "%s: Unknown ioctl %d\n", __func__, cmd);
>  		ret = -ENOTTY;
> 
> 

