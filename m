Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90AD15E687
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jul 2019 16:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfGCOZE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Jul 2019 10:25:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45764 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfGCOZE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 3 Jul 2019 10:25:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26F3BB65F;
        Wed,  3 Jul 2019 14:25:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B499B1E0D71; Wed,  3 Jul 2019 16:24:57 +0200 (CEST)
Date:   Wed, 3 Jul 2019 16:24:57 +0200
From:   Jan Kara <jack@suse.cz>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 23/30] ext2: Use kmemdup rather than duplicating its
 implementation
Message-ID: <20190703142457.GA26423@quack2.suse.cz>
References: <20190703131727.25735-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703131727.25735-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 03-07-19 21:17:27, Fuqian Huang wrote:
> kmemdup is introduced to duplicate a region of memory in a neat way.
> Rather than kmalloc/kzalloc + memset, which the programmer needs to
> write the size twice (sometimes lead to mistakes), kmemdup improves
> readability, leads to smaller code and also reduce the chances of mistakes.
> Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Thanks. Added to my tree.

								Honza

> ---
>  fs/ext2/xattr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index 1e33e0ac8cf1..a9c641cd5484 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -506,11 +506,10 @@ bad_block:		ext2_error(sb, "ext2_xattr_set",
>  
>  			unlock_buffer(bh);
>  			ea_bdebug(bh, "cloning");
> -			header = kmalloc(bh->b_size, GFP_KERNEL);
> +			header = kmemdup(HDR(bh), bh->b_size, GFP_KERNEL);
>  			error = -ENOMEM;
>  			if (header == NULL)
>  				goto cleanup;
> -			memcpy(header, HDR(bh), bh->b_size);
>  			header->h_refcount = cpu_to_le32(1);
>  
>  			offset = (char *)here - bh->b_data;
> -- 
> 2.11.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
