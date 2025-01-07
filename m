Return-Path: <linux-ext4+bounces-5915-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A8A03589
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 03:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68867A1AE9
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jan 2025 02:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312815B135;
	Tue,  7 Jan 2025 02:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaP4v+Er"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2E715ADA6;
	Tue,  7 Jan 2025 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218438; cv=none; b=eHHJEHDZzIVE3xPoAwS8YonM4xJeA4ClE1vMfhyO0EIPWmgif/kKYoe8aC74oxmo5Q7nAs9kWSoFMKnpMHE8Pxiqb1PwRjHrGsF/CgqWMfJ4ZDJQTU8YSNzPDHUkEmKL7+rknE8tPjDUUjsA+BT8r0oxJ7wTSlvzMlY1XvNmVWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218438; c=relaxed/simple;
	bh=5ndm79B0bTLRVdrOOon/oVKB5uCSVABKdD0NixwYEv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oP1Z1RF5Zl+g1lssVyBtsAJZUXEcxpIGduP9Fi7acEBbu+brhtwKtrmcOzD+tsdBDnX37Vohv4lH/vxnLki6mb6CUgP+DsmpIa6RH3N06xZeyB8BnTBPFE1KOUCVJ1kc6/GtixhFWqBLDVNnk2/L/bz/wd2Teg/ahHnqW8nrkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaP4v+Er; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53ffaaeeb76so15971140e87.0;
        Mon, 06 Jan 2025 18:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736218433; x=1736823233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0QZBSNu13yegfg7usrcCBObNvxPkxpjrwxiEqIrz9k=;
        b=BaP4v+Erzcp2mYUKf0Q0rx5HNc6J3MVIHh79dc/ZMJyvTOlJyUB4CZVo1Wm0t9k2qF
         Aeq277x1epJLS4ngmqA4GIxrXW1C3DnRcbB+4LgEKeABVWy53IGE00JAOLo1YZxOgvBO
         0a8ONJIVgkmBWyuLQIehwcY9fq+tWQZcTd1W6g1gr642/mGpmStD/z6jLblAFr5tKaxd
         aC5i2vJaTAfgbHICFSys7F0LflHU6xj6QBThRbK0RS+LhYhE9Ri7MrX5X/z5EdRcLOae
         ujv/rkZQxH4oNOZZcvK188jTs8xv79q1tjoOjTOIfecXsSCaxr9UBUM9TNluqjVccSrC
         LZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218433; x=1736823233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0QZBSNu13yegfg7usrcCBObNvxPkxpjrwxiEqIrz9k=;
        b=tJnQ6uVykaHsk4qgIbi5Vl3SEW654h3Pp+cxz4abdwLBrLzM5u7vysafrFtQZpwdwK
         hg1lVl7oXir21q2C/4uZeZAifyEHi4lt17yMwFn/DbDX1hPZDmfEf0KMNtia0zIOUcv3
         JRxfLPrKChpSNFADJqlbEIYJvmP6SDhtUrVc+prV6tsCJdkpLnBLBXaEZD4iYz4iqlsZ
         C3lfftCBvfvhsX/FRW5bf4K3AjO/dLk7ukYCVUkjIUlGQD7ZsdVsiZ1k++p5msmlaUir
         JmWqgRaqnb5fq6mB5himgGOgvrCsmmhr/LLkm+pZeN+OKwW7TNC9AqnIuZkz9y5WJxY0
         kFng==
X-Forwarded-Encrypted: i=1; AJvYcCU4sRm7pyGxset25fzUNnyHDGU0fBtnNu45Xf4EtS1oWjIPQ/WFF/h/hDUh5LD4cc4QFzCLGA1ZjlXfeV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKAawESXl2o1h6ECS/kVhkCLEtrIv/3c9t9KK6Zj7BLNHocwq
	/MzNHW+SAeHSeZIZQ9hc0SPje6c0VFULMNhTjDgfludBF69dr94dJJS7elpPtH+ysM7oaRlwmIu
	PeMwkuW5wagHU4fm0vFjg9vnGe6g=
X-Gm-Gg: ASbGncunG8O0WIVl6+DQXYtKjoFt1E2lphHx1/89fIuLdW5Eaakc1IRtlFJ2JcjmLgK
	pPwwvOHUZ8qmtMNcc472GWjjYG1d5nrCXfI32UtE=
X-Google-Smtp-Source: AGHT+IHx/iPCn9OYZw23fe8BfMBjeqWE+thugtjyZMPX+mMhLi1qRXql0wAgzvJf5Rq5Khx5YBac9wO96QO+/LJ6vuY=
X-Received: by 2002:a05:6512:32c3:b0:542:29b6:9c27 with SMTP id
 2adb3069b0e04-54229b69cf9mr18994658e87.51.1736218432895; Mon, 06 Jan 2025
 18:53:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-2-sunjunchao2870@gmail.com> <7mghv2p2ee5o4cehwni7lqni3xggem7uzycpjdjvv23uuu4hov@g3sm3l4m2njj>
In-Reply-To: <7mghv2p2ee5o4cehwni7lqni3xggem7uzycpjdjvv23uuu4hov@g3sm3l4m2njj>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Tue, 7 Jan 2025 10:53:39 +0800
X-Gm-Features: AbW1kvYZQVBCFuLPpwS4Cxpn177DCZAyobqIGhc1u9PcNgElV0gBii57ohbtXR0
Message-ID: <CAHB1Naiwv6SXMwfPWzB6xf0xPd08QwNvxwKFwRFD-=208avU=Q@mail.gmail.com>
Subject: Re: [PATCH 1/7] ext4: Modify ei->i_flags before calling ext4_mark_iloc_dirty()
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, boyu.mt@taobao.com, tm@tao.ma
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Jan Kara <jack@suse.cz> =E4=BA=8E2025=E5=B9=B41=E6=9C=886=E6=97=A5=E5=91=A8=
=E4=B8=80 23:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 20-12-24 23:16:19, Julian Sun wrote:
> > Modify ei->i_flags before calling ext4_mark_iloc_dirty() so that
> > the modifications to ei->i_flags can be reflected in the raw_inode
> > during the call to ext4_mark_iloc_dirty()->ext4_do_update_inode()
> >
> > Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> > ---
> >  fs/ext4/inline.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> > index 3536ca7e4fcc..d479495d03aa 100644
> > --- a/fs/ext4/inline.c
> > +++ b/fs/ext4/inline.c
> > @@ -465,11 +465,10 @@ static int ext4_destroy_inline_data_nolock(handle=
_t *handle,
> >       ext4_clear_inode_flag(inode, EXT4_INODE_INLINE_DATA);
> >
> >       get_bh(is.iloc.bh);
> > -     error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> > -
> >       EXT4_I(inode)->i_inline_off =3D 0;
> >       EXT4_I(inode)->i_inline_size =3D 0;
> >       ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> > +     error =3D ext4_mark_iloc_dirty(handle, inode, &is.iloc);
>
> I don't see what difference this makes since ext4_clear_inode_state() doe=
s
> not modify ei->i_flags but ei->i_state_flags which is not stored on disk.=
..

Yes, you are correct. On my machine, BITS_PER_LONG is 64, so
ext4_clear_inode_state() modifies the high 32 bits of ei->i_flags
which are also not stored on disk.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR


Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

