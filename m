Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0BA2A0A0E
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJ3PkC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 11:40:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:55874 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgJ3PkC (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 30 Oct 2020 11:40:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5E82ADE8;
        Fri, 30 Oct 2020 15:40:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4C0FA1E10D0; Fri, 30 Oct 2020 16:40:00 +0100 (CET)
Date:   Fri, 30 Oct 2020 16:40:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 3/9] ext4 / jbd2: add fast commit initialization
Message-ID: <20201030154000.GE19757@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-4-harshadshirwadkar@gmail.com>
 <20201021200039.GD25702@quack2.suse.cz>
 <CAD+ocbwGE4SHPZ9eaZx6cW9cWbtOSVKOQtfWVHEkaxK370QHbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbwGE4SHPZ9eaZx6cW9cWbtOSVKOQtfWVHEkaxK370QHbw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 29-10-20 16:28:34, harshad shirwadkar wrote:
> On Wed, Oct 21, 2020 at 1:00 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 15-10-20 13:37:55, Harshad Shirwadkar wrote:
> > > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > > new file mode 100644
> > > index 000000000000..8362bf5e6e00
> > > --- /dev/null
> > > +++ b/fs/ext4/fast_commit.h
> > > @@ -0,0 +1,9 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef __FAST_COMMIT_H__
> > > +#define __FAST_COMMIT_H__
> > > +
> > > +/* Number of blocks in journal area to allocate for fast commits */
> > > +#define EXT4_NUM_FC_BLKS             256
> >
> > Maybe this could be tunable (at least during mkfs but maybe also with
> > a mount option)? I can imagine some people will want to tune this for their
> > workloads similarly as they tune the journal size. And although current
> > minimal journal size is 1024, I'd be actually calmer if jbd2 properly
> > checked from the start that requested fastcommit area isn't too big for the
> > journal...
> Sounds good, commit e029c5f2798720b463e8df0e184a4d1036311b43 ("ext4:
> make num of fast commit blocks configurable") fixes this. With that
> commit, now we have reserved a field in the superblock that tells the
> number of fast commit blocks. Now that this is configurable, I wonder
> if there's any point in giving the file system the ability to
> configure the number of blocks? In other words, I'm thinking of
> dropping jbd2_fc_init() which takes the number of fast commit blocks
> as an argument and just solely rely on the value found in the journal
> superblock. New mke2fs will allow you to set the number of fast commit
> blocks in JBD2 superblock. Any objections on that?

Yeah, that sounds as a good cleanup to me.

> > > +
> > > +#endif /* __FAST_COMMIT_H__ */
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 70256a240442..23bf55057fc2 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -5170,6 +5170,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
> > >       journal->j_commit_interval = sbi->s_commit_interval;
> > >       journal->j_min_batch_time = sbi->s_min_batch_time;
> > >       journal->j_max_batch_time = sbi->s_max_batch_time;
> > > +     ext4_fc_init(sb, journal);
> > >
> > >       write_lock(&journal->j_state_lock);
> > >       if (test_opt(sb, BARRIER))
> > > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > > index c0600405e7a2..4497bfbac527 100644
> > > --- a/fs/jbd2/journal.c
> > > +++ b/fs/jbd2/journal.c
> > > @@ -1181,6 +1181,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
> > >       if (!journal->j_wbuf)
> > >               goto err_cleanup;
> > >
> > > +     if (journal->j_fc_wbufsize > 0) {
> > > +             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > > +                                     sizeof(struct buffer_head *),
> > > +                                     GFP_KERNEL);
> > > +             if (!journal->j_fc_wbuf)
> > > +                     goto err_cleanup;
> > > +     }
> > > +
> >
> > Hum, but journal_init_common() gets called e.g. through
> > jbd2_journal_init_inode() before ext4_init_journal_params() sets
> > j_fc_wbufsize? How is this supposed to work?
> I realized that this part never really gets executed in the current
> code. That's because when journal_init_common is called, j_fc_wbufsize
> is not set. It only gets set later, so this could have been dropped.

OK, just clean it up please..

> > >       bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> > >       if (!bh) {
> > >               pr_err("%s: Cannot get buffer for journal superblock\n",
> > > @@ -1194,11 +1202,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
> > >
> > >  err_cleanup:
> > >       kfree(journal->j_wbuf);
> > > +     kfree(journal->j_fc_wbuf);
> > >       jbd2_journal_destroy_revoke(journal);
> > >       kfree(journal);
> > >       return NULL;
> > >  }
> > >
> > > +int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > > +{
> > > +     journal->j_fc_wbufsize = num_fc_blks;
> > > +     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > > +                             sizeof(struct buffer_head *), GFP_KERNEL);
> > > +     if (!journal->j_fc_wbuf)
> > > +             return -ENOMEM;
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL(jbd2_fc_init);
> >
> > Hum, probably I'd find it less error prone to have size of fastcommit area
> > as an argument to jbd2_journal_init_dev() and jbd2_journal_init_inode().
> > That way we are sure journal parameters are initialized correctly from the
> > start. OTOH number of fastcommit blocks in the journal as we load it from
> > the disk and need to replay could be different from the number of
> > fastcommit blocks requested now (once we allow tuning) and this can get
> > confusing pretty fast. So maybe we just set number of fastcommit blocks in
> > journal_init_common() and then perform setup of everything else in
> > journal_reset()?
> Please see my comment above. If we just rely on the value found in the
> superblock, then there is no question of FS requesting a different
> number of FC blocks than what we find in journal superblock. If we go
> that route, then we can set the default value of j_fc_wbufsize in
> journal_init_common().  Whenever we journal superblock after that, we
> can override the default value with what we find in the superblock.

Yes, having only the value in journal superblock deals nicely with all
these issues. I'm for it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
