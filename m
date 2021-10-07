Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFD5425314
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbhJGMc4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 08:32:56 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59378 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241261AbhJGMcz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 08:32:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 89AFC224B8;
        Thu,  7 Oct 2021 12:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633609860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqTBeTOLXh63TdbL8mtx0+7eTpit6RF97QgRBdN8vW0=;
        b=TYcZyGM6Ri1W/rO+n037uidWhkcJU2ItEow+bpzHwW0KbQGPBoDo2kz6enohP2dTOtJa0O
        knwFRdyXCWHhnMLYA0W0e22AGm558SSMBfbumeCnjdaf3jxc/YUExLw/9oB3msV9k3OF3S
        N1HRgOz6ysvATX2MsqElT2g62rnrtYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633609860;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QqTBeTOLXh63TdbL8mtx0+7eTpit6RF97QgRBdN8vW0=;
        b=wy3U7YQmfuke6i/OE5U17gI8qoAbb9s9gYkHwOBnwiycVPVYAgGpUhplk0zbVFLJgZxXZ9
        z7J+2e82lRt3L4CA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 78BA0A3B83;
        Thu,  7 Oct 2021 12:31:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5FBC11F2C96; Thu,  7 Oct 2021 14:31:00 +0200 (CEST)
Date:   Thu, 7 Oct 2021 14:31:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 2/6] ext4: introduce last_check_time record
 previous check time
Message-ID: <20211007123100.GG12712@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911090059.1876456-3-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-09-21 17:00:55, Ye Bin wrote:
> kmmpd:
> ...
>     diff = jiffies - last_update_time;
>     if (diff > mmp_check_interval * HZ) {
> ...
> As "mmp_check_interval = 2 * mmp_update_interval", 'diff' always little
> than 'mmp_update_interval', so there will never trigger detection.
> Introduce last_check_time record previous check time.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

I think the check is there only for the case where write_mmp_block() +
sleep took longer than mmp_check_interval. I agree that should rarely
happen but on a really busy system it is possible and in that case we would
miss updating mmp block for too long and so another node could have started
using the filesystem. I actually don't see a reason why kmmpd should be
checking the block each mmp_check_interval as you do - mmp_check_interval
is just for ext4_multi_mount_protect() to know how long it should wait
before considering mmp block stale... Am I missing something?

								Honza

> ---
>  fs/ext4/mmp.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 12af6dc8457b..c781b09a78c9 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -152,6 +152,7 @@ static int kmmpd(void *data)
>  	int mmp_update_interval = le16_to_cpu(es->s_mmp_update_interval);
>  	unsigned mmp_check_interval;
>  	unsigned long last_update_time;
> +	unsigned long last_check_time;
>  	unsigned long diff;
>  	int retval = 0;
>  
> @@ -170,6 +171,7 @@ static int kmmpd(void *data)
>  
>  	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>  	       sizeof(mmp->mmp_nodename));
> +	last_check_time = jiffies;
>  
>  	while (!kthread_should_stop() && !sb_rdonly(sb)) {
>  		if (!ext4_has_feature_mmp(sb)) {
> @@ -198,17 +200,18 @@ static int kmmpd(void *data)
>  		}
>  
>  		diff = jiffies - last_update_time;
> -		if (diff < mmp_update_interval * HZ)
> +		if (diff < mmp_update_interval * HZ) {
>  			schedule_timeout_interruptible(mmp_update_interval *
>  						       HZ - diff);
> +			diff = jiffies - last_update_time;
> +		}
>  
>  		/*
>  		 * We need to make sure that more than mmp_check_interval
> -		 * seconds have not passed since writing. If that has happened
> -		 * we need to check if the MMP block is as we left it.
> +		 * seconds have not passed since check. If that has happened
> +		 * we need to check if the MMP block is as we write it.
>  		 */
> -		diff = jiffies - last_update_time;
> -		if (diff > mmp_check_interval * HZ) {
> +		if (jiffies - last_check_time > mmp_check_interval * HZ) {
>  			struct buffer_head *bh_check = NULL;
>  			struct mmp_struct *mmp_check;
>  
> @@ -234,6 +237,7 @@ static int kmmpd(void *data)
>  				goto wait_to_exit;
>  			}
>  			put_bh(bh_check);
> +			last_check_time = jiffies;
>  		}
>  
>  		 /*
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
