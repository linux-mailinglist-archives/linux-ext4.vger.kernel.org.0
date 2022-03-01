Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7574C8AEB
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 12:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbiCALhC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Mar 2022 06:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiCALhA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Mar 2022 06:37:00 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B77B939BA
        for <linux-ext4@vger.kernel.org>; Tue,  1 Mar 2022 03:36:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D030421997;
        Tue,  1 Mar 2022 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646134578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXQaNDN9Pbvom6AD2LBD/oGzON/XaC69Ga1vGvKTNDE=;
        b=rulNDScQmJjnwaGBmlexwsld0TFybEXt9x/0cgV7iQlTQRD8B+Q7bVc2mD6jS0rQNy4vfq
        a7F2jm5DkBDM11KDriQ4Jt090oxquAaBYmIFTl5CQxop8AwRt7NWFIShxs7TqkBP5fnZsC
        2rfS9vZE7lNBW7I4qrWvQUZFgnDkBe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646134578;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXQaNDN9Pbvom6AD2LBD/oGzON/XaC69Ga1vGvKTNDE=;
        b=Yx1w4IYX130ucpTrEXLzHTi4nYArPHNdz6vd0WYODnWey04rC6oboprEWWc4SnnFtJCES1
        N7fp0GBT27i3MYBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD535A3B8C;
        Tue,  1 Mar 2022 11:36:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6C8DEA0608; Tue,  1 Mar 2022 12:36:18 +0100 (CET)
Date:   Tue, 1 Mar 2022 12:36:18 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v3] ext4: fix underflow in ext4_max_bitmap_size()
Message-ID: <20220301113618.ai6agoqa42fbu2he@quack3.lan>
References: <20220301111704.2153829-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301111704.2153829-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 01-03-22 19:17:04, Zhang Yi wrote:
> when ext4 filesystem is created with 64k block size, ^extent and
> ^huge_file features. the upper_limit would underflow during the
> computations in ext4_max_bitmap_size(). The problem is the size of block
> index tree for such large block size is more than i_blocks can carry.
> So fix the computation to count with this possibility. After this fix,
> the 'res' cannot overflow loff_t on the extreme case of filesystem with
> huge_files and 64K block size, so this patch also revert commit
> 75ca6ad408f4 ("ext4: fix loff_t overflow in ext4_max_bitmap_size()").
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v3->v2: rewrite change log and use ppb to compute 'res' blocks.
> v2->v1: use DIV_ROUND_UP_ULL instead of DIV_ROUND_UP.
> 
>  fs/ext4/super.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5021ca0a28a..bfba62206a14 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3468,8 +3468,9 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
>   */
>  static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>  {
> -	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
> +	loff_t upper_limit, res = EXT4_NDIR_BLOCKS;
>  	int meta_blocks;
> +	unsigned int ppb = 1 << (bits - 2);
>  
>  	/*
>  	 * This is calculated to be the largest file size for a dense, block
> @@ -3501,27 +3502,42 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>  
>  	}
>  
> +	/* Compute how many blocks we can address by block tree */
> +	res += ppb;
> +	res += ppb * ppb;
> +	res += ((loff_t)ppb) * ppb * ppb;
> +	/* Compute how many metadata blocks are needed */
> +	meta_blocks = 1;
> +	meta_blocks += 1 + ppb;
> +	meta_blocks += 1 + ppb + ppb * ppb;
> +	/* Does block tree limit file size? */
> +	if (res + meta_blocks <= upper_limit)
> +		goto check_lfs;
> +
> +	res = upper_limit;
> +	/* How many metadata blocks are needed for addressing upper_limit? */
> +	upper_limit -= EXT4_NDIR_BLOCKS;
>  	/* indirect blocks */
>  	meta_blocks = 1;
> +	upper_limit -= ppb;
>  	/* double indirect blocks */
> -	meta_blocks += 1 + (1LL << (bits-2));
> -	/* tripple indirect blocks */
> -	meta_blocks += 1 + (1LL << (bits-2)) + (1LL << (2*(bits-2)));
> -
> -	upper_limit -= meta_blocks;
> -	upper_limit <<= bits;
> -
> -	res += 1LL << (bits-2);
> -	res += 1LL << (2*(bits-2));
> -	res += 1LL << (3*(bits-2));
> +	if (upper_limit < ppb * ppb) {
> +		meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb);
> +		res -= meta_blocks;
> +		goto check_lfs;
> +	}
> +	meta_blocks += 1 + ppb;
> +	upper_limit -= ppb * ppb;
> +	/* tripple indirect blocks for the rest */
> +	meta_blocks += 1 + DIV_ROUND_UP_ULL(upper_limit, ppb) +
> +		DIV_ROUND_UP_ULL(upper_limit, ppb*ppb);
> +	res -= meta_blocks;
> +check_lfs:
>  	res <<= bits;
> -	if (res > upper_limit)
> -		res = upper_limit;
> -
>  	if (res > MAX_LFS_FILESIZE)
>  		res = MAX_LFS_FILESIZE;
>  
> -	return (loff_t)res;
> +	return res;
>  }
>  
>  static ext4_fsblk_t descriptor_loc(struct super_block *sb,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
