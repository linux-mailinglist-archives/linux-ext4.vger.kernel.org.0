Return-Path: <linux-ext4+bounces-10645-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D6EBBF915
	for <lists+linux-ext4@lfdr.de>; Mon, 06 Oct 2025 23:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B4E3C21B1
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Oct 2025 21:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362C6258EC1;
	Mon,  6 Oct 2025 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozMAegp2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD87D226CE0
	for <linux-ext4@vger.kernel.org>; Mon,  6 Oct 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759785787; cv=none; b=Da/uCQ4iy8iwz7EV/trbn7subHIKEZXqPPfj+0GHNIT1y/pe9yyakYLyC2mpPT1u4ava0E7qS5mybzgWI1F6yAcpenF4GeLnt+iEZalFunQgORYO1ig6aMEJFIdFlk1qDMSz+nVjG6D+NDAySnmIHsYjYZ2dkwiIgTPrd1KXiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759785787; c=relaxed/simple;
	bh=1kIc6IWwQBkBLR2/aoO4e4id1OSr8H3D/Oz6OHEVkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG1mcKsmLiUHszt52KPmi/9ZQIuAAZWnisFOhlFBS2pjsj4KBjmhZm4EayMsbAmF1+fTk5KddXNAa/MCqyrhpWaF3LXi/wNjG3egyZtwY7OF66KEgUhBspubgXYHojAvPfhNTVxZN2acwAHn8/lAFzuWbUWy5wWq6Oh8a/Tk5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozMAegp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FBC4CEF5;
	Mon,  6 Oct 2025 21:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759785787;
	bh=1kIc6IWwQBkBLR2/aoO4e4id1OSr8H3D/Oz6OHEVkyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozMAegp2H0tuPML136afVRmTwZkTqVEWL1a8uFFMmvsGPBzzJpVrBAiviQTOiaXcT
	 Q5H+k2eimvg5N4DOYqWoavJ8hWk5Gyx02kQjmWtPNS7mGWz0mPlYjMlG1m/O2HOket
	 vqfVNujOBhDOSQPG46hI3O0OxA+MemnTLYR1PMhbJPj2NfwRzQ2Gtr41B0bBKTqofK
	 eHsHzwNqEK+pIQwjxrwtnQsYBDxq2A2eU23L+0W/+sqf7Lzu/fZkoFsuCPxnuiNc3U
	 ipmHkoy0yb2jLfvuCUmq6FgS737TrGGrWriBsmdmd1R52J2LUd9/vRnyT7+/VY2Klj
	 ke1I8rHIl77/Q==
Date: Mon, 6 Oct 2025 14:23:06 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 05/12] fuse2fs: free global_fs after a failed
 ext2fs_close call
Message-ID: <20251006212306.GK8084@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
 <175797569709.245695.7389555784743357.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175797569709.245695.7389555784743357.stgit@frogsfrogsfrogs>

On Mon, Sep 15, 2025 at 03:39:01PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> If ext2fs_close fails for any reason, it won't free the ext2_filsys
> object or any of the other things that hang off of it, like the io
> managers and whatnot.  Right now this results in a memory leak of
> global_fs, which is mostly benign because we're nearly to the end of
> main() anyway.
> 
> However, a future patch will move the ext2fs_close call to op_destroy
> prior to introducing fuseblk support, which means that we won't close
> the (O_EXCL) block device before returning from umount, which will cause
> problems with fstests and the user expectation that block devices are
> closed when umount(8) returns.
> 
> Therefore, free the context after a failed close.
> 
> Cc: <linux-ext4@vger.kernel.org> # v1.43.7
> Fixes: 6ae16a6814f47c ("misc: clean up error handling for ext2fs_run_ext3_journal()")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  misc/fuse2fs.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 4d92e1e818b1c4..08470a99dc7b4d 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4905,8 +4905,10 @@ int main(int argc, char *argv[])
>  	}
>  	if (global_fs) {
>  		err = ext2fs_close(global_fs);

Heh, this could have been ext2fs_close_free(&global_fs).  Will resubmit.

--D

> -		if (err)
> +		if (err) {
>  			com_err(argv[0], err, "while closing fs");
> +			ext2fs_free(global_fs);
> +		}
>  		global_fs = NULL;
>  	}
>  	if (fctx.lockfile) {
> 
> 

