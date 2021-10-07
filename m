Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3375C4252F5
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 14:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241319AbhJGM2C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 08:28:02 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241144AbhJGM2B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 08:28:01 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E55AC224B0;
        Thu,  7 Oct 2021 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633609566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ND8Yu8tDRqDniMgWsqUamQ6A8/6Z3CCF0JWxZLsBwo=;
        b=GsWTr/NdzN4wqt0jaDcZd+eDNbJpFC7Vd0/Nmq+1s9m3AobioQbOLwj3QZiPy01Xb8abTv
        M96GTCGlJD/Uaq4E6Ptm836oUTrQZiG/B7de1iXH1UP4ExtmYnLtS158LBGkXj+6azsR3W
        RB/wI9dZh390HGZn2/09AlUJOezU/Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633609566;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ND8Yu8tDRqDniMgWsqUamQ6A8/6Z3CCF0JWxZLsBwo=;
        b=6/uqmmbZjg0Rx9H2Zq8j+EX+Bbo/qtOmvrLi1wU/3NHBeYHJblzp3ts4gXD7E7LYWEdTpd
        xGVcxRBtd96uDdBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 96CF6A3B8A;
        Thu,  7 Oct 2021 12:26:06 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5ADAC1F2C96; Thu,  7 Oct 2021 14:26:04 +0200 (CEST)
Date:   Thu, 7 Oct 2021 14:26:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 1/6] ext4: init seq with random value in kmmpd
Message-ID: <20211007122604.GF12712@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911090059.1876456-2-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-09-21 17:00:54, Ye Bin wrote:
> If two host has the same nodename, and seq start from 0, May cause the
> detection mechanism to fail.
> So init seq with random value to accelerate conflict detection.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch. I agree the code in kmmpd looks suspicious.  The
sequence number is initialized to a random number in
ext4_multi_mount_protect() which is called before kmmpd is started. I think
kmmpd() should initialize its 'seq' to a number fetched from the mmp
block, instead of 0 as is currently in the code. I don't think generating a
new random number as you do is really needed...

								Honza

> ---
>  fs/ext4/mmp.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index cebea4270817..12af6dc8457b 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -122,6 +122,21 @@ void __dump_mmp_msg(struct super_block *sb, struct mmp_struct *mmp,
>  		       (int)sizeof(mmp->mmp_bdevname), mmp->mmp_bdevname);
>  }
>  
> +/*
> + * Get a random new sequence number but make sure it is not greater than
> + * EXT4_MMP_SEQ_MAX.
> + */
> +static unsigned int mmp_new_seq(void)
> +{
> +	u32 new_seq;
> +
> +	do {
> +		new_seq = prandom_u32();
> +	} while (new_seq > EXT4_MMP_SEQ_MAX);
> +
> +	return new_seq;
> +}
> +
>  /*
>   * kmmpd will update the MMP sequence every s_mmp_update_interval seconds
>   */
> @@ -132,7 +147,7 @@ static int kmmpd(void *data)
>  	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
>  	struct mmp_struct *mmp;
>  	ext4_fsblk_t mmp_block;
> -	u32 seq = 0;
> +	u32 seq = mmp_new_seq();
>  	unsigned long failed_writes = 0;
>  	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>  	unsigned mmp_check_interval;
> @@ -258,21 +273,6 @@ void ext4_stop_mmpd(struct ext4_sb_info *sbi)
>  	}
>  }
>  
> -/*
> - * Get a random new sequence number but make sure it is not greater than
> - * EXT4_MMP_SEQ_MAX.
> - */
> -static unsigned int mmp_new_seq(void)
> -{
> -	u32 new_seq;
> -
> -	do {
> -		new_seq = prandom_u32();
> -	} while (new_seq > EXT4_MMP_SEQ_MAX);
> -
> -	return new_seq;
> -}
> -
>  /*
>   * Protect the filesystem from being mounted more than once.
>   */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
