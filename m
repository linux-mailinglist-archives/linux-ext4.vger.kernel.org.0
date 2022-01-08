Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985274880D5
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jan 2022 03:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiAHCJV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jan 2022 21:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiAHCJU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 7 Jan 2022 21:09:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEEFC06173E
        for <linux-ext4@vger.kernel.org>; Fri,  7 Jan 2022 18:09:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id bp20so21888057lfb.6
        for <linux-ext4@vger.kernel.org>; Fri, 07 Jan 2022 18:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiJhbJ2aBb0qjBsuYYXGsPdSValv1YALN0zVHkP+alM=;
        b=Ao9/bWL/zwovU6cqVd0D/MyCY9g/soKUG8w1vXWmgtMEaMZ9kFXEn3SRMfjD6NyqkY
         xaxh8oBp4Y//AQI8VP/givvyZ6zDFWverkWH8zlm1QIWSIidBkT2mt1LRX4YJy/ohk3V
         bSvtBko1RljiO8peu5OJ6eo5/2lE7nQ7pxXwDVCr2OgumG7Li6LQZHv2qeiQF3TMGeqw
         8qaPa31xjTKWs8yv23Sdih+SWF4WNDjHuxKt+wCogdyAP1pXMt3gmwUGq5NC9ZRy6jrb
         9+hIghar6fV5WI792xtboJSFIwT63rWfPx98KMB7XiM3adDJs8VeiR0KMye+axg2db9F
         gukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiJhbJ2aBb0qjBsuYYXGsPdSValv1YALN0zVHkP+alM=;
        b=6xR/GwCo2j5E6Sj3YKLdIcZpdhXasiPO39rMxsD+0HSPTMpyMYwAlFWkgiPlbyxGVi
         AgGZLEbjpe58+wpEYcv11wZSD9s/RNuCTgmYC2/Lp46hHMIBfhYfhDFlrB68H09kegBz
         RiX+98AzLaPZGbQGzksPZxxLO2q+0HMYRUZuKpxN91pvgR3Q/BF71B6f4DIQVqJ0b1G5
         1L2sxRLXjsbQchEybzhuIN5wduZh7Jv+Yczx8+FPHD6THXFG/ATqzw2z6FfhxRdAwdkO
         QNq2P5U0KRxaTCGfCEnGFs6NvPGKYH/6Y28NIjO3DyqJLzXY6HV43ZjjwnE/C+lbz3Pa
         v8Lw==
X-Gm-Message-State: AOAM533Q0/fQSv9t5H7iIiSz9nah6qgwwJ9Nk+YiMJEU1glD2yit39SI
        +XQIc/qpwdeqIoo0OYXquE2iST2wuZTdf8JndoVyow==
X-Google-Smtp-Source: ABdhPJz3ZuvzjB2Xxxx0jSq9TUC7Q0ZpjgD4pH0JDWwhTXG+Zxp1GJQ3xtrXXGN940Nb2qNqjlUQmtW1tymGSOlgdr4=
X-Received: by 2002:ac2:4895:: with SMTP id x21mr58793403lfc.336.1641607758305;
 Fri, 07 Jan 2022 18:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20220106024518.8161-1-yinxin.x@bytedance.com> <20220106024518.8161-2-yinxin.x@bytedance.com>
 <CAD+ocbx2e06YoESJM7m5ra-6so0ijWsYyN1L1ZFTXqxedMMoNw@mail.gmail.com>
In-Reply-To: <CAD+ocbx2e06YoESJM7m5ra-6so0ijWsYyN1L1ZFTXqxedMMoNw@mail.gmail.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Sat, 8 Jan 2022 10:09:06 +0800
Message-ID: <CAK896s4EgEPU4FyyXczW79uFhVDido-Cwc=X-6jJ3kz2LXwBqw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] ext4: prevent used blocks from being
 allocated during fast commit replay
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 8, 2022 at 4:26 AM harshad shirwadkar
<harshadshirwadkar@gmail.com> wrote:
>
> On Wed, Jan 5, 2022 at 6:45 PM Xin Yin <yinxin.x@bytedance.com> wrote:
> >
> > during fast commit replay procedure, we clear inode blocks bitmap in
> > ext4_ext_clear_bb(), this may cause ext4_mb_new_blocks_simple() allocate
> > blocks still in use.
> >
> > make ext4_fc_record_regions() also record physical disk regions used by
> > inodes during replay procedure. Then ext4_mb_new_blocks_simple() can
> > excludes these blocks in use.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/ext4/ext4.h        |  2 ++
> >  fs/ext4/extents.c     |  4 ++++
> >  fs/ext4/fast_commit.c | 11 ++++++++---
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 82fa51d6f145..7b0686758691 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -2932,6 +2932,8 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
> >  void ext4_fc_replay_cleanup(struct super_block *sb);
> >  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
> >  int __init ext4_fc_init_dentry_cache(void);
> > +int ext4_fc_record_regions(struct super_block *sb, int ino,
> > +                    ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay);
> >
> >  /* mballoc.c */
> >  extern const struct seq_operations ext4_mb_seq_groups_ops;
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index c3e76a5de661..9b6c76629c93 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -6096,11 +6096,15 @@ int ext4_ext_clear_bb(struct inode *inode)
> >
> >                                         ext4_mb_mark_bb(inode->i_sb,
> >                                                         path[j].p_block, 1, 0);
> > +                                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> > +                                                       0, path[j].p_block, 1, 1);
> >                                 }
> >                                 ext4_ext_drop_refs(path);
> >                                 kfree(path);
> >                         }
> >                         ext4_mb_mark_bb(inode->i_sb, map.m_pblk, map.m_len, 0);
> > +                       ext4_fc_record_regions(inode->i_sb, inode->i_ino,
> > +                                       map.m_lblk, map.m_pblk, map.m_len, 1);
> >                 }
> >                 cur = cur + map.m_len;
> >         }
> > diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> > index 23d13983a281..f0cd20f5fe5e 100644
> > --- a/fs/ext4/fast_commit.c
> > +++ b/fs/ext4/fast_commit.c
> > @@ -1567,13 +1567,15 @@ static int ext4_fc_replay_create(struct super_block *sb, struct ext4_fc_tl *tl,
> >   * Record physical disk regions which are in use as per fast commit area. Our
> >   * simple replay phase allocator excludes these regions from allocation.
> >   */
> > -static int ext4_fc_record_regions(struct super_block *sb, int ino,
> > -               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len)
> > +int ext4_fc_record_regions(struct super_block *sb, int ino,
> > +               ext4_lblk_t lblk, ext4_fsblk_t pblk, int len, int replay)
> Can you explain a bit why this replay parameter is needed here? This
> function simply reallocs the regions array if it doesn't have enough
> space. I am not sure why we need to change that behavior.

ext4_fc_record_regions() originally only used during scan phase,  and
set fc_regions_valid = fc_regions_use when getting a TAIL tag. Now we
also use it during the replay phase,   and need to update
fc_regions_valid in this case, because ext4_fc_replay_check_excluded()
uses fc_regions_valid for regions checking.
Please correct me if I'm wrong.

> >  {
> >         struct ext4_fc_replay_state *state;
> >         struct ext4_fc_alloc_region *region;
> >
> >         state = &EXT4_SB(sb)->s_fc_replay_state;
> > +       if (replay && state->fc_regions_used != state->fc_regions_valid)
> > +               state->fc_regions_used = state->fc_regions_valid;
> >         if (state->fc_regions_used == state->fc_regions_size) {
> >                 state->fc_regions_size +=
> >                         EXT4_FC_REPLAY_REALLOC_INCREMENT;
> > @@ -1591,6 +1593,9 @@ static int ext4_fc_record_regions(struct super_block *sb, int ino,
> >         region->pblk = pblk;
> >         region->len = len;
> >
> > +       if (replay)
> > +               state->fc_regions_valid++;
> > +
> >         return 0;
> >  }
> >
> > @@ -1938,7 +1943,7 @@ static int ext4_fc_replay_scan(journal_t *journal,
> >                         ret = ext4_fc_record_regions(sb,
> >                                 le32_to_cpu(ext.fc_ino),
> >                                 le32_to_cpu(ex->ee_block), ext4_ext_pblock(ex),
> > -                               ext4_ext_get_actual_len(ex));
> > +                               ext4_ext_get_actual_len(ex), 0);
> >                         if (ret < 0)
> >                                 break;
> >                         ret = JBD2_FC_REPLAY_CONTINUE;
> > --
> > 2.20.1
> >
