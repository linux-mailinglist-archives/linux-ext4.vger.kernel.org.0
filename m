Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F384881C2
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jan 2022 07:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiAHGFc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 8 Jan 2022 01:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiAHGFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 8 Jan 2022 01:05:32 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE25DC061574;
        Fri,  7 Jan 2022 22:05:31 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j6so30206922edw.12;
        Fri, 07 Jan 2022 22:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKy0Ld0t/rb55huiDujNkhyOqnsFdqUh2fOUZOkxN48=;
        b=ElRDvdPLDhCghbXgOzk6lq0DvtAMSlweI65lMQ4TxnkMwgDT8qVmAz8Gz1ZcwPiXDZ
         OgGx76dYF5k5etnZL964lEtp0RFYI+0bSL1U8JsSbJIUYJxofeYy0nmAFWSft836JsBs
         EYZcEMpcjzeqSSS64G3L7mCdso3rRvofOOgCbUTCOxsjMUR8G4sEXSL9uOB26uqccwgP
         8dShbjYVR8iMnvgsUFiDkyDltok/kMDA/wR/+txPjih1D1HcLpk0DIp3xSEAcCwkRLpl
         xGZdAF8BF3HZ0eR2h6xUQCl5j3g60VsSVEu8WQRJ9DYffDDFAIANaGD8BkaOH9r7wXQ4
         cfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKy0Ld0t/rb55huiDujNkhyOqnsFdqUh2fOUZOkxN48=;
        b=XUit0u0q8Ml4Vaz5ETtCWJaiFvSHXh5ISlmJpNYcZcrqWX7FB1z0EuyNUqaeyvLg32
         rKFW6MrPiR3G0LqR1jLJomk2kGFBroCcIvIQuPEk0V0KBysohGxTGpGnvbySSwgzyqrJ
         +8d1kPrcytCKevNZ6/5S7q8ZCm/tdguGeEt0QKBeKH+K5PowmT8fWirYfNUt5pHb76M3
         wnimifkUR7rqJimOFXouUXhV57TD+gDmOTBhDGo3nXk847fEat/3ICRjA17GTmomzlcL
         eZeupIOxc+VeTK37m2iH1PC7x6GZSRCNj8Ga6aN3H3zR8B9iHYkZ/J74rGe9pY2X4kfG
         6Pqw==
X-Gm-Message-State: AOAM533xcqFEThay9o7EOSCNRLEYBi+yxQMzwoyCq2g4IPYdu8rDawZk
        9p/wmAASH2iC10JW1Y03wWeRs19uaQhCa9s8tLw=
X-Google-Smtp-Source: ABdhPJy2T/2xdEWvLdKJc3r4bh7gu318iPxRp81+gvESMiy7CEHxte4tHO54XPF/7TWqoNokTRo6zMZTBaLG4Jw2l60=
X-Received: by 2002:a05:6402:4241:: with SMTP id g1mr65579080edb.11.1641621930273;
 Fri, 07 Jan 2022 22:05:30 -0800 (PST)
MIME-Version: 1.0
References: <20220106024518.8161-1-yinxin.x@bytedance.com> <20220106024518.8161-2-yinxin.x@bytedance.com>
 <CAD+ocbx2e06YoESJM7m5ra-6so0ijWsYyN1L1ZFTXqxedMMoNw@mail.gmail.com> <CAK896s4EgEPU4FyyXczW79uFhVDido-Cwc=X-6jJ3kz2LXwBqw@mail.gmail.com>
In-Reply-To: <CAK896s4EgEPU4FyyXczW79uFhVDido-Cwc=X-6jJ3kz2LXwBqw@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Fri, 7 Jan 2022 22:05:19 -0800
Message-ID: <CAD+ocbzn4gopc_ohSe66WxiZ-yz4e=XKF+_tHTVQ6JWXd_T8kA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ext4: prevent used blocks from being
 allocated during fast commit replay
To:     Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ah, I see okay. Yeah, that makes sense. We do need to update
fc_regions_valid for every addition during the replay phase. I think
it may be helpful to add some comments describing this behavior in the
code. But other than that, I think what you're doing is fine.

Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

On Fri, Jan 7, 2022 at 6:09 PM Xin Yin <yinxin.x@bytedance.com> wrote:
>
> On Sat, Jan 8, 2022 at 4:26 AM harshad shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > On Wed, Jan 5, 2022 at 6:45 PM Xin Yin <yinxin.x@bytedance.com> wrote:
> > >
> > > during fast commit replay procedure, we clear inode blocks bitmap in
> > > ext4_ext_clear_bb(), this may cause ext4_mb_new_blocks_simple() allocate
> > > blocks still in use.
> > >
> > > make ext4_fc_record_regions() also record physical disk regions used by
> > > inodes during replay procedure. Then ext4_mb_new_blocks_simple() can
> > > excludes these blocks in use.
> > >
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > > ---
> > >  fs/ext4/ext4.h        |  2 ++
> > >  fs/ext4/extents.c     |  4 ++++
> > >  fs/ext4/fast_commit.c | 11 ++++++++---
> > >  3 files changed, 14 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > index 82fa51d6f145..7b0686758691 100644
> > > --- a/fs/ext4/ext4.h
> > > +++ b/fs/ext4/ext4.h
> > > @@ -2932,6 +2932,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
> > >  void ext4_fc_replay_cleanup(struct super_block *sb);
> > >  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
> > >  int __init ext4_fc_init_dentry_cache(void);
> > > +int ext4_fc_record_regions(struct super_block *sb, int ino,
> > > +                    ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay);
> > >
> > >  /* mballoc.c */
> > >  extern const struct seq_operations ext4_mb_seq_groups_ops;
> > > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > > index c3e76a5de661..9b6c76629c93 100644
> > > --- a/fs/ext4/extents.c
> > > +++ b/fs/ext4/extents.c
> > > @@ -6096,11 +6096,15 @@ int ext4_ext_clear_bb(struct inode *inode)
> > >
> > >                                         ext4_mb_mark_bb(inode->i_sb,
> > >                                                         path[j].p_block, 1, 0);
> > > +                                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> > > +                                                       0, path[j].p_block, 1, 1);
> > >                                 }
> > >                                 ext4_ext_drop_refs(path);
> > >                                 kfree(path);
> > >                         }
> > >                         ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> > > +                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> > > +                                       map.m_lblk, map.m_pblk, map.m_len, 1);
> > >                 }
> > >                 cur = cur + map.m_len;
> > >         }
> > > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > > index 23d13983a281..f0cd20f5fe5e 100644
> > > --- a/fs/ext4/fast_commit.c
> > > +++ b/fs/ext4/fast_commit.c
> > > @@ -1567,13 +1567,15 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
> > >   * Record physical disk regions which are in use as per fast commit area. Our
> > >   * simple replay phase allocator excludes these regions from allocation.
> > >   */
> > > -static int ext4_fc_record_regions(struct super_block *sb, int ino,
> > > -               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
> > > +int ext4_fc_record_regions(struct super_block *sb, int ino,
> > > +               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay)
> > Can you explain a bit why this replay parameter is needed here? This
> > function simply reallocs the regions array if it doesn't have enough
> > space. I am not sure why we need to change that behavior.
>
> ext4_fc_record_regions() originally only used during scan phase,  and
> set fc_regions_valid = fc_regions_use when getting a TAIL tag. Now we
> also use it during the replay phase,   and need to update
> fc_regions_valid in this case, because ext4_fc_replay_check_excluded()
> uses fc_regions_valid for regions checking.
> Please correct me if I'm wrong.
>
> > >  {
> > >         struct ext4_fc_replay_state *state;
> > >         struct ext4_fc_alloc_region *region;
> > >
> > >         state = &EXT4_SB(sb)->s_fc_replay_state;
> > > +       if (replay && state->fc_regions_used != state->fc_regions_valid)
> > > +               state->fc_regions_used = state->fc_regions_valid;
> > >         if (state->fc_regions_used == state->fc_regions_size) {
> > >                 state->fc_regions_size +=
> > >                         EXT4_FC_REPLAY_REALLOC_INCREMENT;
> > > @@ -1591,6 +1593,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
> > >         region->pblk = pblk;
> > >         region->len = len;
> > >
> > > +       if (replay)
> > > +               state->fc_regions_valid++;
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -1938,7 +1943,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
> > >                         ret = ext4_fc_record_regions(sb,
> > >                                 le32_to_cpu(ext.fc_ino),
> > >                                 le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
> > > -                               ext4_ext_get_actual_len(ex));
> > > +                               ext4_ext_get_actual_len(ex), 0);
> > >                         if (ret < 0)
> > >                                 break;
> > >                         ret = JBD2_FC_REPLAY_CONTINUE;
> > > --
> > > 2.20.1
> > >
