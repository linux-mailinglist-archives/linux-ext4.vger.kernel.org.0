Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7FB304906
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Jan 2021 20:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbhAZFea (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Jan 2021 00:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbhAZCDc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 21:03:32 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC9C061797;
        Mon, 25 Jan 2021 16:21:28 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id u4so697536pjn.4;
        Mon, 25 Jan 2021 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJgAgQP11zokYfGVBujFOzsobumPVUSFg2V2m/PgB6o=;
        b=OeoEzKs9iAFX8/BeqfqPipxRkleqtnWRdmDMD8chcVl03j4u4ZwPXcuCOKurjfh/P1
         qkJZJzi8TDx+4DJAH+ps2vpKt8D1JUFkN1ST96z9oU9ozPiTSl8PBRc5cfF6axK6h9zi
         XI7yR5rbczgPl6xszy6bmZQGkx/cuf5orYq9IScvttfCLQr+6VWqXDngzKMCv30FxeQW
         gl+uajegBYNtgnidpPuZP9BMw7Jg+5VZHbMVPcT9mOoLPbeOhgC+bpzZ9ot9PP+WoFY1
         Bg5kUhAkuiZAqIhGxBdIONr7fBlMF++Oh09xU7frX6fJlkaKOPQY1HkANlCz8aSgatXG
         e0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJgAgQP11zokYfGVBujFOzsobumPVUSFg2V2m/PgB6o=;
        b=FUAgwWfNMKVa4xVhTJos9XGk/Z3OnqmxeFof7rW1rSqAH2vOHgdQ8XRgzJ9fW/Ab5h
         Vsya8WTK46NIGLDXyzwGi46VVyzM6YneDh2XvCKBMKkiGuBW5hmygBjASM33kt1aN2Ug
         Slv/Glzuqjdx8OKsmhYutj1fTJO4OHdtrDYzX45T+QAaHmd7YFAetssFY12zObyftImj
         kH1UwekQgC9RfpBzKqDVOvGXZV+AKvwyl+JcxbQ8Ti/K0NFfBv8Aj/F80IOGbT0fx1GO
         s8ilYo2+OEXCRVGz9WP/byU/g64ImGIVm6lhiQ/6EQ3IdFU9BIXDlzxD0Ivmp8Pw5xFh
         DisQ==
X-Gm-Message-State: AOAM531pwsdIyzlXAeX0xfMqq2rVfo2JpVUrOLHM4X3LT+byC/9+RIRj
        +D2ApL3eJc7Q+yLZf/Irn2zeaCX6UKBOjb0W
X-Google-Smtp-Source: ABdhPJwdN2PSGcAKJxECxKhru6o8AkmRJkwKT3ibdDYUc5n+TyrNSc8V1SjBL+R6kGj1ONYUGVIgmw==
X-Received: by 2002:a17:90b:3111:: with SMTP id gc17mr2890786pjb.164.1611620487511;
        Mon, 25 Jan 2021 16:21:27 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.50])
        by smtp.gmail.com with ESMTPSA id a31sm17671665pgb.93.2021.01.25.16.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 16:21:26 -0800 (PST)
Subject: Re: [RFC PATCH v2 1/4] jbd2: make jdb2_debug module parameter per
 device
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, jack@suse.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1611402263.git.brookxu@tencent.com>
 <2364f54ebe6b03d4d12802531175f0b4cd2857ae.1611402263.git.brookxu@tencent.com>
 <CAD+ocbx18bb-UB79wcqMDMZmjCzUKUtUBEH9wKApyrUD8KpXxQ@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <ef1ff688-a549-f1b7-7a80-a281e45abe3f@gmail.com>
Date:   Tue, 26 Jan 2021 08:21:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAD+ocbx18bb-UB79wcqMDMZmjCzUKUtUBEH9wKApyrUD8KpXxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



harshad shirwadkar wrote on 2021/1/26 1:15:
> Hey hi! I don't see my previous comments being handled here or am I
> missing something? It'd be really handy to have the device name
> printed in jbd2 logs.

Maybe I miss something..,the origin switch has been reserved, the new added
switch and the origin switch together determine whether the log of a certain
device is finally output. . Also, I will add device information to the next
version.thanks.

> On Sat, Jan 23, 2021 at 4:01 AM Chunguang Xu <brookxu.cn@gmail.com> wrote:
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> On a multi-disk machine, because jbd2's debugging switch is global,this
>> confuses the logs of multiple disks. It is not easy to distinguish the
>> logs of each disk and the amount of generated logs is very large. Maybe
>> a separate debugging switch for each disk would be better, so that we
>> can easily distinguish the logs of a certain disk.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>> ---
>>  fs/jbd2/journal.c     | 55 ++++++++++++++++++++++++++++++++++++++++---
>>  fs/jbd2/transaction.c |  2 +-
>>  include/linux/jbd2.h  |  7 ++++++
>>  3 files changed, 60 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 2dc944442802..1f32b854ea28 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -101,13 +101,13 @@ EXPORT_SYMBOL(jbd2_inode_cache);
>>  static int jbd2_journal_create_slab(size_t slab_size);
>>
>>  #ifdef CONFIG_JBD2_DEBUG
>> -void __jbd2_debug(int level, const char *file, const char *func,
>> +void jbd2_log(int level, journal_t *j, const char *file, const char *func,
>>                   unsigned int line, const char *fmt, ...)
>>  {
>>         struct va_format vaf;
>>         va_list args;
>>
>> -       if (level > jbd2_journal_enable_debug)
>> +       if (!j || (level > jbd2_journal_enable_debug && level > j->j_debug_level))
>>                 return;
>>         va_start(args, fmt);
>>         vaf.fmt = fmt;
>> @@ -115,7 +115,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
>>         printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
>>         va_end(args);
>>  }
>> -EXPORT_SYMBOL(__jbd2_debug);
>> +EXPORT_SYMBOL(jbd2_log);
>>  #endif
>>
>>  /* Checksumming functions */
>> @@ -1257,6 +1257,48 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
>>         return seq_release(inode, file);
>>  }
>>
>> +#ifdef CONFIG_JBD2_DEBUG
>> +static int jbd2_proc_debug_show(struct seq_file *m, void *v)
>> +{
>> +       journal_t *j = m->private;
>> +
>> +       seq_printf(m, "%d\n", j->j_debug_level);
>> +       return 0;
>> +}
>> +
>> +static int jbd2_proc_debug_open(struct inode *inode, struct file *file)
>> +{
>> +       journal_t *journal = PDE_DATA(inode);
>> +
>> +       return single_open(file, jbd2_proc_debug_show, journal);
>> +}
>> +
>> +static ssize_t jbd2_proc_debug_write(struct file *file,
>> +               const char __user *buffer, size_t count, loff_t *ppos)
>> +{
>> +       struct seq_file *seq = file->private_data;
>> +       journal_t *j = seq->private;
>> +       char c;
>> +
>> +       if (get_user(c, buffer))
>> +               return -EFAULT;
>> +
>> +       if (c < '0' || c > '5')
>> +               return -EINVAL;
>> +
>> +       j->j_debug_level = c - '0';
>> +       return count;
>> +}
>> +
>> +static const struct proc_ops jbd2_debug_proc_ops = {
>> +       .proc_open      = jbd2_proc_debug_open,
>> +       .proc_read      = seq_read,
>> +       .proc_write     = jbd2_proc_debug_write,
>> +       .proc_release   = single_release,
>> +       .proc_lseek     = seq_lseek,
>> +};
>> +#endif
>> +
>>  static const struct proc_ops jbd2_info_proc_ops = {
>>         .proc_open      = jbd2_seq_info_open,
>>         .proc_read      = seq_read,
>> @@ -1272,12 +1314,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
>>         if (journal->j_proc_entry) {
>>                 proc_create_data("info", S_IRUGO, journal->j_proc_entry,
>>                                  &jbd2_info_proc_ops, journal);
>> +#ifdef CONFIG_JBD2_DEBUG
>> +               proc_create_data("jbd2_debug", S_IRUGO, journal->j_proc_entry,
>> +                                &jbd2_debug_proc_ops, journal);
>> +#endif
>>         }
>>  }
>>
>>  static void jbd2_stats_proc_exit(journal_t *journal)
>>  {
>>         remove_proc_entry("info", journal->j_proc_entry);
>> +#ifdef CONFIG_JBD2_DEBUG
>> +       remove_proc_entry("jbd2_debug", journal->j_proc_entry);
>> +#endif
>>         remove_proc_entry(journal->j_devname, proc_jbd2_stats);
>>  }
>>
>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index 9396666b7314..71787e826788 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -150,7 +150,7 @@ static inline void update_t_max_wait(transaction_t *transaction,
>>                                      unsigned long ts)
>>  {
>>  #ifdef CONFIG_JBD2_DEBUG
>> -       if (jbd2_journal_enable_debug &&
>> +       if ((jbd2_journal_enable_debug || transaction->t_journal->j_debug_level) &&
>>             time_after(transaction->t_start, ts)) {
>>                 ts = jbd2_time_diff(ts, transaction->t_start);
>>                 spin_lock(&transaction->t_handle_lock);
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 99d3cd051ac3..600a2ea8324a 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1211,6 +1211,13 @@ struct journal_s
>>          */
>>         struct transaction_stats_s j_stats;
>>
>> +#ifdef CONFIG_JBD2_DEBUG
>> +       /**
>> +        * @j_debug_level: debugging level for jbd2.
>> +        */
>> +       unsigned int j_debug_level;
>> +#endif
>> +
>>         /**
>>          * @j_failed_commit: Failed journal commit ID.
>>          */
>> --
>> 2.30.0
>>
