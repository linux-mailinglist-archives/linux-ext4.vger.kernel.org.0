Return-Path: <linux-ext4+bounces-3950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A59637BB
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 03:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1835284AD2
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152E1BC41;
	Thu, 29 Aug 2024 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGfLHWHm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56147B657;
	Thu, 29 Aug 2024 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724894920; cv=none; b=bWUySY7h3GyavKQfy61B11aNrmIm3et0KPC+pBz1Tcu1FHJ9rS95sebQeOZ/v4YSnuSO6X+Je/v/u4Lo1bpas3ZHi8c9k//LGIckrYgiLGOq0G1LJh6CZyIXJu6q4Vz61gsJDU+TYCdXOZonbdQZC8sO0hDRP7oM4cSXIkWMEvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724894920; c=relaxed/simple;
	bh=hJPw9WNnBj0xx+pUeyWe0lkkiL31zPtm4LecDQ2WnCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QIqWpzzRD0KkWOZkOvj8DJ7myaJ8YdEhUskaqh+MroHBl3ttc37qBSzkPwTsgxl6TsGOMYzT1rBMcJxeYetmdVKy5lLHKORA6Ym4Hpv8DNPjJf3hZtC1NpOJQjUlk6otfdEeICL4OEdqLDd/Uew0Ffqjt0+PSnPnLtPKswEp+qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGfLHWHm; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4fcf40c9ed3so72630e0c.2;
        Wed, 28 Aug 2024 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724894917; x=1725499717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/rto/v3KaEi+3k2rCfGKqCycGuoujaCCcVQ0FlJe9JE=;
        b=HGfLHWHmOD+uYblONH+5vZxPKfIw9AliNopU+UJrDz7T6irPDUmPGtcPAmnfz2YFxI
         +6pd0ieW71CRC2/N+WEAZMscI0f/ZObO75uqsf3nL3IbKn2ZUgVZkQqN9+uA4T4sDiux
         ukRAKnklQ5aPT+NJD4YmOrw5yBpx1Ift2RV263Dz0RJtbs4BRaFUqWxnJ8Ur5qBiYXOo
         Lb+jT8Snc/ixcQMAtqKts5TCzjX711jaGxrcVb0GHePjXmM15wfjx5PYYFLwELe2GIJx
         m0CsJhsMZzWmtccnkm8SIHFHGhKZ2dGZ9v3sTutuJKkU7pJ7zZYUr143VV+L+OpBWhX2
         VYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724894917; x=1725499717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rto/v3KaEi+3k2rCfGKqCycGuoujaCCcVQ0FlJe9JE=;
        b=dTT2JSIiEmaoJO7atgLooFiNwvu3BaZwpoiuM5PWWNEK/QV7lqC0h1wZoy6Jk7sgLV
         lMbSBgJFJ80+bK/BXGJDFKtqssUgNJO9YYM+0KvDvI3S+eeUYPZ+UBYhRsVrOjetmI+l
         jEGgbob1Id9jA7hMePlBCks7aYFPvCg7BhUUYoAm66PFnd+EBRnMvXLpRirM8oRZCGOE
         vqgWWiIVDqqNH0rDlaJj3fKKT/IHMG/3zgougHm1T8dtdAA6BvlniRvrknn2mmA6abJL
         GScjBOU4gCYyyFON0R4rIN1uHp+TYgOJTNg91cvuImjUE7j2GuvLeJsSfjy6DfTFVLSn
         BcqA==
X-Forwarded-Encrypted: i=1; AJvYcCWQHv5iKnPbCrJbEPSs/0QKMPLug0qm+Fo+VpTsSBNP+/2QUGIDlKEBCXHgKEDJawxdyYH6bbjuO0He@vger.kernel.org, AJvYcCXk9dbxKxH3QWCEXO3QhZbUPhlDywfh0D7+6Dj2oYn4DnpxmQYqxtK/DhBM9J5ub4v9H3y0thfw1tR6qsJi@vger.kernel.org
X-Gm-Message-State: AOJu0YxUs42Rs/LlVKvKF8PkVl71eJxlqxKohEhXWV+/X5RUzg5tN6f4
	RmCjZCmFUnTeuh7XjzMEYU5aiVGa25RoaeFt/vgpXO2loGLxsaUN5Wjx+0bcSefWbSiHwb6KMpY
	sORmJWtVTVGfQzEMaUBJDHbtt1WM=
X-Google-Smtp-Source: AGHT+IHLWs5KAyuOqkzeiLpihf/diDsOUac5tebZ1iQd9nk/cyEZnKA8cs5z5kXqAx0XbuzOXwsiAp1cggRW/pAbdEI=
X-Received: by 2002:a05:6122:88c:b0:4fc:f1e3:d20e with SMTP id
 71dfb90a1353d-4ffe4a5d259mr1708959e0c.1.1724894916914; Wed, 28 Aug 2024
 18:28:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823013329.1996741-1-zhangshida@kylinos.cn>
 <20240823013329.1996741-2-zhangshida@kylinos.cn> <20240829000346.GC558903@google.com>
In-Reply-To: <20240829000346.GC558903@google.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Thu, 29 Aug 2024 09:28:00 +0800
Message-ID: <CANubcdXCz5yjFdfmtQateGdR-h-kZ-5a_KEKRVL2p0u=dm+M8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ext4: hoist ext4_block_write_begin and replace the __block_write_begin
To: Eric Biggers <ebiggers@kernel.org>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zhangshida@kylinos.cn, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Eric Biggers <ebiggers@kernel.org> =E4=BA=8E2024=E5=B9=B48=E6=9C=8829=E6=97=
=A5=E5=91=A8=E5=9B=9B 08:03=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Aug 23, 2024 at 09:33:28AM +0800, zhangshida wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Using __block_write_begin() make it inconvenient to journal the
> > user data dirty process. We can't tell the block layer maintainer,
> > =E2=80=98Hey, we want to trace the dirty user data in ext4, can we add =
some
> > special code for ext4 in __block_write_begin?=E2=80=99:P
> >
> > So use ext4_block_write_begin() instead.
> >
> > The two functions are basically doing the same thing except for the
> > fscrypt related code. Narrow the scope of CONFIG_FS_ENCRYPTION so as
> > to allow ext4_block_write_begin() to function like __block_write_begin
> > when the config is disabled.
> > And hoist the ext4_block_write_begin so that it can be used in other
> > files.
> >
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  fs/ext4/ext4.h   |  2 ++
> >  fs/ext4/inline.c | 10 +++++-----
> >  fs/ext4/inode.c  | 23 ++++++-----------------
> >  3 files changed, 13 insertions(+), 22 deletions(-)
>
> Thanks for cleaning this up.
>
> There are still some comments in fs/ext4/inode.c that reference
> __block_write_begin.  Can you update them too?
>
> One more thing below.
>
> > @@ -1119,7 +1118,9 @@ static int ext4_block_write_begin(struct folio *f=
olio, loff_t pos, unsigned len,
> >       }
> >       if (unlikely(err)) {
> >               folio_zero_new_buffers(folio, from, to);
> > -     } else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> > +     }
> > +#ifdef CONFIG_FS_ENCRYPTION
> > +     else if (fscrypt_inode_uses_fs_layer_crypto(inode)) {
> >               for (i =3D 0; i < nr_wait; i++) {
> >                       int err2;
> >
> > @@ -1131,10 +1132,10 @@ static int ext4_block_write_begin(struct folio =
*folio, loff_t pos, unsigned len,
> >                       }
> >               }
> >       }
> > +#endif
>
> This #ifdef isn't necessary since fscrypt_inode_uses_fs_layer_crypto() re=
turns
> false (and it's known at compile time) when !CONFIG_FS_ENCRYPTION.
>

Okay. Will make another version.

Thanks,
Stephen

> - Eric

