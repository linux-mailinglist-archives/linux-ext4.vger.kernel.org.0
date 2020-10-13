Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75828C5A8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgJMA2J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMA2J (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:28:09 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502E4C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id qp15so25796202ejb.3
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWCNVJNll8U86YvQOhAJ/su5hqzqBQSw7bij6/EPRw0=;
        b=PChOqeJ7WrCi+dylFIjaYIk1gUmo5Rx3evEuddZxskM7udvjbT3naUB/jd0RIaKYDf
         Hv4hOtZ3box3ol+DQAXrQeIswnKqQoMBk6Xe9JKeMQ+L9AaPpxSZWM32lWIR2aAxkUDr
         YUEko6wfyNubVbcmCnigyIAy3NHcGdayn0Vxx1KnGZ7psyVuhQqpAX1m+JWgKINxYQvh
         PbB3yguUAXK0kfbKXtMb7el4R04xWQ2PQpUf6EwQjOJGXWZ2fJcP7cksyShLagH0QO1S
         dhLWk90RkdqcQWCY1x/EJaXcjm0GkRsMQgunFwVMoCT49pTWydh2xxZ8T18W9p3KEIru
         TXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWCNVJNll8U86YvQOhAJ/su5hqzqBQSw7bij6/EPRw0=;
        b=L+1I0Has6d2sudKOiGBNOUYp0HyD+wKtd0DzXKsJ7VFJa1tT2D5thl8/jkmjLXrFf7
         OFcF7YXfN1uRxJSoONNTd+8qgR6/i76a+MFztqqXzcPy5jVmQRfzvYWzmBRZhMMUO4TQ
         RDxzSE84BxcrdY2ogCtW+LGPoJHAVQ4lH05ebeeqib99ZOgeuuUf9u6LoMSwdevKHiTl
         OBSlfNlsInGQ5pEcKKrznH5QSBHmAS3x7EB7d8VoGIwrwQ3to87hIZilmdm2nQ5yKSGD
         EsYstseXNDgYvGTYriPCILrf9ti1pRfOsWdnL6DAlTb67V4SIiISl7n+kVDjjqDQQM+8
         3uUg==
X-Gm-Message-State: AOAM530QtSR42TH6FxXL8DxkfTIiLP/pEkPajQnJNlS3PYX22aP+DRXV
        bglgy6TlVVaPnu+7b+6zDf3bwyK3Bg44+ZG5gX8=
X-Google-Smtp-Source: ABdhPJzIeqEKLYtTHHvEg6DF1PKpNde7nidW+udADSJdcgNkIZ3/Fh/LkGZOKBLzqjNTYuXjjg7eo9+LJcXskjc8Gj0=
X-Received: by 2002:a17:906:a985:: with SMTP id jr5mr31905121ejb.549.1602548887892;
 Mon, 12 Oct 2020 17:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-5-harshadshirwadkar@gmail.com> <96e9210e-f0d1-eaf6-593b-7fae982a8df2@linux.ibm.com>
In-Reply-To: <96e9210e-f0d1-eaf6-593b-7fae982a8df2@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:27:56 -0700
Message-ID: <CAD+ocbwJ9u=RHA3gpTqFL6vUSAfjZwoTdUeBy+x+peGAaXrbuA@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] jbd2: add fast commit machinery
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 9, 2020 at 9:16 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> > This patch implements following APIs in JBD2 to allow for fast
> > commits:
> >
> > jbd2_fc_start(): Start a new fast commit. This function waits for any
> > existing fast commit or full commit to complete.
> >
> > jbd2_fc_stop(): Stop fast commit. This function ends current fast
> > commit and wakes up either the journal thread or the other fast commit
> > waiting for current fast commit to complete.
> >
> > jbd2_fc_stop_do_commit(): Stop fast commit and perform a full
> > commit. This is same as above but also performs a full commit.
> >
> > This patch also adds a cleanup handler in journal_t that is called
> > after every full and fast commit.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >   fs/ext4/fast_commit.c |  8 ++++++
> >   fs/jbd2/commit.c      | 19 ++++++++++++
> >   fs/jbd2/journal.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
> >   include/linux/jbd2.h  | 21 ++++++++++++++
> >   4 files changed, 115 insertions(+)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 0dad8bdb1253..f2d11b4c6b62 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -8,11 +8,19 @@
> >    * Ext4 fast commits routines.
> >    */
> >   #include "ext4_jbd2.h"
> > +/*
> > + * Fast commit cleanup routine. This is called after every fast commit and
> > + * full commit. full is true if we are called after a full commit.
> > + */
> > +static void ext4_fc_cleanup(journal_t *journal, int full)
> > +{
> > +}
> >
> >   void ext4_fc_init(struct super_block *sb, journal_t *journal)
> >   {
> >       if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> >               return;
> > +     journal->j_fc_cleanup_callback = ext4_fc_cleanup;
> >       if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
> >               pr_warn("Error while enabling fast commits, turning off.");
> >               ext4_clear_feature_fast_commit(sb);
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index 6d2da8ad0e6f..ba35ecb18616 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -413,6 +413,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >       J_ASSERT(journal->j_running_transaction != NULL);
> >       J_ASSERT(journal->j_committing_transaction == NULL);
> >
> > +     write_lock(&journal->j_state_lock);
> > +     journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
>
> Shouldn't we set this flag only after the while loop ends and before
> releasing the write lock()? Like how we are doing in jbd2_fc_start()?
The reason why we need to do this before the while loop is to ensure
that a full commit takes priority over a fast commit. So, if we have
reached here, we are going to perform a full commit. Setting this flag
before the while loop ensures that any other ext4 sync operations that
may start after we have entered this while loop don't start another
fast commit. This ensures that the commit thread doesn't starve. I'll
add a comment in the code explaining this.
>
>
> > +     while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
> > +             DEFINE_WAIT(wait);
> > +
> > +             prepare_to_wait(&journal->j_wait_fc, &wait,
> > +                             TASK_UNINTERRUPTIBLE);
> > +             write_unlock(&journal->j_state_lock);
> > +             schedule();
> > +             write_lock(&journal->j_state_lock);
> > +             finish_wait(&journal->j_wait_fc, &wait);
> > +     }
> > +     write_unlock(&journal->j_state_lock);
> > +
> >       commit_transaction = journal->j_running_transaction;
> >
> >       trace_jbd2_start_commit(journal, commit_transaction);
> > @@ -1119,12 +1133,16 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >
> >       if (journal->j_commit_callback)
> >               journal->j_commit_callback(journal, commit_transaction);
> > +     if (journal->j_fc_cleanup_callback)
> > +             journal->j_fc_cleanup_callback(journal, 1);
> >
> >       trace_jbd2_end_commit(journal, commit_transaction);
> >       jbd_debug(1, "JBD2: commit %d complete, head %d\n",
> >                 journal->j_commit_sequence, journal->j_tail_sequence);
> >
> >       write_lock(&journal->j_state_lock);
> > +     journal->j_flags &= ~JBD2_FULL_COMMIT_ONGOING;
> > +     journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
> >       spin_lock(&journal->j_list_lock);
> >       commit_transaction->t_state = T_FINISHED;
> >       /* Check if the transaction can be dropped now that we are finished */
> > @@ -1136,6 +1154,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >       spin_unlock(&journal->j_list_lock);
> >       write_unlock(&journal->j_state_lock);
> >       wake_up(&journal->j_wait_done_commit);
> > +     wake_up(&journal->j_wait_fc);
> >
> >       /*
> >        * Calculate overall stats
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 736a1736619f..17a30a2c38f9 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -714,6 +714,72 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
> >       return err;
> >   }
> >
> > +/*
> > + * Start a fast commit. If there's an ongoing fast or full commit wait for
> > + * it to complete. Returns 0 if a new fast commit was started. Returns -EALREADY
> > + * if a fast commit is not needed, either because there's an already a commit
> > + * going on or this tid has already been committed. Returns -EINVAL if no jbd2
> > + * commit has yet been performed.
> > + */
> > +int jbd2_fc_start(journal_t *journal, tid_t tid)
> > +{
> > +     /*
> > +      * Fast commits only allowed if at least one full commit has
> > +      * been processed.
> > +      */
> > +     if (!journal->j_stats.ts_tid)
> > +             return -EINVAL;
> > +
> > +     if (tid <= journal->j_commit_sequence)
> > +             return -EALREADY;
> > +
> > +     write_lock(&journal->j_state_lock);
> > +     if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> > +         (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
> > +             DEFINE_WAIT(wait);
> > +
> > +             prepare_to_wait(&journal->j_wait_fc, &wait,
> > +                             TASK_UNINTERRUPTIBLE);
> > +             write_unlock(&journal->j_state_lock);
> > +             schedule();
> > +             finish_wait(&journal->j_wait_fc, &wait);
> > +             return -EALREADY;
> > +     }
> > +     journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
> > +     write_unlock(&journal->j_state_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Stop a fast commit. If fallback is set, this function starts commit of
> > + * TID tid before any other fast commit can start.
> > + */
> > +static int __jbd2_fc_stop(journal_t *journal, tid_t tid, bool fallback)
> > +{
> > +     if (journal->j_fc_cleanup_callback)
> > +             journal->j_fc_cleanup_callback(journal, 0);
> > +     write_lock(&journal->j_state_lock);
> > +     journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
> > +     if (fallback)
> > +             journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
> > +     write_unlock(&journal->j_state_lock);
> > +     wake_up(&journal->j_wait_fc);
> > +     if (fallback)
> > +             return jbd2_complete_transaction(journal, tid);
> > +     return 0;
> > +}
> > +
> > +int jbd2_fc_stop(journal_t *journal)
> > +{
> > +     return __jbd2_fc_stop(journal, 0, 0);
> > +}
> > +
> > +int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid)
> > +{
> > +     return __jbd2_fc_stop(journal, tid, 1);
> > +}
> > +
> >   /* Return 1 when transaction with given tid has already committed. */
> >   int jbd2_transaction_committed(journal_t *journal, tid_t tid)
> >   {
> > @@ -1140,6 +1206,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >       init_waitqueue_head(&journal->j_wait_commit);
> >       init_waitqueue_head(&journal->j_wait_updates);
> >       init_waitqueue_head(&journal->j_wait_reserved);
> > +     init_waitqueue_head(&journal->j_wait_fc);
> >       mutex_init(&journal->j_abort_mutex);
> >       mutex_init(&journal->j_barrier);
> >       mutex_init(&journal->j_checkpoint_mutex);
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 36f65a818366..aad986a9f3ff 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -858,6 +858,13 @@ struct journal_s
> >        */
> >       wait_queue_head_t       j_wait_reserved;
> >
> > +     /**
> > +      * @j_wait_fc:
> > +      *
> > +      * Wait queue to wait for completion of async fast commits.
> > +      */
> > +     wait_queue_head_t       j_wait_fc;
>
> If we follow the naming convention then j_fc_wait, will be more
> convenient.
Makes sense, will do that in V10.

Thanks,
Harshad

>
> > +
> >       /**
> >        * @j_checkpoint_mutex:
> >        *
> > @@ -1208,6 +1215,15 @@ struct journal_s
> >        */
> >       struct lockdep_map      j_trans_commit_map;
> >   #endif
> > +
> > +     /**
> > +      * @j_fc_cleanup_callback:
> > +      *
> > +      * Clean-up after fast commit or full commit. JBD2 calls this function
> > +      * after every commit operation.
> > +      */
> > +     void (*j_fc_cleanup_callback)(struct journal_s *journal, int);
> > +
> >   };
> >
> >   #define jbd2_might_wait_for_commit(j) \
> > @@ -1292,6 +1308,8 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,        FAST_COMMIT)
> >   #define JBD2_ABORT_ON_SYNCDATA_ERR  0x040   /* Abort the journal on file
> >                                                * data write error in ordered
> >                                                * mode */
> > +#define JBD2_FAST_COMMIT_ONGOING     0x100   /* Fast commit is ongoing */
> > +#define JBD2_FULL_COMMIT_ONGOING     0x200   /* Full commit is ongoing */
> >
> >   /*
> >    * Function declarations for the journaling transaction and buffer
> > @@ -1546,6 +1564,9 @@ extern int jbd2_cleanup_journal_tail(journal_t *);
> >
> >   /* Fast commit related APIs */
> >   int jbd2_fc_init(journal_t *journal, int num_fc_blks);
> > +int jbd2_fc_start(journal_t *journal, tid_t tid);
> > +int jbd2_fc_stop(journal_t *journal);
> > +int jbd2_fc_stop_do_commit(journal_t *journal, tid_t tid);
> >   /*
> >    * is_journal_abort
> >    *
> >
