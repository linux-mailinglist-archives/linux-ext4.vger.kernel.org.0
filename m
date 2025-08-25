Return-Path: <linux-ext4+bounces-9597-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71937B33867
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B64887ACC43
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 08:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215EC288C26;
	Mon, 25 Aug 2025 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="rNu+vRKN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFBD1FB3;
	Mon, 25 Aug 2025 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108928; cv=none; b=D+wDiZkHszruHoVCvQ3PZ8CUuI8KWfJzvIPDNU4hGlnr4AvXuDr7BLGtwiFTVasTxDr76mgI12FBL0MMCuTie5VTIh6aNOpkOZZ205lXUA2s25VliAMZfWlqmjRccVd5KTcHmkr84VjNp+sewWgOd/AL/SYvwo5A+EAeWvMRDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108928; c=relaxed/simple;
	bh=LByR8OtkujGJ9OYhVLpYhW2Vetxj0MFIbNqghCz+cLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kB4ywajdH2PRejBOIK4uNKWfeMrbQaYMRAqSAb5rLytE7W++vACK/TI5mHNQUnsljwEyjof7mIycwxWF1ojhGZy6Kz3JKJW7/XMN3RIbtcTHAQ2vMfo8uUQ1jz3lyaWnwJE8euz9YzZnit58YnAruhtf+a2/resxTK/Af0gFJtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=rNu+vRKN; arc=none smtp.client-ip=212.227.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1756108918; x=1756713718; i=christian@heusel.eu;
	bh=bvMw/hN/dMbt6aDczhjkbAxPwz4eyKouvingsBA2vYk=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rNu+vRKNpKAE88/V7Rk9uOIXW3H3CIn3AM6GkfBXfNA8pnaAamm/Qipd3YfCaa1E
	 PNipPWZJxKXMRXpS3BwHodoKyggpjl5jX1b1Oa0UwnSwb9J1otdEzH6CVSfLveuRG
	 fmHcOb1FxWzbQaNT+cWWjUcNyDHcWZ1J7K9qrcUakHx0is8y8gykIFjOh0rLsGlLE
	 cMXx/AzMTNaynai52nVuEejZhmkUc2EksJDOD4DhEgb8nN7Sqt9/8S6y/Hw4nbHww
	 Kg57yuZK+L/aOOIMJxSR8tMJ47eiy+kHqnkjdae8RBMnnhmoksRYjiCiIsq0sTh5d
	 CMr5ZpefDu2uUF7axw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([94.31.75.247]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MRC7g-1vBOj02xlM-00Xzmo; Mon, 25 Aug 2025 09:55:55 +0200
Date: Mon, 25 Aug 2025 09:55:52 +0200
From: Christian Heusel <christian@heusel.eu>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Luca Boccassi <bluca@debian.org>, Zhang Yi <yi.zhang@huawei.com>, 
	Sasha Levin <sashal@kernel.org>, Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, stable@vger.kernel.org, 
	heftig@archlinux.org
Subject: Re: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
Message-ID: <36950a03-7d6a-455b-bceb-225f9cd28950@heusel.eu>
References: <3d7f77d2-b1f8-4d49-b36a-927a943efc2f@heusel.eu>
 <CAMw=ZnRtmhi8aaO+xsT=kgXYhB8u3sgBdtevrxDWctTLteWYoA@mail.gmail.com>
 <2025082214-oink-kindling-11cf@gregkh>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="suzg447ltmbicq3n"
Content-Disposition: inline
In-Reply-To: <2025082214-oink-kindling-11cf@gregkh>
X-Provags-ID: V03:K1:YaulqtulJauBgdHn8lwwfoPijOs88eQhsj20fFMsFs+2ABxLlw8
 Ch6TDCa8AiWjM5bildqNlnwwZXVC/OSQS2OkrftBvteZR15BkuqdbAXbfcJ8k/0tV2Ye/fu
 IxbKKu/daO0qa8sDJFWai5fHkKqVCrq4eSGz5aGqiGqkiy6jQ3PEqlBSR8axQKpXtsb9gGx
 s/bLeupm/FGY7ypAAk+Ug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xC21lo1F9RU=;uApFh/op5KJ6b6RXzy+GfVYoU0O
 IQ4FMpnbgz3urWZ9OZEpd9X+ZNJa6No8XiO9oNOI2inHEcxJY5fj1HF4agtD7MXVS4UUELOsP
 m33wUWEkkCunWXcGFlUwrK1CtYE3HIE9hbG2gHFY18yl8B/Qjp40jPMxej8G074R2XlAzMMN6
 y9pOtCbpAGf3GGL6IRdV7Si6vwQjk2cqJWALuEET0GW5DilY3zYdeipFL7/JmVnGzgJZhPmKs
 rkDHfA/llYCwVnKLBa6bsuvzGXz+g+SmRpql4PBhGu8bAdq8KfRAQ178jmZ0oddbiGG0zcCmR
 cFvfO5EQrvXWjTae4RmnvlYKKv27t/Qzh3DePny3woGx+duQ1OnxvYglNcHkz9BzL7H+IgHKO
 JaJ0GAIU+hbDGSw/OwXcvQS+pdphMrZ3i41T5DdgcoeoS+pxVqj1hF/40tO6U7bLInZT+aaLU
 aYvYuyfzIvGvuNKW/tmwZ95/6QRJ3pDyTAhVjcPqyuqG3UEVHQc6iCeknoOcWrMq/nXVphtmE
 wRY1kzVkwdyq2Ec372+3qZQ+DqXfiP/O6b57mqOpi0btswMGlH/0KxcgSKgAF+rF1EkLRXdPI
 mIOwRax/l89cVsWVOMEj8t8w2C+KUb9HG0/LShIr16sdi1VtzBpTN5Fe29RqLRhly0Ld1ENJC
 zUh83JR8mFV5P7NLo2YKAxL9hkM1ldTRXtHyb5oMAsFU3p9Ft/AYb5222ZA7EoX9kEIrmYhWY
 6Wno2XrJv0uUU2W9Qkv2H5i/HXoCOKux/yeF+sPRwEeV5W4S+gt3Puj77uo+DGecJ8UjXaGmv
 3+G+wMn34F7V1NUWvb9OhwtEaJcFYP/XB5KSLovTytb7CgQsfpWCyqtIOTBDTAOS9M66vvVGw
 pcQoBDPaH2AZ2X4R1qGyP58wmlQLA46HQ5fesB0BWHImUKJ9r0dmuIZtbcl7Qfuqv/Dm5QN/O
 kM66q5Ot1r6Vo+vw29sz5WO2yAVDYkNwAX8WU0hxxl7lkQT4eDTXBAPsm0rlserfKxkDnOJm8
 gyzA0W1JyMEhP/Qi93/4rUSyA9RHq/P2f1lMK7h4t1HDitdlLVM5CB3LQGWeQuvFv/kFPtt9E
 mvDJ1BhFhNjVOFJNnyv99t1SZ+UvJyqMpu/4kkhMVT2TlW8zM2TgA72T5UeIVXMRUkW4USlfl
 +EO9RowqOTQxKjkbOFRBuvK8NAKLi2NZlF8L/yNw0omji4IwErAxna6uO770aKqq1JwT3EhgE
 J53fzOAvtvQB64gyrsYmFh4wuNRhFTXXoYbyByN+RSqekII18z5oDHN1syogWdUkAGjB86aut
 qTU3nJfLeoCc/vz0+LkTgQI8jCuF3iNGOF6A5DBLEp+kFqnjA0RWhTomghLDaShCZP2tILF39
 LxEXlqLV5DGotIDyOGhstPaI4V0nqAJ+fx55LYg+ql4vwBCpcSDZZD6nTUOPKf5sq7Emhccyi
 IIk5maNWTS8NCXKp3eNwtZMYixyj8jVFSYXADDKHZK5t2WtoJsTm69eLy6Q1iVn39/KgH82GU
 3kMkSZJmhQO44RxuV5So5pK/4rz0OEvnbaOqXIUPZZ9Q1pNq3hvdD2PMdjPG6vQZ2pycRmh4U
 mzPupenb1GLs3hbTejBWZhcUpmueyA+hIF9vlLEGLClYdmU3s/LCNh6KnZUPfO68ZBAep5pGI
 J8nMBnCNjIVj61KA+VmhOi


--suzg447ltmbicq3n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION][STABLE] ext4: too many credits wanted / file system
 issue in v6.16.1
MIME-Version: 1.0

On 25/08/22 02:41PM, Greg KH wrote:
> On Tue, Aug 19, 2025 at 11:38:11PM +0100, Luca Boccassi wrote:
> > On Tue, 19 Aug 2025 at 21:53, Christian Heusel <christian@heusel.eu> wr=
ote:
> > >
> > > Hello everyone,
> > >
> > > the systemd CI has [recently noticed][0] an issue within the ext4 file
> > > system after the Arch Linux kernel was upgraded to 6.16.1. The issue =
is
> > > exclusive to the stable tree and does not occur on 6.16 and not on
> > > 6.17-rc2. I have also tested 6.16.2-rc1 and it still contains the bug.
> > >
> > > I was able to bisect the issue between 6.16 and 6.16.1 to the followi=
ng
> > > commit:
> > >
> > >     b9c561f3f29c2 ("ext4: fix insufficient credits calculation in ext=
4_meta_trans_blocks()")
> > >
> > > The issue can be reproduced by running the tests from
> > > [TEST-58-REPART.sh][1] by running the [systemd integration tests][2].
> > > But if there are any suggestions I can also test myself as the initial
> > > setup for the integration tests is a bit involved.
> > >
> > > It is not yet clear to me whether this has real-world impact besides =
the
> > > test, but the systemd devs said that it's not a particularily demandi=
ng
> > > workflow, so I guess it is expected to work and could cause issues on
> > > other systems too.
> > >
> > > Also does anybody have an idea which backport could be missing?
> > >
> > > Cheers,
> > > Chris
> > >
> > > [0]: https://github.com/systemd/systemd/actions/runs/17053272497/job/=
48345703316#step:14:233
> > > [1]: https://github.com/systemd/systemd/blob/main/test/units/TEST-58-=
REPART.sh
> > > [2]: https://github.com/systemd/systemd/blob/main/test/integration-te=
sts/README.md
> > >
> > > ---
> > >
> > > #regzbot introduced: b9c561f3f29c2
> > > #regzbot title: [STABLE] ext4: too many credits wanted / file system =
issue in v6.16.1
> > > #regzbot link: https://github.com/systemd/systemd/actions/runs/170532=
72497/job/48345703316#step:14:233
> > >
> > > ---
> > >
> > > git bisect start
> > > # status: waiting for both good and bad commits
> > > # good: [038d61fd642278bab63ee8ef722c50d10ab01e8f] Linux 6.16
> > > git bisect good 038d61fd642278bab63ee8ef722c50d10ab01e8f
> > > # status: waiting for bad commit, 1 good commit known
> > > # bad: [3e0969c9a8c57ff3c6139c084673ebedfc1cf14f] Linux 6.16.1
> > > git bisect bad 3e0969c9a8c57ff3c6139c084673ebedfc1cf14f
> > > # good: [288f1562e3f6af6d9b461eba49e75c84afa1b92c] media: v4l2-ctrls:=
 Fix H264 SEPARATE_COLOUR_PLANE check
> > > git bisect good 288f1562e3f6af6d9b461eba49e75c84afa1b92c
> > > # bad: [f427460a1586c2e0865f9326b71ed6e5a0f404f2] f2fs: turn off one_=
time when forcibly set to foreground GC
> > > git bisect bad f427460a1586c2e0865f9326b71ed6e5a0f404f2
> > > # bad: [5f57327f41a5bbb85ea382bc389126dd7b8f2d7b] scsi: elx: efct: Fi=
x dma_unmap_sg() nents value
> > > git bisect bad 5f57327f41a5bbb85ea382bc389126dd7b8f2d7b
> > > # good: [9143c604415328d5dcd4d37b8adab8417afcdd21] leds: pca955x: Avo=
id potential overflow when filling default_label (take 2)
> > > git bisect good 9143c604415328d5dcd4d37b8adab8417afcdd21
> > > # good: [9c4f20b7ac700e4b4377f85e36165a4f6ca85995] RDMA/hns: Fix acce=
ssing uninitialized resources
> > > git bisect good 9c4f20b7ac700e4b4377f85e36165a4f6ca85995
> > > # good: [0b21d1962bec2e660c22c4c4231430f97163dcf8] perf tests bp_acco=
unt: Fix leaked file descriptor
> > > git bisect good 0b21d1962bec2e660c22c4c4231430f97163dcf8
> > > # good: [3dbe96d5481acd40d6090f174d2be8433d88716d] clk: thead: th1520=
-ap: Correctly refer the parent of osc_12m
> > > git bisect good 3dbe96d5481acd40d6090f174d2be8433d88716d
> > > # bad: [c6714f30ef88096a8da9fcafb6034dc4e9aa467d] clk: sunxi-ng: v3s:=
 Fix de clock definition
> > > git bisect bad c6714f30ef88096a8da9fcafb6034dc4e9aa467d
> > > # bad: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: fix insuffici=
ent credits calculation in ext4_meta_trans_blocks()
> > > git bisect bad b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8
> > > # first bad commit: [b9c561f3f29c2d6e1c1d3ffc202910bef250b7d8] ext4: =
fix insufficient credits calculation in ext4_meta_trans_blocks()
> >=20
> > The full kernel warning (immediately after the ext4 fs stops working):
>=20
> I've pushed out a 6.16.3-rc1 that should hopefully resolve this.
>=20
> thanks,
>=20
> greg k-h

Hey Greg,

6.16.3 does indeed resolve the issue, thanks for fixing :)

Cheers,
Chris

--suzg447ltmbicq3n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmisFwcACgkQwEfU8yi1
JYX46A//a6hajRTv75g9ySWeqW+eZy767mmrv1saz+e1tw+RRu5VHYX8qUdOPpZH
Oc6hLJOAvxDjevCKE4lRjP9CQQ7ub+uMDtCfZ2kFowEWEilB62RPZUsrMU14CN2x
pQMhyR0MVR9QkddQSnHX1bhFxszhcANl2bNWoEs7WtJk5TJ3P2bPl6ast+Lp7hIg
u3s8ppOgSNdbfzAIAum2t/dpGQvYJC1o7XXa8YtfP4/3aMqLbn6rPQSUFWxlPMyN
TzzFACqoBrCeg98ab7kDCDMRHNnbrebPLEiT6jnT503zY62b6isOAf67EnZX4m7y
+1Wqm/3x6JgTxBuDKpIZMppIIjEEIPUutBX+dA1ca2GD+2y1wS6UIw97Mm3zHko4
p4+62tump8ymGHVlw3fx3WJmkWPjsKdti4RdAQ884hdmHCBTIx+LGiy+GaKZP6As
f4AZkuEHkJFLcRBFISIZaeeOUdQdBKHqa0cyDwekRG1E6mYvp3XMFHiczsJhaYBd
IOq/JAvhhW6c4X0+/SYunpvv6TiAOhf+zw75DoCnsq7c5FQpqvuMtpcEgUwqRCzE
EM9zCG7bqHpi3rSE7eXwFZ3wTtRGeS371z+RcPLVJMM3CAZnRWV3oZiXUe2czk9B
3HG1WPrHU7oQPSVy8IE6xSmSeM/vDGYiEJEkcKDOsufNT+ZiNWg=
=x8w0
-----END PGP SIGNATURE-----

--suzg447ltmbicq3n--

