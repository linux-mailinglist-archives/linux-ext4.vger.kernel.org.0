Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9878B352DE5
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 18:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbhDBQqn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 12:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhDBQqi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 12:46:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5EBC0613E6
        for <linux-ext4@vger.kernel.org>; Fri,  2 Apr 2021 09:46:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b16so5986919eds.7
        for <linux-ext4@vger.kernel.org>; Fri, 02 Apr 2021 09:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IEm28Suw72x+agQvgRp5hRjnSYv7/re+fsdw9ki6Nsw=;
        b=RHPR5ZekSlvcin20ER8g8+eeP/P0Ylb6IoGt+Wa97gPmtjIXOF3+5PqU7pLGvcC0Ah
         eYkMhYWxMrZDSHSGkouQLOCB6HAe4zWhdZmQ+TMEm1U+mln5TLLcGc2SK+djzVo8IEDR
         PJTkKafCWuLWCARtkIG+t4m0DYWp5QkYOlpfCt0//jVPrV7Qbao+Uds5uX+xgjUhLg6V
         VS3rqo9ovLNYJcmx9nA3G5ruZ+A/X/vSkMrBOjyBS1RlKGMWAY9R9HCpbjSN7+Uxu5/l
         P+AtUDxN4UoORgxMtJfhWY3FdthaoA2s46dQ1arob/B6peaY1lApwFPIHUZeCQ3xpiS1
         Flyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IEm28Suw72x+agQvgRp5hRjnSYv7/re+fsdw9ki6Nsw=;
        b=aga8iDQk5AA+jhAmdqSH3gqGyFgU3VhRMm8fwPEn4KeyIxB0mlQQyFq6fW4eqho6VW
         di6Bm7nbsw+MZe1sJIGKwV+dXT2VudIrU4IqtniB17kXrD5vIt2GQ45As3dCILHmWsqn
         gDe4e29BE7q7MVVmiECaplyWYTcJwqLiKb/sMuIf50xydmBo9uATZ+7zymHeyr3TtHWD
         Ci3YGbzt6/M0axAVFdN7nIUkZgu6sb/EefbahmdlwLFW66DP0A/TpTr6ogqD1v0mK4bI
         wDiRl8RmbTMrSqVMk+NCNd0CquCidiBOOdwcxOieRhNCtkbhiXN0rgOqN32FwT30QtX9
         qXtQ==
X-Gm-Message-State: AOAM530vCoQFXGFe950DGbB3kRAxkLeat5qOW3/v2fBn6gEWja28z0k1
        kSbrFpQ3tz3pYXJV5uGvRC0bTlgq1H1RVI+aVaE=
X-Google-Smtp-Source: ABdhPJxBduNsZwbVw7DURTbYB8UhP3SwuGdbRFB8Tf6Y3aOeIIf2zETplSYZB/d1MkZdXREkXZkQ/88sPSifmb3dv94=
X-Received: by 2002:aa7:d813:: with SMTP id v19mr16304293edq.213.1617381993938;
 Fri, 02 Apr 2021 09:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210401172129.189766-8-harshadshirwadkar@gmail.com> <5815C46F-D210-4545-9610-136F68E93B66@dilger.ca>
In-Reply-To: <5815C46F-D210-4545-9610-136F68E93B66@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 2 Apr 2021 09:46:22 -0700
Message-ID: <CAD+ocbwhQva2d7H2E=67_aSSzr0VkR+xiBjEmBTb4ENggvU6Hw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] ext4: make prefetch_block_bitmaps default
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for taking a look!

On Thu, Apr 1, 2021 at 10:16 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Apr 1, 2021, at 11:45, Harshad Shirwadkar <harshadshirwadkar@gmail.com=
> wrote:
> >
> > =EF=BB=BFBlock bitmap prefetching is needed for these allocator optimiz=
ation
> > data structures to get populated and provide better group scanning
> > order. So, turn it on bu default. prefetch_block_bitmaps mount option
> > is now marked as removed and a new option no_prefetch_block_bitmaps is
> > added to disable block bitmap prefetching.
>
> This makes it more difficult to change between an old kernel and a new on=
e
> using this option. It would be better to keep prefetch_block_bitmaps to t=
urn
> the option on (not harmful if it is already on), and no_* turn it off.
How so? This patch doesn't get rid of the prefetch_block_bitmaps mount
option, it just marks it as "removed". So, you can still pass
"prefetch_block_bitmaps" mount option and get the prefetching
behavior, the only difference is that you'll get an additional kernel
message saying that "ignoring removed mount option
prefetch_block_bitmaps", which I thought is good since looking at that
message, users will eventually remove that mount option from their
mount arguments.

Thanks,
Harshad
>
> Cheers, Andreas
>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > ---
> > fs/ext4/ext4.h  |  2 +-
> > fs/ext4/super.c | 15 ++++++++-------
> > 2 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 9a5afe9d2310..20c757f711e7 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -1227,7 +1227,7 @@ struct ext4_inode_info {
> > #define EXT4_MOUNT_JOURNAL_CHECKSUM    0x800000 /* Journal checksums */
> > #define EXT4_MOUNT_JOURNAL_ASYNC_COMMIT    0x1000000 /* Journal Async C=
ommit */
> > #define EXT4_MOUNT_WARN_ON_ERROR    0x2000000 /* Trigger WARN_ON on err=
or */
> > -#define EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS 0x4000000
> > +#define EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS 0x4000000
> > #define EXT4_MOUNT_DELALLOC        0x8000000 /* Delalloc support */
> > #define EXT4_MOUNT_DATA_ERR_ABORT    0x10000000 /* Abort on file data w=
rite */
> > #define EXT4_MOUNT_BLOCK_VALIDITY    0x20000000 /* Block validity check=
ing */
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 6116640081c0..cec0fb07916b 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -1687,7 +1687,7 @@ enum {
> >    Opt_dioread_nolock, Opt_dioread_lock,
> >    Opt_discard, Opt_nodiscard, Opt_init_itable, Opt_noinit_itable,
> >    Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
> > -    Opt_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> > +    Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
> > #ifdef CONFIG_EXT4_DEBUG
> >    Opt_fc_debug_max_replay, Opt_fc_debug_force
> > #endif
> > @@ -1787,7 +1787,8 @@ static const match_table_t tokens =3D {
> >    {Opt_inlinecrypt, "inlinecrypt"},
> >    {Opt_nombcache, "nombcache"},
> >    {Opt_nombcache, "no_mbcache"},    /* for backward compatibility */
> > -    {Opt_prefetch_block_bitmaps, "prefetch_block_bitmaps"},
> > +    {Opt_removed, "prefetch_block_bitmaps"},
> > +    {Opt_no_prefetch_block_bitmaps, "no_prefetch_block_bitmaps"},
> >    {Opt_mb_optimize_scan, "mb_optimize_scan=3D%d"},
> >    {Opt_removed, "check=3Dnone"},    /* mount option from ext2/3 */
> >    {Opt_removed, "nocheck"},    /* mount option from ext2/3 */
> > @@ -2009,7 +2010,7 @@ static const struct mount_opts {
> >    {Opt_max_dir_size_kb, 0, MOPT_GTE0},
> >    {Opt_test_dummy_encryption, 0, MOPT_STRING},
> >    {Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
> > -    {Opt_prefetch_block_bitmaps, EXT4_MOUNT_PREFETCH_BLOCK_BITMAPS,
> > +    {Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMA=
PS,
> >     MOPT_SET},
> >    {Opt_mb_optimize_scan, EXT4_MOUNT2_MB_OPTIMIZE_SCAN, MOPT_GTE0},
> > #ifdef CONFIG_EXT4_DEBUG
> > @@ -3706,11 +3707,11 @@ static struct ext4_li_request *ext4_li_request_=
new(struct super_block *sb,
> >
> >    elr->lr_super =3D sb;
> >    elr->lr_first_not_zeroed =3D start;
> > -    if (test_opt(sb, PREFETCH_BLOCK_BITMAPS))
> > -        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> > -    else {
> > +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS)) {
> >        elr->lr_mode =3D EXT4_LI_MODE_ITABLE;
> >        elr->lr_next_group =3D start;
> > +    } else {
> > +        elr->lr_mode =3D EXT4_LI_MODE_PREFETCH_BBITMAP;
> >    }
> >
> >    /*
> > @@ -3741,7 +3742,7 @@ int ext4_register_li_request(struct super_block *=
sb,
> >        goto out;
> >    }
> >
> > -    if (!test_opt(sb, PREFETCH_BLOCK_BITMAPS) &&
> > +    if (test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS) &&
> >        (first_not_zeroed =3D=3D ngroups || sb_rdonly(sb) ||
> >         !test_opt(sb, INIT_INODE_TABLE)))
> >        goto out;
> > --
> > 2.31.0.291.g576ba9dcdaf-goog
> >
