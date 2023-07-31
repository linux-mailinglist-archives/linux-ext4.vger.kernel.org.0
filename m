Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD417696CB
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jul 2023 14:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjGaMwU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jul 2023 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjGaMwT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 31 Jul 2023 08:52:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60106E46
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 05:52:18 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-403e7db1e96so10918531cf.0
        for <linux-ext4@vger.kernel.org>; Mon, 31 Jul 2023 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690807937; x=1691412737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q4RU+jcc8rY/tzWr+eTjZHyit/9dZraZT0AokBeR0A=;
        b=PqGAavr3HytB6jbqYh5/YE0/nC7+AtSzi7Iz6d4DF2b+5r2bX7AyBzKCUdhZ3KptA7
         HXe9uq2BxcP2MUKAqNmQ6ZWYOyKOHdZQi2njSWArXFzdFBkDEEIUgqO3GcBZsO21LjLA
         mBCdHt/vpc5kphpZ4xh6qlvedTgCK/TuuP2EuvbHTf3pnYF1HRtkNli6jpNEdMtBIg79
         NuaVfkQqYceiP80gI9pLFUUtfnglebIbiGKXeWb0lJ+lNyjycPuHwp7lQ2BTx6mZIijr
         7iTvIfgMVEi5plYvtX7ySa4WKEgOc9bSbGm0RABS/zUPDUeIotQsuY2DcmgZtfQplDBd
         7KzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690807937; x=1691412737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q4RU+jcc8rY/tzWr+eTjZHyit/9dZraZT0AokBeR0A=;
        b=HRhQcEScREDnhDOeI7lC/+9MgnMjNACWyj2IjaPYXf0zm6hqs6DGrAQ6IUjNxXfiDr
         4uqvvF2FXlExkEmcD6aXrCy574Jq14uBGEjcnj7h6ZTKqFcpyMiBEZTwAhcCO0NihZTb
         9uLBKIGOWT6j2GkOR+ELWMv9A+Gub4Y/53srMA5vNHYssBbz/W04jAFqY7z6ySvsFrhc
         VgEhrMV0i3unHvX7GqHDht7zSat0Gb1GK24UmlLN+ftTmBtWL1rXP0ekBRlxNTetgGlL
         SRC6GlnNV1oCV4oje1aftVvXjAb8SxgxscGKT0Nx0UTU3UH8l7UtFDy1UDULlnOBvAsi
         Hndw==
X-Gm-Message-State: ABy/qLYyro3W0RUWX+QmbL/c8U5LXuTw+y3i6IEJ2rBvD2uF0h918iE9
        BhRXlkyRU5BUSckJLMHBPUNQb1fJ/3b6q0pxvL0nxg==
X-Google-Smtp-Source: APBJJlGfio3r0JSORA53QEaV2Tm8k8v+feUfyN/g7bVJkXRI9eFhiegwqKRQMq/3NZs9Hr/WCEA9uazVlO65hDamqHA=
X-Received: by 2002:a05:622a:19a6:b0:40e:b4f2:b523 with SMTP id
 u38-20020a05622a19a600b0040eb4f2b523mr5040304qtc.6.1690807937477; Mon, 31 Jul
 2023 05:52:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230725121848.26865-1-changfengnan@bytedance.com> <810f6c3a-89a1-837f-fd79-46f1fd32bbe7@linux.dev>
In-Reply-To: <810f6c3a-89a1-837f-fd79-46f1fd32bbe7@linux.dev>
From:   Fengnan Chang <changfengnan@bytedance.com>
Date:   Mon, 31 Jul 2023 20:52:06 +0800
Message-ID: <CAPFOzZurP23oCENeP57f7Kj-4uCf9bN9ERZQTbdZJh_d5rUEwg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3] ext4: improve trim efficiency
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     adilger.kernel@dilger.ca, tytso@mit.edu,
        linux-ext4@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted, Andreas:
    Any comments ?

Thanks.

Guoqing Jiang <guoqing.jiang@linux.dev> =E4=BA=8E2023=E5=B9=B47=E6=9C=8831=
=E6=97=A5=E5=91=A8=E4=B8=80 10:27=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 7/25/23 20:18, Fengnan Chang wrote:
> > In commit a015434480dc("ext4: send parallel discards on commit
> > completions"), issue all discard commands in parallel make all
> > bios could merged into one request, so lowlevel drive can issue
> > multi segments in one time which is more efficiency, but commit
> > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > seems broke this way, let's fix it.
> > In my test:
> > 1. create 10 normal files, each file size is 10G.
> > 2. deallocate file, punch a 16k holes every 32k.
> > 3. trim all fs.
> >
> > the time of fstrim fs reduce from 6.7s to 1.3s.
> >
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202307171455.ee68ef8b-oliver.san=
g@intel.com
> > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> > ---
> >   fs/ext4/mballoc.c | 49 +++++++++++++++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 43 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> > index a2475b8c9fb5..b75ca1df0d30 100644
> > --- a/fs/ext4/mballoc.c
> > +++ b/fs/ext4/mballoc.c
> > @@ -6790,7 +6790,8 @@ int ext4_group_add_blocks(handle_t *handle, struc=
t super_block *sb,
> >    * be called with under the group lock.
> >    */
> >   static int ext4_trim_extent(struct super_block *sb,
> > -             int start, int count, struct ext4_buddy *e4b)
> > +             int start, int count, bool noalloc, struct ext4_buddy *e4=
b,
> > +             struct bio **biop, struct ext4_free_data **entryp)
> >   __releases(bitlock)
> >   __acquires(bitlock)
> >   {
> > @@ -6812,9 +6813,16 @@ __acquires(bitlock)
> >        */
> >       mb_mark_used(e4b, &ex);
> >       ext4_unlock_group(sb, group);
> > -     ret =3D ext4_issue_discard(sb, group, start, count, NULL);
> > +     ret =3D ext4_issue_discard(sb, group, start, count, biop);
> > +     if (!ret && !noalloc) {
> > +             struct ext4_free_data *entry =3D kmem_cache_alloc(ext4_fr=
ee_data_cachep,
> > +                             GFP_NOFS|__GFP_NOFAIL);
> > +             entry->efd_start_cluster =3D start;
> > +             entry->efd_count =3D count;
> > +             *entryp  =3D entry;
> > +     }
> > +
> >       ext4_lock_group(sb, group);
> > -     mb_free_blocks(NULL, e4b, start, ex.fe_len);
> >       return ret;
> >   }
> >
> > @@ -6824,26 +6832,40 @@ static int ext4_try_to_trim_range(struct super_=
block *sb,
> >   __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
> >   __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
> >   {
> > -     ext4_grpblk_t next, count, free_count;
> > +     ext4_grpblk_t next, count, free_count, bak;
> >       void *bitmap;
> > +     struct ext4_free_data *entry =3D NULL, *fd, *nfd;
> > +     struct list_head discard_data_list;
> > +     struct bio *discard_bio =3D NULL;
> > +     struct blk_plug plug;
> > +     bool noalloc =3D false;
> > +
> > +     INIT_LIST_HEAD(&discard_data_list);
> >
> >       bitmap =3D e4b->bd_bitmap;
> >       start =3D (e4b->bd_info->bb_first_free > start) ?
> >               e4b->bd_info->bb_first_free : start;
> >       count =3D 0;
> >       free_count =3D 0;
> > +     bak =3D start;
> >
> > +     blk_start_plug(&plug);
> >       while (start <=3D max) {
> >               start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
> >               if (start > max)
> >                       break;
> >               next =3D mb_find_next_bit(bitmap, max + 1, start);
> > +             /* when only one segment, there is no need to alloc entry=
 */
> > +             noalloc =3D (free_count =3D=3D 0) && (next >=3D max);
> >
> >               if ((next - start) >=3D minblocks) {
> > -                     int ret =3D ext4_trim_extent(sb, start, next - st=
art, e4b);
> > +                     int ret =3D ext4_trim_extent(sb, start, next - st=
art, noalloc, e4b,
> > +                                                     &discard_bio, &en=
try);
> >
> > -                     if (ret && ret !=3D -EOPNOTSUPP)
> > +                     if (ret < 0)
> >                               break;
> > +                     if (entry)
> > +                             list_add_tail(&entry->efd_list, &discard_=
data_list);
> >                       count +=3D next - start;
> >               }
> >               free_count +=3D next - start;
> > @@ -6863,6 +6885,21 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group=
))
> >               if ((e4b->bd_info->bb_free - free_count) < minblocks)
> >                       break;
> >       }
> > +     if (discard_bio) {
> > +             ext4_unlock_group(sb, e4b->bd_group);
> > +             submit_bio_wait(discard_bio);
> > +             bio_put(discard_bio);
> > +             ext4_lock_group(sb, e4b->bd_group);
> > +     }
> > +     blk_finish_plug(&plug);
> > +
> > +     if (noalloc)
> > +             mb_free_blocks(NULL, e4b, bak, free_count);
> > +
> > +     list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
> > +             mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_=
count);
> > +             kmem_cache_free(ext4_free_data_cachep, fd);
> > +     }
> >
> >       return count;
> >   }
>
> With the new version, I don't see big difference from my test.
>
> Thanks,
> Guoqing
