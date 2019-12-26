Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D5712AB4F
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 10:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLZJfE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 04:35:04 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:23782 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfLZJfE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 04:35:04 -0500
X-Greylist: delayed 312 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Dec 2019 04:35:02 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577352901;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=CrhxrHnI4h8bUXWJL2MnJTVPHP2ek6Df7gTpwCbz51M=;
        b=paoDuqMUEURJYStOUmtanYJybDvF4AqrM1eajy+MOEPWHdMTsug885THknmJQ7mamR
        clVsWK1Ugs+hbpkfvf7LbkKn29cOhzJb9J8i9w+uMV8JTyfEA4gqOGfp2bzLV8+T5Qth
        QMdCSZSnMaNmUiTfLeiRbDKcV9n4YPFrMiK3Mttv8EQ5G7iLkv7/DXkqThQo+NeCvBNd
        B6aGTQxJ9yJZmaHG1M3UYtSlVGrD4cULWbehuqKlsvgfZNU37RSfnMroij/qt4cHlVDw
        XlIoSsf6C+kMTzLj7RVzYlSJ4nqR3niG7IJZntDqZ+2z8GhyHMhXWQO9mXEmqmKiuC7a
        qfaw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIPSZNQ=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 46.1.3 DYNA|AUTH)
        with ESMTPSA id e09841vBQ9T1B4U
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 26 Dec 2019 10:29:01 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ted Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>,
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
Date:   Thu, 26 Dec 2019 10:29:00 +0100
Message-ID: <9872655.prSdhymlXK@positron.chronox.de>
In-Reply-To: <cover.1577088521.git.luto@kernel.org>
References: <cover.1577088521.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Am Montag, 23. Dezember 2019, 09:20:43 CET schrieb Andy Lutomirski:

Hi Andy,
>=20
> There are some open questions and future work here:
>=20
> Should the kernel provide an interface to get software-generated
> "true random" numbers?  I can think of only one legitimate reason to
> use such an interface: compliance with government standards.  If the
> kernel provides such an interface going forward, I think it should
> be a brand new character device, and it should have a default mode
> 0440 or similar.  Software-generated "true random numbers" are a
> very limited resource, and resource exhaustion is a big deal.  Ask
> anyone who has twiddled their thumbs while waiting for gnupg to
> generate a key.  If we think the kernel might do such a thing, then
> patches 5-8 could be tabled for now.

What about offering a compile-time option to enable or disable such code?=20
Note, with the existing random.c code base, there is no need to have a=20
separate blocking_pool. The ChaCha20 DRNG could be used for that very same=
=20
purpose, provided that in case these true random numbers are generated when=
=20
the Chacha20 DRNG received an equal amount of "unused" entropy.
>=20
> Alternatively, perhaps the kernel should instead provide a
> privileged interface to read out raw samples from the various
> entropy sources, and users who care could have a user daemon that
> does something intelligent with them.  This would push the mess of
> trying to comply with whatever standards are involved to userspace.
> Userspace could then export "true randomness" via CUSE if it is so
> inclined, or could have a socket with a well-known name, or whatever
> else seems appropriate.

With the patch set v26 of my LRNG I offer another possible alternative=20
avoiding any additional character device file and preventing the starvation=
 of=20
legitimate use cases: the LRNG has an entropy pool that leaves different=20
levels of entropy in the pool depending on the use cases of this data.

If an unprivileged caller requests true random data, at least 1024 bits of=
=20
entropy is left in the pool. I.e. all entropy above that point is available=
=20
for this request type. Note, even namespaces fall into this category=20
considering that unprivileged users can create a user name space in which t=
hey=20
can become root.

If a non-blocking DRNG serving /dev/urandom or getrandom(2) needs reseeding=
,=20
at least 512 bits of entropy is left in the pool. Each DRNG seeding operati=
on=20
requires at least 128 bits and at most 256 bits of entropy. This means that=
 at=20
least 2 reseed operations worth of entropy is found in the entropy pool eve=
n=20
though massive amount of true random numbers are requested by unprivileged=
=20
users.

If a privileged caller requests true random numbers, the entropy pool is=20
allowed to be exhausted.

Access to the true random number generator is provided with getrandom(2) an=
d=20
the GRND_TRUERANDOM flag. If the true random number generator (TRNG) is not=
=20
compiled or not present, -EOPNOTSUPP is returned.

Entire patch set:

Reviewed-by: Stephan M=FCller <smueller@chronox.de>

Ciao
Stephan


