Return-Path: <linux-ext4+bounces-10876-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA3ABDBF80
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 03:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B4E3C1873
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Oct 2025 01:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E632F5485;
	Wed, 15 Oct 2025 01:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewLrPDDV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E82F6176
	for <linux-ext4@vger.kernel.org>; Wed, 15 Oct 2025 01:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760490907; cv=none; b=BOeqoy5Kd7rdxjQPC5QXN1O7cj0XV8P6sEgt0RJmsWwKmdk18tmA1O7jBIprPd6L80cpDvTKRxudqSPnCrsSZadppuBxnv82t4q1cV4yvJ5J9xgIiLW5mWHSOq3CFcKpg8pMNPJd+xTT/VTh3M88cUshNmc4V7DX0ydATVC/fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760490907; c=relaxed/simple;
	bh=Yy9owtTi/yAxSJw/spwWSzSuAacHbrDAYS0eaCgFAys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WbXgZqjtyxK1/iYFiRbJzq0UCn6C+F/G3BpWVrc60FP6euip6d+IBPcj0D4AheVqzzY96/O1D4nPbWDMp0GdlaJVFW7JoT7d5k5WT5O9TX+rsqLSwLExlCGO39poC+62sm6chm//5yRgHxTNIZeL+J2GA5EhQp4fKNKnihz2FS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewLrPDDV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E144C4CEE7;
	Wed, 15 Oct 2025 01:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760490906;
	bh=Yy9owtTi/yAxSJw/spwWSzSuAacHbrDAYS0eaCgFAys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewLrPDDV//xaOE3e+yK0CGIKyMFzsBs+nqKTOeSduRfbFT2NxhmCKqnuqHE9ZLEMK
	 h/6/98RMp0FjsD9Ddz0B2Hu8PXk7Cd6/Dz1k2OA1CgHIhaoS8h4NdP0iElcN4qixoT
	 h/EoJEmCDAw2kxUHKmCroGBjLY3pWDY5JoiO7Z+BFlbskyUilC7jZ0f3xJCfbkl3vO
	 PwxPeq80yaUT7z9mLF2PCbMSngtRYFI0aZHVcvYBuc1ujKRIit/eaCmXnu/PVctRzx
	 BsAnMzMxh+osy7Pig8nwMBs/NAtOZwF0aDlSFE8/9E6D0/lzetxqRVOwoyIM1zMrW+
	 H9XQlr+J9H3ag==
Date: Tue, 14 Oct 2025 18:15:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dave.dykstra@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: reopen filesystem read-write for read-only
 journal recovery
Message-ID: <20251015011505.GD6170@frogsfrogsfrogs>
References: <20251010214735.22683-1-dave.dykstra@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010214735.22683-1-dave.dykstra@cern.ch>

On Fri, Oct 10, 2025 at 04:47:35PM -0500, Dave Dykstra wrote:
> This changes the strategy added in c7f2688540d95e7f2cbcd178f8ff62ebe079faf7
> for recovery of journals when read-only is requested.  That strategy always
> opened the filesystem file read-write first, in case there was a journal to
> recover.  A big problem with that strategy was that the user might not have
> write access to the file.  The new strategy with read-only mounts is to
> open the filesystem read-only first, then if there is a journal that needs
> recovery, attempt to reopen it read-write.  If that works and the journal
> is recovered, reopen it again read-only.
> 
> - Fixes https://github.com/tytso/e2fsprogs/issues/244
> 
> Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
> ---
>  misc/fuse2fs.c | 62 ++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 7 deletions(-)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index cb5620c7..30a46976 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4607,8 +4607,7 @@ int main(int argc, char *argv[])
>  	FILE *orig_stderr = stderr;
>  	char extra_args[BUFSIZ];
>  	int ret;
> -	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE |
> -		    EXT2_FLAG_RW;
> +	int flags = EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | EXT2_FLAG_EXCLUSIVE;
>  
>  	memset(&fctx, 0, sizeof(fctx));
>  	fctx.magic = FUSE2FS_MAGIC;
> @@ -4689,6 +4688,8 @@ int main(int argc, char *argv[])
>  
>  	/* Start up the fs (while we still can use stdout) */
>  	ret = 2;
> +	if (!fctx.ro)

ro and EXT2_FLAG_RW are not the same thing!

The rw/ro arguments are passed through to the kernel; they determine
whether or not user programs can write to the directory tree.  That's up
to the kernel.

EXT2_FLAG_RW determines if the filesystem can be written to at all.
It's set by default, but it is cleared if the user passes norecovery
as an option or the block device can't be opened.

You can have a ro mount of a EXT2_FLAG_RW filesystem.  That means that
the filesystem can modify/reorganize itself, even if users can't write
to files.

> +		flags |= EXT2_FLAG_RW;
>  	char options[50];
>  	sprintf(options, "offset=%lu", fctx.offset);
>  	if (fctx.directio)
> @@ -4751,8 +4752,12 @@ int main(int argc, char *argv[])
>  	 * ext4 can't do COW of shared blocks, so if the feature is enabled,
>  	 * we must force ro mode.
>  	 */
> -	if (ext2fs_has_feature_shared_blocks(global_fs->super))
> +	if (ext2fs_has_feature_shared_blocks(global_fs->super) && !fctx.ro) {
> +		log_printf(&fctx, "%s\n",
> + _("Mounting read-only because shared blocks feature is enabled."));
>  		fctx.ro = 1;
> +		/* Note that EXT2_FLAG_RW is left set */
> +	}

Yeah, the logging here could be improved.

>  
>  	if (ext2fs_has_feature_journal_needs_recovery(global_fs->super)) {
>  		if (fctx.norecovery) {
> @@ -4761,6 +4766,27 @@ int main(int argc, char *argv[])
>  			fctx.ro = 1;
>  			global_fs->flags &= ~EXT2_FLAG_RW;
>  		} else {
> +			if (!(flags & EXT2_FLAG_RW)) {

I don't like this, because we should open the filesystem with
EXT2_FLAG_RW set by default and only downgrade to !EXT2_FLAG_RW if we
can't open it...

> +				/* Attempt to re-open read-write */
> +				err = ext2fs_close(global_fs);
> +				if (err)
> +					com_err(argv[0], err,
> +						"while closing filesystem");
> +				global_fs = NULL;

...if the close fails, you just leaked the old global_fs context.
ext2fs_close_free is what you want (and yes that's a bug in fuse2fs).

> +				flags |= EXT2_FLAG_RW;
> +				err = ext2fs_open2(fctx.device, options, flags,
> +						   0, 0, unix_io_manager,
> +						   &global_fs);
> +				if (err) {
> +					err_printf(&fctx, "%s.\n",
> +						   error_message(err));
> +					err_printf(&fctx, "%s\n",
> + _("Journal needs recovery but filesystem cannot be reopened read-write."));
> +					err_printf(&fctx, "%s\n",
> + _("Please run e2fsck -fy."));
> +					goto out;
> +				}

...and also, if you re-do ext2fs_open2(), you then have to re-check all
the feature support bits above because we unlocked the filesystem
device, which means its contents could have been replaced completely
in the interim.

Also note that I have a /very large/ pile of fuse2fs improvements and
rewrites and cleanups that are out for review on the list; you might
want to look at those first.

--D

> +			}
>  			log_printf(&fctx, "%s\n", _("Recovering journal."));
>  			err = ext2fs_run_ext3_journal(&global_fs);
>  			if (err) {
> @@ -4772,12 +4798,32 @@ int main(int argc, char *argv[])
>  			ext2fs_clear_feature_journal_needs_recovery(global_fs->super);
>  			ext2fs_mark_super_dirty(global_fs);
>  		}
> +	} else if (fctx.ro && !(flags & EXT2_FLAG_RW)) {
> +		log_printf(&fctx, "%s\n", _("Mounting read-only."));
>  	}
>  
> -	if (global_fs->flags & EXT2_FLAG_RW) {
> +	if (fctx.ro && (flags & EXT2_FLAG_RW)) {
> +		/* Re-open read-only */
> +		err = ext2fs_close(global_fs);
> +		if (err)
> +			com_err(argv[0], err, "while closing filesystem");
> +		global_fs = NULL;
> +		flags &= ~EXT2_FLAG_RW;
> +		err = ext2fs_open2(fctx.device, options, flags, 0, 0,
> +				   unix_io_manager, &global_fs);
> +		if (err) {
> +			err_printf(&fctx, "%s.\n", error_message(err));
> +			err_printf(&fctx, "%s\n",
> + _("Failed to remount read-only."));
> +			goto out;
> +		}
> +		log_printf(&fctx, "%s\n", _("Remounted read-only."));
> +	}
> +
> +	if (!fctx.ro) {
>  		if (ext2fs_has_feature_journal(global_fs->super))
>  			log_printf(&fctx, "%s",
> - _("Warning: fuse2fs does not support using the journal.\n"
> + _("Warning: fuse2fs does not support writing the journal.\n"
>     "There may be file system corruption or data loss if\n"
>     "the file system is not gracefully unmounted.\n"));
>  		err = ext2fs_read_inode_bitmap(global_fs);
> @@ -4833,8 +4879,10 @@ int main(int argc, char *argv[])
>  	if (fctx.no_default_opts == 0)
>  		fuse_opt_add_arg(&args, extra_args);
>  
> -	if (fctx.ro)
> +	if (fctx.ro) {
> +		/* This is in case ro was implied above and not passed in */
>  		fuse_opt_add_arg(&args, "-oro");
> +	}
>  
>  	if (fctx.fakeroot) {
>  #ifdef HAVE_MOUNT_NODEV
> @@ -4892,7 +4940,6 @@ int main(int argc, char *argv[])
>  		ret = 0;
>  		break;
>  	}
> -out:
>  	if (ret & 1) {
>  		fprintf(orig_stderr, "%s\n",
>   _("Mount failed due to unrecognized options.  Check dmesg(1) for details."));
> @@ -4903,6 +4950,7 @@ out:
>   _("Mount failed while opening filesystem.  Check dmesg(1) for details."));
>  		fflush(orig_stderr);
>  	}
> +out:
>  	if (global_fs) {
>  		err = ext2fs_close(global_fs);
>  		if (err)
> -- 
> 2.43.5
> 
> 

