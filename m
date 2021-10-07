Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC94253C5
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 15:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241255AbhJGNOE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 09:14:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37116 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241234AbhJGNOC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 09:14:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F09922530;
        Thu,  7 Oct 2021 13:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633612328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgbL1rqMpGZjBhO5AG+VRXtRVPrTuD36HvlipY3Lir8=;
        b=PohcdEB7N9qpLWRFTlS115DRWTw4fmEGg3992zqM89bPyy80/8MBiYpcMs1IOYLhPAJqU/
        mc+D/tFU8h22PEltCO0s8WpXTJgroO1CbXletOAl+T1qNwWPWA5gb8bY+tTzABN7K+eZ6B
        yytFjXCG5I54QUItdJcGa6erTSpo/Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633612328;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgbL1rqMpGZjBhO5AG+VRXtRVPrTuD36HvlipY3Lir8=;
        b=IAFDSBoUn6RJAcRJtS25CnUnaesejUZptaqm+YDtVotqYnBq4IQyU52aflEjXiNGgjmDAa
        l0rA139DNH+Ib6DQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id E9888A3B87;
        Thu,  7 Oct 2021 13:12:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CAC021F2C96; Thu,  7 Oct 2021 15:12:07 +0200 (CEST)
Date:   Thu, 7 Oct 2021 15:12:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2 6/6] ext4: fix possible store wrong check
 interval value in disk when umount
Message-ID: <20211007131207.GJ12712@quack2.suse.cz>
References: <20210911090059.1876456-1-yebin10@huawei.com>
 <20210911090059.1876456-7-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911090059.1876456-7-yebin10@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 11-09-21 17:00:59, Ye Bin wrote:
> Test follow steps:
> 1. mkfs.ext4 /dev/sda -O mmp
> 2. mount /dev/sda  /mnt
> 3. wait for about 1 minute
> 4. umount mnt
> 5. debugfs /dev/sda
> 6. dump_mmp
> 7. fsck.ext4 /dev/sda
> 
> I found 'check_interval' is range in [5, 10]. And sometime run fsck
> print "MMP interval is 10 seconds and total wait time is 42 seconds.
> Please wait...".
> kmmpd:
> ...
> 	if (diff < mmp_update_interval * HZ)
> 		schedule_timeout_interruptible(mmp_update_interval * HZ - diff);
> 	 diff = jiffies - last_update_time;
> ...
> 	mmp_check_interval = max(min(EXT4_MMP_CHECK_MULT * diff / HZ,
> 				EXT4_MMP_MAX_CHECK_INTERVAL),
> 			        EXT4_MMP_MIN_CHECK_INTERVAL);
> 	mmp->mmp_check_interval = cpu_to_le16(mmp_check_interval);
> ...
> We will call ext4_stop_mmpd to stop kmmpd kthread when umount, and
> schedule_timeout_interruptible will be interrupted, so 'diff' maybe
> little than mmp_update_interval. Then mmp_check_interval will range
> in [EXT4_MMP_MAX_CHECK_INTERVAL, EXT4_MMP_CHECK_MULT * diff / HZ].
> To solve this issue, if 'diff' little then mmp_update_interval * HZ
> just break loop, don't update check interval.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/mmp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index a0d47a906faa..f39e1fa0c6db 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -205,6 +205,14 @@ static int kmmpd(void *data)
>  			schedule_timeout_interruptible(mmp_update_interval *
>  						       HZ - diff);
>  			diff = jiffies - last_update_time;
> +			/* If 'diff' little 'than mmp_update_interval * HZ', it
> +			 * means someone call ext4_stop_mmpd to stop kmmpd
> +			 * kthread. We don't need to update mmp_check_interval
> +			 * any more, as 'diff' is not exact value.
> +			 */
> +			if (unlikely(diff < mmp_update_interval * HZ &&
> +			    kthread_should_stop()))
> +				break;
>  		}

So in this case, mmp_check_interval would be EXT4_MMP_MIN_CHECK_INTERVAL. I
don't quite understand what the practical problem is - the fsck message?
That will happen anytime mmp_check_interval is >= 10 AFAICT and I don't
quite see how that is connected to this condition... Can you explain a bit
more please?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
