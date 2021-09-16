Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F348F40D443
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Sep 2021 10:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbhIPIG0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Sep 2021 04:06:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34454 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhIPIG0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Sep 2021 04:06:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B408E22335;
        Thu, 16 Sep 2021 08:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631779505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVENeIY7NAsYPQTSoq53oPlwiVkAb+aTeVYsy6Rj4jk=;
        b=hUIfCoU9/AQVinfQgawSW+mRfMbzkKX9hNX4z6p/GF1tX0g7mup4qf8TXkqY5zToUwNaS/
        VKi50h9E6JgDu9jmUro4+W5y9qvHst8ux9aeMzf2IcV2EJBn3sdcHDg3i7QfyPGvdOo7sb
        rDGs9TCE7eVmOz/fbXEoxkdZvu/mgSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631779505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hVENeIY7NAsYPQTSoq53oPlwiVkAb+aTeVYsy6Rj4jk=;
        b=V6KtDAS0/v3G1tkrbqRgqSzFfh0ylkDq499Gb38wRbAC4JM8fc1LCVLr/ukMCOukp236Tp
        p47kUTu3XmfA94CA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 9B140A3BA2;
        Thu, 16 Sep 2021 08:05:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 009F51E0C04; Thu, 16 Sep 2021 10:05:04 +0200 (CEST)
Date:   Thu, 16 Sep 2021 10:05:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: recheck buffer uptodate bit under buffer lock
Message-ID: <20210916080504.GA10610@quack2.suse.cz>
References: <20210910080316.70421-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910080316.70421-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-09-21 16:03:16, Zhang Yi wrote:
> Commit 8e33fadf945a ("ext4: remove an unnecessary if statement in
> __ext4_get_inode_loc()") forget to recheck buffer's uptodate bit again
> under buffer lock, which may overwrite the buffer if someone else have
> already brought it uptodate and changed it.
> 
> Fixes: 8e33fadf945a ("ext4: remove an unnecessary if statement in __ext4_get_inode_loc()")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Oh, right. Thanks for fixing this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d18852d6029c..236adc647eb0 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4340,6 +4340,12 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		goto has_buffer;
>  
>  	lock_buffer(bh);
> +	if (ext4_buffer_uptodate(bh)) {
> +		/* Someone brought it uptodate while we waited */
> +		unlock_buffer(bh);
> +		goto has_buffer;
> +	}
> +
>  	/*
>  	 * If we have all information of the inode in memory and this
>  	 * is the only valid inode in the block, we need not read the
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
