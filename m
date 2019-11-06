Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7DE0F1AAE
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Nov 2019 17:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFQBY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Nov 2019 11:01:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:42060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727074AbfKFQBY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 6 Nov 2019 11:01:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAD8EB195;
        Wed,  6 Nov 2019 16:01:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B641C1E4353; Wed,  6 Nov 2019 17:01:22 +0100 (CET)
Date:   Wed, 6 Nov 2019 17:01:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 5/5] ext2: fix improper function comment
Message-ID: <20191106160122.GD12685@quack2.suse.cz>
References: <20191104114036.9893-1-cgxu519@mykernel.net>
 <20191104114036.9893-5-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104114036.9893-5-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-11-19 19:40:36, Chengguang Xu wrote:
> Just fix a improper function comment.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks, applied! I've also fixed @group_first_block as that should be
@start_block.

								Honza

> ---
>  fs/ext2/balloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 9a9bd566243d..4180467122d0 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -749,7 +749,7 @@ ext2_try_to_allocate(struct super_block *sb, int group,
>   *		but we will shift to the place where start_block is,
>   *		then start from there, when looking for a reservable space.
>   *
> - * 	@size: the target new reservation window size
> + *	@sb: the super block.
>   *
>   * 	@group_first_block: the first block we consider to start
>   *			the real search from
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
