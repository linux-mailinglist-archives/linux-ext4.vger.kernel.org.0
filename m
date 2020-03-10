Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27C86180BFC
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Mar 2020 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgCJXCh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Mar 2020 19:02:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46449 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXCh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Mar 2020 19:02:37 -0400
Received: by mail-pl1-f194.google.com with SMTP id w12so119391pll.13
        for <linux-ext4@vger.kernel.org>; Tue, 10 Mar 2020 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=U59O1Foeqobf/5A+Fbao0QIwyZDJIAT+QYUdmJYQzjU=;
        b=S7nD5nLK1kfHyqPQ3gqd2DS8vUDYgL55ddbe2Y0Tc5hxubbYY6N6mMfdnKBCDSlCAY
         S3TLsAjlelMpqQcnbBgb7oinKGQ/3Xq+wqTqVEkgIIgIqrEo9TLYytr8x8Wmi79UzrIh
         kzkp9UJ1Lltomwm0KHQrqxIz7sa84Wxtm7N8w1DQvW8D/mhFTJrulYXhXdNbhn0kvVtR
         W5mphEYjY5TAPEE+OOEB84tNxhKc7blvCf/9Vv2Qc+o9jmyGHRwmU6vMK4E00rTe4qHg
         0I36M0ic2UBXLQCgHKojTprHJ17QyzOBIsCnkUZ18wq3gGp+Ny2S9nc/E8nh028RDtbd
         sU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=U59O1Foeqobf/5A+Fbao0QIwyZDJIAT+QYUdmJYQzjU=;
        b=PHjUvNzrRsGbqFBIHaoDoo+1+x+qGhtEfcFPkr9Va68rel7nKWH656b7k/gC715caT
         W6ml6XAocEEYCQadClfFLD2IMdod55s67TS4PprGhOUAofAf3A5/zgH/LriQfpwQsddc
         hPPskP5pOXJ5uX9LgcFSUMFMyD8Ll4V2M42DSNyoROqCz4v6SwnoPyHKFhwuOFnQ6cqn
         QhMffF1fEp0iNz88YL6cvDpy4IrMYQjMDtS6CluWHisIBxVWryoSedHq1Bh9dYD/cPl5
         hSXUtmh2se7fGCMVUWqz7BAHzALFhxiV/WNAdaJX/i+a1iFtnXsS7OaWVYEc//zNB64A
         TdGQ==
X-Gm-Message-State: ANhLgQ10YB5gjDVmbJmKU1HP29MuK3gJIcWd4pAHxC8g2hwsMq6OC++u
        wtgjjw6JWNsZ0YtZCvL5R3bktdf1Gok=
X-Google-Smtp-Source: ADFU+vvdQp7sqAFaZNhgIbkQf7PaeAEDPoyXO0J4hcmwgOC5Mu5TMqOSPfFK/lr5e9GCxBEKYDt1/g==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr233309pll.120.1583881354163;
        Tue, 10 Mar 2020 16:02:34 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id dw19sm3239918pjb.16.2020.03.10.16.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 16:02:33 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <2BF8E155-34A0-4913-9B81-DC6CA1A4F6E0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_91421AA8-ED0D-48E8-8379-8C41047C5BF9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: mark block bitmap corrupted when found instead of
 BUGON
Date:   Tue, 10 Mar 2020 17:02:26 -0600
In-Reply-To: <20200310150156.641-1-dmonakhov@gmail.com>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
To:     Dmitry Monakhov <dmonakhov@gmail.com>
References: <20200310150156.641-1-dmonakhov@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_91421AA8-ED0D-48E8-8379-8C41047C5BF9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 10, 2020, at 9:01 AM, Dmitry Monakhov <dmonakhov@gmail.com> =
wrote:
>=20
> We already has similar code in ext4_mb_complex_scan_group(), but
> ext4_mb_simple_scan_group() still affected.
>=20
> Other reports: https://www.spinics.net/lists/linux-ext4/msg60231.html
>=20
> Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 1027e01..97cd1a2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1901,8 +1901,15 @@ void ext4_mb_simple_scan_group(struct =
ext4_allocation_context *ac,
> 		BUG_ON(buddy =3D=3D NULL);
>=20
> 		k =3D mb_find_next_zero_bit(buddy, max, 0);
> -		BUG_ON(k >=3D max);
> -
> +		if (k >=3D max) {
> +			ext4_grp_locked_error(ac->ac_sb, e4b->bd_group, =
0, 0,
> +				"%d free clusters of order %d. But found =
0",
> +				grp->bb_counters[i], i);
> +			ext4_mark_group_bitmap_corrupted(ac->ac_sb,
> +					 e4b->bd_group,
> +					=
EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> +			break;
> +		}
> 		ac->ac_found++;
>=20
> 		ac->ac_b_ex.fe_len =3D 1 << i;
> --
> 2.7.4
>=20


Cheers, Andreas






--Apple-Mail=_91421AA8-ED0D-48E8-8379-8C41047C5BF9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5oHIQACgkQcqXauRfM
H+C8iRAAt3auppTYpj6wIHsJkAIpeThViFToNRBGK4P5+CVZqwVaHJbosgt4ycwL
p1ttTa4jpJXqQxYodmMGK4XVfQP9VIva98xAYLeuU3M33HdOKa57TzNz3WXiEAkn
xwNzCHehBqIpQxZe67UBretM5X88//TJNjF2iml+0M5j5XtvGgCjg7Sg1J/ChRPz
T19Sf2oEm82MW8lEWezAqWll+E3aPLbX+YchIffeEAFZOKAO2Q9MJqfz/0UoXD1b
lfuI2ZZP5mM3+DOi3eAEvJX/TZDF8NjC+pCOmfiiWjQt+d92Yn+jGVytXjJQSxEb
6TQbKlJhobT8gmTh3KVUzchh2vYCRwGO7P/0aEWd+Au4JRJlWICC0mes6AqAMX8y
W2csjccS6QIHjrENkcfdQ8HpW265kr1lnffNxgcssGI2w0ChHRBIxG6XyVSqpUqJ
rPusqMZa4sL6uKuqfQqCN2P86K9dgbmq7g2bmquCZh4AcCaul8g4/doWnlgrrCIP
aXMeGF1c562OaICSfvJZlJDGdoAyLj69Ptj6U3cXg7PydthlBt+wPHOxI8x/JNaP
zmw5gjmeDhTQnx4KyBzIjUeq83a4zNfIlui4nS4I6GBxAAk90Io/ZFiw89VW2yVi
ctUnzSL9JT4i8BBa8GCUGL+sWrGkzg/iZC/fzxdygCnSdh6GjzA=
=ojSm
-----END PGP SIGNATURE-----

--Apple-Mail=_91421AA8-ED0D-48E8-8379-8C41047C5BF9--
