Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D2C2E67
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfJAHue (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:50:34 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36589 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbfJAHud (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:50:33 -0400
Received: by mail-oi1-f195.google.com with SMTP id k20so13587737oih.3
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6OucmKR5TvSwQKe6SzD5iJe5lWs8Hy7Vd4C7UvIC8Q=;
        b=teK38wCMTEe2DhUOsE8EjhzmEVUYU3mPbnQj4Zi1U8gBM5/uHrT372HyyGKwSMyv+P
         BI0XSNRsYU1/1jZ7qFIE3adgRnDQhy/vpmMqtMAn+OJozfUojtfIxDPql6LL89+DqQmv
         iGNXRldPUE9y3z2mwKCmgwr9kKeOXHXG+FnrTf8Lp9w32dY+RrQ0V4MK0iz9ab862r0J
         faWEhKIGyjy8X51Iu8xWdBS2bupWk8O/SWELw5Dg7VSlUYwxt2ShJDO4FJ8CdDdZQH2S
         EhuWcRg+552Qyd2PjIiJ92hfdACjvInf+qjuZlzSXNYClNDjPaH5kXnv3Coe7/w3aHSx
         eQtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6OucmKR5TvSwQKe6SzD5iJe5lWs8Hy7Vd4C7UvIC8Q=;
        b=W+/gVgaCoFTJsLVOTMzVohSpFfGsYrkfsFSgqWn0TMD/QQDKtVyaucfZmcRtAv6uyF
         /h0ym/phxSD01cKlEBPorvX5EV8EyT+SY+Xj2uipn1oJa0PG8UbFB17zaEIXAB/1zmAO
         fYwuC9DDkIU8Gc0vIStGViVYNafD1g5n5ZJVMQMtgZYTDP+d9ZUTAmrugCOAH6q++m7l
         0zWbg3YjFOM6hZpU1L203tUvo/tIEi2H+DywpYGJFyVvSh56qPGEjB9sprM60fIHcpKM
         Q13JcSreeEqDZB0XPjTpPIVkNSrKELk7Rny3DS8jaR7rLhfvfMfA5lUZyUSrrEWz+dsk
         gktQ==
X-Gm-Message-State: APjAAAU9KP+T44zPr/b9ki6xqD2cswsYW4QfwePJ0+BnR0LPh2UpRzKC
        A+Uv/1p8wA3dMq5BypJ8R8tO2wRzXagp/wulWUAwR3ji
X-Google-Smtp-Source: APXvYqwxHmyQAuYWdmX7FdATCbOqHw4MkcbT4B/eeCqDBJtO21y9EYX0DNrdXlS9WoOoxBcFc6ve4IIeU+PACA1QB/c=
X-Received: by 2002:aca:31c7:: with SMTP id x190mr2735414oix.17.1569916231906;
 Tue, 01 Oct 2019 00:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-8-harshadshirwadkar@gmail.com> <10EB162C-FDCF-476B-9AC0-923C2230DEA7@dilger.ca>
In-Reply-To: <10EB162C-FDCF-476B-9AC0-923C2230DEA7@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 1 Oct 2019 00:50:21 -0700
Message-ID: <CAD+ocbxML=Zj4SxgFONAFtx9apNkEzfhiTs7p6Qf+-x6kUxf4w@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] ext4: add fields that are needed to track
 changed files
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, handled in V3.

On Fri, Aug 9, 2019 at 2:23 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > Ext4's fast commit feature tracks changed files and maintains them in
> > a queue. We also remember for each file the logical block range that
> > needs to be committed. This patch adds these fields to ext4_inode_info
> > and ext4_sb_info and also adds initialization calls.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > ---
> >
> > Changelog:
> >
> > V2: Converted s_fc_lock from mutex to spinlock to improve parallelism
> >    performance.
> > ---
> > fs/ext4/ext4.h      | 34 ++++++++++++++++++++++++++++++++++
> > fs/ext4/ext4_jbd2.c | 13 +++++++++++++
> > fs/ext4/ext4_jbd2.h |  2 ++
> > fs/ext4/inode.c     |  1 +
> > fs/ext4/super.c     |  7 +++++++
> > 5 files changed, 57 insertions(+)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index becbda38b7db..0d15d4539dda 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -921,6 +921,27 @@ enum {
> >       I_DATA_SEM_QUOTA,
> > };
> >
> > +/*
> > + * Ext4 fast commit inode specific information
> > + */
> > +struct ext4_fast_commit_inode_info {
> > +     /* TID / SUB-TID when old_i_size and i_size were recorded */
> > +     tid_t fc_tid;
> > +     tid_t fc_subtid;
> > +
> > +     /*
> > +      * Start of logical block range that needs to be committed in this fast
> > +      * commit
> > +      */
> > +     loff_t fc_lblk_start;
> > +
> > +     /*
> > +      * End of logical block range that needs to be committed in this fast
> > +      * commit
> > +      */
> > +     loff_t fc_lblk_end;
>
> Since these are logical block numbers within the journal, they certainly
> don't need to be 64-bit values.  loff_t is for byte offsets, this should
> use ext4_lblk_t, which will also reduce the size of the struct by 8 bytes.
>
> > +};
> > +
> >
> > /*
> >  * fourth extended file system inode data in memory
> > @@ -955,6 +976,9 @@ struct ext4_inode_info {
> >
> >       struct list_head i_orphan;      /* unlinked but open inodes */
> >
> > +     struct list_head i_fc_list;     /* inodes that need fast commit */
>
> This comment should document what lock is protecting this list, along
> with the other fields.
>
> > +     struct ext4_fast_commit_inode_info i_fc;
>
> Since this increases the size of the inode, does it affect the number of
> inodes that can fit into one page of ext4_inode_cachep?
>
> >       /*
> >        * i_disksize keeps track of what the inode size is ON DISK, not
> >        * in memory.  During truncate, i_size is set to the new size by
> > @@ -1529,6 +1553,16 @@ struct ext4_sb_info {
> >       /* Barrier between changing inodes' journal flags and writepages ops. */
> >       struct percpu_rw_semaphore s_journal_flag_rwsem;
> >       struct dax_device *s_daxdev;
> > +
> > +     /* Ext4 fast commit stuff */
> > +     bool fc_replay;                 /* Fast commit replay in progress */
> > +     struct list_head s_fc_q;        /* Inodes that need fast commit. */
>
> This comment should document what lock is protecting this list, along
> with the other fields.
>
> > +     __u32 s_fc_q_cnt;               /* Number of inodes in the fc queue */
> > +     bool s_fc_eligible;             /*
> > +                                      * Are changes after the last commit
> > +                                      * eligible for fast commit?
> > +                                      */
>
> It is slightly more space efficient to put the bool values together
> rather than interleaving them between 64-bit values.
>
> > +     spinlock_t s_fc_lock;
> > };
> >
> > static inline struct ext4_sb_info *EXT4_SB(struct super_block *sb)
> > diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> > index 7c70b08d104c..75b6db808837 100644
> > --- a/fs/ext4/ext4_jbd2.c
> > +++ b/fs/ext4/ext4_jbd2.c
> > @@ -330,3 +330,16 @@ int __ext4_handle_dirty_super(const char *where, unsigned int line,
> >               mark_buffer_dirty(bh);
> >       return err;
> > }
> > +
> > +void ext4_init_inode_fc_info(struct inode *inode)
> > +{
> > +     handle_t *handle = ext4_journal_current_handle();
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +
> > +     memset(&ei->i_fc, 0, sizeof(ei->i_fc));
> > +     if (ext4_handle_valid(handle)) {
> > +             ei->i_fc.fc_tid = handle->h_transaction->t_tid;
> > +             ei->i_fc.fc_subtid = handle->h_transaction->t_journal->j_subtid;
> > +     }
> > +     INIT_LIST_HEAD(&ei->i_fc_list);
> > +}
> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > index ef8fcf7d0d3b..2305c1acd415 100644
> > --- a/fs/ext4/ext4_jbd2.h
> > +++ b/fs/ext4/ext4_jbd2.h
> > @@ -459,4 +459,6 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
> >       return 1;
> > }
> >
> > +void ext4_init_inode_fc_info(struct inode *inode);
> > +
> > #endif        /* _EXT4_JBD2_H */
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 420fe3deed39..f230a888eddd 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -4996,6 +4996,7 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
> >       for (block = 0; block < EXT4_N_BLOCKS; block++)
> >               ei->i_data[block] = raw_inode->i_block[block];
> >       INIT_LIST_HEAD(&ei->i_orphan);
> > +     ext4_init_inode_fc_info(&ei->vfs_inode);
> >
> >       /*
> >        * Set transaction id's of transactions that have to be committed
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 6bab59ae81f7..0b833e9b61c1 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1100,6 +1100,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
> >       ei->i_datasync_tid = 0;
> >       atomic_set(&ei->i_unwritten, 0);
> >       INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
> > +     ext4_init_inode_fc_info(&ei->vfs_inode);
> >       return &ei->vfs_inode;
> > }
> >
> > @@ -1139,6 +1140,7 @@ static void init_once(void *foo)
> >       init_rwsem(&ei->i_data_sem);
> >       init_rwsem(&ei->i_mmap_sem);
> >       inode_init_once(&ei->vfs_inode);
> > +     ext4_init_inode_fc_info(&ei->vfs_inode);
> > }
> >
> > static int __init init_inodecache(void)
> > @@ -4301,6 +4303,11 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
> >       INIT_LIST_HEAD(&sbi->s_orphan); /* unlinked but open files */
> >       mutex_init(&sbi->s_orphan_lock);
> >
> > +     INIT_LIST_HEAD(&sbi->s_fc_q);
> > +     sbi->s_fc_q_cnt = 0;
> > +     sbi->s_fc_eligible = true;
> > +     spin_lock_init(&sbi->s_fc_lock);
> > +
> >       sb->s_root = NULL;
> >
> >       needs_recovery = (es->s_last_orphan != 0 ||
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog
> >
>
>
> Cheers, Andreas
>
>
>
>
>
