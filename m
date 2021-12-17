Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87847955F
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 21:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhLQUUb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 15:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbhLQUUb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 15:20:31 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31464C061574
        for <linux-ext4@vger.kernel.org>; Fri, 17 Dec 2021 12:20:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so12446114edd.0
        for <linux-ext4@vger.kernel.org>; Fri, 17 Dec 2021 12:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7Gnlptmb4fvfdMWnbwsJPEurJMHugjJYproZ2OfvZg=;
        b=ZX2GfmseMaR4kfgPi6kHGaeE9/0mVnw7xoKjjzcTsa6zBenvxufiNY3YPdXS/oWoMs
         ereI4wCu//pdlJ+3gvVOwFagx7nG+Xy80Ln1shIHYaCjlOyzkJM80VCfCruZXYUsZkyw
         kySMbxgLdhKu6s0nzFuN4kLCbcimku7nvjPVPZN/B30DraBRhsYhuUyJ8AxEEPkQGl5M
         4IzBUoBd3hHqMQjXNGLhs27ys+B6eMa+Gy1agJ69dbSW99+jjgk8nOzCWQH6uPyBLl6J
         lbzBI8w1BeAj28gUsCK9bimX8K+VuwU4K+wcRl6s6BNH5NLe6v/+dNzlpRT1y2U+r31G
         ZzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7Gnlptmb4fvfdMWnbwsJPEurJMHugjJYproZ2OfvZg=;
        b=640jGoWDJhGWt8GTWbaOdIBSNBnVYbHyqgSne5jIRlk3CP2jPzYWqudfTOwFhNPl76
         Js/qXbuWVOQ9AHy7JU5EqQiZQHQrtbT4Un+PWSc+Uq03cgcH1Vj9Kj58ndB2DcSFpr8w
         hu7mK1mLrq91H4XM1ZPkMXw+lQji4u4B6Sm+Iwsxn8bBHZWrfLPT1GSgl7MvlTNUmYdi
         lPgQVHYkmAUeLPuyR7OtzpvOGdKYGr0TiZLp/PiCwVLfN8RXsBj/LN0R4pkMSQu1tdvU
         gRMnd86HBUvZwLsBuYXVaI/U4WgVUHuDrja438gitqq7KkoSqVGKapIjCjxKx6Zmpahy
         z2lA==
X-Gm-Message-State: AOAM531oF7nKe3JazLasyhIrJFH+wSYrZZJntHmWZ5v6QZY8zDFciJLb
        OtUMBVP+PhEzk+gm27BciFFO7TvbWWWnj+puXhM=
X-Google-Smtp-Source: ABdhPJyTD+RvSlOC/de3BJZYf0W5hskcy3NTh2+ALDZLM4mEFUQ5o+T2zVKIRjmL/5ycc9iosBF8dCmzCTOWhpBPVMg=
X-Received: by 2002:a50:ff10:: with SMTP id a16mr4360113edu.275.1639772429554;
 Fri, 17 Dec 2021 12:20:29 -0800 (PST)
MIME-Version: 1.0
References: <YbiK3JetFFl08bd7@linutronix.de>
In-Reply-To: <YbiK3JetFFl08bd7@linutronix.de>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 17 Dec 2021 12:20:18 -0800
Message-ID: <CAD+ocbzQLgjeQz6Sz7YGF45=P0nqLTYh8XBsc_OjQirrjFOLeg@mail.gmail.com>
Subject: Re: [PATCH REPOST] ext4: Destroy ext4_fc_dentry_cachep kmemcache on
 module removal.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lukas Czerner <lczerner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Sebastian for the patch, it looks good.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Tue, Dec 14, 2021 at 9:35 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> The kmemcache for ext4_fc_dentry_cachep remains registered after module
> removal.
>
> Destroy ext4_fc_dentry_cachep kmemcache on module removal.
>
> Fixes: aa75f4d3daaeb ("ext4: main fast-commit commit path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>
> Link: https://lore.kernel.org/r/20211110134640.lyku5vklvdndw6uk@linutronix.de
> ---
>  fs/ext4/ext4.h        | 1 +
>  fs/ext4/fast_commit.c | 5 +++++
>  fs/ext4/super.c       | 2 ++
>  3 files changed, 8 insertions(+)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 404dd50856e5d..af7088085d4e4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2935,6 +2935,7 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
>  void ext4_fc_replay_cleanup(struct super_block *sb);
>  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
>  int __init ext4_fc_init_dentry_cache(void);
> +void ext4_fc_destroy_dentry_cache(void);
>
>  /* mballoc.c */
>  extern const struct seq_operations ext4_mb_seq_groups_ops;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 0f32b445582ab..4665508efd778 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -2192,3 +2192,8 @@ int __init ext4_fc_init_dentry_cache(void)
>
>         return 0;
>  }
> +
> +void ext4_fc_destroy_dentry_cache(void)
> +{
> +       kmem_cache_destroy(ext4_fc_dentry_cachep);
> +}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4e33b5eca694d..71185a217d05b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6649,6 +6649,7 @@ static int __init ext4_init_fs(void)
>  out:
>         unregister_as_ext2();
>         unregister_as_ext3();
> +       ext4_fc_destroy_dentry_cache();
>  out05:
>         destroy_inodecache();
>  out1:
> @@ -6675,6 +6676,7 @@ static void __exit ext4_exit_fs(void)
>         unregister_as_ext2();
>         unregister_as_ext3();
>         unregister_filesystem(&ext4_fs_type);
> +       ext4_fc_destroy_dentry_cache();
>         destroy_inodecache();
>         ext4_exit_mballoc();
>         ext4_exit_sysfs();
> --
> 2.34.1
>
