Return-Path: <linux-ext4+bounces-8016-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B22ABBFF5
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462DB1B626D2
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB62B27935B;
	Mon, 19 May 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6PfRF78"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B427FD40;
	Mon, 19 May 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747662739; cv=none; b=AiRZXaoZGMm8zxUPfDOzrFkkrcSTVIefT8y77Sl6taJq9YuUqVupoI5CbE5Yk+HKDGkYYq+pIPPH3u0DMtPEde9efF0JQWZTzLZMN+4e2hvWCpG8G/rCWEjYB2rPX2tNDk4C9+dNKmBbg7c6CKwV3fFDE1pxzZKj3KlMRh8U2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747662739; c=relaxed/simple;
	bh=s0l9iW5KbP0oGFXHuUopMWX9GgpNakrOf3mX2mmZPdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gCHt0Jb54awFSM26hmfN1TpsFjYQPP4g1DdW3h8tBL8dvwCSpfj5lMEmcnNYOp2RCQPFXHoPIE8BIUn763s4VwQbV0q48+1BnjsXOrfxPzKu53EbqFnSz0u3K8SEA6A8VNCEyRZeJnJB2bNh7yh//xjzkIW3Tzg5JKFkc0L0WYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6PfRF78; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A28C4CEE4;
	Mon, 19 May 2025 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747662737;
	bh=s0l9iW5KbP0oGFXHuUopMWX9GgpNakrOf3mX2mmZPdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6PfRF78+nFF4s8WR0BjPyklkba+iUPaDHORSi+0smpSxInC2zZIOKgIMGqfVa8km
	 IcP56CPWlXY8lAR5uOXT+PCNUbf7Y3gOBbhijentbVd5HlaAWPKZT37Q4ciAbgA8D2
	 qep/QHachguy4h0T9tqsiLjAyLYDN6ITsyokZBABxTIIc4GadJVY2ExJqNJQ4kSfQ8
	 zFrfIMjL7kmQZVDdpTarewd8VVTS8TNHyIN9EUad4+B7OxsjT/Jurgwnq4fXJFNJKM
	 iusLK9+p68gb0ahhQwxkMAKaoQQkPAjTSTM0GNWFtXTqEG0nnJyJgg8VcT5dpS+CEl
	 OVc5rCufc+BDw==
Date: Mon, 19 May 2025 06:52:13 -0700
From: Kees Cook <kees@kernel.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <202505190651.943F729@keescook>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>

On Sun, May 18, 2025 at 11:54:21PM -0400, Ethan Carter Edwards wrote:
> strcpy() is deprecated; assignment can be used instead which
> theoretically/potentially increases speed as a function call is removed.
> 
> Straight assignment works because the strings are not null-terminated
> which means they don't strictly require a str(s)cpy call.
> 
> No functional changes intended.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> ---
> There's an ongoing effort to remove calls to strcpy throughout the
> kernel.
> 
> Link: https://github.com/KSPP/linux/issues/88
> ---
> Changes in v2:
> - completely remove the call to strcpy and replace it with assignment
>   off of Theo's suggestion. Thanks.
> - Link to v1: https://lore.kernel.org/r/20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com
> ---
>  fs/ext4/inline.c | 4 ++--
>  fs/ext4/namei.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 2c9b762925c72f2ff5a402b02500370bc1eb0eb1..f3bc8b3904a8a9b55162f002b5bd63a527b290a5 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
>  		if (pos == 0) {
>  			fake.inode = cpu_to_le32(inode->i_ino);
>  			fake.name_len = 1;
> -			strcpy(fake.name, ".");
> +			fake.name[0] = ".";

This means the trailing NUL byte isn't being copied any more? That seems
like a big change, even if name_len is being used for length tracking.

-- 
Kees Cook

