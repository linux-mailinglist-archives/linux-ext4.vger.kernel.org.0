Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063AC309FC5
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Feb 2021 01:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhBAAtI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 31 Jan 2021 19:49:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBAAtD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 31 Jan 2021 19:49:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF70364E09;
        Mon,  1 Feb 2021 00:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612140503;
        bh=UiySlPbagcPbnKf+65+enUICXrYYE5z7ajBqABAZRtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNQVvgNEo5AHuTHkyqKFg+huyKQuigJnpXOdaRG4xPPQu6vDXVJIPRTj1gra2y9HZ
         qg/NWHLb1oihyk4/upE97ogHLcgonrB6qh4eOiAW1jeEHx0L7VAUwqUstWsXYFtDB4
         uMJu51X+2HU98kpgLtRNr61buysRRWEHwSGQnkd5hVVJ1ZlNkQdPZZRvtt0VF1gjTx
         6NSU8Y4wxMKTUwdA4TkI55BsIM+59k6hXpQyfEzaMOYF1S+WjOOU5s2AYteVPrdqD4
         p3bLZMpmrXB7KneRhX2FEAJvWIHw+1Gllm79XVsMsrh1OcPQ3j4ZLZ9Ekf0fIPp1o1
         V1G2UhZcI7mgg==
Date:   Sun, 31 Jan 2021 17:48:20 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vinicius Tinti <viniciustinti@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] ext4: Enable code path when DX_DEBUG is set
Message-ID: <20210201004820.GA26230@localhost>
References: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
 <20210201003125.90257-1-viniciustinti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201003125.90257-1-viniciustinti@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 01, 2021 at 12:31:25AM +0000, Vinicius Tinti wrote:
> By enabling -Wunreachable-code-aggressive on Clang the following code
> paths are unreachable.
> 
> This has been present since commit ac27a0ec112a ("[PATCH] ext4: initial
> copy of files from ext3") and fs/ext3 had it present at the beginning of
> git history. It has not been changed since.
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
> 
> Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
> ---
>  fs/ext4/namei.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cf652ba3e74d..46ae6a4e4be5 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -827,20 +827,21 @@ dx_probe(struct ext4_filename *fname, struct inode *dir,
>  				p = m + 1;
>  		}
>  
> -		if (0) { // linear search cross check
> -			unsigned n = count - 1;
> -			at = entries;
> -			while (n--)
> +#ifdef DX_DEBUG
> +		// linear search cross check
> +		unsigned n = count - 1;

You are going to introduce an instance of -Wdeclaration-after-statement
here.

fs/ext4/namei.c:834:12: warning: ISO C90 forbids mixing declarations and
code [-Wdeclaration-after-statement]
                unsigned n = count - 1;
                         ^
1 warning generated.

The quick hack would be changing the

if (0) {

to

#ifdef DX_DEBUG
    if (1) {

but that seems kind of ugly.

Other options would be turning DX_DEBUG into a proper Kconfig symbol so
that IS_ENABLED could be used or maybe combine it into
CONFIG_EXT4_DEBUG.

Cheers,
Nathan
