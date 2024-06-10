Return-Path: <linux-ext4+bounces-2839-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307599026A7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2024 18:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CA41C2267C
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2024 16:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C4142E94;
	Mon, 10 Jun 2024 16:25:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303F182495
	for <linux-ext4@vger.kernel.org>; Mon, 10 Jun 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.213.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036719; cv=none; b=BORv2Be4dB/I6f399+83M6YUzFhpGD2/M/WIEX9+WRVQaD1ibG0RhpTjEyMSF9bIl1BFNN5rriM/IiVaHn9qmQzxtA/AODT9TK/rlsChhQc/98mJ9+t1rQe4WbKOxjDN6kTISBBFchTAQ/WZDd4EzfR79RHkDkpr6771T67qAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036719; c=relaxed/simple;
	bh=HWyu4k3TKEtzeCrlUrlhUfzKjT/REFBNbfGD4iMt0Nc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jfUcs49Lx9nEnQHxc2ER55nQNx46QnHudTG5BDOmifPtNlOM6axpm+MKJGbBxzhkKf3JITrfUdHb3k9yV3z/tTn9lZPIfw3tevDud/Q3mjILtp3QoJdIoj5A1Pw4pILfmPfAAEKmSp/velSihngdCjCqnQr9O3FxJMVWEPqiCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=95.217.213.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from 213.219.156.63.adsl.dyn.edpnet.net ([213.219.156.63] helo=deadeye)
	by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ben@decadent.org.uk>)
	id 1sGhV6-0008E5-BZ; Mon, 10 Jun 2024 18:04:04 +0200
Received: from ben by deadeye with local (Exim 4.97)
	(envelope-from <ben@decadent.org.uk>)
	id 1sGhV5-00000006Qcn-2x4W;
	Mon, 10 Jun 2024 18:04:03 +0200
Message-ID: <e6797603353b8162df6c29777ed5936af4d11b32.camel@decadent.org.uk>
Subject: Re: linux: ext4 corruption with symlinks
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-ext4@vger.kernel.org, =?ISO-8859-1?Q?Herv=E9?= Werner
	 <dud225@hotmail.com>
Cc: Diederik de Haas <didi.debian@cknow.org>, 1039883@bugs.debian.org, 
	Salvatore Bonaccorso
	 <carnil@debian.org>
Date: Mon, 10 Jun 2024 18:03:58 +0200
Autocrypt: addr=ben@decadent.org.uk; prefer-encrypt=mutual;
 keydata=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
In-Reply-To: <DB4PR02MB936085F4449207358A9943568FABA@DB4PR02MB9360.eurprd02.prod.outlook.com>
References: <168802788716.2369531.1979971093539266086.reportbug@ariane.home>
 <ZL5DB7vU3GnIx588@eldamar.lan> <2002858.macj2W6JUv@bagend>
 <DB4PR02MB936085F4449207358A9943568FABA@DB4PR02MB9360.eurprd02.prod.outlook.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-+YiL7wBynssCBQyl48fY"
User-Agent: Evolution 3.50.3-1+b1 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.156.63
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-+YiL7wBynssCBQyl48fY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 5 Nov 2023 16:12:41 +0000 Herv=C3=A9 Werner <dud225@hotmail.com>
wrote:
> Hello
>=20
> I'm sorry for the delay.
>=20
> > Are you able to reliably preoeduce the issue and can bisect it to
> > the introducing commit?
> I faced this issue on real data but I struggled to find a reliable
> scenario to reproduce it. Here is what I just came up with:
>=C2=A0=C2=A0 sudo mkfs -t ext4 -O fast_commit,inline_data /dev/sdb
>=C2=A0=C2=A0 sudo mount /dev/sdb /mnt/
>=C2=A0=C2=A0 sudo install -d -o myuser /mnt/annex
>=C2=A0=C2=A0 cd /mnt/annex
>=C2=A0=C2=A0 git init && git annex init
>=C2=A0=C2=A0 for i in {1..2}; do
>=C2=A0=C2=A0=C2=A0=C2=A0 for i in {1..10000}; do
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dd if=3D/dev/urandom of=3Dfile-${i} b=
s=3D1K count=3D1 2>/dev/null
>=C2=A0=C2=A0=C2=A0=C2=A0 done
>=C2=A0=C2=A0=C2=A0=C2=A0 git annex add -J cpus . >/dev/null && git annex s=
ync -J cpus && git annex fsck -J cpus >/dev/null
>=C2=A0=C2=A0=C2=A0=C2=A0 git rm * && git annex sync=C2=A0 && git annex dro=
punused all
>=C2=A0=C2=A0 done
>=20
> Then at some point the following error appears:
>=C2=A0=C2=A0 EXT4-fs error (device sdb): ext4_map_blocks:577: inode #39423=
43: block 4: comm git-annex:w: lblock 1 mapped to illegal pblock 4 (length =
1)
[...]

I can also reproduce this error message using the above script and:

- Linux 6.10-rc2
- A 2 GiB loopback devic instead of /dev/sdb

I bisected this back to:

commit 9725958bb75cdfa10f2ec11526fdb23e7485e8e4
Author: Xin Yin <yinxin.x@bytedance.com>
Date:   Thu Dec 23 11:23:37 2021 +0800
=20
    ext4: fast commit may miss tracking unwritten range during ftruncate

It is still possible to cleanly revert that commit from 6.10-rc2, and
doing so removes the error message.

Ben.

--=20
Ben Hutchings
Reality is just a crutch for people who can't handle science fiction.


--=-+YiL7wBynssCBQyl48fY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmZnI+4ACgkQ57/I7JWG
EQmRtRAAg6uc0G0KIpx1IeCTSGDNwKES+MNkfxcS6SCuZbKw9bDy5v0OYFhWfVkg
3FQ5xu98uTUW3+d0xS9qV7EUziJJqSk8v8PEtzffeOWX5duJBDAAnQ4ed4Na5JG0
EiKcxauZQsajXTJGS/KKq9+Lif4RZzNXNLk6kEEWWDyDCnWIfJr47AW9QizSqTfh
B26xxzrc0lrMyVwQyyOgGIdpbLJdJZ2RnhdvKVT4U2oV8gJYB4xi7JYAdN5D5LNx
p7nhzvd5fXzSzU0Mv48JzQq8FfIOiwCFrcl8lEtSnchjgdJnZnxzktW+5NVwAe6m
X7qrl60CP8uGI86mDPbN15ayG1frdi+o6j8RkkZCJAt2PlT2xdzP5Nruh48GJcwt
AmznfFNFZUFHSc5Zp4vO5+3YjEV3zs210+XQ0IN2Jjg/6RWb+izREvaoCMaFN/JK
wCQ9UDthadySReunWEbprMRovete0x494dq+7X86j90ElZ2d3x3i67POqK6whm8o
SmpDC3iHvT0Jqq6AJ0uycFfCZ2ZFuIU7ki7L07DLuMeLOI22ns1WmrRCzlHZUUZ6
Pkdj+HDBD3aAkb/JnWLnlR7rnhgO9OiYUeZCLpUugP1P8JTvrJ9BRp3LegTR23A6
IUTQA1LN02T1sBOacZHwTCS1s2x7e0Ri8yPOu4QejixUD/Tm5j0=
=5oIT
-----END PGP SIGNATURE-----

--=-+YiL7wBynssCBQyl48fY--

