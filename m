Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828C02DA066
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Dec 2020 20:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502032AbgLNT0p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Dec 2020 14:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440454AbgLNT0Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 14 Dec 2020 14:26:16 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEDE6C0613D6
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:25:35 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id b2so18428516edm.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Dec 2020 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uGakVfnUHTotaBa8u50t+RuW90jXuEMteJbj2e6oUjA=;
        b=ZBrSEKxtZNtKx+vOiGN9Oxpjj7oMBAoEx0+GmFYdB4xCKIDpRu7FDirDAUOiSKllOC
         srfajQP0WfHJNP0mqzXcm57IDlNSNnt3DLMALni2/Rw9451w+C+Il+0JAg1DJ8SiY3jT
         gVpYc0S0V64fP5fa8MSQeE0kSL+HvTNRMTkehA83Uvx0sBqloy6mLrhMC5mLaVzOhbc9
         DCV4jxIjis73yAVKX1CVKh3d/sziWSvTSEriRjGz17UtRyOWFUvVEhsfmGrCon/kT7me
         WxjnWLv2/iKzd0PjmM9wLFX2NXeHt7vDQtfbKyIfHn7muZXXf4zH24GMGfKsCNp9iQ5x
         hV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uGakVfnUHTotaBa8u50t+RuW90jXuEMteJbj2e6oUjA=;
        b=ryRKWxyeD7WsykUab84vIINGshQzpXylifqnuk/lj8iE2JimKFYDQMBry3fPZwdmeu
         IVgEohswj584zibXZQtVYsFqSKucuEfAv1HWafL8R0oGr8wCmYjKmcWHigNQubNxOZpT
         CuQ5AMgkUy+xK8My0ZHuBrAef6C2Fj1UZFG7o6UDiP3zMaO8UZXc70tbeoUl1pH3uXTG
         76wNNBdver06UQGb7XvJvfu2e9op0LsXeF9vB94MAS1mGk3/CnX89xsDzarxiKDiBv4r
         t/pVv0lS/4O1QxwUulFgMpObG7IQQuN1bBbah0Lz/4KC+R/rtfiCmEdKNP0O9SgwV/mB
         SW8A==
X-Gm-Message-State: AOAM530lAxZSZbVA4MQfk/zrYsrQdoui928Re6zO0GjhuLaEEtxWrtWx
        N/P/mGkOo4Ru1xEYdwnInuE34XTHnz6CUM2ZfOA=
X-Google-Smtp-Source: ABdhPJwFg8tB7BEOYP3WC0+1Ig496VIvSqJKt0mQj22ZGPONqJVeWUlWTO9l787DTl6mZF8Z7CdvzOM1cx+Medehico=
X-Received: by 2002:a05:6402:1516:: with SMTP id f22mr25931013edw.382.1607973934534;
 Mon, 14 Dec 2020 11:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20201127113405.26867-1-jack@suse.cz> <20201127113405.26867-10-jack@suse.cz>
In-Reply-To: <20201127113405.26867-10-jack@suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 14 Dec 2020 11:25:23 -0800
Message-ID: <CAD+ocbw9WGMuDf0ytdvzPSgkvtVBxo=uROS7WqhYEHLs3nttBQ@mail.gmail.com>
Subject: Re: [PATCH 09/12] ext4: Drop sync argument of ext4_commit_super()
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Looks good to me.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Fri, Nov 27, 2020 at 10:25 AM Jan Kara <jack@suse.cz> wrote:
>
> Everybody passes 1 as sync argument of ext4_commit_super(). Just drop
> it.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 47 ++++++++++++++++++++++-------------------------
>  1 file changed, 22 insertions(+), 25 deletions(-)
>
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 73a09b73fc11..aae12ea1466a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -65,7 +65,7 @@ static struct ratelimit_state ext4_mount_msg_ratelimit;
>  static int ext4_load_journal(struct super_block *, struct ext4_super_block *,
>                              unsigned long journal_devnum);
>  static int ext4_show_options(struct seq_file *seq, struct dentry *root);
> -static int ext4_commit_super(struct super_block *sb, int sync);
> +static int ext4_commit_super(struct super_block *sb);
>  static int ext4_mark_recovery_complete(struct super_block *sb,
>                                         struct ext4_super_block *es);
>  static int ext4_clear_journal_err(struct super_block *sb,
> @@ -621,7 +621,7 @@ static void save_error_info(struct super_block *sb, int error,
>  {
>         __save_error_info(sb, error, ino, block, func, line);
>         if (!bdev_read_only(sb->s_bdev))
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>  }
>
>  /* Deal with the reporting of failure conditions on a filesystem such as
> @@ -686,7 +686,7 @@ static void flush_stashed_error_work(struct work_struct *work)
>         struct ext4_sb_info *sbi = container_of(work, struct ext4_sb_info,
>                                                 s_error_work);
>
> -       ext4_commit_super(sbi->s_sb, 1);
> +       ext4_commit_super(sbi->s_sb);
>  }
>
>  #define ext4_error_ratelimit(sb)                                       \
> @@ -1151,7 +1151,7 @@ static void ext4_put_super(struct super_block *sb)
>                 es->s_state = cpu_to_le16(sbi->s_mount_state);
>         }
>         if (!sb_rdonly(sb))
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>
>         rcu_read_lock();
>         group_desc = rcu_dereference(sbi->s_group_desc);
> @@ -2641,7 +2641,7 @@ static int ext4_setup_super(struct super_block *sb, struct ext4_super_block *es,
>         if (sbi->s_journal)
>                 ext4_set_feature_journal_needs_recovery(sb);
>
> -       err = ext4_commit_super(sb, 1);
> +       err = ext4_commit_super(sb);
>  done:
>         if (test_opt(sb, DEBUG))
>                 printk(KERN_INFO "[EXT4 FS bs=%lu, gc=%u, "
> @@ -4862,7 +4862,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>         if (DUMMY_ENCRYPTION_ENABLED(sbi) && !sb_rdonly(sb) &&
>             !ext4_has_feature_encrypt(sb)) {
>                 ext4_set_feature_encrypt(sb);
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>         }
>
>         /*
> @@ -5415,7 +5415,7 @@ static int ext4_load_journal(struct super_block *sb,
>                 es->s_journal_dev = cpu_to_le32(journal_devnum);
>
>                 /* Make sure we flush the recovery flag to disk. */
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>         }
>
>         return 0;
> @@ -5425,7 +5425,7 @@ static int ext4_load_journal(struct super_block *sb,
>         return err;
>  }
>
> -static int ext4_commit_super(struct super_block *sb, int sync)
> +static int ext4_commit_super(struct super_block *sb)
>  {
>         struct ext4_sb_info *sbi = EXT4_SB(sb);
>         struct ext4_super_block *es = EXT4_SB(sb)->s_es;
> @@ -5502,8 +5502,7 @@ static int ext4_commit_super(struct super_block *sb, int sync)
>
>         BUFFER_TRACE(sbh, "marking dirty");
>         ext4_superblock_csum_set(sb);
> -       if (sync)
> -               lock_buffer(sbh);
> +       lock_buffer(sbh);
>         if (buffer_write_io_error(sbh) || !buffer_uptodate(sbh)) {
>                 /*
>                  * Oh, dear.  A previous attempt to write the
> @@ -5519,16 +5518,14 @@ static int ext4_commit_super(struct super_block *sb, int sync)
>                 set_buffer_uptodate(sbh);
>         }
>         mark_buffer_dirty(sbh);
> -       if (sync) {
> -               unlock_buffer(sbh);
> -               error = __sync_dirty_buffer(sbh,
> -                       REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> -               if (buffer_write_io_error(sbh)) {
> -                       ext4_msg(sb, KERN_ERR, "I/O error while writing "
> -                              "superblock");
> -                       clear_buffer_write_io_error(sbh);
> -                       set_buffer_uptodate(sbh);
> -               }
> +       unlock_buffer(sbh);
> +       error = __sync_dirty_buffer(sbh,
> +               REQ_SYNC | (test_opt(sb, BARRIER) ? REQ_FUA : 0));
> +       if (buffer_write_io_error(sbh)) {
> +               ext4_msg(sb, KERN_ERR, "I/O error while writing "
> +                      "superblock");
> +               clear_buffer_write_io_error(sbh);
> +               set_buffer_uptodate(sbh);
>         }
>         return error;
>  }
> @@ -5559,7 +5556,7 @@ static int ext4_mark_recovery_complete(struct super_block *sb,
>
>         if (ext4_has_feature_journal_needs_recovery(sb) && sb_rdonly(sb)) {
>                 ext4_clear_feature_journal_needs_recovery(sb);
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>         }
>  out:
>         jbd2_journal_unlock_updates(journal);
> @@ -5601,7 +5598,7 @@ static int ext4_clear_journal_err(struct super_block *sb,
>
>                 EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
>                 es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> -               ext4_commit_super(sb, 1);
> +               ext4_commit_super(sb);
>
>                 jbd2_journal_clear_err(journal);
>                 jbd2_journal_update_sb_errno(journal);
> @@ -5703,7 +5700,7 @@ static int ext4_freeze(struct super_block *sb)
>                 ext4_clear_feature_journal_needs_recovery(sb);
>         }
>
> -       error = ext4_commit_super(sb, 1);
> +       error = ext4_commit_super(sb);
>  out:
>         if (journal)
>                 /* we rely on upper layer to stop further updates */
> @@ -5725,7 +5722,7 @@ static int ext4_unfreeze(struct super_block *sb)
>                 ext4_set_feature_journal_needs_recovery(sb);
>         }
>
> -       ext4_commit_super(sb, 1);
> +       ext4_commit_super(sb);
>         return 0;
>  }
>
> @@ -5985,7 +5982,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
>         }
>
>         if (sbi->s_journal == NULL && !(old_sb_flags & SB_RDONLY)) {
> -               err = ext4_commit_super(sb, 1);
> +               err = ext4_commit_super(sb);
>                 if (err)
>                         goto restore_opts;
>         }
> --
> 2.16.4
>
