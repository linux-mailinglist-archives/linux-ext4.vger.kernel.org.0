Return-Path: <linux-ext4+bounces-8401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2563EAD7E46
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Jun 2025 00:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C82E3B5183
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA122424C;
	Thu, 12 Jun 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W++ZIELK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCDC522F
	for <linux-ext4@vger.kernel.org>; Thu, 12 Jun 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749766553; cv=none; b=SkFTgkmt0uevFqWAAco4ACKZgTuPSNbduvHIKQ9yh8GpWfRfQEa0geru9/cUb1JLAHo6UuH8zydpB1jNirC9ShAncuzA/O8I+A9yyAzlCbyuNGj1aCYV+EBn1y7H9ptWVP4qAbJ4jHVw6M0KT0plS1csEV4KMaj3AucJUOyhtx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749766553; c=relaxed/simple;
	bh=FXDAyyS+N8zKhSbe8lthRnZnP9gbxpzLqKtfkTDwWKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgpQx6XEfUTRtB1BtzkTD0KlNQi1lqDPDny1cgnb6F0FUfqr3eKvn3K5wCdrOujlEUnk/c+gdz7bmjLRjh39+QhiY3H8gqmJktlk1Lumqe/T+j+16GBjzwPw/3iKMye3kWavG9fDBG3fx7jcVP8LCJy7Lnc7gbezC3iBHwp//eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W++ZIELK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C22C4CEEA;
	Thu, 12 Jun 2025 22:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749766553;
	bh=FXDAyyS+N8zKhSbe8lthRnZnP9gbxpzLqKtfkTDwWKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W++ZIELKdL2bFohwbIn34EyrPLan6iaybF5Mkz/v9GP0PMLW6Ln59WT99njo+WC1F
	 JoAafjZgQ8kCPaDnRrFswYmJ4DiAk74G6x1c1fGK7Fz/rCd1M6yqMYRHtYmbs/Bqcl
	 3iyTZOfPrWxZkJ+OomFzd13GkyhkB7+ioH6YNsgw2NGd/9ka4UW2d2zP+sfYQGwsgx
	 jUoyhzDaEcou+kA5BFHmS2FhA/44ci9i3u0PoBAWDvQrDQe12pows1Bum+ez4EwLPj
	 /CwsuhOh5GadUKxQH/zjfXWUOpuTyYUDlV1bX8Nxza9QF6Tghsalzn6/PfiO+its8g
	 0VIUB5nDnslAg==
Date: Thu, 12 Jun 2025 15:15:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/3] fuse2fs: catch positive errnos coming from libext2fs
Message-ID: <20250612221552.GO6179@frogsfrogsfrogs>
References: <174966018041.3972888.391896904012834159.stgit@frogsfrogsfrogs>
 <174966018106.3972888.12154557537002504919.stgit@frogsfrogsfrogs>
 <20250612164304.GQ784455@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612164304.GQ784455@mit.edu>

On Thu, Jun 12, 2025 at 02:13:04PM -0230, Theodore Ts'o wrote:
> On Wed, Jun 11, 2025 at 09:44:17AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Something in libext2fs is returning EOVERFLOW (positive) to us.  We need
> > to pass negative errnos back to the fuse driver, so perform this
> > translation.
> 
> This isn't actually the best way to fix things.  The way the com_err
> architecture works is that errcode_t is a 32-bit unsigned integer,
> where the the top 24-bits is a subsystem identifier.  If the subsystem
> identifier is zero, then the low 8 bits is presumed to be an errno
> value.  Otherwise, the subsystem identifier is formed by taking a 4
> character identifier from 62 valid code points A-Z, a-z, 0-9, and _,
> where A is 1, and _ is 63.

I.... had no idea that errcode_t's were actually segmented numbers.  Is
there a way to figure out the subsystem from one of them?  Or will
fuse2fs just have to "know" that !(errcode & 0xFFFFFF00) means "errno"?

> Error table subsystems that are in common use and used by packages
> shipped by most Linux distributions include "krb5" and "kadm" from the
> MIT Kerberos implementation, and "ext2" and "prof" which ship as part
> of e2fsprogs.  The original design came from Multics, and the idea is
> that a library might call other libraries, and having a single unified
> error code namespace can be super-useful.  Top-level callers can check
> to see if an error is non-zero, and if so, call error_message(retval)
> and get back a human-friendly string regardless of which library might
> have originally generated the error.
> 
> CMU has a handy-dandy registry of the various libraries that use the
> common error infrastructure here[1].
> 
> [1] https://www.central.org/frameless/numbers/errors.html
> 
> In the case of the ext2fs library, it doesn't actually call any AFS,
> Kerberos, ASN.1, etc. libraries, so in practice the only valid error
> codes that we should get back are either in the range 0..255 and
> EXT2_ET_BASE..EXT2_ET_BASE+255.  But at least in theory, it's possible
> that in the future, libext2fs might call some other library that might
> return com_err error codes.
> 
> So a better, more idiomatic fix would be something like this below.
> 
>        	       		      	      	- Ted
> 
> P.S.  By the way, I'm not entirely convinced by the is_err vs !is_err
> logic.  I get the idea is that we want to not log certain error cases
> resulting from looking up a non-existing file name, but for example,
> EXT2_ET_NO_MEMORY or any of the EXT2_TDB_* error messages should never
> happen under normal circumstances, so if they do happen, they probably
> should be logged, and so perhaps is_err=1 should be set for those
> errors.  Similarly, I suspect that any MMP errors should probably also
> be logged, but we can handle that as a separate commit.

Hrm -- if MMP fails, that implies that we might not be the owner of
this filesystem, right?  Doesn't that means we should be careful about
not scribbling on the superblock?

> commit 71f046a788adbae163c9398fccf50fff89bb9083
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Jun 12 14:03:44 2025 -0230
> 
>     fuse2fs: correctly handle system errno values in __translate_error()
>     
>     Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
>     Reported-by: "Darrick J. Wong" <djwong@kernel.org>
>     Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index bc49edfe..97b1c5b5 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -4659,9 +4659,9 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
>  	int is_err = 0;
>  
>  	/* Translate ext2 error to unix error code */
> -	if (err < EXT2_ET_BASE)
> -		goto no_translation;
>  	switch (err) {
> +	case 0:
> +		break;
>  	case EXT2_ET_NO_MEMORY:
>  	case EXT2_ET_TDB_ERR_OOM:
>  		ret = -ENOMEM;
> @@ -4755,11 +4755,10 @@ static int __translate_error(ext2_filsys fs, ext2_ino_t ino, errcode_t err,
>  		break;
>  	default:
>  		is_err = 1;
> -		ret = -EIO;
> +		ret = (err < 256) ? -err : -EIO;

Ok I'll rework the patch with this logic, but add a fat comment about
all this.

--D

>  		break;
>  	}
>  
> -no_translation:
>  	if (!is_err)
>  		return ret;
>  
> 

