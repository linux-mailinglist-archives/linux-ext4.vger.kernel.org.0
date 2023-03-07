Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5EA6AF6E7
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Mar 2023 21:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCGUpc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Mar 2023 15:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCGUpb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Mar 2023 15:45:31 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEEA5941E;
        Tue,  7 Mar 2023 12:45:28 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PWSBY5wdtz4x5Q;
        Wed,  8 Mar 2023 07:45:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1678221926;
        bh=d24e1QtWViCs95rpXCfFX1SB1CW7UKfxzgWthhcvCsg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Beb00cSOvppal9zE9y9m6g/btJSUon0is67WX4R3U2vEReX80eucSv2anQaFayYT5
         znKzjKka2ITGfCehfmGdBEI5hJFwSPq+YqQRLs4hUhmREUtFbtXmGiBtOpgzSGZBIQ
         vJD9tk+2zcf7cwp7hrTe75sX/qK3wf+HmBlXgDv4V1wFv/Xs9cy7XWiagN3jZFjtg3
         Sw9DnE/Y2XGCGTPvo7hHiX2nXLvneTJTHEgJlSzIeB6XWLXhPGFoJP3/2Z3+PtOl6N
         0sEAptQgVzEeBDG3/3P5J1I+b/yLa/7odXONo5MXnxQqw9cT1YGCiRnNWQK2GlV457
         49HCgr5Q4P4og==
Date:   Wed, 8 Mar 2023 07:45:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ext4 Development <linux-ext4@vger.kernel.org>
Subject: Re: The state of ext4 tree merging (was Re: Linux 6.3-rc1)
Message-ID: <20230308074431.21c32d58@oak.ozlabs.ibm.com>
In-Reply-To: <20230307162137.GB960946@mit.edu>
References: <CAHk-=wgr1D8hb75Z+nn+4LXUnosp0HM+gP+YJEcEav1DgTC=Cw@mail.gmail.com>
        <ZAVbZJSyOdF0BxAJ@debian.me>
        <20230306124134.hmeuvjhihs4ubpmz@quack3>
        <20230307090203.56c41488@oak.ozlabs.ibm.com>
        <20230307162137.GB960946@mit.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lR6o7dtq7QQ3HgOXpDI/ylr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--Sig_/lR6o7dtq7QQ3HgOXpDI/ylr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Theodore,

On Tue, 7 Mar 2023 11:21:37 -0500 "Theodore Ts'o" <tytso@mit.edu> wrote:
>

> What duplicate commits?  As far as I know there aren't any.  My normal
> practice is to send a secondary push to fix a few bug fixes targetted
> for upcoming release (in this case, 6.3), and then I'll reset to -rc2
> or -rc3 for patches that are targetted for the next merge window (in
> this case, 6.4).
>=20
> The data=3Dwriteback patches was dropped from dev before the pull
> request, and won't show up on dev until they are ready for Linus.

Did you forget to push the dev branch out?  The version I have (and still s=
ee on git.kernel.org) has commit

  2c2dec1e86cc ("ext4: fix incorrect options show of original mount_opt and=
 extend mount_opt2")

at its head, but what you sent to Linus has commit

  e3645d72f886 ("ext4: fix incorrect options show of original mount_opt and=
 extend mount_opt2")

at its head.

--=20
Cheers,
Stephen Rothwell

--Sig_/lR6o7dtq7QQ3HgOXpDI/ylr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQHolkACgkQAVBC80lX
0GwyFAf/XraxgruCW7KtfRJthd4nCOKyFi89EeDJWTump9rrzdE42xghEYlScA3u
l/4CYccDYqmn2iXM6UCuR+L4JyKDekTs6LyFuq7m8p85rJfcIXaZ/mrSILz7It3r
buxydkx2621eazRar6GHGHnEia8144KoVlcOZ6Hwk/o/JbyYpTdLTfXWZlW0Telu
NJMFomjes4LZ5UIHRCFIwPv8eAcD88A+Epr0QNmSUp9kKnegPYqhehnQMqEr5gl3
OpzJ1rg8n3La7vlg5F4sevUP7N8erOO9Sfu7e1Q3loBQnDhYYk6YzdXfCKwKYVPG
9DeijSmvP60918IH5VzDSjCv67vrHw==
=CzdL
-----END PGP SIGNATURE-----

--Sig_/lR6o7dtq7QQ3HgOXpDI/ylr--
