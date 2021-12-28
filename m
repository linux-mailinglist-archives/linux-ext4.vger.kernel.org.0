Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BD480DC4
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Dec 2021 23:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhL1WkT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Dec 2021 17:40:19 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:60126 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbhL1WkT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Dec 2021 17:40:19 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 123C61C0B77; Tue, 28 Dec 2021 23:40:18 +0100 (CET)
Date:   Tue, 28 Dec 2021 23:40:17 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <20211228224017.GA2242@duo.ucw.cz>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work>
 <YbuGLsQy6TSM2xOl@mit.edu>
 <20211217093534.2ug6e5cm37md2c3u@work>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
In-Reply-To: <20211217093534.2ug6e5cm37md2c3u@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > So the question is, is it worth it to continue supporting the migrate
> > feature, or should we just delete all of the migration code, and risk
> > users complaining that we've broken their use case?  The chances of
> > that happening is admittedly low, and Linus's rule that "it's only
> > breaking userspace if a user complains" means we might very well get
> > away with it.  :-)
>=20
> That's a very good summary Ted, thanks.
>=20
> Our rationale behind not supporting the migration was always the fact
> that we felt that backup was absolutely necessary before operation like
> this. When you already have up-to-date backup available you might as
> well create a fresh ext4 file system with all the advantages it brings
> and recover data from said backup. I think this is still a very
> reasonable approach.

Umm. Not really?

First... full backup/restore will take a _long_ time.

Second... if you do online migration, you have filesystem you are
quite unlikely to corrupt, and backup you are unlikely to use. If you
do backup/restore, you have to be _way_ more careful that backup media
is reliable etc.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYcuSUQAKCRAw5/Bqldv6
8l2kAKCs+/aLi7Q0m2l8B0Z/lo5ml8h+EwCeMcYdjuzb8vm9b1uutXrUteym7Qs=
=ndn0
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
