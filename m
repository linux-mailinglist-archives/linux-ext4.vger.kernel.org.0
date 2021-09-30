Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5755B41DE75
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Sep 2021 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbhI3QMS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 12:12:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43172 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348067AbhI3QMR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 12:12:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62842225DD;
        Thu, 30 Sep 2021 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633018234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpddWotJDEB20/Y8A/qQAdI2vVsD5aWSl/LVh8iF40Q=;
        b=AQpU9JqLN/6kfwXY/TPDPw/NKaapn93qDicLYPiHxZyG74b/weHuUemBVpuOJblhXYXjCb
        YIi0hPhJX8+hKB7on/HpM6rL3GN0Igfk4kPFQbQEZpjzJYjur/ws36wGt0/zdda2bf/nKV
        661upQ5LxQe9nx2W4/i9RxepvsCPXPQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633018234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpddWotJDEB20/Y8A/qQAdI2vVsD5aWSl/LVh8iF40Q=;
        b=lE5GxDlFwdD/mmUGdzFoqUOZLj02OkCHLkdAY0FwZVi04dfngCUg0dKxbL5WzY0YMPT4D9
        52AhZz4dAvKHiEDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 4D1AFA3B81;
        Thu, 30 Sep 2021 16:10:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DC0781F2BA4; Thu, 30 Sep 2021 18:10:30 +0200 (CEST)
Date:   Thu, 30 Sep 2021 18:10:30 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 1/3] ext4: correct the left/middle/right debug message
 for binsearch
Message-ID: <20210930161030.GA17404@quack2.suse.cz>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
 <20210903062748.4118886-2-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903062748.4118886-2-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-09-21 14:27:46, yangerkun wrote:
> The debuginfo for binsearch want to show the left/middle/right extent
> while the process search for the goal block. However we show this info
> after we change right or left.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c33e0a2cb6c3..7ae32078b48f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -713,13 +713,14 @@ ext4_ext_binsearch_idx(struct inode *inode,
>  	r = EXT_LAST_INDEX(eh);
>  	while (l <= r) {
>  		m = l + (r - l) / 2;
> +		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
> +			  le32_to_cpu(l->ei_block), m, le32_to_cpu(m->ei_block),
> +			  r, le32_to_cpu(r->ei_block));
> +
>  		if (block < le32_to_cpu(m->ei_block))
>  			r = m - 1;
>  		else
>  			l = m + 1;
> -		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
> -			  le32_to_cpu(l->ei_block), m, le32_to_cpu(m->ei_block),
> -			  r, le32_to_cpu(r->ei_block));
>  	}
>  
>  	path->p_idx = l - 1;
> @@ -781,13 +782,14 @@ ext4_ext_binsearch(struct inode *inode,
>  
>  	while (l <= r) {
>  		m = l + (r - l) / 2;
> +		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
> +			  le32_to_cpu(l->ee_block), m, le32_to_cpu(m->ee_block),
> +			  r, le32_to_cpu(r->ee_block));
> +
>  		if (block < le32_to_cpu(m->ee_block))
>  			r = m - 1;
>  		else
>  			l = m + 1;
> -		ext_debug(inode, "%p(%u):%p(%u):%p(%u) ", l,
> -			  le32_to_cpu(l->ee_block), m, le32_to_cpu(m->ee_block),
> -			  r, le32_to_cpu(r->ee_block));
>  	}
>  
>  	path->p_ext = l - 1;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
