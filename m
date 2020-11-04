Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BA82A6FBB
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Nov 2020 22:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731436AbgKDVf5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Nov 2020 16:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731404AbgKDVf5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Nov 2020 16:35:57 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3705C0613D3
        for <linux-ext4@vger.kernel.org>; Wed,  4 Nov 2020 13:35:56 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id a10so6838967edt.12
        for <linux-ext4@vger.kernel.org>; Wed, 04 Nov 2020 13:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFObasUtiXPKydGigI97edI1fCaY0o3DK1B8Ycx9MKw=;
        b=kyvUfnhyEnQblgYOVJRYaszDhNkY+Xc5xWBTzS+btZHNSR9zs+QVl5MaWOsEaUWuHZ
         SvsaIMuomLojf5UA3ZkIIifCo1NZLGDtNIXIsEALPcvfimDsKPNQrvHRtonXxNbzNyt2
         4GDkLC3Omhm+JmrFnfhX2hycWxhG3u4FcdwC83FMK/+0mU+vSepnKDdq6qsnh2NZJi5X
         zfrk5PsIZoQfmj1/jtEyfFis16wwFAben2+CVHDVi1y+WoaJuHidPPBJ14CHd76nh1HE
         GEil4uPTaOzeVRwM6InzQDPOVZvUVwMzaPBgNDJ7aV1JFU5nJ6uOHzF0sTbrs4bwbeVg
         +POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFObasUtiXPKydGigI97edI1fCaY0o3DK1B8Ycx9MKw=;
        b=Q4HGX0jpfdXqwUAAbbPnb7fDUwfmf8QFwYsraXPxeYBsC9fwDISroX/4fWMmIfslYY
         1b2K3FJduDErjdTccBqDFeshrhXmPwftwR4aLiynlsilvF7Pe3/PON+LHRYh3U8YRo4Y
         r6S9LQzNqDLDy8niVvJ3Ibq+bNVXnaBhp7nCZv7TSNWepQGbDriJ0CDwmS/lBMWQAUbE
         x0NH7MCH1nI0gnyWKuiPImgN7vG2NXXao9HzuKHp7VQHKno0kfvcaD0jVVuhtszFckmB
         6IJpDrc1UZUbZ7dzrt04vb0MOfBfPDSzhlOXz1i+R7Z+PXU6SO58iZ2bJCAU2ZOEUfCS
         PzYg==
X-Gm-Message-State: AOAM532exgFNgEOL9uprazFz9b2Lbcdbcm8sKGxAstmcz0dBBQfpgVhq
        es3RHn47k8nb5GipN3FQ5ccFlsHWSXlSWQZpP2GvwjjX7MH6HJIW
X-Google-Smtp-Source: ABdhPJwke1eynxU9C84n1iECDWPUHKqA8Ormp2DCE6oXt98MRweCXk+4UddDCEg23AhseQr5Shnb4l2eQZihEPXOJlE=
X-Received: by 2002:aa7:df81:: with SMTP id b1mr21245227edy.365.1604525755605;
 Wed, 04 Nov 2020 13:35:55 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-7-harshadshirwadkar@gmail.com> <20201103164203.GJ3440@quack2.suse.cz>
In-Reply-To: <20201103164203.GJ3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 4 Nov 2020 13:35:44 -0800
Message-ID: <CAD+ocbxiLYy6fMdcW_WoR6KvXBqE6eu5uyFgZfgUVwVLYBOGMw@mail.gmail.com>
Subject: Re: [PATCH 06/10] ext4: dedpulicate the code to wait on inode that's
 being committed
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 8:42 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:14, Harshad Shirwadkar wrote:
> > This patch removes the deduplicates the code that implements waiting
> > on inode that's being committed. That code is moved into a new
> > function.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Looks good to me. Just one nit below:
>
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index b1ca55c7d32a..0f2543220d1d 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -155,6 +155,28 @@ void ext4_fc_init_inode(struct inode *inode)
> >       ei->i_fc_committed_subtid = 0;
> >  }
> >
> > +static void ext4_fc_wait_committing_inode(struct inode *inode)
> > +{
> > +     wait_queue_head_t *wq;
> > +     struct ext4_inode_info *ei = EXT4_I(inode);
> > +
>
> Maybe add lockdep_assert_held(&EXT4_SB(inode->i_sb)->s_fc_lock) here to
> make sure the function is called properly? It's kind of unobvious
> requirement (but hard to avoid)...
Sounds good. I had to add it after the #ifdef and before the
"prepare_to_wait()" call in order to avoid "ISO C90 forbids mixed
declarations and code [-Wd
eclaration-after-statement]" warning.

Thanks,
Harshad
>
> > +#if (BITS_PER_LONG < 64)
> > +     DEFINE_WAIT_BIT(wait, &ei->i_state_flags,
> > +                     EXT4_STATE_FC_COMMITTING);
> > +     wq = bit_waitqueue(&ei->i_state_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +#else
> > +     DEFINE_WAIT_BIT(wait, &ei->i_flags,
> > +                     EXT4_STATE_FC_COMMITTING);
> > +     wq = bit_waitqueue(&ei->i_flags,
> > +                             EXT4_STATE_FC_COMMITTING);
> > +#endif
> > +     prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
> > +     spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> > +     schedule();
> > +     finish_wait(wq, &wait.wq_entry);
> > +}
> > +
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
