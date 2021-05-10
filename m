Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6718E378128
	for <lists+linux-ext4@lfdr.de>; Mon, 10 May 2021 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhEJKWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 May 2021 06:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230093AbhEJKWs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 10 May 2021 06:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2653FADDB;
        Mon, 10 May 2021 10:21:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 900A31F2C5C; Mon, 10 May 2021 12:21:42 +0200 (CEST)
Date:   Mon, 10 May 2021 12:21:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: cleanup in-core orphan list if ext4_truncate()
 failed to get a transaction handle
Message-ID: <20210510102142.GD11100@quack2.suse.cz>
References: <20210507071904.160808-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507071904.160808-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 07-05-21 15:19:04, Zhang Yi wrote:
> In ext4_orphan_cleanup(), if ext4_truncate() failed to get a transaction
> handle, it didn't remove the inode from the in-core orphan list, which
> may probably trigger below error dump in ext4_destroy_inode() during the
> final iput() and could lead to memory corruption on the later orphan
> list changes.
> 
>  EXT4-fs (sda): Inode 6291467 (00000000b8247c67): orphan list check failed!
>  00000000b8247c67: 0001f30a 00000004 00000000 00000023  ............#...
>  00000000e24cde71: 00000006 014082a3 00000000 00000000  ......@.........
>  0000000072c6a5ee: 00000000 00000000 00000000 00000000  ................
>  ...
> 
> This patch fix this by cleanup in-core orphan list manually if
> ext4_truncate() return error.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Thanks! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/ext4/super.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7dc94f3e18e6..12850d72e9a4 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3101,8 +3101,15 @@ static void ext4_orphan_cleanup(struct super_block *sb,
>  			inode_lock(inode);
>  			truncate_inode_pages(inode->i_mapping, inode->i_size);
>  			ret = ext4_truncate(inode);
> -			if (ret)
> +			if (ret) {
> +				/*
> +				 * We need to clean up the in-core orphan list
> +				 * manually if ext4_truncate() failed to get a
> +				 * transaction handle.
> +				 */
> +				ext4_orphan_del(NULL, inode);
>  				ext4_std_error(inode->i_sb, ret);
> +			}
>  			inode_unlock(inode);
>  			nr_truncates++;
>  		} else {
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
