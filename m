Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D71213A68
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jul 2020 14:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgGCMzn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jul 2020 08:55:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:49006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgGCMzn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 3 Jul 2020 08:55:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C09CCAD1E;
        Fri,  3 Jul 2020 12:55:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3495B1E12EB; Fri,  3 Jul 2020 14:55:42 +0200 (CEST)
Date:   Fri, 3 Jul 2020 14:55:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: fix some incorrect comments in inode.c
Message-ID: <20200703125542.GA21364@quack2.suse.cz>
References: <20200703124411.24085-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703124411.24085-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 03-07-20 20:44:11, Chengguang Xu wrote:
> There are some incorrect comments in inode.c, so fix them
> properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks, I've added the patch to my tree.

								Honza

> ---
> v1->v2:
> - Fix incorrect comment for ext2_blks_to_allocate() instead of
> deleting it.
> - Fix incorrect comment for ext2_alloc_blocks().
> 
>  fs/ext2/inode.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> index c8b371c82b4f..80662e1f7889 100644
> --- a/fs/ext2/inode.c
> +++ b/fs/ext2/inode.c
> @@ -356,8 +356,7 @@ static inline ext2_fsblk_t ext2_find_goal(struct inode *inode, long block,
>   *	@blks: number of data blocks to be mapped.
>   *	@blocks_to_boundary:  the offset in the indirect block
>   *
> - *	return the total number of blocks to be allocate, including the
> - *	direct and indirect blocks.
> + *	return the number of direct blocks to allocate.
>   */
>  static int
>  ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
> @@ -390,11 +389,9 @@ ext2_blks_to_allocate(Indirect * branch, int k, unsigned long blks,
>   *	ext2_alloc_blocks: multiple allocate blocks needed for a branch
>   *	@indirect_blks: the number of blocks need to allocate for indirect
>   *			blocks
> - *
> + *	@blks: the number of blocks need to allocate for direct blocks
>   *	@new_blocks: on return it will store the new block numbers for
>   *	the indirect blocks(if needed) and the first direct block,
> - *	@blks:	on return it will store the total number of allocated
> - *		direct blocks
>   */
>  static int ext2_alloc_blocks(struct inode *inode,
>  			ext2_fsblk_t goal, int indirect_blks, int blks,
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
