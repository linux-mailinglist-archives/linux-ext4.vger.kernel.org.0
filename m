Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E201F1EB819
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jun 2020 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFBJNx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jun 2020 05:13:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgFBJNw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 2 Jun 2020 05:13:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1B677AB64;
        Tue,  2 Jun 2020 09:13:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 509481E1282; Tue,  2 Jun 2020 11:13:51 +0200 (CEST)
Date:   Tue, 2 Jun 2020 11:13:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext2: propagate errors up to ext2_find_entry()'s callers
Message-ID: <20200602091351.GD19165@quack2.suse.cz>
References: <20200601134222.37235-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601134222.37235-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 01-06-20 21:42:22, zhangyi (F) wrote:
> The same to commit <36de928641ee4> (ext4: propagate errors up to
> ext4_find_entry()'s callers') in ext4, also return error instead of NULL
> pointer in case of some error happens in ext2_find_entry() (e.g. -ENOMEM
> or -EIO). This could avoid a negative dentry cache entry installed even
> it failed to read directory block due to IO error.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
>  fs/ext2/dir.c   | 62 +++++++++++++++++++++++++------------------------
>  fs/ext2/ext2.h  |  3 ++-
>  fs/ext2/namei.c | 28 ++++++++++++++++++----
>  3 files changed, 58 insertions(+), 35 deletions(-)
> 
> diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
> index 13318e255ebf..1c3ab60890b1 100644
> --- a/fs/ext2/dir.c
> +++ b/fs/ext2/dir.c
> @@ -347,8 +347,7 @@ struct ext2_dir_entry_2 *ext2_find_entry (struct inode *dir,
>  	unsigned long npages = dir_pages(dir);
>  	struct page *page = NULL;
>  	struct ext2_inode_info *ei = EXT2_I(dir);
> -	ext2_dirent * de;
> -	int dir_has_error = 0;
> +	ext2_dirent *de, *ret = NULL;

I don't think you need additional 'ret' variable and it does not improve
the readability of the code either... You can just use 'de' all the time.

Otherwise the patch looks good. I'd also note that all callers of
ext2_find_entry() except for ext2_inode_by_name() transform de == NULL to
-ENOENT so it would be a good followup cleanup to return -ENOENT directly
from ext2_find_entry(). Also ext2_inode_by_name() could just pass -ENOENT
further since only ext2_lookup() needs to actually transform this -ENOENT
to calling d_splice_alias() with NULL inode.

Thanks for the patch!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
