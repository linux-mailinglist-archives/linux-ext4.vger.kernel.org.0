Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2411F0185
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jun 2020 23:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgFEV0H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 17:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgFEV0G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 17:26:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D358C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 14:26:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so3354102pjb.5
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=akp7YNHlTSPuKxro5t3hRhRa//uBAoONtuzOYZH66fE=;
        b=aQ54V/DO9VgYOSLT1yC/sO4nMctcjh5uP0Zr4dMmZ6Xpd4hMMtwHVb2sxDiuJ0vwHY
         S5clMHi+BcI5DxjkfzL+1J3aQcGE1ich7xCe4HYuPrzLWY08xuLfL1loZZgF1sjZvdFk
         7Px/ZNXyWDUumSNlpQKminzlMah3InS+B77Rt2+1xfAyFVeeRdzt+wGZRUNLKMKAvn1j
         xCN2KrQ6mcw7kNGpusmFvijAaOQuQrcYTalBflPOmE1Pe+TifYHGiXLKTAhwWThM6/DD
         wr757cJJWLb9cx+S0o0Tpr1JlX7bEQF1pFmuXHnbOKBeK9Uok/AOsA6IPijcPKkU7cR7
         3XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=akp7YNHlTSPuKxro5t3hRhRa//uBAoONtuzOYZH66fE=;
        b=RmGUU4xW6dDQ6yXN0QrNjXmhD/ltsOGJ8ofFMdeTSHT3hhOb7zoKhZbnzq7TyPCLWM
         Vk+1UqzBd520JfXVnR48BwXmY0c/mzj2EE2HWH1DgGNYBKbgWllbKTR1sdlmYsB25lEi
         iYlItIvHo3+3v/w9rLbcrMfLRnacfH9TMGvDjKOHBUIkHj3S4IbAxX7xiS1rVTDSc+PI
         vc0kOQCKbGKtOW6HPIUd/J2LRFKjTKGbeIhGVyd/NhVXNtXre18gdAVegYA0Wti5DQBL
         hHDiVVrxkPobUV8axHo6pdZSFl+SpbPP0I3LBVCb44F54+CGp1VBwb7JR8Y5XGRAfkvn
         bvrw==
X-Gm-Message-State: AOAM533MaQtsVr9Q7uJdrlihHIl2twNPAnK6HVsr5pDbZ6vz5+RVP8TX
        WvTVrFnkCA5xwnhnKRyOraSEuI7nNkk=
X-Google-Smtp-Source: ABdhPJyBTnTEPiuzL/B74oG4KlfzOlOXevnsUPJ8Xpext26dDVjKMPOaOu9GjCd+Zw/OhC5dG7mTIw==
X-Received: by 2002:a17:902:b08d:: with SMTP id p13mr11508731plr.131.1591392365501;
        Fri, 05 Jun 2020 14:26:05 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id m2sm8936156pjf.34.2020.06.05.14.26.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2020 14:26:04 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1D928A6F-0C72-4943-A571-52300DDCE77B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0508F768-4C1F-4807-96E9-00702C9AE3BA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] e2fsck: use size_t instead of int in string_copy()
Date:   Fri, 5 Jun 2020 15:26:01 -0600
In-Reply-To: <20200605081442.13428-2-lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20200605081442.13428-1-lczerner@redhat.com>
 <20200605081442.13428-2-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0508F768-4C1F-4807-96E9-00702C9AE3BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 5, 2020, at 2:14 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> len argument in string_copy() is int, but it is used with malloc(),
> strlen(), strncpy() and some callers use sizeof() to pass value in. So
> it really ought to be size_t rather than int. Fix it.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Thanks, having good types makes it much easier to follow code logic.

There are still a bunch of places in e2fsprogs that are using "int" and
"long" for various blocks, counters, etc. that could use more precise
types.  I did a bunch of cleanup when I reviewd all of the directory and
allocation code for 64-bit issues. It still lingers elsewhere, but every
fix improves the code a bit, if we keep an eye on other incoming =
changes.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/e2fsck.h | 2 +-
> e2fsck/util.c   | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 9b2b9ce8..85f953b2 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -627,7 +627,7 @@ extern void log_err(e2fsck_t ctx, const char *fmt, =
...)
> extern void e2fsck_read_bitmaps(e2fsck_t ctx);
> extern void e2fsck_write_bitmaps(e2fsck_t ctx);
> extern void preenhalt(e2fsck_t ctx);
> -extern char *string_copy(e2fsck_t ctx, const char *str, int len);
> +extern char *string_copy(e2fsck_t ctx, const char *str, size_t len);
> extern int fs_proc_check(const char *fs_name);
> extern int check_for_modules(const char *fs_name);
> #ifdef RESOURCE_TRACK
> diff --git a/e2fsck/util.c b/e2fsck/util.c
> index d98b8e47..88e0ea8a 100644
> --- a/e2fsck/util.c
> +++ b/e2fsck/util.c
> @@ -135,7 +135,7 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, =
unsigned long size,
> }
>=20
> char *string_copy(e2fsck_t ctx EXT2FS_ATTR((unused)),
> -		  const char *str, int len)
> +		  const char *str, size_t len)
> {
> 	char	*ret;
>=20
> --
> 2.21.3
>=20


Cheers, Andreas






--Apple-Mail=_0508F768-4C1F-4807-96E9-00702C9AE3BA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7auGoACgkQcqXauRfM
H+BLERAAo6GMokrqLArgkGVZTaUu8NYnd7nAUc3hr0dP4GIrLmsj+woAqVbIv79s
WTt0P0kYDMMmceY9MBbYML6f6syxPvVyE+8tAe0JEu/IcsHqzIUFlgiE9+fz5wpp
vvjHd4Y03B9drJs4MUoXlbqQAENF0wx3VPREXbSTDFkZRPH+5KiY/wZ+jBRLej0i
IrthFjTiMIlOTycCHoHYMV3QJobpR7/++6lfRKabb+KlBFIAkuMrXyaRLdks/jEQ
z6Il1x1KvkArDKBmV39b3rHQgT/V7loSU8RfPIN7S4rHlTLDVjXiF1D+NuFA2Ww/
o3ri7wVl73VO2BBVAI0cF1KNMRaKs0HApiSGyhKjWrztS7DWfIfPitAJdYrJPCOO
URnjB0mdWbGOXYjNQB6ONmMNSwqQSsqyrf50blCti82/tazvrE7A+IslL0hOGnho
/ySYGcN0f7+E626Umg9jlv3QmfUkN9zdPKfEcedZczMAlJ3aFM3G0CxuC3taEuFL
UHvjX8gMsHCzFts2zqw+NlxK4YyLvnMyz7CEu/t03SvjwqJA9U3UnV5D7alqBFVP
aKbo0YIquJgjG6R50lCsRFphaimWNFmH41pgfYSMaS/mZxdKOKoe/yVngHS39sl0
VhEoIYnAbZZAsEGNKz8qXmr2cLzmQ/MPsWXVEygPv9uP87hEGx8=
=jeN+
-----END PGP SIGNATURE-----

--Apple-Mail=_0508F768-4C1F-4807-96E9-00702C9AE3BA--
