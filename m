Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4721B41DECC
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Sep 2021 18:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350093AbhI3QXT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 12:23:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44630 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350072AbhI3QXT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 12:23:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BEE7021AC1;
        Thu, 30 Sep 2021 16:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633018895; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFPwd309wb72bOIcAzCmQZn2zLy+zYKHQPu1UkTz3Ew=;
        b=vRlMEYTie6IYyt5Yvda8e9TwjLAr3EmphcuFt81iOgJTa0oW+2uuAv0OSMO9mxLsXzqoPi
        SWpH3c6kpTH/5+BCYEFTbmOHbAIqIhjLlXTYBKkXiVY34eN06UtjZ4/QTJysCQ0k9EF9qW
        PrCT9h70Tdb0jWREo1HGcsPRx80FnKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633018895;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFPwd309wb72bOIcAzCmQZn2zLy+zYKHQPu1UkTz3Ew=;
        b=K6Zs8xemcJiaoxwSMVCjObrOtrXKI7sfGWSqGjuOwtFjz6Aw5W+VB84aC8x1AOd5LJrgfv
        pTi595Fv6rd+3IDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ABE5BA3B83;
        Thu, 30 Sep 2021 16:21:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7EAFF1F2BA4; Thu, 30 Sep 2021 18:21:35 +0200 (CEST)
Date:   Thu, 30 Sep 2021 18:21:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 2/3] ext4: ensure enough credits in
 ext4_ext_shift_path_extents
Message-ID: <20210930162135.GB17404@quack2.suse.cz>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
 <20210903062748.4118886-3-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903062748.4118886-3-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-09-21 14:27:47, yangerkun wrote:
> Like ext4_ext_rm_leaf, we can ensure enough credits before every call
> that will consume credits. This can remove ext4_access_path which only
> used in ext4_ext_shift_path_extents. It's a prepare patch for the next
> bugfix patch.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 49 +++++++++++++++--------------------------------
>  1 file changed, 15 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7ae32078b48f..a6fb0350f062 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4974,36 +4974,6 @@ int ext4_get_es_cache(struct inode *inode, struct fiemap_extent_info *fieinfo,
>  	return ext4_fill_es_cache_info(inode, start_blk, len_blks, fieinfo);
>  }
>  
> -/*
> - * ext4_access_path:
> - * Function to access the path buffer for marking it dirty.
> - * It also checks if there are sufficient credits left in the journal handle
> - * to update path.
> - */
> -static int
> -ext4_access_path(handle_t *handle, struct inode *inode,
> -		struct ext4_ext_path *path)
> -{
> -	int credits, err;
> -
> -	if (!ext4_handle_valid(handle))
> -		return 0;
> -
> -	/*
> -	 * Check if need to extend journal credits
> -	 * 3 for leaf, sb, and inode plus 2 (bmap and group
> -	 * descriptor) for each block group; assume two block
> -	 * groups
> -	 */
> -	credits = ext4_writepage_trans_blocks(inode);
> -	err = ext4_datasem_ensure_credits(handle, inode, 7, credits, 0);
> -	if (err < 0)
> -		return err;
> -
> -	err = ext4_ext_get_access(handle, inode, path);
> -	return err;
> -}
> -
>  /*
>   * ext4_ext_shift_path_extents:
>   * Shift the extents of a path structure lying between path[depth].p_ext
> @@ -5018,6 +4988,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  	int depth, err = 0;
>  	struct ext4_extent *ex_start, *ex_last;
>  	bool update = false;
> +	int credits, restart_credits;
>  	depth = path->p_depth;
>  
>  	while (depth >= 0) {
> @@ -5027,13 +4998,23 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  				return -EFSCORRUPTED;
>  
>  			ex_last = EXT_LAST_EXTENT(path[depth].p_hdr);
> +			/* leaf + sb + inode */
> +			credits = 3;
> +			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr)) {
> +				update = true;
> +				/* extent tree + sb + inode */
> +				credits = depth + 2;
> +			}
>  
> -			err = ext4_access_path(handle, inode, path + depth);
> +			restart_credits = ext4_writepage_trans_blocks(inode);
> +			err = ext4_datasem_ensure_credits(handle, inode, credits,
> +					restart_credits, 0);
>  			if (err)
>  				goto out;
>  
> -			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr))
> -				update = true;
> +			err = ext4_ext_get_access(handle, inode, path + depth);
> +			if (err)
> +				goto out;
>  
>  			while (ex_start <= ex_last) {
>  				if (SHIFT == SHIFT_LEFT) {
> @@ -5064,7 +5045,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  		}
>  
>  		/* Update index too */
> -		err = ext4_access_path(handle, inode, path + depth);
> +		err = ext4_ext_get_access(handle, inode, path + depth);
>  		if (err)
>  			goto out;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
