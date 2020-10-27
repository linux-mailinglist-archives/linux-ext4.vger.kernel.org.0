Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DEB29C2B0
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Oct 2020 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820791AbgJ0Rih (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Oct 2020 13:38:37 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:46267 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760354AbgJ0Rif (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Oct 2020 13:38:35 -0400
Received: by mail-ej1-f65.google.com with SMTP id t25so3399015ejd.13
        for <linux-ext4@vger.kernel.org>; Tue, 27 Oct 2020 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzRkJ6+B7+EQNE6NUDNUSFGBRBqrG4GdS9FQgplcndU=;
        b=oiMtii7295sctvDuxBJpG7sIeIRxMEJnRSkmO7GQXDlESXSDsS/2Vh7KnA8rFUTfBD
         EfeJvafM1HowPdwXWepV5B0Guws60QPSkXN6a194UO4WvsjxRqUjf8FMA9QoMiREqWp7
         C6lF4PJmSIofE1d27wRsbM3/zXWZ5Nfuypt6Mjg+3XDYt7YvMeYMg1ZxiLqkR9Q47eAF
         GTglaKyc+2PY8IioxxQV9uJuKAjNJhbaDuhGfwcNpf4AwFxG6SQ7i94CzVC2tVzd2fjN
         K3pDABIhJpzV3EQyKoTFvPB3WIkj1iK8lIx50n5o3syJwskZSlbMjHC+wCzO0+oRPJOM
         rgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzRkJ6+B7+EQNE6NUDNUSFGBRBqrG4GdS9FQgplcndU=;
        b=ByM3UNxKjZibC+gxsc+cjMTG+Eiht97Eoj47k3ZcPnHWDCyjD04ddla7NIndE94Czz
         JsKpcSNz/rzv8/40qAGsux1uICjefSPbfOmO+hekEm0xkZS3OCyTrrTjRlbVQR3pE4Fo
         cM+YXigu/oStH4EP/n+Ya5ofC8jCA4dktJMMcssgl/JXsAyYpMEfkd34MQ/UFFwUki93
         XcjivQk6ez80nlwLv+VPGj1q9zD4iGWEHlLKeMUNgK/fi30TumcKfio7lk6o4Zna0jGB
         e75sh0AbFaeT3b7p/RBJj50hnW+yoUSedJpPj3rkE2jj04ID1ngOr2PXOgzToyFgECAS
         bOQg==
X-Gm-Message-State: AOAM533gCap7Lv0Ul7xWHlHB+s+ZqZNgBaPkmAZwPT1F2cUejz5HB5Xy
        dYDxe68RdWGfoQWEVkXbbQjWBTIgHvgAb8BaRnk=
X-Google-Smtp-Source: ABdhPJxvH5OowNxOvZU69rGieewFmJQbS7SHJ48sNyl7DKNZus2kmv4ciP8qZLG28wMCdUb5URmq1TuaO9gMdU0n4RU=
X-Received: by 2002:a17:906:354e:: with SMTP id s14mr3471509eja.192.1603820310490;
 Tue, 27 Oct 2020 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com> <20201023103013.GF25702@quack2.suse.cz>
 <CAD+ocbws2J0boxfNA+gahWwTAqm8-Pef9_WkcwwKFjpiJhvJKw@mail.gmail.com> <20201027142910.GB16090@quack2.suse.cz>
In-Reply-To: <20201027142910.GB16090@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 27 Oct 2020 10:38:19 -0700
Message-ID: <CAD+ocbx0JMK=s3u2OXwRXt1BDUf18+DU_XF6WV2VarAi7CLgRw@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 27, 2020 at 7:29 AM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 26-10-20 13:55:47, harshad shirwadkar wrote:
> > > > + *
> > > > + * The fast commit space at the end of above operations would look like this:
> > > > + *      [HEAD] [CREAT A] [UNLINK B] [TAIL] [ADD_RANGE A] [DEL_RANGE A] [TAIL]
> > > > + *             |<---  Fast Commit 1   --->|<---      Fast Commit 2     ---->|
> > > > + *
> > > > + * Replay code should thus check for all the valid tails in the FC area.
> > >
> > > And one design question: Why do we record unlink of B here? I was kind of
> > > hoping that fastcommit due to fsync(A) would record only operations related
> > > to A. Because the way you wrote it, fast commit is inherently still a
> > > filesystem-global operation requiring global ordering of metadata changes
> > > with all the scalability bottlenecks current journalling code has. It's
> > > faster by some factor due to more efficient packing of "small" changes not
> > > fundamentally faster AFAICT...
> > So given that fsync() for Ext4 traditionally resulted in syncing of
> > all the dirty inodes / buffers. If we fsync() only the file in
> > question, I'm worried that we may break some of the existing
> > applications. In the earlier version of the series, I had a
> > "soft_consistency" mode which did exactly that. It broke a bunch of
> > xfstests that had this assumption. Also, in my tests I didn't see a
> > big performance difference between these fast commits and the fast
> > commits with soft consistency. Most probably, that's because the
> > benchmarks perform a fsync on all the files and current fast commits
> > give it a batching effect which soft consistency mode would fail to
> > provide.
> >
> > But I'm not fixated on this, I think it's still good to have
> > soft_consistency mode. Good thing is this doesn't affect the on-disk
> > format. So, this is something that can be gradually added to Ext4.
>
> OK, I see. Maybe add a paragraph about this to fastcommit doc? I agree that
> we can leave these optimizations for later, I was just wondering whether
> there isn't some fundamental reason why global flush would be required and
> I'm happy to hear that there isn't.
Ack
>
> The advantage of soft_consistency as you call it would be IMO most seen if
> there's relatively heavy non-fsync IO load in parallel with frequent fsyncs
> of a tiny file. And such load is not infrequent in practice. I agree that
> benchmarks like dbench are unlikely to benefit from soft_consistency since
> all IO the benchmark does is in fact forced by fsync.
>
> I also think that with soft_consistency we could benefit (e.g. on SSD
> storage) from having several fast-commit areas in the journal so multiple
> fastcommits can run in parallel. But that's also for some later
> experimentation...
Yeah makes sense.
>
> > > > +
> > > > +     mutex_lock(&ei->i_fc_lock);
> > > > +     if (running_txn_tid == ei->i_sync_tid) {
> > > > +             update = true;
> > > > +     } else {
> > > > +             ext4_fc_reset_inode(inode);
> > > > +             ei->i_sync_tid = running_txn_tid;
> > > > +     }
> > > > +     ret = __fc_track_fn(inode, args, update);
> > > > +     mutex_unlock(&ei->i_fc_lock);
> > > > +
> > > > +     if (!enqueue)
> > > > +             return ret;
> > > > +
> > > > +     spin_lock(&sbi->s_fc_lock);
> > > > +     if (list_empty(&EXT4_I(inode)->i_fc_list))
> > > > +             list_add_tail(&EXT4_I(inode)->i_fc_list,
> > > > +                             (sbi->s_mount_state & EXT4_FC_COMMITTING) ?
> > > > +                             &sbi->s_fc_q[FC_Q_STAGING] :
> > > > +                             &sbi->s_fc_q[FC_Q_MAIN]);
> > > > +     spin_unlock(&sbi->s_fc_lock);
> > >
> > > OK, so how do you prevent inode from being freed while it is still on
> > > i_fc_list? I don't see anything preventing that and it could cause nasty
> > > use-after-free issues. Note that for similar reasons JBD2 uses external
> > > separately allocated inode for jbd2_inode so that it can have separate
> > > lifetime (related to transaction commits) from struct ext4_inode_info.
> > So, if you see the function ext4_fc_del() above, it's called from
> > ext4_clear_inode(). What ext4_fc_del() does is that, if the inode is
> > not being committed, it just removes it from the list. If that inode
> > was deleted, we have a separate dentry queue which will record the
> > deletion of the inode, so we don't really need the struct
> > ext4_inode_info for recording that on-disk. However, if the inode is
> > being committed (this is figured out by checking the per inode
> > COMMITTING state), ext4_fc_del() waits until the completion.
>
> But I don't think this quite works. Consider the following scenario:
>
> inode I gets modified in transaction T
>   you add I to FC list
>
> memory pressure reclaims I from memory
>   you remove I from FC list
>
> open(I) -> inode gets loaded to memory again. Not tracked in FC list.
> fsync(I) -> nothing to do, FC list is empty
> <crash>
>
> And 'I' now doesn't contain data in should because T didn't commit yet and
> FC was empty.
Hmmm, I see. This needs to get fixed. However, I'm a little confused
here. On memory pressure, the call chain would be like:
VFS->ext4_evict_inode() -> ext4_free_inode() -> ext4_clear_inode(). In
ext4_clear_inode(), we free up the jbd2_inode as well. If that's the
case, how does jbd2_inode survive the memory pressure where its
corresponding VFS inode is freed up?

Assuming I'm missing something, one option would be to track
jbd2_inode in the FC list instead of ext4_inode_info? Would that take
care of the problem? Another option would be to trigger a fast_commit
from ext4_evict_inode if the inode being freed is on fc list. But I'm
worried that would increase the latency of unlink operation.
>
> > > > +
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +struct __track_dentry_update_args {
> > > > +     struct dentry *dentry;
> > > > +     int op;
> > > > +};
> > > > +
> > > > +/* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
> > > > +static void ext4_fc_submit_bh(struct super_block *sb)
> > > > +{
> > > > +     int write_flags = REQ_SYNC;
> > > > +     struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
> > > > +
> > > > +     if (test_opt(sb, BARRIER))
> > > > +             write_flags |= REQ_FUA | REQ_PREFLUSH;
> > >
> > > Submitting each fastcommit buffer with REQ_FUA | REQ_PREFLUSH is
> > > unnecessarily expensive (especially if there will be unrelated writes
> > > happening to the filesystem while fastcommit is running). If nothing else,
> > > it's enough to have REQ_PREFLUSH only once during the whole fastcommit to
> > > flush out written back data blocks (plus journal device may be different
> > > from the filesystem device so you need to be flushing the filesystem device
> > > for this - see how the jbd2 commit code does this).
> > >
> > > Also REQ_FUA on each block may be overkill for devices that don't support
> > > it natively (and thus REQ_FUA is simulated with full write cache pre and
> > > post flush) - for such devices it would be better to just write out
> > > fastcommit normally and then issue one cache flush. With careful
> > > checksumming, block ID tagging and such, it should be safe against disk
> > > reordering writes. But I guess we can leave this optimization as a TODO
> > > item for later (but I think it would be good to design the on-disk format of
> > > fastcommit blocks so that it does not rely on FUA writes).
> > I see. The on disk format doesn't rely on FUA / PREFLUSH, I added it
> > based on the observation that in most cases all the fast commit info
> > was written in 1 block only. I didn't see much difference in the
> > performance but I get your point. I'll add this as a TODO in the code
> > for now.
>
> OK, the performance optimization can wait for later but the flushing of
> proper device needs to be fixed soon - as I wrote above REQ_PREFLUSH is not
> enough (and needed at all) when the journal device is different from the
> filesystem device.
Ack
>
> > > > +/*
> > > > + * Complete a fast commit by writing tail tag.
> > > > + *
> > > > + * Writing tail tag marks the end of a fast commit. In order to guarantee
> > > > + * atomicity, after writing tail tag, even if there's space remaining
> > > > + * in the block, next commit shouldn't use it. That's why tail tag
> > > > + * has the length as that of the remaining space on the block.
> > > > + */
> > > > +static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
> > > > +{
> > > > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > > > +     struct ext4_fc_tl tl;
> > > > +     struct ext4_fc_tail tail;
> > > > +     int off, bsize = sbi->s_journal->j_blocksize;
> > > > +     u8 *dst;
> > > > +
> > > > +     /*
> > > > +      * ext4_fc_reserve_space takes care of allocating an extra block if
> > > > +      * there's no enough space on this block for accommodating this tail.
> > > > +      */
> > > > +     dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(tail), &crc);
> > > > +     if (!dst)
> > > > +             return -ENOSPC;
> > > > +
> > > > +     off = sbi->s_fc_bytes % bsize;
> > > > +
> > > > +     tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_TAIL);
> > > > +     tl.fc_len = cpu_to_le16(bsize - off - 1 + sizeof(struct ext4_fc_tail));
> > > > +     sbi->s_fc_bytes = round_up(sbi->s_fc_bytes, bsize);
> > > > +
> > > > +     ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), &crc);
> > > > +     dst += sizeof(tl);
> > > > +     tail.fc_tid = cpu_to_le32(sbi->s_journal->j_running_transaction->t_tid);
> > > > +     ext4_fc_memcpy(sb, dst, &tail.fc_tid, sizeof(tail.fc_tid), &crc);
> > > > +     dst += sizeof(tail.fc_tid);
> > > > +     tail.fc_crc = cpu_to_le32(crc);
> > > > +     ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
> > > > +
> > > > +     ext4_fc_submit_bh(sb);
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > Is there a reason to pass CRC all around (so you have to have special
> > > functions like ext4_fc_memcpy(), ext4_fc_memzero(), ...) instead of just
> > > creating the whole block and then computing CRC in one go?
> > >
> > > In fact, as looking through the code, it seems to me it would be slightly
> > > nicer layer separation and interface if JBD2 provided functions for storage
> > > of data blobs and handled the details of space & block management,
> > > checksums, writeout, on recovery verification of correctness (so it would
> > > just provide back a stream of blobs for FS to replay). Just an idea for
> > > consideration, the current interface isn't too bad and we can change it
> > > later if we decide so.
> > I designed this keeping DAX mode in mind where we would benefit if we
> > don't use buffer heads and blocks. There is no block level CRC, but
> > CRC covers all the tags either from the start or from the last tail
> > tag (whichever comes first). This kind of CRC can span across
> > multipleblocks or we could have multiple CRCs in one block. Passing
> > CRC around helps us to compute CRC as we write tags to storage. In DAX
> > mode, this would allow fast commit commits to be smaller than block
> > size. DAX mode code isn't implemented completely yet, but I wanted to
> > make sure that the design of on-disk format is consistent and
> > efficient for both DAX and non-DAX modes.
>
> OK, I understand. Thanks for explanation!
>
> > > > +
> > > > +/*
> > > > + * Adds tag, length, value and updates CRC. Returns true if tlv was added.
> > > > + * Returns false if there's not enough space.
> > > > + */
> > > > + */
> > > > +static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
> > > > +{
> > > > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > > > +     int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
> > > > +     int ret;
> > > > +     struct ext4_iloc iloc;
> > > > +     struct ext4_fc_inode fc_inode;
> > > > +     struct ext4_fc_tl tl;
> > > > +     u8 *dst;
> > > > +
> > > > +     ret = ext4_get_inode_loc(inode, &iloc);
> > > > +     if (ret)
> > > > +             return ret;
> > > > +
> > > > +     if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
> > > > +             inode_len += ei->i_extra_isize;
> > > > +
> > > > +     fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
> > > > +     tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
> > > > +     tl.fc_len = cpu_to_le16(inode_len + sizeof(fc_inode.fc_ino));
> > > > +
> > > > +     dst = ext4_fc_reserve_space(inode->i_sb,
> > > > +                     sizeof(tl) + inode_len + sizeof(fc_inode.fc_ino), crc);
> > > > +     if (!dst)
> > > > +             return -ECANCELED;
> > > > +
> > > > +     if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, sizeof(tl), crc))
> > > > +             return -ECANCELED;
> > > > +     dst += sizeof(tl);
> > > > +     if (!ext4_fc_memcpy(inode->i_sb, dst, &fc_inode, sizeof(fc_inode), crc))
> > > > +             return -ECANCELED;
> > > > +     dst += sizeof(fc_inode);
> > > > +     if (!ext4_fc_memcpy(inode->i_sb, dst, (u8 *)ext4_raw_inode(&iloc),
> > > > +                                     inode_len, crc))
> > > > +             return -ECANCELED;
> > >
> > > Isn't this racy? What guarantees the inode state you record here is a valid
> > > one for the fastcommit? I mean this gets called at the time of fastcommit
> > > (i.e., fsync), so a fastcommit code must record changes to all other
> > > metadata that relate to the currently recorded inode state. But this isn't
> > > serialized in any way (AFAICT) with on-going inode changes so how can
> > > fastcommit code guarantee that? This is a similar case as a problem I
> > > describe below...
> > So we have ext4_fc_start_update(inode) / ext4_fc_stop_update(inode)
> > which is called by all the operations that happen on an inode. If the
> > inode in question is undergoing a fast commit, ext4_fc_start_update()
> > will block. So that ensures that inode won't be modified once fast
> > commit starts. So, in general, before doing any fast commit related
> > operation, we'll first put the inode in committing state, that's the
> > state of the inode which will be committed on-disk in fast commit.
>
> I see. See the case below for my comments.
>
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +/*
> > > > + * Writes updated data ranges for the inode in question. Updates CRC.
> > > > + * Returns 0 on success, error otherwise.
> > > > + */
> > > > +static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> > > > +{
> > > > +     ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> > > > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > > > +     struct ext4_map_blocks map;
> > > > +     struct ext4_fc_add_range fc_ext;
> > > > +     struct ext4_fc_del_range lrange;
> > > > +     struct ext4_extent *ex;
> > > > +     int ret;
> > > > +
> > > > +     mutex_lock(&ei->i_fc_lock);
> > > > +     if (ei->i_fc_lblk_len == 0) {
> > > > +             mutex_unlock(&ei->i_fc_lock);
> > > > +             return 0;
> > > > +     }
> > > > +     old_blk_size = ei->i_fc_lblk_start;
> > > > +     new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
> > > > +     ei->i_fc_lblk_len = 0;
> > > > +     mutex_unlock(&ei->i_fc_lock);
> > > > +
> > > > +     cur_lblk_off = old_blk_size;
> > > > +     jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> > > > +               __func__, cur_lblk_off, new_blk_size, inode->i_ino);
> > > > +
> > > > +     while (cur_lblk_off <= new_blk_size) {
> > > > +             map.m_lblk = cur_lblk_off;
> > > > +             map.m_len = new_blk_size - cur_lblk_off + 1;
> > > > +             ret = ext4_map_blocks(NULL, inode, &map, 0);
> > > > +             if (ret < 0)
> > > > +                     return -ECANCELED;
> > >
> > > So isn't this actually racy with a risk of stale data exposure? Consider a
> > > situation like:
> > >
> > > Task 1:                         Task 2:
> > > pwrite(file, buf, 8192, 0)
> > > punch(file, 0, 4096)
> > > fsync(file)
> > >   writeout range 4096-8192
> > >   fastcommit for inode range 0-8192
> > >                                 pwrite(file, buf, 4096, 0)
> > >     ext4_map_blocks(file)
> > >       - reports that block at offset 0 is mapped so that is recorded in
> > >         fastcommit record. But data for that is not written so after a
> > >         crash we'd expose stale data in that block.
> > >
> > > Am I missing something?
> > So the way this gets handled is before entering this function, the
> > inode enters COMMITTING state (in ext4_fc_submit_inode_data_all
> > function). Once in COMMITTING state, all the inodes on this inode get
> > paused. Also, the commit path waits until all the ongoing updates on
> > that inode are completed. Once they are completed, only then its data
> > buffers are flushed and this ext4_map_blocks is called. So Task-2 here
> > would have either completely finished or would wait until the end of
> > this inode's commit. I realize that I should probably add more
> > comments to make this more clearer in the code. But is handling it
> > this way sufficient or am I missing any more cases?
>
> I see. In principle this should work. But I don't like that we have yet
> another mechanism that needs to properly wrap inode changes to make
> fastcommits work. And if we get it wrong somewhere, the breakage will be
> almost impossible to notice until someone looses data after a power
> failure. So it seems a bit fragile to me.
Ack
>
> Ideally I think we would reuse the current transaction machinery for this
> somehow (so that changes added through one transaction handle would behave
> atomically wrt to fastcommits) but the details are not clear to me yet. I
> need to think more about this...
Yeah, I thought about that too. All we need to do is to atomically
increment an "number of ongoing updates" counter on an inode, which
could be done by existing ext4_journal_start()/stop() functions.
However, the problem is that current ext4_journal_start()/stop() don't
take inode as an argumen. I considered changing all the
ext4_journal_start/stop calls but that would have inflated the size of
this patch series which is already pretty big. But we can do that as a
follow up cleanup. Does that sound reasonable?
>
> > > > +
> > > > +             if (map.m_len == 0) {
> > > > +                     cur_lblk_off++;
> > > > +                     continue;
> > > > +             }
> > > > +
> > > > @@ -271,6 +272,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > > >
> > > >  out:
> > > >       inode_unlock(inode);
> > > > +     ext4_fc_stop_update(inode);
> > > >       if (likely(ret > 0)) {
> > > >               iocb->ki_pos += ret;
> > > >               ret = generic_write_sync(iocb, ret);
> > > > @@ -534,7 +536,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > > >                       goto out;
> > > >               }
> > > >
> > > > +             ext4_fc_start_update(inode);
> > > >               ret = ext4_orphan_add(handle, inode);
> > > > +             ext4_fc_stop_update(inode);
> > >
> > > Why is here protected only the orphan addition? What about other changes
> > > happening to the inode during direct write?
> > This is the only change that is protected by handle in this function.
> > What I'm trying to do here (and in other places) is that anything that
> > happens between ext4_journal_start() and ext4_journal_stop() happens
> > atomically. The way to guarantee that is to ensure that the same block
> > is also surrounded by ext4_fc_start_update(inode) and
> > ext4_fc_stop_update(inode).
> >
> > I also realized while looking at this comment is that we probably need
> > a new TLV for adding orphan inode to the list?
>
> > > Also I don't see anything tracking inode changes due to writes through mmap?
> > > How is that supposed to work?
> > Right, I have missed those. I see that mmap function
> > ext4_page_mkwrite() calls ext4_jbd2_inode_add_write that tells jbd2
> > what is the range that needs to be written for the inode in question.
> > I guess I can just update that function to update inode's FC range as
> > well?
>
> Yes, you need to add tracking of the page range handled in
> ext4_page_mkwrite() to FC.
Ack
>
> I've also realized that you probably need to disable fastcommits when data
> journaling is enabled for the inode (probably just disable fastcommit
> feature with data=jounral mount option, make inode ineligible if it has
> 'journal data' flag set).
Oh yes, thanks for pointing that out. I'll fix that too

Thanks,
Harshad
>
>                                                                         Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
