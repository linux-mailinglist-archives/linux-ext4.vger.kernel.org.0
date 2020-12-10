Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA7E2D6925
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 21:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392238AbgLJUwP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 15:52:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52440 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390239AbgLJUwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 15:52:15 -0500
Received: from localhost (unknown [IPv6:2804:14c:132:242d::1000])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 727D91F45C5C;
        Thu, 10 Dec 2020 20:51:32 +0000 (GMT)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     linux-ext4@vger.kernel.org, drosen@google.com, ebiggers@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH RESEND v2 06/12] e2fsck: Fix entries with invalid
 encoded characters
Organization: Collabora
References: <20201210150353.91843-1-arnaud.ferraris@collabora.com>
        <20201210150353.91843-7-arnaud.ferraris@collabora.com>
Date:   Thu, 10 Dec 2020 17:51:26 -0300
In-Reply-To: <20201210150353.91843-7-arnaud.ferraris@collabora.com> (Arnaud
        Ferraris's message of "Thu, 10 Dec 2020 16:03:47 +0100")
Message-ID: <87360d2xm9.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Arnaud Ferraris <arnaud.ferraris@collabora.com> writes:

> From: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> On strict mode, invalid Unicode sequences are not permited.  This patch
> adds a verification step to pass2 to detect and modify the entries with
> the same replacement char used for non-encoding directories '.'.
>
> After the encoding test, we still want to check the name for usual
> problems, '\0', '/' in the middle of the sequence.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
> ---
> Changes in v2:
>   - added missing comment
>   - uses the problem code introduced by the previous patch
>   - reworked a test to ease future support of encrypted+casefolded
>     directories
>
>  e2fsck/e2fsck.c |  4 ++++
>  e2fsck/e2fsck.h |  1 +
>  e2fsck/pass1.c  | 18 +++++++++++++++++
>  e2fsck/pass2.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++-----
>  4 files changed, 69 insertions(+), 5 deletions(-)
>
> diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
> index d8be566f..dc4b45e2 100644
> --- a/e2fsck/e2fsck.c
> +++ b/e2fsck/e2fsck.c
> @@ -75,6 +75,10 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
>  		ext2fs_free_block_bitmap(ctx->block_found_map);
>  		ctx->block_found_map = 0;
>  	}
> +	if (ctx->inode_casefold_map) {
> +		ext2fs_free_block_bitmap(ctx->inode_casefold_map);
> +		ctx->inode_casefold_map = 0;
> +	}
>  	if (ctx->inode_link_info) {
>  		ext2fs_free_icount(ctx->inode_link_info);
>  		ctx->inode_link_info = 0;
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 85f953b2..dcaab0a1 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -262,6 +262,7 @@ struct e2fsck_struct {
>  	ext2fs_inode_bitmap inode_bb_map; /* Inodes which are in bad blocks */
>  	ext2fs_inode_bitmap inode_imagic_map; /* AFS inodes */
>  	ext2fs_inode_bitmap inode_reg_map; /* Inodes which are regular files*/
> +	ext2fs_inode_bitmap inode_casefold_map; /* Inodes which are casefolded */
>  
>  	ext2fs_block_bitmap block_found_map; /* Blocks which are in use */
>  	ext2fs_block_bitmap block_dup_map; /* Blks referenced more than once */
> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 8eecd958..6909fed5 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -23,6 +23,7 @@
>   * 	- A bitmap of which inodes have bad fields.	(inode_bad_map)
>   * 	- A bitmap of which inodes are in bad blocks.	(inode_bb_map)
>   * 	- A bitmap of which inodes are imagic inodes.	(inode_imagic_map)
> + * 	- A bitmap of which inodes are casefolded.	(inode_casefold_map)
>   * 	- A bitmap of which blocks are in use.		(block_found_map)
>   * 	- A bitmap of which blocks are in use by two inodes	(block_dup_map)
>   * 	- The data blocks of the directory inodes.	(dir_map)
> @@ -1260,6 +1261,20 @@ void e2fsck_pass1(e2fsck_t ctx)
>  		ctx->flags |= E2F_FLAG_ABORT;
>  		return;
>  	}
> +	if (casefold_fs) {
> +		pctx.errcode =
> +			e2fsck_allocate_inode_bitmap(fs,
> +						     _("inode casefold map"),
> +						     EXT2FS_BMAP64_RBTREE,
> +						     "inode_casefold_map",
> +						     &ctx->inode_casefold_map);
> +		if (pctx.errcode) {
> +			pctx.num = 1;
> +			fix_problem(ctx, PR_1_ALLOCATE_IBITMAP_ERROR, &pctx);
> +			ctx->flags |= E2F_FLAG_ABORT;
> +			return;
> +		}
> +	}
>  	pctx.errcode = e2fsck_setup_icount(ctx, "inode_link_info", 0, NULL,
>  					   &ctx->inode_link_info);
>  	if (pctx.errcode) {
> @@ -1870,6 +1885,9 @@ void e2fsck_pass1(e2fsck_t ctx)
>  		    add_encrypted_file(ctx, &pctx) < 0)
>  			goto clear_inode;
>  
> +		if (casefold_fs && inode->i_flags & EXT4_CASEFOLD_FL)
> +			ext2fs_mark_inode_bitmap2(ctx->inode_casefold_map, ino);
> +
>  		if (LINUX_S_ISDIR(inode->i_mode)) {
>  			ext2fs_mark_inode_bitmap2(ctx->inode_dir_map, ino);
>  			e2fsck_add_dir_info(ctx, ino, 0);
> diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
> index 4dbc44ea..b9402b24 100644
> --- a/e2fsck/pass2.c
> +++ b/e2fsck/pass2.c
> @@ -36,11 +36,13 @@
>   * 	- The inode_bad_map bitmap
>   * 	- The inode_dir_map bitmap
>   * 	- The encrypted_file_info
> + *	- The inode_casefold_map bitmap
>   *
>   * Pass 2 frees the following data structures
>   * 	- The inode_bad_map bitmap
>   * 	- The inode_reg_map bitmap
>   * 	- The encrypted_file_info
> + *	- The inode_casefold_map bitmap
>   */
>  
>  #define _GNU_SOURCE 1 /* get strnlen() */
> @@ -287,6 +289,10 @@ void e2fsck_pass2(e2fsck_t ctx)
>  		ext2fs_free_inode_bitmap(ctx->inode_reg_map);
>  		ctx->inode_reg_map = 0;
>  	}
> +	if (ctx->inode_casefold_map) {
> +		ext2fs_free_inode_bitmap(ctx->inode_casefold_map);
> +		ctx->inode_casefold_map = 0;
> +	}
>  	destroy_encrypted_file_info(ctx);
>  
>  	clear_problem_context(&pctx);
> @@ -515,6 +521,30 @@ static int encrypted_check_name(e2fsck_t ctx,
>  	return 0;
>  }
>  
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
> +		ret = fix_problem(ctx, PR_2_BAD_CASEFOLDED_NAME, pctx);
> +		if (ret) {
> +			end = &dirent->name[len];
> +			for (; *pos && pos != end; pos++)
> +				*pos = '.';
> +		}
> +	}
> +
> +	return (ret || check_name(ctx, dirent, pctx));
> +}
> +
>  /*
>   * Check the directory filetype (if present)
>   */
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
> @@ -1483,11 +1520,7 @@ skip_checksum:
>  		if (check_filetype(ctx, dirent, ino, &cd->pctx))
>  			dir_modified++;
>  
> -		if (dir_encpolicy_id == NO_ENCRYPTION_POLICY) {
> -			/* Unencrypted directory */
> -			if (check_name(ctx, dirent, &cd->pctx))
> -				dir_modified++;
> -		} else {
> +		if (dir_encpolicy_id != NO_ENCRYPTION_POLICY) {
>  			/* Encrypted directory */
>  			if (dot_state > 1 &&
>  			    check_encrypted_dirent(ctx, dirent,
> @@ -1497,6 +1530,14 @@ skip_checksum:
>  				dir_modified++;
>  				goto next;
>  			}
> +		} else if (cf_dir) {
> +			/* Casefolded directory */
> +			if (encoded_check_name(ctx, dirent, &cd->pctx))
> +				dir_modified++;
> +		} else {
> +			/* Unencrypted and uncasefolded directory */
> +			if (check_name(ctx, dirent, &cd->pctx))
> +				dir_modified++;
>  		}

This won't do for encrypted+casefolded directories, right?

>  
>  		if (dx_db) {

-- 
Gabriel Krisman Bertazi
