Return-Path: <linux-ext4+bounces-10953-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30425BEB614
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 21:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED7BA404306
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Oct 2025 19:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704352F7455;
	Fri, 17 Oct 2025 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVdd0IMm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666F33F8A5
	for <linux-ext4@vger.kernel.org>; Fri, 17 Oct 2025 19:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760729097; cv=none; b=nwKrUEYqVPT8VgqNt8sg+hSCWX6A5oGD5C8dJmimV5ljHKrfaWsRGs/TOQ9PtMNj/Y8O8PpKOqmlH7/GUkSUlCbzCrQPMOssGYlBfgGvgQxFbg9o1+ipNyxTnMDBSLAhzhEbz9D5vJfpJ95mTXpfbl9bz85KlusKvnn4Zo73z48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760729097; c=relaxed/simple;
	bh=V0FWF77fBUf0wF2BfPnQ0/ommV10TP68zdmApRwPb4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O2Th4AMDN3Rgo60HKdpgKrR2dAqAp7vK9fg39fDWbIr54QVK4hJXGuxgDymxMeem/CUodT/O50QuCVPd6OHYRTQ4CZAXCjJIi1X+39BNLXtrBHF+rWFFAPCcWgEqCNnV1Q+V1nK60ahCozdSfbAuA2MTOKt9XrAuRuyMVv2wZhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVdd0IMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D33C4CEE7;
	Fri, 17 Oct 2025 19:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760729096;
	bh=V0FWF77fBUf0wF2BfPnQ0/ommV10TP68zdmApRwPb4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZVdd0IMm6WJ0Q0z3cEmbeTgfabr2IGlKLrTDIfYgHZfO7ibKSerhL4/iA12P9K4/o
	 JGo8qP8HR0iDDlcAAhgYvPMKk8YcYurXvRmBhMubvvgM5y5ZIw5GUIUx2suWAL1rNT
	 d/nKOeUh2bOzu+gm4W41SfSzVutmi5S6YO/PyRh1mClMihNXscJYKb0nxYg+ivTCCj
	 rvWOTD0o1aR8hSsbGpTXPMWV3pFLPavKzjfuj+jByx/G7HsVighixIShk3f6Vtz8WZ
	 OKCuPUOTdES4f/RGs4FiwlvMlrE6KvmcKvb4Qzhx2v/9DVHumMLJECf2UyWkoDhhlH
	 LNWEmw9DP2Y1g==
Date: Fri, 17 Oct 2025 12:24:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Dave Dykstra <dave.dykstra@cern.ch>
Cc: linux-ext4@vger.kernel.org,
	Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
Subject: Re: [PATCH] fuse2fs: open read-only when ro option and image
 non-writable
Message-ID: <20251017192456.GG6170@frogsfrogsfrogs>
References: <20251016200206.3035-1-dave.dykstra@cern.ch>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016200206.3035-1-dave.dykstra@cern.ch>

On Thu, Oct 16, 2025 at 03:02:06PM -0500, Dave Dykstra wrote:
> This opens the image read-only when an ro option is given and the
> image is not writable.  If it is then found that a journal recovery
> is needed, an error is returned then.
> 
> The ret value is set to 4 after the option checks so that if there's
> an error resulting in "goto out" it won't print an error about
> unrecognized options.
> 
> Also submitted as PR https://github.com/tytso/e2fsprogs/pull/250
> for the issue https://github.com/tytso/e2fsprogs/issues/244.
> 
> Replaces 
>     https://lore.kernel.org/linux-ext4/20251010214735.22683-1-dave.dykstra@cern.ch/T/#u
>     https://lore.kernel.org/linux-ext4/175798064776.350013.6744611652039454651.stgit@frogsfrogsfrogs/#t
> 
> Signed-off-by: Dave Dykstra <2129743+DrDaveD@users.noreply.github.com>
> ---
>  misc/fuse2fs.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index cb5620c7..2ae2fc1a 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4696,9 +4696,19 @@ int main(int argc, char *argv[])
>  	err = ext2fs_open2(fctx.device, options, flags, 0, 0, unix_io_manager,
>  			   &global_fs);
>  	if (err) {
> -		err_printf(&fctx, "%s.\n", error_message(err));
> -		err_printf(&fctx, "%s\n", _("Please run e2fsck -fy."));
> -		goto out;
> +		if (((err == EACCES) || (err == EPERM)) && fctx.ro) {

This is not correct.  mount(8) for the kernel ext4 driver responds to
the block device being readonly by retrying with an ro mount.  The user
is not required to specify 'ro':

# blockdev --setro/ dev/sda
# strace -e mount mount /dev/sda /mnt
40677<mount> 12:19:36 (+     0.000102) mount("/dev/sda", "/mnt", "ext4", 0, NULL) = -1 EACCES (Permission denied)
40677<mount> 12:19:36 (+     0.000285) mount("/dev/sda", "/mnt", "ext4", MS_RDONLY, NULL) = 0

> +			// read-only requested and don't have write access
> +			dbg_printf(&fctx, "%s: %s\n", __func__,
> + _("Permission denied with writable, trying without.\n"));
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
> @@ -4741,6 +4751,8 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	ret = 4;

Why 4?  Is this an internal mount bug?

--D

> +
>  	if (global_fs->super->s_state & EXT2_ERROR_FS) {
>  		err_printf(&fctx, "%s\n",
>   _("Errors detected; running e2fsck is required."));
> @@ -4760,6 +4772,11 @@ int main(int argc, char *argv[])
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
> @@ -4833,8 +4850,10 @@ int main(int argc, char *argv[])
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

