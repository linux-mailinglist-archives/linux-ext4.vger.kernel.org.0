Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B55FA58
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jul 2019 16:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbfGDOzR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Jul 2019 10:55:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:47306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727314AbfGDOzR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 4 Jul 2019 10:55:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63872AD69;
        Thu,  4 Jul 2019 14:55:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C90FD1E3F56; Thu,  4 Jul 2019 16:55:14 +0200 (CEST)
Date:   Thu, 4 Jul 2019 16:55:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     tytso@mit.edu, Jan Kara <jack@suse.com>, houtao1@huawei.com,
        miaoxie@huawei.com, yi.zhang@huawei.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix warning when turn on dioread_nolock and
 inline_data
Message-ID: <20190704145514.GC31037@quack2.suse.cz>
References: <1562244632-134963-1-git-send-email-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562244632-134963-1-git-send-email-yangerkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 04-07-19 20:50:32, yangerkun wrote:
> mkfs.ext4 -O inline_data /dev/vdb
> mount -o dioread_nolock /dev/vdb /mnt
> echo "some inline data..." >> /mnt/test-file
> echo "some inline data..." >> /mnt/test-file
> sync
> 
> With upon script, system will trigger
> "WARN_ON(!io_end->handle && sbi->s_journal)" since the wrong order
> between rsv_blocks calculate and destroy inline data for dealloc.

Thanks for the patch! Good catch! I'd just rephrase the last paragraph as:

The above script will trigger "WARN_ON(!io_end->handle && sbi->s_journal)"
because ext4_should_dioread_nolock() returns false for a file with inline
data. Move the check to a place after we have already removed the inline
data and prepared inode to write normal pages.

Otherwise the patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>
> ---
>  fs/ext4/inode.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index c7f77c6..3f2a366 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2769,15 +2769,6 @@ static int ext4_writepages(struct address_space *mapping,
>  		goto out_writepages;
>  	}
>  
> -	if (ext4_should_dioread_nolock(inode)) {
> -		/*
> -		 * We may need to convert up to one extent per block in
> -		 * the page and we may dirty the inode.
> -		 */
> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> -						PAGE_SIZE >> inode->i_blkbits);
> -	}
> -
>  	/*
>  	 * If we have inline data and arrive here, it means that
>  	 * we will soon create the block for the 1st page, so
> @@ -2796,6 +2787,15 @@ static int ext4_writepages(struct address_space *mapping,
>  		ext4_journal_stop(handle);
>  	}
>  
> +	if (ext4_should_dioread_nolock(inode)) {
> +		/*
> +		 * We may need to convert up to one extent per block in
> +		 * the page and we may dirty the inode.
> +		 */
> +		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
> +						PAGE_SIZE >> inode->i_blkbits);
> +	}
> +
>  	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>  		range_whole = 1;
>  
> -- 
> 2.7.4
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
