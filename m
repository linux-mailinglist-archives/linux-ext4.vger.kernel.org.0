Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF98432E95
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 13:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfFCL0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 07:26:35 -0400
Received: from mail1.g1.pair.com ([66.39.3.162]:60306 "EHLO mail1.g1.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfFCL0e (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 3 Jun 2019 07:26:34 -0400
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 07:26:33 EDT
Received: from mail1.g1.pair.com (localhost [127.0.0.1])
        by mail1.g1.pair.com (Postfix) with ESMTP id B533F547763;
        Mon,  3 Jun 2019 07:19:45 -0400 (EDT)
Received: from harpe.intellique.com (labo.djinux.com [82.225.196.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail1.g1.pair.com (Postfix) with ESMTPSA id 8C69760B01C;
        Mon,  3 Jun 2019 07:19:44 -0400 (EDT)
Date:   Mon, 3 Jun 2019 13:19:46 +0200
From:   Emmanuel Florac <eflorac@intellique.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
        "Theodore Ts'o" <tytso@mit.edu>, xfs <linux-xfs@vger.kernel.org>,
        Eric Sandeen <sandeen@redhat.com>
Subject: Re: How to package e2scrub
Message-ID: <20190603131946.03930c0e@harpe.intellique.com>
In-Reply-To: <20190530152855.GA5390@magnolia>
References: <20190529120603.xuet53xgs6ahfvpl@work>
        <20190529182111.GA5220@magnolia>
        <20190530060426.GA30438@infradead.org>
        <20190530152855.GA5390@magnolia>
Organization: Intellique
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/H5b_76QovpEvKn1OoeJIwpz"; protocol="application/pgp-signature"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/H5b_76QovpEvKn1OoeJIwpz
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le Thu, 30 May 2019 08:28:55 -0700
"Darrick J. Wong" <darrick.wong@oracle.com> =C3=A9crivait:

> On Wed, May 29, 2019 at 11:04:26PM -0700, Christoph Hellwig wrote:
> > On Wed, May 29, 2019 at 11:21:11AM -0700, Darrick J. Wong wrote: =20
> > > Indeed.  Eric picked "xfsprogs-xfs_scrub" for Rawhide, though I
> > > find that name to be very clunky and would have preferred
> > > "xfs_scrub". =20
> >=20
> > Why not just xfs-scrub? =20
>=20
> Slight preference for the package sharing a name with its key
> ingredient:
>=20
> # xfs_scrub /home
> Bad command or file name
> # apt install xfs_scrub
> <stuff>
> # xfs_scrub /home
> WARNING: ALL DATA ON NON-REMOVABLE DISK
> DRIVE C: WILL BE LOST!
> Proceed with Format (Y/N)?
>=20
> --D

Debian packages always replace _ with - in the package name itself
because the _ is used to separate the package name proper from the
version and architecture : package_version_arch.deb.

--=20
------------------------------------------------------------------------
Emmanuel Florac     |   Direction technique
                    |   Intellique
                    |	<eflorac@intellique.com>
                    |   +33 1 78 94 84 02
------------------------------------------------------------------------

--Sig_/H5b_76QovpEvKn1OoeJIwpz
Content-Type: application/pgp-signature
Content-Description: Signature digitale OpenPGP

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlz1AlMACgkQX3jQXNUicVZz+ACg0oITUTx4DoH6CgqJ4DaYTL3c
A7EAoP0uRe2hI334k1c4/XNS/1PBnfUr
=7WXO
-----END PGP SIGNATURE-----

--Sig_/H5b_76QovpEvKn1OoeJIwpz--
