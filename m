Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8835639E13B
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Jun 2021 17:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFGPwP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Jun 2021 11:52:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55888 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhFGPwP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Jun 2021 11:52:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3D7B71FDA1;
        Mon,  7 Jun 2021 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1623081023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMFhBY6RRNhXxQSZRdv9RWVO5yhAishy3HwwjhZR/FE=;
        b=BDNtVRYLzomvaEOToypRhXc/SUkghYU5YeT2X98PLJR/AewsB2Fi7rCgt4/5uXUQT3JIaY
        SoDUbSoxSSyYzeVyWIa0WTDG7kJ09GX9+pTMrbgozIeN455mlh+TdzGqyN05WFOL75sPnO
        u/ks2PkzHqhHvJZWYm2DfE/JHNXgJnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1623081023;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pMFhBY6RRNhXxQSZRdv9RWVO5yhAishy3HwwjhZR/FE=;
        b=TuP9CamROenxjmTrMupRrYB58tMV2/4Yiiyk2LvATjcCiUN6aFKOJjNkrJ0DOeww7ZR8g6
        epvwoewElRp0uPAw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 2FA35A3B89;
        Mon,  7 Jun 2021 15:50:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 172B11F2CA8; Mon,  7 Jun 2021 17:50:23 +0200 (CEST)
Date:   Mon, 7 Jun 2021 17:50:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [RFC PATCH v3 7/8] ext4: remove bdev_try_to_free_page() callback
Message-ID: <20210607155023.GC29326@quack2.suse.cz>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-8-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527135641.420514-8-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 27-05-21 21:56:40, Zhang Yi wrote:
> After we introduce a jbd2 shrinker to release checkpointed buffer's
> journal head, we could free buffer without bdev_try_to_free_page()
> under memory pressure. So this patch remove the whole
> bdev_try_to_free_page() callback directly. It also remove many
> use-after-free issues relate to it together.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bf6d0085e1b7..b778236d06e6 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1442,26 +1442,6 @@ static int ext4_nfs_commit_metadata(struct inode *inode)
>  	return ext4_write_inode(inode, &wbc);
>  }
>  
> -/*
> - * Try to release metadata pages (indirect blocks, directories) which are
> - * mapped via the block device.  Since these pages could have journal heads
> - * which would prevent try_to_free_buffers() from freeing them, we must use
> - * jbd2 layer's try_to_free_buffers() function to release them.
> - */
> -static int bdev_try_to_free_page(struct super_block *sb, struct page *page,
> -				 gfp_t wait)
> -{
> -	journal_t *journal = EXT4_SB(sb)->s_journal;
> -
> -	WARN_ON(PageChecked(page));
> -	if (!page_has_buffers(page))
> -		return 0;
> -	if (journal)
> -		return jbd2_journal_try_to_free_buffers(journal, page);
> -
> -	return try_to_free_buffers(page);
> -}
> -
>  #ifdef CONFIG_FS_ENCRYPTION
>  static int ext4_get_context(struct inode *inode, void *ctx, size_t len)
>  {
> @@ -1656,7 +1636,6 @@ static const struct super_operations ext4_sops = {
>  	.quota_write	= ext4_quota_write,
>  	.get_dquots	= ext4_get_dquots,
>  #endif
> -	.bdev_try_to_free_page = bdev_try_to_free_page,
>  };
>  
>  static const struct export_operations ext4_export_ops = {
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
