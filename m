Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F34240DC18
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhIPOCM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 10:02:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43084 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235536AbhIPOCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 10:02:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6432B223D1;
        Thu, 16 Sep 2021 14:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631800850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIJLlufKVyjdYEfqx/HCbz9i/DCGShNqv5yny221QFc=;
        b=eEqfmxWEZ5htxQkRoY7AQPjWaNdnIDiLFT/xIvKn/MaKhuixgyyqU5FIDwP5/+s0gDoqJW
        SNFAirWWKef7+QDXyQM6YYeCJ3RC6mpo1h+2pnuFBR02S5Una51nN1zls+olZ1Y07xJz2Q
        B+QUhIIubw6yj2ED91BNfA0lKAwUQQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631800850;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIJLlufKVyjdYEfqx/HCbz9i/DCGShNqv5yny221QFc=;
        b=Pe9sx9/9uGLmjSCYZABFdzaxberI/l6+pyXicOX/+xd7Xis0ewhO+gL0zVQQ4z9EgkzkOh
        YOk1bWuBQMCZ20Dg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 3A503A3B90;
        Thu, 16 Sep 2021 14:00:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 02DFA1E0C06; Thu, 16 Sep 2021 16:00:47 +0200 (CEST)
Date:   Thu, 16 Sep 2021 16:00:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: update last_pos for the case ext4_htree_fill_tree
 return fail
Message-ID: <20210916140046.GH10610@quack2.suse.cz>
References: <20210914111415.3921954-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914111415.3921954-1-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-09-21 19:14:15, yangerkun wrote:
> Or the ls for ext4 dir can run into a deadloop since info->last_pos !=
> ctx->pos which will reset the world and start read the entry which has
> already got before. Details see below:
> 
> 1. a dx_dir which has 3 block, block 0 as dx_root block, block 1/2 as
>    leaf block which own the ext4_dir_entry_2
> 2. block 1 read ok and call_filldir which will fill the dirent and update
>    the ctx->pos
> 3. block 2 read fail, but we has already fill some dirent, so we will
>    return back to userspace will a positive return val(see ksys_getdents64)
> 4. the second ext4_dx_readdir will reset the world since info->last_pos
>    != ctx->pos, and will also init the curr_hash which pos to block 1
> 5. So we will read block1 too, and once block2 still read fail, we can
>    only fill one dirent because the hash of the entry in block1(besides
>    the last one) won't greater than curr_hash
> 6. this time, we forget update last_pos too since the read for block2
>    will fail, and since we has got the one entry, ksys_getdents64 can
>    return success
> 7. Latter we will trapped in a loop with step 4~6
> 
> Fix it by update last_pos too once ext4_htree_fill_tree return fail.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/dir.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index ffb295aa891c..74b172a4adda 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -551,7 +551,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
>  	struct dir_private_info *info = file->private_data;
>  	struct inode *inode = file_inode(file);
>  	struct fname *fname;
> -	int	ret;
> +	int ret = 0;
>  
>  	if (!info) {
>  		info = ext4_htree_create_dir_info(file, ctx->pos);
> @@ -599,7 +599,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
>  						   info->curr_minor_hash,
>  						   &info->next_hash);
>  			if (ret < 0)
> -				return ret;
> +				goto finished;
>  			if (ret == 0) {
>  				ctx->pos = ext4_get_htree_eof(file);
>  				break;
> @@ -630,7 +630,7 @@ static int ext4_dx_readdir(struct file *file, struct dir_context *ctx)
>  	}
>  finished:
>  	info->last_pos = ctx->pos;
> -	return 0;
> +	return ret < 0 ? ret : 0;
>  }
>  
>  static int ext4_release_dir(struct inode *inode, struct file *filp)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
