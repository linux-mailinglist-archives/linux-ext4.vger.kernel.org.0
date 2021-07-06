Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACAC3BD43A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 14:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhGFMFo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 08:05:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38182 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236988AbhGFLwz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 07:52:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 092272259E;
        Tue,  6 Jul 2021 11:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625569898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf8GSQGhHiB4OfOLbET/J5Yv29wllECV1thanHGQR4Q=;
        b=R43OQ2ozEeng92i2+mxgJpjRWm1C7S8H4nsYwnM4wEx2pquQ45fKMz0yt8MPeTUlS+5Eyl
        Nmqwn01c2VulfhdUpgMuCrlJVy+iwVAn7v3tfSFSf8rAWb1a/hVGgX9UpP7y5JckFKz4/y
        sczhi+M3LVj52ZAdQ5Karz3Lhs72OhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625569898;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vf8GSQGhHiB4OfOLbET/J5Yv29wllECV1thanHGQR4Q=;
        b=WiGdv8PtvIHKbPCAljYwAWlwWg1PideVLKYwwbUIrOAaQC5U1//rDkQbNf2EKfgo3+WUUl
        Tm+u3cxh5piExwBA==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id E60C6A3B9C;
        Tue,  6 Jul 2021 11:11:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B96DE1F2C9A; Tue,  6 Jul 2021 13:11:37 +0200 (CEST)
Date:   Tue, 6 Jul 2021 13:11:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Fix use-after-free about sbi->s_mmp_tsk
Message-ID: <20210706111137.GA7922@quack2.suse.cz>
References: <20210629143603.2166962-1-yebin10@huawei.com>
 <20210629143603.2166962-2-yebin10@huawei.com>
 <20210705111548.GD15373@quack2.suse.cz>
 <YONtEGojq7LcXnuC@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YONtEGojq7LcXnuC@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 05-07-21 16:35:28, Theodore Ts'o wrote:
> On Mon, Jul 05, 2021 at 01:15:48PM +0200, Jan Kara wrote:
> > 
> > That being said for this scheme spinlock is enough, you don't need a mutex
> > for s_mmp_lock.
> 
> I think we can solve this without using using either a spinlock or a
> mutex, and it's a smaller and simpler patch as a result.  (This is the
> -v2 version of this patch, which removes an unused label compared to
> the earlier version.)

Yeah, what you suggest is probably simpler. Some comments below.

> From 22ebc97aac75e27a5fd11acdb2bc3030d1da58d1 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Fri, 2 Jul 2021 12:45:02 -0400
> Subject: [PATCH] ext4: fix possible UAF when remounting r/o a mmp-protected file system
> 
> After commit 618f003199c6 ("ext4: fix memory leak in
> ext4_fill_super"), after the file system is remounted read-only, there
> is a race where the kmmpd thread can exit, causing sbi->s_mmp_tsk to
> point at freed memory, which the call to ext4_stop_mmpd() can trip
> over.
> 
> Fix this by only allowing kmmpd() to exit when it is stopped via
> ext4_stop_mmpd().
> 
> Link: https://lore.kernel.org/r/e525c0bf7b18da426bb3d3dd63830a3f85218a9e.1625244710.git.tytso@mit.edu
> Reported-by: Ye Bin <yebin10@huawei.com>
> Bug-Report-Link: <20210629143603.2166962-1-yebin10@huawei.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/mmp.c   | 33 +++++++++++++++++----------------
>  fs/ext4/super.c |  6 +++++-
>  2 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 6cb598b549ca..1e95cee3d8b7 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -157,6 +157,17 @@ static int kmmpd(void *data)
>  	       sizeof(mmp->mmp_nodename));
>  
>  	while (!kthread_should_stop()) {
> +		if (!(le32_to_cpu(es->s_feature_incompat) &
> +		    EXT4_FEATURE_INCOMPAT_MMP)) {

We can probably use ext4_has_feature_mmp() macro when changing this?

> +			ext4_warning(sb, "kmmpd being stopped since MMP feature"
> +				     " has been disabled.");
> +			goto wait_to_exit;
> +		}
> +		if (sb_rdonly(sb)) {
> +			if (!kthread_should_stop())
> +				schedule_timeout_interruptible(HZ);

Cannot this effectively block remount RO for 1s when we wait for kmmpd to
exit? I think doing 'break' when we detected RO super is fine. We'll write
the mmp block and then wait for kthread_should_stop() condition as in any
other abort case. Am I missing something?

> +			continue;
> +		}
>  		if (++seq > EXT4_MMP_SEQ_MAX)
>  			seq = 1;
>  
> @@ -177,16 +188,6 @@ static int kmmpd(void *data)
>  			failed_writes++;
>  		}
>  
> -		if (!(le32_to_cpu(es->s_feature_incompat) &
> -		    EXT4_FEATURE_INCOMPAT_MMP)) {
> -			ext4_warning(sb, "kmmpd being stopped since MMP feature"
> -				     " has been disabled.");
> -			goto exit_thread;
> -		}
> -
> -		if (sb_rdonly(sb))
> -			break;
> -
>  		diff = jiffies - last_update_time;
>  		if (diff < mmp_update_interval * HZ)
>  			schedule_timeout_interruptible(mmp_update_interval *
> @@ -207,7 +208,7 @@ static int kmmpd(void *data)
>  				ext4_error_err(sb, -retval,
>  					       "error reading MMP data: %d",
>  					       retval);
> -				goto exit_thread;
> +				goto wait_to_exit;
>  			}
>  
>  			mmp_check = (struct mmp_struct *)(bh_check->b_data);
> @@ -221,7 +222,7 @@ static int kmmpd(void *data)
>  				ext4_error_err(sb, EBUSY, "abort");
>  				put_bh(bh_check);
>  				retval = -EBUSY;
> -				goto exit_thread;
> +				goto wait_to_exit;
>  			}
>  			put_bh(bh_check);
>  		}
> @@ -242,9 +243,11 @@ static int kmmpd(void *data)
>  	mmp->mmp_seq = cpu_to_le32(EXT4_MMP_SEQ_CLEAN);
>  	mmp->mmp_time = cpu_to_le64(ktime_get_real_seconds());
>  
> -	retval = write_mmp_block(sb, bh);
> +	return write_mmp_block(sb, bh);
>  
> -exit_thread:
> +wait_to_exit:
> +	while (!kthread_should_stop())
> +		schedule();

This makes me a bit nervous that we could unnecessarily burn CPU for
potentially a long time (e.g. if somebody uses tune2fs to disable MMP, we
would be sitting in this loop until the fs in remounted / unmounted). So
maybe we should have something like:

	while (!kthread_should_stop()) {
		set_task_state(TASK_INTERRUPTIBLE);
		if (!kthread_should_stop())
			schedule();
	}

This should safely synchronize with (and not miss wakeup from)
kthread_stop() since that first sets KTHREAD_SHOULD_STOP and after that
calls wake_up_process().

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
