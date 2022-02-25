Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566CB4C44B3
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Feb 2022 13:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiBYMj2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Feb 2022 07:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiBYMj1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Feb 2022 07:39:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779271D63A3
        for <linux-ext4@vger.kernel.org>; Fri, 25 Feb 2022 04:38:54 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 365D121117;
        Fri, 25 Feb 2022 12:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645792733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOfKMwlQBolqMoMnhjOYN4BNOR0i5B3VKfnpWwg+nHY=;
        b=Q6IGcU13QC8fsV92fnbGLcmezaiff+aR1QaVGVYFzu4sQF0ZSwU+ocI32OEvhdW1QaVdfY
        Rw46NiNUCUcMCqHJ5BssRz5x/+wOJgRiM/RdfYq1KnksbU1c0T2ylCCfyunlVVLHz+xQgL
        dHFXoHzpz/4dbwEyb75hiyGgiI4Wc4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645792733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aOfKMwlQBolqMoMnhjOYN4BNOR0i5B3VKfnpWwg+nHY=;
        b=kmYsNNUuQ4do4lV0GE8Ut+55OM7C7sOznnO0ytqpDgGJaKcbj1s6Gg9nHN/IFfeCp2RXVN
        gdFg4RFh7patWSDw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4ED83A3B81;
        Fri, 25 Feb 2022 12:38:52 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F2F7EA05D9; Fri, 25 Feb 2022 13:38:51 +0100 (CET)
Date:   Fri, 25 Feb 2022 13:38:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2] ext4: fix underflow in ext4_max_bitmap_size()
Message-ID: <20220225123851.flahv2nlvpqq3d33@quack3.lan>
References: <20220225102837.3048196-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225102837.3048196-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 25-02-22 18:28:37, Zhang Yi wrote:
> The same to commit 1c2d14212b15 ("ext2: Fix underflow in ext2_max_size()")
> in ext2 filesystem, ext4 driver has the same issue with 64K block size
> and ^huge_file, fix this issue the same as ext2. This patch also revert
> commit 75ca6ad408f4 ("ext4: fix loff_t overflow in ext4_max_bitmap_size()")
> because it's no longer needed.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks for the patch. I would not refer to ext2 patch in the changelog - it
is better to have it self-contained. AFAIU the problem is that (meta_blocks
> upper_limit) for 64k blocksize and ^huge_file and so upper_limit would
underflow during the computations, am I right?

Also two comments below:

> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c5021ca0a28a..95608c2127e7 100644
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
> -	/* indirect blocks */
> -	meta_blocks = 1;
> -	/* double indirect blocks */
> -	meta_blocks += 1 + (1LL << (bits-2));
> -	/* tripple indirect blocks */
> -	meta_blocks += 1 + (1LL << (bits-2)) + (1LL << (2*(bits-2)));
> -
> -	upper_limit -= meta_blocks;
> -	upper_limit <<= bits;
> -
> +	/* Compute how many blocks we can address by block tree */
>  	res += 1LL << (bits-2);
>  	res += 1LL << (2*(bits-2));
>  	res += 1LL << (3*(bits-2));

When you have the 'ppb' convenience variable, perhaps you can update this
math to:

	res = EXT4_NDIR_BLOCKS + ppb + ppb*ppb + ((long long)ppb)*ppb*ppb;

It is easier to understand and matches how you compute meta_blocks as well.

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
> +	/* indirect blocks */
> +	meta_blocks = 1;
> +	upper_limit -= ppb;
> +	/* double indirect blocks */
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

Cannot this overflow loff_t again? I mean if upper_limit == (1 << 48) - 1
and we have 64k blocksize, 'res' will be larger than (1 << 47) and thus 
res << 16 will be greater than 1 << 63 => negative... Am I missing
something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
