Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA1A35001D
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 14:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235420AbhCaMY1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Mar 2021 08:24:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235317AbhCaMX4 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 31 Mar 2021 08:23:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E08BB1EC;
        Wed, 31 Mar 2021 12:23:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 51E421E4415; Wed, 31 Mar 2021 14:23:54 +0200 (CEST)
Date:   Wed, 31 Mar 2021 14:23:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH v2] ext4: fix check to prevent false positive report of
 incorrect used inodes
Message-ID: <20210331122354.GH30749@quack2.suse.cz>
References: <20210331121516.2243099-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331121516.2243099-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 31-03-21 20:15:16, Zhang Yi wrote:
> Commit <50122847007> ("ext4: fix check to prevent initializing reserved
> inodes") check the block group zero and prevent initializing reserved
> inodes. But in some special cases, the reserved inode may not all belong
> to the group zero, it may exist into the second group if we format
> filesystem below.
> 
>   mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
> 
> So, it will end up triggering a false positive report of a corrupted
> file system. This patch fix it by avoid check reserved inodes if no free
> inode blocks will be zeroed.
> 
> Fixes: 50122847007 ("ext4: fix check to prevent initializing reserved inodes")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v1:
>  - Splict check of used_blks and used_inos to make code more
>    comprehensible as Jan suggested.
> 
>  fs/ext4/ialloc.c | 48 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 633ae7becd61..5f0c7fe32672 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1513,6 +1513,7 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
>  	handle_t *handle;
>  	ext4_fsblk_t blk;
>  	int num, ret = 0, used_blks = 0;
> +	unsigned long used_inos = 0;
>  
>  	/* This should not happen, but just to be sure check this */
>  	if (sb_rdonly(sb)) {
> @@ -1543,22 +1544,37 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
>  	 * used inodes so we need to skip blocks with used inodes in
>  	 * inode table.
>  	 */
> -	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT)))
> -		used_blks = DIV_ROUND_UP((EXT4_INODES_PER_GROUP(sb) -
> -			    ext4_itable_unused_count(sb, gdp)),
> -			    sbi->s_inodes_per_block);
> -
> -	if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
> -	    ((group == 0) && ((EXT4_INODES_PER_GROUP(sb) -
> -			       ext4_itable_unused_count(sb, gdp)) <
> -			      EXT4_FIRST_INO(sb)))) {
> -		ext4_error(sb, "Something is wrong with group %u: "
> -			   "used itable blocks: %d; "
> -			   "itable unused count: %u",
> -			   group, used_blks,
> -			   ext4_itable_unused_count(sb, gdp));
> -		ret = 1;
> -		goto err_out;
> +	if (!(gdp->bg_flags & cpu_to_le16(EXT4_BG_INODE_UNINIT))) {
> +		used_inos = EXT4_INODES_PER_GROUP(sb) -
> +			    ext4_itable_unused_count(sb, gdp);
> +		used_blks = DIV_ROUND_UP(used_inos, sbi->s_inodes_per_block);
> +
> +		/* Bogus inode unused count? */
> +		if (used_blks < 0 || used_blks > sbi->s_itb_per_group) {
> +			ext4_error(sb, "Something is wrong with group %u: "
> +				   "used itable blocks: %d; "
> +				   "itable unused count: %u",
> +				   group, used_blks,
> +				   ext4_itable_unused_count(sb, gdp));
> +			ret = 1;
> +			goto err_out;
> +		}
> +
> +		used_inos += group * EXT4_INODES_PER_GROUP(sb);
> +		/*
> +		 * Are there some uninitialized inodes in the inode table
> +		 * before the first normal inode?
> +		 */
> +		if ((used_blks != sbi->s_itb_per_group) &&
> +		     (used_inos < EXT4_FIRST_INO(sb))) {
> +			ext4_error(sb, "Something is wrong with group %u: "
> +				   "itable unused count: %u; "
> +				   "itables initialized count: %ld",
> +				   group, ext4_itable_unused_count(sb, gdp),
> +				   used_inos);
> +			ret = 1;
> +			goto err_out;
> +		}
>  	}
>  
>  	blk = ext4_inode_table(sb, gdp) + used_blks;
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
