Return-Path: <linux-ext4+bounces-4961-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3363F9BCA9F
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 11:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE8928676D
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 10:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D4D1D2B26;
	Tue,  5 Nov 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DJ+zfkDs"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218921D27B1;
	Tue,  5 Nov 2024 10:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730803172; cv=none; b=hbzSQcAVKE+BkiW9heRGxzAGZ+fI4IFj3TIy0J33xIz9DTtMZOAay01kEg71x6IawddXPQ5Oa9sOApAJC3/zDtjAklYJKyIcd0WwTlIY97a1IQmIaNoKYF3kN0QV4frX1GC1DRc0Z6P94+YB0ymkRk62bPfKpC0hvekLXjgYIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730803172; c=relaxed/simple;
	bh=IFKg3EsAvQ1VaRerxmIvvfabiwCBdZgnja2Q5JB+bPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ASW1Vx204GNSuQ07/WUVp4gsRkCWiL/wg8kaLiYt3GXxYsM64Qr2eSC5X8FBT2+z6O+RHvWnQ7RpTXwzGG1RuE8sY0luca7b96ZhxLgqw6k9Z8Gt57e93aIVNTIO70E8Vi6snKIMB0tYED3gUTabqZ32Y6+uZplGMznwi1Ftrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DJ+zfkDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40853C4CED0;
	Tue,  5 Nov 2024 10:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730803171;
	bh=IFKg3EsAvQ1VaRerxmIvvfabiwCBdZgnja2Q5JB+bPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ+zfkDsT7uYfjMgkT5tgNOrNEyuH2aDPuvbwS4PdCikr4ovvufVFgs2nEYJ3pI/Z
	 kAX1SEr8L/7GtGZUvWKxKVyDag9/UrVO9lZyMBQ3x92OHoboUoMGe4NVp6XBs+4VMK
	 G1g5M4UYO2TIT8Fq3haezdoObMKG/sGQMXyk1uu0=
Date: Tue, 5 Nov 2024 11:39:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Use struct_size() to improve
 ext4_htree_store_dirent()
Message-ID: <2024110539-frugality-glutton-58f0@gregkh>
References: <20241105103353.11590-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105103353.11590-2-thorsten.blum@linux.dev>

On Tue, Nov 05, 2024 at 11:33:54AM +0100, Thorsten Blum wrote:
> Inline and use struct_size() to calculate the number of bytes to
> allocate for new_fn and remove the local variable len.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> This change was originally part of another patch that was split into two
> separate patches after feedback from Greg KH
> - Link: https://lore.kernel.org/r/20241104234214.8094-2-thorsten.blum@linux.dev/
> ---
>  fs/ext4/dir.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
> index 233479647f1b..02d47a64e8d1 100644
> --- a/fs/ext4/dir.c
> +++ b/fs/ext4/dir.c
> @@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
>  	struct rb_node **p, *parent = NULL;
>  	struct fname *fname, *new_fn;
>  	struct dir_private_info *info;
> -	int len;
>  
>  	info = dir_file->private_data;
>  	p = &info->root.rb_node;
>  
>  	/* Create and allocate the fname structure */
> -	len = sizeof(struct fname) + ent_name->len + 1;
> -	new_fn = kzalloc(len, GFP_KERNEL);
> +	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
> +			 GFP_KERNEL);

Does this actually matter and make the code any more robust or faster?

The original code here is easier to read and understand, why add
complexity if it is not required?

thanks,

greg k-h

