Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC2734D258
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Mar 2021 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhC2O0w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Mar 2021 10:26:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhC2O0d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Mar 2021 10:26:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 99A5FAE56;
        Mon, 29 Mar 2021 14:26:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E2A5A1E4353; Mon, 29 Mar 2021 16:26:31 +0200 (CEST)
Date:   Mon, 29 Mar 2021 16:26:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: fix check to prevent false positive report of
 incorrect used inodes
Message-ID: <20210329142631.GC4283@quack2.suse.cz>
References: <20210329061955.2437573-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329061955.2437573-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 29-03-21 14:19:55, Zhang Yi wrote:
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

Thanks! The patch looks correct but maybe the code can be made more
comprehensible like I suggest below?

> @@ -1543,22 +1544,25 @@ int ext4_init_inode_table(struct super_block *sb, ext4_group_t group,
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
> +		if (used_blks >= 0 && used_blks <= sbi->s_itb_per_group)
> +			used_inos += group * EXT4_INODES_PER_GROUP(sb);

Maybe if would be more comprehensible like:

		/* Bogus inode unused count? */
		if (used_blks < 0 || used_blks > sbi->s_itb_per_group) {
			ext4_error(...);
			ret = 1;
			goto err_out;
		}

		used_inos += EXT4_INODES_PER_GROUP(sb);
		/*
		 * Are there some uninitialized inodes in the inode table
		 * before the first normal inode?
		 */
		if (used_blks != sbi->s_itb_per_group &&
		    used_inos < EXT4_FIRST_INO(sb)) {
			ext4_error(...);
			ret = 1;
			goto err_out;
		}
> +
> +		if ((used_blks < 0) || (used_blks > sbi->s_itb_per_group) ||
> +		    ((used_blks != sbi->s_itb_per_group) &&
> +		     (used_inos < EXT4_FIRST_INO(sb)))) {
> +			ext4_error(sb, "Something is wrong with group %u: "
> +				   "used itable blocks: %d; "
> +				   "itable unused count: %u",
> +				   group, used_blks,
> +				   ext4_itable_unused_count(sb, gdp));
> +			ret = 1;
> +			goto err_out;
> +		}
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
