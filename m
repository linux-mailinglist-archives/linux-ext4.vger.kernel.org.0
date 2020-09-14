Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A36268745
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 10:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbgINIfP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Sep 2020 04:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:40540 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgINIfO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Sep 2020 04:35:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01E62AD60;
        Mon, 14 Sep 2020 08:35:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 47D141E12ED; Mon, 14 Sep 2020 10:35:12 +0200 (CEST)
Date:   Mon, 14 Sep 2020 10:35:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext2: Fix some kernel-doc warnings in balloc.c
Message-ID: <20200914083512.GB4863@quack2.suse.cz>
References: <20200911114036.60616-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911114036.60616-1-wanghai38@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 11-09-20 19:40:36, Wang Hai wrote:
> Fixes the following W=1 kernel build warning(s):
> 
> fs/ext2/balloc.c:203: warning: Excess function parameter 'rb_root' description in '__rsv_window_dump'
> fs/ext2/balloc.c:294: warning: Excess function parameter 'rb_root' description in 'search_reserve_window'
> fs/ext2/balloc.c:878: warning: Excess function parameter 'rsv' description in 'alloc_new_reservation'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/ext2/balloc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index fa9c951d3471..1f3f4326bf3c 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -189,7 +189,7 @@ static void group_adjust_blocks(struct super_block *sb, int group_no,
>  
>  /**
>   * __rsv_window_dump() -- Dump the filesystem block allocation reservation map
> - * @rb_root:		root of per-filesystem reservation rb tree
> + * @root:		root of per-filesystem reservation rb tree
>   * @verbose:		verbose mode
>   * @fn:			function which wishes to dump the reservation map
>   *
> @@ -282,7 +282,7 @@ goal_in_my_reservation(struct ext2_reserve_window *rsv, ext2_grpblk_t grp_goal,
>  
>  /**
>   * search_reserve_window()
> - * @rb_root:		root of reservation tree
> + * @root:		root of reservation tree
>   * @goal:		target allocation block
>   *
>   * Find the reserved window which includes the goal, or the previous one
> @@ -859,7 +859,7 @@ static int find_next_reservable_window(
>   *
>   *	failed: we failed to find a reservation window in this group
>   *
> - *	@rsv: the reservation
> + *	@my_rsv: the reservation
>   *
>   *	@grp_goal: The goal (group-relative).  It is where the search for a
>   *		free reservable space should start from.
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
