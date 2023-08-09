Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E946775507
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Aug 2023 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjHIIVe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Aug 2023 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbjHIIVd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Aug 2023 04:21:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7076C268E
        for <linux-ext4@vger.kernel.org>; Wed,  9 Aug 2023 01:21:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40ff9749be6so8767941cf.1
        for <linux-ext4@vger.kernel.org>; Wed, 09 Aug 2023 01:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691569260; x=1692174060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cN74UbUl67REon53d0dVi5mPxhYOp82SVTBp87Si/0=;
        b=Y243X9nHhRTtNw2CNB80yd+hNDmbUo44ut8BX+bObI5uwMncSRREMpdiKmFnYDMbN3
         dAIosKnlygzJZBVvv9PqM7cHPgxEYe9+JisLoVrTh+0sVVLGwUUyDFYbTQPIcQi1MC+V
         iIcC1jyIEPH5PXNN+iWLmPy1EcdsqBnNpotx5e1eUlYGZe8RrdyEHtMPjX6KVru2oapS
         oi5qoQTq1WVdDWdpXBUh0cW+WWPeTu/bVA+kN+9syRTXB+bpyvlgyy11JOLH+hHWFq7o
         S5z6X5AqVfXBdrkdlVs4pA9SMWZ2Hz0p+jQC+qtBtUElpYPuPRWFfdBTO9etpeg5qvzz
         0G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691569260; x=1692174060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cN74UbUl67REon53d0dVi5mPxhYOp82SVTBp87Si/0=;
        b=cA8GbVXKMgaZxKivIDGBotTMyEVuR9Zgi2uNXTsQQHgyOAcIrwmh/05fdfbPfVqm6L
         FIS/+3R6WnwAC8nvZqEcU4hcsyOsGbhHFXr10uKJwqFEawSegVOXPsnHJGCKRHh7+s6E
         yvHrGMcEP7s0IDMC1FDib2mgVZXS/LAK4hwfY4TJnOva1+2VWVp13aRnHR1osZ1kjmPY
         jONWx23m728lZPF5InKT47BY10F9n/fzSv3erBIkJvaHFfOboakKtgz1pIp9Db8kYot6
         X+W89naMSzCt0eHd5NxkONDe43OwebnVN9jhGjtpioxc88hx/+EQB/bnLmPPDPnWm943
         5KFA==
X-Gm-Message-State: AOJu0Yw6rh8WUGYMC8blat8BdfbGgghQzaLnKGkPpHnXtPWHBHjTOPei
        1G+pcBhrlNTTVp15VPQ+T3LYPhmcVZ/L9MEtcpQjUA==
X-Google-Smtp-Source: AGHT+IFNWCrH+ZNa+HGllWlrsLg4gESS7imlxGeWkBJkUXWjad8VEIP/DqGm/PfLSs5nbCZHRnGz+ntsZmlIUa323Ts=
X-Received: by 2002:a05:622a:1982:b0:405:379e:c78d with SMTP id
 u2-20020a05622a198200b00405379ec78dmr2595390qtc.3.1691569260412; Wed, 09 Aug
 2023 01:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230725121848.26865-1-changfengnan@bytedance.com>
 <810f6c3a-89a1-837f-fd79-46f1fd32bbe7@linux.dev> <CAPFOzZurP23oCENeP57f7Kj-4uCf9bN9ERZQTbdZJh_d5rUEwg@mail.gmail.com>
In-Reply-To: <CAPFOzZurP23oCENeP57f7Kj-4uCf9bN9ERZQTbdZJh_d5rUEwg@mail.gmail.com>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Wed, 9 Aug 2023 16:20:49 +0800
Message-ID: <CAPFOzZsR5DjCfm0c2qtob-OXwRx9NB0WFaHMQ96WK0vNhmWSfg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] ext4: improve trim efficiency
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping

Fengnan Chang <changfengnan@bytedance.com> =E4=BA=8E2023=E5=B9=B47=E6=9C=88=
31=E6=97=A5=E5=91=A8=E4=B8=80 20:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Ted, Andreas:
>     Any comments ?
>
> Thanks.
>
> Guoqing Jiang <guoqing.jiang@linux.dev> =E4=BA=8E2023=E5=B9=B47=E6=9C=883=
1=E6=97=A5=E5=91=A8=E4=B8=80 10:27=E5=86=99=E9=81=93=EF=BC=9A
> >
> >
> >
> > On 7/25/23 20:18, Fengnan Chang wrote:
> > > In commit a015434480dc("ext4: send parallel discards on commit
> > > completions"), issue all discard commands in parallel make all
> > > bios could merged into one request, so lowlevel drive can issue
> > > multi segments in one time which is more efficiency, but commit
> > > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > > seems broke this way, let's fix it.
> > > In my test:
> > > 1. create 10 normal files, each file size is 10G.
> > > 2. deallocate file, punch a 16k holes every 32k.
> > > 3. trim all fs.
> > >
> > > the time of fstrim fs reduce from 6.7s to 1.3s.
> > >
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.s=
ang@intel.com
> > > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> > > ---
> > >   fs/ext4/mballoc.c | 49 +++++++++++++++++++++++++++++++++++++++++---=
---
> > >   1 file changed, 43 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > > index a2475b8c9fb5..b75ca1df0d30 100644
> > > --- a/fs/ext4/mballoc.c
> > > +++ b/fs/ext4/mballoc.c
> > > @@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, str=
uct super_block *sb,
> > >    * be called with under the group lock.
> > >    */
> > >   static int ext4_trim_extent(struct super_block *sb,
> > > -             int start, int count, struct ext4_buddy *e4b)
> > > +             int start, int count, bool noalloc, struct ext4_buddy *=
e4b,
> > > +             struct bio **biop, struct ext4_free_data **entryp)
> > >   __releases(bitlock)
> > >   __acquires(bitlock)
> > >   {
> > > @@ -6812,9 +6813,16 @@ __acquires(bitlock)
> > >        */
> > >       mb_mark_used(e4b, &ex);
> > >       ext4_unlock_group(sb, group);
> > > -     ret =3D ext4_issue_discard(sb, group, start, count, NULL);
> > > +     ret =3D ext4_issue_discard(sb, group, start, count, biop);
> > > +     if (!ret && !noalloc) {
> > > +             struct ext4_free_data *entry =3D kmem_cache_alloc(ext4_=
free_data_cachep,
> > > +                             GFP_NOFS|__GFP_NOFAIL);
> > > +             entry->efd_start_cluster =3D start;
> > > +             entry->efd_count =3D count;
> > > +             *entryp  =3D entry;
> > > +     }
> > > +
> > >       ext4_lock_group(sb, group);
> > > -     mb_free_blocks(NULL, e4b, start, ex.fe_len);
> > >       return ret;
> > >   }
> > >
> > > @@ -6824,26 +6832,40 @@ static int ext4_try_to_trim_range(struct supe=
r_block *sb,
> > >   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
> > >   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
> > >   {
> > > -     ext4_grpblk_t next, count, free_count;
> > > +     ext4_grpblk_t next, count, free_count, bak;
> > >       void *bitmap;
> > > +     struct ext4_free_data *entry =3D NULL, *fd, *nfd;
> > > +     struct list_head discard_data_list;
> > > +     struct bio *discard_bio =3D NULL;
> > > +     struct blk_plug plug;
> > > +     bool noalloc =3D false;
> > > +
> > > +     INIT_LIST_HEAD(&discard_data_list);
> > >
> > >       bitmap =3D e4b->bd_bitmap;
> > >       start =3D (e4b->bd_info->bb_first_free > start) ?
> > >               e4b->bd_info->bb_first_free : start;
> > >       count =3D 0;
> > >       free_count =3D 0;
> > > +     bak =3D start;
> > >
> > > +     blk_start_plug(&plug);
> > >       while (start <=3D max) {
> > >               start =3D mb_find_next_zero_bit(bitmap, max + 1, start)=
;
> > >               if (start > max)
> > >                       break;
> > >               next =3D mb_find_next_bit(bitmap, max + 1, start);
> > > +             /* when only one segment, there is no need to alloc ent=
ry */
> > > +             noalloc =3D (free_count =3D=3D 0) && (next >=3D max);
> > >
> > >               if ((next - start) >=3D minblocks) {
> > > -                     int ret =3D ext4_trim_extent(sb, start, next - =
start, e4b);
> > > +                     int ret =3D ext4_trim_extent(sb, start, next - =
start, noalloc, e4b,
> > > +                                                     &discard_bio, &=
entry);
> > >
> > > -                     if (ret && ret !=3D -EOPNOTSUPP)
> > > +                     if (ret < 0)
> > >                               break;
> > > +                     if (entry)
> > > +                             list_add_tail(&entry->efd_list, &discar=
d_data_list);
> > >                       count +=3D next - start;
> > >               }
> > >               free_count +=3D next - start;
> > > @@ -6863,6 +6885,21 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_gro=
up))
> > >               if ((e4b->bd_info->bb_free - free_count) < minblocks)
> > >                       break;
> > >       }
> > > +     if (discard_bio) {
> > > +             ext4_unlock_group(sb, e4b->bd_group);
> > > +             submit_bio_wait(discard_bio);
> > > +             bio_put(discard_bio);
> > > +             ext4_lock_group(sb, e4b->bd_group);
> > > +     }
> > > +     blk_finish_plug(&plug);
> > > +
> > > +     if (noalloc)
> > > +             mb_free_blocks(NULL, e4b, bak, free_count);
> > > +
> > > +     list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list)=
 {
> > > +             mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->ef=
d_count);
> > > +             kmem_cache_free(ext4_free_data_cachep, fd);
> > > +     }
> > >
> > >       return count;
> > >   }
> >
> > With the new version, I don't see big difference from my test.
> >
> > Thanks,
> > Guoqing
