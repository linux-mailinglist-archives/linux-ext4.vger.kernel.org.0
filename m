Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCFE1F9009
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jun 2020 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgFOHhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 Jun 2020 03:37:16 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:39492 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgFOHhQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 Jun 2020 03:37:16 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 436A61C0C0A; Mon, 15 Jun 2020 09:37:13 +0200 (CEST)
Date:   Mon, 15 Jun 2020 09:37:12 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: 5.8-rc1: new warnings in ext4_mb_new_blocks?
Message-ID: <20200615073712.GA4164@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Booting 5.8-rc1 on x220, I get scary warnings:

[    7.089941] EXT4-fs (sdb2): mounted filesystem with ordered data mode. O=
pts: errors=3Dremount-ro
[    7.343231] BUG: using smp_processor_id() in preemptible [00000000] code=
: systemd-tmpfile/2788
[    7.344052] caller is debug_smp_processor_id+0x17/0x20
[    7.344897] CPU: 3 PID: 2788 Comm: systemd-tmpfile Not tainted 5.8.0-rc1=
+ #116
[    7.345745] Hardware name: LENOVO 42872WU/42872WU, BIOS 8DET74WW (1.44 )=
 03/13/2018
[    7.346561] Call Trace:
[    7.347355]  dump_stack+0x60/0x7a
[    7.348170]  check_preemption_disabled+0xb1/0xc0
[    7.348951]  debug_smp_processor_id+0x17/0x20
[    7.349728]  ext4_mb_new_blocks+0x1f2/0x13e0

and they continue after boot.
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXuclKAAKCRAw5/Bqldv6
8itPAJwKR2DOmEe1aznivFQPlM8E4RFGGQCeLq41TlzBLNB2r6ZpEi04/RAo8EY=
=sycn
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
