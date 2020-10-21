Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D628929518F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 19:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503539AbgJURcB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 13:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503534AbgJURcA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 13:32:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857B8C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 10:32:00 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so4416243ejb.6
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 10:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNQ0VApk2L4HcG7sdyimN+6+j3z7XbNrmDhWSBT89Ck=;
        b=p0Pyyvszs1qPGfEXHKsJKXsZKoZ0rktydR3weTX7QQy9Vemqh0rD3u2m6aUr4MZCOO
         61FmxzSOTukfxIC+GoCOKVteqtPxHvVqn+cF2lzsqTIPZC2g0IMrXnOAte7lpAKO6V4O
         cI//vA1f5nIaF5SV4z6kqPxvK3WVjou8hiw6f80xAVjp5rlfa4wjG9SnpZxDeuLHlJXP
         Q01z/WJ/GKLXsKMdXEA0SFlaqwmUPWngh2cABtj+ePUAqci0BLZ9aw7NFNsHONsIJSM9
         WEmZl4ENAZOY8s6z46KfyWspIzKxm9n8Gzu9oiaObX83ooFpMNYSdeber/BbeBFM2Byo
         5pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNQ0VApk2L4HcG7sdyimN+6+j3z7XbNrmDhWSBT89Ck=;
        b=V00ySeKnlpbRhTSs2ltWqnQPuy7W//ed7rOhkIRMKiiD/0Nr9FiDLIq+m6mm/waBgk
         ZdXzdGC/iuTWJv/Pc5SKSSNeJfUW60d1b5jfiTtIAm2v1c3ThjOmfLlKgdjuXcH6sMHP
         ZtFOb+qlMpmAghIxLpH2vICRbbPpHVSzjnCWNyCVvf7H4vlq3Ke5S0/Tvuy4RHMD9UzS
         pfT+a61uPTU6i+h7rafLvTvqCNsWZ+AOB3wVr7B3imX2dzXu3N4T5lhiIWOS5Wqw3knF
         04MpmPFKP3vOQYhhIxoB6kVKUWm/xNAEGculuFvYjtGRRGmvoVmWQM2p/WBLWA9UAK2Y
         6GgA==
X-Gm-Message-State: AOAM531pAxRy6KP+XJ6hAoPftI2eRp/AP1pUpRCE9zetEr41oUFK+2Vj
        llB/4zWMPOplips7no7jDQ51YR6twwo7mhNaq2g=
X-Google-Smtp-Source: ABdhPJzqny3E86eeCW8fXwlUKQjv+j9cQ8oF6e+aUI3/VJGlPbDDRIZnO2y55wkfSAFEDjnEIo+HM/HRY9eU+BqCq7U=
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr4455363ejm.223.1603301519189;
 Wed, 21 Oct 2020 10:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-3-harshadshirwadkar@gmail.com> <20201021161814.GC25702@quack2.suse.cz>
In-Reply-To: <20201021161814.GC25702@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 21 Oct 2020 10:31:48 -0700
Message-ID: <CAD+ocbyCs4DpcCwEtrnh-aodK-p+SWybuKw+ebUrCvKS0uMDaQ@mail.gmail.com>
Subject: Re: [PATCH v10 2/9] ext4: add fast_commit feature and handling for
 extended mount options
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 9:18 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-10-20 13:37:54, Harshad Shirwadkar wrote:
> > We are running out of mount option bits. Add handling for using
> > s_mount_opt2. Add ext4 and jbd2 fast commit feature flag and also add
> > ability to turn off the fast commit feature in Ext4.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> >  fs/ext4/ext4.h       |  4 ++++
> >  fs/ext4/super.c      | 27 ++++++++++++++++++++++-----
> >  include/linux/jbd2.h |  5 ++++-
> >  3 files changed, 30 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 1879531a119f..02d7dc378505 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1213,6 +1213,8 @@ struct ext4_inode_info {
> >  #define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM        0x00000008 /* User explicitly
> >                                               specified journal checksum */
> >
> > +#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT      0x00000010 /* Journal fast commit */
> > +
> >  #define clear_opt(sb, opt)           EXT4_SB(sb)->s_mount_opt &= \
> >                                               ~EXT4_MOUNT_##opt
> >  #define set_opt(sb, opt)             EXT4_SB(sb)->s_mount_opt |= \
> > @@ -1813,6 +1815,7 @@ static inline bool ext4_verity_in_progress(struct inode *inode)
> >  #define EXT4_FEATURE_COMPAT_RESIZE_INODE     0x0010
> >  #define EXT4_FEATURE_COMPAT_DIR_INDEX                0x0020
> >  #define EXT4_FEATURE_COMPAT_SPARSE_SUPER2    0x0200
> > +#define EXT4_FEATURE_COMPAT_FAST_COMMIT              0x0400
> >  #define EXT4_FEATURE_COMPAT_STABLE_INODES    0x0800
>
> Is fast commit really a compat feature? IMO if there are fast commits
> stored in the journal, the filesystem is actually incompatible with the
> old kernels because data we guranteed to be permanenly stored may be
> invisible for the old kernel (since it won't replay fastcommit
> transactions).
>
> ...
>
> Oh, now I see that the journal FAST_COMMIT is actually incompat. So what's
> the point of compat ext4 feature with incompat JBD2 feature?
So having fast commits enabled on an ext4 file system doesn't
immediately make it incompatible with the older kernels. FS becomes
incompatible only if there are fast commits blocks that are stored in
the journal. So, one of the tricks that this patchset does is on a
clean unmount, since it's guaranteed that there are no fast commit
blocks in journal, we clear out the JBD2 incompat flag and preserve
the compat flag in ext4. So, we can think of ext4 compat flag as "FS
will try fast commits when possible" while jbd2 incompat flag as
"There are fast commits blocks present in the journal". Does that make
sense?
>
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 901c1c938276..70256a240442 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1709,7 +1709,7 @@ enum {
> >       Opt_dioread_nolock, Opt_dioread_lock,
> >       Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> >       Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> > -     Opt_prefetch_block_bitmaps,
> > +     Opt_prefetch_block_bitmaps, Opt_no_fc,
>
> It would be more consistent to use a name 'Opt_nofc' and IMHO 'fc' is
> really too short an ambiguous. I agree "nofastcommit" is somewhat long but
> still OK and much more descriptive...
Ack
>
> >  };
> >
> >  static const match_table_t tokens = {
> > @@ -1796,6 +1796,7 @@ static const match_table_t tokens = {
> >       {Opt_init_itable, "init_itable=%u"},
> >       {Opt_init_itable, "init_itable"},
> >       {Opt_noinit_itable, "noinit_itable"},
> > +     {Opt_no_fc, "no_fc"},
>
> And here "nofastcommit", or perhaps "nofast_commit".
Ack

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
