Return-Path: <linux-ext4+bounces-3534-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7D1941F04
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 19:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C994D1F237AA
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 17:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6120189B86;
	Tue, 30 Jul 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKPCU0jk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460EA1A76C9;
	Tue, 30 Jul 2024 17:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722361883; cv=none; b=Esi3Mo3GRiCW/f1cf5BoWGTZPoRUmumkqbumZf0Ql48ueOxHB8x1pZH1PS5K9CFEywrbeZp853gWVFD6j23kIAT1+VkPNo8eqUCeAN7Sb87woHofKMKiCCNmlYuKLVQjvOPrezmEoEgHPHTADi5bTqMGubLg0A1/aFLLM8UeP2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722361883; c=relaxed/simple;
	bh=fDB5YBjDRgQVsrkSaiPwTDINLMLNz6nMQx97q/bF8vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsMQfJGUkDz4hRgwKFa42hzrkzoqsbLuxH2cFue/1/7v1eqeg3pPDgPl0g5nqG/XUXxalnKeth66cNp7zyYULq3VhkQJwFnIXFFT0K0i8iXifVi4Nla/kqY3N8NpAbZSr+EhIoVqG49fzguwg3iQwwsIV4AuRol7VMvZCfthZfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKPCU0jk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6436C32782;
	Tue, 30 Jul 2024 17:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722361882;
	bh=fDB5YBjDRgQVsrkSaiPwTDINLMLNz6nMQx97q/bF8vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKPCU0jkCRJUJEDuzwfJdhyQYXcCclcfB78/jM0BEVvmGhFn+B+lB0KQoE3c+HMiM
	 EuGBSPUNay61btW/wsBnkdUQolT6BXVV1Ri8A9X1QAKhrVjg7IXxWD8tG1OjkOBLX0
	 Qo8bQ7xtTXsRPx+KhbmMNhnWB1mcVdOZDcAFeju3cyuKwLseLRzEkp469716JSX6jH
	 If0eMkmTHCEFC717TkD4TWGtLG/hHXNY2p1ABLIblGdEIiS9FvDHy8lT8Dj1dHrpGu
	 dLPcwjuJA3J3rEnrVFSzx1ceORbykOZEOijnhf1mrk+nXEu04sbtdQ7t7faN4itpxI
	 qXKs+tourFxwg==
Date: Tue, 30 Jul 2024 10:51:22 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, gustavoars@kernel.org,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
Message-ID: <202407301050.44292F8@keescook>
References: <20240730172301.231867-4-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730172301.231867-4-thorsten.blum@toblux.com>

On Tue, Jul 30, 2024 at 07:23:04PM +0200, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Remove the now obsolete comment on the count field.
> 
> Refactor ext4_expand_inode_array() by assigning count before copying any
> data using memcpy(). Copy only the inodes array instead of the whole
> struct because count has been set explicitly.
> 
> Use struct_size() and struct_size_t() instead of offsetof().
> 
> Change the data type of the local variable count to unsigned int to
> match the struct's count data type.
> 
> Compile-tested only.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
> Changes in v2:
> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
> - Use struct_size() and struct_size_t() instead of offsetof()
> - Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/
> ---
>  fs/ext4/xattr.c | 20 +++++++++-----------
>  fs/ext4/xattr.h |  4 ++--
>  2 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 46ce2f21fef9..b27543587103 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2879,11 +2879,10 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
>  	if (*ea_inode_array == NULL) {
>  		/*
>  		 * Start with 15 inodes, so it fits into a power-of-two size.
> -		 * If *ea_inode_array is NULL, this is essentially offsetof()
>  		 */
>  		(*ea_inode_array) =
> -			kmalloc(offsetof(struct ext4_xattr_inode_array,
> -					 inodes[EIA_MASK]),
> +			kmalloc(struct_size_t(struct ext4_xattr_inode_array,

This can be struct_size(*ea_inode_array, ...) too, like you have below.

> +					      inodes, EIA_MASK),
>  				GFP_NOFS);
>  		if (*ea_inode_array == NULL)
>  			return -ENOMEM;
> @@ -2891,17 +2890,16 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
>  	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
>  		/* expand the array once all 15 + n * 16 slots are full */
>  		struct ext4_xattr_inode_array *new_array = NULL;
> -		int count = (*ea_inode_array)->count;
> +		unsigned int count = (*ea_inode_array)->count;
>  
> -		/* if new_array is NULL, this is essentially offsetof() */
> -		new_array = kmalloc(
> -				offsetof(struct ext4_xattr_inode_array,
> -					 inodes[count + EIA_INCR]),
> -				GFP_NOFS);
> +		new_array = kmalloc(struct_size(*ea_inode_array, inodes,
> +						count + EIA_INCR),
> +				    GFP_NOFS);
>  		if (new_array == NULL)
>  			return -ENOMEM;
> -		memcpy(new_array, *ea_inode_array,
> -		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
> +		new_array->count = count;
> +		memcpy(new_array->inodes, (*ea_inode_array)->inodes,
> +		       count * sizeof(struct inode *));
>  		kfree(*ea_inode_array);
>  		*ea_inode_array = new_array;
>  	}
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index bd97c4aa8177..e14fb19dc912 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
>  };
>  
>  struct ext4_xattr_inode_array {
> -	unsigned int count;		/* # of used items in the array */
> -	struct inode *inodes[];
> +	unsigned int count;
> +	struct inode *inodes[] __counted_by(count);
>  };
>  
>  extern const struct xattr_handler ext4_xattr_user_handler;

Thanks for the reworking!

-- 
Kees Cook

