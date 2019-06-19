Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40DF4B6B9
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbfFSLIi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 07:08:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727076AbfFSLIi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Jun 2019 07:08:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 31E38AE74;
        Wed, 19 Jun 2019 11:08:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 98D3B1E15DD; Wed, 19 Jun 2019 13:08:36 +0200 (CEST)
Date:   Wed, 19 Jun 2019 13:08:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     jinshui zhang <leozhangjs@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhangjs <zachary@baishancloud.com>
Subject: Re: [PATCH] ext4: make __ext4_get_inode_loc plug
Message-ID: <20190619110836.GC32409@quack2.suse.cz>
References: <20190617155712.51339-1-leozhangjs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617155712.51339-1-leozhangjs@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 17-06-19 23:57:12, jinshui zhang wrote:
> From: zhangjs <zachary@baishancloud.com>
> 
> If the task is unplugged when called, the inode_readahead_blks may not be merged, 
> these will cause small pieces of io, It should be plugged.
> 
> Signed-off-by: zhangjs <zachary@baishancloud.com>

Out of curiosity, on which path do you see __ext4_get_inode_loc() being
called without IO already plugged?

Otherwise the patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c7f77c6..8fe046b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4570,6 +4570,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
>  	struct buffer_head	*bh;
>  	struct super_block	*sb = inode->i_sb;
>  	ext4_fsblk_t		block;
> +	struct blk_plug		plug;
>  	int			inodes_per_block, inode_offset;
>  
>  	iloc->bh = NULL;
> @@ -4654,6 +4655,8 @@ static int __ext4_get_inode_loc(struct inode *inode,
>  		}
>  
>  make_io:
> +		blk_start_plug(&plug);
> +
>  		/*
>  		 * If we need to do any I/O, try to pre-readahead extra
>  		 * blocks from the inode table.
> @@ -4688,6 +4691,9 @@ static int __ext4_get_inode_loc(struct inode *inode,
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_read_sync;
>  		submit_bh(REQ_OP_READ, REQ_META | REQ_PRIO, bh);
> +
> +		blk_finish_plug(&plug);
> +
>  		wait_on_buffer(bh);
>  		if (!buffer_uptodate(bh)) {
>  			EXT4_ERROR_INODE_BLOCK(inode, block,
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
