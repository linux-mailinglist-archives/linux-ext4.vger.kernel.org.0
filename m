Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4FF298909
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Oct 2020 10:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772509AbgJZJD6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 05:03:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45876 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1772507AbgJZJD6 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Oct 2020 05:03:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00737AC35;
        Mon, 26 Oct 2020 09:03:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 99A741E0EAA; Mon, 26 Oct 2020 10:03:50 +0100 (CET)
Date:   Mon, 26 Oct 2020 10:03:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v10 4/9] jbd2: add fast commit machinery
Message-ID: <20201026090350.GA28769@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-5-harshadshirwadkar@gmail.com>
 <20201022101648.GE25702@quack2.suse.cz>
 <CAD+ocbwBf0f225Kni97Ywy5b08+XXOTSX+DGJS=OOvEptU-HTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbwBf0f225Kni97Ywy5b08+XXOTSX+DGJS=OOvEptU-HTQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 23-10-20 10:17:18, harshad shirwadkar wrote:
> Thanks Jan for reviewing the patches.

You're welcome. Rather I'm sorry that I've got to that after so long time.

> On Thu, Oct 22, 2020 at 3:16 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 15-10-20 13:37:56, Harshad Shirwadkar wrote:
> > > This functions adds necessary APIs needed in JBD2 layer for fast
> > > commits.
> > >
> > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > > ---
> > >  fs/ext4/fast_commit.c |   8 ++
> > >  fs/jbd2/commit.c      |  44 ++++++++++
> > >  fs/jbd2/journal.c     | 190 +++++++++++++++++++++++++++++++++++++++++-
> > >  include/linux/jbd2.h  |  27 ++++++
> > >  4 files changed, 268 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 0dad8bdb1253..f2d11b4c6b62 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -8,11 +8,19 @@
> > >   * Ext4 fast commits routines.
> > >   */
> > >  #include "ext4_jbd2.h"
> > > +/*
> > > + * Fast commit cleanup routine. This is called after every fast commit and
> > > + * full commit. full is true if we are called after a full commit.
> > > + */
> > > +static void ext4_fc_cleanup(journal_t *journal, int full)
> > > +{
> > > +}
> > >
> > >  void ext4_fc_init(struct super_block *sb, journal_t *journal)
> > >  {
> > >       if (!test_opt2(sb, JOURNAL_FAST_COMMIT))
> > >               return;
> > > +     journal->j_fc_cleanup_callback = ext4_fc_cleanup;
> > >       if (jbd2_fc_init(journal, EXT4_NUM_FC_BLKS)) {
> > >               pr_warn("Error while enabling fast commits, turning off.");
> > >               ext4_clear_feature_fast_commit(sb);
> > > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > > index 6252b4c50666..fa688e163a80 100644
> > > --- a/fs/jbd2/commit.c
> > > +++ b/fs/jbd2/commit.c
> > > @@ -206,6 +206,30 @@ int jbd2_journal_submit_inode_data_buffers(struct jbd2_inode *jinode)
> > >       return generic_writepages(mapping, &wbc);
> > >  }
> > >
> > > +/* Send all the data buffers related to an inode */
> > > +int jbd2_submit_inode_data(struct jbd2_inode *jinode)
> > > +{
> > > +
> > > +     if (!jinode || !(jinode->i_flags & JI_WRITE_DATA))
> > > +             return 0;
> > > +
> > > +     trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> > > +     return jbd2_journal_submit_inode_data_buffers(jinode);
> > > +
> > > +}
> > > +EXPORT_SYMBOL(jbd2_submit_inode_data);
> > > +
> > > +int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> > > +{
> > > +     if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
> > > +             !jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
> > > +             return 0;
> > > +     return filemap_fdatawait_range_keep_errors(
> > > +             jinode->i_vfs_inode->i_mapping, jinode->i_dirty_start,
> > > +             jinode->i_dirty_end);
> > > +}
> > > +EXPORT_SYMBOL(jbd2_wait_inode_data);
> > > +
> > >  /*
> > >   * Submit all the data buffers of inode associated with the transaction to
> > >   * disk.
> > > @@ -415,6 +439,20 @@ void jbd2_journal_commit_transaction(journal_t *journal)
> > >       J_ASSERT(journal->j_running_transaction != NULL);
> > >       J_ASSERT(journal->j_committing_transaction == NULL);
> > >
> > > +     write_lock(&journal->j_state_lock);
> > > +     journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;
> > > +     while (journal->j_flags & JBD2_FAST_COMMIT_ONGOING) {
> > > +             DEFINE_WAIT(wait);
> > > +
> > > +             prepare_to_wait(&journal->j_fc_wait, &wait,
> > > +                             TASK_UNINTERRUPTIBLE);
> > > +             write_unlock(&journal->j_state_lock);
> > > +             schedule();
> > > +             write_lock(&journal->j_state_lock);
> > > +             finish_wait(&journal->j_fc_wait, &wait);
> > > +     }
> > > +     write_unlock(&journal->j_state_lock);
> >
> > Hum, I'd like to understand: Is there a reason to block fastcommits already
> > when the running transaction is in T_LOCKED state? Strictly speaking it is
> > necessary only once we get to T_FLUSH state AFAIU (because only then we
> > start to write transaction to the journal). I guess there are both
> > advantages and disadvantages to it - if we allowed fastcommits running in
> > T_LOCKED state, we could lower fsync() latency more. OTOH it could increase
> > commit latency because we'd have to wait for fastcommits after T_LOCKED
> > state.
> That's right. I thought given that the transaction is anyway entering
> locked state, might as well wait for it to complete instead of writing
> blocks that are going to be obsoleted immediately. Also note that this
> full commit could have started due to fast commits being in ineligible
> state. If that's the case, the fast commit code will realize that it
> can't do much and it will again wait for a full commit. So, even
> though there is a fsync latency benefit to waiting till T_FLUSH, I'd
> still marginally prefer blocking fast commits once the transaction
> enters T_LOCKED state.

OK, makes sence. We can always change it if we find good performance
reasons for other choice.

> > > +}
> > > +EXPORT_SYMBOL(jbd2_fc_end_commit);
> > > +
> > > +int jbd2_fc_end_commit_fallback(journal_t *journal, tid_t tid)
> > > +{
> > > +     return __jbd2_fc_end_commit(journal, tid, 1);
> > > +}
> > > +EXPORT_SYMBOL(jbd2_fc_end_commit_fallback);
> > > +
> >
> > Is there a need for 'tid' here? Once jbd2_fc_begin_commit() sets
> > JBD2_FAST_COMMIT_ONGOING normal commit cannot proceed so when we decide we
> > cannot do fastcommit in the end, we know the transaction that needs to
> > commit is the currently running transaction, so we can fetch its TID from
> > the journal once we hold j_state_lock before clearing
> > JBD2_FAST_COMMIT_ONGOING. Cannot we?

Did you miss this comment?

> > >  /* Return 1 when transaction with given tid has already committed. */
> > >  int jbd2_transaction_committed(journal_t *journal, tid_t tid)
> > >  {
> > > @@ -784,6 +855,110 @@ int jbd2_journal_next_log_block(journal_t *journal, unsigned long long *retp)
> > >       return jbd2_journal_bmap(journal, blocknr, retp);
> > >  }
> > >
> > > +/* Map one fast commit buffer for use by the file system */
> > > +int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
> > > +{
> > > +     unsigned long long pblock;
> > > +     unsigned long blocknr;
> > > +     int ret = 0;
> > > +     struct buffer_head *bh;
> > > +     int fc_off;
> > > +
> > > +     *bh_out = NULL;
> > > +     write_lock(&journal->j_state_lock);
> > > +
> > > +     if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
> > > +             fc_off = journal->j_fc_off;
> > > +             blocknr = journal->j_fc_first + fc_off;
> > > +             journal->j_fc_off++;
> > > +     } else {
> > > +             ret = -EINVAL;
> > > +     }
> > > +     write_unlock(&journal->j_state_lock);
> >
> > Is j_state_lock really needed here? There is always only one process doing
> > fastcommit so nobody else should be touching j_fc_off and other fields. Or
> > am I missing something?
> You are right, there should only be one process calling
> jbd2_fc_get_buf. I'll fix this.

Maybe add a comment to j_fc_off & co. that they are not protected by any
lock - only by the fact that there's always only a single process doing
fastcommit.

> > > +
> > > +     /*
> > > +      * Wait in reverse order to minimize chances of us being woken up before
> > > +      * all IOs have completed
> > > +      */
> > > +     for (i = j_fc_off - 1; i >= j_fc_off - num_blks; i--) {
> > > +             bh = journal->j_fc_wbuf[i];
> > > +             wait_on_buffer(bh);
> > > +             put_bh(bh);
> > > +             journal->j_fc_wbuf[i] = NULL;
> > > +             if (unlikely(!buffer_uptodate(bh)))
> > > +                     return -EIO;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(jbd2_fc_wait_bufs);
> > > +
> > > +/*
> > > + * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
> > > + * for completion.
> > > + */
> > > +int jbd2_fc_release_bufs(journal_t *journal)
> > > +{
> > > +     struct buffer_head *bh;
> > > +     int i, j_fc_off;
> > > +
> > > +     read_lock(&journal->j_state_lock);
> > > +     j_fc_off = journal->j_fc_off;
> > > +     read_unlock(&journal->j_state_lock);
> > > +
> > > +     /*
> > > +      * Wait in reverse order to minimize chances of us being woken up before
> > > +      * all IOs have completed
> > > +      */
> > > +     for (i = j_fc_off - 1; i >= 0; i--) {
> > > +             bh = journal->j_fc_wbuf[i];
> > > +             if (!bh)
> > > +                     break;
> > > +             put_bh(bh);
> > > +             journal->j_fc_wbuf[i] = NULL;
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(jbd2_fc_release_bufs);
> > > +
> >
> > I kind of wonder if releasing of buffers shouldn't be done automatically
> > either as part of jbd2_fc_wait_bufs() or when ending fastcommit. But I
> > don't have a strong opinion so this is just an idea for consideration.
> So, that's what I do. The buffers get released in jbd2_fc_wait_bufs().
> However, in case of errors or fallback to full commits, buffers may
> not be submitted and thus won't be released. So this function is to
> release all the unsubmitted buffers. This gets called from the cleanup
> callback which is called after every successful or failed full commit
> or fast commit.

Aha, I missed that. Thanks for explanation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
