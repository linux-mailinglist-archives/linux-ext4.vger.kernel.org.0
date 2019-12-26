Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4192812AC10
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 13:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfLZMGk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 07:06:40 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:14213 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfLZMGj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 07:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577361995;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3PDCF9xkGeHLIJ88g7UinUwwyuHwYmmyTi0y9uV/15c=;
        b=atq4ZYLX7+dBFPkW/jcxlCsNyKbl8RwmzkojRB+z2Ltt6qGcSWsu6LQya70fKLAIuD
        ypbHHbrZ1L4jQTeOYk8DzjArH+fb3INV4TWVmtuc0Vz9PwlQRfk2n0/ewwswbcUQHZD9
        Mk4Tt7obeMrkaWPsjxf6Pw2lbwU3SdPL3qkHWdmHTm60KSsdAbCj5vAQHxQaeCuMdGC9
        IkCbCfr1BwG/ePQH+vKNC8mvwaIR37bNq7S/sp0kPgdCK1V/VCIIC46+O5OI+j3KQmfY
        h9g74h4UVKTEhhPIffcgNkK64HscVI11mcbH4u9rzr3zSKA28crTDGNv0DVbTPpsB40J
        ViBg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIPSZNQ=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id e09841vBQC3YBSF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 26 Dec 2019 13:03:34 +0100 (CET)
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
Date:   Thu, 26 Dec 2019 13:03:34 +0100
Message-ID: <4820831.xlnk3tY4r2@tauon.chronox.de>
In-Reply-To: <888017FA-06A1-42EF-9FC0-46629138DA9E@amacapital.net>
References: <9872655.prSdhymlXK@positron.chronox.de> <888017FA-06A1-42EF-9FC0-46629138DA9E@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Donnerstag, 26. Dezember 2019, 12:12:29 CET schrieb Andy Lutomirski:

Hi Andy,

> > On Dec 26, 2019, at 5:29 PM, Stephan M=C3=BCller <smueller@chronox.de> =
wrote:
> >=20
> > =EF=BB=BFAm Montag, 23. Dezember 2019, 09:20:43 CET schrieb Andy Lutomi=
rski:
> >=20
> > Hi Andy,
> >=20
> >> There are some open questions and future work here:
> >>=20
> >> Should the kernel provide an interface to get software-generated
> >> "true random" numbers?  I can think of only one legitimate reason to
> >> use such an interface: compliance with government standards.  If the
> >> kernel provides such an interface going forward, I think it should
> >> be a brand new character device, and it should have a default mode
> >> 0440 or similar.  Software-generated "true random numbers" are a
> >> very limited resource, and resource exhaustion is a big deal.  Ask
> >> anyone who has twiddled their thumbs while waiting for gnupg to
> >> generate a key.  If we think the kernel might do such a thing, then
> >> patches 5-8 could be tabled for now.
> >=20
> > What about offering a compile-time option to enable or disable such cod=
e?
> > Note, with the existing random.c code base, there is no need to have a
> > separate blocking_pool. The ChaCha20 DRNG could be used for that very s=
ame
> > purpose, provided that in case these true random numbers are generated
> > when
> > the Chacha20 DRNG received an equal amount of "unused" entropy.
>=20
> This scares me. The DRNG should be simple and easy to understand. If we=
=E2=80=99re
> tapping extra numbers in some weird way, then I would be more comfortable
> with some clear assurance that this doesn=E2=80=99t break the security. I=
f we=E2=80=99re
> tapping numbers in the same way as normal urandom, then I don=E2=80=99t r=
eally see
> the point.

Agreed. I was just trying to outline that the removal of the blocking_pool =
is=20
a good thing. Even when we decide that random.c should receive a TRNG, we d=
o=20
not need to re-add a blocking pool, but can easily use the existing ChaCha2=
0=20
DRNG (most likely with its own instance).

> >> Alternatively, perhaps the kernel should instead provide a
> >> privileged interface to read out raw samples from the various
> >> entropy sources, and users who care could have a user daemon that
> >> does something intelligent with them.  This would push the mess of
> >> trying to comply with whatever standards are involved to userspace.
> >> Userspace could then export "true randomness" via CUSE if it is so
> >> inclined, or could have a socket with a well-known name, or whatever
> >> else seems appropriate.
> >=20
> > With the patch set v26 of my LRNG I offer another possible alternative
> > avoiding any additional character device file and preventing the
> > starvation of legitimate use cases: the LRNG has an entropy pool that
> > leaves different levels of entropy in the pool depending on the use cas=
es
> > of this data.
> >=20
> > If an unprivileged caller requests true random data, at least 1024 bits=
 of
> > entropy is left in the pool. I.e. all entropy above that point is
> > available
> > for this request type. Note, even namespaces fall into this category
> > considering that unprivileged users can create a user name space in whi=
ch
> > they can become root.
>=20
> This doesn=E2=80=99t solve the problem. If two different users run stupid=
 programs
> like gnupg, they will starve each other.

But such scenario will always occur, will it not? If there are two callers =
for=20
a limited resource, they will content if one "over-uses" the resource. My i=
dea=20
was to provide an interface where its use does not starve other more releva=
nt=20
use cases (e.g. seeding of the DRNGs). I.e. a user of a TRNG has the right =
to=20
be DoSed - that is the price to pay when using this concept.
>=20
> As I see it, there are two major problems with /dev/random right now: it=
=E2=80=99s
> prone to DoS (i.e. starvation, malicious or otherwise), and, because no
> privilege is required, it=E2=80=99s prone to misuse. Gnupg is misuse, ful=
l stop. If
> we add a new unprivileged interface, gnupg and similar programs will use
> it, and we lose all over again.

I am under the impression that the over-using of /dev/random is that other =
use=20
cases like re-seeding of /dev/urandom are DoSed. But if there is a hog on t=
he=20
TRNG that only causes a problem for itself for other equally specialized=20
applications, so be it.

When using a char device with rights of 440, then at least all applications=
=20
part of that special group will still content for TRNG data. The only=20
additional benefit I would currently see for a char device with permissions=
 of=20
440 is that an admin can control which applications have access to the TRNG=
 to=20
begin with. But when an attacker can fool those applications to use more=20
random data, we again have a DoS. So, we just pushed the issue down the roa=
d=20
without solving it (and I think there is no solution for the issue that TRN=
G=20
users can DoS each other).=20

Speaking of GnuPG and after having some discussions with Werner Koch, I thi=
nk=20
the reason for using /dev/random was that this (used to be) the only=20
randomness source that has a guarantee of being seeded (Werner is not=20
participating in this thread, so I hope I am not misrepresenting his words)=
=2E=20
With the presence of getrandom(2), this is now solved. IIRC libgcrypt has=20
received support for getrandom(2) and the issue of blocking on /dev/random=
=20
should now be a thing of the past with recent libgcrypt (and thus GnuPG)=20
versions.=20

Ciao
Stephan


