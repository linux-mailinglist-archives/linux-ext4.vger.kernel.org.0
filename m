Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAAB82A7519
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Nov 2020 02:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgKEByA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Nov 2020 20:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKEByA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Nov 2020 20:54:00 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E3C0613CF
        for <linux-ext4@vger.kernel.org>; Wed,  4 Nov 2020 17:53:58 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id gn41so293502ejc.4
        for <linux-ext4@vger.kernel.org>; Wed, 04 Nov 2020 17:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXffRTQkeKscbddjBgK9BhilOU6iS/TrKvpQ7cD3hfw=;
        b=XHhVN08IaIHHPZh5CBualM60oGqv/pAAxT/N7h+9anUlpK1tZosErYH1sX5A7VBo2P
         N42EnzqY8nD7jB9wz/cZEc5lrZFdCCXSub35ERByU0gCEgw9VGJYaCx3KUBioC2cdN2y
         JjRbwDpwaYC3Gpzx8sVFv/+9oDLwSKB1kMkJDgLzNquXj97AqBDxMz8F6s4edEiHuCQi
         CgYINJIQrp1Ful/YZdQ4L0dbIwjLKS9G+4901uQhbCQw+fF9xJ1Wxquf4tT86hJJykTI
         j2QRSpu4ckAGO0DoqpgjbI8hgLgYG8Rpw8shMyvGUj4bVwTnfS+/G9PQ/VtL72/dlUcB
         xKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXffRTQkeKscbddjBgK9BhilOU6iS/TrKvpQ7cD3hfw=;
        b=DeL5h/LSnEGZxKLGS4kSNxvRJVqRHIgz1ulKOiPZMIZpTXgoY8hGiqIZHhN/6t+Cfh
         U1rb70YRazaXf5i61LcB/Thon1rVh6CjqFt3LMgnSDsp1b9E4QI+5bgPc3MdQoIdHsUL
         859qb+yt0LVuPhZkpcSyxmTYaR9qqdv5NDrXNDdqXf3BVOPoELUtsHIWHIEdHWw5pRwx
         mHU3b9Gvz7/mESTbdb0tlRanxos96kWTggEFN1Yy2JwbgI8gSrfPG+nXL5jfHcLfNLFd
         3Dc9B0FWbgeF8BHMXL7cyz8RQrlyJUHsEQqlSgN9ATjSzFG/GKs7vJ4/u0dIeXKIeu6h
         c/pQ==
X-Gm-Message-State: AOAM530K9SG6P7F/X6vEXwFnCMpkAWap1vwY2izzFb2PpYUdGdukc1yB
        4KR4LkmlxyUkdvickM9cnq+j8IPuI0Mtsaot5a0=
X-Google-Smtp-Source: ABdhPJzMYKkg+Nt4ENAXbRd4VRs18QVhdQNVtdDVVhXQMdv+mTj7Iw346BtsZG3IsIf/DpHqZMsBK1cmJnp3r228N9c=
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr33108ejr.345.1604541237520;
 Wed, 04 Nov 2020 17:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-4-harshadshirwadkar@gmail.com> <20201103144646.GG3440@quack2.suse.cz>
In-Reply-To: <20201103144646.GG3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 4 Nov 2020 17:53:46 -0800
Message-ID: <CAD+ocbwuy3z=DOgBOYdPcbTqqqPad4HJax+9t9797C5wwSRLXQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] ext4: pass handle to ext4_fc_track_* functions
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 6:46 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:11, Harshad Shirwadkar wrote:
> > Use transaction id found in handle->h_transaction->h_tid for tracking
> > fast commit updates. This patch also restructures ext4_unlink to make
> > handle available inside ext4_unlink for fast commit tracking.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Thanks for the patch. Couple of comments below:
>
> > @@ -4651,8 +4652,6 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >                    FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
> >                    FALLOC_FL_INSERT_RANGE))
> >               return -EOPNOTSUPP;
> > -     ext4_fc_track_range(inode, offset >> blkbits,
> > -                     (offset + len - 1) >> blkbits);
>
> Why do you delete the ext4_fc_track_range() call here?
I realized that all the different ext4_fallocate functions such as
punch_hole, zero_range etc have their own track calls. Collapse_range
and insert_range are fc ineligible operations, and the default
fallocate calls ext4_map_blocks(), so this call here isn't really
needed. I also took a look at all the other calls to
ext4_fc_track_range() and I think we only need ext4_fc_track_range()
calls in following situations:

1) ext4_map_blocks()
2) ext4_punch_hole()
3) ext4_zero_range()
4) ext4_setattr() --> for handling truncate

I'll remove all the other callers in the next version.

>
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 354f81ff819d..5c3af472287a 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -323,15 +323,18 @@ static inline int ext4_fc_is_ineligible(struct super_block *sb)
> >   * If enqueue is set, this function enqueues the inode in fast commit list.
> >   */
> >  static int ext4_fc_track_template(
> > -     struct inode *inode, int (*__fc_track_fn)(struct inode *, void *, bool),
> > +     handle_t *handle, struct inode *inode,
> > +     int (*__fc_track_fn)(struct inode *, void *, bool),
> >       void *args, int enqueue)
> >  {
> > -     tid_t running_txn_tid;
> >       bool update = false;
> >       struct ext4_inode_info *ei = EXT4_I(inode);
> >       struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> > +     tid_t tid = 0;
> >       int ret;
> >
> > +     if (ext4_handle_valid(handle) && handle->h_transaction)
> > +             tid = handle->h_transaction->t_tid;
>
> The handle->h_transaction check is pointless here. It is always true. And
> if you move the tid fetching after the JOURNAL_FAST_COMMIT check below, you
> don't need the ext4_handle_valid() check either as fastcommit cannot be
> enabled without a journal.
Ack
>
> >       if (!test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT) ||
> >           (sbi->s_mount_state & EXT4_FC_REPLAY))
> >               return -EOPNOTSUPP;
>
>
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 5159830dacb8..f3f8bf61072e 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -2631,7 +2631,7 @@ static int ext4_create(struct inode *dir, struct dentry *dentry, umode_t mode,
> >               inode_save = inode;
> >               ihold(inode_save);
> >               err = ext4_add_nondir(handle, dentry, &inode);
> > -             ext4_fc_track_create(inode_save, dentry);
> > +             ext4_fc_track_create(handle, inode_save, dentry);
> >               iput(inode_save);
> >       }
> >       if (handle)
> > @@ -2668,7 +2668,7 @@ static int ext4_mknod(struct inode *dir, struct dentry *dentry,
> >               ihold(inode_save);
> >               err = ext4_add_nondir(handle, dentry, &inode);
> >               if (!err)
> > -                     ext4_fc_track_create(inode_save, dentry);
> > +                     ext4_fc_track_create(handle, inode_save, dentry);
> >               iput(inode_save);
> >       }
>
> Not directly related to this patch but why do you bother with 'inode_save'
> in the above cases? I guess you're afraid by the comment that "inode
> reference is consumed by the dentry" but since you have a dentry reference
> as well, you can be sure that the inode stays around...
Yeah, I think I was confused by that. I'll get rid of inode_save stuff
and just use d_inode(dentry) instead.
>
> >       if (handle)
> > @@ -2833,7 +2833,7 @@ static int ext4_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
> >               iput(inode);
> >               goto out_retry;
> >       }
> > -     ext4_fc_track_create(inode, dentry);
> > +     ext4_fc_track_create(handle, inode, dentry);
> >       ext4_inc_count(dir);
>
> And I was also wondering why all the directory tracking functions take both
> dentry and the inode. You can fetch inode from a dentry with d_inode()
> helper so I don't see a reason for passing it separately. That is, in a
> couple of places you call ext4_fc_track_*() before d_instantiate[_new]() so
> dentry isn't fully setup yet but there's nothing which prevents you from
> calling it after d_instantiate().
>
> The only possible exception to this is the ext4_rename() code. There you
> don't have suitable dentry for the link tracking so this would need to
> explicitely pass the inode & dentry. But that place can just call a low
> level wrapper allowing that. All the other places can use a higher level
> function which just takes the dentry.
Yeah, it's the rename that's the problem. Rename calls
ext4_fc_track_link() and ext4_fc_track_unlink(). I'd need to define
two lower level wrappers just for this one function call. But I agree
that it will make the code look much cleaner. I'll do that in V2.
>
> >  static int ext4_unlink(struct inode *dir, struct dentry *dentry)
> >  {
> > +     handle_t *handle;
> >       int retval;
> >
> >       if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
> > @@ -3282,9 +3273,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
> >       if (retval)
> >               goto out_trace;
> >
> > -     retval = __ext4_unlink(dir, &dentry->d_name, d_inode(dentry));
> > +     handle = ext4_journal_start(dir, EXT4_HT_DIR,
> > +                                 EXT4_DATA_TRANS_BLOCKS(dir->i_sb));
> > +     if (IS_ERR(handle)) {
> > +             retval = PTR_ERR(handle);
> > +             goto out_trace;
> > +     }
> > +
> > +     retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
> >       if (!retval)
> > -             ext4_fc_track_unlink(d_inode(dentry), dentry);
> > +             ext4_fc_track_unlink(handle, d_inode(dentry), dentry);
> >  #ifdef CONFIG_UNICODE
> >       /* VFS negative dentries are incompatible with Encoding and
> >        * Case-insensitiveness. Eventually we'll want avoid
> > @@ -3295,6 +3293,8 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
> >       if (IS_CASEFOLDED(dir))
> >               d_invalidate(dentry);
> >  #endif
> > +     if (handle)
> > +             ext4_journal_stop(handle);
>
> How could 'handle' be NULL here?
Ack

Thanks,
Harshad

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
