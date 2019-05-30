Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DF2FAF9
	for <lists+linux-ext4@lfdr.de>; Thu, 30 May 2019 13:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfE3Lfv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 May 2019 07:35:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726065AbfE3Lfu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 May 2019 07:35:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F18EAEFF;
        Thu, 30 May 2019 11:35:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0D28E1E3C08; Thu, 30 May 2019 13:35:47 +0200 (CEST)
Date:   Thu, 30 May 2019 13:35:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: add missing brelse() in ext2_new_inode()
Message-ID: <20190530113547.GD29237@quack2.suse.cz>
References: <20190530101042.32197-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530101042.32197-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 30-05-19 18:10:42, Chengguang Xu wrote:
> There is a missing brelse of bitmap_bh in an error
> path of ext2_new_inode().
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the fix! Applied.

								Honza
> ---
>  fs/ext2/ialloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index 334dea4e499d..fda7d3f5b4be 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -509,6 +509,7 @@ struct inode *ext2_new_inode(struct inode *dir, umode_t mode,
>  	/*
>  	 * Scanned all blockgroups.
>  	 */
> +	brelse(bitmap_bh);
>  	err = -ENOSPC;
>  	goto fail;
>  got:
> -- 
> 2.20.1
> 
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
