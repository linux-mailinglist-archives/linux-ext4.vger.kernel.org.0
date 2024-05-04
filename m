Return-Path: <linux-ext4+bounces-2296-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBA8BBC7D
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7660282788
	for <lists+linux-ext4@lfdr.de>; Sat,  4 May 2024 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479823B29D;
	Sat,  4 May 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="jUyeUf66"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E42622F00
	for <linux-ext4@vger.kernel.org>; Sat,  4 May 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714833767; cv=none; b=bt5GqpCiLZOkF0mPsbI4jCxQtxUSNhEEuTFH1/rVzKyM/y8sFXW5eWuef6G4E7oCRgsxYMxiUuooHrVTMLfdu+Cy5SLl1ugIYeE7cHl3DLpFFL8MhO8Gm4qqckhKzj1mgC9zC4xMx/RCJacmNvViUsC11EFgMrXk7BPrfEVTGTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714833767; c=relaxed/simple;
	bh=NZAlC+VfeNY8Uo4/rEESESaDZ1CWN7kU4D4ghCz1Omk=;
	h=Content-Type:MIME-Version:Content-Disposition:From:To:Subject:
	 Date:Message-ID; b=qmsgOCW3dARdl7+c6yd+Q1sIs+V3wJfrtAEWv+jUPUdlGpxAv3B+bkI2ANyIX9bwOQJcWUhrp6sWJwUA5I82897i2PJ8zr9p+uQWvXxiP4kIy0FMHy4prRztkqJSDDl/xnYSdRKi5EBUurRFT+62CMa81NFcFN5VDCbQnaNjvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=jUyeUf66; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Received: from localhost (ip2504e6e1.dynamic.kabel-deutschland.de [37.4.230.225])
	by mister-muffin.de (Postfix) with ESMTPSA id 6734A28B
	for <linux-ext4@vger.kernel.org>; Sat,  4 May 2024 16:32:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1714833171;
	bh=NZAlC+VfeNY8Uo4/rEESESaDZ1CWN7kU4D4ghCz1Omk=;
	h=From:To:Subject:Date:From;
	b=jUyeUf66XzwCpFGLujc/vaUjJq2Vn0brQv0JvYnynR7X4r9ej59hi8rhF/iTYx572
	 l+7Wl5afQgLIJ0athLbmJ9qLhbRdNtXw2E44docBkdRAbtO1zkIfkvOvSVYEGV63fu
	 OhR/5NtdxN3ggY4edKBDpIe6Do0IjfaxLdo5hW+w=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============5291737487209645571=="
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
To: linux-ext4@vger.kernel.org
Subject: created ext4 disk image differs depending on the underlying filesystem
Date: Sat, 04 May 2024 16:32:50 +0200
Message-ID: <171483317081.2626447.5951155062757257572@localhost>
User-Agent: alot/0.10

--===============5291737487209645571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I originally observed this issue when creating ext4 disk images on a 9p
filesystem which differed from the images I created on a tmpfs. I observed =
that
the difference also exists when the underlying file system is fat32, so I'm
using this as an example here. For what it's worth, the ext4 filesystem ima=
ges
created on a tmpfs are identical to those created on an ext4 fs. To demonst=
rate
the issue, please see the script at the end of this mail (it requires sudo =
to
mount and unmount the fat32 disk image). As you can see from the printed
hashes, the disk images produced outside the fat32 disk are always identica=
l as
expected. The diff between the reproducible images and those stored on fat3=
2 is
also very short but I don't know what data is stored at those points:

@@ -85,7 +85,7 @@
 00000540: 0000 0000 0000 0000 0000 0000 0000 1000  ................
 00000550: 0000 0000 0000 0000 0000 0000 2000 2000  ............ . .
 00000560: 0200 0000 0000 0000 0000 0000 0000 0000  ................
-00000570: 0000 0000 0401 0000 8c04 0000 0000 0000  ................
+00000570: 0000 0000 0401 0000 4900 0000 0000 0000  ........I.......
 00000580: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 00000590: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000005a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
@@ -125,9 +125,9 @@
 000007c0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000007d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 000007e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
-000007f0: 0000 0000 0000 0000 0000 0000 264c 0251  ............&L.Q
+000007f0: 0000 0000 0000 0000 0000 0000 64ca bba5  ............d...
 00000800: 1200 0000 2200 0000 3200 0000 9d03 7300  ...."...2.....s.
-00000810: 0200 0000 0000 0000 babb 8a41 7300 2004  ...........As. .
+00000810: 0200 0400 0000 0000 babb 8a41 7300 69f5  ...........As.i.
 00000820: 0000 0000 0000 0000 0000 0000 0000 0000  ................
 00000830: 0000 0000 0000 0000 bc7a 6e31 0000 0000  .........zn1....
 00000840: 0000 0000 0000 0000 0000 0000 0000 0000  ................

Any idea what is going on? Is there a better way to diff two ext4 disk imag=
es
than diffing the xxd output? If I try diffing the dumpe2fs output I get the=
se
differences:

@@ -32,7 +32,7 @@
 Maximum mount count:      -1
 Last checked:             Fri May  3 16:14:49 2024
 Check interval:           0 (<none>)
-Lifetime writes:          1164 kB
+Lifetime writes:          73 kB
 Reserved blocks uid:      0 (user root)
 Reserved blocks gid:      0 (group root)
 First inode:              11
@@ -44,7 +44,7 @@
 Directory Hash Seed:      0b7f9cfd-0113-486c-a453-4f5483bd486b
 Journal backup:           inode blocks
 Checksum type:            crc32c
-Checksum:                 0x51024c26
+Checksum:                 0xa5bbca64
 Checksum seed:            0xf81d767d
 Orphan file inode:        12
 Journal features:         (none)
@@ -56,7 +56,7 @@
 Journal start:            0
=20
=20
-Group 0: (Blocks 1-2047) csum 0x0420
+Group 0: (Blocks 1-2047) csum 0xf569 [ITABLE_ZEROED]
   Primary superblock at 1, Group descriptors at 2-2
   Reserved GDT blocks at 3-17
   Block bitmap at 18 (+17), csum 0x7abcbbba

Why would these bits differ depending on the filesystem on which the disk i=
mage
is stored? Is there a way to equalize this information so that the disk ima=
ge
looks the same independent on the underlying filesystem?

Thanks!

cheers, josch

#!/bin/sh
set -eu
mkfs() {
	imgpath=3D"$1"
	rm -f "$imgpath"
	dd if=3D/dev/zero of=3D"$imgpath" bs=3D1024 count=3D2048 2>/dev/null
	echo H4sIAAAAAAAAA+3OQQrCMBCF4Vl7ihwho9PkPKVEtJgU2rjo7a240JXSRSnC/20ew5vFy=
/P5ekulzUk24xfB7JkaG/+ZL3oUtaCnYE2IUZZbTcX57Sa93afajs5JP0zd5cvfr/5P5bkbSk2l=
HvZeAgAAAAAAAAAAAAAAAABY4wEWZDwwACgAAA=3D=3D \
	| base64 -d \
	| env LC_ALL=3DC.UTF-8 SOURCE_DATE_EPOCH=3D1714745689 /sbin/mke2fs -d - \
		-q -F -o Linux -T ext4 -O metadata_csum,64bit \
		-U 0b7f9cfd-0113-486c-a453-4f5483bd486b \
		-E hash_seed=3D0b7f9cfd-0113-486c-a453-4f5483bd486b \
		-b 1024 "$imgpath"
	md5sum "$imgpath"
}

mkfs "/dev/shm/disk.ext4"
mkfs disk.ext4

rm -f fat32.img
mkdir -p mnt
dd if=3D/dev/zero of=3Dfat32.img bs=3D1024 count=3D65536 2>/dev/null
/sbin/mkfs.vfat -F 32 fat32.img
sudo mount -o rw,umask=3D0000 fat32.img mnt
mkfs mnt/disk.ext4
bash -c 'diff -u <(xxd mnt/disk.ext4) <(xxd disk.ext4) || true'
bash -c 'diff -u <(/sbin/dumpe2fs mnt/disk.ext4) <(/sbin/dumpe2fs disk.ext4=
) || true'
sudo umount mnt
mkfs disk.ext4
mkfs "/dev/shm/disk.ext4"
rm "/dev/shm/disk.ext4" disk.ext4 fat32.img
rmdir mnt
--===============5291737487209645571==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmY2Rw8ACgkQ8sulx4+9
g+EgwxAAixKFTjRPvk1WI+G5pcpCJUdXM7DP4pbwBaEN5qtvBl2mQlfqT18akynH
c/DCtIgFwV0TU0cqwSO6HegAUWwo87PiPVBY7RiZT9xHz/n2PdSgR4vv5eua8oH4
s9jNzvy51WFFp3HUHAlYQVWzjttYmf900Vcsf3sGGeoJjnSi9CZjceS7E/1qCtgW
+XEFB3OeTOMl6gw/Y7tP91tqHztG8OMq0HeArgcKgSr1qIUpJSQ3wentBWglOncD
5GeZMFick3ETG3rT3n+UE8Z+ETQNbbo2i7QR/kRWsdcP5vcUUiMynjrxEXPLdSBY
opTVWTmfhmRLqFZu5Jb2KYgt6IBmeQblB64LzHU0Ud7oW/rKEY2c2DyQjnN8S9Bv
nLM9zA+K19N3fdYiwQCOX1p4SvgUVzywdtyVg/XcNhAQqt3rX5QHoeDYMc0BcF2o
e8PKWBwJE0jH7F5r5qCj4TRdLTL6a8ZTDz8Ijb7hpnbfXqJjv8e/s35upQ55X/Nm
miYViEOe9Ee+vxFm4/g5dvWfMWTPWv807Uy22/XltiGFT2E912whRCcAXaW+uWB/
2p1rlIlYdMD0PemA+q+YNIGj43BeW5VCi1EuQGyx4uftFM6j9M6Tq1ydFdbpFkeL
ld66pOh8xfk4TWBCb81GpT0HsgurmzMPOOTilWoa8lDCF4obBII=
=9rT8
-----END PGP SIGNATURE-----

--===============5291737487209645571==--

