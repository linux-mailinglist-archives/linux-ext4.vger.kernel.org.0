Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA365DAD4
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 17:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239827AbjADQ5l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 11:57:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240315AbjADQ5Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 11:57:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F4C5FF7
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 08:54:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5273617B2
        for <linux-ext4@vger.kernel.org>; Wed,  4 Jan 2023 16:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C43C433EF;
        Wed,  4 Jan 2023 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672851268;
        bh=bFyATlx/uuL6zqlY7ptVAByOpFfbSbrE13c+v8eXIRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TJVgz+BfOdml2Lu7/td6YkaP0rJIQcKm4D6urd6tf80IjFiy0w/BhVfPEaTyWSLRc
         EFfi6AdFkuqnLFwHkEHz8u8vpjoFLpq6RsBmX0lDmyXRJG6nY3wQJMLApREmCKMkGn
         iHhttlc4G6+3n5emZyP6BcIlyDtyvK6oxw5ZAPzbtyTR219W+UGGgzlnOquSUtmilc
         6bqQ6UhXuPHUAFb/1nrmncy+etNSuQvRrv3T9vigqC/BOyc4CBkS79o2dbkz3vQJqZ
         tKsevTBuj//BPSedCEGfU7QxkX5HYQEY/Dj/TclXnfoSJE8TUu+zBtDu7BYPvz183B
         UU3MOhGczkKEQ==
Date:   Wed, 4 Jan 2023 08:54:27 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [e2fsprogs PATCH] libext2fs: fix 32-bit Windows build
Message-ID: <Y7WvQ9cqOZuF0YJR@magnolia>
References: <20230104090301.275976-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104090301.275976-1-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 04, 2023 at 01:03:01AM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> _WIN32 is the standard macro to detect Windows, regardless of 32-bit or
> 64-bit.  _WIN64 is for 64-bit Windows only.  Use _WIN32 where _WIN64 was
> incorrectly being used.
> 
> This fixes several 32-bit Windows build errors, for example this one:

Color me impressed, I would have applied to deprecate Windows support
entirely, particularly given the existence of WSL.

That said ... back in the day, IIRC it was _WINDOWS that one was
supposed to check for a Windows build, and the _WIN{16,32,64} variants
existed to detect specific variants of it.  But, that was 25 years ago;
for all I know that's passé and _WIN32 is fine.

--D

> plausible.c: In function ‘print_ext2_info’:
> plausible.c:109:31: error: ‘unix_io_manager’ undeclared (first use in this function); did you mean ‘undo_io_manager’?
>   109 |                               unix_io_manager,
>       |                               ^~~~~~~~~~~~~~~
>       |                               undo_io_manager
> 
> Fixes: 86b6db9f5a43 ("libext2fs: code adaptation to use the Windows IO manager")
> Cc: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/ext2fs/getsectsize.c | 12 ++++++------
>  lib/support/plausible.c  |  2 +-
>  util/subst.c             |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/ext2fs/getsectsize.c b/lib/ext2fs/getsectsize.c
> index 3a461eb9..bd978c53 100644
> --- a/lib/ext2fs/getsectsize.c
> +++ b/lib/ext2fs/getsectsize.c
> @@ -51,10 +51,10 @@
>   */
>  errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
>  {
> -#ifdef _WIN64
> +#ifdef _WIN32
>  	*sectsize = 512; // just guessing
>  	return 0;
> -#else // not _WIN64
> +#else // not _WIN32
>  
>  	int	fd;
>  
> @@ -78,7 +78,7 @@ errcode_t ext2fs_get_device_sectsize(const char *file, int *sectsize)
>  	close(fd);
>  	return 0;
>  
> -#endif // ifdef _WIN64
> +#endif // ifdef _WIN32
>  }
>  
>  /*
> @@ -117,11 +117,11 @@ int ext2fs_get_dio_alignment(int fd)
>   */
>  errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
>  {
> -#ifdef _WIN64
> +#ifdef _WIN32
>  
>  	return ext2fs_get_device_sectsize(file, sectsize);
>  
> -#else // not _WIN64
> +#else // not _WIN32
>  
>  	int	fd;
>  
> @@ -147,5 +147,5 @@ errcode_t ext2fs_get_device_phys_sectsize(const char *file, int *sectsize)
>  	close(fd);
>  	return 0;
>  
> -#endif // ifdef _WIN64
> +#endif // ifdef _WIN32
>  }
> diff --git a/lib/support/plausible.c b/lib/support/plausible.c
> index bbed2a70..349aa2c4 100644
> --- a/lib/support/plausible.c
> +++ b/lib/support/plausible.c
> @@ -103,7 +103,7 @@ static void print_ext2_info(const char *device)
>  	time_t			tm;
>  
>  	retval = ext2fs_open2(device, 0, EXT2_FLAG_64BITS, 0, 0,
> -#ifdef _WIN64
> +#ifdef _WIN32
>  			      windows_io_manager,
>  #else
>  			      unix_io_manager,
> diff --git a/util/subst.c b/util/subst.c
> index c0eda5cf..be2a0dda 100644
> --- a/util/subst.c
> +++ b/util/subst.c
> @@ -434,7 +434,7 @@ int main(int argc, char **argv)
>  					printf("Using original atime\n");
>  				set_utimes(outfn, fileno(old), tv);
>  			}
> -#ifndef _WIN64
> +#ifndef _WIN32
>  			if (ofd >= 0)
>  				(void) fchmod(ofd, 0444);
>  #endif
> @@ -444,7 +444,7 @@ int main(int argc, char **argv)
>  		} else {
>  			if (verbose)
>  				printf("Creating or replacing %s.\n", outfn);
> -#ifndef _WIN64
> +#ifndef _WIN32
>  			if (ofd >= 0)
>  				(void) fchmod(ofd, 0444);
>  #endif
> -- 
> 2.39.0
> 
