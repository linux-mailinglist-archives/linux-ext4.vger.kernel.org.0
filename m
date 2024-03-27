Return-Path: <linux-ext4+bounces-1762-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A789888EF20
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 20:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE029CDF0
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Mar 2024 19:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468021509B2;
	Wed, 27 Mar 2024 19:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="XqEBnttW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4918130A60
	for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567477; cv=none; b=KIwv4usI98nPl9RYecD5GVf5hGMi4SEy+My6+buI9iddn1x1qKkJKPgu1r9sG6WBoeZ4xriUrJ29J7xT3p3emQQvhN+kN9VR3bA4mWiwtKGVfrBRQEIXxezXtWb+5IuJpf9Zfq7IKBnNyR11cvf9XX6Gcnck1368Odb2eYy33us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567477; c=relaxed/simple;
	bh=BUaJ4vSH9H9CHYDttYdgiL6C391gOlQLNRl5rVgjO2E=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=BN52NA1ZYQwv4HTnYZRuZ2f+M9jB6ea000P74BxLzUBzRWdaTPobl+uQHcQJkVXNPZD/MsIAEW7vmexSbYoe4n3Kq8n3CnGegJyHDYSLUdpJtNg81Xu+7j7QyA+KyxuiNctRZqvAXscKpwyXz65rGBpeOl7JBorzRAJbqLv1SC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=XqEBnttW; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eac64f2205so214325b3a.2
        for <linux-ext4@vger.kernel.org>; Wed, 27 Mar 2024 12:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1711567474; x=1712172274; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jG56tO92ba2rJOBiqqbdwDJouF7flBydhR/7n2DFjws=;
        b=XqEBnttW1ZugRUF/zpy5fn/4Yx6krg89XgKl70jVRLLHtpHPPYlP18Ow+xqNPT1spK
         TCAHC5rjW1TuIR8wOMLwV14OsOAfQmEofW+Kjc2c7mxAq/nbDX/GZbWRX/sPGVNhzLJo
         C4iSYvyqbBWSbEdGucje9RcE63WQH9/IMj6lKdoXPhqH0Ewe0RQeu76DoDe7/UEO/UnS
         OKWWeRp62c8v8HgN7uhJWevyEsp5UVThit3FDED4PSNpVelVk9PffvEyjcNPikBooGZI
         Aob5VSULviSlSs6LDvogXftU9CxMxsNoU7wgrkqNyhBhJYJlyf0qh+bdS0ngyiG3HlP+
         mzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711567474; x=1712172274;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jG56tO92ba2rJOBiqqbdwDJouF7flBydhR/7n2DFjws=;
        b=YuwfjgfNjaXxH9IgzP+mdHe8CirGyWNtz4493y25AS5zfqOz/5QQQj7K7XOGOD9vwV
         a9PN9lxjKOYUgO3CfaoNtBluybU/FJxW9y4x8NKY6k2bIV/+/7VFEWRHzFqzztt7ke1H
         zzY4E63ZIBFJz4iINiro3K9KLFzykOwk+PiN97XUXiG0unqeWsGZVwN6RjUPohi053yT
         8jYuTq3vS7lVdC+5K2LKZtvSAGAtdjWmv9NoP6jRqBBGMm3eQtRywgtectvQTbZsAJwu
         Q9q7PFevg23BxiUEtcsdv3N/Nf0FH2RcC2vF65lEPeJPGbZi/Q9QYGVt8RJOZ4b4ryN7
         Nlmg==
X-Forwarded-Encrypted: i=1; AJvYcCU5769e3/H06yxsaDI4eJh1/cGDu9GG4QW8/Yiw+FPStrkb47G8jKsD9zIVigSoEZ8sE71kBTUc1jemFzjO0z+HVhn9kJKIv86qgg==
X-Gm-Message-State: AOJu0Ywqk8a+XzxF+us/+pvbYkBzJS7NadwQq9fupe3CEf4Ow4++ReTI
	usnv5NJrZ3Rjx7ENFK4ZnwLCGh37bjBNRGcaHw8X7zKFdgZogLJs7RgeHHjimdlwVfho9SlYvZy
	O
X-Google-Smtp-Source: AGHT+IG0DASfyJMy5AnFP42ad8toJh8ob66Y1B6avCF2eg+SfpUG3WYwe2KP3k4adpzHr4JqvBspKg==
X-Received: by 2002:a05:6a00:21d6:b0:6ea:ad01:354f with SMTP id t22-20020a056a0021d600b006eaad01354fmr868773pfj.18.1711567473964;
        Wed, 27 Mar 2024 12:24:33 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id b7-20020a62cf07000000b006e6aee6807dsm8509752pfg.22.2024.03.27.12.24.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:24:32 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <F7E15565-D316-4F02-93D4-CC081AB421C0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4181BD24-3240-484A-858C-8AA278A7662E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH e2fsprogs] e2fsck: update quota accounting after directory
 optimization
Date: Wed, 27 Mar 2024 13:25:49 -0600
In-Reply-To: <20240327154352.22648-1-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240327154352.22648-1-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_4181BD24-3240-484A-858C-8AA278A7662E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 27, 2024, at 9:43 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> In "Pass 3A: Optimizing directories", a directory may have it's size =
reduced.
> If that happens and quota is enabled in the filesystem, the quota =
information
> will be incorrect because it doesn't take the rehash into account.
>=20
> This patch simply updates the quota data accordingly, after the =
directory is
> written and it's size has been updated.

Hi Luis,
thanks for the patch.  It looks reasonable, and might (partially) =
explain
why quota accounting occasionally reports inconsistencies by a few =
blocks
after running e2fsck.  You can add my Reviewed-by: to the patch.


Could you please include an e2fsck regression test for this, to confirm
that it is working and continues to work in the future?  It should be
possible to use something like the following to create a test case:

    # cd tests
    # make testnew
    # tune2fs -O quota,project f_testnew/image
    # mkdir /mnt/tmp
    # mount -t ext4 -o loop f_testnew/image /mnt/tmp
    # mkdir /mnt/tmp/subdir
    # chattr -p 1000 -P /mnt/tmp/subdir
    # touch /mnt/tmp/subdir/long-filenames-for-test-{1..1024}
    # rm /mnt/tmp/subdir/long-filenames-for-test-{1..1024..2}
    # umount /mnt/tmp
    # echo "directory optimization updates quota" > f_testnew/name
    # make testend
    # mv f_testnew f_quota_shrinkdir

and confirm in expect.[12] that the quota did not need to be repaired
afterward by e2fsck (i.e. there shouldn't be any error messages about
inconsistent quota).  Running this test with an unpatched e2fsck should
report that the quotas had to be fixed and the test should fail.


On a related note, it would be convenient if "make testnew" passed an
environment variable (e.g. $TESTNEW_OPTS) to mke2fs so more options
could be set at format time instead of using tune2fs afterward:

    # TESTNEW_OPTS=3D"-O quota,project" make testnew

It isn't a big deal in this case, but might be useful in the future.

Cheers, Andreas

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218626
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
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
>=20


Cheers, Andreas






--Apple-Mail=_4181BD24-3240-484A-858C-8AA278A7662E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYEcr0ACgkQcqXauRfM
H+DlRhAAt/nWD+Ez7qF4xJ+8wqJ+lSYS18KwdJ2yza54Fqmt8pGMNqmtaT6yDF6P
EL3iJuMnNNpVxC6staU+v+jojaHgSJUTRQ3B2a1cw4cTQDD3l7cFJ6+5xr+bgJ4D
YmlyTwxjqXIKSCKMBCZ2KPj6hb7c4fL0hBmR7bVSEiSYOPnDSiXerhHBeflpx7+5
eRAijxPhFwogCJt/hHWILh4+rhaNdglB+JXN2ro4oDDTv3dCxr9iXl38tpXwW7LY
fJCOEHzdjGzOVTqEBxWSLQMIu79h8OTOmyb8vqiRYx9pV2eVbOJ8kzdPMOc5184q
FLmNBUHiphRPi2OTesVudrQu0QobA5GjGN4IVw+IQ5NZEZylwqho/eTb1yiBApp8
Zxbv/F3ZtZU1VPZ0XdpCyfcnBNXFJLtIkkApFtdly2fvMbc3Oi3iYeb64NBVFX0n
1t5HqPF7VBbf02a5uRJk02pcmyWOEWH+kPhO1OszVjGM74srm7/AOYtJt0Q/8mgU
xiw9OXo0r+zZb8MbUXC8kNMXJT7Rv8FHVDD5zLoyEgQflW05YKuna9ELLwx7b5pc
4dAQwhJZgiIQz4blPvxfN1zYl62ZDATm2F7zsMWRi/4OCgjnRo7rx5iZE2ZMOnd6
sRhYrAxT+cPCUtkGxaHG4w7dOXztJBn4VDMOrMg2JtVBvgsD3dg=
=P8IU
-----END PGP SIGNATURE-----

--Apple-Mail=_4181BD24-3240-484A-858C-8AA278A7662E--

