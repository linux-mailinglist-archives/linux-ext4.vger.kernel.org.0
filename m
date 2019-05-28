Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 068702C156
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 10:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfE1IaY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 04:30:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726532AbfE1IaY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 May 2019 04:30:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27E6FAFE8;
        Tue, 28 May 2019 08:30:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C78AD1E3C0C; Tue, 28 May 2019 10:30:21 +0200 (CEST)
Date:   Tue, 28 May 2019 10:30:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ext2: merge xattr next entry check to
 ext2_xattr_entry_valid()
Message-ID: <20190528083021.GB9607@quack2.suse.cz>
References: <20190528025947.18373-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528025947.18373-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 28-05-19 10:59:45, Chengguang Xu wrote:
> We have introduced ext2_xattr_entry_valid() for xattr
> entry sanity check, so it's better to do relevant things
> in one place.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks! I've applied all three patches to my tree.

								Honza

> ---
>  fs/ext2/xattr.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index d21dbf297b74..28503979696d 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -145,10 +145,16 @@ ext2_xattr_header_valid(struct ext2_xattr_header *header)
>  }
>  
>  static bool
> -ext2_xattr_entry_valid(struct ext2_xattr_entry *entry, size_t end_offs)
> +ext2_xattr_entry_valid(struct ext2_xattr_entry *entry,
> +		       char *end, size_t end_offs)
>  {
> +	struct ext2_xattr_entry *next;
>  	size_t size;
>  
> +	next = EXT2_XATTR_NEXT(entry);
> +	if ((char *)next >= end)
> +		return false;
> +
>  	if (entry->e_value_block != 0)
>  		return false;
>  
> @@ -214,17 +220,14 @@ ext2_xattr_get(struct inode *inode, int name_index, const char *name,
>  	/* find named attribute */
>  	entry = FIRST_ENTRY(bh);
>  	while (!IS_LAST_ENTRY(entry)) {
> -		struct ext2_xattr_entry *next =
> -			EXT2_XATTR_NEXT(entry);
> -		if ((char *)next >= end)
> -			goto bad_block;
> -		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
> +		if (!ext2_xattr_entry_valid(entry, end,
> +		    inode->i_sb->s_blocksize))
>  			goto bad_block;
>  		if (name_index == entry->e_name_index &&
>  		    name_len == entry->e_name_len &&
>  		    memcmp(name, entry->e_name, name_len) == 0)
>  			goto found;
> -		entry = next;
> +		entry = EXT2_XATTR_NEXT(entry);
>  	}
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
>  		ea_idebug(inode, "cache insert failed");
> @@ -299,13 +302,10 @@ ext2_xattr_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	/* check the on-disk data structure */
>  	entry = FIRST_ENTRY(bh);
>  	while (!IS_LAST_ENTRY(entry)) {
> -		struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(entry);
> -
> -		if ((char *)next >= end)
> -			goto bad_block;
> -		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
> +		if (!ext2_xattr_entry_valid(entry, end,
> +		    inode->i_sb->s_blocksize))
>  			goto bad_block;
> -		entry = next;
> +		entry = EXT2_XATTR_NEXT(entry);
>  	}
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
>  		ea_idebug(inode, "cache insert failed");
> @@ -390,7 +390,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  	struct super_block *sb = inode->i_sb;
>  	struct buffer_head *bh = NULL;
>  	struct ext2_xattr_header *header = NULL;
> -	struct ext2_xattr_entry *here, *last;
> +	struct ext2_xattr_entry *here = NULL, *last = NULL;
>  	size_t name_len, free, min_offs = sb->s_blocksize;
>  	int not_found = 1, error;
>  	char *end;
> @@ -444,10 +444,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		 */
>  		last = FIRST_ENTRY(bh);
>  		while (!IS_LAST_ENTRY(last)) {
> -			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
> -			if ((char *)next >= end)
> -				goto bad_block;
> -			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
> +			if (!ext2_xattr_entry_valid(last, end, sb->s_blocksize))
>  				goto bad_block;
>  			if (last->e_value_size) {
>  				size_t offs = le16_to_cpu(last->e_value_offs);
> @@ -465,7 +462,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  				if (not_found <= 0)
>  					here = last;
>  			}
> -			last = next;
> +			last = EXT2_XATTR_NEXT(last);
>  		}
>  		if (not_found > 0)
>  			here = last;
> @@ -476,7 +473,6 @@ ext2_xattr_set(struct inode *inode, int name_index, const char *name,
>  		/* We will use a new extended attribute block. */
>  		free = sb->s_blocksize -
>  			sizeof(struct ext2_xattr_header) - sizeof(__u32);
> -		here = last = NULL;  /* avoid gcc uninitialized warning. */
>  	}
>  
>  	if (not_found) {
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
