Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F112A9BEF
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Nov 2020 19:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgKFSXB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 13:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:42416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgKFSXB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 6 Nov 2020 13:23:01 -0500
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8E5208FE;
        Fri,  6 Nov 2020 18:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604686980;
        bh=+Ts7gJxIlSSxSAGj04VSLAnxs4apD4F9ITw6jQ22PEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0NX2TlHxflTVmPTo23eodQqGodMTxkJunZcQACwq0IMOpi0gAK7EDM2dae732zpuK
         5ZIR5rEcWwkExgp4j9QnnDKVxObPrswAdR9Xz4V7lmCZT8wZjWVe9yelUmdVxOViFF
         e6hBgS3IYsm8hPWyrhBJhqIJJmnD8imQGIM/9Oow=
Date:   Fri, 6 Nov 2020 10:22:58 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH 05/11] e2fsck: Fix entries with invalid encoded characters
Message-ID: <20201106182258.GB79496@sol.localdomain>
References: <20201105161642.87488-1-arnaud.ferraris@collabora.com>
 <20201105161642.87488-6-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105161642.87488-6-arnaud.ferraris@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 05, 2020 at 05:16:37PM +0100, Arnaud Ferraris wrote:
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 8eecd958..968734e8 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c

Theres a comment at the top of this file that could be updated to mention
inode_casefold_map.

> +static int encoded_check_name(e2fsck_t ctx,
> +			      struct ext2_dir_entry *dirent,
> +			      struct problem_context *pctx)
> +{
> +	const struct ext2fs_nls_table *tbl = ctx->fs->encoding;
> +	int ret;
> +	int len = ext2fs_dirent_name_len(dirent);
> +	char *pos, *end;
> +
> +	ret = ext2fs_check_encoded_name(tbl, dirent->name, len, &pos);
> +	if (ret < 0) {
> +		fatal_error(ctx, _("NLS is broken."));
> +	} else if(ret > 0) {
> +		ret = fix_problem(ctx, PR_2_BAD_NAME, pctx);
> +		if (ret) {
> +			end = &dirent->name[len];
> +			for (; *pos && pos != end; pos++)
> +				*pos = '.';
> +		}
> +	}
> +
> +	return (ret || check_name(ctx, dirent, pctx));
> +}

Maybe this should use a new problem code instead of reusing PR_2_BAD_NAME?

> @@ -998,11 +1028,18 @@ static int check_dir_block(ext2_filsys fs,
>  	size_t	max_block_size;
>  	int	hash_flags = 0;
>  	static char *eop_read_dirblock = NULL;
> +	int cf_dir = 0;
>  
>  	cd = (struct check_dir_struct *) priv_data;
>  	ibuf = buf = cd->buf;
>  	ctx = cd->ctx;
>  
> +	/* We only want filename encoding verification on strict
> +	 * mode. */
> +	if (ext2fs_test_inode_bitmap2(ctx->inode_casefold_map, ino) &&
> +	    (ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL))
> +		cf_dir = 1;
> +
>  	if (ctx->flags & E2F_FLAG_RUN_RETURN)
>  		return DIRENT_ABORT;
>  
> @@ -1483,7 +1520,11 @@ skip_checksum:
>  		if (check_filetype(ctx, dirent, ino, &cd->pctx))
>  			dir_modified++;
>  
> -		if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
> +		if (cf_dir) {
> +			/* casefolded directory */
> +			if (encoded_check_name(ctx, dirent, &cd->pctx))
> +				dir_modified++;
> +		} else if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
>  			/* Unencrypted directory */
>  			if (check_name(ctx, dirent, &cd->pctx))
>  				dir_modified++;

It might be a good idea to rearrange this logic to be ready for directories that
are both encrypted and casefolded, where checking the encoded names won't be
possible:

	if (dir_encpolicy_id != NO_ENCRYPTION_POLICY) {
		/* handle encrypted dir */
	} else if (cf_dir) {
		/* handle casefolded dir */
	} else {
		/* handle regular dir */
	}
