Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD412A0B8E
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 17:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgJ3QpY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Oct 2020 12:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3QpY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Oct 2020 12:45:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F266EC0613CF
        for <linux-ext4@vger.kernel.org>; Fri, 30 Oct 2020 09:45:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w25so7365491edx.2
        for <linux-ext4@vger.kernel.org>; Fri, 30 Oct 2020 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mf1c5egGmTZQx+Z2c3acOT+PzqQF8w1wnpcZ26w6OBA=;
        b=L39VUNNbUOu57sSlraejQ25HoNqcjvqm3mTh9/iSAcyQNTH/W9aaCJLgnTLvJBkVnx
         q/5XxsaMsKu22EM7AjN3pzzMqZXjnig7oZtFE0JEoCEtzNbBV0NBT0niIlRJIId3n73A
         O3JEmIhnn4Jna4MAAtR5OHvYmjYHHzgH+IneJUrXWkGruOdFxLY7LeNk/kY+sz3aNkVJ
         baymvpp0tRT/QjgSnk5tfRgPkDkgigEQ0+mfOw43NFzI3rI2NWM2fvASLSqtk1U5hNTC
         1Q0oKpjiz/KTL/OG5C3hNOg40Q8ciN5G9mgeDA0WrjWdZAaJJ6VbFk+YqNhfAFNxpPwv
         ElqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mf1c5egGmTZQx+Z2c3acOT+PzqQF8w1wnpcZ26w6OBA=;
        b=N13pfjIRAudRbUSPHi0UOflQhfcAgue6dG1LQM2YejaB4BOu6N93XvPtbt15l4irt9
         dEiV/3j2QLVh/em7kFLuteurafjVwFAdkmG46KYBsnAP8hrkETiX7Ct8LGug+I42hiFc
         9zwxmiY7bJCx1+4K4rpBRY8WbCfB1X/W6auab4BN97BpBhyH/eUQRS9L2wqOhxEQ5PGr
         GIWXbsOLeXCdYRKmMTR3+c7vIuqHQ0f31ldrzLb4TQUOHpISpAwlW7RbAWJCog/Ahi2/
         4fMEc1kb3iqBx+FrEPxZBqHs5itZ+Mn5tMWEHQlWjiZuhix/0FexL1ZhPUkJ8C6DGrQ+
         gWvw==
X-Gm-Message-State: AOAM530mtk5tHqUpthCCF1fJ0P69oOzQkgK4YXXqYDNRAFwmvSB6Ktsm
        J9K5XXaT9jADffeFFswsmPfkC6zrbJZYkNPAwRQ=
X-Google-Smtp-Source: ABdhPJyFHl0vxEq1PO0mC2lkIBRBj81PVIOebknzsqnlqU6uPclaSP5OBFgcovqL9whWKY3k/hivOdpiEjxaFew6Gnw=
X-Received: by 2002:a50:9ec6:: with SMTP id a64mr3303072edf.382.1604076322496;
 Fri, 30 Oct 2020 09:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com> <20201023103013.GF25702@quack2.suse.cz>
 <CAD+ocbws2J0boxfNA+gahWwTAqm8-Pef9_WkcwwKFjpiJhvJKw@mail.gmail.com>
 <20201027142910.GB16090@quack2.suse.cz> <CAD+ocbx0JMK=s3u2OXwRXt1BDUf18+DU_XF6WV2VarAi7CLgRw@mail.gmail.com>
 <20201030152831.GD19757@quack2.suse.cz>
In-Reply-To: <20201030152831.GD19757@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 30 Oct 2020 09:45:10 -0700
Message-ID: <CAD+ocby_So+Gw_a9=GVoQdW7z1+qUCSZpvKYuYe=xS2MuGcdOA@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
To:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 8:28 AM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 27-10-20 10:38:19, harshad shirwadkar wrote:
> > On Tue, Oct 27, 2020 at 7:29 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > +
> > > > > > +     mutex_lock(&ei->i_fc_lock);
> > > > > > +     if (running_txn_tid == ei->i_sync_tid) {
> > > > > > +             update = true;
> > > > > > +     } else {
> > > > > > +             ext4_fc_reset_inode(inode);
> > > > > > +             ei->i_sync_tid = running_txn_tid;
> > > > > > +     }
> > > > > > +     ret = __fc_track_fn(inode, args, update);
> > > > > > +     mutex_unlock(&ei->i_fc_lock);
> > > > > > +
> > > > > > +     if (!enqueue)
> > > > > > +             return ret;
> > > > > > +
> > > > > > +     spin_lock(&sbi->s_fc_lock);
> > > > > > +     if (list_empty(&EXT4_I(inode)->i_fc_list))
> > > > > > +             list_add_tail(&EXT4_I(inode)->i_fc_list,
> > > > > > +                             (sbi->s_mount_state & EXT4_FC_COMMITTING) ?
> > > > > > +                             &sbi->s_fc_q[FC_Q_STAGING] :
> > > > > > +                             &sbi->s_fc_q[FC_Q_MAIN]);
> > > > > > +     spin_unlock(&sbi->s_fc_lock);
> > > > >
> > > > > OK, so how do you prevent inode from being freed while it is still on
> > > > > i_fc_list? I don't see anything preventing that and it could cause nasty
> > > > > use-after-free issues. Note that for similar reasons JBD2 uses external
> > > > > separately allocated inode for jbd2_inode so that it can have separate
> > > > > lifetime (related to transaction commits) from struct ext4_inode_info.
> > > > So, if you see the function ext4_fc_del() above, it's called from
> > > > ext4_clear_inode(). What ext4_fc_del() does is that, if the inode is
> > > > not being committed, it just removes it from the list. If that inode
> > > > was deleted, we have a separate dentry queue which will record the
> > > > deletion of the inode, so we don't really need the struct
> > > > ext4_inode_info for recording that on-disk. However, if the inode is
> > > > being committed (this is figured out by checking the per inode
> > > > COMMITTING state), ext4_fc_del() waits until the completion.
> > >
> > > But I don't think this quite works. Consider the following scenario:
> > >
> > > inode I gets modified in transaction T
> > >   you add I to FC list
> > >
> > > memory pressure reclaims I from memory
> > >   you remove I from FC list
> > >
> > > open(I) -> inode gets loaded to memory again. Not tracked in FC list.
> > > fsync(I) -> nothing to do, FC list is empty
> > > <crash>
> > >
> > > And 'I' now doesn't contain data in should because T didn't commit yet and
> > > FC was empty.
> > Hmmm, I see. This needs to get fixed. However, I'm a little confused
> > here. On memory pressure, the call chain would be like:
> > VFS->ext4_evict_inode() -> ext4_free_inode() -> ext4_clear_inode(). In
> > ext4_clear_inode(), we free up the jbd2_inode as well. If that's the
> > case, how does jbd2_inode survive the memory pressure where its
> > corresponding VFS inode is freed up?
>
> Right (and I forgot about this detail of jbd2_inode lifetime). But with
> jbd2_inode the thing is that it needs to stay around only as long as there
> are dirty pages attached to the inode - once pages are written out (and
> this always happens before inode can be evicted from memory), we are sure
> the following transaction commit has nothing to do with the inode so we can
> safely free it.
>
> With your FC list, we need to track what has changed in the inode even
> after all data pages have been written out.
>
> > Assuming I'm missing something, one option would be to track
> > jbd2_inode in the FC list instead of ext4_inode_info? Would that take
> > care of the problem? Another option would be to trigger a fast_commit
> > from ext4_evict_inode if the inode being freed is on fc list. But I'm
> > worried that would increase the latency of unlink operation.
>
> So tracking in jbd2_inode will not help - I was confused about that.
> Forcing FC on inode eviction is IMO a no-go. That would regress some loads
> and also make behavior under memory pressure worse (XFS was actually doing
> something similar and they had serious trouble with that under heavy memory
> pressure because they needed to write tens of thousands of inodes to the
> log during reclaim).
>
> I think that if we are evicting an inode that is in fastcommit and that isn't
> unlinked, we just mark the fs as ineligible - to note we are loosing info
> needed for fastcommit. This shouldn't happen frequently and if it does, it
> means the machine is under heavy memory pressure and it likely isn't
> beneficial to keep the info around or try to reload inode from disk on
> fastcommit.
Ack, this sounds good to me! Thanks, I'll do this.
>
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +/*
> > > > > > + * Writes updated data ranges for the inode in question. Updates CRC.
> > > > > > + * Returns 0 on success, error otherwise.
> > > > > > + */
> > > > > > +static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> > > > > > +{
> > > > > > +     ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> > > > > > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > > > > > +     struct ext4_map_blocks map;
> > > > > > +     struct ext4_fc_add_range fc_ext;
> > > > > > +     struct ext4_fc_del_range lrange;
> > > > > > +     struct ext4_extent *ex;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     mutex_lock(&ei->i_fc_lock);
> > > > > > +     if (ei->i_fc_lblk_len == 0) {
> > > > > > +             mutex_unlock(&ei->i_fc_lock);
> > > > > > +             return 0;
> > > > > > +     }
> > > > > > +     old_blk_size = ei->i_fc_lblk_start;
> > > > > > +     new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
> > > > > > +     ei->i_fc_lblk_len = 0;
> > > > > > +     mutex_unlock(&ei->i_fc_lock);
> > > > > > +
> > > > > > +     cur_lblk_off = old_blk_size;
> > > > > > +     jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> > > > > > +               __func__, cur_lblk_off, new_blk_size, inode->i_ino);
> > > > > > +
> > > > > > +     while (cur_lblk_off <= new_blk_size) {
> > > > > > +             map.m_lblk = cur_lblk_off;
> > > > > > +             map.m_len = new_blk_size - cur_lblk_off + 1;
> > > > > > +             ret = ext4_map_blocks(NULL, inode, &map, 0);
> > > > > > +             if (ret < 0)
> > > > > > +                     return -ECANCELED;
> > > > >
> > > > > So isn't this actually racy with a risk of stale data exposure? Consider a
> > > > > situation like:
> > > > >
> > > > > Task 1:                         Task 2:
> > > > > pwrite(file, buf, 8192, 0)
> > > > > punch(file, 0, 4096)
> > > > > fsync(file)
> > > > >   writeout range 4096-8192
> > > > >   fastcommit for inode range 0-8192
> > > > >                                 pwrite(file, buf, 4096, 0)
> > > > >     ext4_map_blocks(file)
> > > > >       - reports that block at offset 0 is mapped so that is recorded in
> > > > >         fastcommit record. But data for that is not written so after a
> > > > >         crash we'd expose stale data in that block.
> > > > >
> > > > > Am I missing something?
> > > > So the way this gets handled is before entering this function, the
> > > > inode enters COMMITTING state (in ext4_fc_submit_inode_data_all
> > > > function). Once in COMMITTING state, all the inodes on this inode get
> > > > paused. Also, the commit path waits until all the ongoing updates on
> > > > that inode are completed. Once they are completed, only then its data
> > > > buffers are flushed and this ext4_map_blocks is called. So Task-2 here
> > > > would have either completely finished or would wait until the end of
> > > > this inode's commit. I realize that I should probably add more
> > > > comments to make this more clearer in the code. But is handling it
> > > > this way sufficient or am I missing any more cases?
> > >
> > > I see. In principle this should work. But I don't like that we have yet
> > > another mechanism that needs to properly wrap inode changes to make
> > > fastcommits work. And if we get it wrong somewhere, the breakage will be
> > > almost impossible to notice until someone looses data after a power
> > > failure. So it seems a bit fragile to me.
> > Ack
> > >
> > > Ideally I think we would reuse the current transaction machinery for this
> > > somehow (so that changes added through one transaction handle would behave
> > > atomically wrt to fastcommits) but the details are not clear to me yet. I
> > > need to think more about this...
> > Yeah, I thought about that too. All we need to do is to atomically
> > increment an "number of ongoing updates" counter on an inode, which
> > could be done by existing ext4_journal_start()/stop() functions.
> > However, the problem is that current ext4_journal_start()/stop() don't
> > take inode as an argumen. I considered changing all the
> > ext4_journal_start/stop calls but that would have inflated the size of
> > this patch series which is already pretty big. But we can do that as a
> > follow up cleanup. Does that sound reasonable?
>
> So ext4_journal_start() actually does take inode as an argument and we use
> it quite some places (we also have ext4_journal_start_sb() which takes just
> the superblock). What I'm not sure about is whether that's the inode you
> want to protect for fastcommit purposes (would need some code auditing) or
> whether there are not more inodes that need the protection for some
> operations. ext4_journal_stop() could be handled by recording the inode in
> the handle on ext4_journal_start() so ext4_journal_stop() then knows for
> which inode to decrement the counter.
>
> Another possibility would be to increment the counter in
> ext4_get_inode_loc() - that is a clear indication we are going to change
> something in the inode. This also automatically handles the situation when
> multiple inodes are modified by the operation or that proper inodes are
> being protected. With decrementing the counter it is somewhat more
> difficult. I think we can only do that at ext4_journal_stop() time so we
> need to record in the handle for which inodes we acquired the update
> references and drop them from ext4_journal_stop(). This would look as a
> rather robust solution to me...
..the only problem here is that the same handle can be returned by
multiple calls to ext4_journal_start(). That means a handle returned
by ext4_journal_start() could be associated with multiple inodes. One
way to deal with this would be to define ext4 specific handle
structure. So, each call to ext4_journal_start would return a struct
that looks like following:

struct ext4_handle {
    handle_t *jbd2_handle;
    struct inode *inode;
}

So now on ext4_journal_stop(), we know for which inode we need to drop
counters. The objects of this struct would either need to have their
own kmem_cache or would need to be defined on stack (I think the
latter is preferred). Should we do this? If we do this, this is going
to be a pretty big change (will have to inspect all the existing
callers of ext4_journal_start() and ext4_journal_stop()).

Another option would be to change the definition of handle_t such that
on every call to jbd2_journal_start(), we get a new wrapper object
that takes a reference on handle_t. Such an object would have a
private pointer that FS can use the way it wants. This will be a
relatively smaller change but it would impact OCFS too. But if we go
this route, we can't avoid using a new kmem_cache, since now these new
handle wrappers would need to be allocated inside of JBD2.

I kind of like the second option better because it keeps the change
comparatively smaller. Wdyt? Also, Ted / Andreas, wdyt?

Thanks,
Harshad

Thank
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
