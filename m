Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56915E00AA
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2019 11:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfJVJ0A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Oct 2019 05:26:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:50542 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728182AbfJVJ0A (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 22 Oct 2019 05:26:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0C21B78C;
        Tue, 22 Oct 2019 09:25:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0E2EB1E4812; Tue, 22 Oct 2019 11:25:55 +0200 (CEST)
Date:   Tue, 22 Oct 2019 11:25:55 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext2: add missing brelse in ext2_new_blocks()
Message-ID: <20191022092555.GH2436@quack2.suse.cz>
References: <20191022091738.9160-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022091738.9160-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 22-10-19 17:17:38, Chengguang Xu wrote:
> There is a missing brelse of bitmap_bh in the
> case of retry.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. Patch applied with small update to the comment - this can also hit
in case our reservation window was alredy full.

								Honza

> ---
> v1->v2:
> - Add comment to explain why the fix is needed.
> 
>  fs/ext2/balloc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index 924c1c765306..18e75adcd2f6 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -1313,6 +1313,13 @@ ext2_fsblk_t ext2_new_blocks(struct inode *inode, ext2_fsblk_t goal,
>  	if (free_blocks > 0) {
>  		grp_target_blk = ((goal - le32_to_cpu(es->s_first_data_block)) %
>  				EXT2_BLOCKS_PER_GROUP(sb));
> +		/*
> +		 * In a special case that allocated blocks are in system zone,
> +		 * we will retry block allocation due to failing to pass sanity
> +		 * check. In this case, the bitmap_bh is non-null pointer and we
> +		 * have to release it before calling read_block_bitmap().
> +		 */
> +		brelse(bitmap_bh);
>  		bitmap_bh = read_block_bitmap(sb, group_no);
>  		if (!bitmap_bh)
>  			goto io_error;
> -- 
> 2.20.1
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
