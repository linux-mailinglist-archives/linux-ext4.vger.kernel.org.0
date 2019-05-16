Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954401FD02
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 03:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfEPBqh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 21:46:37 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25943 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726580AbfEPBOA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 May 2019 21:14:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1557969227; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=gxLfazM6U39H0EerEH7mpfBVWJbp6/qkhV7yBhKbWXKJeWhRAZSDv5CPAt4ygXGmgYjgqYP32FH+9udCZIQXmzx6D7xSJV259mM1DMdq0v0+byWpyAVNmW1EBTH5dH08FxvQyU9YEATjo7348Rlvxcxx9g8vx9SIyzyh/kLunmA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1557969227; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:References:Subject:To:ARC-Authentication-Results; 
        bh=lt64Im3MAfWyXP/AetiFnsStHLb2QjMqY7o6IDxn4sk=; 
        b=hY1u7n+2zG6+IcEe1wZHnnCBFKcREbSu6w/PpeaFZ6F5pEynZ06Jt2A253ql7oYnKiniJa3Rg6FmdHPg8dk1u0pbv0AnXxxtbyTaJqh+knS1s87Q+KnaglB0w0btIeNB2prXHdMZ04mknXHSuU6aEYR5hVEYbAabBIRiNbhRxnU=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=zoho.com.cn;
        spf=pass  smtp.mailfrom=cgxu519@zoho.com.cn;
        dmarc=pass header.from=<cgxu519@zoho.com.cn> header.from=<cgxu519@zoho.com.cn>
Received: from hades (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1557969225407162.07974578306607; Thu, 16 May 2019 09:13:45 +0800 (CST)
Message-ID: <6340e88cfb57aadef737ba882d342cd922555a95.camel@zoho.com.cn>
Subject: Re: [PATCH 2/3] ext2: Merge loops in ext2_xattr_set()
From:   "cgxu519@zoho.com.cn" <cgxu519@zoho.com.cn>
Reply-To: cgxu519@zoho.com.cn
To:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Date:   Thu, 16 May 2019 09:13:34 +0800
In-Reply-To: <20190515140144.1183-3-jack@suse.cz>
References: <20190515140144.1183-1-jack@suse.cz>
         <20190515140144.1183-3-jack@suse.cz>
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
> There are two very similar loops when searching xattr to set. Just merge
> them.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext2/xattr.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index fb2e008d4406..26a049ca89fb 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -437,27 +437,7 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  			goto cleanup;
>  		}
>  		/* Find the named attribute. */
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
> +		last = FIRST_ENTRY(bh);
>  		while (!IS_LAST_ENTRY(last)) {
>  			struct ext2_xattr_entry *next = EXT2_XATTR_NEXT(last);
>  			if ((char *)next >= end)
> @@ -467,8 +447,18 @@ ext2_xattr_set(struct inode *inode, int name_index, const
> char *name,
>  				if (offs < min_offs)
>  					min_offs = offs;
>  			}
> +			if (not_found) {
> +				if (name_index == last->e_name_index &&
> +				    name_len == last->e_name_len &&
> +				    !memcmp(name, last->e_name,name_len)) {
> +					not_found = 0;
> +					here = last;
> +				}
> +			}
>  			last = next;
>  		}
> +		if (not_found)
> +			here = last;

Entry name is sorted so I think for new entry we should find right place for it
not just appending to last.

Thanks,
Chengguang

>  
>  		/* Check whether we have enough space left. */
>  		free = min_offs - ((char*)last - (char*)header) - sizeof(__u32);



