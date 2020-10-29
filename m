Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A932D29F915
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Oct 2020 00:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgJ2X2r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Oct 2020 19:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJ2X2r (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Oct 2020 19:28:47 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37857C0613D2
        for <linux-ext4@vger.kernel.org>; Thu, 29 Oct 2020 16:28:47 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id w27so6173400ejb.3
        for <linux-ext4@vger.kernel.org>; Thu, 29 Oct 2020 16:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=znmixTNCpdDe7752le4rNpX5igIl9cr3leY/huuxzgI=;
        b=aSHPeasN0O9NGYDUNa1LCj00y1oG0pkOGufhEfms5p8cMAaAWHBIKYvQEVLuAdp6OI
         vbLG6gKcDZkGcnXr4v4zJ+518UQHQoIpAImEuFGKNr4W7nXQsyGc+gX4s9gXtEMecpMs
         XqwmMeGVer3miA5FxTHCLyO879H44SlmYywoR8G6gAAxbQqCNtgRYRtvQ/4957zvTt4v
         QduGJeeECDT9r5w47fkOyXEaraalq7wQ+P1KK2SN1PsZIRS27COUhmKRGW/jucOpbJ1b
         4LkHd2LHtO8SpNmc4bkNoIOUQg3ohV3VXkqfWXUtbBnCPXcAQV0Cv7c9Plk7SBARx6S9
         MSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=znmixTNCpdDe7752le4rNpX5igIl9cr3leY/huuxzgI=;
        b=AXk5Dcm/GkmDUk0fzjx5D7vdienhQagm+4UGkCNUXrFiQJwkh3be9uBAX0GDCc31j8
         16DvFzxH/wrwa8RSXYZHJTFs4JridkM4CW775MR7QkzbTSQXBuXezYYAt0BybEqIIDvY
         en4wWjpXt4I8JizO+Cp7ktejKptVBo7kMitA75d1fO0cTdUpJSXGga5TeTORVS9uOodi
         mZNogwRJQ1V5zL08qJUASrUQTacRPtN+LIEV1JT3uEtbdYOJw4xSGANWL0fjwg9N+FBL
         kEJghRVwB1aK4upYZ+PzEGYNue8KCYW8/SsYb0O8Uhf+zCHxa+qIt/txCwUKDVHluWnz
         8dxg==
X-Gm-Message-State: AOAM53312mexhEtFtyf/mDlSEAKtgtEDHSMLufU/HBcj+psJBPE1a6Up
        ifVR2zS2TDW6g/zKxcO3cPYK85t5hjvoKh4y5g5Ta18SVKqfWg==
X-Google-Smtp-Source: ABdhPJyR4lo+GDUw4ZC2LY6YslQ4ioHZfICgZkb+622CEVl4Dx/ONJXmBhGhYRjyN8bn1Vkgm30aqR5Tl04dM+NeP0g=
X-Received: by 2002:a17:907:20d6:: with SMTP id qq22mr6286880ejb.187.1604014125796;
 Thu, 29 Oct 2020 16:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201015203802.3597742-1-harshadshirwadkar@gmail.com>
 <20201015203802.3597742-4-harshadshirwadkar@gmail.com> <20201021200039.GD25702@quack2.suse.cz>
In-Reply-To: <20201021200039.GD25702@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 29 Oct 2020 16:28:34 -0700
Message-ID: <CAD+ocbwGE4SHPZ9eaZx6cW9cWbtOSVKOQtfWVHEkaxK370QHbw@mail.gmail.com>
Subject: Re: [PATCH v10 3/9] ext4 / jbd2: add fast commit initialization
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 1:00 PM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 15-10-20 13:37:55, Harshad Shirwadkar wrote:
> > diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> > new file mode 100644
> > index 000000000000..8362bf5e6e00
> > --- /dev/null
> > +++ b/fs/ext4/fast_commit.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +#ifndef __FAST_COMMIT_H__
> > +#define __FAST_COMMIT_H__
> > +
> > +/* Number of blocks in journal area to allocate for fast commits */
> > +#define EXT4_NUM_FC_BLKS             256
>
> Maybe this could be tunable (at least during mkfs but maybe also with
> a mount option)? I can imagine some people will want to tune this for their
> workloads similarly as they tune the journal size. And although current
> minimal journal size is 1024, I'd be actually calmer if jbd2 properly
> checked from the start that requested fastcommit area isn't too big for the
> journal...
Sounds good, commit e029c5f2798720b463e8df0e184a4d1036311b43 ("ext4:
make num of fast commit blocks configurable") fixes this. With that
commit, now we have reserved a field in the superblock that tells the
number of fast commit blocks. Now that this is configurable, I wonder
if there's any point in giving the file system the ability to
configure the number of blocks? In other words, I'm thinking of
dropping jbd2_fc_init() which takes the number of fast commit blocks
as an argument and just solely rely on the value found in the journal
superblock. New mke2fs will allow you to set the number of fast commit
blocks in JBD2 superblock. Any objections on that?
>
> > +
> > +#endif /* __FAST_COMMIT_H__ */
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 70256a240442..23bf55057fc2 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5170,6 +5170,7 @@ static void ext4_init_journal_params(struct super_block *sb, journal_t *journal)
> >       journal->j_commit_interval = sbi->s_commit_interval;
> >       journal->j_min_batch_time = sbi->s_min_batch_time;
> >       journal->j_max_batch_time = sbi->s_max_batch_time;
> > +     ext4_fc_init(sb, journal);
> >
> >       write_lock(&journal->j_state_lock);
> >       if (test_opt(sb, BARRIER))
> > diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> > index c0600405e7a2..4497bfbac527 100644
> > --- a/fs/jbd2/journal.c
> > +++ b/fs/jbd2/journal.c
> > @@ -1181,6 +1181,14 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >       if (!journal->j_wbuf)
> >               goto err_cleanup;
> >
> > +     if (journal->j_fc_wbufsize > 0) {
> > +             journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > +                                     sizeof(struct buffer_head *),
> > +                                     GFP_KERNEL);
> > +             if (!journal->j_fc_wbuf)
> > +                     goto err_cleanup;
> > +     }
> > +
>
> Hum, but journal_init_common() gets called e.g. through
> jbd2_journal_init_inode() before ext4_init_journal_params() sets
> j_fc_wbufsize? How is this supposed to work?
I realized that this part never really gets executed in the current
code. That's because when journal_init_common is called, j_fc_wbufsize
is not set. It only gets set later, so this could have been dropped.
>
> >       bh = getblk_unmovable(journal->j_dev, start, journal->j_blocksize);
> >       if (!bh) {
> >               pr_err("%s: Cannot get buffer for journal superblock\n",
> > @@ -1194,11 +1202,23 @@ static journal_t *journal_init_common(struct block_device *bdev,
> >
> >  err_cleanup:
> >       kfree(journal->j_wbuf);
> > +     kfree(journal->j_fc_wbuf);
> >       jbd2_journal_destroy_revoke(journal);
> >       kfree(journal);
> >       return NULL;
> >  }
> >
> > +int jbd2_fc_init(journal_t *journal, int num_fc_blks)
> > +{
> > +     journal->j_fc_wbufsize = num_fc_blks;
> > +     journal->j_fc_wbuf = kmalloc_array(journal->j_fc_wbufsize,
> > +                             sizeof(struct buffer_head *), GFP_KERNEL);
> > +     if (!journal->j_fc_wbuf)
> > +             return -ENOMEM;
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(jbd2_fc_init);
>
> Hum, probably I'd find it less error prone to have size of fastcommit area
> as an argument to jbd2_journal_init_dev() and jbd2_journal_init_inode().
> That way we are sure journal parameters are initialized correctly from the
> start. OTOH number of fastcommit blocks in the journal as we load it from
> the disk and need to replay could be different from the number of
> fastcommit blocks requested now (once we allow tuning) and this can get
> confusing pretty fast. So maybe we just set number of fastcommit blocks in
> journal_init_common() and then perform setup of everything else in
> journal_reset()?
Please see my comment above. If we just rely on the value found in the
superblock, then there is no question of FS requesting a different
number of FC blocks than what we find in journal superblock. If we go
that route, then we can set the default value of j_fc_wbufsize in
journal_init_common().  Whenever we journal superblock after that, we
can override the default value with what we find in the superblock.
>
> > +
> >  /* jbd2_journal_init_dev and jbd2_journal_init_inode:
> >   *
> >   * Create a journal structure assigned some fixed set of disk blocks to
> > @@ -1316,11 +1336,20 @@ static int journal_reset(journal_t *journal)
> >       }
> >
> >       journal->j_first = first;
> > -     journal->j_last = last;
> >
> > -     journal->j_head = first;
> > -     journal->j_tail = first;
> > -     journal->j_free = last - first;
> > +     if (jbd2_has_feature_fast_commit(journal) &&
> > +         journal->j_fc_wbufsize > 0) {
> > +             journal->j_fc_last = last;
> > +             journal->j_last = last - journal->j_fc_wbufsize;
> > +             journal->j_fc_first = journal->j_last + 1;
> > +             journal->j_fc_off = 0;
> > +     } else {
> > +             journal->j_last = last;
> > +     }
> > +
> > +     journal->j_head = journal->j_first;
> > +     journal->j_tail = journal->j_first;
> > +     journal->j_free = journal->j_last - journal->j_first;
>
> So the journal size is effectively shorter by j_fc_wbufsize. But this has
> also impact on maximum transaction size we can allow for the journal and
> related parameters (generally derived from j_maxlen you don't touch).
> So this needs to get fixed. Maybe just setting j_maxlen lower is the
> easiest but then please change the comment at its definition to mention in
> memory value is without fastcommit blocks. Or just create new journal
> parameter for the size of area usable for normal commits.
Ack, will do

Thanks,
Harshad.

>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
