Return-Path: <linux-ext4+bounces-759-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FA829242
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 02:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1E21B25D6C
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 01:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418D15C0;
	Wed, 10 Jan 2024 01:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WDYDxxRy"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689D81373
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6dbdc007f37so148977a34.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jan 2024 17:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704851767; x=1705456567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY5bMKZJ50jgz3CZvW1+3drPLalYN0Sz2puWtIuL59c=;
        b=WDYDxxRyJhXrsFBXY2WUJSdBGwe+gfRy5RdLuXjbtbOlck5Y6ueo70uA5jJXjfEAfE
         fxWZVp1drfkquMC3g8SuBni4jVrAxKN3tRY70NdrXnuJHFk0wJvZicaj9m63PURSoa6y
         +j6QLmohyh9o20oZmMwxzx62na7s4mmsAU9DXrH27/Gnd5Jd+T4gqGg8xWFnX7UlUxjv
         84huli8Mf68v98j7Ftg39nd/cO3sD+m27rox7/JGAAg/m4m9LCF5bkuJ2n5DzdXp90LL
         l0F25bvQ0kVEqlGfF7brujV3qMNatb/VMzFrGA91qqGpePmP2+kFRt8cRVRuYJNtG6cI
         h7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704851767; x=1705456567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY5bMKZJ50jgz3CZvW1+3drPLalYN0Sz2puWtIuL59c=;
        b=MA2IQqNdFN8JILIqzb/e65VaxatJ2+ACgjoBl3ZRuzuqW9//2c9OIgTOhhztuGOrpP
         5AwcAEKkzixfH4jwfv29Lj931YNqtMEvgtc877oPT+t0tulRr1+o88TSCfr2cz/IOUeO
         RkJZ/HRj969InEwLivjZRGPQcxfhG7WHpgI7TAZjO486h+yvdeC47QUj2FjLUd5XmhH2
         rhFIPcfZZAmTgoLmxNTTmUl943HbNxQ5qnINrX5VUg6RRjKC3czRLEgjrznviGZEQjh9
         YfUUxdeVFjaK4jEPO0Et0vGvhxizleEzZrWeQzwuqmiPYbBilJIpGTYKCvJL/emTI1E7
         Up5Q==
X-Gm-Message-State: AOJu0YyxRoqEyu811rwmpiuGqSET095DkQYmpYUn9ZAugqWo6O49z8iE
	sBJ+lw7F+4jh+Ys+qVjb04rdBuMy9rb9NJNUSmLyqfx3D3GdLg==
X-Google-Smtp-Source: AGHT+IHom8pkNXCfTqc6FT2qk0Y4GJEkWclKfF51vhSDchUol7+5pklJRlMHCWHEbgHJOWTIYYj6bg60PVkEk2jZOfA=
X-Received: by 2002:a05:6870:f293:b0:1fb:1d07:86a6 with SMTP id
 u19-20020a056870f29300b001fb1d0786a6mr837052oap.3.1704851767287; Tue, 09 Jan
 2024 17:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901092820.33757-1-changfengnan@bytedance.com>
 <20240108171506.k47t4qztbbhulsp3@quack3> <CAPFOzZtz2VzFcTDrvz_kWPSuUWgOb-Dcf66S+5nxUf66+-9Lww@mail.gmail.com>
 <20240109120852.jospfnxmeeusbxnm@quack3>
In-Reply-To: <20240109120852.jospfnxmeeusbxnm@quack3>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Wed, 10 Jan 2024 09:55:56 +0800
Message-ID: <CAPFOzZtN1FkoSUm_hXFNO06hxzQ2QN76hWox-x41xwkStVoR=A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] ext4: improve trim efficiency
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=97=A5=E5=91=A8=
=E4=BA=8C 20:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 09-01-24 19:28:07, Fengnan Chang wrote:
> > Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=97=A5=E5=
=91=A8=E4=BA=8C 01:15=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri 01-09-23 17:28:20, Fengnan Chang wrote:
> > > > In commit a015434480dc("ext4: send parallel discards on commit
> > > > completions"), issue all discard commands in parallel make all
> > > > bios could merged into one request, so lowlevel drive can issue
> > > > multi segments in one time which is more efficiency, but commit
> > > > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex"=
)
> > > > seems broke this way, let's fix it.
> > > >
> > > > In my test:
> > > > 1. create 10 normal files, each file size is 10G.
> > > > 2. deallocate file, punch a 16k holes every 32k.
> > > > 3. trim all fs.
> > > > the time of fstrim fs reduce from 6.7s to 1.3s.
> > > >
> > > > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
> > >
> > > This seems to have fallen through the cracks... I'm sorry for that.
> > >
> > > >  static int ext4_try_to_trim_range(struct super_block *sb,
> > > >               struct ext4_buddy *e4b, ext4_grpblk_t start,
> > > >               ext4_grpblk_t max, ext4_grpblk_t minblocks)
> > > >  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
> > > >  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
> > > >  {
> > > > -     ext4_grpblk_t next, count, free_count;
> > > > +     ext4_grpblk_t next, count, free_count, bak;
> > > >       void *bitmap;
> > > > +     struct ext4_free_data *entry =3D NULL, *fd, *nfd;
> > > > +     struct list_head discard_data_list;
> > > > +     struct bio *discard_bio =3D NULL;
> > > > +     struct blk_plug plug;
> > > > +     ext4_group_t group =3D e4b->bd_group;
> > > > +     struct ext4_free_extent ex;
> > > > +     bool noalloc =3D false;
> > > > +     int ret =3D 0;
> > > > +
> > > > +     INIT_LIST_HEAD(&discard_data_list);
> > > >
> > > >       bitmap =3D e4b->bd_bitmap;
> > > >       start =3D max(e4b->bd_info->bb_first_free, start);
> > > >       count =3D 0;
> > > >       free_count =3D 0;
> > > >
> > > > +     blk_start_plug(&plug);
> > > >       while (start <=3D max) {
> > > >               start =3D mb_find_next_zero_bit(bitmap, max + 1, star=
t);
> > > >               if (start > max)
> > > >                       break;
> > > > +             bak =3D start;
> > > >               next =3D mb_find_next_bit(bitmap, max + 1, start);
> > > > -
> > > >               if ((next - start) >=3D minblocks) {
> > > > -                     int ret =3D ext4_trim_extent(sb, start, next =
- start, e4b);
> > > > +                     /* when only one segment, there is no need to=
 alloc entry */
> > > > +                     noalloc =3D (free_count =3D=3D 0) && (next >=
=3D max);
> > >
> > > Is the single extent case really worth the complications to save one
> > > allocation? I don't think it is but maybe I'm missing something. Othe=
rwise
> > > the patch looks good to me!
> > yeah, it's necessary, if there is only one segment, alloc memory may ca=
use
> > performance regression.
> > Refer to this https://lore.kernel.org/linux-ext4/CALWNXx-6y0=3DZDBMicv2=
qng9pKHWcpJbCvUm9TaRBwg81WzWkWQ@mail.gmail.com/
>
> Ah, thanks for the reference! Then what I'd suggest is something like:
>
>         struct ext4_free_data first_entry;
>         /*
>          * We preallocate the first entry on stack to optimize for the co=
mmon
>          * case of trimming single extent in each group. It has measurabl=
e
>          * performance impact.
>          */
>         struct ext4_free_data *entry =3D &first_entry;
>
> then when we allocate we do:
>
>                 if (!entry)
>                         entry =3D kmem_cache_alloc(...)
>                 entry->efd_start_cluster =3D start;
>                 entry->efd_count =3D next - start;
>                 list_add_tail(&entry->efd_list, &discard_data_list);
>                 entry =3D NULL;
>
> and then when freeing we can have:
>
>         list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
>                 mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_=
count);
>                 if (fd !=3D &first_entry)
>                         kmem_cache_free(ext4_free_data_cachep, fd);
>         }
>
> Then it is more understandable what's going on...
Looks better, I'll modify it in the next version.
Thanks.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

