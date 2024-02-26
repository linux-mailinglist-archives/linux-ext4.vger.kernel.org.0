Return-Path: <linux-ext4+bounces-1385-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7E86694E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 05:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF161F22DB6
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Feb 2024 04:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A2C1B270;
	Mon, 26 Feb 2024 04:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lVtO//zl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965EE18EA1
	for <linux-ext4@vger.kernel.org>; Mon, 26 Feb 2024 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921346; cv=none; b=f0lsyBD/KJeaiZbKUjvqENZJd80VgMIQcwxnmQ8HJx88EGFbctk6fYU2htApHE2iSy+lW7x+yv/7yPam9MXV2CKG/heUxP5WppkHPIFQRW61s8htCLFrdiXqNSPRqg3QihYdHubCKSZUImIxPwxXFkfQ9xk8lNbXem5q3Md3ZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921346; c=relaxed/simple;
	bh=RgfQE/2D1DcMpey08Nd9CYj209z2ybghPP4CILv+ubQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qeOxZ4T1wNNb33JS+yfdm4wTkW5gBZ4fCGWSgXZg2JKLXcEC0YwcXGtUs0mXEbyvpd8nj00Z6Udx+KHfIjmJtvKUrWFKge8eD9V/33bR1QVkp/45hPX0MrR+ro7BqriaZkfdfd8aXUxVw8Y68eQ3VsmYtqhPrtjS0tozyqLY5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lVtO//zl; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dd9abbd7-56af-4654-83ae-741d41493f5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708921341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1JSBKAC57cp8w/tmE/XKxptpPiKoJ0VG+X8vxxgNIu4=;
	b=lVtO//zlJWvJVvJt7NwyLtFBcW3cD4e/vXq1kFN1WZP/nDZuA1zZ1xzjG/rXUje7ya0IcT
	24F6FT8wLdRJ6pyB4W7UrN5ExjDl/aHDgxarOQFr4xHXSIH+gnNxe+MVrqYzHTmwBkYWAV
	y3f4NJFgHoF5qnWNNZPmDaFgZV1HoSk=
Date: Mon, 26 Feb 2024 12:22:04 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ext4: remove SLAB_MEM_SPREAD flag usage
Content-Language: en-US
To: tytso@mit.edu, adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, vbabka@suse.cz,
 roman.gushchin@linux.dev, Xiongwei.Song@windriver.com
References: <20240224134822.829456-1-chengming.zhou@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240224134822.829456-1-chengming.zhou@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/2/24 21:48, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.

Update changelog to make it clearer:

The SLAB_MEM_SPREAD flag used to be implemented in SLAB, which was
removed as of v6.8-rc1, so it became a dead flag since the commit
16a1d968358a ("mm/slab: remove mm/slab.c and slab_def.h"). And the
series[1] went on to mark it obsolete to avoid confusion for users.
Here we can just remove all its users, which has no functional change.

[1] https://lore.kernel.org/all/20240223-slab-cleanup-flags-v2-1-02f1753e8303@suse.cz/

Thanks!

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  fs/ext4/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index eb689fb85ce9..9a744f22aa24 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1500,8 +1500,7 @@ static int __init init_inodecache(void)
>  {
>  	ext4_inode_cachep = kmem_cache_create_usercopy("ext4_inode_cache",
>  				sizeof(struct ext4_inode_info), 0,
> -				(SLAB_RECLAIM_ACCOUNT|SLAB_MEM_SPREAD|
> -					SLAB_ACCOUNT),
> +				SLAB_RECLAIM_ACCOUNT|SLAB_ACCOUNT,
>  				offsetof(struct ext4_inode_info, i_data),
>  				sizeof_field(struct ext4_inode_info, i_data),
>  				init_once);

