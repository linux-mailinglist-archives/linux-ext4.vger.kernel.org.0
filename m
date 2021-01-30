Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B7C30914D
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 02:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhA3Bir (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Jan 2021 20:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhA3BgT (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 29 Jan 2021 20:36:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C366B64E02;
        Sat, 30 Jan 2021 01:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611970508;
        bh=u2XIkil74u2aEx3WMNSlpljx3WRlu9c0WuuP3VNRoo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYVkzUOBUMMdSvmnuXaDPxuz04E6mlSLxXqsoLKupDhOaDnfNUvHWhl4S64mIRsUo
         G0P4z729aCOJHoFwErlnJxoBrVtDkd/keoU8lHc2F0+V7SteYprTRp0y0afYaSijP3
         hB6U6DKQMZhLElXCcyHFjYWiXlWBDoHyoBhF6yJzu9h2qe4FQTxIrkpbfCMFsrW9Je
         Hqd+d//3Jpza76SlpNpUXltSB2D+QNoD9FBiDLDHILZJfY+YYkG49mAm+p//tqrmq1
         /9taXnJWVTrHsch/9qPqz4MIZPcTusJODjDpV1H70SQmNYRjeI0Gw6GQGzplVgZv1U
         z+yDDdPBwty5Q==
Date:   Fri, 29 Jan 2021 18:35:05 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ext4: Remove unreachable code
Message-ID: <20210130013505.GB2709570@localhost>
References: <20210129185856.158310-1-viniciustinti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129185856.158310-1-viniciustinti@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 29, 2021 at 06:58:56PM +0000, Vinicius Tinti wrote:
> By enabling -Wunreachable-code-aggressive on Clang the following code
> paths are unreachable.
> 
> Commit dd73b5d5cb67 ("ext4: convert dx_probe() to use the ERR_PTR
> convention")
> Commit ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> 
> Clang warns:
> 
> fs/ext4/namei.c:831:17: warning: code will never be executed
> [-Wunreachable-code]
>                         unsigned n = count - 1;
>                                      ^~~~~
> fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
> explicitly dead
>                 if (0) { // linear search cross check
>                     ^
>                     /* DISABLES CODE */ ( )

The commit message might be a little clearer if it were restructured a
bit, maybe something like so?

By enabling -Wunreachable-code-aggressive on Clang, the following code
paths are unreachable:

fs/ext4/namei.c:831:17: warning: code will never be executed
[-Wunreachable-code]
                        unsigned n = count - 1;
                                     ^~~~~
fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark code as
explicitly dead
                if (0) { // linear search cross check
                    ^
                    /* DISABLES CODE */ ( )

This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
copy of files from ext3") and fs/ext3 had it present at the beginning of
git history so it is safe to remove.

> Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>

Regardless of the commit message, I believe this is the right way to get
rid of the warning:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  fs/ext4/namei.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cf652ba3e74d..1f64dbd7237b 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -827,21 +827,6 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
>  				p = m + 1;
>  		}
>  
> -		if (0) { // linear search cross check
> -			unsigned n = count - 1;
> -			at = entries;
> -			while (n--)
> -			{
> -				dxtrace(printk(KERN_CONT ","));
> -				if (dx_get_hash(++at) > hash)
> -				{
> -					at--;
> -					break;
> -				}
> -			}
> -			ASSERT(at == p - 1);
> -		}
> -
>  		at = p - 1;
>  		dxtrace(printk(KERN_CONT " %x->%u\n",
>  			       at == entries ? 0 : dx_get_hash(at),
> -- 
> 2.25.1
> 
