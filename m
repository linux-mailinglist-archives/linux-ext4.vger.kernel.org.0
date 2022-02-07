Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8785A4AC2D4
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 16:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359485AbiBGPQi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441967AbiBGOqm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 09:46:42 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FBC03FEC1;
        Mon,  7 Feb 2022 06:46:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6266E21100;
        Mon,  7 Feb 2022 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644245176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNh5UrO2grxW38SlZb3RoMz+NPhu6ub9EMH/rFUycQ0=;
        b=rISZxS6qaVofJ9ph3oN9d1EnGNCeHElNJWQxqEsBhI7bHkdZbIkjtPOhCCQQPeX31cCX6n
        XKQh/Qy39IdzefMePC0rX0lqMGP2xUUmSKvUBakM0ls0z2WOGetXWJWorYlzATzjLrpK/G
        7nY4BNmcMzImqdgXZhouzLaKWYNpkW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644245176;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gNh5UrO2grxW38SlZb3RoMz+NPhu6ub9EMH/rFUycQ0=;
        b=6u/Eh5SuLEoJXhx7JzjJULISRn9OQqWmkkWlKRO9pVPHbQyrUCzQDZRdwy8JbcsuDE4E6y
        dwVYLumd+bNyhjCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5156BA3BC1;
        Mon,  7 Feb 2022 14:46:15 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A08D5A05BC; Mon,  7 Feb 2022 15:46:12 +0100 (CET)
Date:   Mon, 7 Feb 2022 15:46:12 +0100
From:   Jan Kara <jack@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     Jan Kara <jack@suse.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ext2: remove unused pointer bdi
Message-ID: <20220207144612.zdczs7wxzbuk3ydr@quack3.lan>
References: <20220207134039.337197-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207134039.337197-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 07-02-22 13:40:39, Colin Ian King wrote:
> The call to bdi_congested has been removed and so the bdi pointer
> is no longer required. Remove it.
> 
> Fixes: 9bbab3a63d49 ("mm/fs: remove bdi_congested() and wb_congested() and related functions")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

I guess this change is in mm tree? So probably it is best if Andrew picks
it up.

								Honza

> ---
>  fs/ext2/ialloc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index d632764da240..998dd2ac8008 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -170,9 +170,6 @@ static void ext2_preread_inode(struct inode *inode)
>  	unsigned long offset;
>  	unsigned long block;
>  	struct ext2_group_desc * gdp;
> -	struct backing_dev_info *bdi;
> -
> -	bdi = inode_to_bdi(inode);
>  
>  	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
>  	gdp = ext2_get_group_desc(inode->i_sb, block_group, NULL);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
