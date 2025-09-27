Return-Path: <linux-ext4+bounces-10458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE427BA5AA1
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 10:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E9747B31EB
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 08:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F52D47F1;
	Sat, 27 Sep 2025 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grmjoAEC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99E2C08BF
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960729; cv=none; b=Jokf1cE3NzVdIj3cwRgUXIC1zqNBX/fhVgCy3sJglNHhJElJdblSP/lsJI/DXhs5bAhGV8EJQ4anoup+GiSlpAkeFuEWU0E5owYMZAgytxj0rOvOKVuJTPf5IZBQ8A3NMwerxtOJlXVqIdTkWhPriJaYsf1eVP6KQ/SdQT5Jv48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960729; c=relaxed/simple;
	bh=88jk2RDKw/3gd24hPvd4dyJfg49pRCPNJvylKv8CS60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXpXMX3eY1WBFOv6p7DbP15kLkEEfKI75KF7djCWF/uw3Fprx6efB/HcK7GFbs6t60r7RDKdZqpNvdomR/34lxidVS8Qu+IISjnJykNXwwJLU1PpHP8jICIW//YcaCKTdeY2BrcrTMzWWxDCh7bVqkgr0AvC5Gv+j0wVDwogehk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grmjoAEC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-362acd22c78so28734111fa.2
        for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758960726; x=1759565526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppwHis2Kihz+Ku7uWuhXRQbuFFZFlc15nzs6xpJLiRE=;
        b=grmjoAECZscgU6nO3zZpOKC5gE+BQI6TVObWVu2lukMtKGDCAW9+/NsZ4BR/7r/sm8
         dcfDcNnboSjz2I1eSmbxikvQCaGg+huSmBU9KFBAiROrj01m6wU2e8Mn/gx4ikwJk3eX
         ptfSCYP5zBcKsgLRyaB25Vne8Ajs0k7cZjPNZN6MH9VlbEbytCDiUesctwNQoLh7Zw6z
         OUf5uObY/j/QevsynhhxrpHivDY5Y1STwWODJ0IswfesnfVAB7ezf2IuRLDMJTNwDvUl
         dynLJzhVXkTrzP8l36x9Xog33KDYkFfWYMubbvh8nr3Whs9jGsa5ehuS+/NOLSH5mlMK
         7D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758960726; x=1759565526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppwHis2Kihz+Ku7uWuhXRQbuFFZFlc15nzs6xpJLiRE=;
        b=MifCuW0TpDsC7MWNX1WGzQPDKKtIZipKkCr05K0H2BIKAQxN0lnZyJeiCu5VXC1b7o
         qi42gLK07FPIU++uVu8XT3Aar/FCWoAOQHWT/obtu5aBC41jbihbiH9K2zgU3d0s/Zxl
         XZS+r6YT92Cmr54YMmVPfMe18APBl6DVjU9m6Ws8XclIobKRttHf9KHYL2dpTzakSHoE
         PE8YnMwBYMhS+NUZU5cslC+38PULLg6RGnkHPBNyJUwSbgZ7lnYwzG4qAD66+O80ZwIo
         YGfMVDkV1+zk+xbiDGyOUof2xyhUhgiEf9vvV6kBdNw64OehSfddR8hln8T8tRH5bKVG
         wRew==
X-Forwarded-Encrypted: i=1; AJvYcCXD5anKSc++G9LzT/chy3pkxovOB18abUKGjeMVXX2hJmWnPayDnFgBeTNjuc+J8ViW2Fn4X1is1HIR@vger.kernel.org
X-Gm-Message-State: AOJu0YxomuY9QLSmefLv3rRd+8kWi7k7dS87tYZMGAoOuh0lMhOhBwcK
	WaNuElkvwQbC7JNkXEg4Vht4201y1cR6oSsUsdZZerHJ0RNB/7bRldyJZF8C2Vr30Z84i65WS0D
	gpQrcZr3wTq4OyyYNBODGyXJVQXfqpIRaIJoB4Ls=
X-Gm-Gg: ASbGncsYkODV1Ki/AkELfKmsfGXWL1BKaW/0nOqJIxoTkbOzm22hw0Se892J66MBcY4
	wDZiP/FRnVXSX6W6/+dGljdRCvXLtFS0LVmW9MXZafvLUri6mbZE6qSCytR1OB+hindlFjxcIEx
	QzTdyjNpiZSzbCpFcz9Ps7BYrfDMYxR8CpgW/lvXZfEConZOs0Ov/Kf2wGoPTJBsPYe9nhhtvzr
	cP4xGvUd6cRmWd+aYI=
X-Google-Smtp-Source: AGHT+IFtbHycSLfh8Jaz12vsLSdnC7wkp/bU1ZFpHTfGntuzcg2dbr5iEg8C4qILK6kN+Dzsj3AtOnnbAMfjZGb3Mds=
X-Received: by 2002:a05:651c:3617:b0:365:d56c:bfb with SMTP id
 38308e7fff4ca-36f7ea7aebcmr30650821fa.21.1758960725446; Sat, 27 Sep 2025
 01:12:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200407064616.221459-3-harshadshirwadkar@gmail.com> <c7a41ba13a3551fca25d7498b9d4542a104fac74.camel@gmail.com>
In-Reply-To: <c7a41ba13a3551fca25d7498b9d4542a104fac74.camel@gmail.com>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Sat, 27 Sep 2025 16:11:54 +0800
X-Gm-Features: AS18NWAPiX9fURNYUW2kcui7bCaSlh9_X7jzPW25UsBOuyx6ydBRwRb9N42fuQg
Message-ID: <CAHB1NagYz+BLXdEtUa7C_6-A6DDCT9Q+A7Vg6PXSwm9D7ZyAkQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using is_dirent_block_empty
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc: adilger@dilger.ca, jack@suse.cz, tytso@mit.edu, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 4:05=E2=80=AFPM Julian Sun <sunjunchao2870@gmail.co=
m> wrote:
>
> On Mon, 2020-04-06 at 23:46 -0700, Harshad Shirwadkar wrote:
> > The new function added in this patchset adds an efficient way to
> > check if a dirent block is empty. Based on that, reimplement
> > ext4_empty_dir().
> >
> > This is a new patch added in V2.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > ---
> >  fs/ext4/namei.c | 39 ++++++++++++++++-----------------------
> >  1 file changed, 16 insertions(+), 23 deletions(-)
> >
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index 39360c442dad..dae7d15fba5c 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -3179,6 +3179,7 @@ bool ext4_empty_dir(struct inode *inode)
> >         struct buffer_head *bh;
> >         struct ext4_dir_entry_2 *de;
> >         struct super_block *sb;
> > +       ext4_lblk_t lblk;
> >
> >         if (ext4_has_inline_data(inode)) {
> >                 int has_inline_data =3D 1;
> > @@ -3218,34 +3219,26 @@ bool ext4_empty_dir(struct inode *inode)
> >                 brelse(bh);
> >                 return true;
> >         }
> > -       offset +=3D ext4_rec_len_from_disk(de->rec_len, sb-
> > > s_blocksize);
> > -       while (offset < inode->i_size) {
> > -               if (!(offset & (sb->s_blocksize - 1))) {
> > -                       unsigned int lblock;
> > -                       brelse(bh);
> > -                       lblock =3D offset >> EXT4_BLOCK_SIZE_BITS(sb);
> > -                       bh =3D ext4_read_dirblock(inode, lblock,
> > EITHER);
> > -                       if (bh =3D=3D NULL) {
> > -                               offset +=3D sb->s_blocksize;
> > -                               continue;
> > -                       }
> > -                       if (IS_ERR(bh))
> > -                               return true;
> > -               }
> > -               de =3D (struct ext4_dir_entry_2 *) (bh->b_data +
> > -                                       (offset & (sb->s_blocksize -
> > 1)));
> > -               if (ext4_check_dir_entry(inode, NULL, de, bh,
> > -                                        bh->b_data, bh->b_size,
> > offset)) {
> > -                       offset =3D (offset | (sb->s_blocksize - 1)) +
> > 1;
> > +       de =3D ext4_next_entry(de, sb->s_blocksize);
> > +       if (!is_empty_dirent_block(inode, bh, de)) {
> > +               brelse(bh);
> > +               return false;
> > +       }
> > +       brelse(bh);
> > +
> > +       for (lblk =3D 1; lblk < inode->i_size >>
> > EXT4_BLOCK_SIZE_BITS(sb);
> > +                       lblk++) {
> > +               bh =3D ext4_read_dirblock(inode, lblk, EITHER);
> > +               if (bh =3D=3D NULL)
> >                         continue;
> > -               }
> > -               if (le32_to_cpu(de->inode)) {
> > +               if (IS_ERR(bh))
> > +                       return true;
> > +               if (!is_empty_dirent_block(inode, bh, NULL)) {
> >                         brelse(bh);
> >                         return false;
> >                 }
> > -               offset +=3D ext4_rec_len_from_disk(de->rec_len, sb-
> > > s_blocksize);
> > +               brelse(bh);
> >         }
> > -       brelse(bh);
> >         return true;
> >  }
> >
>
> Hi,
>
> I=E2=80=99ve recently been looking into the ext4 directory shrinking prob=
lem
> and was considering trying to add this feature myself. To my surprise,
> I found that this patch set had already implemented it and even
> received Reviewed-by. I=E2=80=99m curious whether it was never merged, or=
 if it
> was merged and later reverted?
>
> If possible, is there anything I could do to contribute to moving this
> patch set forward toward being merged?

cc ext4 mail list.
>
> Thanks.
>
>


--=20
Julian Sun <sunjunchao2870@gmail.com>

