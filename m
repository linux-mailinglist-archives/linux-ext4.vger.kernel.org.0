Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF93C9C78E
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 05:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfHZDOq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Aug 2019 23:14:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41441 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfHZDOp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Aug 2019 23:14:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id m9so9249437pls.8
        for <linux-ext4@vger.kernel.org>; Sun, 25 Aug 2019 20:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ZllGI13AlK4sHlxJJy9w6q6OSW8QfiylMxmDt6tuTOY=;
        b=P0UvXQzEMSN3TlwohcXnk3/ZWxgS/lgaaJ5klm0t6/twFu9xDtDTqOcCzThANBOu4H
         GEEuKPpRv2cPbdUVSn1fOoT1e8wm65+LlGFWUrfW8/5KpBaDkBF8auvcY1LhO886DJmE
         cHkLb8THsd3uAIGC/tdvH4lo8MqWiOFx5igcdzOZuXsF19bysMvOZpzGpcNzxCB5fP6m
         JvLNyliyO8m8tVxwIi9J7kwlAx8/ymEDdYhTSJvqbSEetKe0FHnCHTFDlIIJJ3/qvzWx
         A2GYsc8N2eh5pkJo8cTlFjy0IQ7KGgQIxRE1yEmYNxxjkbFo02GrFui0Z8iK5esoTCrH
         hDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ZllGI13AlK4sHlxJJy9w6q6OSW8QfiylMxmDt6tuTOY=;
        b=BLPu6U9O5u5uAI62Mf2eFcPL99zBbHbrHsl+WEpFgcRJu3nzbEDVOaRzTErZ9GmirD
         YeVCkhh+GkGbAXjVewnoBOHMLkwIn8pqT1Yr+BFsWcQbDpipQ7KAIH2X6c3Mi8B/gQUn
         9TwWMnpFeFyCB2uDIwmkZEQ5Ws8Gp9CDVynj5VoUMFcls0scPfXX/QnCw1KUkrkU96WV
         5mzB4nKJ8L9hB69yLW+snP2OsSVckDunW/3fxu85iddhLrRvPFwdafEAdPE1XxlqSRIB
         RxiM6bZZRrZOxD+aOKud+mdRwIplxFFpnS2bAYzjdWVNZtmRThoVWobLe6QtbaUmFTGX
         udOg==
X-Gm-Message-State: APjAAAWqoiLQJSjO+11O6vxUvdnNn7LIgzT39pI0GnemqKXZMDvxHKhe
        KFQVcY9PMF2JpfRV55y2kR5rEy5gjZsnCg==
X-Google-Smtp-Source: APXvYqwQqyKk4ziYrT/UwVqvb+X3XkyNXC5uCRgAQWSOZmHPLiqKAd+5KkOCtvD2USQbDXThQW+4UQ==
X-Received: by 2002:a17:902:1121:: with SMTP id d30mr16739645pla.174.1566789285017;
        Sun, 25 Aug 2019 20:14:45 -0700 (PDT)
Received: from cabot.adilger.ext (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id b136sm9747370pfb.73.2019.08.25.20.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Aug 2019 20:14:44 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <20839FA5-74D6-4F8E-81D4-26C7D57A94BC@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9065B471-2342-445A-A060-CE6707353314";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/4] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Date:   Sun, 25 Aug 2019 21:14:42 -0600
In-Reply-To: <20190822082617.19180-1-dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Dongyang Li <dongyangli@ddn.com>
References: <20190822082617.19180-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9065B471-2342-445A-A060-CE6707353314
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 22, 2019, at 2:26 AM, Dongyang Li <dongyangli@ddn.com> wrote:
>=20
> For a bigalloc filesystem, converting the block bitmap from blocks
> to chunks in ext2fs_convert_subcluster_bitmap() can take a long time
> when the device is huge, because we test the bitmap
> bit-by-bit using ext2fs_test_block_bitmap2().
> Use ext2fs_find_first_set_block_bitmap2() which is more efficient
> for mke2fs when the fs is mostly empty.
>=20
> e2fsck can also benefit from this during pass1 block scanning.
>=20
> Time taken for "mke2fs -O bigalloc,extent -C 131072 -b 4096" on a 1PB
> device:
>=20
> without patch:
> real    27m49.457s
> user    21m36.474s
> sys     6m9.514s
>=20
> with patch:
> real    6m31.908s
> user    0m1.806s
> sys    6m29.697s
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/gen_bitmap64.c | 20 +++++++-------------
> 1 file changed, 7 insertions(+), 13 deletions(-)
>=20
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index 6e4d8b71..f1dd1891 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -799,8 +799,7 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 	ext2fs_generic_bitmap_64 bmap, cmap;
> 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
> 	errcode_t		retval;
> -	blk64_t			i, b_end, c_end;
> -	int			n, ratio;
> +	blk64_t			i, next, b_end, c_end;
>=20
> 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
> 	if (fs->cluster_ratio_bits =3D=3D =
ext2fs_get_bitmap_granularity(gen_bmap))
> @@ -817,18 +816,13 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 	bmap->end =3D bmap->real_end;
> 	c_end =3D cmap->end;
> 	cmap->end =3D cmap->real_end;
> -	n =3D 0;
> -	ratio =3D 1 << fs->cluster_ratio_bits;
> 	while (i < bmap->real_end) {
> -		if (ext2fs_test_block_bitmap2(gen_bmap, i)) {
> -			ext2fs_mark_block_bitmap2(gen_cmap, i);
> -			i +=3D ratio - n;
> -			n =3D 0;
> -			continue;
> -		}
> -		i++; n++;
> -		if (n >=3D ratio)
> -			n =3D 0;
> +		retval =3D ext2fs_find_first_set_block_bitmap2(gen_bmap,
> +						i, bmap->real_end, =
&next);
> +		if (retval)
> +			break;
> +		ext2fs_mark_block_bitmap2(gen_cmap, next);
> +		i =3D EXT2FS_C2B(fs, EXT2FS_B2C(fs, next) + 1);
> 	}
> 	bmap->end =3D b_end;
> 	cmap->end =3D c_end;
> --
> 2.22.1
>=20


Cheers, Andreas






--Apple-Mail=_9065B471-2342-445A-A060-CE6707353314
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1jTqIACgkQcqXauRfM
H+C22BAAgXsnWxiMOBShmN4VNZ1vxdCb9/AuRNZeRg6qfpOlqT8+HbQ97T2J7+iC
m+p6w6qHKukeMHixvZtkbGRZKbUpGO2tVriP8nOngkhdORwXjcADOS0JUCYxjyqY
3vC3W5tXy9TwrHGKi2/1blYmgEc1WlqRcEd8Gu3wtH8welyDTY4aoR27b5OjFWl4
OjA8MiAvoX4ekQs+2wPbE3VkeQaxJza7pHY80sOoCx3yUbJqIddPBxywK/2q+KeH
oq4Z3jYDqXImnHAz7mAQ96lgvXjell7g5LqtRHCdiD+PjUFKmlfqiOb/YliEAZ0U
+5TPCeWR1BjOnaZ6/oyjorYMfdRRrFbv6cdseNZEjSDp8vzhPIBsTuedxu6qfknb
i2+ypHLG59WRGWP6RrbQpXVZpSVVD8foDo5QqjrELTbuOgtzTrsendX81YJij4tp
STAPNB1zHIbUHN3tm1wIb3PqjrjKs3GO2BAdygScS5Bxo22KOk10Ou/fxsqZEZ9f
hjwKvwzL45QhEa+QgE1C5K8jgL6tj5GYfgxuHRA2abFB+JhZD/qpmUWwXduhBtDQ
RbasXuqY6Vppmf53Fa18gJK0VcckwFQ4L7WpbbVfEfqi7mrEiSNrGY/HAUJpmbnf
N17fhC2OlQsnr/x4D+ImLypFsAAElDAUzqptctLdeNXL0hrwXNw=
=6Jyj
-----END PGP SIGNATURE-----

--Apple-Mail=_9065B471-2342-445A-A060-CE6707353314--
