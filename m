Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE52F3F99
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Jan 2021 01:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbhALW3j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 17:29:39 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:33426 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394599AbhALW3Y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jan 2021 17:29:24 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B5A061C0B8B; Tue, 12 Jan 2021 23:28:40 +0100 (CET)
Date:   Tue, 12 Jan 2021 23:28:40 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: Malicious fs images was Re: ext4 regression in v5.9-rc2 from
 e7bfb5c9bb3d on ro fs with overlapped bitmaps
Message-ID: <20210112222840.GA28214@duo.ucw.cz>
References: <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
 <20210110184101.GA4625@amd>
 <X/4YArRJMgGjSyZY@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <X/4YArRJMgGjSyZY@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > People want to use USB sticks from time to time. And while I
> > understand XFS is so complex it is unsuitable for such use, I'd still
> > expect bugs to be fixed there.
> >=20
> > I hope VFAT to be safe to mount, because that is very common on USB.
> >=20
> > I also hope ext2/3/4 is safe in that regard.
>=20
> Ext4 will fix file system fuzzing attack bugs on a best efforts basis.
> That is, when I have time, I've been known to stay up late to bugs
> reported by fuzzers.  I hope ext4 is safe, but I'm not going to make
> any guarantees that it is Bug-Free(tm).  If you want to trust it in
> that way, you do so at your risk.

Good.

> > Anyway it would be nice to have documentation explaining this. If I'm
> > wrong about VFAT being safe, it would be good to know, and I guess
> > many will be surprised that XFS is using different rules.
>=20
> Using USB sticks is fine, so long as you trust the provenance of the
> drive.  If you take a random USB stick that is handed to you by

Well... That makes passing data between Windows and Linux machines
using USB stick "interesting", right?

> someone whom you don't trust implicitly, or worse, that you picked up
> abandoned on the sidewalk, there have been plenty of articles which
> describe why this is a REALLY BAD IDEA, and even if you ignore
> OS-level vuleranbilities, there are also firwmare and hardware based
> vulerabilities that would put your computer at risk.  See [2] and
> [3]

I know, but bear with me.

> As far as documentation is concerned, how far should we go?  Should
> there be a warning in the execve(2) system call man page that you
> shouldn't download random binaries from the network and execute them?  :-)

No need to pull straw men for me.

This thread suggested that kernel is _not_ supposed to be robust
against corrupt filesystems (because fsck is not integrated in
kernel). Which was news to me (and I'm not the person that needs
warning in execve documentation).

I'd certainly like to hear that VFAT and EXT4 _is_ supposed to be
robust in that way.

And if we have filesystems where corrupt image is known to allow
arbitrary code execution, we need to

a) document that.

b) disable them when secure boot is enabled.

Because with secure boot, we are supposed to be secure against attacks
=66rom root, and root can prepare malicious filesystems. ("The problem,
simply put, is this: the objective of secure boot is to prevent the
system from running any unsigned code in a privileged mode. So, if one
boots a Linux system that, in turn, gives access to the machine to
untrusted code, the entire purpose has been defeated. The consequences
could hurt both locally (bad code could take control of the machine)
and globally (the signing key used to boot Linux could be revoked), so
it is an outcome that is worth avoiding. Doing so, however, requires
placing limitations in the kernel so that not even root can circumvent
the secure boot chain of trust." -- https://lwn.net/Articles/514985/
).

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX/4imAAKCRAw5/Bqldv6
8igbAKCnfyP6mP9AHNkzvIsq1Z/ZDtXU8QCdEyaoLjawtnyub5W2dVUMRLpB6d0=
=CR7u
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
