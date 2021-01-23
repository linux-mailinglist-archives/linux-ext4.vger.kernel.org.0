Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF5930128D
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 04:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbhAWDQe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 22:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbhAWDQ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 22:16:28 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50860C06174A;
        Fri, 22 Jan 2021 19:15:48 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w18so5077811pfu.9;
        Fri, 22 Jan 2021 19:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MqEg3AXJCGnfDEjdnM6R+MZyPNmwSGFNN/i99lEytuc=;
        b=dB9dNGxe9/nVVLDWdR5RF2PMhxYqwI6Q313PPv9YQTu+ICzz0PAd96DLBmuLMJQVl7
         JgiHhkckJ7kXTdi5xhNVm24+CPJcleIHYEMkwAGetd8RNKpWm/K3qcJueLyArXU8PKBL
         jIDyWbWoXtBmT+ms2QyK9NaPXJO8Gq2kbYIdmUv82SDToUbcA0DdT+rorBPJbYtJTIE4
         m6HYdmF9A/Bi5T0ivExFYbetKRd+RLGZ3MyvvpxJxBaeKgD1pIFRx29a+28jblMFFNsv
         nqT+3DHBK8YEluhBteSNnl1IlsQ/r0rdtSahbpHvMRse85AMJc4m4gsOyHd+CrTyK+h0
         Y+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MqEg3AXJCGnfDEjdnM6R+MZyPNmwSGFNN/i99lEytuc=;
        b=Rl3Y0ZEsB5um7nFcktKIcKDi6VI5kkAL67E3RpIyAiFsLGV5SOZL5/Gqsv/uY/AE4N
         H4MTXjHadhSvmcxWD0NYdDwnLs1o+/ksuvAlYvswjTmWRBDbLUo8A+EjHPh6LUjwkJRy
         lMtImPgd95Lnk28QUL4FZaarqZJ53Mald82sXNxEv3tFoHQDWoTY54oaZx7KRsJjmZnk
         IkUJ+1+K2X4Hr2P8knrFWIG+OhiQnLa9X6yTuKHa/Z3vb0cROM/iaOX9IG9k2H7n/lFQ
         03eTt8AybqBxBNvknUUPeS1hoJ980iBXwbKpdYpaYlO7mW67EDsUO4cjoYu9S59VmhxK
         F9HA==
X-Gm-Message-State: AOAM533qvFzlQWdPxt5AximW8+caKW5amxt72S44rDK4/X28UZHd/f+/
        W+oM1mXCF7yqdYaApzNPItq1Ks/WwUXBtw==
X-Google-Smtp-Source: ABdhPJz+HbOML5A1UmLBuejQl3uOmZiERasS47xvE2K3ZGgvReTd664mj7FxwQCFv7r9hykht3HPgg==
X-Received: by 2002:a63:fc56:: with SMTP id r22mr4675327pgk.3.1611371747660;
        Fri, 22 Jan 2021 19:15:47 -0800 (PST)
Received: from [127.0.0.1] ([203.205.141.51])
        by smtp.gmail.com with ESMTPSA id a189sm10830817pfd.117.2021.01.22.19.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jan 2021 19:15:47 -0800 (PST)
Subject: Re: [RFC PATCH 1/4] jbd2: make jdb2_debug module parameter per device
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>, jack@suse.com,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <cover.1611287342.git.brookxu@tencent.com>
 <b5a6fbe941f61289f15d84d9cad42df912daee7f.1611287342.git.brookxu@tencent.com>
 <CAD+ocbwonrZbaEsZ2L+e8QiRxsy56xdhaUYkLkPPdKBKPyE+vg@mail.gmail.com>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <6f72c639-53a7-411c-4672-f559fd63d347@gmail.com>
Date:   Sat, 23 Jan 2021 11:15:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAD+ocbwonrZbaEsZ2L+e8QiRxsy56xdhaUYkLkPPdKBKPyE+vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

En...，your idea maybe better, thanks for your time.

harshad shirwadkar wrote on 2021/1/23 3:00:
> I wonder if we should retain the existing module param as well apart
> from the new device specific logging switch? If that switch is
> enabled, we'll get jbd2 logs for all the devices. Given that the old
> jbd2_debug interface was a module param, I wonder somebody somewhere
> might have infrastructure on top of that to enable debugging for jbd2?
> And by removing this interface we may accidentally break them?
> 
> On Thu, Jan 21, 2021 at 10:48 PM Chunguang Xu <brookxu.cn@gmail.com> wrote:
>>
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> On a multi-disk machine, because jbd2's debugging switch is global,this
>> confuses the logs of multiple disks. It is not easy to distinguish the
>> logs of each disk and the amount of generated logs is very large. Or a
>> separate debugging switch for each disk would be better, so that you
>> can easily distinguish the logs of a certain disk.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
>> ---
>>  fs/jbd2/journal.c     | 63 +++++++++++++++++++++++++++++++++++--------
>>  fs/jbd2/transaction.c |  2 +-
>>  include/linux/jbd2.h  |  7 +++++
>>  3 files changed, 60 insertions(+), 12 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 2dc944442802..ae147cc713c7 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -48,14 +48,6 @@
>>  #include <linux/uaccess.h>
>>  #include <asm/page.h>
>>
>> -#ifdef CONFIG_JBD2_DEBUG
>> -ushort jbd2_journal_enable_debug __read_mostly;
>> -EXPORT_SYMBOL(jbd2_journal_enable_debug);
>> -
>> -module_param_named(jbd2_debug, jbd2_journal_enable_debug, ushort, 0644);
>> -MODULE_PARM_DESC(jbd2_debug, "Debugging level for jbd2");
>> -#endif
>> -
>>  EXPORT_SYMBOL(jbd2_journal_extend);
>>  EXPORT_SYMBOL(jbd2_journal_stop);
>>  EXPORT_SYMBOL(jbd2_journal_lock_updates);
>> @@ -101,13 +93,13 @@ EXPORT_SYMBOL(jbd2_inode_cache);
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
>> +       if (!j || level > j->j_debug_level)
>>                 return;
>>         va_start(args, fmt);
>>         vaf.fmt = fmt;
>> @@ -115,7 +107,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
>>         printk(KERN_DEBUG "%s: (%s, %u): %pV", file, func, line, &vaf);
> Now that you have journal_t passed to jbd2_log, it would also be good
> to print the name of the device in this message. I think you can use
> j->j_devname for that.
> 
> Thanks,
> Harshad
>>         va_end(args);
>>  }
>> -EXPORT_SYMBOL(__jbd2_debug);
>> +EXPORT_SYMBOL(jbd2_log);
>>  #endif
>>
>>  /* Checksumming functions */
>> @@ -1257,6 +1249,48 @@ static int jbd2_seq_info_release(struct inode *inode, struct file *file)
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
>> @@ -1272,12 +1306,19 @@ static void jbd2_stats_proc_init(journal_t *journal)
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
>> index 9396666b7314..f25c6ff16165 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -150,7 +150,7 @@ static inline void update_t_max_wait(transaction_t *transaction,
>>                                      unsigned long ts)
>>  {
>>  #ifdef CONFIG_JBD2_DEBUG
>> -       if (jbd2_journal_enable_debug &&
>> +       if (transaction->t_journal->j_debug_level &&
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
