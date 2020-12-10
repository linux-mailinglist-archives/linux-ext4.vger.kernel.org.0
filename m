Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446BE2D61E5
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 17:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392210AbgLJQFE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 11:05:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:51824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391491AbgLJQFD (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 10 Dec 2020 11:05:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FCE3AF22;
        Thu, 10 Dec 2020 16:04:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EFC9C1E1354; Thu, 10 Dec 2020 17:04:19 +0100 (CET)
Date:   Thu, 10 Dec 2020 17:04:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix an IS_ERR() vs NULL check
Message-ID: <20201210160419.GA31725@quack2.suse.cz>
References: <20201023112232.GB282278@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023112232.GB282278@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 23-10-20 14:22:32, Dan Carpenter wrote:
> The ext4_find_extent() function never returns NULL, it returns error
> pointers.
> 
> Fixes: 44059e503b03 ("ext4: fast commit recovery path")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

I think this fix has fallen through the cracks? It looks good to me so feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 6b33b9c86b00..a19d0e3a4126 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5820,8 +5820,8 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  	int ret;
>  
>  	path = ext4_find_extent(inode, start, NULL, 0);
> -	if (!path)
> -		return -EINVAL;
> +	if (IS_ERR(path))
> +		return PTR_ERR(path);
>  	ex = path[path->p_depth].p_ext;
>  	if (!ex) {
>  		ret = -EFSCORRUPTED;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
