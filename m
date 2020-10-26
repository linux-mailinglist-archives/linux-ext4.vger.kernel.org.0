Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49DF2992A3
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Oct 2020 17:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786240AbgJZQka (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Oct 2020 12:40:30 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:46040 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1786238AbgJZQka (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Oct 2020 12:40:30 -0400
Received: by mail-ej1-f66.google.com with SMTP id dt13so14537169ejb.12
        for <linux-ext4@vger.kernel.org>; Mon, 26 Oct 2020 09:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRCgKfkNMkyO5vhhWKo4sOlt/KmvTkflm7J/wOAOVk8=;
        b=RaFXSEW0WYjNQu/kmf0wYjX9ttn8uOchhwzMG/4RSM96Yr9agBSvJcdoxQZCT8qF+r
         HYFjSZ+HxPnRakUsIlYjshH/oKXvIds8gY0HvV9bs+VVSNE2vdmhZlDeq1I8zuD6dqCu
         4QG9oocH2wVLfI6kCPvQhyyk0s6WVnCPrK7vpnPELfau4KLl1GzcRkHjN1lLAJYHLdh4
         Ve8JPGCZxDiSEBH7dp40YV/oZWoG7ayI34m1+bFyhCHA/bSS8OX988ZDNFYVp+yt2KwP
         I1YcoYzfBBBYu9t61rJbNXPIeSN/Vyt661mdTgashgubMKa4fzx293Nn/bC2xTLgu5Vt
         npPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRCgKfkNMkyO5vhhWKo4sOlt/KmvTkflm7J/wOAOVk8=;
        b=PHZILBYLyXKx1Q00huVtuo0p5dgzJlQH2z7khBy5p9q3/MniT2s2S1TOi1q4UW2gB7
         kbXE2N3HWTARo72bAjamccugHnN67+o7b4OF0Of1X0vGkqwXJ+zTdNtY87qUV/7Ue5wc
         LRxdGSHlLZVLx9O2EtRafMBQ/MOBaboBmR8APk80yczX778AqSXD3LNGYF8WwWiWW9ma
         93Gbk1v4z5VdXoJJEbvD/o94SmOatfHn+wr+cMvUj4QxmQHFM/iQZyuU6UcITCmuh2Ex
         izHqRGN7M/D1vkSWOx2WfggdecZYHyT8LUvGGrX/6Pj6nT1DtSOSCnr4I3JAQPnkNkxZ
         DVww==
X-Gm-Message-State: AOAM532gkvpTiwvE5KLB7eKILDboJSgtTzwj93ZOlnRMnDbUzmh81kPZ
        vcuJJh3Dyc3Y876x2W+cnMsF05j9MNBbrExVVPk=
X-Google-Smtp-Source: ABdhPJxi+lPuMlYMNC/aZwZlb3VMyR14tNwmpOO3S0Mkdyuk/Nvq5Rw59wbpV23I+ENGdEg7OOxaxnJ+Yop0UNSPVDQ=
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr16070829ejb.187.1603730426624;
 Mon, 26 Oct 2020 09:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-3-harshadshirwadkar@gmail.com> <20201021161814.GC25702@quack2.suse.cz>
 <CAD+ocbyCs4DpcCwEtrnh-aodK-p+SWybuKw+ebUrCvKS0uMDaQ@mail.gmail.com> <20201022130908.GD24163@quack2.suse.cz>
In-Reply-To: <20201022130908.GD24163@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 26 Oct 2020 09:40:15 -0700
Message-ID: <CAD+ocbyw2ZuohtkaVXGBG7kKeRj7k+5faYDm4c3t1_c_pSva5w@mail.gmail.com>
Subject: Re: [PATCH v10 2/9] ext4: add fast_commit feature and handling for
 extended mount options
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Will do, thanks!

On Thu, Oct 22, 2020 at 6:09 AM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 21-10-20 10:31:48, harshad shirwadkar wrote:
> > On Wed, Oct 21, 2020 at 9:18 AM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Thu 15-10-20 13:37:54, Harshad Shirwadkar wrote:
> > > > We are running out of mount option bits. Add handling for using
> > > > s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
> > > > ability to turn off the fast commit feature in Ext4.
> > > >
> > > > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > > > ---
> > > >  fs/ext4/ext4.h       |  4 ++++
> > > >  fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
> > > >  include/linux/jbd2.h |  5 ++++-
> > > >  3 files changed, 30 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > > index 1879531a119f..02d7dc378505 100644
> > > > --- a/fs/ext4/ext4.h
> > > > +++ b/fs/ext4/ext4.h
> > > > @@ -1213,6 +1213,8 @@ struct ext4_inode_info {
> > > >  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM        0x00000008 /* User explicitly
> > > >                                               specified journal checksum */
> > > >
> > > > +#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT      0x00000010 /* Journal fast commit */
> > > > +
> > > >  #define clear_opt(sb, opt)           EXT4_SB(sb)->s_mount_opt &= \
> > > >                                               ~EXT4_MOUNT_##opt
> > > >  #define set_opt(sb, opt)             EXT4_SB(sb)->s_mount_opt |= \
> > > > @@ -1813,6 +1815,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
> > > >  #define EXT4_FEATURE_COMPAT_RESIZE_INODE     0x0010
> > > >  #define EXT4_FEATURE_COMPAT_DIR_INDEX                0x0020
> > > >  #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2    0x0200
> > > > +#define EXT4_FEATURE_COMPAT_FAST_COMMIT              0x0400
> > > >  #define EXT4_FEATURE_COMPAT_STABLE_INODES    0x0800
> > >
> > > Is fast commit really a compat feature? IMO if there are fast commits
> > > stored in the journal, the filesystem is actually incompatible with the
> > > old kernels because data we guranteed to be permanenly stored may be
> > > invisible for the old kernel (since it won't replay fastcommit
> > > transactions).
> > >
> > > ...
> > >
> > > Oh, now I see that the journal FAST_COMMIT is actually incompat. So what's
> > > the point of compat ext4 feature with incompat JBD2 feature?
> > So having fast commits enabled on an ext4 file system doesn't
> > immediately make it incompatible with the older kernels. FS becomes
> > incompatible only if there are fast commits blocks that are stored in
> > the journal. So, one of the tricks that this patchset does is on a
> > clean unmount, since it's guaranteed that there are no fast commit
> > blocks in journal, we clear out the JBD2 incompat flag and preserve
> > the compat flag in ext4. So, we can think of ext4 compat flag as "FS
> > will try fast commits when possible" while jbd2 incompat flag as
> > "There are fast commits blocks present in the journal". Does that make
> > sense?
>
> Yes, understood. That's clever. Thanks for explanation! But please add the
> above justification to the description of EXT4_FEATURE_COMPAT_FAST_COMMIT
> feature or somewhere around that.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
