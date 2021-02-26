Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D77325BAF
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Feb 2021 03:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBZChZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Feb 2021 21:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhBZChY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Feb 2021 21:37:24 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E89C061574
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 18:36:44 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id w21so9233399edc.7
        for <linux-ext4@vger.kernel.org>; Thu, 25 Feb 2021 18:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OYeh8Xf00a0hwCdFk1WYCJDHQ8XtX2AeWUe3EXNPZ0w=;
        b=KjdySDBbcaqh5y6Bufd7OTI9f3AS0kwzun/O2xcJ9wxVtUgiRuirsm9WKR56C/y3YU
         bBN/hEUjAI6cT9nmRE26CeCvq3mqZwP8joxGo7S6mibZ/p4gPt+7ke3lzxx+l+8QHzCK
         4DM0tFQsaNPewh5G4b07L0neHSFwiBEvd/bq85kxm3HAm4o97nnPSgE0gvZEfMcInFUB
         f327KNUX90BDBkh0YecjfNaHJ21fIjOCxcxcUAB8Os8wAm9YCsrGQmRyNXGUa2ixBGne
         2CzY4jwC455IpM5LdPj9qU0zH4N46Ma6wEifFf3ufgXVFmrJ8MLy63K7yGskEB9jDvmb
         gSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OYeh8Xf00a0hwCdFk1WYCJDHQ8XtX2AeWUe3EXNPZ0w=;
        b=Xukb1gdnBWnynNPSsrSc+qUmrlW+afmgIg7MSQ+LJq9tHUExvNnyDV2TYDuTprfQuV
         xwJujFeT6QZzuA80uo26D0LZxI8/P+taL2+Qh3+C+2yMKOd3Z0vUD9X3Hgq5z9wQNmy2
         b6uJquKS7hXnJ+y7OutOXy46zDyfhc4sRvCEfON1R5NNXj8PE3L+OvYykoqNuV3VbNh3
         P9Fc+q2bDwr1cFWnZgfuOvmEHduauf5NKbVQDxWHEwnym2K0J1BQ6xkKTFXF14mcAE2W
         N6JhSgxOvkF66h8auiRNsXcUbF6t5I8symDKlDO3rdapM1IgjrY4+3RAphX3iBDLBahy
         t5CA==
X-Gm-Message-State: AOAM530foSLsPleCCqlVWA5OuUUbAd/Pa/rqFpOpKXOctwd1pHljyrf0
        DU2uLzl2BjoAOATELgHH1HkdyloPwo3p3cUPPZti6pw67B8=
X-Google-Smtp-Source: ABdhPJyrH5+x5LDJL0VS83UR+Y7kobz+hPvirue7KyglTjFACKCYoyAFtQUIN1SL/OfrzJqGU+KG6hObgWHGEjRQzw0=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr935377edt.382.1614307001818;
 Thu, 25 Feb 2021 18:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-4-harshadshirwadkar@gmail.com> <1029810C-1D3F-45ED-9EF3-EF85C31AE81B@gmail.com>
In-Reply-To: <1029810C-1D3F-45ED-9EF3-EF85C31AE81B@gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 25 Feb 2021 18:36:30 -0800
Message-ID: <CAD+ocbwY8J2+SPznXSz9+xNEwCaewo_aF45vJQmYZThHhZ9QJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ext4: add MB_NUM_ORDERS macro
To:     =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Artem for pointing that out. I'll fix this in V3.

- Harshad

On Tue, Feb 16, 2021 at 2:45 AM =D0=91=D0=BB=D0=B0=D0=B3=D0=BE=D0=B4=D0=B0=
=D1=80=D0=B5=D0=BD=D0=BA=D0=BE =D0=90=D1=80=D1=82=D1=91=D0=BC
<artem.blagodarenko@gmail.com> wrote:
>
> Hello Harshad,
>
> I believe there are two places yet there number could be changed to the m=
acros
>
> fs/ext4/mballoc.c <<ext4_mb_init_cache>>
>              (sb->s_blocksize_bits+2));
>
> fs/ext4/mballoc.c <<ext4_mb_good_group>>
> if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)
>
> Best regards,
> Artem Blagodarenko
>
> > On 9 Feb 2021, at 23:28, Harshad Shirwadkar <harshadshirwadkar@gmail.co=
m> wrote:
> >
> > A few arrays in mballoc.c use the total number of valid orders as
> > their size. Currently, this value is set as "sb->s_blocksize_bits +
> > 2". This makes code harder to read. So, instead add a new macro
> > MB_NUM_ORDERS(sb) to make the code more readable.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > ---
> > fs/ext4/mballoc.c | 15 ++++++++-------
> > fs/ext4/mballoc.h |  5 +++++
> > 2 files changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index fffd0770e930..b7f25120547d 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, s=
truct ext4_group_info *grp)
> >
> >       grp->bb_largest_free_order =3D -1; /* uninit */
> >
> > -     bits =3D sb->s_blocksize_bits + 1;
> > +     bits =3D MB_NUM_ORDERS(sb) - 1;
> >       for (i =3D bits; i >=3D 0; i--) {
> >               if (grp->bb_counters[i] > 0) {
> >                       grp->bb_largest_free_order =3D i;
> > @@ -1928,7 +1928,7 @@ void ext4_mb_simple_scan_group(struct ext4_alloca=
tion_context *ac,
> >       int max;
> >
> >       BUG_ON(ac->ac_2order <=3D 0);
> > -     for (i =3D ac->ac_2order; i <=3D sb->s_blocksize_bits + 1; i++) {
> > +     for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
> >               if (grp->bb_counters[i] =3D=3D 0)
> >                       continue;
> >
> > @@ -2314,13 +2314,13 @@ ext4_mb_regular_allocator(struct ext4_allocatio=
n_context *ac)
> >        * We also support searching for power-of-two requests only for
> >        * requests upto maximum buddy size we have constructed.
> >        */
> > -     if (i >=3D sbi->s_mb_order2_reqs && i <=3D sb->s_blocksize_bits +=
 2) {
> > +     if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) {
> >               /*
> >                * This should tell if fe_len is exactly power of 2
> >                */
> >               if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) =3D=3D 0)
> >                       ac->ac_2order =3D array_index_nospec(i - 1,
> > -                                                        sb->s_blocksiz=
e_bits + 2);
> > +                                                        MB_NUM_ORDERS(=
sb));
> >       }
> >
> >       /* if stream allocation is enabled, use global goal */
> > @@ -2850,7 +2850,7 @@ int ext4_mb_init(struct super_block *sb)
> >       unsigned max;
> >       int ret;
> >
> > -     i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
> > +     i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
> >
> >       sbi->s_mb_offsets =3D kmalloc(i, GFP_KERNEL);
> >       if (sbi->s_mb_offsets =3D=3D NULL) {
> > @@ -2858,7 +2858,7 @@ int ext4_mb_init(struct super_block *sb)
> >               goto out;
> >       }
> >
> > -     i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
> > +     i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
> >       sbi->s_mb_maxs =3D kmalloc(i, GFP_KERNEL);
> >       if (sbi->s_mb_maxs =3D=3D NULL) {
> >               ret =3D -ENOMEM;
> > @@ -2884,7 +2884,8 @@ int ext4_mb_init(struct super_block *sb)
> >               offset_incr =3D offset_incr >> 1;
> >               max =3D max >> 1;
> >               i++;
> > -     } while (i <=3D sb->s_blocksize_bits + 1);
> > +     } while (i < MB_NUM_ORDERS(sb));
> > +
> >
> >       spin_lock_init(&sbi->s_md_lock);
> >       sbi->s_mb_free_pending =3D 0;
> > diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> > index 7597330dbdf8..02861406932f 100644
> > --- a/fs/ext4/mballoc.h
> > +++ b/fs/ext4/mballoc.h
> > @@ -78,6 +78,11 @@
> >  */
> > #define MB_DEFAULT_MAX_INODE_PREALLOC 512
> >
> > +/*
> > + * Number of valid buddy orders
> > + */
> > +#define MB_NUM_ORDERS(sb)            ((sb)->s_blocksize_bits + 2)
> > +
> > struct ext4_free_data {
> >       /* this links the free block information from sb_info */
> >       struct list_head                efd_list;
> > --
> > 2.30.0.478.g8a0d178c01-goog
> >
>
