Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7830289E
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Jan 2021 18:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbhAYRS5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jan 2021 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbhAYRQ5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 12:16:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE57C06174A;
        Mon, 25 Jan 2021 09:16:03 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ox12so19198221ejb.2;
        Mon, 25 Jan 2021 09:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YqcYHGl5kc5AGV7qWqhvdn3PB9MvMhkNCXy7zys9qA=;
        b=kvu0MpaNyCzkABePF0XIVU3JS4qw8vKXFkeJQglHoZ06yxPvupUSzHRG0IE8f2H496
         HeHZhAkWIGhEGbep1HOvyHCUnEU6AvUu8+BKOI0KlJ4vGi5/3kU6iWEm3naB8em+qtBM
         FEOCDnf1/lDjdL1EDhLYA1YRAg+QTKrcaAwwa4fMwS0bKRpRPck8hHh5hYQou7csdb0m
         KTiU1Ri0v/blrh1rcDa2YQa6B1NIsvJoR00u4wQlADttlaBvrJK0wbH0y/CGiUq+9ipn
         uzQkPPAue+sSlfTCG+xHw5ZGxGDNxWorGx0+TmkNT/6nnZ7MYesSMh6pERR+r3Hz8+Kg
         rI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YqcYHGl5kc5AGV7qWqhvdn3PB9MvMhkNCXy7zys9qA=;
        b=nATYEdjxJ9tNn/NPEZU0FPhZTQ9+nFqEemta+qeccou4UdWpe7O0T8XCv9flMdl594
         q0TGZAunyjD9e0NX2gPwedJfoqyhWVAu3zc5l2hFNI7ueQEOHc0uukMyD7saq/jNiGoh
         CDeJLxfPO6M6YIEmDa8w7PyxK9ldt4mXvvlTFH2p9IDDvzhsSEWymkFxfQg296P+7Oeq
         V/cLXHJKC1vJgZC+pJwRmYT/uNl3syvvWSeURpb6qaCZAPS/RqiLit4btp2UU/uf1ru4
         UgUUP9s29RUzetGE06LPYoNPQgA3RTMABUe5NBb/E6sqm0DJUwX+RH95V1vbmd1tLExL
         l53Q==
X-Gm-Message-State: AOAM533XeQa45GI7Kz6CYBYo1/uozgRF/GV4T4Mno2MjdgCsR+wCOtZX
        J4rThhv512hrAVI86vhwL/JcFwuvbL4IBTi6ogY=
X-Google-Smtp-Source: ABdhPJxmm+T6Vb9bMo1e/GZSfgKWxonHYHJecfXWdWv7KRaqwbDG4zw7SrggFJWN2K/kSGu3IXnvNhXFrywIOeE+yac=
X-Received: by 2002:a17:907:3e27:: with SMTP id hp39mr983168ejc.187.1611594962398;
 Mon, 25 Jan 2021 09:16:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611402263.git.brookxu@tencent.com> <2364f54ebe6b03d4d12802531175f0b4cd2857ae.1611402263.git.brookxu@tencent.com>
In-Reply-To: <2364f54ebe6b03d4d12802531175f0b4cd2857ae.1611402263.git.brookxu@tencent.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 25 Jan 2021 09:15:51 -0800
Message-ID: <CAD+ocbx18bb-UB79wcqMDMZmjCzUKUtUBEH9wKApyrUD8KpXxQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] jbd2: make jdb2_debug module parameter per device
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, jack@suse.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey hi! I don't see my previous comments being handled here or am I
missing something? It'd be really handy to have the device name
printed in jbd2 logs.

On Sat, Jan 23, 2021 at 4:01 AM Chunguang Xu <brookxu.cn@gmail.com> wrote:
>
> From: Chunguang Xu <brookxu@tencent.com>
>
> On a multi-disk machine, because jbd2's debugging switch is global,this
> confuses the logs of multiple disks. It is not easy to distinguish the
> logs of each disk and the amount of generated logs is very large. Maybe
> a separate debugging switch for each disk would be better, so that we
> can easily distinguish the logs of a certain disk.
>
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>  fs/jbd2/journal.c     | 55 ++++++++++++++++++++++++++++++++++++++++---
>  fs/jbd2/transaction.c |  2 +-
>  include/linux/jbd2.h  |  7 ++++++
>  3 files changed, 60 insertions(+), 4 deletions(-)
>
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 2dc944442802..1f32b854ea28 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -101,13 +101,13 @@ EXPORT_SYMBOL(jbd2_inode_cache);
>  static int jbd2_journal_create_slab(size_t slab_size);
>
>  #ifdef CONFIG_JBD2_DEBUG
> -void __jbd2_debug(int level, const char *file, const char *func,
> +void jbd2_log(int level, journal_t *j, const char *file, const char *func,
>                   unsigned int line, const char *fmt, ...)
>  {
>         struct va_format vaf;
>         va_list args;
>
> -       if (level > jbd2_journal_enable_debug)
> +       if (!j || (level > jbd2_journal_enable_debug && level > j->j_debug_level))
>                 return;
>         va_start(args, fmt);
>         vaf.fmt = fmt;
> @@ -115,7 +115,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
>         printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
>         va_end(args);
>  }
> -EXPORT_SYMBOL(__jbd2_debug);
> +EXPORT_SYMBOL(jbd2_log);
>  #endif
>
>  /* Checksumming functions */
> @@ -1257,6 +1257,48 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
>         return seq_release(inode, file);
>  }
>
> +#ifdef CONFIG_JBD2_DEBUG
> +static int jbd2_proc_debug_show(struct seq_file *m, void *v)
> +{
> +       journal_t *j = m->private;
> +
> +       seq_printf(m, "%d\n", j->j_debug_level);
> +       return 0;
> +}
> +
> +static int jbd2_proc_debug_open(struct inode *inode, struct file *file)
> +{
> +       journal_t *journal = PDE_DATA(inode);
> +
> +       return single_open(file, jbd2_proc_debug_show, journal);
> +}
> +
> +static ssize_t jbd2_proc_debug_write(struct file *file,
> +               const char __user *buffer, size_t count, loff_t *ppos)
> +{
> +       struct seq_file *seq = file->private_data;
> +       journal_t *j = seq->private;
> +       char c;
> +
> +       if (get_user(c, buffer))
> +               return -EFAULT;
> +
> +       if (c < '0' || c > '5')
> +               return -EINVAL;
> +
> +       j->j_debug_level = c - '0';
> +       return count;
> +}
> +
> +static const struct proc_ops jbd2_debug_proc_ops = {
> +       .proc_open      = jbd2_proc_debug_open,
> +       .proc_read      = seq_read,
> +       .proc_write     = jbd2_proc_debug_write,
> +       .proc_release   = single_release,
> +       .proc_lseek     = seq_lseek,
> +};
> +#endif
> +
>  static const struct proc_ops jbd2_info_proc_ops = {
>         .proc_open      = jbd2_seq_info_open,
>         .proc_read      = seq_read,
> @@ -1272,12 +1314,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
>         if (journal->j_proc_entry) {
>                 proc_create_data("info", S_IRUGO, journal->j_proc_entry,
>                                  &jbd2_info_proc_ops, journal);
> +#ifdef CONFIG_JBD2_DEBUG
> +               proc_create_data("jbd2_debug", S_IRUGO, journal->j_proc_entry,
> +                                &jbd2_debug_proc_ops, journal);
> +#endif
>         }
>  }
>
>  static void jbd2_stats_proc_exit(journal_t *journal)
>  {
>         remove_proc_entry("info", journal->j_proc_entry);
> +#ifdef CONFIG_JBD2_DEBUG
> +       remove_proc_entry("jbd2_debug", journal->j_proc_entry);
> +#endif
>         remove_proc_entry(journal->j_devname, proc_jbd2_stats);
>  }
>
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index 9396666b7314..71787e826788 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -150,7 +150,7 @@ static inline void update_t_max_wait(transaction_t *transaction,
>                                      unsigned long ts)
>  {
>  #ifdef CONFIG_JBD2_DEBUG
> -       if (jbd2_journal_enable_debug &&
> +       if ((jbd2_journal_enable_debug || transaction->t_journal->j_debug_level) &&
>             time_after(transaction->t_start, ts)) {
>                 ts = jbd2_time_diff(ts, transaction->t_start);
>                 spin_lock(&transaction->t_handle_lock);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..600a2ea8324a 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1211,6 +1211,13 @@ struct journal_s
>          */
>         struct transaction_stats_s j_stats;
>
> +#ifdef CONFIG_JBD2_DEBUG
> +       /**
> +        * @j_debug_level: debugging level for jbd2.
> +        */
> +       unsigned int j_debug_level;
> +#endif
> +
>         /**
>          * @j_failed_commit: Failed journal commit ID.
>          */
> --
> 2.30.0
>
