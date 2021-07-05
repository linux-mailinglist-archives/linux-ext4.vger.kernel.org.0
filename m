Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888CF3BBB92
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Jul 2021 12:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhGEKzU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Jul 2021 06:55:20 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54866 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhGEKzT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Jul 2021 06:55:19 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 350D01FE5A;
        Mon,  5 Jul 2021 10:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625482362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fpm40tJrF9OSlPlTcqcUfpdONlePzhoBnOab2uQUEys=;
        b=0wEkN24gF/FOmZ1iPTXdKv+M4eUgo2mxXHZhcFd6bxgAwW6i8jEqxLhyej7PVorl3ws5gI
        FKmxyKr9K9VyjYWH+xAO0BU9RXCEl1wZOMOQocztIWk3USjI50tBTyfTRccTJBFWwWISzE
        bhSY4u1lGl3Fmp8jNzbyw+OOhkvG8Jo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625482362;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fpm40tJrF9OSlPlTcqcUfpdONlePzhoBnOab2uQUEys=;
        b=UOBQlRxLr7p1DxkwBpr202hhGJvFbA3oe6t9Na57yO3DPeRaKbY1AZlPcIrbUwlGguOhwn
        Ti6GeTi9N5Co7dCw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id 25638A3B8A;
        Mon,  5 Jul 2021 10:52:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EAFB81E1139; Mon,  5 Jul 2021 12:52:41 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:52:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH 2/2] ext4: Fix potential uas-after-free about
 sbi->s_mmp_tsk when kmmpd kthread exit before set sbi->s_mmp_tsk
Message-ID: <20210705105241.GC15373@quack2.suse.cz>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210629143603.2166962-3-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 29-06-21 22:36:03, Ye Bin wrote:
> Now sbi->s_mmp_tsk is created with kthread_run, then kmmpd maybe
> already running and even exit as exception. Even though we set
> sbi->s_mmp_tsk with NULL before kmmpd kthread exit, but
> "sbi->s_mmp_tsk=kthread_run(XX)" may set after set with NULL.
>    mount                     kmmpd
>      |                         |
>      |-call kthread_run        |
>      |                         |-kmmpd runing
>      |                         |-kmmpd exit sbi->s_mmp_tsk=NULL
>      |                         |
>      |-kthread_run return      |
>      | and set sbi->s_mmp_tsk  |
>      |                         |
>      |-then we get wild ptr"sbi->s_mmp_tsk" and later trigger UAF
> 
> This patch is base on previous "ext4: Fix use-after-free about sbi->s_mmp_tsk".
> Previous patch ensure kmmpd kthread exit by itself will set sbi->s_mmp_tsk with
> NULL. We can create kthread first, and then wakeup kmmpd kthread later.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mmp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index fc18a8c205c7..6ec1ea182cc0 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -394,16 +394,18 @@ int ext4_multi_mount_protect(struct super_block *sb,
>  	/*
>  	 * Start a kernel thread to update the MMP block periodically.
>  	 */
> -	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb, "kmmpd-%.*s",
> -					     (int)sizeof(mmp->mmp_bdevname),
> -					     bdevname(bh->b_bdev,
> -						      mmp->mmp_bdevname));
> +	EXT4_SB(sb)->s_mmp_tsk = kthread_create(kmmpd, sb, "kmmpd-%.*s",
> +						(int)sizeof(mmp->mmp_bdevname),
> +						bdevname(bh->b_bdev,
> +							 mmp->mmp_bdevname));
> +
>  	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
>  		EXT4_SB(sb)->s_mmp_tsk = NULL;
>  		ext4_warning(sb, "Unable to create kmmpd thread for %s.",
>  			     sb->s_id);
>  		goto failed;
>  	}
> +	wake_up_process(EXT4_SB(sb)->s_mmp_tsk);
>  
>  	return 0;
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
