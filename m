Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DE1F616
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 15:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfEON6d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 09:58:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42784 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfEON6d (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 09:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9297FAF81;
        Wed, 15 May 2019 13:58:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5199A1E3C5A; Wed, 15 May 2019 15:58:30 +0200 (CEST)
Date:   Wed, 15 May 2019 15:58:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ext2: introduce helper for xattr entry validation
Message-ID: <20190515135830.GB9526@quack2.suse.cz>
References: <20190513224042.23377-1-cgxu519@zoho.com.cn>
 <20190513224042.23377-2-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513224042.23377-2-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-05-19 06:40:42, Chengguang Xu wrote:
> Introduce helper function ext2_xattr_entry_valid()
> for xattr entry validation and clean up the entry
> check ralated code.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

So I like the direction where this is going but I don't think the end
result after this particular patch is significantly better. So I've ended
up modifying this patch slightly and adding two more cleanups to make things
more obvious. I'll send the result separately.

								Honza

> ---
> v1->v2:
> - Pass end offset instead of inode to ext2_xattr_entry_valid()
> - Change signed-off mail address.
> 
>  fs/ext2/xattr.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index db27260d6a5b..d11c83529514 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -144,6 +144,20 @@ ext2_xattr_header_valid(struct ext2_xattr_header *header)
>  	return true;
>  }
>  
> +static bool
> +ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t size,
> +		       size_t end_offs)
> +{
> +	if (entry->e_value_block != 0)
> +		return false;
> +
> +	if (size > end_offs ||
> +	    le16_to_cpu(entry->e_value_offs) + size > end_offs)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * ext2_xattr_get()
>   *
> @@ -217,8 +231,7 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  	if (entry->e_value_block != 0)
>  		goto bad_block;
>  	size = le32_to_cpu(entry->e_value_size);
> -	if (size > inode->i_sb->s_blocksize ||
> -	    le16_to_cpu(entry->e_value_offs) + size > inode->i_sb->s_blocksize)
> +	if (!ext2_xattr_entry_valid(entry, size, inode->i_sb->s_blocksize))
>  		goto bad_block;
>  
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
> @@ -483,8 +496,8 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		if (!here->e_value_block && here->e_value_size) {
>  			size_t size = le32_to_cpu(here->e_value_size);
>  
> -			if (le16_to_cpu(here->e_value_offs) + size > 
> -			    sb->s_blocksize || size > sb->s_blocksize)
> +			if (!ext2_xattr_entry_valid(here, size,
> +			    inode->i_sb->s_blocksize))
>  				goto bad_block;
>  			free += EXT2_XATTR_SIZE(size);
>  		}
> -- 
> 2.17.2
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
