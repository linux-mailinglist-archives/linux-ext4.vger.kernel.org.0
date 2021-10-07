Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE2A42551F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241937AbhJGORT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 10:17:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56752 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhJGORR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 10:17:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0144222536;
        Thu,  7 Oct 2021 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633616123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFMJH9cjoNNkanu2nS+bPYZOud1m0KHzHexWhpyQvEs=;
        b=yonKk2B3+rCxghzoRgDE0fup5nfkd1Drw3MOB6Y9xCf22dcg1ggq2EH3JtkEt47WHlMNz5
        d0s/yuKQ+qvo40BO2Oj7C/D2bcL9u9VcIvs2YU/T8ZqujLYLuV2b2sIQ15IY402gYsSQSD
        F/BhzprGq8uAV6pdqETmP7f+5UIAv5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633616123;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tFMJH9cjoNNkanu2nS+bPYZOud1m0KHzHexWhpyQvEs=;
        b=hK5A9VRlN9LYhNf7mIOs7pU99Jv+mTfBhG1o+Xcl7ULyoI4kwVoAXYZz97mfECTDLptWZx
        2Hln5Q67UPlxTKCg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E5F64A3B85;
        Thu,  7 Oct 2021 14:15:22 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C86BA1F2C96; Thu,  7 Oct 2021 16:15:22 +0200 (CEST)
Date:   Thu, 7 Oct 2021 16:15:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chenyuan Mi <cymi20@fudan.edu.cn>
Cc:     yuanxzhang@fudan.edu.cn, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix refcount leak bug in __ext4_new_inode()
Message-ID: <20211007141522.GB2670@quack2.suse.cz>
References: <20210908024605.16857-1-cymi20@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908024605.16857-1-cymi20@fudan.edu.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 08-09-21 10:46:05, Chenyuan Mi wrote:
> After successfully creating handle by __ext4_journal_start_sb(),
> the function forgets to decrease the refcount of handle in several
> paths, causing refcount leak.
> 
> Fix this issue by recording a flag when successfully getting handle
> by __ext4_journal_start_sb(), and decrease the refcount of handle
> when exiting this function if holding the flag.
> 
> Signed-off-by: Chenyuan Mi <cymi20@fudan.edu.cn>
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

I'm sorry but this patch is wrong. We are expected to return with handle
running from __ext4_new_inode(). Please have a look into callers of
ext4_new_inode() and ext4_new_inode_start_handle() how they use and then
stop the handle. And similarly as for the second patch I'd note that even a
small amount of testing would show you that this patch does not work.

                                                                Honza

> 
> ---
>  fs/ext4/ialloc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index f73e5eb43eae..7563b892c64f 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -944,6 +944,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  	ext4_group_t flex_group;
>  	struct ext4_group_info *grp = NULL;
>  	bool encrypt = false;
> +	bool create_handle = false;
>  
>  	/* Cannot create files in a deleted directory */
>  	if (!dir || !dir->i_nlink)
> @@ -1085,6 +1086,7 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  				ext4_std_error(sb, err);
>  				goto out;
>  			}
> +			create_handle = true;
>  		}
>  		BUFFER_TRACE(inode_bitmap_bh, "get_write_access");
>  		err = ext4_journal_get_write_access(handle, sb, inode_bitmap_bh,
> @@ -1345,7 +1347,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  		ext4_std_error(sb, err);
>  		goto fail_free_drop;
>  	}
> -
> +	if (create_handle)
> +		ext4_journal_stop(handle);
>  	ext4_debug("allocating inode %lu\n", inode->i_ino);
>  	trace_ext4_allocate_inode(inode, dir, mode);
>  	brelse(inode_bitmap_bh);
> @@ -1357,6 +1360,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
>  	clear_nlink(inode);
>  	unlock_new_inode(inode);
>  out:
> +	if (create_handle)
> +		ext4_journal_stop(handle);
>  	dquot_drop(inode);
>  	inode->i_flags |= S_NOQUOTA;
>  	iput(inode);
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
