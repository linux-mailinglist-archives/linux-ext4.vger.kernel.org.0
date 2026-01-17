Return-Path: <linux-ext4+bounces-12949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB4D38BB3
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 03:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2FBAC3000183
	for <lists+linux-ext4@lfdr.de>; Sat, 17 Jan 2026 02:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527A92FD7A3;
	Sat, 17 Jan 2026 02:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iPthp0AS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B56E2F747D
	for <linux-ext4@vger.kernel.org>; Sat, 17 Jan 2026 02:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768617361; cv=none; b=u5UJVfi6MUrswMzRLXGLF8EMgubOiLljJ6lqza6MuARacMmpObFVfYACUeGb74XgkeUVq/q/l2gxwdkF4z8ZYN1CfnJF3MbSTRw1LugWw4ZIX4lp/sJleNwO4FKfQHkaB5uE5gVyscTMfuJa0QTJxLpgnFsVVMBvaonIavayjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768617361; c=relaxed/simple;
	bh=RLqUT5lI622iGQrK5X0BBni1xmhAmKjvMWG/xUpCDpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFEZII0UUeo4ABDquDiQojdbwdWqnszf9iTADFyvfIN5BCvHYG9XdkJ0JI/hlrP6f5LLEaDa09x3KSdAdp+E2sTQx1SrRHG/p2EpmHJiOor4CqfsDBoe4rZxrWrApHNOoiy8kKfgeLQoaotKmBrsA2bktMqeux6WFAarplTVV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPthp0AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7E4C116C6;
	Sat, 17 Jan 2026 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768617360;
	bh=RLqUT5lI622iGQrK5X0BBni1xmhAmKjvMWG/xUpCDpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPthp0AS19tOlPjdcu1PDKC2BqOV/oKCurh0SQQrJHUQzaZGUhf2IRoG0wFDUsuYZ
	 hH3KnrQM8ITzooz8nb5yBBNR38axtCxNGbHzKYWBcbp+p+B6z0ea5+FUhMlulQNYRe
	 vXhj/A23M6t5C9trWyp+JkjFtCWmLxaum7jBAWkFLNiux2AArWeJ60oD2GpVFDmvE3
	 gVVxGSn+z5vUg8ZF81fDOmb8woc1WQ5kQ0iLKPzXZ5FpTVN5PYV8FR6jYxOBSAHrsT
	 bFkJ0APlnPhvycLdWUH5DWEFYSU671ckNKivCBWSNOVJi7WHz9UImsfRrihcgfUFwX
	 wnSFyIOBcwSKg==
Date: Fri, 16 Jan 2026 18:35:59 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Daniel Tang <danielzgtg.opensource@gmail.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] e4defrag inline data segfault fix
Message-ID: <20260117023559.GC15522@frogsfrogsfrogs>
References: <4378305.GUtdWV9SEq@daniel-desktop3>
 <20260116172139.GB15522@frogsfrogsfrogs>
 <20260116234405.GG19200@macsyma.local>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116234405.GG19200@macsyma.local>

On Fri, Jan 16, 2026 at 01:44:05PM -1000, Theodore Tso wrote:
> On Fri, Jan 16, 2026 at 09:21:39AM -0800, Darrick J. Wong wrote:
> > On Fri, Jan 16, 2026 at 05:25:35AM -0500, Daniel Tang wrote:
> > > Please sign-off on, and apply, the patch at
> > > https://gist.github.com/tytso/609572aed4d3f789742a50356567e929 . It
> > > fixes the bug at https://github.com/tytso/e2fsprogs/issues/260 .
> > 
> > Perhaps that patch should get posted to the list for a proper review?
> 
> The context was that Daniel had proposed a pull request on github:
> 
>    https://github.com/tytso/e2fsprogs/pull/261
> 
> I had reviewed the change on github, and counter-proposed a better
> fix, which was what Daniel was referring to on the gist.github.com,
> and asked him to confirm that this fixed the issue that he was
> concerned about.
> 
> This took place in early Ddecember, and I lost track of it because of
> the holidays.  (Daniel, that's because my primary workflow is e-mail,
> and github issues and pull requests are things that I look at on a
> best-efforts basis, whereas with e-mail I have things like Patchwork
> to make sure I don't lose track of patch discussions.  It also means
> that other people can more easily review proposed fixes.)
> 
> Anyway, for folks on the ext4 list who might be curious, here's the
> fix.  As it turns out, this is one where the description of the fix
> takes a lot more space than the actual fix itself.  Which is why I
> hadn't bothered to write it all up before asking Daniel to test it to
> make sure it fixed the issue that he had run into.

<nod> bugfixes are fun like that :D

>       	    	       	    	       - Ted
> 
> commit 23785e90554b301b90076568fd33eb76dc930fba
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Fri Jan 16 18:01:09 2026 -0500
> 
>     e4defrag: don't try to defragment files which have 0 or 1 blocks
>     
>     This fixes a crash in e4defrag when the file is using the inline_data
>     feature, and so the file data is stored in the inode table.
>     Technically speaking, such a file does not consume any data blocks,
>     but when an application program calls stat(2) on such a file, and
>     st_blocks is set to 0, it might confuse the program into thinking the
>     file did not contain any data.  For this reason, ext4 returns 1 in
>     st_blocks.  (For other files or directories, st_blocks will be a
>     multiple of the file system block size divided by 512, since st_blocks
>     is denominated in units of 512 sectors on Linux --- and most other Unix
>     systems with the notable exception of HP-UX.)
>     
>     Unfortunately, when e4defrag tries to defragment a inline data file,
>     it divides st_blocks by (fs->block_size / 512), and this results in
>     e4defrag thinking that the file 0 data blocks --- and since the file
>     is not skipped because st_blocks != 0, this results in crash when
>     dividing by zero.
>     
>     As it turns out, it's pointless to try to defrag a file with 0 or 1
>     data blocks.  So fix this by skipping any file where st_blocks <=
>     block_size / 512.

Excellent description.  I glanced at the github issue this morning and
wondered what was going on with all the /512s...

>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/misc/e4defrag.c b/misc/e4defrag.c
> index bbeb5b167..68e937fdb 100644
> --- a/misc/e4defrag.c
> +++ b/misc/e4defrag.c
> @@ -1091,11 +1091,11 @@ static int file_statistic(const char *file, const struct stat64 *buf,
>  		return 0;
>  	}
>  
> -	/* Has no blocks */
> -	if (buf->st_blocks == 0) {
> +	/* Has 0 or 1 blocks, no point to defragment */
> +	if (buf->st_blocks <= buf->st_blksize / 512) {

...because can't you call FS_IOC_GETFLAGS and look for
EXT4_INLINE_DATA_FL?

--D

>  		if (mode_flag & DETAIL) {
>  			PRINT_FILE_NAME(file);
> -			STATISTIC_ERR_MSG("File has no blocks");
> +			STATISTIC_ERR_MSG("# of file blocks <= 1");
>  		}
>  		return 0;
>  	}
> @@ -1452,11 +1452,11 @@ static int file_defrag(const char *file, const struct stat64 *buf,
>  		return 0;
>  	}
>  
> -	/* Has no blocks */
> -	if (buf->st_blocks == 0) {
> +	/* Has 0 or 1 blocks, no point to defragment */
> +	if (buf->st_blocks <= buf->st_blksize / 512) {
>  		if (mode_flag & DETAIL) {
>  			PRINT_FILE_NAME(file);
> -			STATISTIC_ERR_MSG("File has no blocks");
> +			IN_FTW_PRINT_ERR_MSG("# of file blocks <= 1");
>  		}
>  		return 0;
>  	}
> 

