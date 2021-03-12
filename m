Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3813338DA5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Mar 2021 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhCLMvP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Mar 2021 07:51:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:48106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232100AbhCLMu5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 12 Mar 2021 07:50:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BE2EDB0D2;
        Fri, 12 Mar 2021 12:50:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6066E1F2C4B; Fri, 12 Mar 2021 13:50:55 +0100 (CET)
Date:   Fri, 12 Mar 2021 13:50:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH] ext4: fix potential error in ext4_do_update_inode
Message-ID: <20210312125055.GB31816@quack2.suse.cz>
References: <20210312065051.36314-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312065051.36314-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 12-03-21 01:50:51, Shijie Luo wrote:
> If set_large_file = 1 and errors occur in ext4_handle_dirty_metadata(),
> the error code will be overridden, go to out_brelse to avoid this
> situation.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>

Yeah, looks good. Once ext4_handle_dirty_metadata() fails, the journal is
aborted anyway so we are unlikely to do anything useful with the
filesystem. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 650c5acd2f2d..8074ae0e976d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5026,7 +5026,7 @@ static int ext4_do_update_inode(handle_t *handle,
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	struct buffer_head *bh = iloc->bh;
>  	struct super_block *sb = inode->i_sb;
> -	int err = 0, rc, block;
> +	int err = 0, block;
>  	int need_datasync = 0, set_large_file = 0;
>  	uid_t i_uid;
>  	gid_t i_gid;
> @@ -5138,9 +5138,9 @@ static int ext4_do_update_inode(handle_t *handle,
>  					      bh->b_data);
>  
>  	BUFFER_TRACE(bh, "call ext4_handle_dirty_metadata");
> -	rc = ext4_handle_dirty_metadata(handle, NULL, bh);
> -	if (!err)
> -		err = rc;
> +	err = ext4_handle_dirty_metadata(handle, NULL, bh);
> +	if (err)
> +		goto out_brelse;
>  	ext4_clear_inode_state(inode, EXT4_STATE_NEW);
>  	if (set_large_file) {
>  		BUFFER_TRACE(EXT4_SB(sb)->s_sbh, "get write access");
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
