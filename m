Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07062A7BD6
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 11:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgKEKa1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Nov 2020 05:30:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:58382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKEKa1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 5 Nov 2020 05:30:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9CF02AB95;
        Thu,  5 Nov 2020 10:30:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DEE221E130B; Thu,  5 Nov 2020 11:30:24 +0100 (CET)
Date:   Thu, 5 Nov 2020 11:30:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 04/10] ext4: clean up the JBD2 API that initializes fast
 commits
Message-ID: <20201105103024.GA32718@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-5-harshadshirwadkar@gmail.com>
 <20201103162943.GH3440@quack2.suse.cz>
 <CAD+ocbykJ61MmkLqq78p=AOT0f_6j066J3ivNHjXJVbtLEvNag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbykJ61MmkLqq78p=AOT0f_6j066J3ivNHjXJVbtLEvNag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-11-20 11:52:24, harshad shirwadkar wrote:
> On Tue, Nov 3, 2020 at 8:29 AM Jan Kara <jack@suse.cz> wrote:
> > > -int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > > +int jbd2_fc_init(journal_t *journal)
> > >  {
> > > -     journal->j_fc_wbufsize = num_fc_blks;
> > > -     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > > -                             sizeof(struct buffer_head *), GFP_KERNEL);
> > > -     if (!journal->j_fc_wbuf)
> > > -             return -ENOMEM;
> > > +     /*
> > > +      * Only set j_fc_wbufsize here to indicate that the client file
> > > +      * system is interested in using fast commits. The actual number of
> > > +      * fast commit blocks is found inside jbd2_superblock and is only
> > > +      * valid if j_fc_wbufsize is non-zero. The real value of j_fc_wbufsize
> > > +      * gets set in journal_reset().
> > > +      */
> > > +     journal->j_fc_wbufsize = JBD2_MIN_FC_BLOCKS;
> > >       return 0;
> > >  }
> >
> > When looking at this, is there a reason why jbd2_fc_init() still exists?  I
> > mean why not just make the rule that the journal has FC block number set
> > iff FC gets enabled? Anything else seems a bit confusing to me and also
> > dangerous - imagine we have fs with FC running, we write some FCs and then
> > crash. Then on system recovery we mount with no_fc mount option. We have
> > just lost data on the filesystem AFAIU... So I'd just remove all the mount
> > options related to fastcommits and leave everything to the journal setup
> > (which can be modified with e2fsprogs if needed) to keep things simple.
> The problem is whether or not to use fast commits is the file system's
> call. The JBD2 feature flag will be cleared on a clean unmount and if
> we rely solely on the JBD2 feature flag, fast commit will be turned
> off after a clean unmount. Whereas the FS compat flag is the source of
> truth about whether fast commit needs to be used or not. That's why we
> need an API for the file system to tell JBD2 to still do fast commits.

Yes, I meant the API could be just that the filesystem either calls
jbd2_journal_set_features() with FASTCOMMIT feature or it won't. Similarly
to how e.g. JBD2_FEATURE_INCOMPAT_64BIT is handled. No need for
jbd2_fc_init() function AFAICT.

> Mount options that override the feature flag in Ext4 were mainly meant
> for debugging purposes. So, perhaps there should be a clear warning
> message in the kernel if any of these options are used? Even if we get
> rid of the mount options, we still need the jbd2_fc_init() API for the
> FS to tell JBD2 that it wants to use fast commit. Note that even if
> jbd2_fc_init() is not called, JBD2 will still try to replay fast
> commit blocks.



> > >  EXPORT_SYMBOL(jbd2_fc_init);
> > > @@ -1500,7 +1494,7 @@ static void journal_fail_superblock(journal_t *journal)
> > >  static int journal_reset(journal_t *journal)
> > >  {
> > >       journal_superblock_t *sb = journal->j_superblock;
> > > -     unsigned long long first, last;
> > > +     unsigned long long first, last, num_fc_blocks;
> > >
> > >       first = be32_to_cpu(sb->s_first);
> > >       last = be32_to_cpu(sb->s_maxlen);
> > > @@ -1513,6 +1507,28 @@ static int journal_reset(journal_t *journal)
> > >
> > >       journal->j_first = first;
> > >
> > > +     /*
> > > +      * At this point, fast commit recovery has finished. Now, we solely
> > > +      * rely on the file system to decide whether it wants fast commits
> > > +      * or not. File system that wishes to use fast commits must have
> > > +      * already called jbd2_fc_init() before we get here.
> > > +      */
> > > +     if (journal->j_fc_wbufsize > 0)
> > > +             jbd2_journal_set_features(journal, 0, 0,
> > > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > > +     else
> > > +             jbd2_journal_clear_features(journal, 0, 0,
> > > +                                       JBD2_FEATURE_INCOMPAT_FAST_COMMIT);
> > > +
> > > +     /* If valid, prefer the value found in superblock over the default */
> > > +     num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> > > +     if (num_fc_blocks > 0 && num_fc_blocks < last)
> > > +             journal->j_fc_wbufsize = num_fc_blocks;
> > > +
> > > +     if (jbd2_has_feature_fast_commit(journal))
> > > +             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > > +                                     sizeof(struct buffer_head *), GFP_KERNEL);
> > > +
> > >       if (jbd2_has_feature_fast_commit(journal) &&
> > >           journal->j_fc_wbufsize > 0) {
> > >               journal->j_fc_last = last;
> > > @@ -1531,7 +1547,8 @@ static int journal_reset(journal_t *journal)
> > >       journal->j_commit_sequence = journal->j_transaction_sequence - 1;
> > >       journal->j_commit_request = journal->j_commit_sequence;
> > >
> > > -     journal->j_max_transaction_buffers = journal->j_maxlen / 4;
> > > +     journal->j_max_transaction_buffers =
> > > +             (journal->j_maxlen - journal->j_fc_wbufsize) / 4;
> > >
> > >       /*
> > >        * As a special case, if the on-disk copy is already marked as needing
> > > @@ -1872,6 +1889,7 @@ static int load_superblock(journal_t *journal)
> > >  {
> > >       int err;
> > >       journal_superblock_t *sb;
> > > +     int num_fc_blocks;
> > >
> > >       err = journal_get_superblock(journal);
> > >       if (err)
> > > @@ -1884,10 +1902,12 @@ static int load_superblock(journal_t *journal)
> > >       journal->j_first = be32_to_cpu(sb->s_first);
> > >       journal->j_errno = be32_to_cpu(sb->s_errno);
> > >
> > > -     if (jbd2_has_feature_fast_commit(journal) &&
> > > -         journal->j_fc_wbufsize > 0) {
> > > +     if (jbd2_has_feature_fast_commit(journal)) {
> > >               journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
> > > -             journal->j_last = journal->j_fc_last - journal->j_fc_wbufsize;
> > > +             num_fc_blocks = be32_to_cpu(sb->s_num_fc_blks);
> > > +             if (!num_fc_blocks || num_fc_blocks >= journal->j_fc_last)
> >
> > I think this needs to be stricter - we need the check that the journal is
> > at least JBD2_MIN_JOURNAL_BLOCKS long (which happens at the beginning of
> > journal_reset()) to happen after we've subtracted fastcommit blocks...
> So are you saying that with FC, the minimum journal size is
> JBD2_MIN_JOURNAL_BLOCKS + JBD2_MIN_FC_BLOCKS? I was assuming that we

Yes. JBD2_MIN_JOURNAL_BLOCKS is minimum number of blocks we need for normal
commits to get reasonable behavior. So as you say with fastcommits enabled,
the minimal journal size is JBD2_MIN_JOURNAL_BLOCKS + JBD2_MIN_FC_BLOCKS.

> will reserve JBD2_MIN_FC_BLOCKS (256) blocks out of the total journal
> size. That way the users who rely on the journal size to be 1024
> blocks, won't see a difference in journal size even after turning FC
> on. But I'm not sure if that's something we should care about.

Well, e2fsprogs need to check journal size when enabling fastcommits so
that we don't get invalid configurations.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
