Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0DD39E13C
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbhFGPwe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 11:52:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55926 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhFGPwd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 11:52:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 99F461FDA1;
        Mon,  7 Jun 2021 15:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623081041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdAI8zOWdrCkFvSAot0ZZEwI8O/JY3phcBaRqs/8Hv4=;
        b=aXw6kprcUNtWi3KMFwrcYEEpQkpQuGZg3UNRtrgzablDRsbFqUvB99jEwyT3kgrrRgGOWO
        gwNGIRRG6QSsSgVf+mkknJhhGywI8/7QetLrCOhYhWxm8lSZJ35lt61V9vGN1YiE0UK6sE
        rhxhUH3QRaoWjV0D9pqNgCvc1utHIHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623081041;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdAI8zOWdrCkFvSAot0ZZEwI8O/JY3phcBaRqs/8Hv4=;
        b=EESHHR44QJV7nagD21ZRmB8zvS0rpOpDhofZPASI6T77n3vCn82EhDPUqu86L+17qudzux
        AaIM3KlhUVetVMAQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 7C1EAA3B85;
        Mon,  7 Jun 2021 15:50:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 301781F2CA8; Mon,  7 Jun 2021 17:50:41 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:50:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 8/8] fs: remove bdev_try_to_free_page callback
Message-ID: <20210607155041.GD29326@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-9-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-9-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:41, Zhang Yi wrote:
> After remove the unique user of sop->bdev_try_to_free_page() callback,
> we could remove the callback and the corresponding blkdev_releasepage()
> at all.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/block_dev.c     | 15 ---------------
>  include/linux/fs.h |  1 -
>  2 files changed, 16 deletions(-)
> 
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index 6cc4d4cfe0c2..e215da6d49b4 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -1733,20 +1733,6 @@ ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  }
>  EXPORT_SYMBOL_GPL(blkdev_read_iter);
>  
> -/*
> - * Try to release a page associated with block device when the system
> - * is under memory pressure.
> - */
> -static int blkdev_releasepage(struct page *page, gfp_t wait)
> -{
> -	struct super_block *super = BDEV_I(page->mapping->host)->bdev.bd_super;
> -
> -	if (super && super->s_op->bdev_try_to_free_page)
> -		return super->s_op->bdev_try_to_free_page(super, page, wait);
> -
> -	return try_to_free_buffers(page);
> -}
> -
>  static int blkdev_writepages(struct address_space *mapping,
>  			     struct writeback_control *wbc)
>  {
> @@ -1760,7 +1746,6 @@ static const struct address_space_operations def_blk_aops = {
>  	.write_begin	= blkdev_write_begin,
>  	.write_end	= blkdev_write_end,
>  	.writepages	= blkdev_writepages,
> -	.releasepage	= blkdev_releasepage,
>  	.direct_IO	= blkdev_direct_IO,
>  	.migratepage	= buffer_migrate_page_norefs,
>  	.is_dirty_writeback = buffer_check_dirty_writeback,
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c3c88fdb9b2a..c3277b445f96 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2171,7 +2171,6 @@ struct super_operations {
>  	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
>  	struct dquot **(*get_dquots)(struct inode *);
>  #endif
> -	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);
>  	long (*nr_cached_objects)(struct super_block *,
>  				  struct shrink_control *);
>  	long (*free_cached_objects)(struct super_block *,
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
