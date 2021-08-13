Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB80A3EB5E9
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240520AbhHMNB2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 09:01:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59076 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhHMNB0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 09:01:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D1762233E;
        Fri, 13 Aug 2021 13:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628859659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PG2A4N5oz5EgeDWFv6Jsu/G7Ebv/BWicUsCWNiMIhF8=;
        b=IVuAWEgQuZ7Il8Kt6vQ9HMqlZj5bpp8AD4m2equA2+OPPylKESpopcqfvedYRnS4DkzVzv
        WI0mezY8sYegf5hPQ9+m5/OusjXWWGKd4Rms0U9hUJwprlwrqQUC4ZGxcrSxId+WMTs2/N
        nDhDl2fXRZniYnpp2PZD+gb0EL1rfcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628859659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PG2A4N5oz5EgeDWFv6Jsu/G7Ebv/BWicUsCWNiMIhF8=;
        b=i4xQIXG7K9ICOHTZZv6jwaZdv6ZZzseGiJ3vLUcToJ+HAW7/fFwQklGUQ3MPmEf+psFuio
        n9Rj8PXdLPV5U3CA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id F09BBA3B84;
        Fri, 13 Aug 2021 13:00:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D0FDB1E423D; Fri, 13 Aug 2021 15:00:55 +0200 (CEST)
Date:   Fri, 13 Aug 2021 15:00:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 2/3] ext4: remove an unnecessary if statement in
 __ext4_get_inode_loc()
Message-ID: <20210813130055.GD11955@quack2.suse.cz>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-3-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810142722.923175-3-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-08-21 22:27:21, Zhang Yi wrote:
> The "if (!buffer_uptodate(bh))" hunk covered almost the whole code after
> getting buffer in __ext4_get_inode_loc() which seems unnecessary, remove
> it and switch to check ext4_buffer_uptodate(), it simplify code and make
> it more readable.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 162 +++++++++++++++++++++++-------------------------
>  1 file changed, 78 insertions(+), 84 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index eb2526a35254..eae1b2d0b550 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4330,99 +4330,93 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	bh = sb_getblk(sb, block);
>  	if (unlikely(!bh))
>  		return -ENOMEM;
> -	if (!buffer_uptodate(bh)) {
> -		lock_buffer(bh);
> -
> -		if (ext4_buffer_uptodate(bh)) {
> -			/* someone brought it uptodate while we waited */
> -			unlock_buffer(bh);
> -			goto has_buffer;
> -		}
> +	if (ext4_buffer_uptodate(bh))
> +		goto has_buffer;
>  
> -		/*
> -		 * If we have all information of the inode in memory and this
> -		 * is the only valid inode in the block, we need not read the
> -		 * block.
> -		 */
> -		if (in_mem) {
> -			struct buffer_head *bitmap_bh;
> -			int i, start;
> +	lock_buffer(bh);
> +	/*
> +	 * If we have all information of the inode in memory and this
> +	 * is the only valid inode in the block, we need not read the
> +	 * block.
> +	 */
> +	if (in_mem) {
> +		struct buffer_head *bitmap_bh;
> +		int i, start;
>  
> -			start = inode_offset & ~(inodes_per_block - 1);
> +		start = inode_offset & ~(inodes_per_block - 1);
>  
> -			/* Is the inode bitmap in cache? */
> -			bitmap_bh = sb_getblk(sb, ext4_inode_bitmap(sb, gdp));
> -			if (unlikely(!bitmap_bh))
> -				goto make_io;
> +		/* Is the inode bitmap in cache? */
> +		bitmap_bh = sb_getblk(sb, ext4_inode_bitmap(sb, gdp));
> +		if (unlikely(!bitmap_bh))
> +			goto make_io;
>  
> -			/*
> -			 * If the inode bitmap isn't in cache then the
> -			 * optimisation may end up performing two reads instead
> -			 * of one, so skip it.
> -			 */
> -			if (!buffer_uptodate(bitmap_bh)) {
> -				brelse(bitmap_bh);
> -				goto make_io;
> -			}
> -			for (i = start; i < start + inodes_per_block; i++) {
> -				if (i == inode_offset)
> -					continue;
> -				if (ext4_test_bit(i, bitmap_bh->b_data))
> -					break;
> -			}
> +		/*
> +		 * If the inode bitmap isn't in cache then the
> +		 * optimisation may end up performing two reads instead
> +		 * of one, so skip it.
> +		 */
> +		if (!buffer_uptodate(bitmap_bh)) {
>  			brelse(bitmap_bh);
> -			if (i == start + inodes_per_block) {
> -				/* all other inodes are free, so skip I/O */
> -				memset(bh->b_data, 0, bh->b_size);
> -				set_buffer_uptodate(bh);
> -				unlock_buffer(bh);
> -				goto has_buffer;
> -			}
> +			goto make_io;
> +		}
> +		for (i = start; i < start + inodes_per_block; i++) {
> +			if (i == inode_offset)
> +				continue;
> +			if (ext4_test_bit(i, bitmap_bh->b_data))
> +				break;
>  		}
> +		brelse(bitmap_bh);
> +		if (i == start + inodes_per_block) {
> +			/* all other inodes are free, so skip I/O */
> +			memset(bh->b_data, 0, bh->b_size);
> +			set_buffer_uptodate(bh);
> +			unlock_buffer(bh);
> +			goto has_buffer;
> +		}
> +	}
>  
>  make_io:
> -		/*
> -		 * If we need to do any I/O, try to pre-readahead extra
> -		 * blocks from the inode table.
> -		 */
> -		blk_start_plug(&plug);
> -		if (EXT4_SB(sb)->s_inode_readahead_blks) {
> -			ext4_fsblk_t b, end, table;
> -			unsigned num;
> -			__u32 ra_blks = EXT4_SB(sb)->s_inode_readahead_blks;
> -
> -			table = ext4_inode_table(sb, gdp);
> -			/* s_inode_readahead_blks is always a power of 2 */
> -			b = block & ~((ext4_fsblk_t) ra_blks - 1);
> -			if (table > b)
> -				b = table;
> -			end = b + ra_blks;
> -			num = EXT4_INODES_PER_GROUP(sb);
> -			if (ext4_has_group_desc_csum(sb))
> -				num -= ext4_itable_unused_count(sb, gdp);
> -			table += num / inodes_per_block;
> -			if (end > table)
> -				end = table;
> -			while (b <= end)
> -				ext4_sb_breadahead_unmovable(sb, b++);
> -		}
> +	/*
> +	 * If we need to do any I/O, try to pre-readahead extra
> +	 * blocks from the inode table.
> +	 */
> +	blk_start_plug(&plug);
> +	if (EXT4_SB(sb)->s_inode_readahead_blks) {
> +		ext4_fsblk_t b, end, table;
> +		unsigned num;
> +		__u32 ra_blks = EXT4_SB(sb)->s_inode_readahead_blks;
> +
> +		table = ext4_inode_table(sb, gdp);
> +		/* s_inode_readahead_blks is always a power of 2 */
> +		b = block & ~((ext4_fsblk_t) ra_blks - 1);
> +		if (table > b)
> +			b = table;
> +		end = b + ra_blks;
> +		num = EXT4_INODES_PER_GROUP(sb);
> +		if (ext4_has_group_desc_csum(sb))
> +			num -= ext4_itable_unused_count(sb, gdp);
> +		table += num / inodes_per_block;
> +		if (end > table)
> +			end = table;
> +		while (b <= end)
> +			ext4_sb_breadahead_unmovable(sb, b++);
> +	}
>  
> -		/*
> -		 * There are other valid inodes in the buffer, this inode
> -		 * has in-inode xattrs, or we don't have this inode in memory.
> -		 * Read the block from disk.
> -		 */
> -		trace_ext4_load_inode(sb, ino);
> -		ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
> -		blk_finish_plug(&plug);
> -		wait_on_buffer(bh);
> -		ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
> -		if (!buffer_uptodate(bh)) {
> -			if (ret_block)
> -				*ret_block = block;
> -			brelse(bh);
> -			return -EIO;
> -		}
> +	/*
> +	 * There are other valid inodes in the buffer, this inode
> +	 * has in-inode xattrs, or we don't have this inode in memory.
> +	 * Read the block from disk.
> +	 */
> +	trace_ext4_load_inode(sb, ino);
> +	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
> +	blk_finish_plug(&plug);
> +	wait_on_buffer(bh);
> +	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
> +	if (!buffer_uptodate(bh)) {
> +		if (ret_block)
> +			*ret_block = block;
> +		brelse(bh);
> +		return -EIO;
>  	}
>  has_buffer:
>  	iloc->bh = bh;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
