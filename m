Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9FF218968
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jul 2020 15:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgGHNos (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jul 2020 09:44:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729288AbgGHNos (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Jul 2020 09:44:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC0F8AD25;
        Wed,  8 Jul 2020 13:44:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 17A531E12BF; Wed,  8 Jul 2020 15:44:46 +0200 (CEST)
Date:   Wed, 8 Jul 2020 15:44:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix spelling mistakes in extents.c
Message-ID: <20200708134446.GA5288@quack2.suse.cz>
References: <20200611031947.165079-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611031947.165079-1-iamkeyur96@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 10-06-20 23:19:46, Keyur Patel wrote:
> Fix spelling issues over the comments in the code.
> 
> requsted ==> requested
> deterimined ==> determined
> insde ==> inside
> neet ==> need
> somthing ==> something
> 
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

Thanks. The fixes look good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Ted, I think this patch has fallen through the cracks...

								Honza
> ---
>  fs/ext4/extents.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7d088ff1e902..8028e1aae8de 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -1915,7 +1915,7 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
>  
>  /*
>   * ext4_ext_insert_extent:
> - * tries to merge requsted extent into the existing extent or
> + * tries to merge requested extent into the existing extent or
>   * inserts requested extent as new one into the tree,
>   * creating new leaf in the no-space case.
>   */
> @@ -3125,7 +3125,7 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
>   *
>   *
>   * Splits extent [a, b] into two extents [a, @split) and [@split, b], states
> - * of which are deterimined by split_flag.
> + * of which are determined by split_flag.
>   *
>   * There are two cases:
>   *  a> the extent are splitted into two extent.
> @@ -3650,7 +3650,7 @@ static int ext4_split_convert_extents(handle_t *handle,
>  		eof_block = map->m_lblk + map->m_len;
>  	/*
>  	 * It is safe to convert extent to initialized via explicit
> -	 * zeroout only if extent is fully insde i_size or new_size.
> +	 * zeroout only if extent is fully inside i_size or new_size.
>  	 */
>  	depth = ext_depth(inode);
>  	ex = path[depth].p_ext;
> @@ -4495,7 +4495,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
>  	}
>  
>  	/*
> -	 * Round up offset. This is not fallocate, we neet to zero out
> +	 * Round up offset. This is not fallocate, we need to zero out
>  	 * blocks, so convert interior block aligned part of the range to
>  	 * unwritten and possibly manually zero out unaligned parts of the
>  	 * range.
> @@ -5579,7 +5579,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		}
>  		ex1 = path1[path1->p_depth].p_ext;
>  		ex2 = path2[path2->p_depth].p_ext;
> -		/* Do we have somthing to swap ? */
> +		/* Do we have something to swap ? */
>  		if (unlikely(!ex2 || !ex1))
>  			goto finish;
>  
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
