Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9603220427
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 13:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfEPLMY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 07:12:24 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25992 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726363AbfEPLMY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 07:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558005128; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=oa8jAt+N0oiwPL/o2/kdkpWUuqHVfjpBo6e9j2SjoIFIzPr5YCWn80rbdqsveMRAdOOYuw2AI8GDl2mPX+j3u8Pvm4sSNIOzDu+QZCHiXEcIcPY7IIg0q41ceUP4L312G+BpP69BCOIm9bjAoz0/cEL3B8qdpYNuTIBG9VErAB8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558005128; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=MBGt7wE6a1gVyLHvWwFQMw6zN3+riLAnRDR6nlDc05o=; 
        b=lPa7h0dvMtqekFzz6NqxrZKmFCzuTudNcCuL0Zex0vhGIyOHIzmPnz0C1NeRkkpU4IlGve5AAaOAN2Uj0lyd2SQ6B5fTFO0gzeG0ykxLy5zz0ytdMyCmZ3OsqBaZ5Tc9XiuTRUcI2JZq/dMlhJeAP10xDtHstHNyW4+LkFOuLSY=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 155800512731489.94072764218072; Thu, 16 May 2019 19:12:07 +0800 (CST)
Message-ID: <689a2ca81548c0300324e60fa7959caf1c2abf13.camel@zoho.com.cn>
Subject: Re: [PATCH 3/3] ext2: Strengthen xattr block checks
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Date:   Thu, 16 May 2019 19:11:56 +0800
In-Reply-To: <20190516100322.12632-4-jack@suse.cz>
References: <20190516100322.12632-1-jack@suse.cz>
         <20190516100322.12632-4-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2019-05-16 at 12:03 +0200, Jan Kara wrote:
> Check every entry in xattr block for validity in ext2_xattr_set() to
> detect on disk corruption early. Also since e_value_block field in xattr
> entry is never != 0 in a valid filesystem, just remove checks for it
> once we have established entries are valid.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Chengguang Xu <cgxu519@zoho.com.cn>

> ---
>  fs/ext2/xattr.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index f9fda6d16d78..d21dbf297b74 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -218,6 +218,8 @@ ext2_xattr_get(struct inode *inode, int name_index, const
> char *name,
>  			EXT2_XATTR_NEXT(entry);
>  		if ((char *)next >= end)
>  			goto bad_block;
> +		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
> +			goto bad_block;
>  		if (name_index == entry->e_name_index &&
>  		    name_len == entry->e_name_len &&
>  		    memcmp(name, entry->e_name, name_len) == 0)
> @@ -229,9 +231,6 @@ ext2_xattr_get(struct inode *inode, int name_index, const
> char *name,
>  	error = -ENODATA;
>  	goto cleanup;
>  found:
> -	if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
> -		goto bad_block;
> -
>  	size = le32_to_cpu(entry->e_value_size);
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
>  		ea_idebug(inode, "cache insert failed");
> @@ -304,6 +303,8 @@ ext2_xattr_list(struct dentry *dentry, char *buffer,
> size_t buffer_size)
>  
>  		if ((char *)next >= end)
>  			goto bad_block;
> +		if (!ext2_xattr_entry_valid(entry, inode->i_sb->s_blocksize))
> +			goto bad_block;
>  		entry = next;
>  	}
>  	if (ext2_xattr_cache_insert(ea_block_cache, bh))
> @@ -446,7 +447,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
>  			if ((char *)next >= end)
>  				goto bad_block;
> -			if (!last->e_value_block && last->e_value_size) {
> +			if (!ext2_xattr_entry_valid(last, sb->s_blocksize))
> +				goto bad_block;
> +			if (last->e_value_size) {
>  				size_t offs = le16_to_cpu(last->e_value_offs);
>  				if (offs < min_offs)
>  					min_offs = offs;
> @@ -489,12 +492,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  		error = -EEXIST;
>  		if (flags & XATTR_CREATE)
>  			goto cleanup;
> -		if (!here->e_value_block && here->e_value_size) {
> -			if (!ext2_xattr_entry_valid(here, sb->s_blocksize))
> -				goto bad_block;
> -			free += EXT2_XATTR_SIZE(
> -					le32_to_cpu(here->e_value_size));
> -		}
> +		free += EXT2_XATTR_SIZE(le32_to_cpu(here->e_value_size));
>  		free += EXT2_XATTR_LEN(name_len);
>  	}
>  	error = -ENOSPC;
> @@ -559,7 +557,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  		here->e_name_len = name_len;
>  		memcpy(here->e_name, name, name_len);
>  	} else {
> -		if (!here->e_value_block && here->e_value_size) {
> +		if (here->e_value_size) {
>  			char *first_val = (char *)header + min_offs;
>  			size_t offs = le16_to_cpu(here->e_value_offs);
>  			char *val = (char *)header + offs;
> @@ -586,7 +584,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  			last = ENTRY(header+1);
>  			while (!IS_LAST_ENTRY(last)) {
>  				size_t o = le16_to_cpu(last->e_value_offs);
> -				if (!last->e_value_block && o < offs)
> +				if (o < offs)
>  					last->e_value_offs =
>  						cpu_to_le16(o + size);
>  				last = EXT2_XATTR_NEXT(last);



