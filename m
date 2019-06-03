Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25E7632D7F
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 12:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfFCKFt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 06:05:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:53918 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfFCKFt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Jun 2019 06:05:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1F489ABD0;
        Mon,  3 Jun 2019 10:05:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D9A761E3C24; Mon,  3 Jun 2019 12:05:45 +0200 (CEST)
Date:   Mon, 3 Jun 2019 12:05:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@zoho.com.cn>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext2: start from parent blockgroup when trying linear
 search for a free inode
Message-ID: <20190603100545.GC27933@quack2.suse.cz>
References: <20190601084941.22792-1-cgxu519@zoho.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190601084941.22792-1-cgxu519@zoho.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 01-06-19 16:49:41, Chengguang Xu wrote:
> Start from parent blockgroup when trying linear search
> for a free indoe because for non directory inode it's
> better to keep in same blockgroup with parent.
> 
> Signed-off-by: Chengguang Xu <cgxu519@zoho.com.cn>

Thanks for the patch! As much as I agree that incrementing group before
calling ext2_get_group_desc() was probably an oversight I don't think that
changing that at this point is good. For ext2 driver we don't really care
about performance too much anymore and also existing filesystems have
inodes for files in a directory allocated in parent_group + 1 and this
change would spread them also to parent_group effectively worsening the
situation.

								Honza

> ---
>  fs/ext2/ialloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/ialloc.c b/fs/ext2/ialloc.c
> index fda7d3f5b4be..435463a255e6 100644
> --- a/fs/ext2/ialloc.c
> +++ b/fs/ext2/ialloc.c
> @@ -411,11 +411,11 @@ static int find_group_other(struct super_block *sb, struct inode *parent)
>  	 */
>  	group = parent_group;
>  	for (i = 0; i < ngroups; i++) {
> -		if (++group >= ngroups)
> -			group = 0;
>  		desc = ext2_get_group_desc (sb, group, NULL);
>  		if (desc && le16_to_cpu(desc->bg_free_inodes_count))
>  			goto found;
> +		if (++group >= ngroups)
> +			group = 0;
>  	}
>  
>  	return -1;
> -- 
> 2.17.2
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
