Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 960275005E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 05:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFXDwh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jun 2019 23:52:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38732 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbfFXDwg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jun 2019 23:52:36 -0400
Received: by mail-pl1-f196.google.com with SMTP id g4so6074369plb.5
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jun 2019 20:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5e2VHlWdPA4aSmpVGqTleBRGIntM2FAj5Oeba+xH80U=;
        b=x+V7cx0jkLLIdOadVDTHckvquovpqPfu5Z15fJYQNJOuO8HSfKPR37nbl3Clmp4P7g
         eQpVs20RdV+wgy5AhNzTsL5Z5QSc04/g1+Do04074YaFHAjIOV2NhleogFpuKsgXA3Uh
         N/hQUkAwf9LbfKK1vAQ8hXX/8SWVxNgUA5h6w2/3+K5zZZVhDlPiLy1HD7Ny4vAxguqC
         350Cb4LFnNuqK4mktbKrKdUfZxZkyKovzd3meORaNd7z9WaRTWOy5OmFxSgBD7ouUEqy
         JiwBbB2WKdyVyiNJh1A6HBwzWrNSid0i2IBUQfaeeaosxJb6qdhLeO46XI6FqRfbyASD
         WWOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5e2VHlWdPA4aSmpVGqTleBRGIntM2FAj5Oeba+xH80U=;
        b=YcMxMq/PPydmVkgQM3GhogiPF1UPN/OpA0fYjKfLFlqj+UqYqX6la2dsMAG2zdbo+I
         dYPQv2YaAhQ5Ji8I0wgkhVGuH5qUgOIzhVkKCXsrfm7szUBP4ygVSx+0yRhMaLX3jYL8
         ilXpNMyfGfWITWRPAbHvrGHF7WvfgQATgbeMzaCDCCIEae04CcuEpyrId/4v54PbRW07
         LlcKrAV6OT1G0tDgm8Kf70brRcvqk24WGzN3FnefcHQgq+NgE/NZJGtzhJUV1kDAzT7Y
         bFG78tmjPfL71QRYM7n1TE7o/onZePiKqSg8x/VTOSAouLQhMwMPsVQDTcOIdzLzdfxP
         8UbQ==
X-Gm-Message-State: APjAAAUw1DKn5U6cRLhNktin5eWlxiXt2wpTRCAadQJtO8DuUmNSGzQs
        2pJwehfmjumA7dK4iuDK7zMlGQ==
X-Google-Smtp-Source: APXvYqzEEUzM2SZmGRtDzADgmWe0FbZfBXh0uOmrLk5pM2LiMMX1m3ARSAlqGZiKF/C9XkndrKUGKg==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr5529405pll.162.1561348355802;
        Sun, 23 Jun 2019 20:52:35 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id i8sm6484618pjk.12.2019.06.23.20.52.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 20:52:34 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <62E29989-4C01-405D-B36B-B47FAAD90794@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C350F6B6-1BEC-4CE1-9ECE-35A87569311C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 08/16] ext4: Initialize timestamps limits
Date:   Sun, 23 Jun 2019 21:53:26 -0600
In-Reply-To: <20190618143110.6720-8-deepa.kernel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
References: <20190618143110.6720-1-deepa.kernel@gmail.com>
 <20190618143110.6720-8-deepa.kernel@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C350F6B6-1BEC-4CE1-9ECE-35A87569311C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 18, 2019, at 8:31 AM, Deepa Dinamani <deepa.kernel@gmail.com> =
wrote:
>=20
> ext4 has different overflow limits for max filesystem
> timestamps based on the extra bytes available.
>=20
> The timestamp limits are calculated according to the
> encoding table in
> a4dad1ae24f85i(ext4: Fix handling of extended tv_sec):
>=20
> * extra  msb of                         adjust for signed
> * epoch  32-bit                         32-bit tv_sec to
> * bits   time    decoded 64-bit tv_sec  64-bit tv_sec      valid time =
range
> * 0 0    1    -0x80000000..-0x00000001  0x000000000   =
1901-12-13..1969-12-31
> * 0 0    0    0x000000000..0x07fffffff  0x000000000   =
1970-01-01..2038-01-19
> * 0 1    1    0x080000000..0x0ffffffff  0x100000000   =
2038-01-19..2106-02-07
> * 0 1    0    0x100000000..0x17fffffff  0x100000000   =
2106-02-07..2174-02-25
> * 1 0    1    0x180000000..0x1ffffffff  0x200000000   =
2174-02-25..2242-03-16
> * 1 0    0    0x200000000..0x27fffffff  0x200000000   =
2242-03-16..2310-04-04
> * 1 1    1    0x280000000..0x2ffffffff  0x300000000   =
2310-04-04..2378-04-22
> * 1 1    0    0x300000000..0x37fffffff  0x300000000   =
2378-04-22..2446-05-10
>=20
> Note that the time limits are not correct for deletion times.
>=20
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: "Theodore Ts'o" <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Cc: linux-ext4@vger.kernel.org
> ---
> fs/ext4/ext4.h  |  4 ++++
> fs/ext4/super.c | 16 ++++++++++++++--
> 2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 1cb67859e051..3f13cf12ae7f 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1631,6 +1631,10 @@ static inline void =
ext4_clear_state_flags(struct ext4_inode_info *ei)
>=20
> #define EXT4_GOOD_OLD_INODE_SIZE 128
>=20
> +#define EXT4_EXTRA_TIMESTAMP_MAX	(((s64)1 << 34) - 1  + S32_MIN)
> +#define EXT4_NON_EXTRA_TIMESTAMP_MAX	S32_MAX
> +#define EXT4_TIMESTAMP_MIN		S32_MIN
> +
> /*
>  * Feature set definitions
>  */
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4079605d437a..0357acdeb6d3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4035,8 +4035,20 @@ static int ext4_fill_super(struct super_block =
*sb, void *data, int silent)
> 			       sbi->s_inode_size);
> 			goto failed_mount;
> 		}
> -		if (sbi->s_inode_size > EXT4_GOOD_OLD_INODE_SIZE)
> -			sb->s_time_gran =3D 1 << (EXT4_EPOCH_BITS - 2);
> +		/* i_atime_extra is the last extra field available for =
[acm]times in
> +		 * struct ext4_inode. Checking for that field should =
suffice to ensure
> +		 * we have extra spaces for all three.
> +		 */
> +		if (sbi->s_inode_size >=3D offsetof(struct ext4_inode, =
i_atime_extra) +
> +			sizeof(((struct ext4_inode *)0)->i_atime_extra)) =
{
> +			sb->s_time_gran =3D 1;
> +			sb->s_time_max =3D EXT4_EXTRA_TIMESTAMP_MAX;
> +		} else {
> +			sb->s_time_gran =3D 0;
> +			sb->s_time_max =3D EXT4_NON_EXTRA_TIMESTAMP_MAX;
> +		}
> +
> +		sb->s_time_min =3D EXT4_TIMESTAMP_MIN;
> 	}
>=20
> 	sbi->s_desc_size =3D le16_to_cpu(es->s_desc_size);
> --
> 2.17.1
>=20


Cheers, Andreas






--Apple-Mail=_C350F6B6-1BEC-4CE1-9ECE-35A87569311C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0QSTYACgkQcqXauRfM
H+AvGBAArX+4Z27UrSx/23J0d4+SDwbnQ0NT/zkXoYpQHR4JNvGLWmWioQXx7ccn
NYB9BB9SlNXiF2rhjrHVNH2vjRjAJ6b4udc/WeZMhgJqUAAMMXaeM6jpF5DRIsvx
6kuNJWdkiq+tvP9MOnCyPuOijqEqqcBMA7H5dOxW7P1xHSsIWcWh/ny22yYzOLc9
YD610aHYWIN9L54mUOzA6ceDePJQJG4LqVDfkvyULgAbwOB90a3rucZe4KzkTebR
WNco07rw5TFplUysjEnHrLt6KrFrL/I0wZjNj2jn53cBpy6FM34XJ5r8dgJZZ86Q
oDrl7fwE2BBuQq9BZLrtEulkAJrtKL+T+OPnM5YU5YvsAETo4mb9I9QMrVXVEq9Q
BWXIzg2QzeyEtMrwgHDhGtIFYOCORUQ/ZuMLd/CTvkmA4bGZSVefcx4LCA+bvQZ3
xfiItILSYQZvXY+g5UQxRuFeaoCXJLU1F4Ixvy2ktNyM0kH3GeVM52zOo1X9e6dj
lPrMGAqHkstWobtUoPZC3qFSPWCjA8QzDvKpceUcRTqLs3MVMYdlvGzpN00fUV7a
UtumF+AoScqhje6aVZwjhu1bDd0cnPx1Jut5OE1PQxHHmcE7cdS3mU8f+mpBos5G
tWv0AD2wODfEq9g6mJSGWXd3lp+8fQiWjtcrIhTmMTtnxFhPV+M=
=Yb4r
-----END PGP SIGNATURE-----

--Apple-Mail=_C350F6B6-1BEC-4CE1-9ECE-35A87569311C--
