Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D9641E959
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352856AbhJAJGg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 05:06:36 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47740 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbhJAJGf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 05:06:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05B07225D5;
        Fri,  1 Oct 2021 09:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633079091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5uzHLEC30ivf7w1v+Q6NrEVtgUgARTvSe/5p6RmJZY=;
        b=1Yw3YvDH3u+x7NdMC1XJQMKmpJluU4OIRwb1bAqIAxihcQfdl2lbgS9zUyf2sc2TzWm65o
        TjO7wXbzQuuL0PPOfKmftC5OMb8GMiL790ZNaELav5bdHK9Xd+ASq7LE6/qTZUR7QDQ1En
        p1wndg08ZBleNAP1BXvUveWgg8fPz2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633079091;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j5uzHLEC30ivf7w1v+Q6NrEVtgUgARTvSe/5p6RmJZY=;
        b=wN8j8v2yGIPuaPyIAIIIcVbEnu/MeBphobemHwzIPPQoSMFvk3+0p8JxVoOA8NfTZPdZNR
        IBuF82PAnWm9A6AA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id ED598A3B83;
        Fri,  1 Oct 2021 09:04:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 96C441F2BA4; Fri,  1 Oct 2021 11:04:50 +0200 (CEST)
Date:   Fri, 1 Oct 2021 11:04:50 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        yukuai3@huawei.com
Subject: Re: [PATCH 1/2] ext4: avoid recheck extent for EXT4_EX_FORCE_CACHE
Message-ID: <20211001090450.GA28799@quack2.suse.cz>
References: <20210904044946.2102404-1-yangerkun@huawei.com>
 <20210904044946.2102404-2-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210904044946.2102404-2-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 04-09-21 12:49:45, yangerkun wrote:
> Buffer with verified means that it has been checked before. No need
> verify and call set_buffer_verified again.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index cbf37b2cf871..8559e288472f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -505,13 +505,16 @@ __read_extent_tree_block(const char *function, unsigned int line,
>  		if (err < 0)
>  			goto errout;
>  	}
> -	if (buffer_verified(bh) && !(flags & EXT4_EX_FORCE_CACHE))
> -		return bh;
> -	err = __ext4_ext_check(function, line, inode,
> -			       ext_block_hdr(bh), depth, pblk);
> -	if (err)
> -		goto errout;
> -	set_buffer_verified(bh);
> +	if (buffer_verified(bh)) {
> +		if (!(flags & EXT4_EX_FORCE_CACHE))
> +			return bh;
> +	} else {
> +		err = __ext4_ext_check(function, line, inode,
> +				       ext_block_hdr(bh), depth, pblk);
> +		if (err)
> +			goto errout;
> +		set_buffer_verified(bh);
> +	}
>  	/*
>  	 * If this is a leaf block, cache all of its entries
>  	 */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
