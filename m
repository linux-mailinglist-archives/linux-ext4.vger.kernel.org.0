Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DD12430B3
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHLWPQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHLWPP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 18:15:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C4C061383
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 15:15:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so1765055pgf.0
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0UirGK2eP5nYKQ3R//RuvacQF/GKHJCzSes3diH/p88=;
        b=cRzVwJCZg6RXxVbG0/pQyXaPOFrD16qD0t7W1AwIUOfu6U29fp5P7R8MzA0JeSLjID
         nk2su5x/xnoKqvyGFfcqvX4/Twhnb6OhWigT7dcD5hK+TGVuMRXenlgEKShTIyZvxgba
         HZIDJBq6iZwejF/9PFZX4ZNZ0KORMrgyak3plLRzRvKl/SSkS2YhSzszqSLNHFICaIbS
         VAk9XTx1X7TftdilIOi4QUHD1R8bSbb3wMeihqHVgIuDFg242x/xwEK9Vw+HCDwthntB
         96/xT7l9fFD7mPdg7gqjRTx6cgcXhXysnWZsJtHU3q80NaOu1K7hSKrHxDXRQ697u//m
         gR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0UirGK2eP5nYKQ3R//RuvacQF/GKHJCzSes3diH/p88=;
        b=WCnFRXuPng1skikq0l3zpth4RENMoz37nGe7/RVtdDjbjAKMXzICQjycyjAT5My78c
         tMs1Dew71HOSa15TYN1lcku96JtRZGdZRTVp6weetDKSxjoKomRM4s1VYTHwDdy9slzT
         IX8G0r/PFw2sVHavXRDfaKK++UZK09ykIf/A18IhEH9UwhlcF/mwwoPyNhewWXeQierO
         hmHImkqI9FlwZcPqXcQW+17Hn0ZJ/HH9r9QJTbUe9ARb0vQQCn+umYomOk652D5jdQXP
         YnsbNZWpszqiNvaxqiK7EAbSe+j7F0N5hBsnoz8pI0ZW+zE2qYz0XSXlJpK2iJPUVw0W
         O6Tg==
X-Gm-Message-State: AOAM530d+miEy3wL5XWnfdSCk1KM/OIKVgtSCwZvSRwZJaddzNTTIc2n
        Op6Ko8HSYZ2mEBw3K40GNYm3wtK3w1tICQ==
X-Google-Smtp-Source: ABdhPJw6MbhgDV79aUnSNLsaiWeLpjtyj3oisdUO9ERqWOEiTYR0NApBHT7V5rVZtAntbk0ir0/1hA==
X-Received: by 2002:a65:568b:: with SMTP id v11mr1116138pgs.396.1597270514667;
        Wed, 12 Aug 2020 15:15:14 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k29sm3389200pfp.142.2020.08.12.15.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 15:15:13 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C9DAA4E8-AEA4-45A3-BF0A-E895DEA2A6C2@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_26287D40-7947-423B-8F74-BBA9D1BEB9B7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: optimize the implementation of ext4_mb_good_group()
Date:   Wed, 12 Aug 2020 16:15:10 -0600
In-Reply-To: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <e20b2d8f-1154-adb7-3831-a9e11ba842e9@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_26287D40-7947-423B-8F74-BBA9D1BEB9B7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 7, 2020, at 8:01 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> It might be better to adjust the code in two places:
> 1. Determine whether grp is currupt or not should be placed first.
> 2. (cr<=3D2 && free <ac->ac_g_ex.fe_len)should may belong to the crx
>   strategy, and it may be more appropriate to put it in the
>   subsequent switch statement block. For cr1, cr2, the conditions
>   in switch potentially realize the above judgment. For cr0, we
>   should add (free <ac->ac_g_ex.fe_len) judgment, and then delete
>   (free / fragments) >=3D ac->ac_g_ex.fe_len), because cr0 returns
>   true by default.
>=20

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

This looks correct.  Not quite as simple as moving a few lines around,
but I think the logic is equivalent.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 14 +++++++-------
> 1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 28a139f..4304113 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2119,13 +2119,11 @@ static bool ext4_mb_good_group(struct =
ext4_allocation_context *ac,
>=20
> 	BUG_ON(cr < 0 || cr >=3D 4);

This could also potentially be removed and keep only "BUG()" in the
default: case, though it would be good to print the value of "cr".

>=20
> -	free =3D grp->bb_free;
> -	if (free =3D=3D 0)
> -		return false;
> -	if (cr <=3D 2 && free < ac->ac_g_ex.fe_len)
> +	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> 		return false;
>=20
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> +	free =3D grp->bb_free;
> +	if (free =3D=3D 0)
> 		return false;
>=20
> 	fragments =3D grp->bb_fragments;
> @@ -2142,8 +2140,10 @@ static bool ext4_mb_good_group(struct =
ext4_allocation_context *ac,
> 		    ((group % flex_size) =3D=3D 0))
> 			return false;
>=20
> -		if ((ac->ac_2order > ac->ac_sb->s_blocksize_bits+1) ||
> -		    (free / fragments) >=3D ac->ac_g_ex.fe_len)
> +		if (free < ac->ac_g_ex.fe_len)
> +			return false;
> +
> +		if (ac->ac_2order > ac->ac_sb->s_blocksize_bits+1)
> 			return true;
>=20
> 		if (grp->bb_largest_free_order < ac->ac_2order)
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_26287D40-7947-423B-8F74-BBA9D1BEB9B7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80ae4ACgkQcqXauRfM
H+BN2RAAgdze08GmPquvpE56LuFoQTaIBij/wzuxR2nnU4mvERfFwT2UVJPibR2U
ym8MLY8fj5urv0gPIpq0Jgmm6KzsOpnkDw5Azahv7I4y74bwKuEn4VDdhwPHI4qG
hlkkP19SvYq4+tmVZuzCVCWWuvrxVIYY1ryvM2j+KK4sUugXvHcKXeDGZYYS1ZR7
GR0Ibqy5D1pjSYLfkN2Oi1AM8idCaGMqRAKgyBHI4X0CoVbJNJfVgRz2xyfHV/0t
5IbTSxnM1GTcgCUUsQdeIVynHgjW/2M85kwRIszjnhsLp26RdxkRNqFMn1xKdyEQ
MSZtitE1nDGEn2usXRQ9OIUokdrl5GjZ5y+4pMLsZJkE63LTatw0fSVe7JQpTnfU
GAcR6KsVfpAnTsz65jgK34P8ryBEECXXY53LGvGS08+X+60Rcpqn67JWjkxQytMl
fiXB/2pflYcJtUxbnyE+Hqo8EuPjAEzhlwa2DJwTTQyBXJctvprG9McF2V3upcvd
1WsP8Lt/UXQ0tVvbwiZ7s8jNFdlNkSk15G3h4ZH+wlKGxwK/+1BeQmA17MdIMh9P
T05Lo4X8VHjD8wR0l3jSBg00ArVWD8Ph3jEATkftbFvZtZ+0L+onCGpEo9chb336
fv7hifT9O404eW+OTS8mF0itxeHVz5/93SiPp3XRRyeMEKdjbXc=
=cKvU
-----END PGP SIGNATURE-----

--Apple-Mail=_26287D40-7947-423B-8F74-BBA9D1BEB9B7--
