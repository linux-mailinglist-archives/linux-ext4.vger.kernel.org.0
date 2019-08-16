Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9A8FA8D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2019 07:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHPF6E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Aug 2019 01:58:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35267 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbfHPF6E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Aug 2019 01:58:04 -0400
Received: by mail-io1-f66.google.com with SMTP id i22so4021947ioh.2
        for <linux-ext4@vger.kernel.org>; Thu, 15 Aug 2019 22:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1q4+lec5lE3oPEjUfr+2rU/XH8zkPynfx0NGg+l+r5s=;
        b=qTtkD8Ms/1nhlGvVlIPJAVzFaFYKP3l98jOVIqs9uD5KglIoQkd1TbwVMgsXSVH6Nu
         5xaTfEn43PBHyxJH/DOVImUI5+S0JODQ19tgSGdhgRYT5KthO5apvWDS05vIJ0JEK62R
         A9DhGZsrzEeornxC4/CqLMQPI4/Wbwq7b3NH3jj3OeOYl+1GznmFZ5czRwA135mBsrLr
         3xUfxF8T6ir/uJHE0C6jmEMv6fhcWQFr0TumftPqfIxYV10T9HlDDXF1qeFuO2+iH9yG
         XnehxyRLcXk8Lb68Y8xJcJ0wl/txpivZ20siBetwEPvlCof4vUXpDO2swP1kn9aARA/Z
         LPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1q4+lec5lE3oPEjUfr+2rU/XH8zkPynfx0NGg+l+r5s=;
        b=ej4JOTciljbFWKjJNtv5ZNe0mJMzBz0QtNpUHs65Id0jprN0jOjkDVCf8Ti50i8WpN
         ad/0nmmO+V918JuMKFH31wJ94EKL9uUDcRdSv10DD07TYGb5vjAlTFnP45aCo+uxnIp9
         t8mwjy8tZEbFhvCO96Q3jfb+ASna1V691fNZ6b+y26RKbWd+Vka2J73TK/UFGl+HtjAV
         ABhOgxtmvDHoLlZ93wwJBqa1vMcowtbh4ATqUbr2BoeEehP3cvynmSe78zvCGHrdj4QF
         7HY4ae1kJXajl1A5Za8cBMuwB1b5E6R0j5A+bVq8L9LspFYvCR95mgXfLqRjkcxB9aPM
         xljw==
X-Gm-Message-State: APjAAAXF/67Xp3lPQp+Rwc2P3+H49GWakTRKmdWnyBkWRNBiQ7NhdKTh
        woT4XDzNFZWcOM3rk9wW+vePtQ==
X-Google-Smtp-Source: APXvYqxxPT5e4ZPfesIfmaxwr6bDR1FrypkFU6Tq9mNYscLR+GqGZc9ipzaNtukJl0udbvXXFyJ3mg==
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr6976670iog.255.1565935083384;
        Thu, 15 Aug 2019 22:58:03 -0700 (PDT)
Received: from [172.20.10.11] ([24.114.55.80])
        by smtp.gmail.com with ESMTPSA id m20sm5101060ioh.4.2019.08.15.22.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 22:58:02 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <16AB3BA6-831E-41E7-B48B-B217FA9CFF3B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B93C4445-5282-4A58-86A7-539DD8FF9BAC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] libext2fs: optimize
 ext2fs_convert_subcluster_bitmap()
Date:   Thu, 15 Aug 2019 23:58:05 -0600
In-Reply-To: <20190816034834.29439-1-dongyangli@ddn.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Dongyang Li <dongyangli@ddn.com>, Theodore Ts'o <tytso@mit.edu>
References: <20190816034834.29439-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B93C4445-5282-4A58-86A7-539DD8FF9BAC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 15, 2019, at 9:49 PM, Dongyang Li <dongyangli@ddn.com> wrote:
>=20
> For a bigalloc filesystem, converting the block bitmap from blocks
> to chunks in ext2fs_convert_subcluster_bitmap() can take a long time
> when the device is huge, because we test the bitmap
> bit-by-bit using ext2fs_test_block_bitmap2().

"bit-by-bit" can fit on the previous line.

> Use ext2fs_find_first_set_block_bitmap2() which is more efficient
> for mke2fs when the fs is mostly empty.
>=20
> e2fsck can also benifit from this during pass1 block scanning.

"benefit"

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
> lib/ext2fs/gen_bitmap64.c | 21 +++++++++------------
> 1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index 6e4d8b71..97601232 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -28,6 +28,7 @@
> #ifdef HAVE_SYS_TIME_H
> #include <sys/time.h>
> #endif
> +#include <sys/param.h>
>=20
> #include "ext2_fs.h"
> #include "ext2fsP.h"
> @@ -799,8 +800,8 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 	ext2fs_generic_bitmap_64 bmap, cmap;
> 	ext2fs_block_bitmap	gen_bmap =3D *bitmap, gen_cmap;
> 	errcode_t		retval;
> -	blk64_t			i, b_end, c_end;
> -	int			n, ratio;
> +	blk64_t			i, next, b_end, c_end;
> +	int			ratio;
>=20
> 	bmap =3D (ext2fs_generic_bitmap_64) gen_bmap;
> 	if (fs->cluster_ratio_bits =3D=3D =
ext2fs_get_bitmap_granularity(gen_bmap))
> @@ -817,18 +818,14 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 	bmap->end =3D bmap->real_end;
> 	c_end =3D cmap->end;
> 	cmap->end =3D cmap->real_end;
> -	n =3D 0;
> 	ratio =3D 1 << fs->cluster_ratio_bits;
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
> +		i =3D bmap->start + roundup(next - bmap->start + 1, =
ratio);
> 	}
> 	bmap->end =3D b_end;
> 	cmap->end =3D c_end;
> --
> 2.22.1
>=20


Cheers, Andreas






--Apple-Mail=_B93C4445-5282-4A58-86A7-539DD8FF9BAC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1WRe0ACgkQcqXauRfM
H+B0lRAAjP4NOXgCT5UgUoX8z6V6WQRIsamh46lMY3uA0YuFX36Um6+jFeQ+agEg
F4ugw2tnf43IwEGr5HxLwfJ0Vrx6TlkHUQem4HFa7JfXa7UTNeGrdDlLHI6vhNyT
l5zsW4SQW47Bn3WMNYnBXcNMDP61VZ99QpcRH2aHMBMHcx6M2L9RWV7vRlngyt41
sjL17pd6JbVMIdhoZrb6jwsXwBzI78bW2gf38oEshb7+seXrtpSf4TyJOGil1kQW
nEyO0CaQyd7rVrujjpGulhTFi5XQf5SLOKyO6QApldHH8eA/UnLbczz+TcOwp13w
YcBw2oAXoxM7tDOGQEZ0QyS1p40mQ+bfmXIyeclia2dIJYKS9LVi3t5//2OAxWV9
4XH28X6ATPreusb28L2ZyYVI3VYfbOTK0RTiuOaYZLC5uaQK1Ngfb+LvRB/VEmLt
NDSAmElhRCPq+bnJ0TLdYQbufK9i2NHJIQOjYoXmAsM9uw7giUSDmAgSvIZ6Xk1Z
nnz52Y+VVr2qadmn9HgAZhOcW9D3ONdGJ56ZCdznv1e6/FASAPG7ZTAzVSRwLLLd
ers2NmRHvQzhVuDeBTI0bZofDhJvzQFEma+B9C1wuLCSQCCWTnh91GGXDSQ/acfJ
fRd0qM3iZDIGl0IadPit51PBnVuXELwjdoegdqSkQQgNb27PDiw=
=PR25
-----END PGP SIGNATURE-----

--Apple-Mail=_B93C4445-5282-4A58-86A7-539DD8FF9BAC--
