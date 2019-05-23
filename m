Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBF628023
	for <lists+linux-ext4@lfdr.de>; Thu, 23 May 2019 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfEWOqP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 May 2019 10:46:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730853AbfEWOqO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 May 2019 10:46:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1C5EEAF0C;
        Thu, 23 May 2019 14:46:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BE2E91E3C69; Thu, 23 May 2019 16:46:12 +0200 (CEST)
Date:   Thu, 23 May 2019 16:46:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: optimize ext2_xattr_get()
Message-ID: <20190523144612.GA18841@quack2.suse.cz>
References: <20190521082140.19992-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521082140.19992-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-05-19 16:21:39, Chengguang Xu wrote:
> Since xattr entry names are sorted, we don't have
> to continue when current entry name is greater than
> target.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the patch! If we are going to do these comparisons in multiple
places, then please create a helper function to do the comparison (so that
we have the same comparison in every place). Something like:

int ext2_xattr_cmp(int name_index, size_t name_len, const char *name,
		   struct ext2_xattr_entry *entry)

Thanks!

								Honza
> ---
>  fs/ext2/xattr.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index d21dbf297b74..f1f857b83b45 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -178,7 +178,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  	struct ext2_xattr_entry *entry;
>  	size_t name_len, size;
>  	char *end;
> -	int error;
> +	int error, not_found;
>  	struct mb_cache *ea_block_cache = EA_BLOCK_CACHE(inode);
>  
>  	ea_idebug(inode, "name=%d.%s, buffer=%p, buffer_size=%ld",
> @@ -220,10 +220,18 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  			goto bad_block;
>  		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
>  			goto bad_block;
> -		if (name_index == entry->e_name_index &&
> -		    name_len == entry->e_name_len &&
> -		    memcmp(name, entry->e_name, name_len) == 0)
> +
> +		not_found = name_index - entry->e_name_index;
> +		if (!not_found)
> +			not_found = name_len - entry->e_name_len;
> +		if (!not_found)
> +			not_found = memcmp(name, entry->e_name,
> +						   name_len);
> +		if (!not_found)
>  			goto found;
> +		if (not_found < 0)
> +			break;
> +
>  		entry = next;
>  	}
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
