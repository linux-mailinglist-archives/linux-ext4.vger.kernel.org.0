Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5846F39D937
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 12:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFGKCU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 06:02:20 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55916 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhFGKCU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 06:02:20 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5BB8121A6C;
        Mon,  7 Jun 2021 10:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623060028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFjiMXVAWRqijm4ryAAi/AxWgTd6JPrh4QAApGk5EJ8=;
        b=Hl0YGueKVNdMk6VZYwfA0+cy3x8GAfZZ4ovNWpuXN1AOBR9piJjHWud5ynyGsKGEnGXXC5
        jL05huKwufBNpmGj5qaGUiXprkf+kyd63ponwczA4jpkFk01Rgp/QP6doikqy6mP1aDzQQ
        6SXNBUvhKFp1NST+GBh01fT3+wdWyBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623060028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GFjiMXVAWRqijm4ryAAi/AxWgTd6JPrh4QAApGk5EJ8=;
        b=cunPtc+elufhsl8ONQYKZN1i5WR3wseVl0DmQRba8IH+/feaWQKwp8mwBNXha9S7y+Mkqs
        pMdxcjXFGNvzgsAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4CC67A3B81;
        Mon,  7 Jun 2021 10:00:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1CC131F2CA8; Mon,  7 Jun 2021 12:00:28 +0200 (CEST)
Date:   Mon, 7 Jun 2021 12:00:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Fix loff_t overflow in ext4_max_bitmap_size()
Message-ID: <20210607100028.GE30275@quack2.suse.cz>
References: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594f409e2c543e90fd836b78188dfa5c575065ba.1622867594.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 05-06-21 10:39:32, Ritesh Harjani wrote:
> We should use unsigned long long rather than loff_t to avoid
> overflow in ext4_max_bitmap_size() for comparison before returning.
> w/o this patch sbi->s_bitmap_maxbytes was becoming a negative
> value due to overflow of upper_limit (with has_huge_files as true)
> 
> Below is a quick test to trigger it on a 64KB pagesize system.
> 
> sudo mkfs.ext4 -b 65536 -O ^has_extents,^64bit /dev/loop2
> sudo mount /dev/loop2 /mnt
> sudo echo "hello" > /mnt/hello 	-> This will error out with
> 				"echo: write error: File too large"
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

OK, this works (although it's really tight ;). Won't it be somewhat safer
if we compared upper_limit and res before shifting both by blocksize_bits
to the left? Basically we need to shift only for comparison with
MAX_LFS_FILESIZE which is in bytes... But either way feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7dc94f3e18e6..bedb66386966 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3189,17 +3189,17 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
>   */
>  static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>  {
> -	loff_t res = EXT4_NDIR_BLOCKS;
> +	unsigned long long upper_limit, res = EXT4_NDIR_BLOCKS;
>  	int meta_blocks;
> -	loff_t upper_limit;
> -	/* This is calculated to be the largest file size for a dense, block
> +
> +	/*
> +	 * This is calculated to be the largest file size for a dense, block
>  	 * mapped file such that the file's total number of 512-byte sectors,
>  	 * including data and all indirect blocks, does not exceed (2^48 - 1).
>  	 *
>  	 * __u32 i_blocks_lo and _u16 i_blocks_high represent the total
>  	 * number of 512-byte sectors of the file.
>  	 */
> -
>  	if (!has_huge_files) {
>  		/*
>  		 * !has_huge_files or implies that the inode i_block field
> @@ -3242,7 +3242,7 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
>  	if (res > MAX_LFS_FILESIZE)
>  		res = MAX_LFS_FILESIZE;
>  
> -	return res;
> +	return (loff_t)res;
>  }
>  
>  static ext4_fsblk_t descriptor_loc(struct super_block *sb,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
