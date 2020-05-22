Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E101DE7C0
	for <lists+linux-ext4@lfdr.de>; Fri, 22 May 2020 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729542AbgEVNLv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 May 2020 09:11:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:45980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgEVNLu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 22 May 2020 09:11:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46063ABEC;
        Fri, 22 May 2020 13:11:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 10D261E126B; Fri, 22 May 2020 15:11:45 +0200 (CEST)
Date:   Fri, 22 May 2020 15:11:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] ext2: fix incorrect i_op for special inode
Message-ID: <20200522131145.GD14199@quack2.suse.cz>
References: <20200522044035.24190-1-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522044035.24190-1-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 22-05-20 12:40:34, Chengguang Xu wrote:
> We should always set &ext2_special_inode_operations to i_op
> for special inode regardless of CONFIG_EXT2_FS_XATTR setting.
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks. I've applied both patches. I've just slightly expanded changelog of
this patch to better explain the implications of the change.

								Honza

> ---
>  fs/ext2/namei.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
> index ccfbbf59e2fc..1a5421a34ef7 100644
> --- a/fs/ext2/namei.c
> +++ b/fs/ext2/namei.c
> @@ -136,9 +136,7 @@ static int ext2_mknod (struct inode * dir, struct dentry *dentry, umode_t mode,
>  	err = PTR_ERR(inode);
>  	if (!IS_ERR(inode)) {
>  		init_special_inode(inode, inode->i_mode, rdev);
> -#ifdef CONFIG_EXT2_FS_XATTR
>  		inode->i_op = &ext2_special_inode_operations;
> -#endif
>  		mark_inode_dirty(inode);
>  		err = ext2_add_nondir(dentry, inode);
>  	}
> -- 
> 2.20.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
