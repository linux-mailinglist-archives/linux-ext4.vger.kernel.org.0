Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C774A8020
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 09:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbiBCIGv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 03:06:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:53666 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiBCIGu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 03:06:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AF4211F3A8;
        Thu,  3 Feb 2022 08:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643875609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/sNOeN4jj6ccVoCuEbZqorSHsEWu+h4B6ItBS/74BY=;
        b=GKRftJcBwGEcS683kmNo1SEmU0CKbCynklXUKbnKG3Rva4p8fhBurPBs5WUjplvh7uY6oe
        vSVDncBvEszJzyBz50I9127wccD9CSSztYiVsBBtRF98NFQQDmWRM6zWYQNmAvGzKR3IWR
        GdGBVJq0yw382W1Qm2cTPgRrKG/MWL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643875609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/sNOeN4jj6ccVoCuEbZqorSHsEWu+h4B6ItBS/74BY=;
        b=xHhPow6Ow3t4jpHN4xzGga41Kc5o2GDgPjX5f1nhU9wQ+Az9oST3bGPGRw3VNmWb1Lr1XQ
        pn359lw2GUgLneCw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A0788A3B81;
        Thu,  3 Feb 2022 08:06:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4E948A05B6; Thu,  3 Feb 2022 09:06:49 +0100 (CET)
Date:   Thu, 3 Feb 2022 09:06:49 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/fs: remove variable bdi set but not used
Message-ID: <20220203080649.5q4c7rvowwgf4ssp@quack3.lan>
References: <20220203052633.54000-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203052633.54000-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 03-02-22 13:26:33, Yang Li wrote:
> The code that uses the pointer 'bdi' has been removed in commit:
> '37c32ade079f000c8e539730f254b14fae0d3b49' and inode_to_bdi() doesn't
> change 'inode', so the declaration and assignment of 'bdi' can be removed.
> 
> Eliminate the following clang warning:
> fs/ext2/ialloc.c:173:27: warning: variable 'bdi' set but not used
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

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
> 2.20.1.7.g153144c
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
