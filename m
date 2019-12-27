Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822CE12B3BF
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 10:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfL0J4V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 04:56:21 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:32666 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfL0J4V (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 04:56:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577440576;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5aK1+NDtiYPzmCQNo6eOoKi5LVv00vD927S/Nr7xXCQ=;
        b=DvH6WDDn1bSu20Gpp1igKsqlTG4Pyo3mEP+uVREQIVL41YEUSgEYGZ+z42USPTQUk6
        cFfLZRfTSWcXXwFosCBC0L58+rtR4ABdC0XyNpaHRs043JlleVpRtzTek4EDO1vELfOs
        TrgbbS2T6ToBdzdlEiFJbvivPuuJmxuyLO6olxSgq5KKFmEtHLTkO38Hm+eeuzhD57eu
        H3pYJ1ymEFmS96W5hOc+lIPzPjF22GGBYrHuKFoGh4QlFgKT6IP171kHl5M/GlcBj5JP
        ROhzm/eEStiVYaBJJKa4QTYrtBP4FdemJN+w1984AEUFciqOKcO1YtsxTDgTYw0dDzh4
        P5vw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbJ/ScSKV5"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id e09841vBR9tRE0W
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 27 Dec 2019 10:55:27 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Ted Ts'o <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] Rework random blocking
Date:   Fri, 27 Dec 2019 10:55:27 +0100
Message-ID: <2958196.rnPSVNvCH9@tauon.chronox.de>
In-Reply-To: <E464D551-1631-4EA8-ADFB-852E16D29CA9@amacapital.net>
References: <4820831.xlnk3tY4r2@tauon.chronox.de> <E464D551-1631-4EA8-ADFB-852E16D29CA9@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Donnerstag, 26. Dezember 2019, 13:46:52 CET schrieb Andy Lutomirski:

Hi Andy,

> > On Dec 26, 2019, at 8:04 PM, Stephan Mueller <smueller@chronox.de> wrot=
e:
> >=20
> > =EF=BB=BFAm Donnerstag, 26. Dezember 2019, 12:12:29 CET schrieb Andy Lu=
tomirski:
> >=20
> > Hi Andy,
> >=20
> >>>> On Dec 26, 2019, at 5:29 PM, Stephan M=C3=BCller <smueller@chronox.d=
e>=20
wrote:
> >>> =EF=BB=BFAm Montag, 23. Dezember 2019, 09:20:43 CET schrieb Andy Luto=
mirski:
> >>>=20
> >>> Hi Andy,
> >>>=20
> >>>> There are some open questions and future work here:
> >>>>=20
> >>>> Should the kernel provide an interface to get software-generated
> >>>> "true random" numbers?  I can think of only one legitimate reason to
> >>>> use such an interface: compliance with government standards.  If the
> >>>> kernel provides such an interface going forward, I think it should
> >>>> be a brand new character device, and it should have a default mode
> >>>> 0440 or similar.  Software-generated "true random numbers" are a
> >>>> very limited resource, and resource exhaustion is a big deal.  Ask
> >>>> anyone who has twiddled their thumbs while waiting for gnupg to
> >>>> generate a key.  If we think the kernel might do such a thing, then
> >>>> patches 5-8 could be tabled for now.
> >>>=20
> >>> What about offering a compile-time option to enable or disable such
> >>> code?
> >>> Note, with the existing random.c code base, there is no need to have a
> >>> separate blocking_pool. The ChaCha20 DRNG could be used for that very
> >>> same
> >>> purpose, provided that in case these true random numbers are generated
> >>> when
> >>> the Chacha20 DRNG received an equal amount of "unused" entropy.
> >>=20
> >> This scares me. The DRNG should be simple and easy to understand. If
> >> we=E2=80=99re
> >> tapping extra numbers in some weird way, then I would be more comforta=
ble
> >> with some clear assurance that this doesn=E2=80=99t break the security=
=2E If we=E2=80=99re
> >> tapping numbers in the same way as normal urandom, then I don=E2=80=99=
t really
> >> see
> >> the point.
> >=20
> > Agreed. I was just trying to outline that the removal of the blocking_p=
ool
> > is a good thing. Even when we decide that random.c should receive a TRN=
G,
> > we do not need to re-add a blocking pool, but can easily use the existi=
ng
> > ChaCha20 DRNG (most likely with its own instance).
>=20
> Fair enough.
>=20
> >>>> Alternatively, perhaps the kernel should instead provide a
> >>>> privileged interface to read out raw samples from the various
> >>>> entropy sources, and users who care could have a user daemon that
> >>>> does something intelligent with them.  This would push the mess of
> >>>> trying to comply with whatever standards are involved to userspace.
> >>>> Userspace could then export "true randomness" via CUSE if it is so
> >>>> inclined, or could have a socket with a well-known name, or whatever
> >>>> else seems appropriate.
> >>>=20
> >>> With the patch set v26 of my LRNG I offer another possible alternative
> >>> avoiding any additional character device file and preventing the
> >>> starvation of legitimate use cases: the LRNG has an entropy pool that
> >>> leaves different levels of entropy in the pool depending on the use
> >>> cases
> >>> of this data.
> >>>=20
> >>> If an unprivileged caller requests true random data, at least 1024 bi=
ts
> >>> of
> >>> entropy is left in the pool. I.e. all entropy above that point is
> >>> available
> >>> for this request type. Note, even namespaces fall into this category
> >>> considering that unprivileged users can create a user name space in
> >>> which
> >>> they can become root.
> >>=20
> >> This doesn=E2=80=99t solve the problem. If two different users run stu=
pid
> >> programs
> >> like gnupg, they will starve each other.
> >=20
> > But such scenario will always occur, will it not? If there are two call=
ers
> > for a limited resource, they will content if one "over-uses" the
> > resource. My idea was to provide an interface where its use does not
> > starve other more relevant use cases (e.g. seeding of the DRNGs). I.e. a
> > user of a TRNG has the right to be DoSed - that is the price to pay when
> > using this concept.
>=20
> Maybe I=E2=80=99m just cynical, but I expect that, if the feature is avai=
lable to
> everyone, then lots of user programmers will use it even though they don=
=E2=80=99t
> need to.  If, on the other hand, there is a barrier to entry, then people
> will be more likely to stop and think.

I would tend to agree with you. But if the man page provides an appropriate=
=20
warning that such DoS is the price to pay, wouldn't you say it is sufficien=
t?=20
I guess you will say no :-)

Thus, if you can convince Greg to allow us creating another device node, I =
am=20
definitely not in the way of creating and using it. All my suggestions simp=
ly=20
try to bridge the gap between Greg's rather reluctant agreement and our nee=
ds.

The good thing is IMHO that we are only talking about the actual kernel/use=
r=20
interface. The plumbing behind it will be identical - at least in my LRNG=20
implementation, I can use the very same handler function for accessing the=
=20
TRNG with either the device file or the getrandom syscall. I guess the same=
=20
would be applicable to any possible random.c TRNG implementation.

>=20
> Even gnupg could have been more clever =E2=80=94 when generating a 4096-b=
it RSA key,
> there is no actual need for 4096 bits of entropy, however entropy is
> defined. 256 bits would have been more than adequate.

I am in violent agreement.
>=20
> (FWIW, my personal view is that 512 bits, in the sense of =E2=80=9Cthe di=
stribution
> being sampled produces no output with probability greater than about
> 2^-512=E2=80=9D, is a good upper limit for even the most paranoid.  This =
is because
> it=E2=80=99s reasonable to assume that an attacker can=E2=80=99t do more =
than 2^128
> operations. As djb has noted, multi-target attacks mean that you can
> amplify success probability in some cases by a factor that won=E2=80=99t =
exceed
> 2^128.  Some day, quantum computers might square-root everything, giving
> 512 bits. Actually, quantum computers won=E2=80=99t square root everythin=
g, but
> much more complicated analysis is needed to get a believable bound.)
>=20
> =E2=80=94Andy



Ciao
Stephan


