Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D314A8A56
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Feb 2022 18:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352985AbiBCRle (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Feb 2022 12:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352996AbiBCRl1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Feb 2022 12:41:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB46C06173D
        for <linux-ext4@vger.kernel.org>; Thu,  3 Feb 2022 09:41:27 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ah7so11011647ejc.4
        for <linux-ext4@vger.kernel.org>; Thu, 03 Feb 2022 09:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6oT++hW6C5oK1MiLjZAPXBEmMurv/nr5AWtfuQ46IUI=;
        b=O2KpXGsDPQ+PTUK/DudcfJwnCK0EceTOw7JLwf/SdVhHamvxesabrnNn6EKmpPYL11
         2o9P4vvizXVo+WIcQnDIGYMjIZ0vkq7uEHQ7e8G9oiV9MuvKqHdWY0KLVFG7Up/U5qxe
         XcS18DP+qHfSjdfBxesBz/RD30/1HOKGrHFMr0K55aXa1gWPZdzWi+tfjrThPPmYzXrE
         zNvqeyYsrD3KNVbNTCiowuaz2TgNHyZIcgniPqMYCcOFKffTBczzGPWaaZtE9XyKsS/J
         JTGoSzM8EUtEUwUuGfIss7qaglycDw0chjjCEXCQTi0+KgxdBOGluG3lgsLsBTtfgPC0
         afrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6oT++hW6C5oK1MiLjZAPXBEmMurv/nr5AWtfuQ46IUI=;
        b=sG5I6syyjFjVcX2PN1dlBg7OjWDHzwfA0EDurdOomTYDcU4hMwgeItPd38aSVMHF54
         xFwg4NYdjWsFYf9LuTZIEKa/r8Y1zRKX75cjISZUKC1xrW0SPYiG07gkLxj0isfuhTKh
         BJ62LOgvzMpeNWciQGZ1CCLQtpX2uzP8YP1ZqlSoVBi9Z/oZbVCU2Q30pLoe9wfhazkF
         p2rB0dFDAVRJFEAO5W2DEFxKNZxmbDT5gJVg/OinxUCOq+aovAT03/H0BJzMs+Hv7buD
         ZYwuuIfGk5oECrTWpG2kL+Ss4yoX5tix4G3mjXOXUVIRBOmpD7tea6H1xTyDFGVhNhl6
         /7Cg==
X-Gm-Message-State: AOAM530wOx2ovK2uVJfK01xZvYwcimOPJki1uOEq6Y/JWjqXlsmRwBi+
        uTXqn1FiJ+QCqYrWmr8EYjwsSvsk1c/dmTNYnMMSyM2Q7GQ=
X-Google-Smtp-Source: ABdhPJxukn1ZOUjO5AKWcYZzt9kxQFnnKa5oV88Cq1RfR48nvBN4WNomgvepEvfApZu4ADqJXTc5FgCF0nXpZC29LMo=
X-Received: by 2002:a17:907:6d99:: with SMTP id sb25mr31454263ejc.15.1643910085894;
 Thu, 03 Feb 2022 09:41:25 -0800 (PST)
MIME-Version: 1.0
References: <20220203064659.1438701-1-harshads@google.com> <20220203121407.q5htlemd6fljaptf@quack3.lan>
In-Reply-To: <20220203121407.q5htlemd6fljaptf@quack3.lan>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 3 Feb 2022 09:41:14 -0800
Message-ID: <CAD+ocbwaEisW7_iN-dtirzPfncG3=BWvrOkmjFNZac599u6odg@mail.gmail.com>
Subject: Re: [PATCH] ext4: remove journal barrier during fast commit
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the detailed review Jan, please see my questions and responses below:

On Thu, 3 Feb 2022 at 04:14, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 02-02-22 22:46:59, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > In commit 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69 ("ext4: use
>
> Just first 12 digits from the commit sha is enough :)
Ack!
>
> > ext4_journal_start/stop for fast commit transactions"), journal
> > barrier was introduced in fast commit path as an intermediate step for
> > fast commit API migration. This patch removes the journal barrier to
> > improve the fast commit performance. Instead of blocking the entire
> > journal before starting the fast commit, this patch only blocks the
> > inode that is being committed during a fast commit.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ...
> > diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> > index 3477a16d08ae..16321f89934c 100644
> > --- a/fs/ext4/ext4_jbd2.c
> > +++ b/fs/ext4/ext4_jbd2.c
> > @@ -106,6 +106,61 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
> >                                  GFP_NOFS, type, line);
> >  }
> >
> > +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> > +                               int type, int blocks, int rsv_blocks,
> > +                               int revoke_creds)
> > +{
> > +     handle_t *handle;
> > +     journal_t *journal;
> > +     int err;
> > +
> > +     trace_ext4_journal_start(inode->i_sb, blocks, rsv_blocks, revoke_creds,
> > +                              _RET_IP_);
> > +     err = ext4_journal_check_start(inode->i_sb);
> > +     if (err < 0)
> > +             return ERR_PTR(err);
> > +
> > +     journal = EXT4_SB(inode->i_sb)->s_journal;
> > +     if (!journal || (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY))
> > +             return ext4_get_nojournal();
> > +
> > +     handle = jbd2__journal_start(journal, blocks, rsv_blocks, revoke_creds,
> > +                                  GFP_NOFS, type, line);
> > +
>
> Perhaps you could reuse __ext4_journal_start_sb() in the above?
>
> > +     if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT)
> > +         && !IS_ERR(handle)
> > +         && !ext4_test_mount_flag(inode->i_sb, EXT4_MF_FC_INELIGIBLE)) {
> > +             if (handle->h_ref == 1) {
> > +                     WARN_ON(handle->h_priv != NULL);
> > +                     ext4_fc_start_update(handle, inode);
> > +                     handle->h_priv = inode;
> > +                     return handle;
> > +             }
> > +             /*
> > +              * Check if this is a nested transaction that modifies multiple
> > +              * inodes. Such a transaction is fast commit ineligible.
> > +              */
> > +             if (handle->h_priv != inode)
> > +                     ext4_fc_mark_ineligible(inode->i_sb,
> > +                                             EXT4_FC_REASON_TOO_MANY_INODES,
> > +                                             handle);
> > +     }
>
> Hum, here you seem to assume that if inode will be modified, we will call
> __ext4_journal_start() with that inode. But that is not true. It is
> perfectly valid to start a transaction with ext4_journal_start_sb() and
> then add inodes to it. ext4_journal_start() is just a convenience helper to
> save some boilerplate code you can but don't have to use when starting a
> transaction. In particular we can have handles modifying more inodes
> without calling ext4_journal_start() for all of them. We also have places
> (most notably inode allocation) that definitely modify inodes but start
> transaction with ext4_journal_start_sb(). A lot of auditing would be
> required to make this approach work and even more to make sure it does not
> break in the future.
Ack.
>
> If I'm reading the code right, what you need to achieve is that buffer
> backing raw inode or inode's logical->physical block mapping is not
> modified while the fastcommit including that inode is running because it
> would corrupt the information being committed. So would not it be enough to
> call ext4_fc_start_update() in ext4_map_blocks() once we know that we need
> to modify block mapping and similarly in ext4_reserve_inode_write() (which
> would need a bit of work to get used universally - fs/ext4/inline.c does
> not seem to use it)? In ext4_journal_stop() we can then call
> ext4_fc_stop_update() (we could either keep going with the
> one-inode-per-handle limitation you have or introduce a list of inodes
> attached to a handle). So essentially attaching inode to fastcommit would
> rather be similar to jbd2_journal_get_write_access() than a transaction
> start. I guess in principle that would work we just have to be careful not
> to introduce deadlocks with running fastcommit (so that fastcommit does not
> wait for some inode update to finish, owner of the handle with that inode
> update waits for some lock, and the lock is held by someone waiting for
> fastcommit to finish). So to do that we would need to block all new handle
> starts, wait for all inode updates to finish (which essentially means wait
> for all handles that modify inodes involved in fastcommit), set
> EXT4_STATE_FC_COMMITTING for all involved inodes, unblock handle starts and
> then we can go on with the fastcommit and EXT4_STATE_FC_COMMITTING flags
> will protect us from inode modifications. This is better than
> journal_lock_updates() we have now but I'm not sure this is the improvement
> you were looking for ;).
Ack, that makes sense. I'll update this patch to call
ext4_fc_start_update() in ext4_reserve_inode_write() and
ext4_map_blocks() as we discussed.

ext4_fc_start_update() has the logic to wait if the inode is in
EXT4_STATE_FC_COMMITTING state. In the current version of the code,
new handle starts are not blocked if they start on an inode that is
not in the fast commit list. But if the inode is being committed (i.e.
its state is EXT4_FC_STATE_FC_COMMITTING), ext4_fc_start_update() will
wait for the commit to finish. With the changes that you mentioned,
instead of waiting at journal start, now ext4_fc_start_update() will
wait at ext4_reserve_inode_write(). Is that acceptable? Apart from
deadlock concerns, are there any other correctness issues with doing
that?
>
> > +
> > +     return handle;
> > +}
> > +
> > +/* Stop fast commit update on the inode in this handle, if any. */
> > +static void ext4_fc_journal_stop(handle_t *handle)
> > +{
> > +     if (!handle->h_priv || handle->h_ref > 1)
> > +             return;
> > +     /*
> > +      * We have an inode and this is the top level __ext4_journal_stop call.
> > +      */
> > +     ext4_fc_stop_update(handle);
> > +     handle->h_priv = NULL;
> > +}
> > +
> >  int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
> >  {
> >       struct super_block *sb;
> > @@ -119,11 +174,13 @@ int __ext4_journal_stop(const char *where, unsigned int line, handle_t *handle)
> >
> >       err = handle->h_err;
> >       if (!handle->h_transaction) {
> > +             ext4_fc_journal_stop(handle);
> >               rc = jbd2_journal_stop(handle);
> >               return err ? err : rc;
> >       }
> >
> >       sb = handle->h_transaction->t_journal->j_private;
> > +     ext4_fc_journal_stop(handle);
> >       rc = jbd2_journal_stop(handle);
> >
> >       if (!err)
>
> Why don't you call ext4_fc_journal_stop() a bit earlier and thus avoid the
> two callsites?
Ack, will do that in V2.
>
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index d2a29fc93742..5edac6f6f7d3 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -5658,7 +5658,6 @@ int ext4_mark_iloc_dirty(handle_t *handle,
> >               put_bh(iloc->bh);
> >               return -EIO;
> >       }
> > -     ext4_fc_track_inode(handle, inode);
>
> I'm confused why it is safe to remove this. I mean if a transaction is
> modifying multiple inodes you will not track them in fast commit?
This is a consequence of my incorrect assumption that the right inode
is always passed to ext4_journal_start(). What I was assuming was that
if the right inode is passed to ext4_journal_start(), then
ext4_journal_start() would ensure that the inode gets tracked. And so
there's no need to do that here again.

Even with the new proposed changes, the inode will be tracked from
ext4_reserve_inode_write(), right? So there is no need to do that here
again?
>
> >
> >       if (IS_I_VERSION(inode))
> >               inode_inc_iversion(inode);
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index d1c4b04e72ab..7cbe0084bb39 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1428,7 +1428,6 @@ static void destroy_inodecache(void)
> >
> >  void ext4_clear_inode(struct inode *inode)
> >  {
> > -     ext4_fc_del(inode);
> >       invalidate_inode_buffers(inode);
> >       clear_inode(inode);
> >       ext4_discard_preallocations(inode, 0);
>
> Is this really safe? What prevents inode reclaim from reclaiming inode
> while it is still part of fastcommit?
I have moved this call from ext4_clear_inode to ext4_free_inode. That
takes care of preventing inode reclaim if the inode is on the fast
commit list. If ext4_evict_inode calls ext4_clear_inode directly
(without ext4_free_inode), then I mark the file system as fast commit
ineligible (actually I realized that I have missed that case in this
version, will add that in V2).

Thanks,
Harshad
>
>                                                                 Honza
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
