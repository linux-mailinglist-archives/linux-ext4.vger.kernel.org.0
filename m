Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2134FDA7
	for <lists+linux-ext4@lfdr.de>; Wed, 31 Mar 2021 12:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhCaJ7s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 Mar 2021 05:59:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:58666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234932AbhCaJ7W (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 31 Mar 2021 05:59:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0416EAE5C;
        Wed, 31 Mar 2021 09:59:21 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A41CD1E4415; Wed, 31 Mar 2021 11:59:20 +0200 (CEST)
Date:   Wed, 31 Mar 2021 11:59:20 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: do not set SB_ACTIVE in ext4_orphan_cleanup()
Message-ID: <20210331095920.GF30749@quack2.suse.cz>
References: <20210331033138.918975-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331033138.918975-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 31-03-21 11:31:38, Zhang Yi wrote:
> When CONFIG_QUOTA is enabled, if we failed to mount the filesystem due
> to some error happens behind ext4_orphan_cleanup(), it will end up
> triggering a after free issue of super_block. The problem is that
> ext4_orphan_cleanup() will set SB_ACTIVE flag if CONFIG_QUOTA is
> enabled, after we cleanup the truncated inodes, the last iput() will put
> them into the lru list, and these inodes' pages may probably dirty and
> will be write back by the writeback thread, so it could be raced by
> freeing super_block in the error path of mount_bdev().
> 
> After check the setting of SB_ACTIVE flag in ext4_orphan_cleanup(), it
> was used to ensure updating the quota file properly, but evict inode and
> trash data immediately in the last iput does not affect the quotafile,
> so setting the SB_ACTIVE flag seems not required[1]. Fix this issue by
> just remove the SB_ACTIVE setting.

Thanks for the patch. Let me rephrase the changelog a little:

When CONFIG_QUOTA is enabled and if we later fail to finish mounting the
filesystem due to some error after ext4_orphan_cleanup(), we may hit use
after free issues. The problem is that ext4_orphan_cleanup() sets SB_ACTIVE
flag and so inodes processed during the orphan cleanup are put to the
superblock's LRU list instead of being immediately destroyed. However the
path handling error recovery after failed ->fill_super() call does not
destroy inodes attached to the superblock and so they are left active in
memory while the superblock is freed.

Originally, SB_ACTIVE setting was added so that updated quota information
is not destroyed when we drop quota inode references after orphan cleanup.
However VFS does not purge dirty inode pages without SB_ACTIVE flag for many
years already. So just remove the hack with setting SB_ACTIVE flag from
ext4_orphan_cleanup().

Also feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> [1] https://lore.kernel.org/linux-ext4/99cce8ca-e4a0-7301-840f-2ace67c551f3@huawei.com/T/#m04990cfbc4f44592421736b504afcc346b2a7c00
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Tested-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..2a33c53b57d8 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3023,9 +3023,6 @@ static void ext4_orphan_cleanup(struct super_block *sb,
>  		sb->s_flags &= ~SB_RDONLY;
>  	}
>  #ifdef CONFIG_QUOTA
> -	/* Needed for iput() to work correctly and not trash data */
> -	sb->s_flags |= SB_ACTIVE;
> -
>  	/*
>  	 * Turn on quotas which were not enabled for read-only mounts if
>  	 * filesystem has quota feature, so that they are updated correctly.
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
