Return-Path: <linux-ext4+bounces-2911-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AB0911926
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 06:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1201C21AB3
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F4D127B62;
	Fri, 21 Jun 2024 04:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WckyVk4m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41A64A;
	Fri, 21 Jun 2024 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718942451; cv=none; b=ez91nriU9UlZ1SoTlcOpBqxZBW+WeIMWjy0UiraW5ACTlWbc87Bb8CnBIjSx2E2KjGrRwGBERqvxZP2z8Exdf7XH/tCUJRoW8GeUxB8ExBuUtoYw4ZVZcz0et6BovM7W9u6wQu8UJqYJ4fgCz45UgD9ljXNpaBAhBrU5hMPq8Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718942451; c=relaxed/simple;
	bh=0gRzCASFCY1Kn+4FJRcIOdf3t1D+lzKakEDtONaj4LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVn4g9PXaASLFHi9/xYm3Jx1y+iTVrL7uF50WlZzfQGmxdh87upahCFh3OsDZSoS31xmIknVCR8ySjmYQEABBOwHOVZaR3akklSFnpUoEOarF4ciH3DPltMgOSmurPnSrdzqtkysewu/6aU2DaP6ywtAIv6SDQthB8qxZiDcuRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WckyVk4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BFAC2BBFC;
	Fri, 21 Jun 2024 04:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718942451;
	bh=0gRzCASFCY1Kn+4FJRcIOdf3t1D+lzKakEDtONaj4LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WckyVk4m0I2/OxIZLsFfP3HdE177xdPaupeglEibxzxQW0X4oGk3//gp86xvFmse9
	 kADtvsn+ABcmalLA0Z3sxZ+uzmP9J+qNoO7rIIioA0w4enWDzu9AaWW32kwp70bdDi
	 HTRWw+dJRP8mqUDXwmxfNfw+LBot7vUbtHff1CP+IQm4BAFo1NctVJWP5nEJJTgNZg
	 AefYxpWDkBtj7IhNJaGZa8RUy7ge6AH5e/aJxUIfy1mN4ATTgcsAgYJvsP5s9ArftL
	 ORXzhcWdxkwsxE8MZNsS+FHNmTDJr7TDnjt1RGuTldUsMY/bJ8IaTX9xV56mk+NjBs
	 8lm/LatYKwazw==
Date: Thu, 20 Jun 2024 21:00:49 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Norbert =?utf-8?B?S2FtacWEc2tp?= <norbert.kaminski@infogain.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+aeb14e2539ffb6d21130@syzkaller.appspotmail.com
Subject: Re: [PATCH] fs/ext4: Prevent encryption/decryption of unaligned
 blocks in aes_encrypt
Message-ID: <20240621040049.GA4362@sol.localdomain>
References: <20240613134825.53238-1-norbert.kaminski@infogain.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240613134825.53238-1-norbert.kaminski@infogain.com>

On Thu, Jun 13, 2024 at 03:48:25PM +0200, Norbert Kamiński wrote:
> syzbot is reporting an uninitialized value in aes_encrypt(). The block
> cipher expects the bytes to encrypt or decrypt to be a multiple of the
> cipher’s block size. However, when ext4_write_begin() is called and new
> folios are allocated, they might not be aligned to the required block
> size.

While the length of file content blocks does need to be a multiple of
FSCRYPT_CONTENTS_ALIGNMENT bytes, this has nothing to do with the syzbot report
that this patch is trying to fix, and this is always the case in ext4 anyway.

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4bae9ccf5fe0..965f790a9d36 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -1156,6 +1156,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
>  	 * the folio (if needed) without using GFP_NOFS.
>  	 */
>  retry_grab:
> +	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> +		mapping_set_gfp_mask(mapping,
> +				     mapping_gfp_mask(mapping) | __GFP_ZERO);
>  	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
>  					mapping_gfp_mask(mapping));
>  	if (IS_ERR(folio))
> @@ -2882,6 +2885,9 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	}
>  
>  retry:
> +	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> +		mapping_set_gfp_mask(mapping,
> +				     mapping_gfp_mask(mapping) | __GFP_ZERO);

No, it's not acceptable to force all pagecache pages to be zeroized in ext4
without opting into init_on_alloc.  This is also the wrong place to set the
mapping's gfp_mask, as the mapping has already been activated.

What actually needs to be done is root-cause this bug and fix the underlying
cause.  It looks like somehow data got marked as valid in the pagecache without
being initialized, which is never supposed to happen.

- Eric

