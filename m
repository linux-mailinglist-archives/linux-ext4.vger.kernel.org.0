Return-Path: <linux-ext4+bounces-3949-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB333963693
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 02:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B8AB22532
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 00:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885166125;
	Thu, 29 Aug 2024 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI/qA/xE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD294C70;
	Thu, 29 Aug 2024 00:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724889829; cv=none; b=Y9c0YHDo93oUMdueijVpDkxsK99BRmEKyxbL8Qgt4c+Wf7JSzt/DFaKXoAlm/plm9hbI+r/2dZZCip237zS2Z3NdXZ6jfJ3zJU7rPYoqS2AIXTWrZCvMwH5rcBFQFY/G5/ykkuZZLL612kSIkIvGDqnne/dEJxBKbAN28zhq+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724889829; c=relaxed/simple;
	bh=YRzZj+qOQt5LVym2qM7ljAW6DcULKkZkh7UhrHxT+aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1aMpnsyjkZkk7DDnj5TE5kqCdTo33mFeAhRDZ4aWCWEqKZxKSZQt70olh7zLqzrEgBZwOz6Sq5ijeZSCDTe9jXqKN5tki2P4s9wLOaOn+/P1z+HyXtqQoNn8SfMv7zhqyc61H5deilXZDbyx4SpeUjXzun5ynWGG+mALtu+jyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI/qA/xE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4FEC4CEC6;
	Thu, 29 Aug 2024 00:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724889828;
	bh=YRzZj+qOQt5LVym2qM7ljAW6DcULKkZkh7UhrHxT+aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pI/qA/xEws7tz/ezKuQDPsTW+mTz6bw0xDaMNM0uvH0TSmMkQIjyx9sOsu4Lz6C44
	 suTCpsKEcKnoHkqXzFDbCUMBVKwcogzra8qjBwZA5++NDgVgpf5feZKR5UKzMtvIM+
	 TIGBOac6lPiOHF/WqHg+8/GC/AiRl5elwqVZVD1drB2JUxvtRsFD0hQbgpYqmf7I1S
	 kL6LTP5KB4gHwhm2HbxWE0PoUYXrJxlTuQm1e1qZzVlGn9nehYD+kC/mlL4VipInQW
	 bDl3wSG1XKtdGqD1cJh9QLcQdKq8OD70mps7Xs2wQCxGhJj6o6LVg/Gg4pr/Wp5ux1
	 DQx/i8TsjVv2w==
Date: Thu, 29 Aug 2024 00:03:46 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 1/2] ext4: hoist ext4_block_write_begin and replace the
 __block_write_begin
Message-ID: <20240829000346.GC558903@google.com>
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
 <20240823013329.1996741-2-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240823013329.1996741-2-zhangshida@kylinos.cn>

On Fri, Aug 23, 2024 at 09:33:28AM +0800, zhangshida wrote:
> From: Shida Zhang <zhangshida@kylinos.cn>
> 
> Using __block_write_begin() make it inconvenient to journal the
> user data dirty process. We can't tell the block layer maintainer,
> ‘Hey, we want to trace the dirty user data in ext4, can we add some
> special code for ext4 in __block_write_begin?’:P
> 
> So use ext4_block_write_begin() instead.
> 
> The two functions are basically doing the same thing except for the
> fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION so as
> to allow ext4_block_write_begin() to function like __block_write_begin
> when the config is disabled.
> And hoist the ext4_block_write_begin so that it can be used in other
> files.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> ---
>  fs/ext4/ext4.h   |  2 ++
>  fs/ext4/inline.c | 10 +++++-----
>  fs/ext4/inode.c  | 23 ++++++-----------------
>  3 files changed, 13 insertions(+), 22 deletions(-)

Thanks for cleaning this up.

There are still some comments in fs/ext4/inode.c that reference
__block_write_begin.  Can you update them too?

One more thing below.

> @@ -1119,7 +1118,9 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  	}
>  	if (unlikely(err)) {
>  		folio_zero_new_buffers(folio, from, to);
> -	} else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> +	}
> +#ifdef CONFIG_FS_ENCRYPTION
> +	else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
>  		for (i = 0; i < nr_wait; i++) {
>  			int err2;
>  
> @@ -1131,10 +1132,10 @@ static int ext4_block_write_begin(struct folio *folio, loff_t pos, unsigned len,
>  			}
>  		}
>  	}
> +#endif

This #ifdef isn't necessary since fscrypt_inode_uses_fs_layer_crypto() returns
false (and it's known at compile time) when !CONFIG_FS_ENCRYPTION.

- Eric

