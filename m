Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2EA1F507C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jun 2020 10:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFJIpR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Jun 2020 04:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:33316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgFJIpQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 10 Jun 2020 04:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 035CEAC52;
        Wed, 10 Jun 2020 08:45:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A001A1E1283; Wed, 10 Jun 2020 10:45:14 +0200 (CEST)
Date:   Wed, 10 Jun 2020 10:45:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: fix missing percpu_counter_inc (fwd)
Message-ID: <20200610084514.GC12551@quack2.suse.cz>
References: <alpine.LRH.2.02.2006091312530.31685@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006091312530.31685@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 09-06-20 13:14:18, Mikulas Patocka wrote:
> I'm resending this because I didn't get any response.

I'm sorry far that. The patch got buried in my inbox... I've queued it up
now. Thanks!

								Honza

> ---------- Forwarded message ----------
> Date: Mon, 20 Apr 2020 16:02:21 -0400 (EDT)
> From: Mikulas Patocka <mpatocka@redhat.com>
> To: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org
> Subject: [PATCH] ext2: fix missing percpu_counter_inc
> 
> sbi->s_freeinodes_counter is only decreased by the ext2 code, it is never
> increased. This patch fixes it.
> 
> Note that sbi->s_freeinodes_counter is only used in the algorithm that
> tries to find the group for new allocations, so this bug is not easily
> visible (the only visibility is that the group finding algorithm selects
> inoptinal result).
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: stable@vger.kernel.org
> 
> ---
>  fs/ext2/ialloc.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/fs/ext2/ialloc.c
> ===================================================================
> --- linux-2.6.orig/fs/ext2/ialloc.c	2019-09-20 14:39:07.951999000 +0200
> +++ linux-2.6/fs/ext2/ialloc.c	2020-04-20 21:33:26.389999000 +0200
> @@ -80,6 +80,7 @@ static void ext2_release_inode(struct su
>  	if (dir)
>  		le16_add_cpu(&desc->bg_used_dirs_count, -1);
>  	spin_unlock(sb_bgl_lock(EXT2_SB(sb), group));
> +	percpu_counter_inc(&EXT2_SB(sb)->s_freeinodes_counter);
>  	if (dir)
>  		percpu_counter_dec(&EXT2_SB(sb)->s_dirs_counter);
>  	mark_buffer_dirty(bh);
> @@ -528,7 +529,7 @@ got:
>  		goto fail;
>  	}
>  
> -	percpu_counter_add(&sbi->s_freeinodes_counter, -1);
> +	percpu_counter_dec(&sbi->s_freeinodes_counter);
>  	if (S_ISDIR(mode))
>  		percpu_counter_inc(&sbi->s_dirs_counter);
>  
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
