Return-Path: <linux-ext4+bounces-11946-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5074FC75EAC
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 19:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D40032A9E7
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Nov 2025 18:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8A33D6E6;
	Thu, 20 Nov 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmMpqIv8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB8277CAB
	for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763663233; cv=none; b=t7GjjKMqGhk3bJv0uG4FS1QK1FQSTIJGAueVQOwTLsyXywgGYwztiBOPXkWmAHFctuWNbK8V/Hggbxq13C0XeXds7tGETQv4A96WxxK4RMfuMC1muUCdJqrjyo/Hi3EIksV1LqS/QzsDkusDcfLh9fARRTxnh4eoWrhZQXlJ2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763663233; c=relaxed/simple;
	bh=3mFOMEzr5wqaR4NhAtveDLmt2cDUPWO73J6j8mhB9Cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PtWnzsqTnROlNrpM3tl4oFXl/wlqWR3cXTKaK+bNR8/Yo9+WG3JnwTH0jh/zwGs3cK1MRVjuOGuY+SLCYduwWAzvxLKEqVg51e3b1gNRQ5OThaSo+wivuHPnhFuxUY1ZyudzBPtgzfSar/qSjL6x833aeEEUTu1p7j7vhGiUJ2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmMpqIv8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so10595505e9.2
        for <linux-ext4@vger.kernel.org>; Thu, 20 Nov 2025 10:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763663230; x=1764268030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8fJtuCapvhL71if6qUwtqOoOt+BwZG7dFYeJXfQ/kU=;
        b=KmMpqIv8dUD0ltvfeY/83GyYAQvuiOUxALjU+IhNqFTo1/f9AE+uqIVROoYJvSzf0p
         Jf8I/h5vYFD3gnw7fgGcrJqKlHgC9pSaowWnQL0hnmsCNi/2+7lvRsuxN3NIxkfitTs2
         t0mR1LZcN/1IavSRmb9VEtmjyajKa5+n4vM/+JmhoBeHJ4DnvyKP54iFpAMMwY0j6H90
         EGi94CM7AqmEToUwpGIvB3DDQZTa9Z6ZTdPJZjjUnuvTr3rEC1WUOv8RXMYTNKs9hm9k
         LVzSpeCfK6onldVGLd4a735f7AJ/w/UfchpviudxNLpUstu/yi0l/pdyRnewXRMcxB6z
         SftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763663230; x=1764268030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v8fJtuCapvhL71if6qUwtqOoOt+BwZG7dFYeJXfQ/kU=;
        b=sIomMoWolPbHlD89cQhM89Ey14IXx7pAuP4JPNEsh181J248glkH//5Y6KZw7S9tsW
         JarEgWIk+GoUeCVWK9YWExEJClbwd0nqpy61QKt1NjPSrMYDnDlMsKzw4cCN8jOHPyJd
         ylaeUZti+K97XZZ6IQw2Vf/e3GWuj1AfEUHh+pieLryMqo2Z7Zf+4qoRb4Z9+87mP9rY
         wwb6Dx1n4r+RVP1kBk3XulsatcuqkznMw5nXTLxfXv9Wn5lCzS367UxbcxpQ9vxvQkTJ
         2Bfvpsqj3Y4qybfHFsOnt9K9C37+RHo9r4xpbXNcH2KuijhIYRzb0kjfyfTaCRm1Fe7T
         SILw==
X-Forwarded-Encrypted: i=1; AJvYcCWxjdG0GLaZ8mfIt370QjDxwpzqWmFhttIvdj3ltiNsPOyXSy21VILx99vTOmUInGfz16NPvQJoR78c@vger.kernel.org
X-Gm-Message-State: AOJu0YxAjvOi7hxS7DTtThR213TETlgqkq2/KD/+3hZmh9Mof+MwBDUO
	qJ0t/4e2uH36rCEYwohHAPPDnOo5k5IsiosQzCr+tcrKMCVAF/PbLg2G
X-Gm-Gg: ASbGnctZfuALqZxEBSYobFCL4mJqiHWyAW1edaOuha0i2ekW6FVdTFLpRElzHxYoZHS
	L+umP0goS1K02oKvT7fg5PHph13YOEu61YKEj+4z3O1x75cJHZ9sKj+TDSRCHl5EHCfXXLaCrXr
	laHezVcwh/FMXeD0ktCIX0gvqVj4DFefIPh9hjpogI4lCuQD+r29NOv/p6FoFNuukD7TNafYOJc
	JBU0LhbVle6GtoaLPkiUCPj0B3nxHaqGCPRj/7W7+iRTgeUddwd5zYyBcwELlsof2hpvRvkS5Ko
	bzaMTVGztyk+kjyb3yPoRx4kCTQrzkmBqBbQUW0d/1kT5s4C1E+ZERpuDCl47VlTXV+j8VTB6Jm
	LTZTBKL5ZIxS8UPzIpmJJynEtjbZX3wj9DqElmEk86Ue3AKspfQeKmsWE9Dzxg+hr4RfG0G4ZWU
	VwKS9Hbk36zxBoH/BqeMXeIIsbKfwH71fYlzKs1K0TwdT/8VBkZyT9
X-Google-Smtp-Source: AGHT+IF/VJ6EtSI84/riBNr2CPA5rd9zxWi3pGW4+BUaR0EHv1CSP4BA7oyKWRxgRSMLvThhRobH5Q==
X-Received: by 2002:a05:600c:474a:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-477b8954699mr49047475e9.2.1763663229701;
        Thu, 20 Nov 2025 10:27:09 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf36d1fasm2110145e9.7.2025.11.20.10.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:27:09 -0800 (PST)
Date: Thu, 20 Nov 2025 18:27:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Guan-Chun Wu <409411716@gms.tku.edu.tw>,
 Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: improve str2hashbuf by processing 4-byte chunks
Message-ID: <20251120182707.42c225f5@pumpkin>
In-Reply-To: <aR9Ir6fdzD5_0Pkn@google.com>
References: <20251116130105.1988020-1-409411716@gms.tku.edu.tw>
	<20251116193513.0f90712a@pumpkin>
	<20251120155816.GB13687@macsyma-3.local>
	<aR9Ir6fdzD5_0Pkn@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Nov 2025 00:58:23 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Hi Ted,
>=20
> On Thu, Nov 20, 2025 at 10:58:16AM -0500, Theodore Tso wrote:
> > On Sun, Nov 16, 2025 at 07:35:13PM +0000, David Laight wrote: =20
> > >=20
> > > The (int) casts are unnecessary (throughout), 'char' is always promot=
ed to
> > > 'signed int' before any arithmetic. =20
> >=20
> > nit: in this case the casts aren't necessary, but your comment is not
> > correct in general, so I just wanted to make sure it's corrected in
> > case someone later looks at the mail archive.
> >=20
> > "char" is not always signed.  It can be signed or unsigned; the C
> > specification allows either.  In this particular case, scp is a
> > "signed char", not "char".

It doesn't matter - as pointed out below.
Both 'signed char' and 'unsigned char' are promoted to 'signed int'
before ANY operation.
Well unless sizeof(char) =3D=3D sizeof(int) when 'unsigned char' is
promoted to 'unsigned int' - which is technically valid and was
true for the C compiler for an old DSP (everything was 32bits).

This is one difference between K&R C and ANSI C - K&R promoted
'unsigned char' to 'unsigned int'.
So there was always the chance that compiling in ANSI mode would
break working code.

> >=20
> > Secondly, it's not that a promotion happens before "any" arithmetic.
> > If we add two 8-bit values together, promotion doesn't happen.  In
> > this case, we are adding a signed char to an int, so the promotion
> > will happen.
> >  =20
> I believe David was referring to the C11 spec 6.3.1.1:
>=20
> If an int can represent all values of the original type (as restricted
> by the width, for a bit-field), the value is converted to an int;
> otherwise, it is converted to an unsigned int. These are called the
> integer promotions. All other types are unchanged by the integer
> promotions.
>=20
> The spec explicitly mentions char + char in 5.1.2.3 example:
>=20
> EXAMPLE 2 In executing the fragment
> char c1, c2;
> /* ... */
> c1 =3D c1 + c2;
> the =E2=80=98=E2=80=98integer promotions=E2=80=99=E2=80=99 require that t=
he abstract machine promote
> the value of each variable to int size and then add the two ints and
> truncate the sum. Provided the addition of two chars can be done
> without overflow, or with overflow wrapping silently to produce the
> correct result, the actual execution need only produce the same result,
> possibly omitting the promotions.

So with:
	char c1, c2;
	int i1, i2, i3;
	...
	i1 =3D c1 + c2;
	i2 =3D (int)c1 + (int)c2;
	i3 =3D (unsigned int)c1 + (unsigned int)c2;
the values of i1, i2 and i3 are all the same (on a 2s compliment cpu for i3)
regardless of whether char is signed or unsigned (they do depend on
the signedness of char).

>=20
> So IIUC conceptually the promotion happens, even if the compiler
> optimizes it out in the actual execution.

Any it is pretty much only x86 and m68k that have instructions for
byte arithmetic.
So for everything else if you assign the result of an arithmetic
operation to a char/short local variable (which is hopefully in
a register rather than on stack) the compiler has to add extra
instructions to mask the value back to 8 (or 16) bits and likely
keep sign extending it as well.

People also forget that the type of 'cond ? c1 : c2' is also 'int'.

Part of it is historic, the pdp11 is a 16bit cpu with byte-addressable
memory and sign-extending byte memory reads (which is probably why char
defaults to signed).

	David


>=20
> Link: https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf
>=20
> Regards,
> Kuan-Wei


