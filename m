Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48BE28C5A3
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Oct 2020 02:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgJMAZi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Oct 2020 20:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgJMAZi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Oct 2020 20:25:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36598C0613D0
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:25:37 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id t21so19021693eds.6
        for <linux-ext4@vger.kernel.org>; Mon, 12 Oct 2020 17:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAocQhnrf/gMDiXKA0QAdM6cdNOBoqA8HOcyL25nqKY=;
        b=hifdfmHmmoHqQEN2enI1fRn1JZDcS3APMWZqafxFXewwr6UQvpawDUfpH1ARU0vVvk
         s89nbuNjhrGIPe4NJXAdBXS9OzQVSrs2+Kdt/jk9RHuthEY3atmDiq7DUnIOzNhUQpgj
         tGieB9HSAKpure+0tiORmlS3byTVFYUKatHsuZbdGGNHBXtuALCjNzvu1SI8eLdLEr7a
         KsW2O9DzcZVaDEJdQtrWlb8mBa073Qg9VZFbCPDP154X4VuIrf5lvWJH7e6Qig+V/3EB
         j2IwID5ZvvhU9S4/x0QJK5QP+D6Re2vKnaEZrEyiltyCRs9Bh1/44oAAHnxagTwI74+i
         DdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAocQhnrf/gMDiXKA0QAdM6cdNOBoqA8HOcyL25nqKY=;
        b=TXGNIhmeq1KXiCjqJQ6rThk5UJ4r09qp7KO3uX9luFugN+lCaKiNJLZJ8node1UCev
         CXkjlLG1VNuJeaxb/2hgIDXKq6CLozeS+0oU/Dyy9Y8yMGJHHp3Alpv1PvjuP3c9ZkSN
         DkfjYT4GgKVVPKIcp3Ck6pIwaUHSpU9cA0MicH6bTXF1tJZkHx+u+QNVsYbBnOLwkGLE
         1jNzDb2aDfZpw12uzCT5wlw4fbjQZ1ATiK16Vav82LbwlhFeCiC2Be6qtI0IQJfWNg47
         XCEakozcu3TRal89I3TkK2aa4rqgKmafrlNMV1447VrGEEiZhklrTR6nua6WnhisKHmH
         ZjlA==
X-Gm-Message-State: AOAM5305I6HfgBPitSt4qMAZNMKotZboTqCivxc0uJPLK5KZoTQe3poI
        IePfU9aUPiCliVSqx9B5ODa7obNP6ohkMGb9hwo=
X-Google-Smtp-Source: ABdhPJyhj5b7R+ZZoLTK6QlYnn6q01aYvl26nL0LiKW6LodXuGcXjClIsfmU58YO6GbdaLAuzuPDhfXuz6qsuvhjFbQ=
X-Received: by 2002:a50:d94d:: with SMTP id u13mr16670214edj.365.1602548735290;
 Mon, 12 Oct 2020 17:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200919005451.3899779-1-harshadshirwadkar@gmail.com>
 <20200919005451.3899779-6-harshadshirwadkar@gmail.com> <c7d7d7b8-c7fe-4780-002b-8f68db988b19@linux.ibm.com>
In-Reply-To: <c7d7d7b8-c7fe-4780-002b-8f68db988b19@linux.ibm.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 12 Oct 2020 17:25:23 -0700
Message-ID: <CAD+ocbzTZQp00LmqWq7UFM-OutG-XnuB2eg57YqFOPhfCTruDA@mail.gmail.com>
Subject: Re: [PATCH v9 5/9] ext4: main fast-commit commit path
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Replies inlined, stripping down the original patch to make this more readable.

On Fri, Oct 9, 2020 at 10:04 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
>
>
> On 9/19/20 6:24 AM, Harshad Shirwadkar wrote:
> > This patch adds main fast commit commit path handlers. The overall
> > patch can be divided into two inter-related parts:
> >
> > (A) Metadata updates tracking
> >
> >      This part consists of helper functions to track changes that need
> >      to be committed during a commit operation. These updates are
> >      maintained by Ext4 in different in-memory queues. Following are
> >      the APIs and their short description that are implemented in this
> >      patch:
> >
> >      - ext4_fc_track_link/unlink/creat() - Track unlink. link and creat
> >        operations
> >      - ext4_fc_track_range() - Track changed logical block offsets
> >        inodes
> >      - ext4_fc_track_inode() - Track inodes
> >      - ext4_fc_mark_ineligible() - Mark file system fast commit
> >        ineligible()
> >      - ext4_fc_start_update() / ext4_fc_stop_update() /
> >        ext4_fc_start_ineligible() / ext4_fc_stop_ineligible() These
> >        functions are useful for co-ordinating inode updates with
> >        commits.
> >
> > (B) Main commit Path
> >
> >      This part consists of functions to convert updates tracked in
> >      in-memory data structures into on-disk commits. Function
> >      ext4_fc_commit() is the main entry point to commit path.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >   fs/ext4/acl.c               |    2 +
> >   fs/ext4/ext4.h              |   61 ++
> >   fs/ext4/extents.c           |   48 +-
> >   fs/ext4/fast_commit.c       | 1209 +++++++++++++++++++++++++++++++++++
> >   fs/ext4/fast_commit.h       |  111 ++++
> >   fs/ext4/file.c              |   10 +-
> >   fs/ext4/fsync.c             |    2 +-
> >   fs/ext4/inode.c             |   41 +-
> >   fs/ext4/ioctl.c             |   16 +-
> >   fs/ext4/namei.c             |   36 +-
> >   fs/ext4/super.c             |   31 +
> >   fs/ext4/xattr.c             |    3 +
> >   fs/jbd2/commit.c            |   42 ++
> >   fs/jbd2/journal.c           |  119 +++-
> >   include/linux/jbd2.h        |    6 +
> >   include/trace/events/ext4.h |  172 +++++
> >   16 files changed, 1882 insertions(+), 27 deletions(-)
> >
> > diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
> > index 76f634d185f1..68aaed48315f 100644
> > --- a/fs/ext4/acl.c
> > +++ b/fs/ext4/acl.c
> > @@ -242,6 +242,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> >       handle = ext4_journal_start(inode, EXT4_HT_XATTR, credits);
> >       if (IS_ERR(handle))
> >               return PTR_ERR(handle);
> > +     ext4_fc_start_update(inode);
> >
> >       if ((type == ACL_TYPE_ACCESS) && acl) {
> >               error = posix_acl_update_mode(inode, &mode, &acl);
> > @@ -259,6 +260,7 @@ ext4_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> >       }
> >   out_stop:
> >       ext4_journal_stop(handle);
> > +     ext4_fc_stop_update(inode);
> >       if (error == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> >               goto retry;
> >       return error;
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 9af3971dd12e..27d48d166e5d 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1022,6 +1022,27 @@ struct ext4_inode_info {
> >
> >       struct list_head i_orphan;      /* unlinked but open inodes */
> >
> > +     /* Fast commit related info */
> > +
> > +     struct list_head i_fc_list;     /*
> > +                                      * inodes that need fast commit
> > +                                      * protected by sbi->s_fc_lock.
> > +                                      */
> > +
> > +     /* Start of lblk range that needs to be committed in this fast commit */
> > +     ext4_lblk_t i_fc_lblk_start;
> > +
> > +     /* End of lblk range that needs to be committed in this fast commit */
> > +     ext4_lblk_t i_fc_lblk_len;
> > +
> > +     /* Number of ongoing updates on this inode */
> > +     atomic_t  i_fc_updates;
> > +
> > +     /* Fast commit wait queue for this inode */
> > +     wait_queue_head_t i_fc_wait;
> > +
> > +     struct mutex i_fc_lock;
>
> Although the code does explain the use of i_fc_lock.
> But a small comment here explaining what does this mutex lock protects
> will be helpful.
Sounds good, I'll add that.
>
> >       /*
> >        * i_disksize keeps track of what the inode size is ON DISK, not
> >        * in memory.  During truncate, i_size is set to the new size by
> > @@ -1142,6 +1163,10 @@ struct ext4_inode_info {
> >   #define     EXT4_VALID_FS                   0x0001  /* Unmounted cleanly */
> >   #define     EXT4_ERROR_FS                   0x0002  /* Errors detected */
> >   #define     EXT4_ORPHAN_FS                  0x0004  /* Orphans being recovered */
> > +#define EXT4_FC_INELIGIBLE           0x0008  /* Fast commit ineligible */
> > +#define EXT4_FC_COMMITTING           0x0010  /* File system underoing a fast
> > +                                              * commit.
> > +                                              */
> >
> >   /*
> >    * Misc. filesystem flags
> > @@ -1614,6 +1639,25 @@ struct ext4_sb_info {
> >       /* Record the errseq of the backing block device */
> >       errseq_t s_bdev_wb_err;
> >       spinlock_t s_bdev_wb_lock;
> > +
> > +     /* Ext4 fast commit stuff */
> > +     atomic_t s_fc_subtid;
> > +     atomic_t s_fc_ineligible_updates;
> > +     /*
> > +      * After commit starts, the main queue gets locked, and the further
> > +      * updates get added in the the staging queue
> > +      */
> > +#define FC_Q_MAIN    0
> > +#define FC_Q_STAGING 1
> > +     struct list_head s_fc_q[2];     /* Inodes staged for fast commit
> > +                                      * that have data changes in them.
> > +                                      */
> > +     struct list_head s_fc_dentry_q[2];      /* directory entry updates */
> > +     int s_fc_bytes;
>
> We don't need unsigned long for s_fc_bytes here is it?
Yes, we do. I'll fix this in V10.
>
>
> > +     spinlock_t s_fc_lock;
>
> some comment pls explaining what all this s_fc_lock protects?
Thanks, I'll add that.
>
> > +     struct buffer_head *s_fc_bh;
> > +     struct ext4_fc_stats s_fc_stats;
> > +     u64 s_fc_avg_commit_time;
> >   };
>
>
> Also I really like this i_fc_** & s_fc_** & ext4_fc_**() convention :)
Thanks! :)
>
>
> >
> >   static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> > @@ -1724,6 +1768,7 @@ enum {
> >       EXT4_STATE_EXT_PRECACHED,       /* extents have been precached */
> >       EXT4_STATE_LUSTRE_EA_INODE,     /* Lustre-style ea_inode */
> >       EXT4_STATE_VERITY_IN_PROGRESS,  /* building fs-verity Merkle tree */
> > +     EXT4_STATE_FC_COMMITTING,       /* Fast commit ongoing */
> >   };
> >
> >   #define EXT4_INODE_BIT_FNS(name, field, offset)                             \
> > @@ -2683,6 +2728,22 @@ extern void ext4_end_bitmap_read(struct buffer_head *bh, int uptodate);
> >   /* fast_commit.c */
> >
> >   void ext4_fc_init(struct super_block *sb, journal_t *journal);
> > +void ext4_fc_init_inode(struct inode *inode);
> > +void ext4_fc_track_range(struct inode *inode, ext4_lblk_t start,
> > +                      ext4_lblk_t end);
> > +void ext4_fc_track_unlink(struct inode *inode, struct dentry *dentry);
> > +void ext4_fc_track_link(struct inode *inode, struct dentry *dentry);
> > +void ext4_fc_track_create(struct inode *inode, struct dentry *dentry);
> > +void ext4_fc_track_inode(struct inode *inode);
> > +void ext4_fc_mark_ineligible(struct super_block *sb, int reason);
> > +void ext4_fc_start_ineligible(struct super_block *sb, int reason);
> > +void ext4_fc_stop_ineligible(struct super_block *sb);
> > +void ext4_fc_start_update(struct inode *inode);
> > +void ext4_fc_stop_update(struct inode *inode);
> > +void ext4_fc_del(struct inode *inode);
> > +int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
> > +int __init ext4_fc_init_dentry_cache(void);
> > +
> >   /* mballoc.c */
> >   extern const struct seq_operations ext4_mb_seq_groups_ops;
> >   extern long ext4_mb_stats;
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index a0481582187a..8de236fedade 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -3723,6 +3723,7 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
> >       err = ext4_ext_dirty(handle, inode, path + path->p_depth);
> >   out:
> >       ext4_ext_show_leaf(inode, path);
> > +     ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
> >       return err;
> >   }
> >
> > @@ -3794,6 +3795,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
> >       if (*allocated > map->m_len)
> >               *allocated = map->m_len;
> >       map->m_len = *allocated;
> > +     ext4_fc_track_range(inode, ee_block, ee_block + ee_len - 1);
> >       return 0;
> >   }
> >
> > @@ -4327,7 +4329,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
> >       map->m_len = ar.len;
> >       allocated = map->m_len;
> >       ext4_ext_show_leaf(inode, path);
> > -
> > +     ext4_fc_track_range(inode, map->m_lblk, map->m_len);
>
> Shouldn't the last argument be map->m_lblk + map->m_len - 1, no?
Thanks for catching this! I'll fix this in V10.
>
>
>
> > + * (B) File specific data range updates:
> > + *
> > + * - EXT4_FC_TAG_ADD_RANGE   - records addition of new blocks to an inode
> > + * - EXT4_FC_TAG_DEL_RANGE   - recordd deletion of blocks from an inode
>
> s/recordd/records
Ack
>
>
> > + *
> > + * (C) Inode metadata (mtime / ctime etc):
> > + *
> > + * - EXT4_FC_TAG_INODE_FULL  - record the inode that should be replayed as is
> > + *                             during recovery. This tag is useful for
> > + *                             setting up a new inode. This tag is necessary
> > + *                             for CREAT tag.
> > + * - EXT4_FC_TAG_INODE_PARTIAL       - record the inode that should only partially be
> > + *                             be replayed during recovery. This tag is
> > + *                             useful when the same inode has had updates
> > + *                             recorded as ADD_RANGE or DEL_RANGE tags.
>
> So we keep INODE_FULL to only track the inode metdata.
> and PARTIAL is to track for any extent add/del range operations right?
> Is there anything else that I am missing?
The main difference between INODE_FULL and PARTIAL is whether or not
i_block[] fields in the inode should be overwritten or not. If we are
dealing with inode that has inline data, the fast commit recovery
operation needs to overwrite the old data with new data. So the
following flow of operations will result in fast commit with
"INODE_FULL" tag:

- New Inode A created with inline data "old"
- Full commit operation (now A is persisted on disk)
- Inode A's contents were modified to "new"
- fsync() (in this case Inode A will be recorded on disk with "INODE_FULL" tag

In case of add range / del range however, since we modify the inode's
extent tree and the resulting inode->i_block[] maybe different than
before crash. That's why we also need a partial tag.
>
>
> > +/*
> > + * Inform Ext4's fast about start of an inode update
> > + *
> > + * This function is called by the high level call VFS callbacks before
> > + * performing any inode update. This function blocks if there's an ongoing
> > + * fast commit on the inode in question.
> > + */
> > +void ext4_fc_start_update(struct inode *inode)
> > +{
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> > +             return;
> > +
> > +restart:
> > +     spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +     if (list_empty(&EXT4_I(inode)->i_fc_list))
>
> We can use ei->i_fc_list directly.
Ack
>
>
>
> > +             goto out;
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
> > +             prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +             spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +             schedule();
> > +             finish_wait(wq, &wait.wq_entry);
> > +             goto restart;
> > +     }
> > +out:
> > +     atomic_inc(&ei->i_fc_updates);
> > +     spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +}
> > +
> > +/*
> > + * Stop inode update and wake up waiting fast commits if any.
> > + */
> > +void ext4_fc_stop_update(struct inode *inode)
> > +{
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +     if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> > +             return;
> > +
> > +     if (atomic_dec_and_test(&ei->i_fc_updates))
> > +             wake_up_all(&ei->i_fc_wait);
> > +}
> > +
> > +/*
> > + * Remove inode from fast commit list. If the inode is being committed
> > + * we wait until inode commit is done.
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
>
> Redundant check, so let's remove this.
Ack
>
>
>
> > +
> > +/* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
> > +static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> > +{
> > +     struct ext4_fc_dentry_update *node;
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +     struct __track_dentry_update_args *dentry_update =
> > +             (struct __track_dentry_update_args *)arg;
> > +     struct dentry *dentry = dentry_update->dentry;
> > +     struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > +
> > +     mutex_unlock(&ei->i_fc_lock);
> > +     node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
> > +     if (!node) {
> > +             ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM);
> > +             mutex_lock(&ei->i_fc_lock);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     node->fcd_op = dentry_update->op;
> > +     node->fcd_parent = dentry->d_parent->d_inode->i_ino;
> > +     node->fcd_ino = inode->i_ino;
> > +     if (dentry->d_name.len > DNAME_INLINE_LEN) {
> > +             node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_KERNEL);
>
>
> Shouldn't this be GFP_NOFS too?
Ack, will fix this.
>
>
>
> > +static void ext4_fc_submit_bh(struct super_block *sb)
> > +{
> > +     int write_flags = REQ_SYNC;
> > +     struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
> > +
> > +     if (test_opt(sb, BARRIER))
> > +             write_flags |= REQ_FUA | REQ_PREFLUSH;
> > +     lock_buffer(bh);
> > +     clear_buffer_dirty(bh);
> > +     set_buffer_uptodate(bh);
>
> Please don't mind me asking this.
> But shouldn't we clear the buffer dirty after the IO is submitted
> and update will be set once the IO is completed?
> Maybe I am missing something here.
Thanks for asking this. What you say makes sense to me, but what I did
here is basically copied from fs/jbd2/commit.c. Is there a reason why
we clear dirty flag and set uptodate in jbd2/commit.c before
submitting bh?
>
>
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
>
> why do we need +1 here?
Since we just added padding, we want to skip the remaining bytes in
the current bh and we want s_fc_bytes to go len bytes into the next
block. The value of ((sbi->s_fc_bytes / bsize + 1) * bsize) is
basically rounding up of division (sbi->s_fc_bytes / bsize).
>
>
>
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
> > +
> > +/*
> > + * Adds tag, length, value and updates CRC. Returns true if tlv was added.
> > + * Returns false if there's not enough space.
> > + */
> > +static bool ext4_fc_add_tlv(struct super_block *sb, u16 tag, u16 len, u8 *val,
> > +                        u32 *crc)
> > +{
> > +     struct ext4_fc_tl tl;
> > +     u8 *dst;
> > +
> > +     dst = ext4_fc_reserve_space(sb, sizeof(tl) + len, crc);
> > +     if (!dst)
> > +             return false;
> > +
> > +     tl.fc_tag = cpu_to_le16(tag);
> > +     tl.fc_len = cpu_to_le16(len);
> > +
> > +     ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
> > +     ext4_fc_memcpy(sb, dst + sizeof(tl), val, len, crc);
> > +
> > +     return true;
> > +}
> > +
> > +/* Same as above, but adds dentry tlv. */
> > +static  bool ext4_fc_add_dentry_tlv(struct super_block *sb, u16 tag,
> > +                                     int parent_ino, int ino, int dlen,
> > +                                     const unsigned char *dname,
> > +                                     u32 *crc)
> > +{
> > +     struct ext4_fc_dentry_info fcd;
> > +     struct ext4_fc_tl tl;
> > +     u8 *dst = ext4_fc_reserve_space(sb, sizeof(tl) + sizeof(fcd) + dlen,
> > +                                     crc);
> > +
> > +     if (!dst)
> > +             return false;
> > +
> > +     fcd.fc_parent_ino = cpu_to_le32(parent_ino);
> > +     fcd.fc_ino = cpu_to_le32(ino);
> > +     tl.fc_tag = cpu_to_le16(tag);
> > +     tl.fc_len = cpu_to_le16(sizeof(fcd) + dlen);
> > +     ext4_fc_memcpy(sb, dst, &tl, sizeof(tl), crc);
> > +     dst += sizeof(tl);
> > +     ext4_fc_memcpy(sb, dst, &fcd, sizeof(fcd), crc);
> > +     dst += sizeof(fcd);
> > +     ext4_fc_memcpy(sb, dst, dname, dlen, crc);
> > +     dst += dlen;
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * Writes inode in the fast commit space under TLV with tag @tag.
> > + * Returns 0 on success, error on failure.
> > + */
> > +static int ext4_fc_write_inode(struct inode *inode, u32 *crc, int tag)
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
> > +     tl.fc_tag = cpu_to_le16(tag);
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
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Writes updated data ranges for the inode in question. Updates CRC.
> > + * Returns 0 on success, error otherwise.
> > + */
> > +static int ext4_fc_write_data(struct inode *inode, u32 *crc)
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
> > +
> > +             if (map.m_len == 0) {
> > +                     cur_lblk_off++;
> > +                     continue;
> > +             }
> > +
> > +             if (ret == 0) {
> > +                     lrange.fc_ino = cpu_to_le32(inode->i_ino);
> > +                     lrange.fc_lblk = cpu_to_le32(map.m_lblk);
> > +                     lrange.fc_len = cpu_to_le32(map.m_len);
> > +                     if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_DEL_RANGE,
> > +                                         sizeof(lrange), (u8 *)&lrange, crc))
> > +                             return -ENOSPC;
> > +             } else {
> > +                     fc_ext.fc_ino = cpu_to_le32(inode->i_ino);
> > +                     ex = (struct ext4_extent *)&fc_ext.fc_ex;
> > +                     ex->ee_block = cpu_to_le32(map.m_lblk);
> > +                     ex->ee_len = cpu_to_le32(map.m_len);
> > +                     ext4_ext_store_pblock(ex, map.m_pblk);
> > +                     if (map.m_flags & EXT4_MAP_UNWRITTEN)
> > +                             ext4_ext_mark_unwritten(ex);
> > +                     else
> > +                             ext4_ext_mark_initialized(ex);
> > +                     if (!ext4_fc_add_tlv(inode->i_sb, EXT4_FC_TAG_ADD_RANGE,
> > +                                         sizeof(fc_ext), (u8 *)&fc_ext, crc))
> > +                             return -ENOSPC;
> > +             }
> > +
> > +             cur_lblk_off += map.m_len;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Commit data inode. If tag == EXT4_FC_TAG_INODE_PARTIAL, we write the
> > + * updated ranges for that inode before committing the inode itself.
> > + * This ensures that the during the replay inode->i_block[] is properly
> > + * initiated before the partial replay of the inode.
> > + */
> > +static int ext4_fc_commit_inode(journal_t *journal, struct inode *inode,
> > +                             u32 *crc, int tag)
> > +{
> > +     int ret;
> > +     int commit_full_inode =
> > +             tag == EXT4_FC_TAG_INODE_FULL || ext4_has_inline_data(inode);
> > +
> > +     if (commit_full_inode) {
> > +             ret = ext4_fc_write_inode(inode, crc, tag);
> > +             if (ret < 0)
> > +                     return ret;
> > +     }
> > +
> > +     ret = ext4_fc_write_data(inode, crc);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (!commit_full_inode)
> > +             ret = ext4_fc_write_inode(inode, crc, tag);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Submit data for all the fast commit inodes */
> > +static int ext4_fc_submit_inode_data_all(journal_t *journal)
> > +{
> > +     struct super_block *sb = (struct super_block *)(journal->j_private);
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_inode_info *ei;
> > +     struct list_head *pos;
> > +     int ret = 0;
> > +
> > +     spin_lock(&sbi->s_fc_lock);
> > +     sbi->s_mount_state |= EXT4_FC_COMMITTING;
> > +     list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
> > +             ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> > +             ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
> > +             while (atomic_read(&ei->i_fc_updates)) {
> > +                     DEFINE_WAIT(wait);
> > +
> > +                     prepare_to_wait(&ei->i_fc_wait, &wait,
> > +                                             TASK_UNINTERRUPTIBLE);
> > +                     if (atomic_read(&ei->i_fc_updates)) {
> > +                             spin_unlock(&sbi->s_fc_lock);
> > +                             schedule();
> > +                             spin_lock(&sbi->s_fc_lock);
> > +                     }
> > +                     finish_wait(&ei->i_fc_wait, &wait);
> > +             }
> > +             spin_unlock(&sbi->s_fc_lock);
> > +             ret = jbd2_submit_inode_data(journal, ei->jinode);
> > +             if (ret)
> > +                     return ret;
> > +             spin_lock(&sbi->s_fc_lock);
> > +     }
> > +     spin_unlock(&sbi->s_fc_lock);
> > +
> > +     return ret;
> > +}
> > +
> > +/* Wait for completion of data for all the fast commit inodes */
> > +static int ext4_fc_wait_inode_data_all(journal_t *journal)
> > +{
> > +     struct super_block *sb = (struct super_block *)(journal->j_private);
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_inode_info *pos, *n;
> > +     int ret = 0;
> > +
> > +     spin_lock(&sbi->s_fc_lock);
> > +     list_for_each_entry_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> > +             if (!ext4_test_inode_state(&pos->vfs_inode,
> > +                                        EXT4_STATE_FC_COMMITTING))
> > +                     continue;
> > +             spin_unlock(&sbi->s_fc_lock);
> > +
> > +             ret = jbd2_wait_inode_data(journal, pos->jinode);
> > +             if (ret)
> > +                     return ret;
> > +             spin_lock(&sbi->s_fc_lock);
> > +     }
> > +     spin_unlock(&sbi->s_fc_lock);
> > +
> > +     return 0;
> > +}
> > +
> > +/* Commit all the directory entry updates */
> > +static int ext4_fc_commit_dentry_updates(journal_t *journal, u32 *crc)
> > +{
> > +     struct super_block *sb = (struct super_block *)(journal->j_private);
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_fc_dentry_update *fc_dentry;
> > +     struct inode *inode;
> > +     struct list_head *pos, *n, *fcd_pos, *fcd_n;
> > +     struct ext4_inode_info *ei;
> > +     int ret;
> > +
> > +     spin_lock(&sbi->s_fc_lock);
> > +     if (list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {
> > +             spin_unlock(&sbi->s_fc_lock);
> > +             return 0;
> > +     }
> > +     list_for_each_safe(fcd_pos, fcd_n, &sbi->s_fc_dentry_q[FC_Q_MAIN]) {
> > +             fc_dentry = list_entry(fcd_pos, struct ext4_fc_dentry_update,
> > +                                     fcd_list);
> > +             if (fc_dentry->fcd_op != EXT4_FC_TAG_CREAT) {
> > +                     spin_unlock(&sbi->s_fc_lock);
> > +                     if (!ext4_fc_add_dentry_tlv(
> > +                             sb, fc_dentry->fcd_op,
> > +                             fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> > +                             fc_dentry->fcd_name.len,
> > +                             fc_dentry->fcd_name.name, crc)) {
> > +                             return -ENOSPC;
> > +                     }
> > +                     spin_lock(&sbi->s_fc_lock);
> > +                     continue;
> > +             }
> > +
> > +             inode = NULL;
> > +             list_for_each_safe(pos, n, &sbi->s_fc_q[FC_Q_MAIN]) {
> > +                     ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
> > +                     if (ei->vfs_inode.i_ino == fc_dentry->fcd_ino) {
> > +                             inode = &ei->vfs_inode;
> > +                             break;
> > +                     }
> > +             }
> > +             /*
> > +              * If we don't find inode in our list, then it was deleted,
> > +              * in which case, we don't need to record it's create tag.
> > +              */
> > +             if (!inode)
> > +                     continue;
> > +             spin_unlock(&sbi->s_fc_lock);
> > +
> > +             /*
> > +              * We first write the inode and then the create dirent. This
> > +              * allows the recovery code to create an unnamed inode first
> > +              * and then link it to a directory entry. This allows us
> > +              * to use namei.c routines almost as is and simplifies
> > +              * the recovery code.
> > +              */
> > +             ret = ext4_fc_commit_inode(journal, inode, crc,
> > +                                             EXT4_FC_TAG_INODE_FULL);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             if (!ext4_fc_add_dentry_tlv(
> > +                     sb, fc_dentry->fcd_op,
> > +                     fc_dentry->fcd_parent, fc_dentry->fcd_ino,
> > +                     fc_dentry->fcd_name.len,
> > +                     fc_dentry->fcd_name.name, crc))
> > +                     return -ENOSPC;
> > +
> > +             spin_lock(&sbi->s_fc_lock);
> > +     }
> > +     spin_unlock(&sbi->s_fc_lock);
> > +     return 0;
> > +}
> > +
> > +static int ext4_fc_perform_commit(journal_t *journal)
> > +{
> > +     struct super_block *sb = (struct super_block *)(journal->j_private);
> > +     struct ext4_sb_info *sbi = EXT4_SB(sb);
> > +     struct ext4_inode_info *iter;
> > +     struct ext4_fc_head head;
> > +     struct list_head *pos;
> > +     struct inode *inode;
> > +     struct blk_plug plug;
> > +     int ret = 0;
> > +     u32 crc = 0;
> > +
> > +     ret = ext4_fc_submit_inode_data_all(journal);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = ext4_fc_wait_inode_data_all(journal);
> > +     if (ret)
> > +             return ret;
> > +
> > +     blk_start_plug(&plug);
> > +     if (sbi->s_fc_bytes == 0) {
> > +             /*
> > +              * Add a head tag only if this is the first fast commit
> > +              * in this TID.
> > +              */
> > +             head.fc_features = cpu_to_le32(EXT4_FC_SUPPORTED_FEATURES);
> > +             head.fc_tid = cpu_to_le32(
> > +                     sbi->s_journal->j_running_transaction->t_tid);
> > +             if (!ext4_fc_add_tlv(sb, EXT4_FC_TAG_HEAD, sizeof(head),
> > +                     (u8 *)&head, &crc))
> > +                     goto out;
> > +     }
> > +
> > +     spin_lock(&sbi->s_fc_lock);
> > +     if (!list_empty(&sbi->s_fc_dentry_q[FC_Q_MAIN])) {
>
> This looks redundant check here. Since we anyway check for list
> emptiness inside ext4_fc_commit_dentry_updates func()
> with s_fc_lock held.
> That should simplify this code block. I guess then we only need to call
> ext4_fc_commit_dentry_updates().
>
> > +
> > +struct ext4_fc_stats {
> > +     int fc_ineligible_reason_count[EXT4_FC_REASON_MAX];
> > +     int fc_num_commits;
> > +     int fc_ineligible_commits;
> > +     int fc_numblks; > +};
>
> I guess, all above counters should be unsigned int or unsigned long right?
Ack, thanks will fix this.
>
>
>
>
> > +
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 153a9fbe1dd0..563243f3b682 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -2611,7 +2611,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> >                      bool excl)
> >   {
> >       handle_t *handle;
> > -     struct inode *inode;
> > +     struct inode *inode, *inode_save;
> >       int err, credits, retries = 0;
> >
> >       err = dquot_initialize(dir);
> > @@ -2629,7 +2629,11 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> >               inode->i_op = &ext4_file_inode_operations;
> >               inode->i_fop = &ext4_file_operations;
> >               ext4_set_aops(inode);
> > +             inode_save = inode;
> > +             ihold(inode_save);
> >               err = ext4_add_nondir(handle, dentry, &inode);
> > +             ext4_fc_track_create(inode_save, dentry);
>
> Shouldn't we check for err before calling ext4_fc_track_create?
Makes sense, will fix this.
>
>
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index ba35ecb18616..dadd9994e74b 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -202,6 +202,47 @@ static int journal_submit_inode_data_buffers(struct address_space *mapping,
> >       return ret;
> >   }
> >
> > +/* Send all the data buffers related to an inode */
> > +int jbd2_submit_inode_data(journal_t *journal, struct jbd2_inode *jinode)
> > +{
> > +     struct address_space *mapping;
> > +     loff_t dirty_start;
> > +     loff_t dirty_end;
> > +     int ret;
> > +
> > +     if (!jinode)
> > +             return 0;
> > +
> > +     dirty_start = jinode->i_dirty_start;
> > +     dirty_end = jinode->i_dirty_end;
> > +
> > +     if (!(jinode->i_flags & JI_WRITE_DATA))
> > +             return 0;
>
> This can be clubbed with above if logic to check if !jinode
Ack
>
> > +
> > +     dirty_start = jinode->i_dirty_start;
> > +     dirty_end = jinode->i_dirty_end;
>
> redundant check
Ack
>
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
> > +     if (journal->j_fc_off + journal->j_first_fc < journal->j_last_fc) {
> > +             fc_off = journal->j_fc_off;
> > +             blocknr = journal->j_first_fc + fc_off;
> > +             journal->j_fc_off++;
>
>
> Not sure if we need to should roll back j_fc_off in case of errors from
> this func.
We can do that. Given that this function is called serially (at least
today), we can reset j_fc_off. Will add that in V10.

Thanks,
Harshad
>
> -ritesh
>
>
