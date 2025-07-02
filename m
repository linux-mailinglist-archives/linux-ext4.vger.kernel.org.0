Return-Path: <linux-ext4+bounces-8776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA7FAF5C86
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 17:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D246B1C4524F
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 15:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70030B988;
	Wed,  2 Jul 2025 15:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG+d+jOr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2A2D3A7E
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469334; cv=none; b=Ia0TaQaRWZMmjrVsYy83q4SwlTXULdjpFz1nkvwW61f9miE2DeGBPiExEKp5QldeYzb7ncHi/dI49O/WLJxYcNDY16LCzY2RyI0cBuDfyTkWCNR1TylhOqmRpc/4h560mdOe/IsH5P0NlmZbrFIkHTGBUTLpWGHASO+Q8kAAdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469334; c=relaxed/simple;
	bh=Ft/U6bU0KIRZGLvAYYabJ4dJS2y28dnWjL2rB3Sj+0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCFdRr3IkeIFoWCCT3ww3U+EfJHCes8z+c29cIq3y64xcQutd2Ukd9y2/lTFJIPtamAo0VoT/d/OH4837EnXUuUQqdvXkEOLOS+pLXZMTG5kcpdGF3Xj3CUbvoExkFKF/es3OIE+TqmIg8LhQI2JzZGYumxY3N4yrKdhHzF+2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG+d+jOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587BC4CEE7;
	Wed,  2 Jul 2025 15:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751469333;
	bh=Ft/U6bU0KIRZGLvAYYabJ4dJS2y28dnWjL2rB3Sj+0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jG+d+jOrc/Mzj/oCdZ/MP7pl92bcTfpMiq4OOdqZDfDTg8FhrwtSRogRUxH02eH4H
	 l0jzhZK7L0AhPjZd7S7qzzVqdyezRO+MzxQ/SjG6+iWRny4X6KAhc+C45HMpAls5xL
	 eHEJL9r7uxwM6Z0XVzLPWE+AKYlXlyfW64rvKyAtEYomJZMY2IUkoPvqaYzvaRUqIJ
	 6uvmVqrUGx0rc1BEcl6i58D/jby+EW4dXDSirKXZWprkRhArds/lPEiWLMQclr3B9G
	 fASANtqmdpvIftjKr/DrVhLSqCDKZypOUEi+bg1+rBBwNayFQU3Y+3eie5FoUtmHTJ
	 7TlgKXCrOK41Q==
Date: Wed, 2 Jul 2025 08:15:33 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 1/2] fuse2fs: fix normal (non-kernel) permissions checking
Message-ID: <20250702151533.GJ9987@frogsfrogsfrogs>
References: <20250702035044.47373-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702035044.47373-1-tytso@mit.edu>

On Tue, Jul 01, 2025 at 11:50:43PM -0400, Theodore Ts'o wrote:
> Commit 9f69dfc4e275 ("fuse2fs: implement O_APPEND correctly") defined
> a new flag, A_OK, to add support for testing whether the file is valid
> for append operations.  This is relevant for the check_iflags_access()
> function, but when are later testing operations mask against the inode
> permissions, this new flag gets in the way and causes non-root users
> attempting to create new inodes in a directory to fail.  Fix this by
> masking off A_OK before doing these tests.
> 
> Fixes: 9f69dfc4e275 ("fuse2fs: implement O_APPEND correctly")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks correct to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  misc/fuse2fs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index bb75d9421..d209bc790 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -687,6 +687,9 @@ static int check_inum_access(struct fuse2fs *ff, ext2_ino_t ino, int mask)
>  		return -EACCES;
>  	}
>  
> +	/* Remove the O_APPEND flag before testing permissions */
> +	mask &= ~A_OK;
> +
>  	/* allow owner, if perms match */
>  	if (inode_uid(inode) == ctxt->uid) {
>  		if ((mask & (perms >> 6)) == mask)
> -- 
> 2.47.2
> 
> 

