Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9D92C09B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 May 2019 09:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE1HwP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 May 2019 03:52:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfE1HwP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 May 2019 03:52:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24A2DB022;
        Tue, 28 May 2019 07:52:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ADD2A1E3C0C; Tue, 28 May 2019 09:52:13 +0200 (CEST)
Date:   Tue, 28 May 2019 09:52:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: code cleanup for ext2_preread_inode()
Message-ID: <20190528075213.GA9607@quack2.suse.cz>
References: <20190528053231.12364-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528053231.12364-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 28-05-19 13:32:31, Chengguang Xu wrote:
> Calling bdi_rw_congested() instead of calling
> bdi_read_congested() and bdi_write_congested().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks! Applied.

							Honza

> ---
>  fs/ext2/ialloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index a0c5ea91fcd4..334dea4e499d 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -172,9 +172,7 @@ static void ext2_preread_inode(struct inode *inode)
>  	struct backing_dev_info *bdi;
>  
>  	bdi = inode_to_bdi(inode);
> -	if (bdi_read_congested(bdi))
> -		return;
> -	if (bdi_write_congested(bdi))
> +	if (bdi_rw_congested(bdi))
>  		return;
>  
>  	block_group = (inode->i_ino - 1) / EXT2_INODES_PER_GROUP(inode->i_sb);
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
