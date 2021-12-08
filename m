Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB0D46D8BA
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Dec 2021 17:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhLHQqP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Dec 2021 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhLHQqP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Dec 2021 11:46:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A05C061746
        for <linux-ext4@vger.kernel.org>; Wed,  8 Dec 2021 08:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 37E50CE2216
        for <linux-ext4@vger.kernel.org>; Wed,  8 Dec 2021 16:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558E6C00446;
        Wed,  8 Dec 2021 16:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638981759;
        bh=SF9V7YgUNGEl5fDFTACbT+ALmxHIHHMklkDMtn6Wzts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qrgnOKPwdPIGIU2tQDxDkE7EPsAO7pNa5gsaAMpWYz+3kaUEo/KPV8W2hqMj+5vSv
         tSkNOs69PC3ZP2diq/DHI1YpI1Es987mpzZnm1ZVxU7KhcO9R9tmNxbxira61DhlwU
         ibs4Ct3PNfvJWhDC89GwTcC+9fw5I1yZygUm82DhlXw8dzPQFfmRLRzpWUkCiQtPXn
         3UIf3Tr8zv9gKxPgdzhp/lLMCeSsckUkQru8eaoLDTlfTJOSHAyaOdyUxtq7ZmB3Do
         AFKjUfJZ0gGthjPXhes0/sycm5ZaGCZSJaJZg6LBcrsE0rBeuZdLCehhBEMKnQuTtq
         LMHrFINSqvH7g==
Date:   Wed, 8 Dec 2021 08:42:38 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2fsck: map PROMPT_* values to prompt messages
Message-ID: <20211208164238.GA69182@magnolia>
References: <20211208075112.85649-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208075112.85649-1-adilger@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 08, 2021 at 12:51:12AM -0700, Andreas Dilger wrote:
> It isn't totally clear when searching the code for PROMPT_*
> constants from problem codes where these messages come from.
> Similarly, there isn't a direct mapping from the prompt string
> to the constant.
> 
> Add comments that make this mapping more clear.
> 
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> ---
>  e2fsck/problem.c | 46 +++++++++++++++++++++++-----------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/e2fsck/problem.c b/e2fsck/problem.c
> index 757b5d56..2d02468c 100644
> --- a/e2fsck/problem.c
> +++ b/e2fsck/problem.c
> @@ -50,29 +50,29 @@
>   * to fix a problem.
>   */
>  static const char *prompt[] = {
> -	N_("(no prompt)"),	/* 0 */
> -	N_("Fix"),		/* 1 */
> -	N_("Clear"),		/* 2 */
> -	N_("Relocate"),		/* 3 */
> -	N_("Allocate"),		/* 4 */
> -	N_("Expand"),		/* 5 */
> -	N_("Connect to /lost+found"), /* 6 */
> -	N_("Create"),		/* 7 */
> -	N_("Salvage"),		/* 8 */
> -	N_("Truncate"),		/* 9 */
> -	N_("Clear inode"),	/* 10 */
> -	N_("Abort"),		/* 11 */
> -	N_("Split"),		/* 12 */
> -	N_("Continue"),		/* 13 */
> -	N_("Clone multiply-claimed blocks"), /* 14 */
> -	N_("Delete file"),	/* 15 */
> -	N_("Suppress messages"),/* 16 */
> -	N_("Unlink"),		/* 17 */
> -	N_("Clear HTree index"),/* 18 */
> -	N_("Recreate"),		/* 19 */
> -	N_("Optimize"),		/* 20 */
> -	N_("Clear flag"),	/* 21 */
> -	"",			/* 22 */
> +	N_("(no prompt)"),			/* PROMPT_NONE		=  0 */

Why not make it even clearer and mismerge proof:

static const char *prompt[] = {
	[0]		= N_("(no prompt")),	/* null value test */
	[PROMPT_FIX]	= N_("Fix"),		/* 1 */
	[PROMPT_CLEAR]	= N_("Clear"),		/* 2 */
	...
};

--D

> +	N_("Fix"),				/* PROMPT_FIX		=  1 */
> +	N_("Clear"),				/* PROMPT_CLEAR		=  2 */
> +	N_("Relocate"),				/* PROMPT_RELOCATE	=  3 */
> +	N_("Allocate"),				/* PROMPT_CREATE	=  4 */
> +	N_("Expand"),				/* PROMPT_EXPAND	=  5 */
> +	N_("Connect to /lost+found"),		/* PROMPT_CONNECT	=  6 */
> +	N_("Create"),				/* PROMPT_CREATE	=  7 */
> +	N_("Salvage"),				/* PROMPT_SALVAGE	=  8 */
> +	N_("Truncate"),				/* PROMPT_TRUNCATE	=  9 */
> +	N_("Clear inode"),			/* PROMPT_CLEAR_INODE	= 10 */
> +	N_("Abort"),				/* PROMPT_ABORT		= 11 */
> +	N_("Split"),				/* PROMPT_SPLIT		= 12 */
> +	N_("Continue"),				/* PROMPT_CONTINUE	= 13 */
> +	N_("Clone multiply-claimed blocks"),	/* PROMPT_CLONE		= 14 */
> +	N_("Delete file"),			/* PROMPT_DELETE	= 15 */
> +	N_("Suppress messages"),		/* PROMPT_SUPPRESS	= 16 */
> +	N_("Unlink"),				/* PROMPT_UNLINK	= 17 */
> +	N_("Clear HTree index"),		/* PROMPT_CLEAR_HTREE	= 18 */
> +	N_("Recreate"),				/* PROMPT_RECREATE	= 19 */
> +	N_("Optimize"),				/* PROMPT_OPTIMIZE	= 20 */
> +	N_("Clear flag"),			/* PROMPT_CLEAR_FLAG	= 21 */
> +	"",					/* PROMPT_NULL		= 22 */
>  };
>  
>  /*
> -- 
> 2.25.1
> 
