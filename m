Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D751B299845
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Oct 2020 21:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgJZU4F (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 16:56:05 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:33575 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgJZU4E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Oct 2020 16:56:04 -0400
Received: by mail-ej1-f68.google.com with SMTP id c15so15809758ejs.0
        for <linux-ext4@vger.kernel.org>; Mon, 26 Oct 2020 13:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TSDeqURda22wP0PW4fdOrUZ9az/qvb7P3WC68Rfb9mk=;
        b=FrY5NRr9W7EjSKiFqekO12+ykIM7qP4dMwuXYuoG6MWOq3hMoLt0b05Isrm7Qx9DRC
         GCdSs8UpABqTqK0+AXE+foCTHhzQs/yD/X7tOAO26/q9+Y2FXhYI73H9t3j3osoP16Gf
         SZYoI5xeI3NQSBRBfAvCNl+0nTSvRFIGyt/Mtt2BkuQXt/QneSOId3+ma+PCPKHPOoRk
         ptlkrPFUo6F+VF4OIC2q9CQ6/uhuVcB/HDIUwL4IxR1bBuLkelRVdqKf/0fAPlAH0/Xt
         jS8laESXEqQ1PwGcDEVDRRmM/zv1oEEsCJ21Kyleu8/3QEtPBki5463K91E792VhA5yd
         J7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TSDeqURda22wP0PW4fdOrUZ9az/qvb7P3WC68Rfb9mk=;
        b=mEkq6h/w39qTKoemimlURcTcb3lSD/FUREghyx8gXM8sETBcLmClqFzb6dCaYgkKqj
         PWAh1HB1MlBn+GCwsAYr+MYxY3bfT9LeaKML+mCwKSkH41p+UNlUNM86ZgkjYYs3gWGi
         Xh7x47A6TKtgVc/Hfy53CL0KMbDbnifr1rnfhLDb6+ZpGY3fjwPh+Y+yu49H5N8P0mj6
         VFUGZ/1v0mBri4m4YAGy2WVzQDYsHcPK5U8FxnpX68gLfPSYDXmx7vwoI0exhAj2b7PU
         rJhc1pXoKuRNnzEYRyzrU6Y7B6h98EwqF33amTBoXnBzAI+5h1zQraA9tvhq6+Z2F57i
         fK/w==
X-Gm-Message-State: AOAM530e6CsyhDT5eAvYSBfCM2GacqsXh0TcJxfDDxeiEScJXTe+poDJ
        zftbFXyC43bHBQFLupUe0c2s+1gncwK81ca+HoA=
X-Google-Smtp-Source: ABdhPJwBj22fW28hXoi0BlYYzioy5uAjztNq3vxbuIKs5ehzmVt1+1QaPw+xQQpvRzsTZxLExZX4DB0kE4oqAZHLp78=
X-Received: by 2002:a17:906:2e0e:: with SMTP id n14mr17062485eji.120.1603745759172;
 Mon, 26 Oct 2020 13:55:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-6-harshadshirwadkar@gmail.com> <20201023103013.GF25702@quack2.suse.cz>
In-Reply-To: <20201023103013.GF25702@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 26 Oct 2020 13:55:47 -0700
Message-ID: <CAD+ocbws2J0boxfNA+gahWwTAqm8-Pef9_WkcwwKFjpiJhvJKw@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] ext4: main fast-commit commit path
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I have reduced the size of the email by trimming off some parts of the
original email. Responses inlined:

On Fri, Oct 23, 2020 at 3:30 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-10-20 13:37:57, Harshad Shirwadkar wrote:
> > diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> > index 76f634d185f1..68aaed48315f 100644
> >       /*
> >        * i_disksize keeps track of what the inode size is ON DISK, not
> >        * in memory.  During truncate, i_size is set to the new size by
> > @@ -1141,6 +1163,10 @@ struct ext4_inode_info {
> >  #define      EXT4_VALID_FS                   0x0001  /* Unmounted cleanly */
> >  #define      EXT4_ERROR_FS                   0x0002  /* Errors detected */
> >  #define      EXT4_ORPHAN_FS                  0x0004  /* Orphans being recovered */
> > +#define EXT4_FC_INELIGIBLE           0x0008  /* Fast commit ineligible */
> > +#define EXT4_FC_COMMITTING           0x0010  /* File system underoing a fast
>           ^^ please align these as the previous values
> Also the names should have _FS suffix.
Ack
>
> Now after more looking, these are actually used in s_mount_state which is
> persistently stored on disk which is probably not what you want. You rather
> want to use something like sbi->s_mount_flags for these?
Oh, you are right, thanks for catching this. I wanted to use
sbi->s_mount_flags. Will fix this.

>
> And now that I also look at sbi->s_mount_flags, these should use atomic
> bitops as currently they seem to be succeptible to RMW races (e.g. due to
> EXT4_MF_MNTDIR_SAMPLED flag) and your flags also need the atomic behavior.
> That would be a separate patch fixing this.
Right, I'll send out a patch for this.
>
> > +                                              * commit.
> > +                                              */
> >
> >  /*
> >   * Misc. filesystem flags
> > @@ -1613,6 +1639,30 @@ struct ext4_sb_info {
> > + *   ext4_fc_stop_ineligible() to fall back to full commits. It is important to
> > + *   make one more fast commit to fall back to full commit after stop call so
> > + *   that it guaranteed that the fast commit ineligible operation contained
> > + *   within ext4_fc_start_ineligible() and ext4_fc_stop_ineligible() is
> > + *   followed by at least 1 full commit.
> > + *
> > + * Atomicity of commits
> > + * --------------------
> > + * In order to gaurantee atomicity during the commit operation, fast commit
>                   ^^^ guarantee

Ack
>
> > + * uses "EXT4_FC_TAG_TAIL" tag that marks a fast commit as complete. Tail
> > + * tag contains CRC of the contents and TID of the transaction after which
> > + * this fast commit should be applied. Recovery code replays fast commit
> > + * logs only if there's at least 1 valid tail present. For every fast commit
> > + * operation, there is 1 tail. This means, we may end up with multiple tails
> > + * in the fast commit space. Here's an example:
> > + *
> > + * - Create a new file A and remove existing file B
> > + * - fsync()
>
> Great that there's an example here. But what do we fsync here? A or dir with
> A or something else?
Well it doesn't matter, explained below:
>
> > + * - Append contents to file A
> > + * - Truncate file A
> > + * - fsync()
>
> And what is fsynced here?
Same
>
> > + *
> > + * The fast commit space at the end of above operations would look like this:
> > + *      [HEAD] [CREAT A] [UNLINK B] [TAIL] [ADD_RANGE A] [DEL_RANGE A] [TAIL]
> > + *             |<---  Fast Commit 1   --->|<---      Fast Commit 2     ---->|
> > + *
> > + * Replay code should thus check for all the valid tails in the FC area.
>
> And one design question: Why do we record unlink of B here? I was kind of
> hoping that fastcommit due to fsync(A) would record only operations related
> to A. Because the way you wrote it, fast commit is inherently still a
> filesystem-global operation requiring global ordering of metadata changes
> with all the scalability bottlenecks current journalling code has. It's
> faster by some factor due to more efficient packing of "small" changes not
> fundamentally faster AFAICT...
So given that fsync() for Ext4 traditionally resulted in syncing of
all the dirty inodes / buffers. If we fsync() only the file in
question, I'm worried that we may break some of the existing
applications. In the earlier version of the series, I had a
"soft_consistency" mode which did exactly that. It broke a bunch of
xfstests that had this assumption. Also, in my tests I didn't see a
big performance difference between these fast commits and the fast
commits with soft consistency. Most probably, that's because the
benchmarks perform a fsync on all the files and current fast commits
give it a batching effect which soft consistency mode would fail to
provide.

But I'm not fixated on this, I think it's still good to have
soft_consistency mode. Good thing is this doesn't affect the on-disk
format. So, this is something that can be gradually added to Ext4.
>
> > + *
> > + * TODOs
> > + * -----
> > + * 1) Make fast commit atomic updates more fine grained. Today, a fast commit
> > + *    eligible update must be protected within ext4_fc_start_update() and
> > + *    ext4_fc_stop_update(). These routines are called at much higher
> > + *    routines. This can be made more fine grained by combining with
> > + *    ext4_journal_start().
> > + *
> > + * 2) Same above for ext4_fc_start_ineligible() and ext4_fc_stop_ineligible()
> > + *
> > + * 3) Handle more ineligible cases.
> > + */
> > +void ext4_fc_del(struct inode *inode)
> > +{
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> > +             return;
> > +
> > +
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> > +             return;
>
> Uh, why testing twice?
Oops, will fix this.
>
> > +
> > +restart:
> > +     spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +     if (list_empty(&ei->i_fc_list)) {
> > +             spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +             return;
> > +     }
> > +
> > +     if (ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING)) {
> > +             wait_queue_head_t *wq;
> > +#if (BITS_PER_LONG < 64)
> > +             DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq = bit_waitqueue(&ei->i_state_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#else
> > +             DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +             wq = bit_waitqueue(&ei->i_flags,
> > +                                EXT4_STATE_FC_COMMITTING);
> > +#endif
>
> Create a helper function for waiting for EXT4_STATE_FC_COMMITTING? It is
> opencoded several times...
Ack
>
> > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +             spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +             schedule();
> > +             finish_wait(wq, &wait.wq_entry);
> > +             goto restart;
> > +     }
> > +     if (!list_empty(&ei->i_fc_list))
>
> You've checked for list_empty() above, no need to recheck again...
Ack
>
> > +             list_del_init(&ei->i_fc_list);
> > +     spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +}
> > +
> > +static int ext4_fc_track_template(
> > +     struct inode *inode, int (*__fc_track_fn)(struct inode *, void *, bool),
> > +     void *args, int enqueue)
> > +{
> > +     tid_t running_txn_tid;
> > +     bool update = false;
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +     struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > +     int ret;
> > +
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (ext4_fc_is_ineligible(inode->i_sb))
> > +             return -EINVAL;
> > +
> > +     running_txn_tid = sbi->s_journal ?
> > +             sbi->s_journal->j_commit_sequence + 1 : 0;
>
> This looks problematic. The j_commit_sequence sampling is racy - first
> without j_state_lock you can be fetching stale value, second you don't
> know whether there is transaction currently committing or not. If there is,
> j_commit_sequence will contain TID of the transaction before it which is
> wrong for your purposes. I think you should pass 'handle' into all the
> tracking functions and derive running transaction TID from that as we do it
> elsewhere.
Oh thanks for pointing this out. Okay makes sense, I'll use handle for this.
>
> > +
> > +     mutex_lock(&ei->i_fc_lock);
> > +     if (running_txn_tid == ei->i_sync_tid) {
> > +             update = true;
> > +     } else {
> > +             ext4_fc_reset_inode(inode);
> > +             ei->i_sync_tid = running_txn_tid;
> > +     }
> > +     ret = __fc_track_fn(inode, args, update);
> > +     mutex_unlock(&ei->i_fc_lock);
> > +
> > +     if (!enqueue)
> > +             return ret;
> > +
> > +     spin_lock(&sbi->s_fc_lock);
> > +     if (list_empty(&EXT4_I(inode)->i_fc_list))
> > +             list_add_tail(&EXT4_I(inode)->i_fc_list,
> > +                             (sbi->s_mount_state & EXT4_FC_COMMITTING) ?
> > +                             &sbi->s_fc_q[FC_Q_STAGING] :
> > +                             &sbi->s_fc_q[FC_Q_MAIN]);
> > +     spin_unlock(&sbi->s_fc_lock);
>
> OK, so how do you prevent inode from being freed while it is still on
> i_fc_list? I don't see anything preventing that and it could cause nasty
> use-after-free issues. Note that for similar reasons JBD2 uses external
> separately allocated inode for jbd2_inode so that it can have separate
> lifetime (related to transaction commits) from struct ext4_inode_info.
So, if you see the function ext4_fc_del() above, it's called from
ext4_clear_inode(). What ext4_fc_del() does is that, if the inode is
not being committed, it just removes it from the list. If that inode
was deleted, we have a separate dentry queue which will record the
deletion of the inode, so we don't really need the struct
ext4_inode_info for recording that on-disk. However, if the inode is
being committed (this is figured out by checking the per inode
COMMITTING state), ext4_fc_del() waits until the completion.
>
> > +
> > +     return ret;
> > +}
> > +
> > +struct __track_dentry_update_args {
> > +     struct dentry *dentry;
> > +     int op;
> > +};
> > +
> > +/* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
> > +static void ext4_fc_submit_bh(struct super_block *sb)
> > +{
> > +     int write_flags = REQ_SYNC;
> > +     struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
> > +
> > +     if (test_opt(sb, BARRIER))
> > +             write_flags |= REQ_FUA | REQ_PREFLUSH;
>
> Submitting each fastcommit buffer with REQ_FUA | REQ_PREFLUSH is
> unnecessarily expensive (especially if there will be unrelated writes
> happening to the filesystem while fastcommit is running). If nothing else,
> it's enough to have REQ_PREFLUSH only once during the whole fastcommit to
> flush out written back data blocks (plus journal device may be different
> from the filesystem device so you need to be flushing the filesystem device
> for this - see how the jbd2 commit code does this).
>
> Also REQ_FUA on each block may be overkill for devices that don't support
> it natively (and thus REQ_FUA is simulated with full write cache pre and
> post flush) - for such devices it would be better to just write out
> fastcommit normally and then issue one cache flush. With careful
> checksumming, block ID tagging and such, it should be safe against disk
> reordering writes. But I guess we can leave this optimization as a TODO
> item for later (but I think it would be good to design the on-disk format of
> fastcommit blocks so that it does not rely on FUA writes).
I see. The on disk format doesn't rely on FUA / PREFLUSH, I added it
based on the observation that in most cases all the fast commit info
was written in 1 block only. I didn't see much difference in the
performance but I get your point. I'll add this as a TODO in the code
for now.
>
> > +     lock_buffer(bh);
> > +     clear_buffer_dirty(bh);
> > +     set_buffer_uptodate(bh);
> > +     bh->b_end_io = ext4_end_buffer_io_sync;
> > +     submit_bh(REQ_OP_WRITE, write_flags, bh);
> > +     EXT4_SB(sb)->s_fc_bh = NULL;
> > +}
> > +
> > +/* Ext4 commit path routines */
> > +
> > +/* memzero and update CRC */
> > +static void *ext4_fc_memzero(struct super_block *sb, void *dst, int len,
> > +                             u32 *crc)
> > +{
> > +     void *ret;
> > +
> > +     ret = memset(dst, 0, len);
> > +     if (crc)
> > +             *crc = ext4_chksum(EXT4_SB(sb), *crc, dst, len);
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Allocate len bytes on a fast commit buffer.
> > + *
> > + * During the commit time this function is used to manage fast commit
> > + * block space. We don't split a fast commit log onto different
> > + * blocks. So this function makes sure that if there's not enough space
> > + * on the current block, the remaining space in the current block is
> > + * marked as unused by adding EXT4_FC_TAG_PAD tag. In that case,
> > + * new block is from jbd2 and CRC is updated to reflect the padding
> > + * we added.
> > + */
> > +static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
> > +{
> > +     struct ext4_fc_tl *tl;
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct buffer_head *bh;
> > +     int bsize = sbi->s_journal->j_blocksize;
> > +     int ret, off = sbi->s_fc_bytes % bsize;
> > +     int pad_len;
> > +
> > +     /*
> > +      * After allocating len, we should have space at least for a 0 byte
> > +      * padding.
> > +      */
> > +     if (len + sizeof(struct ext4_fc_tl) > bsize)
> > +             return NULL;
> > +
> > +     if (bsize - off - 1 > len + sizeof(struct ext4_fc_tl)) {
> > +             /*
> > +              * Only allocate from current buffer if we have enough space for
> > +              * this request AND we have space to add a zero byte padding.
> > +              */
> > +             if (!sbi->s_fc_bh) {
> > +                     ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
> > +                     if (ret)
> > +                             return NULL;
> > +                     sbi->s_fc_bh = bh;
> > +             }
> > +             sbi->s_fc_bytes += len;
> > +             return sbi->s_fc_bh->b_data + off;
> > +     }
> > +     /* Need to add PAD tag */
> > +     tl = (struct ext4_fc_tl *)(sbi->s_fc_bh->b_data + off);
> > +     tl->fc_tag = cpu_to_le16(EXT4_FC_TAG_PAD);
> > +     pad_len = bsize - off - 1 - sizeof(struct ext4_fc_tl);
> > +     tl->fc_len = cpu_to_le16(pad_len);
> > +     if (crc)
> > +             *crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
> > +     if (pad_len > 0)
> > +             ext4_fc_memzero(sb, tl + 1, pad_len, crc);
> > +     ext4_fc_submit_bh(sb);
> > +
> > +     ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
> > +     if (ret)
> > +             return NULL;
> > +     sbi->s_fc_bh = bh;
> > +     sbi->s_fc_bytes = (sbi->s_fc_bytes / bsize + 1) * bsize + len;
> > +     return sbi->s_fc_bh->b_data;
> > +}
> > +
> > +/* memcpy to fc reserved space and update CRC */
> > +static void *ext4_fc_memcpy(struct super_block *sb, void *dst, const void *src,
> > +                             int len, u32 *crc)
> > +{
> > +     if (crc)
> > +             *crc = ext4_chksum(EXT4_SB(sb), *crc, src, len);
> > +     return memcpy(dst, src, len);
> > +}
> > +
> > +/*
> > + * Complete a fast commit by writing tail tag.
> > + *
> > + * Writing tail tag marks the end of a fast commit. In order to guarantee
> > + * atomicity, after writing tail tag, even if there's space remaining
> > + * in the block, next commit shouldn't use it. That's why tail tag
> > + * has the length as that of the remaining space on the block.
> > + */
> > +static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
> > +{
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_fc_tl tl;
> > +     struct ext4_fc_tail tail;
> > +     int off, bsize = sbi->s_journal->j_blocksize;
> > +     u8 *dst;
> > +
> > +     /*
> > +      * ext4_fc_reserve_space takes care of allocating an extra block if
> > +      * there's no enough space on this block for accommodating this tail.
> > +      */
> > +     dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(tail), &crc);
> > +     if (!dst)
> > +             return -ENOSPC;
> > +
> > +     off = sbi->s_fc_bytes % bsize;
> > +
> > +     tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_TAIL);
> > +     tl.fc_len = cpu_to_le16(bsize - off - 1 + sizeof(struct ext4_fc_tail));
> > +     sbi->s_fc_bytes = round_up(sbi->s_fc_bytes, bsize);
> > +
> > +     ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), &crc);
> > +     dst += sizeof(tl);
> > +     tail.fc_tid = cpu_to_le32(sbi->s_journal->j_running_transaction->t_tid);
> > +     ext4_fc_memcpy(sb, dst, &tail.fc_tid, sizeof(tail.fc_tid), &crc);
> > +     dst += sizeof(tail.fc_tid);
> > +     tail.fc_crc = cpu_to_le32(crc);
> > +     ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
> > +
> > +     ext4_fc_submit_bh(sb);
> > +
> > +     return 0;
> > +}
>
> Is there a reason to pass CRC all around (so you have to have special
> functions like ext4_fc_memcpy(), ext4_fc_memzero(), ...) instead of just
> creating the whole block and then computing CRC in one go?
>
> In fact, as looking through the code, it seems to me it would be slightly
> nicer layer separation and interface if JBD2 provided functions for storage
> of data blobs and handled the details of space & block management,
> checksums, writeout, on recovery verification of correctness (so it would
> just provide back a stream of blobs for FS to replay). Just an idea for
> consideration, the current interface isn't too bad and we can change it
> later if we decide so.
I designed this keeping DAX mode in mind where we would benefit if we
don't use buffer heads and blocks. There is no block level CRC, but
CRC covers all the tags either from the start or from the last tail
tag (whichever comes first). This kind of CRC can span across
multipleblocks or we could have multiple CRCs in one block. Passing
CRC around helps us to compute CRC as we write tags to storage. In DAX
mode, this would allow fast commit commits to be smaller than block
size. DAX mode code isn't implemented completely yet, but I wanted to
make sure that the design of on-disk format is consistent and
efficient for both DAX and non-DAX modes.
>
> > +
> > +/*
> > + * Adds tag, length, value and updates CRC. Returns true if tlv was added.
> > + * Returns false if there's not enough space.
> > + */
> > + */
> > +static int ext4_fc_write_inode(struct inode *inode, u32 *crc)
> > +{
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +     int inode_len = EXT4_GOOD_OLD_INODE_SIZE;
> > +     int ret;
> > +     struct ext4_iloc iloc;
> > +     struct ext4_fc_inode fc_inode;
> > +     struct ext4_fc_tl tl;
> > +     u8 *dst;
> > +
> > +     ret = ext4_get_inode_loc(inode, &iloc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (EXT4_INODE_SIZE(inode->i_sb) > EXT4_GOOD_OLD_INODE_SIZE)
> > +             inode_len += ei->i_extra_isize;
> > +
> > +     fc_inode.fc_ino = cpu_to_le32(inode->i_ino);
> > +     tl.fc_tag = cpu_to_le16(EXT4_FC_TAG_INODE);
> > +     tl.fc_len = cpu_to_le16(inode_len + sizeof(fc_inode.fc_ino));
> > +
> > +     dst = ext4_fc_reserve_space(inode->i_sb,
> > +                     sizeof(tl) + inode_len + sizeof(fc_inode.fc_ino), crc);
> > +     if (!dst)
> > +             return -ECANCELED;
> > +
> > +     if (!ext4_fc_memcpy(inode->i_sb, dst, &tl, sizeof(tl), crc))
> > +             return -ECANCELED;
> > +     dst += sizeof(tl);
> > +     if (!ext4_fc_memcpy(inode->i_sb, dst, &fc_inode, sizeof(fc_inode), crc))
> > +             return -ECANCELED;
> > +     dst += sizeof(fc_inode);
> > +     if (!ext4_fc_memcpy(inode->i_sb, dst, (u8 *)ext4_raw_inode(&iloc),
> > +                                     inode_len, crc))
> > +             return -ECANCELED;
>
> Isn't this racy? What guarantees the inode state you record here is a valid
> one for the fastcommit? I mean this gets called at the time of fastcommit
> (i.e., fsync), so a fastcommit code must record changes to all other
> metadata that relate to the currently recorded inode state. But this isn't
> serialized in any way (AFAICT) with on-going inode changes so how can
> fastcommit code guarantee that? This is a similar case as a problem I
> describe below...
So we have ext4_fc_start_update(inode) / ext4_fc_stop_update(inode)
which is called by all the operations that happen on an inode. If the
inode in question is undergoing a fast commit, ext4_fc_start_update()
will block. So that ensures that inode won't be modified once fast
commit starts. So, in general, before doing any fast commit related
operation, we'll first put the inode in committing state, that's the
state of the inode which will be committed on-disk in fast commit.
>
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Writes updated data ranges for the inode in question. Updates CRC.
> > + * Returns 0 on success, error otherwise.
> > + */
> > +static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> > +{
> > +     ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +     struct ext4_map_blocks map;
> > +     struct ext4_fc_add_range fc_ext;
> > +     struct ext4_fc_del_range lrange;
> > +     struct ext4_extent *ex;
> > +     int ret;
> > +
> > +     mutex_lock(&ei->i_fc_lock);
> > +     if (ei->i_fc_lblk_len == 0) {
> > +             mutex_unlock(&ei->i_fc_lock);
> > +             return 0;
> > +     }
> > +     old_blk_size = ei->i_fc_lblk_start;
> > +     new_blk_size = ei->i_fc_lblk_start + ei->i_fc_lblk_len - 1;
> > +     ei->i_fc_lblk_len = 0;
> > +     mutex_unlock(&ei->i_fc_lock);
> > +
> > +     cur_lblk_off = old_blk_size;
> > +     jbd_debug(1, "%s: will try writing %d to %d for inode %ld\n",
> > +               __func__, cur_lblk_off, new_blk_size, inode->i_ino);
> > +
> > +     while (cur_lblk_off <= new_blk_size) {
> > +             map.m_lblk = cur_lblk_off;
> > +             map.m_len = new_blk_size - cur_lblk_off + 1;
> > +             ret = ext4_map_blocks(NULL, inode, &map, 0);
> > +             if (ret < 0)
> > +                     return -ECANCELED;
>
> So isn't this actually racy with a risk of stale data exposure? Consider a
> situation like:
>
> Task 1:                         Task 2:
> pwrite(file, buf, 8192, 0)
> punch(file, 0, 4096)
> fsync(file)
>   writeout range 4096-8192
>   fastcommit for inode range 0-8192
>                                 pwrite(file, buf, 4096, 0)
>     ext4_map_blocks(file)
>       - reports that block at offset 0 is mapped so that is recorded in
>         fastcommit record. But data for that is not written so after a
>         crash we'd expose stale data in that block.
>
> Am I missing something?
So the way this gets handled is before entering this function, the
inode enters COMMITTING state (in ext4_fc_submit_inode_data_all
function). Once in COMMITTING state, all the inodes on this inode get
paused. Also, the commit path waits until all the ongoing updates on
that inode are completed. Once they are completed, only then its data
buffers are flushed and this ext4_map_blocks is called. So Task-2 here
would have either completely finished or would wait until the end of
this inode's commit. I realize that I should probably add more
comments to make this more clearer in the code. But is handling it
this way sufficient or am I missing any more cases?
>
> > +
> > +             if (map.m_len == 0) {
> > +                     cur_lblk_off++;
> > +                     continue;
> > +             }
> > +
> > @@ -271,6 +272,7 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> >
> >  out:
> >       inode_unlock(inode);
> > +     ext4_fc_stop_update(inode);
> >       if (likely(ret > 0)) {
> >               iocb->ki_pos += ret;
> >               ret = generic_write_sync(iocb, ret);
> > @@ -534,7 +536,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >                       goto out;
> >               }
> >
> > +             ext4_fc_start_update(inode);
> >               ret = ext4_orphan_add(handle, inode);
> > +             ext4_fc_stop_update(inode);
>
> Why is here protected only the orphan addition? What about other changes
> happening to the inode during direct write?
This is the only change that is protected by handle in this function.
What I'm trying to do here (and in other places) is that anything that
happens between ext4_journal_start() and ext4_journal_stop() happens
atomically. The way to guarantee that is to ensure that the same block
is also surrounded by ext4_fc_start_update(inode) and
ext4_fc_stop_update(inode).

I also realized while looking at this comment is that we probably need
a new TLV for adding orphan inode to the list?
>
> >               if (ret) {
> >                       ext4_journal_stop(handle);
> >                       goto out;
> > @@ -656,8 +660,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  #endif
> >       if (iocb->ki_flags & IOCB_DIRECT)
> >               return ext4_dio_write_iter(iocb, from);
> > -
> > -     return ext4_buffered_write_iter(iocb, from);
> > +     else
> > +             return ext4_buffered_write_iter(iocb, from);
>
> Why this change?
Oops, this can be removed.
>
> >  }
> >
> >  #ifdef CONFIG_FS_DAX
> > @@ -757,6 +761,7 @@ static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
> >       if (!daxdev_mapping_supported(vma, dax_dev))
> >               return -EOPNOTSUPP;
> >
> > +     ext4_fc_start_update(inode);
> >       file_accessed(file);
>
> Uh, is this ext4_fc_start_update() for the file_accessed() call? What about
> all the other inode timestamp updates? I'd say handling in ext4_setattr()
> should be enough?
Makes sense. I'll remove this.
>
> Also I don't see anything tracking inode changes due to writes through mmap?
> How is that supposed to work?
Right, I have missed those. I see that mmap function
ext4_page_mkwrite() calls ext4_jbd2_inode_add_write that tells jbd2
what is the range that needs to be written for the inode in question.
I guess I can just update that function to update inode's FC range as
well?

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
