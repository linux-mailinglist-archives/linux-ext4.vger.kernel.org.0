Return-Path: <linux-ext4+bounces-11833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3920C53F47
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 19:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A42B3B1732
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 18:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BE334DCCE;
	Wed, 12 Nov 2025 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF9Y5WGi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B822E34DCF4;
	Wed, 12 Nov 2025 18:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972087; cv=none; b=SkU8Yx85z8a9Dk+PFod84NQtQW20xqIjMLEazGUxNvTXCtv6NJssdmvWvuDbA6j/ks5xuOzyPr9FzzFeDBiBwy+NMFI+dzB3vRVgjueuAY5xdqG/pFJFQRoumhqky1ICihy+isxrDWwKkClM64GQeYYNIP6BtRW+TSTYy83btR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972087; c=relaxed/simple;
	bh=ekgvmpg8fuY/U25CUIq0yLJHYxpLpn6TXiTKg/kz3ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F96fLgG0/6nAFIppFmDwYhd4JbtqEnlCop1NzL+DWHqLJH0PyouB8fQ27WF1Vpcg7y6FBqrVTf52RUVlyIK0PXbtzDHieQncbbiQ84s7qiaWBZHrZWQrmPkNBsIOMiw8MYd6bXP2k+ZzV85nO87S6hOsUiOKYw550TmDLMtn2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF9Y5WGi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3D4C4CEF1;
	Wed, 12 Nov 2025 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762972087;
	bh=ekgvmpg8fuY/U25CUIq0yLJHYxpLpn6TXiTKg/kz3ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DF9Y5WGiCRzDZVPOgY4mQTgDJJAbyjJYqmPq+QWcdtD/1E/5YxjHQcRF0i8xl9lK6
	 XXC3siQeGTj1vSOpvorlUfHqYs5Xm/xAVFQy/eMxlBwjPa9Zf3ROqcbqPB1EY8dhtB
	 zd9x+diyTGnX18hmzeYQuDGFetWYEReaYh6AVDp7KkgzE3wZb1e3VLixgIVwAWvt5A
	 sWMhNLC87/YCRmG+b4mZM3tID6a7+iOSdEIvI+y/Ui8QBpIvObC/PeP7DDg9XrPCQ4
	 NSfL+t8ebi6QXv1TZ4ccwm0za4yER77RRoeXMN7SjJbjcIBDy1ntnskW13VSL1gNs4
	 f1t34LNSqHvKw==
Date: Wed, 12 Nov 2025 10:28:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Haodong Tian <tianhd25@mails.tsinghua.edu.cn>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/ext4: fix typo in comment
Message-ID: <20251112182806.GM196358@frogsfrogsfrogs>
References: <20251112155916.3007639-1-tianhd25@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251112155916.3007639-1-tianhd25@mails.tsinghua.edu.cn>

On Wed, Nov 12, 2025 at 11:59:16PM +0800, Haodong Tian wrote:
> Correct 'metdata' -> 'metadata' in comment.
> 
> Signed-off-by: Haodong Tian <tianhd25@mails.tsinghua.edu.cn>

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/ext4/balloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
> index c9329ed5c094..8040c731b3e4 100644
> --- a/fs/ext4/balloc.c
> +++ b/fs/ext4/balloc.c
> @@ -752,7 +752,7 @@ ext4_fsblk_t ext4_new_meta_blocks(handle_t *handle, struct inode *inode,
>  		*count = ar.len;
>  	/*
>  	 * Account for the allocated meta blocks.  We will never
> -	 * fail EDQUOT for metdata, but we do account for it.
> +	 * fail EDQUOT for metadata, but we do account for it.
>  	 */
>  	if (!(*errp) && (flags & EXT4_MB_DELALLOC_RESERVED)) {
>  		dquot_alloc_block_nofail(inode,
> -- 
> 2.47.3
> 
> 

