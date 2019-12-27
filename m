Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4258812B3E2
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Dec 2019 11:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfL0KaK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Dec 2019 05:30:10 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:24796 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfL0KaK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Dec 2019 05:30:10 -0500
X-Greylist: delayed 80746 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2019 05:30:09 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577442607;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Qx0iM8FINnvF6+4nf5gRDxQg8HM8PCrY5XDC09oP3uk=;
        b=ULYFxwWgTUvxznZh3jbUvrtbLdfp1lGKxl3Sv6qMMY3hF5tyJ53LQaEF/HY6qI7DUF
        rzIG8OVgPRnTGS/lH5McC3m6aqGsZQTcznqt21uab5qAFFJEggbN7k3QFH/nvrX85oVO
        p60Xx6isGMhx8nJ3VZGYqyr/Rrsm71+lRwcAdLfiK19aLzNba4me6TuMGHuUGPaq34Kk
        ZDWBcRuoZJEjIUIVWOAUPTKrdEUdCqQAThPFpJDLqjcD84tbZhCn0BXY5aOu8rpauyxb
        xVgwMRb9obst7bEytkoq1zpA4Fmc4QcPQyOQQZXtA42hC5vrsH6lOUQdYGZD/IJM6JDZ
        flHQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbJ/ScSKV5"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id e09841vBRATME7m
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 27 Dec 2019 11:29:22 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Date:   Fri, 27 Dec 2019 11:29:22 +0100
Message-ID: <4048434.Q8HajmOrkZ@tauon.chronox.de>
In-Reply-To: <26B7EEAE-1166-4B45-9534-E00C5B2767C1@amacapital.net>
References: <20191226140423.GB3158@mit.edu> <26B7EEAE-1166-4B45-9534-E00C5B2767C1@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Freitag, 27. Dezember 2019, 00:29:20 CET schrieb Andy Lutomirski:

Hi Ted, Andy,

> >> On Dec 26, 2019, at 10:04 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >>=20
> >> =EF=BB=BFOn Thu, Dec 26, 2019 at 01:03:34PM +0100, Stephan Mueller wro=
te:
> >> Agreed. I was just trying to outline that the removal of the
> >> blocking_pool is a good thing. Even when we decide that random.c should
> >> receive a TRNG, we do not need to re-add a blocking pool, but can easi=
ly
> >> use the existing ChaCha20 DRNG (most likely with its own instance).
> >=20
> > Well, it depends on what you mean by "TRNG" --- the ChaCha20 DRNG only
> > has a state of 256 bits.  So if you want to only depend on "true
> > entropy" you can't extract more than 256 bits without violating that
> > assumption, at least if you're using a very strict definition of TRNG.


My definition of TRNG is identical to the German AIS 31 and I guess identic=
al=20
to your definition of a TRNG.

A TRNG will produce an amount of random data that is equal to the amount of=
=20
"fresh" entropy that was provided by the noise source. I.e. it should be=20
identical to the blocking_pool behavior.

This definition is slightly stricter than the SP800-90A definition of "a DR=
BG=20
with prediction resistance" which requires a reseed with entropy equal to t=
he=20
security strength of the DRBG, but allows one generate operation which at m=
ost=20
generates 2^19 random bits.

Such TRNG has two components

1. the noise source / the entropy pool

2. the random number generator

All I try to say is that the random number generator does not need to be a=
=20
special implementation of, say, a blocking_pool, but it can be any type of=
=20
DRNG (ChaCha20, SP800-90A DRBG, ...).

To manage that DRNG, the logic needs to ensure that the maximum entropy=20
content assumed to be present in the DRNG is min(entropy_from_noise_source,=
=20
security_strength_DRNG). For the case of the blocking_pool, the security=20
strength is 1024 bits which means that at most the blocking_pool can hold u=
p=20
to 1024 bits. With a ChaCha20 DRNG, the security strength is 256 bits.=20
SP800-90A defines the security strengths of the DRBGs.

That said, for a TRNG, the DRNG part must be seeded with the amount of entr=
opy=20
equaling the requested numbers of random bits, but at most with entropy=20
equaling the security strength of the DRNG. If the caller wants more random=
=20
data, the request must be chunked to ensure that the DRNG is always reseede=
d=20
before satisfying the chunk of the request.

> >=20
> > By getting rid of the blocking pool, and making /dev/random work like
> > getrandom with flags set to 0, we're effectively abandoning any kind
> > of assertion that /dev/random is some kind of TRNG.  This is not
> > insane; this is what the *BSD's have always done.

Correct, and I am not disputing it. And I think that making Linux to behave=
=20
like the BSD's and guaranteeing that the DRNG is fully seeded based on Andy=
's=20
patch set is a good thing.

All I try to say is that there are use cases where a TRNG with the initiall=
y=20
defined operation is required. This most prominent use case is the German A=
IS=20
31 and the (re)seeding requirements of deterministic RNGs.
> >=20
> > But once we do this, and /dev/random takes on the semantics of "block
> > until the CRNG has been initialized, and then it won't block after
> > that", if we change it so that it now has some different semantics,
> > such as "one you extract a 256-bit key, the read from /dev/random will
> > block until we can refill it, which might take seconds, minutes or
> > hours", will be considered a regression, and we can't do that.
>=20
> I don=E2=80=99t think Stephan was proposing that. He was proposing a way =
to
> implement a new interface that blocks.

Thank you, Andy. Yes. I am trying to propose a separate interface.

Our discussion currently produced the following suggestions:

=2D add a new GRND_TRUERANDOM flag to getrandom(2) which allows access to t=
he=20
TRNG. Andy did not like it because he mentioned that it may be misused sinc=
e=20
the syscall is unprivileged. I had some suggestions to overcome this proble=
m,=20
but not all of Andy's considerations could be addressed with this suggestio=
n.=20
As an idea, my current LRNG system call implementation looks like:

SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
                unsigned int, flags)
{
        if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE|
GRND_TRUERANDOM))
                return -EINVAL;

        /*
         * Requesting insecure and blocking randomness at the same time mak=
es
         * no sense.
         */
        if ((flags &
             (GRND_INSECURE|GRND_RANDOM)) =3D=3D (GRND_INSECURE|GRND_RANDOM=
))
                return -EINVAL;

        /* Only allow GRND_TRUERANDOM by itself or with NONBLOCK */
        if ((flags & GRND_TRUERANDOM) &&
            ((flags &~ GRND_TRUERANDOM) !=3D 0) &&
            ((flags &~ (GRND_TRUERANDOM | GRND_NONBLOCK)) !=3D 0))
                return -EINVAL;

        if (count > INT_MAX)
                count =3D INT_MAX;

        if (flags & GRND_TRUERANDOM)
                return lrng_read_common_block(flags & GRND_NONBLOCK, buf,
                                              count, lrng_trng_get);
        if (flags & GRND_INSECURE)
                return lrng_sdrng_read(NULL, buf, count, NULL);

        return lrng_read_common_block(flags & GRND_NONBLOCK, buf, count,
                                      lrng_sdrng_get_sleep);

}


=2D Andy mentioned that he likes the approach with having another new char=
=20
device with permissions 440 to provide an interface to the TRNG as more=20
appropriate. However, Greg was reluctant to add a new device file.

I personally am indifferent. All I am suggesting is to have a TRNG offered =
to=20
user space.

> > Of course, we can hope that people will be using getrandom() and there
> > will be very few new users of the /dev/random pathname.  But nothing
> > is ever guaranteed..
> >=20
> >                       - Ted



Ciao
Stephan


