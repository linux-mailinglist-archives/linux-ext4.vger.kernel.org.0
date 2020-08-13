Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF7B2435DE
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 10:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMIUX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 04:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMIUX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 04:20:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949E5C061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:20:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so2456107pgb.2
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 01:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LbxBre4j5wgWNiOnVUMIBxVQPXw3IJamLz7oOYBCk98=;
        b=mzQc5xgon95kSo1UsJUqR3IhtF0wujeoycq9wbULBqcI2HhVBt/p3RQRV68QPHnbpA
         xQj80b5uSebk/0UCAhRKTW1rExJkM4B0uHfp3sTz122DAOn5uT7ZWZZVC2AtkythlUd+
         wFEZctFBxThkm5/rp7cAhxuM7cosANnxYulKFon7F2IrDHAjJvS5J8M0ioUApWjiwt9K
         UuXg3ydP37XIbhMoxsjg6iGAEWvQ6ETjjA7gHrBgtA/b8Prte7ySUEXUNGwHEdcGPPAh
         +e7GYvgBLH2XqbVwpUZi7xd4kdR/3RwFsSaOyapoatKeiMPT/GzQVkhNrcJLhEbVW9No
         xmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LbxBre4j5wgWNiOnVUMIBxVQPXw3IJamLz7oOYBCk98=;
        b=SrqJYeCIfw4WZShpUZp1q+YlX4c4aQW/HNescsAqg4+kEdjyjMtgJt8SX8DEga6/Yf
         LcrKreURV1g3mBe7rFcS6lcTKjv93gVBaVB4ndaROcPh3JO3XWpwyrfg4tMV0AzsTwAr
         8dZnByYqgEgs2DXzOYKNK+E1T671G0extF0RxfyrolYIU9hGyMGzZzhsG+8e+eS87nqF
         gLBNT0OoD6NIhqgNaLLMdmleDlgW9bTev5eCSXW4L6oe0iysHA/x8zNHIV2/TKmXibId
         UDBMe1Xt+v+pdBLZbDekRraSNS3ryvjAT6SzHu7SEA7YRBAxqWspJ3zyWyy6g5d3WWTq
         aeHQ==
X-Gm-Message-State: AOAM530J5beGWhEj6Jm/oCtGq5CIToffV+ldWjkGZ6uthB5rGx9S0awL
        SXRodwrbwbzT9DHLJPP+USBCcQ==
X-Google-Smtp-Source: ABdhPJz3nisXlOFfuuqWqBYNHLz1XRizRZi58jHfsVFlWhrLL/GMnZxIc1o2r3ZzPIxbbVi/Z96VwA==
X-Received: by 2002:a62:158e:: with SMTP id 136mr3337560pfv.36.1597306822686;
        Thu, 13 Aug 2020 01:20:22 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id y135sm5184051pfg.148.2020.08.13.01.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 01:20:21 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D636E979-399D-46F2-8F67-EFB135AEF2B8@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E9F137BF-6E78-4F1A-855E-04E678F291D8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: fix typos in ext4_mb_regular_allocator() comment
Date:   Thu, 13 Aug 2020 02:20:18 -0600
In-Reply-To: <d6514145-73b3-808b-ec5a-a8be27c51f9c@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <d6514145-73b3-808b-ec5a-a8be27c51f9c@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E9F137BF-6E78-4F1A-855E-04E678F291D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Aug 7, 2020, at 8:01 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Fix typos in ext4_mb_regular_allocator() comment
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f21f34..0edec26 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2237,8 +2237,8 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 		goto out;
>=20
> 	/*
> -	 * ac->ac2_order is set only if the fe_len is a power of 2
> -	 * if ac2_order is set we also set criteria to 0 so that we
> +	 * ac->ac_2order is set only if the fe_len is a power of 2
> +	 * if ac->ac_2order is set we also set criteria to 0 so that we
> 	 * try exact allocation using buddy.
> 	 */
> 	i =3D fls(ac->ac_g_ex.fe_len);
> --
> 1.8.3.1


Cheers, Andreas






--Apple-Mail=_E9F137BF-6E78-4F1A-855E-04E678F291D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8098MACgkQcqXauRfM
H+D3SxAAjKliuZGa47N7eqC6DRplouJ+sTMpgoKjqsEI0cYxuzm6+pZY15d1hvIS
Lle2UFFE53TwCuCxzo3bH+Z7/T/D09U5EKS900vYK870p9VwLSoCcxFesc1bfrQl
QGG4qhRS7shyTDnzhRIlepobtRdCN2dFR9sry2jv8RfV+w/XMsHnm1MOIt3+UZ+U
2VKZeE6C1pFIxwQqDjhUu6FLT7wfoye/Nityt6xgLfwI/hvUfIjkXLVJxTN0jetv
qHwsNBLKgiJ4PyHkRwecqQ4tq/YFjavrN5BzTh5+k1tQfJxlxMZCBc2CmP96OOA5
oamyT9TKLg+CWKG+YunzW336qfxSr1ZzLG/UPcc7IFVwAya0dMLonMGIX22IVMkw
XY2VtBiGxcCPNs02wYs75GqkwsVsc3d2Xesf3cy8MuIiui5yhQtO3U3PIfMEttR8
s4OstumbSr93orghLfPuRP2UyfUcud06zEmRauWHvChVcB+KgP12itsZppodNMvs
y2mYk8RNHE3dNxKP+56pOuI8PDWlEiY/UWYYV7HM3R3dpyXxmT+1pYVGkNmHeRUv
RN8LmZEIM4jEFQMvF+cWcAC3WWg3v1dGUaJ6+02n5MBchmq0BEWDsbKvtxeWLOGy
GJI2fknf5ti9npZTs1f4xcWoxE5+W1sBfF8UOBIp9ONMFOEARVM=
=4nWK
-----END PGP SIGNATURE-----

--Apple-Mail=_E9F137BF-6E78-4F1A-855E-04E678F291D8--
