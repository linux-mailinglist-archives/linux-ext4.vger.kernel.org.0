Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771712EF0B1
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbhAHKcJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Jan 2021 05:32:09 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:59722 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhAHKcJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Jan 2021 05:32:09 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 50E001C0B88; Fri,  8 Jan 2021 11:31:10 +0100 (CET)
Date:   Fri, 8 Jan 2021 11:31:10 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>, Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210108103109.GA23265@duo.ucw.cz>
References: <20210105154726.GD1551@shell.armlinux.org.uk>
 <20210106115359.GB26994@C02TD0UTHF1T.local>
 <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <X/c2aqSvYCaB9sR6@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
In-Reply-To: <X/c2aqSvYCaB9sR6@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > them in my git history.
> >=20
> > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > or just for aarch64?
>=20
> Russell, Arnd, thanks so much for tracking down the root cause of the
> bug!
>=20
> I will note that RHEL 7 uses gcc 4.8.  I personally don't have an
> objections to requiring developers using RHEL 7 to have to install a
> more modern gcc (since I use Debian Testing and gcc 10.2.1, myself,
> and gcc 5.1 is so five years ago :-), but I could imagine that being
> considered inconvenient for some.

I'm on gcc 4.9.2 on a machine that is hard to upgrade :-(.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/g0bQAKCRAw5/Bqldv6
8pyYAJoC5zO0PTOA6H3eh72g3UUzmjmDdACggNwbZUNV+58zQH7zPdNsq1KIARg=
=u1Av
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
