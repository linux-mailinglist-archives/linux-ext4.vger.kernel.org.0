Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6961B1B5A07
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Apr 2020 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgDWLH3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Apr 2020 07:07:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:47046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDWLH3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Apr 2020 07:07:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8C0D8B08C;
        Thu, 23 Apr 2020 11:07:27 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 75D621E1293; Thu, 23 Apr 2020 13:07:27 +0200 (CEST)
Date:   Thu, 23 Apr 2020 13:07:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     tytso@mit.edu, jack@suse.cz, linux-ext4@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH v2] ext4: fix error pointer dereference
Message-ID: <20200423110727.GG3737@quack2.suse.cz>
References: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587628004-95123-1-git-send-email-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 23-04-20 15:46:44, Jeffle Xu wrote:
> Don't pass error pointers to brelse().
> 
> commit 7159a986b420 ("ext4: fix some error pointer dereferences") has fixed
> some cases, fix the remaining one case.
> 
> Once ext4_xattr_block_find()->ext4_sb_bread() failed, error pointer is
> stored in @bs->bh, which will be passed to brelse() in the cleanup
> routine of ext4_xattr_set_handle(). This will then cause a NULL panic
> crash in __brelse().
> 
> BUG: unable to handle kernel NULL pointer dereference at 000000000000005b
> RIP: 0010:__brelse+0x1b/0x50
> Call Trace:
>  ext4_xattr_set_handle+0x163/0x5d0
>  ext4_xattr_set+0x95/0x110
>  __vfs_setxattr+0x6b/0x80
>  __vfs_setxattr_noperm+0x68/0x1b0
>  vfs_setxattr+0xa0/0xb0
>  setxattr+0x12c/0x1a0
>  path_setxattr+0x8d/0xc0
>  __x64_sys_setxattr+0x27/0x30
>  do_syscall_64+0x60/0x250
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> In this case, @bs->bh stores '-EIO' actually.
> 
> Fixes: fb265c9cb49e ("ext4: add ext4_sb_bread() to disambiguate ENOMEM cases")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: stable@kernel.org # 2.6.19

Thanks for the patch! It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/xattr.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 21df43a..01ba663 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1800,8 +1800,11 @@ struct ext4_xattr_block_find {
>  	if (EXT4_I(inode)->i_file_acl) {
>  		/* The inode already has an extended attribute block. */
>  		bs->bh = ext4_sb_bread(sb, EXT4_I(inode)->i_file_acl, REQ_PRIO);
> -		if (IS_ERR(bs->bh))
> -			return PTR_ERR(bs->bh);
> +		if (IS_ERR(bs->bh)) {
> +			error = PTR_ERR(bs->bh);
> +			bs->bh = NULL;
> +			return error;
> +		}
>  		ea_bdebug(bs->bh, "b_count=%d, refcount=%d",
>  			atomic_read(&(bs->bh->b_count)),
>  			le32_to_cpu(BHDR(bs->bh)->h_refcount));
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
