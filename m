Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F42A4121
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 11:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgKCKE3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 05:04:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:46486 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgKCKE2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 05:04:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 812FCAC97;
        Tue,  3 Nov 2020 10:04:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E1141E12FB; Tue,  3 Nov 2020 11:04:26 +0100 (CET)
Date:   Tue, 3 Nov 2020 11:04:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
Message-ID: <20201103100426.GB3440@quack2.suse.cz>
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com>
 <20201023103013.GF25702@quack2.suse.cz>
 <CAD+ocbws2J0boxfNA+gahWwTAqm8-Pef9_WkcwwKFjpiJhvJKw@mail.gmail.com>
 <20201027142910.GB16090@quack2.suse.cz>
 <CAD+ocbx0JMK=s3u2OXwRXt1BDUf18+DU_XF6WV2VarAi7CLgRw@mail.gmail.com>
 <20201030152831.GD19757@quack2.suse.cz>
 <CAD+ocby_So+Gw_a9=GVoQdW7z1+qUCSZpvKYuYe=xS2MuGcdOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocby_So+Gw_a9=GVoQdW7z1+qUCSZpvKYuYe=xS2MuGcdOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 30-10-20 09:45:10, harshad shirwadkar wrote:
> > > > > > > +
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Writes updated data ranges for the inode in question. Updates CRC.
> > > > > > > + * Returns 0 on success, error otherwise.
> > > > > > > + */
> > > > > > > +static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> > > > > > > +{
> > > > > > > +     ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> > > > > > > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > > > > > > +     struct ext4_map_blocks map;
> > > > > > > +     struct ext4_fc_add_range fc_ext;
> > > > > > > +     struct ext4_fc_del_range lrange;
> > > > > > > +     struct ext4_extent *ex;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     mutex_lock(&ei->i_fc_lock);
> > > > > > > +     if (ei->i_fc_lblk_len == 0) {
> > > > > > > +             mutex_unlock(&ei->i_fc_lock);
> > > > > > > +             return 0;
> > > > > > > +     }
> > > > > > > +     old_blk_size = ei->i_fc_lblk_start;
> > > > > > > +     new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
> > > > > > > +     ei->i_fc_lblk_len = 0;
> > > > > > > +     mutex_unlock(&ei->i_fc_lock);
> > > > > > > +
> > > > > > > +     cur_lblk_off = old_blk_size;
> > > > > > > +     jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> > > > > > > +               __func__, cur_lblk_off, new_blk_size, inode->i_ino);
> > > > > > > +
> > > > > > > +     while (cur_lblk_off <= new_blk_size) {
> > > > > > > +             map.m_lblk = cur_lblk_off;
> > > > > > > +             map.m_len = new_blk_size - cur_lblk_off + 1;
> > > > > > > +             ret = ext4_map_blocks(NULL, inode, &map, 0);
> > > > > > > +             if (ret < 0)
> > > > > > > +                     return -ECANCELED;
> > > > > >
> > > > > > So isn't this actually racy with a risk of stale data exposure? Consider a
> > > > > > situation like:
> > > > > >
> > > > > > Task 1:                         Task 2:
> > > > > > pwrite(file, buf, 8192, 0)
> > > > > > punch(file, 0, 4096)
> > > > > > fsync(file)
> > > > > >   writeout range 4096-8192
> > > > > >   fastcommit for inode range 0-8192
> > > > > >                                 pwrite(file, buf, 4096, 0)
> > > > > >     ext4_map_blocks(file)
> > > > > >       - reports that block at offset 0 is mapped so that is recorded in
> > > > > >         fastcommit record. But data for that is not written so after a
> > > > > >         crash we'd expose stale data in that block.
> > > > > >
> > > > > > Am I missing something?
> > > > > So the way this gets handled is before entering this function, the
> > > > > inode enters COMMITTING state (in ext4_fc_submit_inode_data_all
> > > > > function). Once in COMMITTING state, all the inodes on this inode get
> > > > > paused. Also, the commit path waits until all the ongoing updates on
> > > > > that inode are completed. Once they are completed, only then its data
> > > > > buffers are flushed and this ext4_map_blocks is called. So Task-2 here
> > > > > would have either completely finished or would wait until the end of
> > > > > this inode's commit. I realize that I should probably add more
> > > > > comments to make this more clearer in the code. But is handling it
> > > > > this way sufficient or am I missing any more cases?
> > > >
> > > > I see. In principle this should work. But I don't like that we have yet
> > > > another mechanism that needs to properly wrap inode changes to make
> > > > fastcommits work. And if we get it wrong somewhere, the breakage will be
> > > > almost impossible to notice until someone looses data after a power
> > > > failure. So it seems a bit fragile to me.
> > > Ack
> > > >
> > > > Ideally I think we would reuse the current transaction machinery for this
> > > > somehow (so that changes added through one transaction handle would behave
> > > > atomically wrt to fastcommits) but the details are not clear to me yet. I
> > > > need to think more about this...
> > > Yeah, I thought about that too. All we need to do is to atomically
> > > increment an "number of ongoing updates" counter on an inode, which
> > > could be done by existing ext4_journal_start()/stop() functions.
> > > However, the problem is that current ext4_journal_start()/stop() don't
> > > take inode as an argumen. I considered changing all the
> > > ext4_journal_start/stop calls but that would have inflated the size of
> > > this patch series which is already pretty big. But we can do that as a
> > > follow up cleanup. Does that sound reasonable?
> >
> > So ext4_journal_start() actually does take inode as an argument and we use
> > it quite some places (we also have ext4_journal_start_sb() which takes just
> > the superblock). What I'm not sure about is whether that's the inode you
> > want to protect for fastcommit purposes (would need some code auditing) or
> > whether there are not more inodes that need the protection for some
> > operations. ext4_journal_stop() could be handled by recording the inode in
> > the handle on ext4_journal_start() so ext4_journal_stop() then knows for
> > which inode to decrement the counter.
> >
> > Another possibility would be to increment the counter in
> > ext4_get_inode_loc() - that is a clear indication we are going to change
> > something in the inode. This also automatically handles the situation when
> > multiple inodes are modified by the operation or that proper inodes are
> > being protected. With decrementing the counter it is somewhat more
> > difficult. I think we can only do that at ext4_journal_stop() time so we
> > need to record in the handle for which inodes we acquired the update
> > references and drop them from ext4_journal_stop(). This would look as a
> > rather robust solution to me...
> ..the only problem here is that the same handle can be returned by
> multiple calls to ext4_journal_start(). That means a handle returned
> by ext4_journal_start() could be associated with multiple inodes. One

That is not quite true. ext4_journal_start() returns always a new handle
(unless that process has already a handle started, but nested handles are
not interesting for our case). Just multiple handles may refer to the same
transaction which is what confused you I guess. So each handle has 1:1
correspondence with a logical operation that needs to be performed
atomically and you can store your inode in handle_t (==
jbd2_journal_handle). Maybe to make the layering clear, you could add a
helper jbd2_associate_handle_with_inode() or something like that for the
storing and similar helper for fetching the inode.

Now I'm not certain that each logical operation has only single inode that
gets modified in it - e.g. rename may modify multiple inodes. Now I suspect
that you are marking the fs as inelligible in all the cases that modify
more inodes but it's difficult to be sure with your current scheme. That's
another way that should be automated by the scheme (which is easy enough -
you can mark fs as ineligible if handle already has different inode
associated with it in ext2_get_inode_loc()).

I don't think you need to play any games with fs private structure at this
point as you describe below...

								Honza


> way to deal with this would be to define ext4 specific handle
> structure. So, each call to ext4_journal_start would return a struct
> that looks like following:
> 
> struct ext4_handle {
>     handle_t *jbd2_handle;
>     struct inode *inode;
> }
> 
> So now on ext4_journal_stop(), we know for which inode we need to drop
> counters. The objects of this struct would either need to have their
> own kmem_cache or would need to be defined on stack (I think the
> latter is preferred). Should we do this? If we do this, this is going
> to be a pretty big change (will have to inspect all the existing
> callers of ext4_journal_start() and ext4_journal_stop()).
> 
> Another option would be to change the definition of handle_t such that
> on every call to jbd2_journal_start(), we get a new wrapper object
> that takes a reference on handle_t. Such an object would have a
> private pointer that FS can use the way it wants. This will be a
> relatively smaller change but it would impact OCFS too. But if we go
> this route, we can't avoid using a new kmem_cache, since now these new
> handle wrappers would need to be allocated inside of JBD2.
> 
> I kind of like the second option better because it keeps the change
> comparatively smaller. Wdyt? Also, Ted / Andreas, wdyt?
> 
> Thanks,
> Harshad
> 
> Thank
> >
> >                                                                 Honza
> > --
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
