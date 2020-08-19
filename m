Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E9A24923D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 03:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHSBUY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 21:20:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34548 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgHSBUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Aug 2020 21:20:23 -0400
Received: from mail-vk1-f197.google.com ([209.85.221.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1k8Cm5-0000Ls-Kk
        for linux-ext4@vger.kernel.org; Wed, 19 Aug 2020 01:20:21 +0000
Received: by mail-vk1-f197.google.com with SMTP id n68so7371986vkf.11
        for <linux-ext4@vger.kernel.org>; Tue, 18 Aug 2020 18:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8m7x0y0fdVGccgcCC9EHSLB3RBAbNnCdZC5bzzdr5k4=;
        b=h6lOOUmT+aJaFjJsBaPNVpmOGfksDnFxHxafO16wi/QnZhMCBh0OyPd7aKS50R4XdC
         UyndKrjw8hxJnHEdau2XugZFrdTXITgnUDMIL/dzryxfB2YSBf0xMM1/OK2Hdrry8JwU
         aQcNzK13ryrRAkJekEWxBPanb2okS4B3UmDSsaX6LCS2sn/5X/V70/LDgdomKFTz7XJj
         3tK8iQF+SJ9ICplWu61g5Tli4WTWGKGHsJ4BPUHPDtWX2wGF9hsKceBOOd82VElKJQZX
         cG+fub8TjYozjnRuWnlisWtR/n3Usgh65V8V8aTMHFP3tmD8hSRY1hkJ6kR4Bgk5PTRB
         rMOg==
X-Gm-Message-State: AOAM530arLLfP1HjSbzlPdM9QsIYC8IqmDuc1D0ooMbP02AqjOKI0+7T
        crTq1PXY0Pmxl58vhxLfhBJKNOt6VWQquN4VQQXBwVWzx381qWcWUzSlpHGVHJZ0uplKlO1CESD
        Uphu7Fj0BeYSH2CxvB0JM++FCwpk1c1fE3LcYs+Fvr8Hy+oEGFcxilvg=
X-Received: by 2002:a05:6102:209d:: with SMTP id h29mr12916452vsr.212.1597800020617;
        Tue, 18 Aug 2020 18:20:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhzXUIlksNZTJK5X6ERhY4rF7YExCkvZN0yuKw13Ifi0/azu+KUb5/HQDJCJb4w+NLo3YOgvtmrBLZfXSI+dE=
X-Received: by 2002:a05:6102:209d:: with SMTP id h29mr12916444vsr.212.1597800020358;
 Tue, 18 Aug 2020 18:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200810010210.3305322-1-mfo@canonical.com> <20200810010210.3305322-3-mfo@canonical.com>
 <20200818145204.GC1902@quack2.suse.cz>
In-Reply-To: <20200818145204.GC1902@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Tue, 18 Aug 2020 22:20:08 -0300
Message-ID: <CAO9xwp3mvXbGSMwPag431P+nGuVud2FK7n-Bq12LYLqm8uNOug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/5] jbd2: introduce journal callbacks j_submit|finish_inode_data_buffers
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        dann frazier <dann.frazier@canonical.com>,
        Mauricio Faria de Oliveira <mauricio.foliveira@gmail.com>,
        Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

Thanks for reviewing.

On Tue, Aug 18, 2020 at 11:52 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 09-08-20 22:02:05, Mauricio Faria de Oliveira wrote:
> > Add the callbacks as opt-in to override the default behavior for
> > the transaction's inode list, instead of moving that code around.
> >
> > This is important as not only ext4 uses the inode list: ocfs2 too,
> > via jbd2_journal_inode_ranged_write(), and maybe out-of-tree code.
>
> I'd prefer if the callback is called unconditionally, jbd2 exports the
> callback that implements the current behavior and and both ext4 & ocfs2
> are adapted to use this callback. We don't care about out of tree code.
> That way things are cleaner long term...

Understood.

>
> > To opt-out of the default behavior (i.e., to do nothing), one has
> > to opt-in with a no-op function.
>
> Your Signed-off-by is missing for this patch.

Oh, I thought it wasn't needed in RFC patches.

Thanks for the suggestions below; they're more precise and descriptive.

I had a few questions in the cover letter, but in case you didn't have
the time, I'll just try harder on them; no worries.

Kind regards,
Mauricio

>
> > ---
> >  fs/jbd2/commit.c     | 21 ++++++++++++++++-----
> >  include/linux/jbd2.h | 21 ++++++++++++++++++++-
> >  2 files changed, 36 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> > index 51f713089e35..b98d227b50d8 100644
> > --- a/fs/jbd2/commit.c
> > +++ b/fs/jbd2/commit.c
> > @@ -237,10 +237,14 @@ static int journal_submit_data_buffers(journal_t *journal,
> >                * instead of writepages. Because writepages can do
> >                * block allocation  with delalloc. We need to write
> >                * only allocated blocks here.
> > +              * This can be overriden with a custom callback.
> >                */
> >               trace_jbd2_submit_inode_data(jinode->i_vfs_inode);
> > -             err = journal_submit_inode_data_buffers(mapping, dirty_start,
> > -                             dirty_end);
> > +             if (journal->j_submit_inode_data_buffers)
> > +                     err = journal->j_submit_inode_data_buffers(jinode);
> > +             else
> > +                     err = journal_submit_inode_data_buffers(mapping,
> > +                                     dirty_start, dirty_end);
> >               if (!ret)
> >                       ret = err;
> >               spin_lock(&journal->j_list_lock);
> > @@ -274,9 +278,16 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
> >                       continue;
> >               jinode->i_flags |= JI_COMMIT_RUNNING;
> >               spin_unlock(&journal->j_list_lock);
> > -             err = filemap_fdatawait_range_keep_errors(
> > -                             jinode->i_vfs_inode->i_mapping, dirty_start,
> > -                             dirty_end);
> > +             /*
> > +              * Wait for the inode data buffers writeout.
> > +              * This can be overriden with a custom callback.
> > +              */
> > +             if (journal->j_finish_inode_data_buffers)
> > +                     err = journal->j_finish_inode_data_buffers(jinode);
> > +             else
> > +                     err = filemap_fdatawait_range_keep_errors(
> > +                                     jinode->i_vfs_inode->i_mapping,
> > +                                     dirty_start, dirty_end);
> >               if (!ret)
> >                       ret = err;
> >               spin_lock(&journal->j_list_lock);
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index d56128df2aff..24efe88eda1b 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -628,7 +628,8 @@ struct transaction_s
> >       struct journal_head     *t_shadow_list;
> >
> >       /*
> > -      * List of inodes whose data we've modified in data=ordered mode.
> > +      * List of inodes whose data we've modified in data=ordered mode
> > +      * or whose pages we should write-protect in data=journaled mode.
>
> I'd rather change the comment to generic "List of inodes associated with
> the transaction. E.g. ext4 uses this to track inodes in data=ordered and
> data=journal mode that need special handling on transaction commit.".
>
> >        * [j_list_lock]
> >        */
> >       struct list_head        t_inode_list;
> > @@ -1110,6 +1111,24 @@ struct journal_s
> >       void                    (*j_commit_callback)(journal_t *,
> >                                                    transaction_t *);
> >
> > +     /**
> > +      * @j_submit_inode_data_buffers:
> > +      *
> > +      * This function is called before flushing metadata buffers.
> > +      * This overrides the default behavior (writeout data buffers.)
> > +      */
>
> I'd change the comment to:
>          * This function is called for all inodes associated with the
>          * committing transaction marked with JI_WRITE_DATA flag before we
>          * start to write out the transaction to the journal.
>
> > +     int                     (*j_submit_inode_data_buffers)
> > +                                     (struct jbd2_inode *);
> > +
> > +     /**
> > +      * @j_finish_inode_data_buffers:
> > +      *
> > +      * This function is called after flushing metadata buffers.
> > +      * This overrides the default behavior (wait writeout.)
> > +      */
>
> And here:
>          * This function is called for all inodes associated with the
>          * committing transaction marked with JI_WAIT_DATA flag after we
>          * we have written the transaction to the journal but before we
>          * write out the commit block.
>
>
> > +     int                     (*j_finish_inode_data_buffers)
> > +                                     (struct jbd2_inode *);
> > +
> >       /*
> >        * Journal statistics
> >        */
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



-- 
Mauricio Faria de Oliveira
