Return-Path: <linux-ext4+bounces-7011-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C71A75064
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD4518930EA
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 18:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EB71DEFEC;
	Fri, 28 Mar 2025 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uN9kn+pM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4449D1C8615
	for <linux-ext4@vger.kernel.org>; Fri, 28 Mar 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186568; cv=none; b=mc7oeELhPCjpQDUUE03ohm4g056ArP7JA9n9L/qC+jAEwWvUQIwV3OWWaol5u1DdKKbFrFJ0V6dznI0eT/uYECHr/vsqUb8b22kGB5mAQbJQsmkGbO1KUfTK55I95BrIhbMOB4f6TSwLktkTWcMlvdK8Wg8KFBsYcA/ziHxJHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186568; c=relaxed/simple;
	bh=R4WLChsmbZ8xUp244YW02q5tm4jeuZm+/2yO+YsE7z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gulxFzmoJQCINiz6gyYqwb6qT6ct0lYoiVdNk0Zx0XfIbYgCLpai/oykt8nDruZJUDqW6kfV6wozeNJI9aMxzciu8glHpp7RIEs7dVVnmFPayUlXhXlv+Ki/tLPZ1ftWUnDKcwIGeVlIbN1iUypAsAUPZ8MpE3clgArBfrmt5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uN9kn+pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA7FC4CEE4;
	Fri, 28 Mar 2025 18:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743186567;
	bh=R4WLChsmbZ8xUp244YW02q5tm4jeuZm+/2yO+YsE7z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uN9kn+pMdRyyGsCCwtJgxJBlWwoubkZ/Ay3WNDz8+n4ACKHdK0Qu1Nyo357TeDpRC
	 /JbuTd9HFljpyU5woMmBKrb9E/A17Eo+hlSa4yeL4NtY7Frne3xAQCX1D1zMUVboT/
	 DMAPC5qENM63/MnLKSORuXdpdB1bYJbvaZOuNsdtVCLZI4xnWK0x3rCc3QUtymB8G3
	 3LP7p6pOX8aNfPURXcUmzueQICkWe7SolPnsbkJAGZUG4mS4Xl5uKjsulcSmLV0u/R
	 Hw5rYF/XelHOAiedwg5wsK3oVR2GZdX1Mmi67gO9tGklluaWXClLMHGwOqSquGUubv
	 7MaPVK3z5GiPA==
Date: Fri, 28 Mar 2025 11:29:27 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] ext2: remove buffer heads from group
 descriptors
Message-ID: <20250328182927.GE2803723@frogsfrogsfrogs>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
 <20250326014928.61507-3-catherine.hoang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326014928.61507-3-catherine.hoang@oracle.com>

On Tue, Mar 25, 2025 at 06:49:26PM -0700, Catherine Hoang wrote:
> The group descriptors are stored as an array of buffer_heads
> s_group_desc in struct ext2_sb_info. Replace these buffer heads with the
> new ext2_buffer and update the buffer functions accordingly.
> 
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
>  fs/ext2/balloc.c | 24 ++++++++++++------------
>  fs/ext2/ext2.h   |  4 ++--
>  fs/ext2/ialloc.c | 12 ++++++------
>  fs/ext2/super.c  | 10 +++++-----
>  4 files changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index b8cfab8f98b9..21dafa9ae2ea 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -38,7 +38,7 @@
>  
>  struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
>  					     unsigned int block_group,
> -					     struct buffer_head ** bh)
> +					     struct ext2_buffer ** buf)
>  {
>  	unsigned long group_desc;
>  	unsigned long offset;
> @@ -63,8 +63,8 @@ struct ext2_group_desc * ext2_get_group_desc(struct super_block * sb,
>  	}
>  
>  	desc = (struct ext2_group_desc *) sbi->s_group_desc[group_desc]->b_data;
> -	if (bh)
> -		*bh = sbi->s_group_desc[group_desc];
> +	if (buf)
> +		*buf = sbi->s_group_desc[group_desc];

Yeah, these patches would be less long if you'd stuck with the "bh"
name.  I hate how this sounds like busy work, but please put it back to
make reviewing easier.

> @@ -1109,10 +1109,10 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	}
>  	for (i = 0; i < db_count; i++) {
>  		block = descriptor_loc(sb, logic_sb_block, i);
> -		sbi->s_group_desc[i] = sb_bread(sb, block);
> +		sbi->s_group_desc[i] = ext2_read_buffer(sb, block);

ext2_read_buffer can return an ERR_PTR, you need to check for errors
here, not just null pointers.

--D

