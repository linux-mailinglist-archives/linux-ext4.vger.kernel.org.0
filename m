Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84E32975A6
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Oct 2020 19:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbgJWRRc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 13:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S465753AbgJWRRb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 13:17:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A46C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 10:17:31 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p9so3395665eji.4
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 10:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oqN60U8dfk1TGdKm6xf50pY1AVZk0foQ3i0DIa/nUiQ=;
        b=p3O/MvGFIoghxPmAMhtL3KnajD554Me1WRkGHvXwJERmXPM4I2h9sHvPs36hjjLK0P
         R4ALXa3AXptHGkcJG9NuwFYMaxFrhQig0xrpGjj7Cp5Fc6Um7seNc6aJYKIMDcnJIeov
         VgS9F2huEwZAE1JcfoOc+Qafw8QoWJRXUDR4xnyMle5UOFtfkb+kE2+gb4xRvh5Mnzu4
         lVwjXA9trGF+UH9H25si3Q0UNmX6zRrCUt4r0Az29OAHybSwJ565eOo0UXxYa69Fjh0b
         iZErYswzp2iva9p7ikDY0lcrdWssSZ18w0N3fk2OgpCAkS528yrlRjVKwUt0JbgOJwHv
         69/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oqN60U8dfk1TGdKm6xf50pY1AVZk0foQ3i0DIa/nUiQ=;
        b=m3rty6njh4KWYsgLt2OrTCpV15ji+yoXd2RFJu0QDasMOj+u1SBT6aaB6kWG1YbPqQ
         LTl7PAbFplC3Z/UJ/ozEvJYraVFG2Xlos4pGQ69KNFQi/1Yv/oJ5/E1Rfh2cCz3Y6rxR
         FbpNcK9zzO+v0qIAixvIVSf0DHELymeF/xC9ISUsXiOtbbbIewzel+GXGJDOLAEPo4Ud
         gA290cWq09mjrUIR7f1a2nrHEDjonQX2erSBPPKNdx/FfQHL6V/tzLRDP6YNynFQ1guz
         G1kzNaM/MyDb6c2fyr85XrVrEzszLZu562+3R96nYcgiTlw3D7xCHKYeHF8WUkmgBPvI
         IWDQ==
X-Gm-Message-State: AOAM532pjnHYvU5aeQ7DKDXp+0nB6dd3urA8bRska+O142DDPxv51myl
        0lSt1AYDOsWIF5rOasFDea3n6qpXsbeP/luFSd8=
X-Google-Smtp-Source: ABdhPJyrtr/74q1lz4AL34TuUOjKg1OZmBUc2xvG42SvGozv8PXVQgZxoIQejJ75rPfoi1BRbMu5m+c/HNHIAYgLGzg=
X-Received: by 2002:a17:906:354e:: with SMTP id s14mr2949914eja.192.1603473449552;
 Fri, 23 Oct 2020 10:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-5-harshadshirwadkar@gmail.com> <20201022101648.GE25702@quack2.suse.cz>
In-Reply-To: <20201022101648.GE25702@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 23 Oct 2020 10:17:18 -0700
Message-ID: <CAD+ocbwBf0f225Kni97Ywy5b08+XXOTSX+DGJS=OOvEptU-HTQ@mail.gmail.com>
Subject: Re: [PATCH v10 4/9] jbd2: add fast commit machinery
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Jan for reviewing the patches.

On Thu, Oct 22, 2020 at 3:16 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-10-20 13:37:56, Harshad Shirwadkar wrote:
> > This functions adds necessary APIs needed in JBD2 layer for fast
> > commits.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >  fs/ext4/fast_commit.c |   8 ++
> >  fs/jbd2/commit.c      |  44 ++++++++++
> >  fs/jbd2/journal.c     | 190 +++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/jbd2.h  |  27 ++++++
> >  4 files changed, 268 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 0dad8bdb1253..f2d11b4c6b62 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -8,11 +8,19 @@
> >   * Ext4 fast commits routines.
> >   */
> >  #include "ext4_jbd2.h"
> > +/*
> > + * Fast commit cleanup routine. This is called after every fast commit and
> > + * full commit. full is true if we are called after a full commit.
> > + */
> > +static void ext4_fc_cleanup(journal_t *journal, int full)
> > +{
> > +}
> >
> >  void ext4_fc_init(struct super_block *sb, journal_t *journal)
> >  {
> >       if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> >               return;
> > +     journal->j_fc_cleanup_callback = ext4_fc_cleanup;
> >       if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
> >               pr_warn("Error while enabling fast commits, turning off.");
> >               ext4_clear_feature_fast_commit(sb);
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index 6252b4c50666..fa688e163a80 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -206,6 +206,30 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
> >       return generic_writepages(mapping, &wbc);
> >  }
> >
> > +/* Send all the data buffers related to an inode */
> > +int jbd2_submit_inode_data(struct jbd2_inode *jinode)
> > +{
> > +
> > +     if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
> > +             return 0;
> > +
> > +     trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> > +     return jbd2_journal_submit_inode_data_buffers(jinode);
> > +
> > +}
> > +EXPORT_SYMBOL(jbd2_submit_inode_data);
> > +
> > +int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> > +{
> > +     if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
> > +             !jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
> > +             return 0;
> > +     return filemap_fdatawait_range_keep_errors(
> > +             jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
> > +             jinode->i_dirty_end);
> > +}
> > +EXPORT_SYMBOL(jbd2_wait_inode_data);
> > +
> >  /*
> >   * Submit all the data buffers of inode associated with the transaction to
> >   * disk.
> > @@ -415,6 +439,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >       J_ASSERT(journal->j_running_transaction != NULL);
> >       J_ASSERT(journal->j_committing_transaction == NULL);
> >
> > +     write_lock(&journal->j_state_lock);
> > +     journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
> > +     while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
> > +             DEFINE_WAIT(wait);
> > +
> > +             prepare_to_wait(&journal->j_fc_wait, &wait,
> > +                             TASK_UNINTERRUPTIBLE);
> > +             write_unlock(&journal->j_state_lock);
> > +             schedule();
> > +             write_lock(&journal->j_state_lock);
> > +             finish_wait(&journal->j_fc_wait, &wait);
> > +     }
> > +     write_unlock(&journal->j_state_lock);
>
> Hum, I'd like to understand: Is there a reason to block fastcommits already
> when the running transaction is in T_LOCKED state? Strictly speaking it is
> necessary only once we get to T_FLUSH state AFAIU (because only then we
> start to write transaction to the journal). I guess there are both
> advantages and disadvantages to it - if we allowed fastcommits running in
> T_LOCKED state, we could lower fsync() latency more. OTOH it could increase
> commit latency because we'd have to wait for fastcommits after T_LOCKED
> state.
That's right. I thought given that the transaction is anyway entering
locked state, might as well wait for it to complete instead of writing
blocks that are going to be obsoleted immediately. Also note that this
full commit could have started due to fast commits being in ineligible
state. If that's the case, the fast commit code will realize that it
can't do much and it will again wait for a full commit. So, even
though there is a fsync latency benefit to waiting till T_FLUSH, I'd
still marginally prefer blocking fast commits once the transaction
enters T_LOCKED state.
>
> Another option is to just block new fast commits at the beginning of
> T_LOCKED state and wait for running fastcommits at the end of T_LOCKED
> state. That way waiting for outstanding handles and waiting for fastcommits
> would be running in parallel and we'd reduce the latency...
This is a good idea! I'll add that TODO item in the code.
>
> Also I'm not sure JBD2_FULL_COMMIT_ONGOING is really needed. I understand
> it is handy at this point but longer term, I'd find it more maintainable if
> we just had a helper function jbd2_fastcommit_allowed() (or whatever) that
> will check journal state and based on presence and state of committing
> transaction return whether fastcommits are allowed or not...
Makes sense.
>
> > +
> >       commit_transaction = journal->j_running_transaction;
> >
> >       trace_jbd2_start_commit(journal, commit_transaction);
> > @@ -422,6 +460,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >                       commit_transaction->t_tid);
> >
> >       write_lock(&journal->j_state_lock);
> > +     journal->j_fc_off = 0;
> >       J_ASSERT(commit_transaction->t_state == T_RUNNING);
> >       commit_transaction->t_state = T_LOCKED;
> >
> > @@ -1121,12 +1160,16 @@ void jbd2_journal_commit_transaction(journal_t *journal)
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
> > @@ -1138,6 +1181,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> >       spin_unlock(&journal->j_list_lock);
> >       write_unlock(&journal->j_state_lock);
> >       wake_up(&journal->j_wait_done_commit);
> > +     wake_up(&journal->j_fc_wait);
> >
> >       /*
> >        * Calculate overall stats
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index 4497bfbac527..0c7c42bd530f 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -159,7 +159,9 @@ static void commit_timeout(struct timer_list *t)
> >   *
> >   * 1) COMMIT:  Every so often we need to commit the current state of the
> >   *    filesystem to disk.  The journal thread is responsible for writing
> > - *    all of the metadata buffers to disk.
> > + *    all of the metadata buffers to disk. If a fast commit is ongoing
> > + *    journal thread waits until it's done and then continues from
> > + *    there on.
> >   *
> >   * 2) CHECKPOINT: We cannot reuse a used section of the log file until all
> >   *    of the data in that part of the log has been rewritten elsewhere on
> > @@ -716,6 +718,75 @@ int jbd2_log_wait_commit(journal_t *journal, tid_t tid)
> >       return err;
> >  }
> >
> > +/*
> > + * Start a fast commit. If there's an ongoing fast or full commit wait for
> > + * it to complete. Returns 0 if a new fast commit was started. Returns -EALREADY
> > + * if a fast commit is not needed, either because there's an already a commit
> > + * going on or this tid has already been committed. Returns -EINVAL if no jbd2
> > + * commit has yet been performed.
> > + */
> > +int jbd2_fc_begin_commit(journal_t *journal, tid_t tid)
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
>
> This check is racy and possibly using stale value of j_commit_sequence
> since j_commit_sequence needs j_state_lock for reliable reading.
Ack, I'll fix this.
>
> > +
> > +     write_lock(&journal->j_state_lock);
> > +     if (journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
> > +         (journal->j_flags & JBD2_FAST_COMMIT_ONGOING)) {
> > +             DEFINE_WAIT(wait);
> > +
> > +             prepare_to_wait(&journal->j_fc_wait, &wait,
> > +                             TASK_UNINTERRUPTIBLE);
> > +             write_unlock(&journal->j_state_lock);
> > +             schedule();
> > +             finish_wait(&journal->j_fc_wait, &wait);
> > +             return -EALREADY;
> > +     }
> > +     journal->j_flags |= JBD2_FAST_COMMIT_ONGOING;
> > +     write_unlock(&journal->j_state_lock);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_begin_commit);
> > +
> > +/*
> > + * Stop a fast commit. If fallback is set, this function starts commit of
> > + * TID tid before any other fast commit can start.
> > + */
> > +static int __jbd2_fc_end_commit(journal_t *journal, tid_t tid, bool fallback)
> > +{
> > +     if (journal->j_fc_cleanup_callback)
> > +             journal->j_fc_cleanup_callback(journal, 0);
> > +     write_lock(&journal->j_state_lock);
> > +     journal->j_flags &= ~JBD2_FAST_COMMIT_ONGOING;
> > +     if (fallback)
> > +             journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
> > +     write_unlock(&journal->j_state_lock);
> > +     wake_up(&journal->j_fc_wait);
> > +     if (fallback)
> > +             return jbd2_complete_transaction(journal, tid);
> > +     return 0;
> > +}
> > +
> > +int jbd2_fc_end_commit(journal_t *journal)
> > +{
> > +     return __jbd2_fc_end_commit(journal, 0, 0);
>
> 'fallback' is bool so please use true / false for it.
Ack
>
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_end_commit);
> > +
> > +int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid)
> > +{
> > +     return __jbd2_fc_end_commit(journal, tid, 1);
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
> > +
>
> Is there a need for 'tid' here? Once jbd2_fc_begin_commit() sets
> JBD2_FAST_COMMIT_ONGOING normal commit cannot proceed so when we decide we
> cannot do fastcommit in the end, we know the transaction that needs to
> commit is the currently running transaction, so we can fetch its TID from
> the journal once we hold j_state_lock before clearing
> JBD2_FAST_COMMIT_ONGOING. Cannot we?
>
> >  /* Return 1 when transaction with given tid has already committed. */
> >  int jbd2_transaction_committed(journal_t *journal, tid_t tid)
> >  {
> > @@ -784,6 +855,110 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
> >       return jbd2_journal_bmap(journal, blocknr, retp);
> >  }
> >
> > +/* Map one fast commit buffer for use by the file system */
> > +int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
> > +{
> > +     unsigned long long pblock;
> > +     unsigned long blocknr;
> > +     int ret = 0;
> > +     struct buffer_head *bh;
> > +     int fc_off;
> > +
> > +     *bh_out = NULL;
> > +     write_lock(&journal->j_state_lock);
> > +
> > +     if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
> > +             fc_off = journal->j_fc_off;
> > +             blocknr = journal->j_fc_first + fc_off;
> > +             journal->j_fc_off++;
> > +     } else {
> > +             ret = -EINVAL;
> > +     }
> > +     write_unlock(&journal->j_state_lock);
>
> Is j_state_lock really needed here? There is always only one process doing
> fastcommit so nobody else should be touching j_fc_off and other fields. Or
> am I missing something?
You are right, there should only be one process calling
jbd2_fc_get_buf. I'll fix this.
>
> > +
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = jbd2_journal_bmap(journal, blocknr, &pblock);
> > +     if (ret)
> > +             return ret;
> > +
> > +     bh = __getblk(journal->j_dev, pblock, journal->j_blocksize);
> > +     if (!bh)
> > +             return -ENOMEM;
> > +
> > +     lock_buffer(bh);
> > +
> > +     clear_buffer_uptodate(bh);
> > +     set_buffer_dirty(bh);
>
> Uh, that's a weird state to leave buffer in (!uptodate & dirty). Flush
> worker could spot such buffer and try to write it out, which would blow
> up... I wouldn't touch the buffer state here, once proper content is
> filled, I'd mark the buffer as uptodate & dirty. That's how buffer state is
> usually managed.
Ack.
>
> > +     unlock_buffer(bh);
> > +     journal->j_fc_wbuf[fc_off] = bh;
> > +
> > +     *bh_out = bh;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_get_buf);
> > +
> > +/*
> > + * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> > + * for completion.
> > + */
> > +int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
> > +{
> > +     struct buffer_head *bh;
> > +     int i, j_fc_off;
> > +
> > +     read_lock(&journal->j_state_lock);
> > +     j_fc_off = journal->j_fc_off;
> > +     read_unlock(&journal->j_state_lock);
>
> Same comment regarding j_state_lock as for jbd2_fc_get_buf().
>
> > +
> > +     /*
> > +      * Wait in reverse order to minimize chances of us being woken up before
> > +      * all IOs have completed
> > +      */
> > +     for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
> > +             bh = journal->j_fc_wbuf[i];
> > +             wait_on_buffer(bh);
> > +             put_bh(bh);
> > +             journal->j_fc_wbuf[i] = NULL;
> > +             if (unlikely(!buffer_uptodate(bh)))
> > +                     return -EIO;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_wait_bufs);
> > +
> > +/*
> > + * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> > + * for completion.
> > + */
> > +int jbd2_fc_release_bufs(journal_t *journal)
> > +{
> > +     struct buffer_head *bh;
> > +     int i, j_fc_off;
> > +
> > +     read_lock(&journal->j_state_lock);
> > +     j_fc_off = journal->j_fc_off;
> > +     read_unlock(&journal->j_state_lock);
> > +
> > +     /*
> > +      * Wait in reverse order to minimize chances of us being woken up before
> > +      * all IOs have completed
> > +      */
> > +     for (i = j_fc_off - 1; i >= 0; i--) {
> > +             bh = journal->j_fc_wbuf[i];
> > +             if (!bh)
> > +                     break;
> > +             put_bh(bh);
> > +             journal->j_fc_wbuf[i] = NULL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_release_bufs);
> > +
>
> I kind of wonder if releasing of buffers shouldn't be done automatically
> either as part of jbd2_fc_wait_bufs() or when ending fastcommit. But I
> don't have a strong opinion so this is just an idea for consideration.
So, that's what I do. The buffers get released in jbd2_fc_wait_bufs().
However, in case of errors or fallback to full commits, buffers may
not be submitted and thus won't be released. So this function is to
release all the unsubmitted buffers. This gets called from the cleanup
callback which is called after every successful or failed full commit
or fast commit.

Thanks,
Harshad
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
