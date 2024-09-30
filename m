Return-Path: <linux-ext4+bounces-4399-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2687898AE64
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 22:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E781F2242E
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 20:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF2D1A0BD7;
	Mon, 30 Sep 2024 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="L75wlg9q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5FE1A2561
	for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 20:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727728188; cv=none; b=l9ucvL40veIDIb7BjL9Ns0RcWt3W/Yz1vLhzEhudIdAfhGlRBini4/2XK7+p91nNc2uLEUuMJEF3t4P8/2we2o6gg4Nr3tksDQxtwxp/7TvMGRnXLgch3jFrJcdfGd8i2IzwvvTk7vpbX1OE7BTL5vHk+tuslcukx/aIoHgu9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727728188; c=relaxed/simple;
	bh=Y8oei5HJUrbcLu/Hn5fswTnfWpffxFMJArI6ShsxL2Y=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=OQ9DT6pkUpbVTogK8vVRtMltjnHIbGwnzfZdS6y8gzg8CuFVZDRtWKz7i90TkjyK4UbVClP6yYdzEIn9lFhO/2rNKtAEfQLFMnmN2opc1uFBrlFBeomu0oqRTcIy4vbW1dCIMgQwNaTUN3mAgrqRauVaTWe9Tgih7STSeepuU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=L75wlg9q; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e0a060f6e8so3172908a91.1
        for <linux-ext4@vger.kernel.org>; Mon, 30 Sep 2024 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1727728184; x=1728332984; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQJXQet8faVzQftQpuN2sAznlv/+FRI6yZxfp3aO+bQ=;
        b=L75wlg9qCNkEWGdRj8sir3Y96Hm9ZeSaiTckHyc2mPaXWmVVSkj2s9b93oXNGJY7B/
         P75DO+J0v0kmJErVeq6+VUpLxjsPg45oXOoiOV1bRs4UCio0OfRjOb5bMrcKu7AtHAiQ
         rjqtV9eP8yxUR+XBTwlmIfVqi7JAKO26CV8/6ifT2oACMfpf1tWv3wAY3byYPoO6aBgb
         wuodk3plDEJS1yolG9a+zVqBMrZXtJ9fcP0ajMzc5Yb9jhPE1pHU3hCizSThtlyhFua9
         0CLeVDI1foKN23ZzROws5lB/vO7JWB9+4Lz6ZFhmH+ycvER32gq8WXbgNNzf+6ekQImR
         n8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727728184; x=1728332984;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQJXQet8faVzQftQpuN2sAznlv/+FRI6yZxfp3aO+bQ=;
        b=NsuYB2cPUkWNIEx9XNR1uWZ59xS6eOq+jAjdl7I0eifLbO60MNbB7p90kbLr2AVWii
         w/0N+MSCtUpiQtd4SvIxES2SPQh12P6Lcl4XnO7Ic0mOhyYRt0tJmQNivhB78jMONz5+
         F2TapaEfxl7EoSe69GL7MYR/tmJlTNWKle0wrLBFf7TDWX+joM5HTqGe22pEvxZdrFzd
         zlBjZXpKM/4MaSFtRXx+zmJlplPylH1Bk5dbISbohD4m4ULx83npoGLoGkDFSA6IDDp3
         LJIlwOV4wynAtL8x+wep1PUWUKPb11AMNGlC1XSyMafRn+xdBnp0Is+qYBp7Sy4fsjYV
         JuZw==
X-Gm-Message-State: AOJu0YxOzzG37lFpf4P5TQuOIQ8TdJnlrChKSL0x0+nSto5bx1JRQK+a
	QaxrLtl2ARXDuFzTzXyts544vQjvOw+MqKvthNyzJBDa/qBlsc8g3kfpyYs+GRdcbh0QGbYeYJw
	z
X-Google-Smtp-Source: AGHT+IGNME//8HcjX3/Mhy1ajdWXtlCbnFaD3OaHXZcAlCi4CqitfMO/dGPEqb+VIHXUgY5E9FSgdQ==
X-Received: by 2002:a17:90a:f404:b0:2d8:dd14:79ed with SMTP id 98e67ed59e1d1-2e0b8ea5e93mr14161961a91.31.1727728184336;
        Mon, 30 Sep 2024 13:29:44 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e29606sm8415616a91.56.2024.09.30.13.29.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2024 13:29:43 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <20F34363-9EA4-40D0-B06E-1B35406448EF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_EC4E3756-16AF-4B9F-9B5F-702F45E8DDAB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Corrupted i_blocks field
Date: Mon, 30 Sep 2024 14:29:40 -0600
In-Reply-To: <ec9c3d81-dd5e-4a80-9148-1e0b24cddd1e@dybdal.dk>
Cc: linux-ext4@vger.kernel.org
To: Jesper Dybdal <jd-ext4@dybdal.dk>
References: <ec9c3d81-dd5e-4a80-9148-1e0b24cddd1e@dybdal.dk>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_EC4E3756-16AF-4B9F-9B5F-702F45E8DDAB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 27, 2024, at 8:38 AM, Jesper Dybdal <jd-ext4@dybdal.dk> wrote:
>=20
> I have now a few times experienced a problem with the i_blocks field =
of a few inodes being corrupted (replaced by extremely large numbers).
>=20
> I don't believe that it is a disk error - the file system is on a =
RAID1 partition and the RAID consistency is checked regularly.
> I also find it hard to believe that it is a RAM error - the machine =
has run memtest86+ overnight without finding anything.
>=20
> The files I've seen corrupted are simple small text files that are =
modified only using an ordinary text editor (emacs).
>=20
> Fsck fixes it.
> The system is an up-to-date Debian Bookworm:
>     Linux nuser 6.1.0-25-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.1.106-3 =
(2024-08-26) x86_64 GNU/Linux
>=20
> I do one thing that is not the default for ext4: I use the =
"nodelalloc" option (because several years ago, there was a discussion =
about "delalloc or not" from which I got the impression that nodelalloc =
was probably slightly safer - if the resulting performance reduction is =
not a problem, which it is not for me):
>      /dev/md0 on / type ext4 =
(rw,relatime,nodelalloc,errors=3Dremount-ro)
>=20
> Three examples follow below.  Note that the bad field values, when =
interpreted as 48-bit signed numbers, are numerically small negative =
numbers (-25, -9, -3, respectively).
>=20
> Excerpts from the fsck logs:
> root: Inode 10748715, i_blocks is 281474976710631, should be 5. FIXED.
> root: Inode 10751288, i_blocks is 281474976710647, should be 3. FIXED.
> root: Inode 10748542, i_blocks is 281474976710653, should be 1. FIXED.
>=20
> I don't know when the first two of these corruptions occurred, but the =
last one happened yesterday or the day before.  The file in question was =
/etc/fstab, and I discovered the problem after I had edited fstab on =
Wednesday and rebooted on Thursday.
>=20
> The corrupted files can be read and copied without problems.  I have =
not dared to delete any of those files before fsck had fixed them.
>=20
> What is going on here?

This looks like an underflow of the used blocks count on the inode:

    281474976710631 =3D 0xffffffffffe7
    281474976710647 =3D 0xfffffffffff7
    281474976710653 =3D 0xfffffffffffd

This is 2^48 blocks, which is the limit for the number of blocks that =
fit
into the available inode fields (32-bit i_blocks_lo, 16-bit =
i_blocks_hi).

There is likely some kind of accounting error in the code.  Is anything
unusual with access patterns for those files (large xattrs/ACLs, are =
they
files or directories or special files. mmap, truncate, fallocate, etc.)?

If you are able to reproduce with the /etc/fstab editing, possibly =
strace
could help to identify if something unusual is being done to the file.

Cheers, Andreas






--Apple-Mail=_EC4E3756-16AF-4B9F-9B5F-702F45E8DDAB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmb7CjQACgkQcqXauRfM
H+BquRAAoG/b+pjTbpbmJNGt0l28OvsmJ8qmh4k9dIV7VpsbT8Xa+gboh2lncQ1V
8P2OWVYHrFFyyed8yjW4QSvsmg5EwOUNUoU0954dt8tI7JM5C5EbKrxbiHyHbHS8
fcNZBwg4F64yl2dSrOOx4KFGCkNbT+Uhf2Qw+RILSIxlriO4ZJbGFQKoeJ/ls4DA
QqZONRect1/laMi7bS8kLHj8BxG+9cEo3snhrHPcXHXH5yBl7CIz85t2ltc9/I+N
fbXmWVJ/xYfLyCw7DTe3u0jPezL959h2xSfrwHis5C/5CWsUssKXdI+kaEWn8uB/
Fd28NKwNHQHHxSnyCYtwcoGbRMsLqw6/PYmrZloBYgn54mTkOwwj2XEviFPC3Dgw
JaEtf/wSdL0XY8ZUwtBXT4tNZZcT+xFACvz/yXokwOhR0S4oUezbP6EJY+gj2E+d
Cg5VduwErjxRHm9oRDwpd+BKBUMOw0j8WvwhFgshmzDV4aY0oOG7pXadW1/kAi5w
GO5WBX/4U3fRVZbRJ7U1ib2GComhbHT6v7TYhwco0ufhRXjpkHZpkxvjRy/4aF9l
/mDoACRMC61GGqSp6CPWK4RBvRj0y4J7hhQFM958czwCe1DLqOmbNqFsTrDmsqU/
GPaEBATgs7cI0C1fy3KWPH79TR6RBB0HKBJTQGm6Sd81y3ItJ2c=
=7myS
-----END PGP SIGNATURE-----

--Apple-Mail=_EC4E3756-16AF-4B9F-9B5F-702F45E8DDAB--

