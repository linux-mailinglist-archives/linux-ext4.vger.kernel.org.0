Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3495D2D6B21
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 00:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391346AbgLJWba (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 17:31:30 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40952 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405143AbgLJW2Z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 17:28:25 -0500
Received: by mail-oi1-f195.google.com with SMTP id p126so7581591oif.7
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 14:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vlk+AGTP6yghUcwAQtekFD1W+cQuQJGh45l7hjsP3fk=;
        b=KGky8CK5wtAeJB/+xh/ZHtvwBrY2R6IjGyt9nWdk0JxO5sn6uBJaaUF6s9QfUPyoTe
         JRE5YpluXBthsRsYdnBIMaRXCh/pJ2er7rH2n0Fff6whmC4VMYdA0jI01mzTb/sejQdV
         Vvd8jVtvLRDs3GQk3Gvu8WPCRokp9leSgiBA667PEIG7X/NuOwJ7xEmL7GabmeL1Z1Rr
         1dd+uPZBmTaiG/ngb8ZC+8y7dVdYTBD+3hLdyMona7lCzGBkprLgUN87zw+NfZyNZy6q
         J6Kn4aTZdhFxBcqIN95CRe+r2Tjh4o7Y8ptaXrc90Fp18pRaGKwcqtfZJLU34sXopu+v
         IUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vlk+AGTP6yghUcwAQtekFD1W+cQuQJGh45l7hjsP3fk=;
        b=XMuXPjfYmFh38/CrvEL8i3QL1hBL5GXE7Ca2xiCtQdeFHm2T+2xPu8Wg+QHEZ0CRf7
         TGwAJhRD21nJmCRM1+b7aMi6oeh7bunftcB2wpKw4Pe/+l2Ki9qHMPamkNi59ZaOnzqM
         Jegb5mK+5j2MCZxlnHPTDdrEuk9nGlF2dfmr0oAoKeRAN8h4RcbUmmg2J/QoMvBMx8H4
         ETndTLnTbxIZo2pr3d0TCk4bbayWHg3VroSWqJtuXdCRDofLATxddsF2d4nObu/Q+IKN
         ju75Q/lR//JJp3KBURw7HvKuyuUa6HiG4pp+7epItCmRDy9U9I7roKMyOXtKanvDgYa2
         Oaiw==
X-Gm-Message-State: AOAM532W96J0+5pe20QEAPCFzcJ3XEejntAItCa2rPK9vJ1GGj2Qe/M4
        GSAN2QLCILrtRF/S48wHJ+g3aYBv33U10J7m
X-Google-Smtp-Source: ABdhPJyreAjBNBlx7RaCEcK3Kptt0GQptR472gbKUXAWTPN3CzrZ3iiD7d6/hXoKbUsjggzfETKZ7Q==
X-Received: by 2002:a17:90a:d148:: with SMTP id t8mr9867575pjw.126.1607638694152;
        Thu, 10 Dec 2020 14:18:14 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d4sm7275794pfo.127.2020.12.10.14.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 14:18:12 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <434BECC9-8882-4C42-95C9-827C0A53CF68@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0A429C94-849D-4A67-B36D-B3F1F8E9BAE3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 02/15] e2fsck: add kernel endian-ness conversion macros
Date:   Thu, 10 Dec 2020 15:18:09 -0700
In-Reply-To: <20201210175608.3265541-3-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
 <20201210175608.3265541-3-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0A429C94-849D-4A67-B36D-B3F1F8E9BAE3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 10, 2020, at 10:55 AM, harshadshirwadkar@gmail.com wrote:
>=20
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>=20
> In order to make recovery.c identical with kernel, we need endianness
> conversion macros (such as cpu_to_be32 and friends) defined in
> e2fsprogs. This patch defines these macros and also fixes recovery.c
> to use these. These macros are also needed for fast commit recovery
> patches later in this series.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>'

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/recovery.c       | 42 ++++++++++-------------------------------
> lib/ext2fs/jfs_compat.h |  6 ++++++
> 2 files changed, 16 insertions(+), 32 deletions(-)
>=20
> diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
> index 5df690ad..6c3b7bb4 100644
> --- a/e2fsck/recovery.c
> +++ b/e2fsck/recovery.c
> @@ -121,27 +121,6 @@ failed:
>=20
> #endif /* __KERNEL__ */
>=20
> -static inline __u32 get_be32(__be32 *p)
> -{
> -	unsigned char *cp =3D (unsigned char *) p;
> -	__u32 ret;
> -
> -	ret =3D *cp++;
> -	ret =3D (ret << 8) + *cp++;
> -	ret =3D (ret << 8) + *cp++;
> -	ret =3D (ret << 8) + *cp++;
> -	return ret;
> -}
> -
> -static inline __u16 get_be16(__be16 *p)
> -{
> -	unsigned char *cp =3D (unsigned char *) p;
> -	__u16 ret;
> -
> -	ret =3D *cp++;
> -	ret =3D (ret << 8) + *cp++;
> -	return ret;
> -}
>=20
> /*
>  * Read a block from the journal
> @@ -232,10 +211,10 @@ static int count_tags(journal_t *journal, struct =
buffer_head *bh)
>=20
> 		nr++;
> 		tagp +=3D tag_bytes;
> -		if (!(get_be16(&tag->t_flags) & JBD2_FLAG_SAME_UUID))
> +		if (!(tag->t_flags & cpu_to_be16(JBD2_FLAG_SAME_UUID)))
> 			tagp +=3D 16;
>=20
> -		if (get_be16(&tag->t_flags) & JBD2_FLAG_LAST_TAG)
> +		if (tag->t_flags & cpu_to_be16(JBD2_FLAG_LAST_TAG))
> 			break;
> 	}
>=20
> @@ -358,9 +337,9 @@ int jbd2_journal_skip_recovery(journal_t *journal)
> static inline unsigned long long read_tag_block(journal_t *journal,
> 						journal_block_tag_t =
*tag)
> {
> -	unsigned long long block =3D get_be32(&tag->t_blocknr);
> +	unsigned long long block =3D be32_to_cpu(tag->t_blocknr);
> 	if (jbd2_has_feature_64bit(journal))
> -		block |=3D (u64)get_be32(&tag->t_blocknr_high) << 32;
> +		block |=3D (u64)be32_to_cpu(tag->t_blocknr_high) << 32;
> 	return block;
> }
>=20
> @@ -429,9 +408,9 @@ static int jbd2_block_tag_csum_verify(journal_t =
*j, journal_block_tag_t *tag,
> 	csum32 =3D jbd2_chksum(j, csum32, buf, j->j_blocksize);
>=20
> 	if (jbd2_has_feature_csum3(j))
> -		return get_be32(&tag3->t_checksum) =3D=3D csum32;
> -
> -	return get_be16(&tag->t_checksum) =3D=3D (csum32 & 0xFFFF);
> +		return tag3->t_checksum =3D=3D cpu_to_be32(csum32);
> +	else
> +		return tag->t_checksum =3D=3D cpu_to_be16(csum32);
> }
>=20
> static int do_one_pass(journal_t *journal,
> @@ -579,7 +558,7 @@ static int do_one_pass(journal_t *journal,
> 				unsigned long io_block;
>=20
> 				tag =3D (journal_block_tag_t *) tagp;
> -				flags =3D get_be16(&tag->t_flags);
> +				flags =3D be16_to_cpu(tag->t_flags);
>=20
> 				io_block =3D next_log_block++;
> 				wrap(journal, next_log_block);
> @@ -643,9 +622,8 @@ static int do_one_pass(journal_t *journal,
> 					memcpy(nbh->b_data, obh->b_data,
> 							=
journal->j_blocksize);
> 					if (flags & JBD2_FLAG_ESCAPE) {
> -						__be32 magic =3D =
cpu_to_be32(JBD2_MAGIC_NUMBER);
> -						memcpy(nbh->b_data, =
&magic,
> -						       sizeof(magic));
> +						*((__be32 *)nbh->b_data) =
=3D
> +						=
cpu_to_be32(JBD2_MAGIC_NUMBER);
> 					}
>=20
> 					BUFFER_TRACE(nbh, "marking =
dirty");
> diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
> index 2bda521d..63ebef99 100644
> --- a/lib/ext2fs/jfs_compat.h
> +++ b/lib/ext2fs/jfs_compat.h
> @@ -20,12 +20,18 @@
> #define REQ_OP_READ 0
> #define REQ_OP_WRITE 1
>=20
> +#define cpu_to_le16(x)	ext2fs_cpu_to_le16(x)
> #define cpu_to_be16(x)	ext2fs_cpu_to_be16(x)
> +#define cpu_to_le32(x)	ext2fs_cpu_to_le32(x)
> #define cpu_to_be32(x)	ext2fs_cpu_to_be32(x)
> +#define cpu_to_le64(x)	ext2fs_cpu_to_le64(x)
> #define cpu_to_be64(x)	ext2fs_cpu_to_be64(x)
>=20
> +#define le16_to_cpu(x)	ext2fs_le16_to_cpu(x)
> #define be16_to_cpu(x)	ext2fs_be16_to_cpu(x)
> +#define le32_to_cpu(x)	ext2fs_le32_to_cpu(x)
> #define be32_to_cpu(x)	ext2fs_be32_to_cpu(x)
> +#define le64_to_cpu(x)	ext2fs_le64_to_cpu(x)
> #define be64_to_cpu(x)	ext2fs_be64_to_cpu(x)
>=20
> typedef unsigned int tid_t;
> --
> 2.29.2.576.ga3fc446d84-goog
>=20


Cheers, Andreas






--Apple-Mail=_0A429C94-849D-4A67-B36D-B3F1F8E9BAE3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/SnqIACgkQcqXauRfM
H+D7MxAAnFqY19owaNh4AUwywOM78Xkhho8pkVu2QCJ6r0fy+/PaZDU6ixO57Umd
92GX2wgoPcOGZbkrDDBVrIMHUwK4a4Kwy5pf0S49ZpcopuLdqEA68tbPLkXgSoWJ
xUdi35xUvnrhkUUIR7pRhTKWs6Ha8hOfAap1JqHkzySaePuy89sfsC2XWRF+4kdX
O5I34jVEM15SmTZyszCPt0XHA2hn1KCISbtMzlwtYNGQAq8d+s4d7nQLnSBsvx3Z
9gePSHi/IPAHvUq53oT+f0d4tCujdgc87g1s3JQ2BERBBrfVSrYnqIZ8jMeU1qvc
8O152gdeggIlkId6GbCHaVtEvhmhng1WhYmI3lB8Z5hfrp92V/bhza8bllSfRY8K
1mevrwY41HiCG5Av+QuzVn03hKkBMmqO8jmBlfTboVprxc9S0Gb8huNhg8dvIdL0
72aZ01zQ0dkPEz+FapZpA1+3Ckrv+zigC/qrjHmzXKPJY8E4bhsZS1jnApIhRWeN
0ncILResiumZl09n+M2lrbW4a7KdxeMwxiI6xLm+6GAI40AXkdfh4L9l+P6rkg0H
okoxYjU/3ZtuM2h0J8mj22FtSBgJMgqpiQw9srZHQj/k5IGuFZP1KLi3CNVhTkpq
HBUMWOZE7O0z2y3+6l3oEHZon6C7ys2Vya1gM9Kikkcvk40kDqM=
=dPqV
-----END PGP SIGNATURE-----

--Apple-Mail=_0A429C94-849D-4A67-B36D-B3F1F8E9BAE3--
