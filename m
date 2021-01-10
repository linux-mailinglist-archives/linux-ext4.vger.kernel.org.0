Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE252F0917
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Jan 2021 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbhAJSmC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Jan 2021 13:42:02 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:40780 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbhAJSmB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Jan 2021 13:42:01 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CB1AE1C0B85; Sun, 10 Jan 2021 19:41:02 +0100 (CET)
Date:   Sun, 10 Jan 2021 19:41:02 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Malicious fs images was Re: ext4 regression in v5.9-rc2 from
 e7bfb5c9bb3d on ro fs with overlapped bitmaps
Message-ID: <20210110184101.GA4625@amd>
References: <20201006025110.GJ49559@magnolia>
 <20201006031834.GA5797@mit.edu>
 <20201006050306.GA8098@localhost>
 <20201006133533.GC5797@mit.edu>
 <20201007080304.GB1112@localhost>
 <20201007143211.GA235506@mit.edu>
 <20201007201424.GB15049@localhost>
 <20201008021017.GD235506@mit.edu>
 <20201008222259.GA45658@localhost>
 <20201009143732.GJ235506@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20201009143732.GJ235506@mit.edu>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Fri 2020-10-09 10:37:32, Theodore Y. Ts'o wrote:
> On Thu, Oct 08, 2020 at 03:22:59PM -0700, Josh Triplett wrote:
> >=20
> > I wasn't trying to make a *new* general principle or policy. I was under
> > the impression that this *was* the policy, because it never occurred to
> > me that it could be otherwise. It seemed like a natural aspect of the
> > kernel/userspace boundary, to the point that the idea of it *not* being
> > part of the kernel's stability guarantees didn't cross my mind.=20
>=20
> >From our perspective (and Darrick and I discussed this on this week's
> ext4 video conference, so it represents the ext4 and xfs maintainer's
> position) is that the file system format is different.  First, the
> on-disk format is not an ABI, and it is several orders more complex
> than a system call interface.  Second, we make no guarantees about
> what the file system created by malicious tools will do.  For example,
> XFS developers reject bug reports from file system fuzzers, because
> the v5 format has CRC checks, so randomly corrupted file systems won't
> crash the kernel.  Yes, this doesn't protect against maliciously
> created file systems where the attacker makes sure the checksums are
> valid, but only crazy people who think containers are just as secure

Well, it is not just containers. It is also USB sticks. And people who
believe secure boot is good idea and try to protect kernel against
root. And crazy people who encrypt pointers in dmesg. And...

People want to use USB sticks from time to time. And while I
understand XFS is so complex it is unsuitable for such use, I'd still
expect bugs to be fixed there.

I hope VFAT to be safe to mount, because that is very common on USB.

I also hope ext2/3/4 is safe in that regard.

Anyway it would be nice to have documentation explaining this. If I'm
wrong about VFAT being safe, it would be good to know, and I guess
many will be surprised that XFS is using different rules.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/7Sj0ACgkQMOfwapXb+vKCDgCfW4PJ9T5AyLvlZAOFRcpTtgPw
qfoAn31wDMvqBEaUcwGpxUc0W2RbVoEe
=l/1d
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
