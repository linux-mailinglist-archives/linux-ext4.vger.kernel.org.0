Return-Path: <linux-ext4+bounces-12767-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D44DAD17BB0
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 10:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9426330089A4
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jan 2026 09:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497E138171E;
	Tue, 13 Jan 2026 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AATCChff"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4540D310777
	for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 09:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297353; cv=none; b=I9kvtNPz1zBk1EqYffwT6jO6SzLxB3FNgjdCDApkhon027E/B3EDAP9DGCSkIaZDzse4scTv9Dz7rEAxJEPIjeHZ1QGTyivvZUkgnnFGmP6rwzPqU9RYCTzBu6/z/Y6wE8jCnAlUZ+nWnLY0fI8H7nq3lLIffJhHWy0sA4Wze5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297353; c=relaxed/simple;
	bh=jsTQpeqf//7r5JEUYZk3rsuws1lH6BKGLO8ueWv8/Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CgxlZIDPjJRL2+EB/N9igzSNIhESqpFwDP+6v4bRVgZQ0KY26YoL6J5HULPiTA1HbVZyLXD8SKY+9iklv3cKdJIc/nAMO8+OSjvcEDi3nbW+pM55IAZJFgsYfF+zAEIq08d5AGtD14u1clX5bidCYe4bMV7xB28LWYIFcsfHMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AATCChff; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so4201744f8f.0
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jan 2026 01:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768297349; x=1768902149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qWi0gxImcfe6sPFx7hTgeNf8sv4DbP5sxUz/myXx3jk=;
        b=AATCChffCjft4duhkcdXSrluLr9HUREMOTCWhpwSLUSCwO3ltkm0pmcL4w1IV0FG3p
         Ht+0RfeR4pfmGLH4qIUypGB4vCSo9o+PET4FJX9EvaAi/pgt6kuSOUzQnJXIEGCy9k43
         Rcv8REBI0/LIxwYk6tDI0y7ok08FToqE03KAIFz8s8b+G2ObtG1DULtJlSlHi/YTYg5v
         YwqDXnZuyBCT3Gc5no2dngt6g7k+3mduiahF37Cd/3FUOymS6jg2zHCbRw5WGWT6jZEd
         gvQr5aX2Usg6mx5TVURufHqY8ewpDlRkXYpnJAxh/tqzA3kr01NeI///rJnknfHkpIzK
         5UiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768297349; x=1768902149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWi0gxImcfe6sPFx7hTgeNf8sv4DbP5sxUz/myXx3jk=;
        b=JUgJTZ21VHOT9DgB/9uE0Ukgwca8CWaLiO6vEra969nNOQnClp5hUnvh9KIBYE2a+Y
         T+XkdIl8b3yN2F4RLb0nfvrmg8vFnK7wGgmehZ3xKnICwdOFGhxf3nI5KLP3asyHdt2n
         OiMdgbhUL8ZRtrnlHP38SJsggU+V+E+lJB8zDZa8mkBY1gUSO5p2kqm2qCto7tcSFCFJ
         ha0aTVQxFj9FhibR5Kx/cESAPKXtgajAeqZBPSV6aE5yQsat3qqwwEGOhl4x5oe+wmqW
         NWzm5IPNiVaDVzctFlhGnvtvt/GYskT+AxTkMZQowasp3r4W1YnHdJYg457JWmQ7Vx8r
         lhdA==
X-Forwarded-Encrypted: i=1; AJvYcCXPhPfBvsh0Uyfpt+eeLlpuoYUUjtFEJ+LR+ROZqwot57/3uWfV7MhysphA8KR1zXkILR8KpF4ieMo8@vger.kernel.org
X-Gm-Message-State: AOJu0YxumnDGs6EKlC5iLZrrcM3TwhqVy5ZM7HiVF8xHC5+YsAc1AkXl
	fme/yRcG3rK+s1qv1SiN6kjzWcm2R/8DvRnwYj+uob2oJ+jenli3/U2A
X-Gm-Gg: AY/fxX4jdX8qhFq6Ht49/znVI9FUvYoEkfBIriRz1NmVh/8eMxIoy70BoqOxhFRTNn6
	gW3TI3hKGiNfx0I3OvWLr0gBwMcEUCo7fsxYNIGHZP9epnWPs9xgS3/yoGk9rW5xdnATtiLRuaP
	1Pug4TABMkPaGFzBOPnY0ivVriqv2HS1FWN3UJk1bBFW6mde4Rkd4wZWRf3RisttO0jCv6cdvFL
	pdkoE5g89EUXhyqGJP2B6FRY/Il5obs/P9uEc15y/MnQG48rNOahHZ5QOvyJGOvI/zhrdPX3q0D
	WVDzuZY1sgLwE7UFR9DKNtAY3qt2okDxQYGUuESdKglo4owmKBvKKXRRQ8MzYMjEX+hegmHRFqo
	+12GPrxvpwgE91hKTGJof2XvN/b13yrsQNh+Z7Pel5SdChKdGVMCe0jAwVRc2kmL2cQI+owQTA1
	yIeKG4p9GZrgiQcpijBBe76E+H74oCTZCPdMDmy1Q9sJo2fMleYA9Z
X-Google-Smtp-Source: AGHT+IGCluKpScy5UmgAEwir80+RNqkqkTWiXHqvvRnvopn9jhUBxHczRPNLOdlhz4XUibpj8zHkVw==
X-Received: by 2002:a05:6000:178a:b0:430:f449:5f18 with SMTP id ffacd0b85a97d-432c37644b4mr26662191f8f.46.1768297348421;
        Tue, 13 Jan 2026 01:42:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5dfa07sm43196646f8f.25.2026.01.13.01.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:42:28 -0800 (PST)
Date: Tue, 13 Jan 2026 09:42:26 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Brian Masney <bmasney@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro
 <viro@zeniv.linux.org.uk>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Miklos
 Szeredi <miklos@szeredi.hu>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 30/44] fs: use min() or umin() instead of min_t()
Message-ID: <20260113094226.144973b2@pumpkin>
In-Reply-To: <aWVs2gVB418WiMVa@redhat.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-31-david.laight.linux@gmail.com>
	<aWVs2gVB418WiMVa@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Jan 2026 16:51:22 -0500
Brian Masney <bmasney@redhat.com> wrote:

> Hi David,
>=20
> On Wed, Nov 19, 2025 at 10:41:26PM +0000, david.laight.linux@gmail.com wr=
ote:
> > From: David Laight <david.laight.linux@gmail.com>
> >=20
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned lo=
ng'
> > and so cannot discard significant bits.
> >=20
> > A couple of places need umin() because of loops like:
> > 	nfolios =3D DIV_ROUND_UP(ret + start, PAGE_SIZE);
> >=20
> > 	for (i =3D 0; i < nfolios; i++) {
> > 		struct folio *folio =3D page_folio(pages[i]);
> > 		...
> > 		unsigned int len =3D umin(ret, PAGE_SIZE - start);
> > 		...
> > 		ret -=3D len;
> > 		...
> > 	}
> > where the compiler doesn't track things well enough to know that
> > 'ret' is never negative.
> >=20
> > The alternate loop:
> >         for (i =3D 0; ret > 0; i++) {
> >                 struct folio *folio =3D page_folio(pages[i]);
> >                 ...
> >                 unsigned int len =3D min(ret, PAGE_SIZE - start);
> >                 ...
> >                 ret -=3D len;
> >                 ...
> >         }
> > would be equivalent and doesn't need 'nfolios'.
> >=20
> > Most of the 'unsigned long' actually come from PAGE_SIZE.
> >=20
> > Detected by an extra check added to min_t().
> >=20
> > Signed-off-by: David Laight <david.laight.linux@gmail.com> =20
>=20
> When doing a mips cross compile from an arm64 host
> (via ARCH=3Dmips CROSS_COMPILE=3Dmips64-linux-gnu- make), the following
> build error occurs in linux-next and goes away when I revert this
> commit.

I've looked at this one before.
I think there is another patch lurking to fix it.

> In file included from <command-line>:                                    =
                                                          =20
> In function =E2=80=98fuse_wr_pages=E2=80=99,                             =
                                                                          =
=20
>     inlined from =E2=80=98fuse_perform_write=E2=80=99 at fs/fuse/file.c:1=
347:27:                                                                   =
=20
> ././include/linux/compiler_types.h:667:45: error: call to =E2=80=98__comp=
iletime_assert_405=E2=80=99 declared with attribute error: min(((pos + len=
=20
> - 1) >> 12) - (pos >> 12) + 1, max_pages) signedness error               =
                                                          =20
...
> fs/fuse/file.c:1326:16: note: in expansion of macro =E2=80=98min=E2=80=99
>  1326 |         return min(((pos + len - 1) >> PAGE_SHIFT) - (pos >> PAGE=
_SHIFT) + 1,
				max_pages);

'len' is 'unsigned long' and the expression is unsigned on 64bit.
But 'pos' is s64 so the expression is signed on 32bit.
IIRC the final version might have been (equivalent to):
	len +=3D pos & (PAGE_SIZE - 1);
	return min(DIV_ROUND_UP(len, PAGE_SIZE), max_pages);
which generates much better code as well (no 64bit maths).
I don't think len can overflow, read/write are limited to INT_MAX - PAGE_SI=
ZE
bytes in the syscall interface.

	David

>=20
> This is on a cento-stream-10 host running
> gcc version 14.3.1 20250617 (Red Hat 14.3.1-2) (GCC). I didn't look into
> this in detail, and I'm not entirely sure what the correct fix here
> should be.
>=20
> Brian
>=20


