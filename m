Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBBD3D6F59
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jul 2021 08:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhG0GV7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Jul 2021 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234905AbhG0GV6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Jul 2021 02:21:58 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45960C061757
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jul 2021 23:21:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso3455350pjs.2
        for <linux-ext4@vger.kernel.org>; Mon, 26 Jul 2021 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=JjbyKnn2E98J6rwMvHEfjfh0bvvIk2JaS+7r3v46qY8=;
        b=1pGZFlXS7VBmcwTkhxyuBPmzm0z+u00rWfciqeL4Un2MyVUpSqLDaVAPGqRhgJdxfs
         TGJsrucsQ1/vkH9hNhhTrBL8v/S3f0iBhTcTGnIUtlc7fuVcreFKfyda/SFDmeigItJY
         wqsHEw4RK1nByQ/BJqMo04rn0F3SFukymCB5vO4IrQ54RMtssGaw6p3mjeQvw50b7lRt
         q0+4QWaEtXaekMcduXRJd4YN6+1zAuF72LJ1cws2vz/ZNkTAIcQCzP7ZXRFOCvXQ5cZz
         zspeaGVp9HfrLtm6bol9OXUoB3Wm0P8pZVAGsjZ90OhIZCBJGKaAd+3gtdDILLO3wtAj
         l7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=JjbyKnn2E98J6rwMvHEfjfh0bvvIk2JaS+7r3v46qY8=;
        b=iPiNWdA204R8A7xmeSVhfYFTJ2YNEggShdnUGSb0X4iP06XBczQK8SdBtwCkLSy+PO
         kdEy6FmWHcikQOuxfX7KwpA0lC6mupI37SblrtP3/PcHSfiacJ+jGuxcd9MiXR8/KaJK
         6HRAWC9llcswneeXjp0rqO2C/FgaJTu7AYxjFqNYggZPtUHWYSTkoJA5mYCZ1AgMl8E5
         NCeW2gwNufI2rDA4rtRc2xSl1JQ7wsDHICYnAYHd9r9oO+qkz3tTa9lK4cdfwHMHfBAX
         KAUqusiUrd49iCMTICTJwf5kkRxWerLYQjv2IjGk8D7OqJIARG8zrZ6Om+0fLAnRQx2R
         9usg==
X-Gm-Message-State: AOAM531s0gQC49AbX24ccEllgM26FihbwOikILs43xQONyyOXkWRA5Xw
        Rw7hgImLCW6S4yMph5/9sVB5/VPEtXGwwumC
X-Google-Smtp-Source: ABdhPJx6inHt3qHC3IxjHvDEvEJJtCwq/FmEQ/S9yrauPnBcLq3AoJc2tJ4Knky+bslv1D/A8YlSvw==
X-Received: by 2002:a17:90a:7789:: with SMTP id v9mr21679398pjk.159.1627366918788;
        Mon, 26 Jul 2021 23:21:58 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id h25sm2160431pfo.190.2021.07.26.23.21.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 23:21:58 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <0FA2DF8F-8F8D-4A54-B21E-73B318C73F4C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F5BD7069-D5DD-4717-881F-9F4F011E01D0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: bug with large_dir in 5.12.17
Date:   Tue, 27 Jul 2021 00:22:10 -0600
In-Reply-To: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
Cc:     linux-ext4@vger.kernel.org
To:     Carlos Carvalho <carlos@fisica.ufpr.br>
References: <YPl/boTCfc3rlJLU@fisica.ufpr.br>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F5BD7069-D5DD-4717-881F-9F4F011E01D0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 22, 2021, at 8:23 AM, Carlos Carvalho <carlos@fisica.ufpr.br> =
wrote:
>=20
> There is a bug when enabling large_dir in 5.12.17. I got this during a =
backup:
>=20
> index full, reach max htree level :2
> Large directory feature is not enabled on this filesystem
>=20
> So I unmounted, ran tune2fs -O large_dir /dev/device and mounted =
again. However
> this error appeared:
>=20
> dx_probe:864: inode #576594294: block 144245: comm rsync: directory =
leaf block found instead of index block
>=20
> I unmounted, ran fsck and it "salvaged" a bunch of directories. =
However at the
> next backup run the same errors appeared again.
>=20
> This is with vanilla 5.2.17.

Hi Carlos,
are you able to reproduce this error on a new directory that did not hit
the 2-level htree limit before enabling large_dir, or did you only see =
this
with directories that hit the 2-level htree limit before the update?
Did you test on any newer kernels than 5.2.17?

Cheers, Andreas






--Apple-Mail=_F5BD7069-D5DD-4717-881F-9F4F011E01D0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmD/phIACgkQcqXauRfM
H+A+0hAAwGRnZMGpoV3ch4mutCejDlrM0k85cwqojcKnRrpJ0AVTWCW6fYfI9dK3
OdZ9GyvfTgswl4QPjfx/bD1/uoy3FRsyClljT5EBgIqZAOnevWActQf7SiL7vTvX
/KghPQpaxyfn9JXNcCXshcxnT83/hv7iefrCcI/D/5+ptmHbvg3KTp3a+H9EJxkt
t44FQJVlbsA3tr5oxrv3ajUWQdOMdO1mrn26uvbmp2Fe+8JjMTNe0U+UycfRnvof
evyOPAmxi0nvu7j7CyKsY7hOVG43EoIMPVuFN8C7BJxW1EzApf248/F7xStw7EzF
Sr0xFI25Z1FCDktaNoR3K831lRFQoYDtVqc3lm61Ymh/ZfWFLRiwSrs6im9of9nj
Bl/oH4va2LxX9ZnTUNKWh1mL2oZUL9fxeE+HkqsabuPm7QwRCyeh7hA4vPcuVijD
D0w8bMY0Y4bsn0LAfatIL0pU+C/OJJ3CVFAkey8eHJpWjhxv9QdHhARlEWXyv1s9
lOF9lWVVjdV5DkaUzVwS26NYybq0lOXaRTCvugJGCrlsnCSWrMqdzv0DKPFA5CeW
BKzndbHJXmyqjJmF0XYNGs+fmbF56LzxJNH90W/ARe+5mFi0Dmdi3On17MPeeJor
PaKSRT3ZmQxwj9iLXCqLpm1IE+RzMNryoHIKB9dH4Q9RXJgD0HE=
=0VbC
-----END PGP SIGNATURE-----

--Apple-Mail=_F5BD7069-D5DD-4717-881F-9F4F011E01D0--
