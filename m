Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D1815F6F4
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Feb 2020 20:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgBNThL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Feb 2020 14:37:11 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40637 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388101AbgBNThL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Feb 2020 14:37:11 -0500
Received: by mail-yb1-f193.google.com with SMTP id f130so5307917ybc.7
        for <linux-ext4@vger.kernel.org>; Fri, 14 Feb 2020 11:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0XAAuOtjtgJHon7++2VKUM8P6XgZXjPqnIyufkBMxb0=;
        b=l5bH+jDB6ohlfOMFK8GQdHfvvtetZhfqiI0ChzTR7BucCN4dybNlxZ5mCNygNZYAhL
         K+vUwMKgJBx0y4HWJs2BShsS5smc7X6LX74I7UkQUC5yK9CGM4iY39mv3lBgBIGpl1W1
         AMVULQgncZsLe04XAbEXDvM1JCVVFod3CauMsozBUtwHxsqd+NzcHAg2d9WPMaZvNf2F
         NiAqK/AGSUVHm0ZBBQhbZqTKFkFGTYuf0QbiGr6aRJA+PhD063GGvpxsoXf+sI+Ma46W
         qMBjAXmuHazgGv0oyxW5R+Vwj2wiAVagDeNHXuRb5qjFahO9OkfSpknK4uQpXbaK7G71
         gF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0XAAuOtjtgJHon7++2VKUM8P6XgZXjPqnIyufkBMxb0=;
        b=QlVdne+FQww7kqmj+JDR/NL00fAcbE1G76OqOhOzTu4ZRmG0hqInqR8UBrcu7tH5/D
         TZkX6ITEYiOE0NvKB1NMh1Fc603u/OLWu8kzR4UQoRe3G9gRLd4DmZBSQIj6jQ7IhDNG
         SH9dbs/NkWijoab3yWaItpdeKsok9PusvI/AMkGTQn8YLqMMjWMBJ2WgujO4u0RQa22T
         fkr5v/f3CtgxcE1l9re3vc0pkpasnvLT01RhCp47ZZOTypGBODYy+cPRCNWHGFg+A0Gn
         4VJ7JDSZBlkAMwNfORSvtkTNe18enKB5maxvBKH1/oLB6aVPWT8NcZ4caeNHB21w3tfc
         KNTw==
X-Gm-Message-State: APjAAAWhFc2+KxQptWJnfau2C+5TaVNz1dRSAJZJ/JygUIhXpcj2TWmc
        FOrcYa6Ynt7X12l09iSF3not7g==
X-Google-Smtp-Source: APXvYqxC5wiRX/lIUUzAoz9Q0282ycJRu2JdfpnGviV+/IQRZwZjMbk2ra2O8Eoo+wDTx7lWTvJtMA==
X-Received: by 2002:a5b:106:: with SMTP id 6mr4756635ybx.83.1581709029813;
        Fri, 14 Feb 2020 11:37:09 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id g65sm2732854ywd.109.2020.02.14.11.37.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 11:37:09 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9D561ECB-5D6E-4979-9CCB-26B56898A286@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_02D01D46-C460-44CE-8B3B-BC36BAF4E7BD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/7] ext2fs: Update allocation info earlier in
 ext2fs_mkdir() and ext2fs_symlink()
Date:   Fri, 14 Feb 2020 12:37:06 -0700
In-Reply-To: <20200213101602.29096-4-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-4-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_02D01D46-C460-44CE-8B3B-BC36BAF4E7BD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:15 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Currently, ext2fs_mkdir() and ext2fs_symlink() update allocation =
bitmaps
> and other information only close to the end of the function, in
> particular after calling to ext2fs_link(). When ext2fs_link() will
> support indexed directories, it will also need to allocate blocks and
> that would cause filesystem corruption in case allocation info isn't
> properly updated. So make sure ext2fs_mkdir() and ext2fs_symlink()
> update allocation info before calling into ext2fs_link().
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

I was wondering if this was done at the end of the function to avoid the
need to undo it if there was an error in the middle of the operation?
I suppose the worst that would happen in that case is an extra bit set
in the block bitmap until the next e2fsck, which is a relatively safe
side-effect...  I'm not sure whether e2fsck would abort anyway in the
case either of these functions return an error?

In any case, this is better than what is there currently.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


> ---
> lib/ext2fs/mkdir.c   | 14 +++++++-------
> lib/ext2fs/symlink.c | 14 +++++++-------
> 2 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/lib/ext2fs/mkdir.c b/lib/ext2fs/mkdir.c
> index 2a63aad16715..947003ebf309 100644
> --- a/lib/ext2fs/mkdir.c
> +++ b/lib/ext2fs/mkdir.c
> @@ -143,6 +143,13 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t =
parent, ext2_ino_t inum,
> 		}
> 	}
>=20
> +	/*
> +	 * Update accounting....
> +	 */
> +	if (!inline_data)
> +		ext2fs_block_alloc_stats2(fs, blk, +1);
> +	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
> +
> 	/*
> 	 * Link the directory into the filesystem hierarchy
> 	 */
> @@ -175,13 +182,6 @@ errcode_t ext2fs_mkdir(ext2_filsys fs, ext2_ino_t =
parent, ext2_ino_t inum,
> 			goto cleanup;
> 	}
>=20
> -	/*
> -	 * Update accounting....
> -	 */
> -	if (!inline_data)
> -		ext2fs_block_alloc_stats2(fs, blk, +1);
> -	ext2fs_inode_alloc_stats2(fs, ino, +1, 1);
> -
> cleanup:
> 	if (block)
> 		ext2fs_free_mem(&block);
> diff --git a/lib/ext2fs/symlink.c b/lib/ext2fs/symlink.c
> index 7f78c5f75549..3e07a539daf3 100644
> --- a/lib/ext2fs/symlink.c
> +++ b/lib/ext2fs/symlink.c
> @@ -162,6 +162,13 @@ need_block:
> 			goto cleanup;
> 	}
>=20
> +	/*
> +	 * Update accounting....
> +	 */
> +	if (!fastlink && !inlinelink)
> +		ext2fs_block_alloc_stats2(fs, blk, +1);
> +	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
> +
> 	/*
> 	 * Link the symlink into the filesystem hierarchy
> 	 */
> @@ -179,13 +186,6 @@ need_block:
> 			goto cleanup;
> 	}
>=20
> -	/*
> -	 * Update accounting....
> -	 */
> -	if (!fastlink && !inlinelink)
> -		ext2fs_block_alloc_stats2(fs, blk, +1);
> -	ext2fs_inode_alloc_stats2(fs, ino, +1, 0);
> -
> cleanup:
> 	if (block_buf)
> 		ext2fs_free_mem(&block_buf);
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_02D01D46-C460-44CE-8B3B-BC36BAF4E7BD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5G9uMACgkQcqXauRfM
H+BoGBAAtRwBBqtlyK4iFZqyHaEaC6WNTrcsMGqEaAMfu/PDnhzWOIrkyToaBctL
Fofn3IZfew4HMSPSeRkXCi3/g1Z5MKfdPN2ZxEi8q67UE1GtzneFmdv7sLm8mk6c
RWuq4gYtpQeZ2X3vrM5huDAzj6N72ffB62d22XtmMzsSvq1gT9AH4aGGSV6+YjYb
m3mhkyAm9Moq2XHoiLQQtjvY26vOiwQ6YfxahpwdU2+NLTMSf21mxtKVQyzkyn2i
ELo/MtyGo9MAgG7OpCMkuCYenTWSavtRxMk2sgHaAQ+Q04otDUeDclYMEZTTqnDh
4eGqOLW1wbYmxU8QfBbh/da1dRRu6fIx9e/yloIQrQjnGtbTZtTsSoLObO/k0jKg
j6Bkv72cWzdzr/6wJ3QMCikr3+TXS8512V2azDYkZGVAh5DmzJPUjA/Z2Fjgxygi
fhq7kBZMmiL+bh+yQe7DRa9xYX6TRLap7u3MW/X35BPJcq2TDCmmkASRJkoqFRlh
JndS8g4q/iASyO8RXz/f5mgvPoF+PEV3eS//ZDQK9ZDWu1ZjcXdkxoEe7DbSiARk
/YjRiVwF4YHIOLDAYx/clh5lCZswkqLQcJ5hMHlZ/1W0rByrZy6xBFqnfZK+jfOu
tkHK/BedwofEDNh2Du+S8ts9ZicNGYxTXiaZw8eaBNKawqw/D0k=
=Cm3R
-----END PGP SIGNATURE-----

--Apple-Mail=_02D01D46-C460-44CE-8B3B-BC36BAF4E7BD--
