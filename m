Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBFA3BE5A4
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 11:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGGJdK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 05:33:10 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58806 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhGGJdJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 05:33:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 00AE022411;
        Wed,  7 Jul 2021 09:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625650229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTDmAl/R8gXdsWrN6qD3tyMGGkTXVmJbjjKspZNUZ3g=;
        b=P47rK1RpsEw1D1+sP0JjKAQeupsmDrDEt0arNhrbCaN9fCDlvyOCzeKwfjJ3Ywp+e8LqPf
        EAqaQ0CUkAnhKFUq+S1wJMVOLVat7AJ/Z8i2lo5IxuQS5mtpx0DEi8NtWdxQFmE+OpZHTq
        0wsiAQFXw3qqAS9JEEovbO4ddgbeO1M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625650229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FTDmAl/R8gXdsWrN6qD3tyMGGkTXVmJbjjKspZNUZ3g=;
        b=H+F1awVGGEwpNS6ZL5igW/jMG0PmeDtwxdhYObKY1XA2iJLptJtqy+zxFwapDMIQNIqJQf
        kYQZx6FTi/Rk58Dw==
Received: from quack2.suse.cz (unknown [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id E55D5A3B9E;
        Wed,  7 Jul 2021 09:30:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B829B1F2CD7; Wed,  7 Jul 2021 11:30:28 +0200 (CEST)
Date:   Wed, 7 Jul 2021 11:30:28 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH -v4] ext4: fix possible UAF when remounting r/o a
 mmp-protected file system
Message-ID: <20210707093028.GA5335@quack2.suse.cz>
References: <20210706194910.GC17149@quack2.suse.cz>
 <20210707002433.3719773-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707002433.3719773-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-07-21 20:24:33, Theodore Ts'o wrote:
> After commit 618f003199c6 ("ext4: fix memory leak in
> ext4_fill_super"), after the file system is remounted read-only, there
> is a race where the kmmpd thread can exit, causing sbi->s_mmp_tsk to
> point at freed memory, which the call to ext4_stop_mmpd() can trip
> over.
> 
> Fix this by only allowing kmmpd() to exit when it is stopped via
> ext4_stop_mmpd().
> 
> Link: https://lore.kernel.org/r/YONtEGojq7LcXnuC@mit.edu
> Reported-by: Ye Bin <yebin10@huawei.com>
> Bug-Report-Link: <20210629143603.2166962-1-yebin10@huawei.com>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mmp.c   | 31 +++++++++++++++----------------
>  fs/ext4/super.c |  6 +++++-
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 6cb598b549ca..bc364c119af6 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -156,7 +156,12 @@ static int kmmpd(void *data)
>  	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
>  	       sizeof(mmp->mmp_nodename));
>  
> -	while (!kthread_should_stop()) {
> +	while (!kthread_should_stop() && !sb_rdonly(sb)) {
> +		if (!ext4_has_feature_mmp(sb)) {
> +			ext4_warning(sb, "kmmpd being stopped since MMP feature"
> +				     " has been disabled.");
> +			goto wait_to_exit;
> +		}
>  		if (++seq > EXT4_MMP_SEQ_MAX)
>  			seq = 1;
>  
> @@ -177,16 +182,6 @@ static int kmmpd(void *data)
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
> @@ -207,7 +202,7 @@ static int kmmpd(void *data)
>  				ext4_error_err(sb, -retval,
>  					       "error reading MMP data: %d",
>  					       retval);
> -				goto exit_thread;
> +				goto wait_to_exit;
>  			}
>  
>  			mmp_check = (struct mmp_struct *)(bh_check->b_data);
> @@ -221,7 +216,7 @@ static int kmmpd(void *data)
>  				ext4_error_err(sb, EBUSY, "abort");
>  				put_bh(bh_check);
>  				retval = -EBUSY;
> -				goto exit_thread;
> +				goto wait_to_exit;
>  			}
>  			put_bh(bh_check);
>  		}
> @@ -244,7 +239,13 @@ static int kmmpd(void *data)
>  
>  	retval = write_mmp_block(sb, bh);
>  
> -exit_thread:
> +wait_to_exit:
> +	while (!kthread_should_stop()) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		if (!kthread_should_stop())
> +			schedule();
> +	}
> +	set_current_state(TASK_RUNNING);
>  	return retval;
>  }
>  
> @@ -391,5 +392,3 @@ int ext4_multi_mount_protect(struct super_block *sb,
>  	brelse(bh);
>  	return 1;
>  }
> -
> -
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index cdbe71d935e8..b8ff0399e171 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5993,7 +5993,6 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  				 */
>  				ext4_mark_recovery_complete(sb, es);
>  			}
> -			ext4_stop_mmpd(sbi);
>  		} else {
>  			/* Make sure we can mount this feature set readwrite */
>  			if (ext4_has_feature_readonly(sb) ||
> @@ -6107,6 +6106,9 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  	if (!test_opt(sb, BLOCK_VALIDITY) && sbi->s_system_blks)
>  		ext4_release_system_zone(sb);
>  
> +	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
> +		ext4_stop_mmpd(sbi);
> +
>  	/*
>  	 * Some options can be enabled by ext4 and/or by VFS mount flag
>  	 * either way we need to make sure it matches in both *flags and
> @@ -6140,6 +6142,8 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>  	for (i = 0; i < EXT4_MAXQUOTAS; i++)
>  		kfree(to_free[i]);
>  #endif
> +	if (!ext4_has_feature_mmp(sb) || sb_rdonly(sb))
> +		ext4_stop_mmpd(sbi);
>  	kfree(orig_data);
>  	return err;
>  }
> -- 
> 2.31.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
