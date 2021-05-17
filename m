Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C10383C53
	for <lists+linux-ext4@lfdr.de>; Mon, 17 May 2021 20:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbhEQSfs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 May 2021 14:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237050AbhEQSfs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 May 2021 14:35:48 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39707C061573;
        Mon, 17 May 2021 11:34:31 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id v6so8455940ljj.5;
        Mon, 17 May 2021 11:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gPQVB2Gxpm829WebDVfYWATfDREweKl2ZF11NUCj36U=;
        b=r5irQvcboz80jzWteaD0Tgi6/vM06PZ17sWzl0p338iOE+oDhn4I1BHjKBDZRnpkyP
         e+FJ9NwG0wznJs5obORewSZFRZfDek/2hIgziLEeudXBqN+gGWsdjb5geKww0SBM1J1j
         wmFsTHtZIicLrXktt8dfFpovNICXUuvX5zlCBVo3Wr4NBKiqxfV6RKwZ2M0h4U3MT9Qd
         ljTIgwx0gdwJc6/u2FaALwRCaURkZy3vHoE+rBqurjjaD/azZsJPrrXgqF2PZ37myGEY
         8VEo+Heg1EDMSvGPbRuhSBkSk4pr+IV3uUaYJ89eLsBf86kf2PFrHqJAy8yERHpyPZlC
         frSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gPQVB2Gxpm829WebDVfYWATfDREweKl2ZF11NUCj36U=;
        b=EvBrDNPbNoTSj1qVIA759j/Xags0RI3vdfgO2bg4P4Xd5qK0v1mqfaeA1rXLzdYWFw
         KcVAxddLQusYmHODyOn76RRgYCCzuJCUO7EmjmHweSo+pj7KblQp5GRhq7IiyILMvkWK
         S8d81g8yubSiTZDkdfBx3xd+1eyHRFlYtFjkeH0KtEfzACHzSwqC7OpbonB0ttyaKMKV
         G08vVqIQgJ0ujTeLP7z3BDOmdQzzS8Ep230gtQkZ5d9tJIcwhbaXJn0ZIQ2td1aoThiu
         lJUeDn81Qdbs1R9cRjgFTktMOZfJgnj213Z1mv+j71anDaMNpAoMlzJ4Zw+aL4vuUBtO
         93yQ==
X-Gm-Message-State: AOAM530g5X13z6RsaIRYpRHZSC+ea4z76gOqYEUo0q7qLlCBriGZ/+uG
        1V5j0djSeWVab+HV/a/vOt0=
X-Google-Smtp-Source: ABdhPJwd3HpNJ6zf+bUM6K7ZqfzWMSfWRqib8AAwTPQ10ZqTPO9prVv3x2gDbl1KUXvn8KRInXCgTQ==
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr575687lji.465.1621276469689;
        Mon, 17 May 2021 11:34:29 -0700 (PDT)
Received: from localhost.localdomain ([94.103.227.227])
        by smtp.gmail.com with ESMTPSA id d16sm2040623lfm.202.2021.05.17.11.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 11:34:29 -0700 (PDT)
Date:   Mon, 17 May 2021 21:34:27 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix memory leak in ext4_fill_super
Message-ID: <20210517213427.3ac17247@gmail.com>
In-Reply-To: <20210517164034.1e7d712b@gmail.com>
References: <YIt9IFY4Xsf5K+eZ@mit.edu>
        <20210430185046.15742-1-paskripkin@gmail.com>
        <20210517164034.1e7d712b@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 17 May 2021 16:40:34 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:
> Hi!
> 
> Is all ok with this one, or I should send v3? :)
> 

BTW, this patch fixes this bug as well
https://syzkaller.appspot.com/bug?id=e2765a883959fd094e6a1c40f3502114fa17c550


With regards,
Pavel Skripkin

> With regards,
> Pavel Skripkin
> 
> On Fri, 30 Apr 2021 21:50:46 +0300
> Pavel Skripkin <paskripkin@gmail.com> wrote:
> > static int kthread(void *_create) will return -ENOMEM
> > or -EINTR in case of internal failure or
> > kthread_stop() call happens before threadfn call.
> > 
> > To prevent fancy error checking and make code
> > more straightforward we moved all cleanup code out
> > of kmmpd threadfn.
> > 
> > Also, dropped struct mmpd_data at all. Now struct super_block
> > is a threadfn data and struct buffer_head embedded into
> > struct ext4_sb_info.
> > 
> > Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com
> > Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> > ---
> >  fs/ext4/ext4.h  |  4 ++++
> >  fs/ext4/mmp.c   | 28 +++++++++++++---------------
> >  fs/ext4/super.c | 10 ++++------
> >  3 files changed, 21 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 826a56e3bbd2..62210cbea84b 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1490,6 +1490,7 @@ struct ext4_sb_info {
> >  	struct kobject s_kobj;
> >  	struct completion s_kobj_unregister;
> >  	struct super_block *s_sb;
> > +	struct buffer_head *s_mmp_bh;
> >  
> >  	/* Journaling */
> >  	struct journal_s *s_journal;
> > @@ -3663,6 +3664,9 @@ extern struct ext4_io_end_vec
> > *ext4_last_io_end_vec(ext4_io_end_t *io_end); /* mmp.c */
> >  extern int ext4_multi_mount_protect(struct super_block *,
> > ext4_fsblk_t); 
> > +/* mmp.c */
> > +extern void ext4_stop_mmpd(struct ext4_sb_info *sbi);
> > +
> >  /* verity.c */
> >  extern const struct fsverity_operations ext4_verityops;
> >  
> > diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
> > index 795c3ff2907c..623bad399612 100644
> > --- a/fs/ext4/mmp.c
> > +++ b/fs/ext4/mmp.c
> > @@ -127,9 +127,9 @@ void __dump_mmp_msg(struct super_block *sb,
> > struct mmp_struct *mmp, */
> >  static int kmmpd(void *data)
> >  {
> > -	struct super_block *sb = ((struct mmpd_data *) data)->sb;
> > -	struct buffer_head *bh = ((struct mmpd_data *) data)->bh;
> > +	struct super_block *sb = (struct super_block *) data;
> >  	struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> > +	struct buffer_head *bh = EXT4_SB(sb)->s_mmp_bh;
> >  	struct mmp_struct *mmp;
> >  	ext4_fsblk_t mmp_block;
> >  	u32 seq = 0;
> > @@ -245,12 +245,18 @@ static int kmmpd(void *data)
> >  	retval = write_mmp_block(sb, bh);
> >  
> >  exit_thread:
> > -	EXT4_SB(sb)->s_mmp_tsk = NULL;
> > -	kfree(data);
> > -	brelse(bh);
> >  	return retval;
> >  }
> >  
> > +void ext4_stop_mmpd(struct ext4_sb_info *sbi)
> > +{
> > +	if (sbi->s_mmp_tsk) {
> > +		kthread_stop(sbi->s_mmp_tsk);
> > +		brelse(sbi->s_mmp_bh);
> > +		sbi->s_mmp_tsk = NULL;
> > +	}
> > +}
> > +
> >  /*
> >   * Get a random new sequence number but make sure it is not greater
> > than
> >   * EXT4_MMP_SEQ_MAX.
> > @@ -275,7 +281,6 @@ int ext4_multi_mount_protect(struct super_block
> > *sb, struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> >  	struct buffer_head *bh = NULL;
> >  	struct mmp_struct *mmp = NULL;
> > -	struct mmpd_data *mmpd_data;
> >  	u32 seq;
> >  	unsigned int mmp_check_interval =
> > le16_to_cpu(es->s_mmp_update_interval); unsigned int wait_time = 0;
> > @@ -364,24 +369,17 @@ int ext4_multi_mount_protect(struct
> > super_block *sb, goto failed;
> >  	}
> >  
> > -	mmpd_data = kmalloc(sizeof(*mmpd_data), GFP_KERNEL);
> > -	if (!mmpd_data) {
> > -		ext4_warning(sb, "not enough memory for
> > mmpd_data");
> > -		goto failed;
> > -	}
> > -	mmpd_data->sb = sb;
> > -	mmpd_data->bh = bh;
> > +	EXT4_SB(sb)->s_mmp_bh = bh;
> >  
> >  	/*
> >  	 * Start a kernel thread to update the MMP block
> > periodically. */
> > -	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, mmpd_data,
> > "kmmpd-%.*s",
> > +	EXT4_SB(sb)->s_mmp_tsk = kthread_run(kmmpd, sb,
> > "kmmpd-%.*s", (int)sizeof(mmp->mmp_bdevname),
> >  					     bdevname(bh->b_bdev,
> >  						      mmp->mmp_bdevname));
> >  	if (IS_ERR(EXT4_SB(sb)->s_mmp_tsk)) {
> >  		EXT4_SB(sb)->s_mmp_tsk = NULL;
> > -		kfree(mmpd_data);
> >  		ext4_warning(sb, "Unable to create kmmpd thread for
> > %s.", sb->s_id);
> >  		goto failed;
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index b9693680463a..539f89c5431f 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1244,8 +1244,8 @@ static void ext4_put_super(struct super_block
> > *sb) ext4_xattr_destroy_cache(sbi->s_ea_block_cache);
> >  	sbi->s_ea_block_cache = NULL;
> >  
> > -	if (sbi->s_mmp_tsk)
> > -		kthread_stop(sbi->s_mmp_tsk);
> > +	ext4_stop_mmpd(sbi);
> > +
> >  	brelse(sbi->s_sbh);
> >  	sb->s_fs_info = NULL;
> >  	/*
> > @@ -5156,8 +5156,7 @@ static int ext4_fill_super(struct super_block
> > *sb, void *data, int silent) failed_mount3:
> >  	flush_work(&sbi->s_error_work);
> >  	del_timer_sync(&sbi->s_err_report);
> > -	if (sbi->s_mmp_tsk)
> > -		kthread_stop(sbi->s_mmp_tsk);
> > +	ext4_stop_mmpd(sbi);
> >  failed_mount2:
> >  	rcu_read_lock();
> >  	group_desc = rcu_dereference(sbi->s_group_desc);
> > @@ -5952,8 +5951,7 @@ static int ext4_remount(struct super_block
> > *sb, int *flags, char *data) */
> >  				ext4_mark_recovery_complete(sb,
> > es); }
> > -			if (sbi->s_mmp_tsk)
> > -				kthread_stop(sbi->s_mmp_tsk);
> > +			ext4_stop_mmpd(sbi);
> >  		} else {
> >  			/* Make sure we can mount this feature set
> > readwrite */ if (ext4_has_feature_readonly(sb) ||
> 
