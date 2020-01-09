Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E26AA135632
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 10:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgAIJvv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 04:51:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:35372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728755AbgAIJvv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 04:51:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BBD93C207;
        Thu,  9 Jan 2020 09:51:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E97881E0CB5; Thu,  9 Jan 2020 10:51:40 +0100 (CET)
Date:   Thu, 9 Jan 2020 10:51:40 +0100
From:   Jan Kara <jack@suse.cz>
To:     Naoto Kobayashi <naoto.kobayashi4c@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext4: Delete ext4_kvzvalloc()
Message-ID: <20200109095140.GB27035@quack2.suse.cz>
References: <20191227080523.31808-1-naoto.kobayashi4c@gmail.com>
 <20191227080523.31808-2-naoto.kobayashi4c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227080523.31808-2-naoto.kobayashi4c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 27-12-19 17:05:21, Naoto Kobayashi wrote:
> Since we're not using ext4_kvzalloc(), delete this function.
> 
> Signed-off-by: Naoto Kobayashi <naoto.kobayashi4c@gmail.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  1 -
>  fs/ext4/super.c | 10 ----------
>  2 files changed, 11 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 61987c106511..b25089e3896d 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2678,7 +2678,6 @@ extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
>  extern int ext4_calculate_overhead(struct super_block *sb);
>  extern void ext4_superblock_csum_set(struct super_block *sb);
>  extern void *ext4_kvmalloc(size_t size, gfp_t flags);
> -extern void *ext4_kvzalloc(size_t size, gfp_t flags);
>  extern int ext4_alloc_flex_bg_array(struct super_block *sb,
>  				    ext4_group_t ngroup);
>  extern const char *ext4_decode_error(struct super_block *sb, int errno,
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b205112ca051..83a231dedcbf 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -214,16 +214,6 @@ void *ext4_kvmalloc(size_t size, gfp_t flags)
>  	return ret;
>  }
> 
> -void *ext4_kvzalloc(size_t size, gfp_t flags)
> -{
> -	void *ret;
> -
> -	ret = kzalloc(size, flags | __GFP_NOWARN);
> -	if (!ret)
> -		ret = __vmalloc(size, flags | __GFP_ZERO, PAGE_KERNEL);
> -	return ret;
> -}
> -
>  ext4_fsblk_t ext4_block_bitmap(struct super_block *sb,
>  			       struct ext4_group_desc *bg)
>  {
> --
> 2.16.6
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
