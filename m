Return-Path: <linux-ext4+bounces-12386-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C77CC8D80
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 17:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 542583148425
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Dec 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CF358D37;
	Wed, 17 Dec 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OkXsifng"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748B535FF6E
	for <linux-ext4@vger.kernel.org>; Wed, 17 Dec 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765989322; cv=none; b=Af2hg09NMbShG7If0ggFsfxiZAOVOlK7XxKLf52MphOCDp1162OUYEkN7v34UTFLMQLqRCDeCowDvpSnL0uPDQVPXFqMe/UEMAe8irf6rcfL4JKSoqqw1EJbm+0MDd2pN9NwVkE1fJkBbVnyGfNND83NpcFjjU1dIUwyNVp1iW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765989322; c=relaxed/simple;
	bh=HgOCLvGTWJ25DrTJdaCwD2dwm3WNDk9UF3YohxIikXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKVHSb6TPM7NDucJAH9gW+w7XS4gRGIpQgyixtcX1Qk65O2lMBqFHllVrB3UKDd+VkgZw1cC1HVQul+rWHP54OZSrQiyF97nYbj7gloi0txzcMu1Fw8uZxzfPBqtrI6+BOJzEqcveFKbDrAwn5GdIDqk31FgWcceQNrgrCNkXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OkXsifng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A14C116B1;
	Wed, 17 Dec 2025 16:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765989322;
	bh=HgOCLvGTWJ25DrTJdaCwD2dwm3WNDk9UF3YohxIikXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OkXsifngxhynpuv5jSBS4hJ4BhCFwYEVjTflGJFu6H+6RWn/zhAx05Mq2vYjDBYae
	 ahM/uhaaIkUHgXq8dTbstj+TgwHCFaOmyGPgX/e7HYrZ16kSRHb5uyBywBBcj8MzXd
	 syTV0jLq577A/gHNrveiYVEyqYUB7/TgIVoSL/N7aAeFiIKJbrjV6PF0v7VN9LeFWR
	 SsIwJJpDr7l42B2ajVAlyKZCHK3aCJTuUOadeLApILCQKRi8tAolCs17eoqrsr5585
	 luUYbJlXZiPN2xY0By69Zwu0mLNUi8MUSoKi/RqtYHyIpoQIa//pRITeMSKEQanRMF
	 VMiN3NnSuwL+A==
Date: Wed, 17 Dec 2025 08:35:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Wang Jianjian <wangjianjian3@huawei.com>
Cc: tytso@mit.edu, linux-ext4@vger.kernel.org, wangjianjian0@foxmail.com
Subject: Re: [PATCH] ext4,fiemap: Add inode offset for xattr fiemap
Message-ID: <20251217163521.GO94594@frogsfrogsfrogs>
References: <20251217084708.494396-1-wangjianjian3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251217084708.494396-1-wangjianjian3@huawei.com>

On Wed, Dec 17, 2025 at 04:47:08PM +0800, Wang Jianjian wrote:
> For xattr in inode, need add inode offset in this block?
> Also, there is one problem, if we have xattrs both in inode
> and block, current implementation will only return xattr inode fiemap.
> Is this by design?

I don't think there's much value in reporting the inline xattrs via
FIEMAP because user programs can't directly access that area anyway.
The only reason (AFAICT) for reporting the external xattr block is for
building a map of lost data given a report of localized media failure.

(FIEMAP only being useful for debugging and after-the-shatter forensics)

> Signed-off-by: Wang Jianjian <wangjianjian3@huawei.com>
> ---
>  fs/ext4/extents.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2cf5759ba689..a16bfc75345d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5043,6 +5043,7 @@ static int ext4_iomap_xattr_fiemap(struct inode *inode, struct iomap *iomap)
>  		if (error)
>  			return error;
>  		physical = (__u64)iloc.bh->b_blocknr << blockbits;
> +		physical += iloc.offset;

Also it doesn't make sense to add the address of the external block to
the inode offset.

--D

>  		offset = EXT4_GOOD_OLD_INODE_SIZE +
>  				EXT4_I(inode)->i_extra_isize;
>  		physical += offset;
> -- 
> 2.34.1
> 
> 

