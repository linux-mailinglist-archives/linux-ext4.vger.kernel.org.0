Return-Path: <linux-ext4+bounces-2453-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FBA8C2FAE
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 07:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CEC1F22BBC
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 05:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BC74779D;
	Sat, 11 May 2024 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="CO/ADUBe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93A208A0
	for <linux-ext4@vger.kernel.org>; Sat, 11 May 2024 05:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715405693; cv=none; b=rY8/NfI623PlstmZXgW6Bu29PzE2efqWG/hsJyG6ZnAbte8NImXJLC7qrajqXmKwrmNBEWQQeQyW86ySiejO9FaYvdhqW7OmzBJpTjG8mZ9vPHFUrTKaljhdsYqi3c9ETDPNQNLvAtuvDC43GYnIsMLZRe0MdmW5PEs4RHSB4MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715405693; c=relaxed/simple;
	bh=V0OIeU2K/e3Qj/CVLYhcSEnrkfba/979DXki9MHQ89o=;
	h=Content-Type:MIME-Version:Content-Disposition:In-Reply-To:
	 References:Subject:From:Cc:To:Date:Message-ID; b=tsZvCkvxkJcwDMZDD92fBbKXAEGWOzlGDZRZ7X8LBkqkchIsMIj5S40C2FkYpMH5nFequwxHTsArpxEC2+ZlaOzsE4IB/6W8jgmitznCm1inNC3XopY9f1Ec4/vqOSwK+uZE/3bNKLc2/jpLKxWI1039R37m+uICtzFmHhWfyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=CO/ADUBe; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Received: from localhost (unknown [37.4.230.225])
	by mister-muffin.de (Postfix) with ESMTPSA id 3F5E527E;
	Sat, 11 May 2024 07:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1715405683;
	bh=V0OIeU2K/e3Qj/CVLYhcSEnrkfba/979DXki9MHQ89o=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CO/ADUBeO5vOBDYx1jcKuZhtTxT67oXbMspWw8vkzRqb+EUgwoAvZNKCvSgXbHeAa
	 JrBDWDDafZ826Qu6Kd5N5iwP/ijMY/SDr1H/CYzIKMBdLwk60ra62BOY6W0iGDui34
	 syUYdySVyhTtPYRvjxN5NwdCN6gxUA8nE2n37Qn0=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============0751526021854325053=="
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240505001020.GA3035072@mit.edu>
References: <171483317081.2626447.5951155062757257572@localhost> <171484520952.2626447.2160419274451668597@localhost> <20240505001020.GA3035072@mit.edu>
Subject: Re: created ext4 disk image differs depending on the underlying filesystem
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc: linux-ext4@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Date: Sat, 11 May 2024 07:34:42 +0200
Message-ID: <171540568260.2626447.10970955416649779876@localhost>
User-Agent: alot/0.10

--===============0751526021854325053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ted,

thank you very much for your (as usual) very detailed and comprehensive rep=
ly!
:D

Quoting Theodore Ts'o (2024-05-05 02:10:20)
> If your goal is to create completely reproducible image files, one questi=
on
> is whether keeping the checksums identical is enough, or do you care about
> whether the underlying file is being more efficiently stored by using spa=
rse
> files or extents marked unitialized?
>=20
> Depending on how much you care about reproducibility versus file
> storage efficiency, I could imagine adding some kind of option which
> disables the zeroout function, and forces e2fsprogs to always write
> zeros, even if that increases the write wearout rate of the underlying
> flash file system, and increasing the size of the image file.  Or I
> could imageine some kind of extended option which hacks mke2fs to zero out
> the lifetime writes counter.;

the good news is, that the fix in my situation is very simple: create the
filesystem on a tmpfs first and then copy it into 9p fs afterwards. Tada, t=
he
created images will be reproducible. I think there are multiple ways forward
with which I'd be happy with:

 1. leave everything as it is. It's just one more copy operation on my end.=
  I
    can just document that if your underlying file system is stupid, you mi=
ght
    not get the same identical image as somebody with a more intelligent
    filesystem does.

 2. allow resetting fs->super->s_kbytes_written to zero. This patch worked =
for
    me:

--- a/lib/ext2fs/closefs.c
+++ b/lib/ext2fs/closefs.c
@@ -504,6 +504,7 @@ errcode_t ext2fs_close2(ext2_filsys fs, int flags)
                                (fs->blocksize / 1024);
                if ((fs->flags & EXT2_FLAG_DIRTY) =3D=3D 0)
                        fs->flags |=3D EXT2_FLAG_SUPER_ONLY | EXT2_FLAG_DIR=
TY;
+               fs->super->s_kbytes_written =3D 0;
        }
        if (fs->flags & EXT2_FLAG_DIRTY) {
                retval =3D ext2fs_flush2(fs, flags);


    If my goal is to create disk images, one could argue that what the end =
user
    is interested in, is the filesystem writes that *they* performed and th=
at
    the disk image they receive should therefor have the counter start at z=
ero.

 3. Somehow do magic with the zeroout function. If anybody has too much
    free-time... ;)

As an end-user I am very interested in keeping the functionality of mke2fs
which keeps track of which parts are actually sparse and which ones are not.
This functionality can be used with tools like "bmaptool" (a more clever dd=
) to
only copy those parts of the image to the flash drive which are actually
supposed to contain data.

Would you be happy about a patch for (2.)? If yes, I can send something over
once I find some time. :)

Thanks!

cheers, josch
--===============0751526021854325053==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmY/A2oACgkQ8sulx4+9
g+GY4RAAu5QOgV8+BVPzH966NS9RpJu7TR/rtj9XjnNJF1yU+YlMY7TU9zD40Gq4
B8aKsg1o4mEj2pOSfIPEwL4CkCZ/AfOWQAt2pxfAtWoh1iOjeQdaz6ZBVjkt6/2O
HMznP6w1eCrcIjr8AanAUAT7KxZWxxYki25LCcsiehzXvY59Yu6vUdundbrOo6Eh
AahB0NXIYC52ZcwTKrltPSt7JRt5jBE3qgkRpenzln0o6JKU9UBOUqTgqW9ENsL2
d5RL1YUV/UrkTpyPKKMUmj86oHixmlNm0qzvMXtgnAIhXEmsflytT9c+kMb2JXYN
WbbwdI+w1YOXDhwPc53ZDsiNGfDSrHJeAmnuhHu3mm28PtRZirJYexYvZuzf6dMu
v+c/01EwAqSuzrW4bGi2CkGKHiWjmXqeO+f9/hVOCA8+MVzonAgBU5woROTwtQEx
h21rLYtbLdfy5bf+YUo22WZ1Fq6+JI0LpeU8qXb0cBB0Sox4x/kEDfCV4CR3RdlL
Ey4Z4n689h3612wBMXLzKQ4lwJMVOjGt+yzTTfmFTeASSBmtBpRqGfydwinvbopQ
pfUc6rdaYLPimS5kVK44fe40eSZQBkZQL2YflRBsom8H1jDAQEff4XKQ68EmmQ+4
bAa/c7DjdjpSwgjOxf86f5eu9mj7a2cZKXsvu3d6An3y1STaQNI=
=JLUI
-----END PGP SIGNATURE-----

--===============0751526021854325053==--

