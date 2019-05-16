Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 325BC20423
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfEPLLt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 07:11:49 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25786 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726383AbfEPLLt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 07:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558005092; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=Yr6KYEiuNWI5O2e4BaTY6iHBPalXeUAbV2AJvcmx/dqK0Wjw6iJPOTmkDv9m2rmHzLTSUC0bFqhYLU49M7Ed5UcrC0vyamgD+lpsKLmzCAykzz+NKFYWp3719ea3fNDIwX9J3nudp65B4+oGKHpLCsTN1YFF+Ei26TWgq+TtBWY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1558005092; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=wEtgW9/vmDo3v5V2mtiagrJx0sRfDRzw8dhD7oZONKk=; 
        b=c6vLh78Qd3/HMdpCAXJoFgK1CkzR8JY8UbQod48EDIGkdsMP8JCWgHuMLPl0RxgZN1H8sOfc4qKtNu/zJRuxwsw08KMrUflEUROWIbO7D5LTAMBRyx8ilW6lAiCzHYz9H291idOJuBVTm3ySiKROlCOjqznpRu2tHVWRbyDxAOU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1558005091390699.5230978860404; Thu, 16 May 2019 19:11:31 +0800 (CST)
Message-ID: <47cf66a681a1836877a6899a67d1b6301bd29e07.camel@zoho.com.cn>
Subject: Re: [PATCH 2/3] ext2: Merge loops in ext2_xattr_set()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Date:   Thu, 16 May 2019 19:11:25 +0800
In-Reply-To: <20190516100322.12632-3-jack@suse.cz>
References: <20190516100322.12632-1-jack@suse.cz>
         <20190516100322.12632-3-jack@suse.cz>
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
> There are two very similar loops when searching xattr to set. Just merge
> them.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Chengguang Xu <cgxu519@zoho.com.cn>


> ---
>  fs/ext2/xattr.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index fb2e008d4406..f9fda6d16d78 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -436,28 +436,12 @@ ext2_xattr_set(struct inode *inode, int name_index,
> const char *name,
>  			error = -EIO;
>  			goto cleanup;
>  		}
> -		/* Find the named attribute. */
> -		here = FIRST_ENTRY(bh);
> -		while (!IS_LAST_ENTRY(here)) {
> -			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(here);
> -			if ((char *)next >= end)
> -				goto bad_block;
> -			if (!here->e_value_block && here->e_value_size) {
> -				size_t offs = le16_to_cpu(here->e_value_offs);
> -				if (offs < min_offs)
> -					min_offs = offs;
> -			}
> -			not_found = name_index - here->e_name_index;
> -			if (!not_found)
> -				not_found = name_len - here->e_name_len;
> -			if (!not_found)
> -				not_found = memcmp(name, here->e_name,name_len);
> -			if (not_found <= 0)
> -				break;
> -			here = next;
> -		}
> -		last = here;
> -		/* We still need to compute min_offs and last. */
> +		/*
> +		 * Find the named attribute. If not found, 'here' will point
> +		 * to entry where the new attribute should be inserted to
> +		 * maintain sorting.
> +		 */
> +		last = FIRST_ENTRY(bh);
>  		while (!IS_LAST_ENTRY(last)) {
>  			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
>  			if ((char *)next >= end)
> @@ -467,8 +451,21 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  				if (offs < min_offs)
>  					min_offs = offs;
>  			}
> +			if (not_found > 0) {
> +				not_found = name_index - last->e_name_index;
> +				if (!not_found)
> +					not_found = name_len - last->e_name_len;
> +				if (!not_found) {
> +					not_found = memcmp(name, last->e_name,
> +							   name_len);
> +				}
> +				if (not_found <= 0)
> +					here = last;
> +			}
>  			last = next;
>  		}
> +		if (not_found > 0)
> +			here = last;
>  
>  		/* Check whether we have enough space left. */
>  		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);



