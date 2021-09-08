Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E927A403D52
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345355AbhIHQIu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 12:08:50 -0400
Received: from THBLACKELECTRIC.COM ([207.244.97.128]:39468 "EHLO lsw.cs1local"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235639AbhIHQIq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Sep 2021 12:08:46 -0400
Received: from [72.29.63.102] (helo=localhost)
        by lsw.cs1local with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <thb@b-tk.org>)
        id 1mO06o-0002b9-Nr; Wed, 08 Sep 2021 16:07:34 +0000
Received: from thb by localhost with local (Exim 4.94.2)
        (envelope-from <thb@b-tk.org>)
        id 1mNz01-0001TC-2C; Wed, 08 Sep 2021 14:56:29 +0000
Date:   Wed, 8 Sep 2021 14:56:29 +0000
From:   "Thaddeus H. Black" <thb@debian.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Dr. Tobias Quathamer" <toddy@debian.org>,
        linux-ext4@vger.kernel.org, debian-doc@lists.debian.org,
        "G. Branden Robinson" <g.branden.robinson@gmail.com>
Subject: Re: [PATCH] filename.7: new manual page
Message-ID: <YTjPHZEpjzn7Ufg/@b-tk.org>
References: <YTX+PEtj60O/TdMh@b-tk.org>
 <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QaviqNKVsYSaVU58"
Content-Disposition: inline
In-Reply-To: <a18a8f3d-78a7-15e5-7a6e-0f4740c84667@gmail.com>
X-Spam_score: -0.8
X-Spam_bar: /
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--QaviqNKVsYSaVU58
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[To limit spam, I'll probably copy future emails only to Alejandro,
Branden, Michael and the linux-man list.]

Alejandro:

I am collecting and applying your and Branden's edits.  Meanwhile,
three questions and some comments occur.

On Mon, Sep 06, 2021 at 04:21:09PM +0200, Alejandro Colomar (man-pages) wro=
te:
> See man-pages(7):
>=20
>    Sections within a manual page
>=20
>               [...]             =20
>               DESCRIPTION
>               [...]             =20

When in doubt, consistency is best.  Good point.

> You could move sections into subsections of DESCRIPTION, and the current
> subsections into tagged paragraphs (.TP).

Question 1:  do you happen to know of a good example of an existing
manual page that already does this?  If you did, then I could follow the
example.  Otherwise, it might be tricky, for the existing subsections
already have tagged paragraphs and other structure within them.
Perhaps .RS/.RE could be used.  I am not sure.

I notice that bash(1) does not follow your advice but dash(1) does.
However, dash(1) has no subsubsections.  In any event, a manual
page *about* conventions, like filename(7), should *obey*
conventions.  I just need to figure out how to obey with good style
in this instance.

On the other hand, there is an alternative, though I do not say whether
it is a better alternative.  The alternative would be to avoid
subsubsections by using colons ':' in subsection titles, instead,
approximately as follows.

    NAME
    DESCRIPTION
        Legal filenames
        Legal filenames:  reserved characters
        Legal filenames:  reserved names
        Legal filenames:  long names
        Legal filenames:  non-UTF-8 names
        Conventional filenames
        Conventional filenames:  the POSIX Portable Filename Character Set
        Conventional filenames:  special semantics
        Conventional filenames:  the full stop to introduce a format extens=
ion
        Soft conventions
        Soft convention:  low line versus hyphen-minus
        Soft convention:  letter case
        Locales and Unicode
        Unconventional filenames
    CONFORMING TO
    SEE ALSO

Question 2:  within the constraints of established manual-page
conventions, which alternative would you and Branden advise?

> > +The format-extension convention is all but universally recognized.
>=20
> Non-native English speakers may have trouble understanding "all but". May=
be
> s/all but/not/?

When a reviewer like you informs me that (for whatever reason) he or she
did not understand a sentence the first time he or she read it, this is
valuable feedback; for if the reviewer did not understand it the first
time, then other readers probably also will not understand it the first
time.  The sentence ought to be rewritten to make reading the sentence
twice unnecessary.

In the sentence in question, I did not mean "not" but rather "almost."

Question 3:  in your opinion, would s/all but/almost/ make the sentence
more readable?  If not, then another option would be s/all but/nearly/.

(For information, I have some time to work on the patch today but little
time during the following two or three weeks.  Therefore, if I am slow
to reply after today, this does not mean that I have forgotten!  If not
today, then I will deliver PATCH v2 some time on or before Sept. 28.)

--QaviqNKVsYSaVU58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEM1APDU+pwMhnuF4GcGMmQy2FIrwFAmE4zxcACgkQcGMmQy2F
Iry/6g//XFoDlbv/YP2tjivBqT5tBhVRYn8hLCp2yzkba6gxL40JuzpfBt5pwhug
rly47YBD5TrbFSxEJ2dpxxDj9HZxk99uUc9Oo4P8qZj5azIwiDnuKd1Fvxo41tTe
QdqQnWBdsk/W+CrD2/yeN5M7lnNDpfUeYhvLvjj5k1gJx1Ao/fSpvGK+m0t38Nyu
47Vx8Z8wkkbZc4CmJd9pDxaEY/xz8/8eUor4+msH2cK1mfxIeFM+0/U9S82D5NU6
h339LQ849RZxmDllPkAIa2MRlSdiZTJeYeGif5zSjIWghA+Y3hhPOTemmt8S3oiY
EAOKsAKsBxBcwApqP5Z8H7yMsntDVb8n54+NEjp93xFPDP5J0dzvqWC4V6VgO0gU
4ADgGI5JdtnONInS10Uc5N8egsR2ibQZWK1J+oksbBToclHy7VCCOHT8qRoOjxsA
LB4GDFEm5ARtEnfLesq09+mSdC3YR2BOS3ojvb1FWMbyL/Pt5M5SOvC4shgBWweX
pLNFyOCsJO/uNzU411IiHuJL2G05ltwh8T2Yvcz8RurHVnRFVBqeaVipbRhKYHeg
hLRWyWUIkFyJM6tOKUrm3esGQm2Tv7a/hUg4dY4x6OhRcj/YQzi3UAAoqP0oijRv
82KnW0pvn7txwxPqMXxxZcKnnDLBQTqP3gTX8mJKI/P3w8GVqqc=
=z95u
-----END PGP SIGNATURE-----

--QaviqNKVsYSaVU58--
