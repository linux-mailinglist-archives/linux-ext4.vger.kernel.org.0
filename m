Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5E382DA2
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhEQNl5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbhEQNl4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 09:41:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B61C061573;
        Mon, 17 May 2021 06:40:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j10so8828344lfb.12;
        Mon, 17 May 2021 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uwmsFmAlOo76er6Ji5UTRtBzo940BiJI4cuJFCDeXfU=;
        b=UbVcU25g+r45EQTwnm5XC1IOOnRNwgWrtDyxScOR/YTVoFKqzGlP4B1BOwrph9s3j0
         wCamxC//WsFQ6rS/eOHdKdkoehjoCvPCGuhzp7YR311zH5Jpe+QUZhmHsZ+sI0eyKz3E
         39Gc+YlVZCGtGnfkUbwP4EzVSjxny52IRi/pjVXPLsAdcl5R1zD2aIZfOYHRllPGVG1x
         8sCO9BTybuIFShckdHjyLXzCGDs/jfsm7zMUGeEBhAZghwrbI4dWlNmbc/4XbM2zz5qC
         8Cqd6Bde0S1c3aP9Jn01B1i4bfoUPM/jTrBo95gmh9E2hOuQwllvwrZ/H5L8POG1PAo4
         zp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uwmsFmAlOo76er6Ji5UTRtBzo940BiJI4cuJFCDeXfU=;
        b=oJlIqDGmSQokT+9C63HVy4LW/Hvrj1I3B3cbj7EkNfkLcqoziOwva180kqzujUn1uh
         4Bhmsc0f+EbLr08L5f50+nVXa+DS7fcCJsFhtQ2FVGf/FT8fBPpyJpZI08WwzRaM7eKH
         HTb6AHry63atpce8jGaotLKKovcXwqCyfhTEZ0dCgb2wL3W5LWnphm8JlPwTvDBJMb4P
         VPJaYuLGCMnU733HrqQTEbSlGF56QEZd6WIjhsE40ZHIO3B48Yf0K0vzk6aaFn0Wb4WT
         /4GWbQw8wo39318dtC169foSlBFlmv3OVamKuQIMznK+WO4B1nPcdC3GjmUgfJbMusaQ
         pfqQ==
X-Gm-Message-State: AOAM530rrPcZI90hYhiPEDh5XjE7+u7R1V1GmgtQ9CVxfCJRpr0QgRly
        SItu5laLoLt5C9Cf7OBtkA8=
X-Google-Smtp-Source: ABdhPJzTPGDuXem4nPuheC3gCCJ7o7R2hUL5WcXmbbZB/BMgNw7/iq3HGgGkVdvgElCr2q/6mB1vGg==
X-Received: by 2002:a19:7012:: with SMTP id h18mr2838021lfc.432.1621258837508;
        Mon, 17 May 2021 06:40:37 -0700 (PDT)
Received: from localhost.localdomain ([94.103.227.227])
        by smtp.gmail.com with ESMTPSA id r1sm2899113ljj.21.2021.05.17.06.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:40:37 -0700 (PDT)
Date:   Mon, 17 May 2021 16:40:34 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210517164034.1e7d712b@gmail.com>
In-Reply-To: <20210430185046.15742-1-paskripkin@gmail.com>
References: <YIt9IFY4Xsf5K+eZ@mit.edu>
        <20210430185046.15742-1-paskripkin@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!

Is all ok with this one, or I should send v3? :)

With regards,
Pavel Skripkin

On Fri, 30 Apr 2021 21:50:46 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:
> static int kthread(void *_create) will return -ENOMEM
> or -EINTR in case of internal failure or
> kthread_stop() call happens before threadfn call.
> 
> To prevent fancy error checking and make code
> more straightforward we moved all cleanup code out
> of kmmpd threadfn.
> 
> Also, dropped struct mmpd_data at all. Now struct super_block
> is a threadfn data and struct buffer_head embedded into
> struct ext4_sb_info.
> 
> Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>  fs/ext4/ext4.h  |  4 ++++
>  fs/ext4/mmp.c   | 28 +++++++++++++---------------
>  fs/ext4/super.c | 10 ++++------
>  3 files changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 826a56e3bbd2..62210cbea84b 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1490,6 +1490,7 @@ struct ext4_sb_info {
>  	struct kobject s_kobj;
>  	struct completion s_kobj_unregister;
>  	struct super_block *s_sb;
> +	struct buffer_head *s_mmp_bh;
>  
>  	/* Journaling */
>  	struct journal_s *s_journal;
> @@ -3663,6 +3664,9 @@ extern struct ext4_io_end_vec
> *ext4_last_io_end_vec(ext4_io_end_t *io_end); /* mmp.c */
>  extern int ext4_multi_mount_protect(struct super_block *,
> ext4_fsblk_t); 
> +/* mmp.c */
> +extern void ext4_stop_mmpd(struct ext4_sb_info *sbi);
> +
>  /* verity.c */
>  extern const struct fsverity_operations ext4_verityops;
>  
> diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> index 795c3ff2907c..623bad399612 100644
> --- a/fs/ext4/mmp.c
> +++ b/fs/ext4/mmp.c
> @@ -127,9 +127,9 @@ void __dump_mmp_msg(struct super_block *sb,
> struct mmp_struct *mmp, */
>  static int kmmpd(void *data)
>  {
> -	struct super_block *sb = ((struct mmpd_data *) data)->sb;
> -	struct buffer_head *bh = ((struct mmpd_data *) data)->bh;
> +	struct super_block *sb = (struct super_block *) data;
>  	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> +	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
>  	struct mmp_struct *mmp;
>  	ext4_fsblk_t mmp_block;
>  	u32 seq = 0;
> @@ -245,12 +245,18 @@ static int kmmpd(void *data)
>  	retval = write_mmp_block(sb, bh);
>  
>  exit_thread:
> -	EXT4_SB(sb)->s_mmp_tsk = NULL;
> -	kfree(data);
> -	brelse(bh);
>  	return retval;
>  }
>  
> +void ext4_stop_mmpd(struct ext4_sb_info *sbi)
> +{
> +	if (sbi->s_mmp_tsk) {
> +		kthread_stop(sbi->s_mmp_tsk);
> +		brelse(sbi->s_mmp_bh);
> +		sbi->s_mmp_tsk = NULL;
> +	}
> +}
> +
>  /*
>   * Get a random new sequence number but make sure it is not greater
> than
>   * EXT4_MMP_SEQ_MAX.
> @@ -275,7 +281,6 @@ int ext4_multi_mount_protect(struct super_block
> *sb, struct ext4_super_block *es = EXT4_SB(sb)->s_es;
>  	struct buffer_head *bh = NULL;
>  	struct mmp_struct *mmp = NULL;
> -	struct mmpd_data *mmpd_data;
>  	u32 seq;
>  	unsigned int mmp_check_interval =
> le16_to_cpu(es->s_mmp_update_interval); unsigned int wait_time = 0;
> @@ -364,24 +369,17 @@ int ext4_multi_mount_protect(struct super_block
> *sb, goto failed;
>  	}
>  
> -	mmpd_data = kmalloc(sizeof(*mmpd_data), GFP_KERNEL);
> -	if (!mmpd_data) {
> -		ext4_warning(sb, "not enough memory for mmpd_data");
> -		goto failed;
> -	}
> -	mmpd_data->sb = sb;
> -	mmpd_data->bh = bh;
> +	EXT4_SB(sb)->s_mmp_bh = bh;
>  
>  	/*
>  	 * Start a kernel thread to update the MMP block
> periodically. */
> -	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, mmpd_data,
> "kmmpd-%.*s",
> +	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb, "kmmpd-%.*s",
>  					     (int)sizeof(mmp->mmp_bdevname),
>  					     bdevname(bh->b_bdev,
>  						      mmp->mmp_bdevname));
>  	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
>  		EXT4_SB(sb)->s_mmp_tsk = NULL;
> -		kfree(mmpd_data);
>  		ext4_warning(sb, "Unable to create kmmpd thread for
> %s.", sb->s_id);
>  		goto failed;
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b9693680463a..539f89c5431f 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1244,8 +1244,8 @@ static void ext4_put_super(struct super_block
> *sb) ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
>  	sbi->s_ea_block_cache = NULL;
>  
> -	if (sbi->s_mmp_tsk)
> -		kthread_stop(sbi->s_mmp_tsk);
> +	ext4_stop_mmpd(sbi);
> +
>  	brelse(sbi->s_sbh);
>  	sb->s_fs_info = NULL;
>  	/*
> @@ -5156,8 +5156,7 @@ static int ext4_fill_super(struct super_block
> *sb, void *data, int silent) failed_mount3:
>  	flush_work(&sbi->s_error_work);
>  	del_timer_sync(&sbi->s_err_report);
> -	if (sbi->s_mmp_tsk)
> -		kthread_stop(sbi->s_mmp_tsk);
> +	ext4_stop_mmpd(sbi);
>  failed_mount2:
>  	rcu_read_lock();
>  	group_desc = rcu_dereference(sbi->s_group_desc);
> @@ -5952,8 +5951,7 @@ static int ext4_remount(struct super_block *sb,
> int *flags, char *data) */
>  				ext4_mark_recovery_complete(sb, es);
>  			}
> -			if (sbi->s_mmp_tsk)
> -				kthread_stop(sbi->s_mmp_tsk);
> +			ext4_stop_mmpd(sbi);
>  		} else {
>  			/* Make sure we can mount this feature set
> readwrite */ if (ext4_has_feature_readonly(sb) ||

