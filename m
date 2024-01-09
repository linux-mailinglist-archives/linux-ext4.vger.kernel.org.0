Return-Path: <linux-ext4+bounces-753-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A350282850D
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 12:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1911B25540
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Jan 2024 11:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B37937153;
	Tue,  9 Jan 2024 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KRf/Abrv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B8364D1
	for <linux-ext4@vger.kernel.org>; Tue,  9 Jan 2024 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-594363b4783so63915eaf.1
        for <linux-ext4@vger.kernel.org>; Tue, 09 Jan 2024 03:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1704799698; x=1705404498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is4qbjslOKPrja7k0nUmaZBfoz3gwPhxToFtexSU9Vo=;
        b=KRf/Abrv6M3DnyvystD4fDu138g8epdrN7sIFhHV/aag/4+RxreC3ZnZgXRHFbvrdL
         C6lMdIVcD/y/6wkdMJTqfeAhs5vusSdfeMOp3mZMzqDWCCIsbtNTQ68GOuhfi4B8U76C
         1Tgjjzkjfqpqkb1Yf91pSbhMag3wqdVuLGGGQj1WPllVrwGpish+ZRZNDaYRABBr7Dpv
         plGrPQRXuYh1N5pyL8dP8QiIajHupkKL2jnmKLt2Z7mMCDi/Hemz3DS2Y3SprApOTfy8
         tD/2XXYPDaRkN8tTM9Ekalno0Un84Bc8zvcrcCwIHQ76Q+5JE9LFIMEhS436cr2Ef2Hv
         Wjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704799698; x=1705404498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is4qbjslOKPrja7k0nUmaZBfoz3gwPhxToFtexSU9Vo=;
        b=q3ws5rF3FSJ/LNzb29K9uUMDD/vHRPaD6tv/5toaKpAJIZUfANCf+a2+yaEtWPev6l
         Rz69p93fQZ50zek0u4TPosBMYoLabeqe6Qo/Pqqa604ajCXdjNHglkavS12sHJF+hltg
         1cHXzyD3UGuCulmhSDedE1fnwTkeZfB3W937De7ljjXRzBE2jfI7ybGOZxrS/MzbNLnO
         lkeKUJTqJhnEo8fN8+8tMko9s5Zviiam45t9NipMyBw+oI39/iI44kZcsqdIwYB+/xtq
         Io1N8PAtN0610hCMmB6heT1wZOqtKHuOnxPoyW1GN9+ZUt4HNeqfEr3yMGU8hq75uSZL
         XFmg==
X-Gm-Message-State: AOJu0Yz50+RVhOpRqImhfNpYN/99W74B64eNQEViwiZjTgHr5DvDmzkn
	5rWK61vERzHKbjv8pQxVQW8dwNJuc4b+o4xkthPsAH3hgcWyLQ==
X-Google-Smtp-Source: AGHT+IELZt1l18ucMb8XHEEsPkAE/csf7vJcnSp3h57rZwAQwbGYlPSq3VjM2UeUegx8s8bxdQlIIZpVR0k9IjGHfAU=
X-Received: by 2002:a05:6871:5d1:b0:203:7c44:b622 with SMTP id
 v17-20020a05687105d100b002037c44b622mr9752944oan.0.1704799698360; Tue, 09 Jan
 2024 03:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230901092820.33757-1-changfengnan@bytedance.com> <20240108171506.k47t4qztbbhulsp3@quack3>
In-Reply-To: <20240108171506.k47t4qztbbhulsp3@quack3>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Tue, 9 Jan 2024 19:28:07 +0800
Message-ID: <CAPFOzZtz2VzFcTDrvz_kWPSuUWgOb-Dcf66S+5nxUf66+-9Lww@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v6] ext4: improve trim efficiency
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2024=E5=B9=B41=E6=9C=889=E6=97=A5=E5=91=A8=
=E4=BA=8C 01:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 01-09-23 17:28:20, Fengnan Chang wrote:
> > In commit a015434480dc("ext4: send parallel discards on commit
> > completions"), issue all discard commands in parallel make all
> > bios could merged into one request, so lowlevel drive can issue
> > multi segments in one time which is more efficiency, but commit
> > 55cdd0af2bc5 ("ext4: get discard out of jbd2 commit kthread contex")
> > seems broke this way, let's fix it.
> >
> > In my test:
> > 1. create 10 normal files, each file size is 10G.
> > 2. deallocate file, punch a 16k holes every 32k.
> > 3. trim all fs.
> > the time of fstrim fs reduce from 6.7s to 1.3s.
> >
> > Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
>
> This seems to have fallen through the cracks... I'm sorry for that.
>
> >  static int ext4_try_to_trim_range(struct super_block *sb,
> >               struct ext4_buddy *e4b, ext4_grpblk_t start,
> >               ext4_grpblk_t max, ext4_grpblk_t minblocks)
> >  __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
> >  __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
> >  {
> > -     ext4_grpblk_t next, count, free_count;
> > +     ext4_grpblk_t next, count, free_count, bak;
> >       void *bitmap;
> > +     struct ext4_free_data *entry =3D NULL, *fd, *nfd;
> > +     struct list_head discard_data_list;
> > +     struct bio *discard_bio =3D NULL;
> > +     struct blk_plug plug;
> > +     ext4_group_t group =3D e4b->bd_group;
> > +     struct ext4_free_extent ex;
> > +     bool noalloc =3D false;
> > +     int ret =3D 0;
> > +
> > +     INIT_LIST_HEAD(&discard_data_list);
> >
> >       bitmap =3D e4b->bd_bitmap;
> >       start =3D max(e4b->bd_info->bb_first_free, start);
> >       count =3D 0;
> >       free_count =3D 0;
> >
> > +     blk_start_plug(&plug);
> >       while (start <=3D max) {
> >               start =3D mb_find_next_zero_bit(bitmap, max + 1, start);
> >               if (start > max)
> >                       break;
> > +             bak =3D start;
> >               next =3D mb_find_next_bit(bitmap, max + 1, start);
> > -
> >               if ((next - start) >=3D minblocks) {
> > -                     int ret =3D ext4_trim_extent(sb, start, next - st=
art, e4b);
> > +                     /* when only one segment, there is no need to all=
oc entry */
> > +                     noalloc =3D (free_count =3D=3D 0) && (next >=3D m=
ax);
>
> Is the single extent case really worth the complications to save one
> allocation? I don't think it is but maybe I'm missing something. Otherwis=
e
> the patch looks good to me!
yeah, it's necessary, if there is only one segment, alloc memory may cause
performance regression.
Refer to this https://lore.kernel.org/linux-ext4/CALWNXx-6y0=3DZDBMicv2qng9=
pKHWcpJbCvUm9TaRBwg81WzWkWQ@mail.gmail.com/

Thanks.

>
>                                                                 Honza
>
> >
> > -                     if (ret && ret !=3D -EOPNOTSUPP)
> > +                     trace_ext4_trim_extent(sb, group, start, next - s=
tart);
> > +                     ex.fe_start =3D start;
> > +                     ex.fe_group =3D group;
> > +                     ex.fe_len =3D next - start;
> > +                     /*
> > +                      * Mark blocks used, so no one can reuse them whi=
le
> > +                      * being trimmed.
> > +                      */
> > +                     mb_mark_used(e4b, &ex);
> > +                     ext4_unlock_group(sb, group);
> > +                     ret =3D ext4_issue_discard(sb, group, start, next=
 - start, &discard_bio);
> > +                     if (!noalloc) {
> > +                             entry =3D kmem_cache_alloc(ext4_free_data=
_cachep,
> > +                                                     GFP_NOFS|__GFP_NO=
FAIL);
> > +                             entry->efd_start_cluster =3D start;
> > +                             entry->efd_count =3D next - start;
> > +                             list_add_tail(&entry->efd_list, &discard_=
data_list);
> > +                     }
> > +                     ext4_lock_group(sb, group);
> > +                     if (ret < 0)
> >                               break;
> >                       count +=3D next - start;
> >               }
> > @@ -6959,6 +6950,22 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group=
))
> >                       break;
> >       }
> >
> > +     if (discard_bio) {
> > +             ext4_unlock_group(sb, e4b->bd_group);
> > +             submit_bio_wait(discard_bio);
> > +             bio_put(discard_bio);
> > +             ext4_lock_group(sb, e4b->bd_group);
> > +     }
> > +     blk_finish_plug(&plug);
> > +
> > +     if (noalloc && free_count)
> > +             mb_free_blocks(NULL, e4b, bak, free_count);
> > +
> > +     list_for_each_entry_safe(fd, nfd, &discard_data_list, efd_list) {
> > +             mb_free_blocks(NULL, e4b, fd->efd_start_cluster, fd->efd_=
count);
> > +             kmem_cache_free(ext4_free_data_cachep, fd);
> > +     }
> > +
> >       return count;
> >  }
> >
> > --
> > 2.20.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

