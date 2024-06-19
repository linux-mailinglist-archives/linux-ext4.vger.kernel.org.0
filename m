Return-Path: <linux-ext4+bounces-2898-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D1590EF51
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 15:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E695828213B
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2024 13:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7814C581;
	Wed, 19 Jun 2024 13:47:18 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A0514388B
	for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2024 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.217.213.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804837; cv=none; b=YcPmoVdaY9Ad5c74WhNU8XKa11XjsP/ejYeIb99gh9QICSw3MWBRscZ36qIw2SQF2qS0qWpPEZeklMHCs+ddLyfe5LdGucqvZ8/lgwRkkZcqvINYuxezwhhZTYoF42qzTUF+DXCQBMc71FJP3AoRjEncrOzrikVlTRr7P4DNRWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804837; c=relaxed/simple;
	bh=zaPijcmrBiDbzZ7ulstvpLzWoEoGqHb1hT++px7/NtE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Waot40cdmphLrE952VSgsGTFCcihR9gFUyTV+WrGt1hP3WfJ1tlfjlBZsOxzyALk3USS1ZQYxLLQSEWTIDVYwb9OKKc6NI9oJ8LgBEVC7SNG41IYH+LSYDcAdeSHVqMsKSGaYc0QODUYp6k3BaYuXivDeufKlChgR+vD/TdxY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=95.217.213.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from 213.219.156.63.adsl.dyn.edpnet.net ([213.219.156.63] helo=deadeye)
	by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ben@decadent.org.uk>)
	id 1sJveV-0003Mo-QJ; Wed, 19 Jun 2024 15:47:07 +0200
Received: from ben by deadeye with local (Exim 4.97)
	(envelope-from <ben@decadent.org.uk>)
	id 1sJveV-00000008RFr-0rvb;
	Wed, 19 Jun 2024 15:47:07 +0200
Message-ID: <142f06efb14253305ba407c034d400c36b2926de.camel@decadent.org.uk>
Subject: Re: [PATCH] ext4: don't track ranges in fast_commit if inode has
 inlined data
From: Ben Hutchings <ben@decadent.org.uk>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>, 
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
 linux-ext4@vger.kernel.org, 1039883@bugs.debian.org
Date: Wed, 19 Jun 2024 15:47:06 +0200
In-Reply-To: <87r0ctbbyc.fsf@brahms.olymp>
References: <20240618144312.17786-1-luis.henriques@linux.dev>
	 <47173a890acd8f92bcfa391263f86f73c2d37ec7.camel@decadent.org.uk>
	 <87r0ctbbyc.fsf@brahms.olymp>
Autocrypt: addr=ben@decadent.org.uk; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-wHR/vvPxj2h/5RvQk6i1"
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


--=-wHR/vvPxj2h/5RvQk6i1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-06-19 at 08:58 +0100, Luis Henriques wrote:
> On Wed 19 Jun 2024 12:30:38 AM +02, Ben Hutchings wrote;
>=20
> > On Tue, 2024-06-18 at 15:43 +0100, Luis Henriques (SUSE) wrote:
> > > When fast-commit needs to track ranges, it has to handle inodes that =
have
> > > inlined data in a different way because ext4_fc_write_inode_data(), i=
n the
> > > actual commit path, will attempt to map the required blocks for the r=
ange.
> > > However, inodes that have inlined data will have it's data stored in
> > > inode->i_block and, eventually, in the extended attribute space.
> > >=20
> > > Unfortunately, because fast commit doesn't currently support extended
> > > attributes, the solution is to mark this commit as ineligible.
> > >=20
> > > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1039883
> > > Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> >=20
> > Reported-by: Herv=C3=A9 Werner <dud225@hotmail.com>
> > Tested-by: Ben Hutchings <benh@debian.org>
> >=20
>=20
> Thanks a lot, Ben.
>=20
> > I think this should also have:
> >=20
> > Fixes: 9725958bb75c ("ext4: fast commit may miss tracking unwritten ran=
ge during ftruncate")
> >=20
> > unless you think the problem is even older than that.
>=20
> If my understanding is correct (hopefully someone will confirm that!), I
> think the problem goes further back.  That commit just makes it more
> likely to be visible, but handling of inlined data is incorrect since the
> fast_commit merge.  So, I guess that's better to simply add:
>=20
> Cc: stable@vger.kernel.org

That makes sense to me.

Ben.

--=20
Ben Hutchings
For every complex problem
there is a solution that is simple, neat, and wrong.


--=-wHR/vvPxj2h/5RvQk6i1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmZy4VoACgkQ57/I7JWG
EQkhpg/9EG64L5Hq9d8HkeJ2ckKQ35aj+uVe1lukwzOxn3BhqLa4QBBjcUAxaeMC
uYDCsHdSXQzxfpVZd1dL31eGgFxpjOANxgVBTvqzFQlOkBakmRu5V6z5NoDkiw2U
d/AjPr7tL1hvxr2BibDlEgz11NIimYRDKaAtyPYUuHCm2iQFwzVthgvyHUk5NPn+
rUQlydKMhy6RpujBuXvfB3vTI42PMeEpbFfJKjniVPP1C/R+w/rC9vpOjyXMJXIH
les1jIcR1lQ74w60FkpWj4u2deNBGvZBthKlmFIUWIDDgwtjbEmpsX5WN9U3ftUw
zAgAnOdNKNIUK+MQOTpOkXBte8XcI6XQ0eiYa6Xs+X6Bgqb7U+totKPJKZFFHzlB
G7R+bQDtWw57xMigehuHK0YtRukWyxAp32Mvu9MIIJur0k6qujVzAClAwYmetmUa
p+DK08v48pmSw7xCgAV7lknYlQ6QHlh7BF/3Q8HRdlv/Pz7TbjWZO0N9y4ih/Btv
r71X+Ysc634s6S9JYohSQup6Tx+dcsHz3Z0uNU5a86YyxgOLrJtbe60fRZ4mdmMh
QQM1qrhXq9wqOUhpUMNiCVkV8YB2vosOyz+Aamt+u1vCLH/DuM5ofqlCdIf9D0v/
l8ONeWuQDYsp6YfB4LU0ELFr9vaAUZna6SYKzaIhl8I0iXZQjyE=
=Biqz
-----END PGP SIGNATURE-----

--=-wHR/vvPxj2h/5RvQk6i1--

