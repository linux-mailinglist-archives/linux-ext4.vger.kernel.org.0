Return-Path: <linux-ext4+bounces-2297-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E898BBD84
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 19:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7906A2825C2
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 17:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83905FDD3;
	Sat,  4 May 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="COsI1sgU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DA11711
	for <linux-ext4@vger.kernel.org>; Sat,  4 May 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714845215; cv=none; b=qa9vp6DFd5wT0mkjQ4u1//S/EfssvOfuOR2NeV9ARBnT+q8N3Fv3ZNIozknurn8Gf2athqWrLxbyC4jO+8brqlqF5/XUqdCVjYnM4blcxnFtWX7owh9TTrpcZ+FFfQrIY1dueEHtAEfQLvnpGt/YPDTgurpGJwX0Qpc+GJxlucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714845215; c=relaxed/simple;
	bh=FyafaEbH0R8SzxOGrFwY6mwdnL9KQHVH3avXedCE2hg=;
	h=Content-Type:MIME-Version:Content-Disposition:In-Reply-To:
	 References:Subject:From:To:Date:Message-ID; b=LnhizoW1hN9n6xMfKI/t9FIbepyCCSH1ObsMLt5Te/vCdkznciHI/ZNH7k9MOVeonGNGLApeqYEyxdSvvcDBMz6hRPkD4eOJdnIVRr2es8+kChXe07u9+ACM92v7wXR1msErage2qanYZIgLhaNFvhXZ4+N+6gKq2kQ4I7h3CMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=COsI1sgU; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Received: from localhost (ip2504e6e1.dynamic.kabel-deutschland.de [37.4.230.225])
	by mister-muffin.de (Postfix) with ESMTPSA id 185DD27E
	for <linux-ext4@vger.kernel.org>; Sat,  4 May 2024 19:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1714845210;
	bh=FyafaEbH0R8SzxOGrFwY6mwdnL9KQHVH3avXedCE2hg=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=COsI1sgUm7AwYpvIL55qsnATpiHfv6IFWyrk+8OjGH74HNfu+ci2pny2GsWli8Gnz
	 z6nvDjUxBUom0mKJltEtVGP7rYLoq842aVcJdGw06eZwXf6cqg9B7GClPfaesPHrea
	 YWDYWJtQAEnqdW9PgCZIOMTAn9biZ15RQ6X4gJQs=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============8318157665090275533=="
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <171483317081.2626447.5951155062757257572@localhost>
References: <171483317081.2626447.5951155062757257572@localhost>
Subject: Re: created ext4 disk image differs depending on the underlying filesystem
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To: linux-ext4@vger.kernel.org
Date: Sat, 04 May 2024 19:53:29 +0200
Message-ID: <171484520952.2626447.2160419274451668597@localhost>
User-Agent: alot/0.10

--===============8318157665090275533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Quoting Johannes Schauer Marin Rodrigues (2024-05-04 16:32:50)
> I originally observed this issue when creating ext4 disk images on a 9p
> filesystem which differed from the images I created on a tmpfs. I observed
> that the difference also exists when the underlying file system is fat32,=
 so
> I'm using this as an example here. For what it's worth, the ext4 filesyst=
em
> images created on a tmpfs are identical to those created on an ext4 fs. To
> demonstrate the issue, please see the script at the end of this mail (it
> requires sudo to mount and unmount the fat32 disk image). As you can see =
from
> the printed hashes, the disk images produced outside the fat32 disk are
> always identical as expected. The diff between the reproducible images and
> those stored on fat32 is also very short but I don't know what data is st=
ored
> at those points:
>=20
> @@ -85,7 +85,7 @@
>  00000540: 0000 0000 0000 0000 0000 0000 0000 1000  ................
>  00000550: 0000 0000 0000 0000 0000 0000 2000 2000  ............ . .
>  00000560: 0200 0000 0000 0000 0000 0000 0000 0000  ................
> -00000570: 0000 0000 0401 0000 8c04 0000 0000 0000  ................
> +00000570: 0000 0000 0401 0000 4900 0000 0000 0000  ........I.......
>  00000580: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>  00000590: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>  000005a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> @@ -125,9 +125,9 @@
>  000007c0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>  000007d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>  000007e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> -000007f0: 0000 0000 0000 0000 0000 0000 264c 0251  ............&L.Q
> +000007f0: 0000 0000 0000 0000 0000 0000 64ca bba5  ............d...
>  00000800: 1200 0000 2200 0000 3200 0000 9d03 7300  ...."...2.....s.
> -00000810: 0200 0000 0000 0000 babb 8a41 7300 2004  ...........As. .
> +00000810: 0200 0400 0000 0000 babb 8a41 7300 69f5  ...........As.i.
>  00000820: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>  00000830: 0000 0000 0000 0000 bc7a 6e31 0000 0000  .........zn1....
>  00000840: 0000 0000 0000 0000 0000 0000 0000 0000  ................
>=20
> Any idea what is going on? Is there a better way to diff two ext4 disk im=
ages
> than diffing the xxd output? If I try diffing the dumpe2fs output I get t=
hese
> differences:
>=20
> @@ -32,7 +32,7 @@
>  Maximum mount count:      -1
>  Last checked:             Fri May  3 16:14:49 2024
>  Check interval:           0 (<none>)
> -Lifetime writes:          1164 kB
> +Lifetime writes:          73 kB
>  Reserved blocks uid:      0 (user root)
>  Reserved blocks gid:      0 (group root)
>  First inode:              11
> @@ -44,7 +44,7 @@
>  Directory Hash Seed:      0b7f9cfd-0113-486c-a453-4f5483bd486b
>  Journal backup:           inode blocks
>  Checksum type:            crc32c
> -Checksum:                 0x51024c26
> +Checksum:                 0xa5bbca64
>  Checksum seed:            0xf81d767d
>  Orphan file inode:        12
>  Journal features:         (none)
> @@ -56,7 +56,7 @@
>  Journal start:            0
> =20
> =20
> -Group 0: (Blocks 1-2047) csum 0x0420
> +Group 0: (Blocks 1-2047) csum 0xf569 [ITABLE_ZEROED]
>    Primary superblock at 1, Group descriptors at 2-2
>    Reserved GDT blocks at 3-17
>    Block bitmap at 18 (+17), csum 0x7abcbbba
>=20
> Why would these bits differ depending on the filesystem on which the disk=
 image
> is stored? Is there a way to equalize this information so that the disk i=
mage
> looks the same independent on the underlying filesystem?

The diff becomes a bit smaller when using
-E lazy_itable_init=3D0,assume_storage_prezeroed=3D0,nodiscard

@@ -85,7 +85,7 @@
 00000540: 0000 0000 0000 0000 0000 0000 0000 1000  ................
 00000550: 0000 0000 0000 0000 0000 0000 2000 2000  ............ . .
 00000560: 0200 0000 0000 0000 0000 0000 0000 0000  ................
-00000570: 0000 0000 0401 0000 ac04 0000 0000 0000  ................
+00000570: 0000 0000 0401 0000 4900 0000 0000 0000  ........I.......
 00000580: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 00000590: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000005a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
@@ -125,7 +125,7 @@
 000007c0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000007d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000007e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
-000007f0: 0000 0000 0000 0000 0000 0000 fb8d a90f  ................
+000007f0: 0000 0000 0000 0000 0000 0000 64ca bba5  ............d...
 00000800: 1200 0000 2200 0000 3200 0000 9d03 7300  ...."...2.....s.
 00000810: 0200 0400 0000 0000 babb 8a41 7300 69f5  ...........As.i.
 00000820: 0000 0000 0000 0000 0000 0000 0000 0000  ................

@@ -32,7 +32,7 @@
 Maximum mount count:      -1
 Last checked:             Fri May  3 16:14:49 2024
 Check interval:           0 (<none>)
-Lifetime writes:          1196 kB
+Lifetime writes:          73 kB
 Reserved blocks uid:      0 (user root)
 Reserved blocks gid:      0 (group root)
 First inode:              11
@@ -44,7 +44,7 @@
 Directory Hash Seed:      0b7f9cfd-0113-486c-a453-4f5483bd486b
 Journal backup:           inode blocks
 Checksum type:            crc32c
-Checksum:                 0x0fa98dfb
+Checksum:                 0xa5bbca64
 Checksum seed:            0xf81d767d
 Orphan file inode:        12
 Journal features:         (none)


The "Lifetime writes" being much higher on fat32 suggests that despite
"nodiscard", less zeroes were written out when ext4 or tmpfs are the underl=
ying
FS?

Thanks!

cheers, josch
--===============8318157665090275533==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmY2dhYACgkQ8sulx4+9
g+HkOBAAjgHV4v0L4BXR03VadrNQJw8welBnJfWNrpASPF9eXMA8zCGbD2lIC3tk
aVHWyk/AoYOSvZp7ED74pr8W8SSTmBNrqdEwsJLg18b2Ix09X+07j8nW5pjw56B5
6ERMQjl07U21PHkV7SJE9R6ZGXHhI6grxf1wy5vDRjRP4l7R6wVyxfFuN4VLk4FD
Ur3bEUQaqYj620g/jeZwJTKPjtCYEYeEMtAZuKq8ZHVyZcjZpwbjkihVwBkr5Mjj
SFp1H7/RsvbL08u3LWUD54N2qrt21TMuY1NMtdPUVCmbv29xRnKu5jyWjBNRPfHn
Cs+aaHjEC6RUA6AfwPRC07DGQCnlv1PVZeiHFP21OTpv7d0I746pS3qSeS6OlQpa
7EBwUNboZZECJhiRhxumaZ1BfLE63zNUQruAgL6R/HFN1Xy0CYRbOu3zOhizGxJ6
GmiyNpB/19dfr9L+M7gSACchOONXtFtH9JnM3w0Ef8MuFg1Y0Io+vuwBNswGUsoU
YodRqeUqHKUxE0iyd90k3oXoKK9BrRVWLO8WrbkpCDQT/LH486f0d5C0Aus+biwE
5gOZwydl11M4lyZsAdcoORlPK/rvxaGoC/uKyD3Sl2y6wgpvbXNyoC6w+M1szulf
iFbg2RXhHJdRJReC/sFg4vaSSazGCZxHcU3X7gvlLccjBtpEFmY=
=rVim
-----END PGP SIGNATURE-----

--===============8318157665090275533==--

