Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E670A3EB5D6
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbhHMMzj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 08:55:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37606 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbhHMMzi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 08:55:38 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D6D05201D0;
        Fri, 13 Aug 2021 12:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628859310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LE7fItUV5qSeFNbpUiGIoGvxTQ19uwIx28/5p3+Xtg0=;
        b=ZnZd+b4aJWFffbKfbk5rK7oys8BhdBbsKGF23QsdDOXKn0f9gK6m9sV+NfBeCSLLqzZIeZ
        YXxct10113v0iftdhWjNFS3/jR/40Z53RyEcqpTOPQ8tF29dBH6hZfYhWR49QjyApRpPKG
        M9omJHm5d52dOXsJeZZBJV5aJJZTIVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628859310;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LE7fItUV5qSeFNbpUiGIoGvxTQ19uwIx28/5p3+Xtg0=;
        b=fBcjuzFEnUFdcCQqJwS/mIxnUJDWTdXjhE1/Wa5hIcjd4k7h2yiUPkmCCe5Jkb5czXj2rM
        vENMw6+beWwFa6Cw==
Received: from quack2.suse.cz (jack.udp.ovpn1.prg.suse.de [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id B1B7BA3B87;
        Fri, 13 Aug 2021 12:55:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 19A071E423D; Fri, 13 Aug 2021 14:55:07 +0200 (CEST)
Date:   Fri, 13 Aug 2021 14:55:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH 1/3] ext4: move inode eio simulation behind io completeion
Message-ID: <20210813125507.GC11955@quack2.suse.cz>
References: <20210810142722.923175-1-yi.zhang@huawei.com>
 <20210810142722.923175-2-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810142722.923175-2-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-08-21 22:27:20, Zhang Yi wrote:
> No EIO simulation is required if the buffer is uptodate, so move the
> simulation behind read bio completeion just like inode/block bitmap
> simulation does.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Makes sense. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d8de607849df..eb2526a35254 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4330,8 +4330,6 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  	bh = sb_getblk(sb, block);
>  	if (unlikely(!bh))
>  		return -ENOMEM;
> -	if (ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO))
> -		goto simulate_eio;
>  	if (!buffer_uptodate(bh)) {
>  		lock_buffer(bh);
>  
> @@ -4418,8 +4416,8 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>  		ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
>  		blk_finish_plug(&plug);
>  		wait_on_buffer(bh);
> +		ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
>  		if (!buffer_uptodate(bh)) {
> -		simulate_eio:
>  			if (ret_block)
>  				*ret_block = block;
>  			brelse(bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
