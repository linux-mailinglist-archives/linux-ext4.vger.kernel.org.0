Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47FD41FD27
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 03:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfEPBqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 21:46:40 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25971 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbfEPBf3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 May 2019 21:35:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1557969370; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=ndvlJ+QjY+o3dq29Jt7bDsU7gT4Bs0dTQ3ET6RJNkkMk/WatZnRBEqCu7rwVYOb+212xfFjR+3nvLq2ZcY3WjrwMdR12YhkjlMq+F8GQKPdtiH1/epvkOIIvqmBen/smGqgxDRZbFAxJxkJ2MHDG9mEmJ3mmojj/6WrqPykNzxM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1557969370; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=IDigYKbsj+6R+kkbD/0QxrSWvHBJf1OOVlGD2OdVh7U=; 
        b=eMb/57QhYrOX0yXlgiVrJpBE/zdUxIGhI3TokME+Dn/QBF3z9keiediHdI0wi2+Xd9YtmF7XwJnB5KaMDcMy5PXNVJIKM+TPJgfmjZdegq39pspi24XOACoZBXU8DnBrM1qQHDNswNHHa1CBin7nxvUZKeYt6IshsMzbITgNTHM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1557969368772393.8452859325248; Thu, 16 May 2019 09:16:08 +0800 (CST)
Message-ID: <e0252f7d378e8de5cadea28ad3c4765a541c2c69.camel@zoho.com.cn>
Subject: Re: [PATCH 3/3] ext2: Strengthen xattr block checks
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Date:   Thu, 16 May 2019 09:16:06 +0800
In-Reply-To: <20190515140144.1183-4-jack@suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
         <20190515140144.1183-4-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 2019-05-15 at 16:01 +0200, Jan Kara wrote:
> Check every entry in xattr block for validity in ext2_xattr_set() to
> detect on disk corruption early. Also since e_value_block field in xattr
> entry is never != 0 in a valid filesystem, just remove checks for it
> once we have established entries are valid.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Could we do the entry check in the loop of get/list operation too?

Thanks,
Chengguang

> ---
>  fs/ext2/xattr.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 26a049ca89fb..04a4148d04b3 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -442,7 +442,9 @@ ext2_xattr_set(struct inode *inode, int name_index, const
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
> @@ -482,12 +484,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
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
> @@ -552,7 +549,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  		here->e_name_len = name_len;
>  		memcpy(here->e_name, name, name_len);
>  	} else {
> -		if (!here->e_value_block && here->e_value_size) {
> +		if (here->e_value_size) {
>  			char *first_val = (char *)header + min_offs;
>  			size_t offs = le16_to_cpu(here->e_value_offs);
>  			char *val = (char *)header + offs;
> @@ -579,7 +576,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  			last = ENTRY(header+1);
>  			while (!IS_LAST_ENTRY(last)) {
>  				size_t o = le16_to_cpu(last->e_value_offs);
> -				if (!last->e_value_block && o < offs)
> +				if (o < offs)
>  					last->e_value_offs =
>  						cpu_to_le16(o + size);
>  				last = EXT2_XATTR_NEXT(last);



