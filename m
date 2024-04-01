Return-Path: <linux-ext4+bounces-1808-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417A8945C3
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52811F21ED2
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 19:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB9535CE;
	Mon,  1 Apr 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="OBDf9WPn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AF535D9
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001027; cv=none; b=ogCPUuF2dhWwTt8icoOIC1TUbVU/0o0/t6EgQCrfI5BQOHXezqrhVt+O3kqTuCBkFSorEzhPsbtsEXP/BXYSqD8CBHF8STHreOwtMykuARr4dp2FcXFua8rASvdS/eOZYVj/Ou6nn/+UGMHNL+xLvnBNKB4VYkt/HZ2xkLq9nzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001027; c=relaxed/simple;
	bh=dJGg+mIOgeL46nEEawfzYt2qIZ2gFeAyu9Kfo2vIZNk=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=o2JIvxh7ax9ldYzbNBwiJsiGgJUJkxA72x0VE24BXqcd/NEx6vk8s2G2RdQxA7vI+KHJ2pfyg7ytosT0ZwryfoJ3qK3OU96rQQMTvFdoQ57PFqgluk0BAkzkK/4n/87rOCeOeVsXK6aaxHXIEvgqPVqsmo1hxRgAcMhX8XGwK0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=OBDf9WPn; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so1623547b3a.2
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712001023; x=1712605823; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai2elRcw+h2bUT55LJF1cfd2ThQtPMogV+QXzs1JjM0=;
        b=OBDf9WPnDPpvNZ3wcz4qGHPep05WP/UAtouC6CEQ/HE4gVegy5HacLsFUkMHbea6KD
         V3L6xl2636XvcdxFC4cXHiUWxfSRlDxtLoBoB493C9xY0HtvkPuyh5KxQngry7mFRHeI
         5O3AUaGrp282Kb/BCflq4P3HUUcu6KHp3keOcvgqxEi0L7poL/TwcXoXzIK+oE/Au8Hx
         HWS61bFuQ6focoeKzg4/dSQTaXvlkqwDN6PILQtK+2Ayn2gYBhbt5H/rm9fNhtvnXR/w
         UDLwA5PxSBb0O1cdc1JwZamVwLvhXOPhkiXamHKkpbiLIhwJ8OixddgbJjVJic8lRkc8
         W7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712001023; x=1712605823;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai2elRcw+h2bUT55LJF1cfd2ThQtPMogV+QXzs1JjM0=;
        b=RaCdjCWC3xsKZ0VYrOc6Tew9NWP+ESrsabydMqNqn6/AbBS4i2wj0qdVT/CjVUsSoS
         sbKtBtgX+tk4PHAJn61LBGL+2bnXH4fXrHYkijRuXSBPFIu0ZVsEGeKbEbd+eiaVa+hm
         iYL01k15bB3BHu/Qmkex3Xb/YwIqJ4nKnhV5j4/xGkUvOpPldnxOozE0+lEL56dthxCx
         VpfZnxZdQA6A3WV5LYMtOF7aTWM0LTGie7UppXOWj0siRztX4wYeby1lvHtdX/QZ90NG
         SfuY9VxOvzhsdgJr+brNMjHC3r1hjcPnB7mvGiW371tlEuVmpVdWKbJsTRyzdWRlPAL6
         231g==
X-Forwarded-Encrypted: i=1; AJvYcCUelMEjayGhYQILFsXy+tWfGc5c/gi4XCUS57VnNEOouyKcYEclMntUl23sBu2Uwd4HiXQNHidTK1MmbbuaH7PkOrsNBkz4XGE2fg==
X-Gm-Message-State: AOJu0YwFhY5YzlsMkwMHmmg9fLjgVJAen4V1GJda9t6SkcJB/hrjFMCv
	UefZJoY0/dXGavkubg4Wm5xWBgzqseDXJUY4pTk7TEhnry0q+Wi06mKcvlP63/w=
X-Google-Smtp-Source: AGHT+IFrhsdoCilPuvUE110WyrRKWnx2gYLufajp3EvIkGFDSE0yHr1Sarv2Hmi2Suiy6B1LQnRb6w==
X-Received: by 2002:a05:6a00:240a:b0:6eb:2e47:62c0 with SMTP id z10-20020a056a00240a00b006eb2e4762c0mr5179439pfh.2.1712001023230;
        Mon, 01 Apr 2024 12:50:23 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id r2-20020aa78b82000000b006eaf43bbcb5sm5045454pfd.114.2024.04.01.12.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 12:50:22 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <098B73D9-5D47-48A0-91F9-EACD1E1581ED@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A2302E43-3836-4935-8BF9-1FD6D36E47FB";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] e2fsck: update quota accounting after directory
 optimization
Date: Mon, 1 Apr 2024 13:52:07 -0600
In-Reply-To: <20240328172940.1609-2-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240328172940.1609-1-luis.henriques@linux.dev>
 <20240328172940.1609-2-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_A2302E43-3836-4935-8BF9-1FD6D36E47FB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 28, 2024, at 11:29 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> In "Pass 3A: Optimizing directories", a directory may have it's size =
reduced.
> If that happens and quota is enabled in the filesystem, the quota =
information
> will be incorrect because it doesn't take the rehash into account.  =
This issue
> was detected by running fstest ext4/014.
>=20
> This patch simply updates the quota data accordingly, after the =
directory is
> written and it's size has been updated.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218626
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/rehash.c | 27 +++++++++++++++++++++------
> 1 file changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/e2fsck/rehash.c b/e2fsck/rehash.c
> index c1da7d52724e..4847d172e5fe 100644
> --- a/e2fsck/rehash.c
> +++ b/e2fsck/rehash.c
> @@ -987,14 +987,18 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, =
ext2_ino_t ino,
> {
> 	ext2_filsys 		fs =3D ctx->fs;
> 	errcode_t		retval;
> -	struct ext2_inode 	inode;
> +	struct ext2_inode_large	inode;
> 	char			*dir_buf =3D 0;
> 	struct fill_dir_struct	fd =3D { NULL, NULL, 0, 0, 0, NULL,
> 				       0, 0, 0, 0, 0, 0 };
> 	struct out_dir		outdir =3D { 0, 0, 0, 0 };
> -	struct name_cmp_ctx name_cmp_ctx =3D {0, NULL};
> +	struct name_cmp_ctx	name_cmp_ctx =3D {0, NULL};
> +	__u64			osize;
>=20
> -	e2fsck_read_inode(ctx, ino, &inode, "rehash_dir");
> +	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
> +			       sizeof(inode), "rehash_dir");
> +
> +	osize =3D EXT2_I_SIZE(&inode);
>=20
> 	if (ext2fs_has_feature_inline_data(fs->super) &&
> 	   (inode.i_flags & EXT4_INLINE_DATA_FL))
> @@ -1013,7 +1017,7 @@ errcode_t e2fsck_rehash_dir(e2fsck_t ctx, =
ext2_ino_t ino,
> 	fd.ino =3D ino;
> 	fd.ctx =3D ctx;
> 	fd.buf =3D dir_buf;
> -	fd.inode =3D &inode;
> +	fd.inode =3D EXT2_INODE(&inode);
> 	fd.dir =3D ino;
> 	if (!ext2fs_has_feature_dir_index(fs->super) ||
> 	    (inode.i_size / fs->blocksize) < 2)
> @@ -1092,14 +1096,25 @@ resort:
> 			goto errout;
> 	}
>=20
> -	retval =3D write_directory(ctx, fs, &outdir, ino, &inode, =
fd.compress);
> +	retval =3D write_directory(ctx, fs, &outdir, ino, =
EXT2_INODE(&inode),
> +				 fd.compress);
> 	if (retval)
> 		goto errout;
>=20
> +	if ((osize > EXT2_I_SIZE(&inode)) &&
> +	    (ino !=3D quota_type2inum(PRJQUOTA, fs->super)) &&
> +	    (ino !=3D fs->super->s_orphan_file_inum) &&
> +	    (ino =3D=3D EXT2_ROOT_INO || ino >=3D =
EXT2_FIRST_INODE(ctx->fs->super)) &&
> +	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
> +		quota_data_sub(ctx->qctx, &inode,
> +			       ino, osize - EXT2_I_SIZE(&inode));
> +	}
> +
> 	if (ctx->options & E2F_OPT_CONVERT_BMAP)
> 		retval =3D e2fsck_rebuild_extents_later(ctx, ino);
> 	else
> -		retval =3D e2fsck_check_rebuild_extents(ctx, ino, =
&inode, pctx);
> +		retval =3D e2fsck_check_rebuild_extents(ctx, ino,
> +						      =
EXT2_INODE(&inode), pctx);
> errout:
> 	ext2fs_free_mem(&dir_buf);
> 	ext2fs_free_mem(&fd.harray);


Cheers, Andreas






--Apple-Mail=_A2302E43-3836-4935-8BF9-1FD6D36E47FB
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYLEGgACgkQcqXauRfM
H+Av/xAAq4camu7y1nOaxY114JfnXcgVw5Yw8IdakEkMGfFZHmy3rHkMv3Xbye1V
Fx/A2gbC31nOxG3a8Ck+nV73Kublmzl95dag1tnMSmr0AqTdzlTbqymHv5stjELv
tSIF3wvWfmTzXAVGFx19JNTlbErZ2x0ctQpZi15CV+sQ6lI1hZgHMsC/JSLQKirL
zdQH5EpUiUR1/jIEUi1YcxqbkR2J+94TBe26ZR9KyD/p/bp9dJEXMKA7e35+C/CZ
SsHE7+JiCRJvVeRvEMEfwKHZhSNd6ztdQ5mp5vcTLinsmrAqc5jFBLUhJS6iKUcf
kD3zBGzlsUyH4pqGmWCNnlJL5k3BGIW/hlqFJMyroLWGFXAPQ4OlaVux5qtv+xUI
UAWie7nxW9t4O0843DLYzVSwrpnN3wWrh99aVa7otMBvwEKZj2H9BJFRYc4YLPdu
hIKU9egix7Qu4TmIsJalB4/RH0jl3m77Y6tpmiIwl3KFC158tqZNqsIEKCXoG7Iv
TxIfJpUNPu4wEr8r8xPvWutZGHXIP5NVrOztdmU0WPFc2yt5cqLKxxabDcQ/NGil
8TcBg4xfa/E7s0MuNmQgNdyB9QKJM0Rzm0HctQMdZQVoULezOYyz+rzQRmHLhPg9
oNmtUwa+B4DsRU34oPRGyEXUrKnSL/SenplVQjJZJFIePu8wO+4=
=HsB4
-----END PGP SIGNATURE-----

--Apple-Mail=_A2302E43-3836-4935-8BF9-1FD6D36E47FB--

