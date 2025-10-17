Return-Path: <linux-ext4+bounces-10965-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC26BEC015
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Oct 2025 01:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591F45E8322
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F0E29ACF6;
	Fri, 17 Oct 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsuJjVey"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943223BF91
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760743976; cv=none; b=ndzsduTzqurRpLLuXx+CFpeUI4NbMnQmAIByoBniEsUd7yfEhoWbhsfW8cwtkF1PxgFDMBl5Fb6eV7P8a70fEDG6eGb8r0rGP2OXkkG3rmNtEXxWsMlLqXPXBfdYjOZ3F2JrgcncOHWqn44vr76DHN2+3SuoVpWC3Mi7pkeQA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760743976; c=relaxed/simple;
	bh=zs1v+GRTCMF2iz82+kmbHm2gBAyX8OuK3v2RfFstACE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hldfDxlIZVN7x1gCvGLsC9RXy4W3MEZJYyRVGF9Vdq6OFSU9eoFXE+vKw7YbudU2o/B5EKr7qA4X1EDVWP8FUZaPMCJrKGAnViNf380fXy8dvA1CNZvxQRmLT89m2frpgyJwLuXM+JWWEaC4KD3ect113aph09xCjvv3eaC7cJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsuJjVey; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB05FC4CEE7;
	Fri, 17 Oct 2025 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760743975;
	bh=zs1v+GRTCMF2iz82+kmbHm2gBAyX8OuK3v2RfFstACE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsuJjVeyMyuWnf9F+jqXvqHmS8oUtImRSixkXOf7BY/UbfNWgwhv7AzrDx083G7lx
	 nhskN1+IpYBUJRSZNH6KFmzL1P5FD2BVL6VP8qynPvVp0pmjaZSlIkv6cYCBZXXT2A
	 vc9su8PlnwIxnT+ZS9/+Jcz2y0FNBC39HiKYGn5lZdjjOoaMWpSB4c11iR/OJYTNs9
	 oMmYb9lmFcfsHV2RiAAiTKdULKuNraRIKG9ufnooxOyApOLVMmliFQi9vpyK7XRGJs
	 qiYV2T/hy+g13inUod1UcLJTckg+DFybQxfuoDmxtuE1Z2uR5+8tWqiMiIaeSGmE9w
	 yICfMDtbiEwtw==
Date: Fri, 17 Oct 2025 16:32:55 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dave.dykstra@cern.ch>, Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: open read-only when image is not writable
Message-ID: <20251017233255.GL6170@frogsfrogsfrogs>
References: <20251017211130.8507-1-dave.dykstra@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017211130.8507-1-dave.dykstra@cern.ch>

On Fri, Oct 17, 2025 at 04:11:30PM -0500, Dave Dykstra wrote:
> This opens the image read-only when the image is not writable. If it is then found that a journal recovery is needed, an error is returned then.
> 
> The ret value is set to 2 after the option checks so that if there's an error resulting in "goto out" it won't print an error about unrecognized options.
> 
> Also submitted as PR https://github.com/tytso/e2fsprogs/pull/250
> for the issue https://github.com/tytso/e2fsprogs/issues/244.
> 
> Replaces 
>   https://lore.kernel.org/linux-ext4/20251016200206.3035-1-dave.dykstra@cern.ch/
>   https://lore.kernel.org/linux-ext4/175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs/
> 
> Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>

Please slow down and give me a chance to reshuffle and QA my existing
fixes for the problems you've complained about.

--D

> ---
>  misc/fuse2fs.c | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index cb5620c7..6a107d2b 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4696,9 +4696,24 @@ int main(int argc, char *argv[])
>  	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
>  			   &global_fs);
>  	if (err) {
> -		err_printf(&fctx, "%s.\n", error_message(err));
> -		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
> -		goto out;
> +		if ((err == EACCES) || (err == EPERM)) {
> +			if (fctx.ro) {
> +				dbg_printf(&fctx, "%s: %s\n", __func__,
> + _("Permission denied with writable, trying without.\n"));
> +			} else {
> +				dbg_printf(&fctx, "%s: %s\n", __func__,
> + _("No write access, opening read-only.\n"));
> +				fctx.ro = 1;
> +			}
> +			flags &= ~EXT2_FLAG_RW;
> +			err = ext2fs_open2(fctx.device, options, flags, 0, 0, 
> +					   unix_io_manager, &global_fs);
> +		}
> +		if (err) {
> +			err_printf(&fctx, "%s.\n", error_message(err));
> +			err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
> +			goto out;
> +		}
>  	}
>  	fctx.fs = global_fs;
>  	global_fs->priv_data = &fctx;
> @@ -4741,6 +4756,8 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	ret = 2;
> +
>  	if (global_fs->super->s_state & EXT2_ERROR_FS) {
>  		err_printf(&fctx, "%s\n",
>   _("Errors detected; running e2fsck is required."));
> @@ -4760,6 +4777,11 @@ int main(int argc, char *argv[])
>   _("Mounting read-only without recovering journal."));
>  			fctx.ro = 1;
>  			global_fs->flags &= ~EXT2_FLAG_RW;
> +		} else if (fctx.ro && !(flags & EXT2_FLAG_RW)) {
> +			err_printf(&fctx, "%s\n",
> + _("Journal needs recovery but filesystem could not be opened read-write."));
> +			err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
> +			goto out;
>  		} else {
>  			log_printf(&fctx, "%s\n", _("Recovering journal."));
>  			err = ext2fs_run_ext3_journal(&global_fs);
> @@ -4833,8 +4855,10 @@ int main(int argc, char *argv[])
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
> -- 
> 2.43.5
> 
> 

