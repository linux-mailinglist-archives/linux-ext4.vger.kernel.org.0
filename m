Return-Path: <linux-ext4+bounces-1867-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BDB898D25
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 19:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1065289E53
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Apr 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486312D201;
	Thu,  4 Apr 2024 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="JqGheVtk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388914A8B
	for <linux-ext4@vger.kernel.org>; Thu,  4 Apr 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712251414; cv=none; b=hggAi2/FA6ozHdm1VvS2myUpupKy4ODAkoIl+g0oEwCclmo5IWvl9xTTDvHCMxLr8cKVqqPFi2xJO5D6q/+3UHgrp/3pD0rH/t0laYMYjfuaminjeVoeMOIvQBOE50DitHXpakCfahZ/zXSAM66RfXm3A/9okhblQLW47Nsffaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712251414; c=relaxed/simple;
	bh=/ERZcV89deQEGOScIgYObnKqWyzgP9IRdSFv/05OtyA=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=oy+3+fY3AfwPeAUP1gniVqYIP5OKyIxwVslHs1PxOM36Ya7rpb6s7euYbHjL8uDi5YvCTIeUi/Z7c5wuYIXVnt9XkGU3Bz6fz7tb9VRtUTXYsU72+ZEFZ8OtqmXazYdu6Js0/ihYV6A9d6FbIWL341+PnPaxw5fBP/PfM3cmfKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=JqGheVtk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e28856ed7aso9293965ad.0
        for <linux-ext4@vger.kernel.org>; Thu, 04 Apr 2024 10:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712251410; x=1712856210; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb9tMr2Ueop+PkfQHR3vRIKn8fg1o9ItUdFKJmhbC0k=;
        b=JqGheVtk1hnkE688ybj38ZPdF7q7QJ4WE9DRnX1AqpZt9OjPW8kK2KGOxAOSfVTMar
         4hcIj18GrnNaHewVtxIcvmXOUzIr52SpggPFyZv91/pMNVmXtcmWQf1PI9Mv6Onpyfyy
         hHTvOGxvk/M7EaxMF25cZv4q+qJb5dHg3xXzQjZdeuPdHOJwsbAs1miAl3nNwFgqbBMu
         YWDFY4FQi93mC74O47nolqKGS23PYuojOo88NuPA3EXq8cqoFwbcQBoveuaOqWUobXfu
         JtWlNMW3iav6+1whLsvBLnfOTRAJ6I1AAjydcJ8mM0VgcMebpgcj5pLjfE/31A8hqtOE
         M5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712251410; x=1712856210;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cb9tMr2Ueop+PkfQHR3vRIKn8fg1o9ItUdFKJmhbC0k=;
        b=ngx+YXMdvlA67ZsJYgZnVFI2tiMKHFu5eNMqG8jYuWix5fZUPtW/fN6tG1TAZqvWLd
         S/Pi1ub1fMf1wKLSCAFl/vJPFN/TTVJAaQZ4ioVrjDr1TVAzG0xrGZ6ksANEARUHlgfW
         LmEqGwNgpTIbYqes5FRyZ66QavJoPaDHntFrImn6mAazI3T/Z0cCMrwduX+uZdEkADgS
         2FhvMvWDulDPknN9YTN+hqBrQrFImCj/a48zUW+UHVilgn4jRvLpNElK+4kRZbIVyo5G
         PWPuTT5mbQaXqR0Ie+HjQzcvlX48N25AYeoo05nB37EKDovGB053tEoAAce/DjO5iMYu
         qoQw==
X-Forwarded-Encrypted: i=1; AJvYcCWemAvsdavLL4RaN9gI3ro6V8XCT4zRXeF1Fd+l+Xx3HaEKJl0hos2GVLu5x3ApSjUbGnFbZjqChYxVYDhow2mAhhYojSi+/tAIuA==
X-Gm-Message-State: AOJu0Yyd5QikfKC2b40nwP5dd97LZeZnPij/VLsDgSEPaJPP4C3IWHmX
	VVojiMk1RfJsPrCv4qzRLNxSb3xKfyuHAbsYRFYrghAnUbbSMJyAf44LqQn2Dz1k+mYAzVN6eFO
	p
X-Google-Smtp-Source: AGHT+IHVRDDylRnTtoXC814H5qoF/f53046x51Z7fremjqsHr0FyQ+dmVd/hf/8dYnQavq4GuSWmFA==
X-Received: by 2002:a17:902:a3cf:b0:1e2:8c26:3264 with SMTP id q15-20020a170902a3cf00b001e28c263264mr2751509plb.36.1712251410076;
        Thu, 04 Apr 2024 10:23:30 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id u16-20020a1709026e1000b001e27e52a7e4sm5837041plk.285.2024.04.04.10.23.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:23:29 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <04E748F4-0CE8-4376-B9E7-F1798EE84F67@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_29909484-59C8-4939-8E4F-3DD950891FD2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 2/4] e2fsck: update quota when deallocating a bad inode
Date: Thu, 4 Apr 2024 11:25:32 -0600
In-Reply-To: <20240404111032.10427-3-luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>,
 linux-ext4@vger.kernel.org
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
References: <20240404111032.10427-1-luis.henriques@linux.dev>
 <20240404111032.10427-3-luis.henriques@linux.dev>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_29909484-59C8-4939-8E4F-3DD950891FD2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 4, 2024, at 5:10 AM, Luis Henriques (SUSE) =
<luis.henriques@linux.dev> wrote:
>=20
> If a bad inode is found it will be deallocated.  However, if the =
filesystem has
> quota enabled, the quota information isn't being updated accordingly.  =
This
> issue was detected by running fstest ext4/019.
>=20
> This patch fixes the issue by decreasing the inode count from the
> quota and, if blocks are also being released, also subtract them as =
well.
>=20
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> e2fsck/pass2.c | 33 +++++++++++++++++++++++----------
> 1 file changed, 23 insertions(+), 10 deletions(-)
>=20
> diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
> index b91628567a7f..e16b488af643 100644
> --- a/e2fsck/pass2.c
> +++ b/e2fsck/pass2.c
> @@ -1859,12 +1859,13 @@ static int deallocate_inode_block(ext2_filsys =
fs,

I'd hoped you might include a better comment for this function, but the =
code
itself looks OK.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> static void deallocate_inode(e2fsck_t ctx, ext2_ino_t ino, char* =
block_buf)
> {
> 	ext2_filsys fs =3D ctx->fs;
> -	struct ext2_inode	inode;
> +	struct ext2_inode_large	inode;
> 	struct problem_context	pctx;
> 	__u32			count;
> 	struct del_block	del_block;
>=20
> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
> +	e2fsck_read_inode_full(ctx, ino, EXT2_INODE(&inode),
> +			       sizeof(inode), "deallocate_inode");
> 	clear_problem_context(&pctx);
> 	pctx.ino =3D ino;
>=20
> @@ -1874,29 +1875,29 @@ static void deallocate_inode(e2fsck_t ctx, =
ext2_ino_t ino, char* block_buf)
> 	e2fsck_read_bitmaps(ctx);
> 	ext2fs_inode_alloc_stats2(fs, ino, -1, =
LINUX_S_ISDIR(inode.i_mode));
>=20
> -	if (ext2fs_file_acl_block(fs, &inode) &&
> +	if (ext2fs_file_acl_block(fs, EXT2_INODE(&inode)) &&
> 	    ext2fs_has_feature_xattr(fs->super)) {
> 		pctx.errcode =3D ext2fs_adjust_ea_refcount3(fs,
> -				ext2fs_file_acl_block(fs, &inode),
> +				ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode)),
> 				block_buf, -1, &count, ino);
> 		if (pctx.errcode =3D=3D EXT2_ET_BAD_EA_BLOCK_NUM) {
> 			pctx.errcode =3D 0;
> 			count =3D 1;
> 		}
> 		if (pctx.errcode) {
> -			pctx.blk =3D ext2fs_file_acl_block(fs, &inode);
> +			pctx.blk =3D ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode));
> 			fix_problem(ctx, PR_2_ADJ_EA_REFCOUNT, &pctx);
> 			ctx->flags |=3D E2F_FLAG_ABORT;
> 			return;
> 		}
> 		if (count =3D=3D 0) {
> 			ext2fs_block_alloc_stats2(fs,
> -				  ext2fs_file_acl_block(fs, &inode), =
-1);
> +				  ext2fs_file_acl_block(fs, =
EXT2_INODE(&inode)), -1);
> 		}
> -		ext2fs_file_acl_block_set(fs, &inode, 0);
> +		ext2fs_file_acl_block_set(fs, EXT2_INODE(&inode), 0);
> 	}
>=20
> -	if (!ext2fs_inode_has_valid_blocks2(fs, &inode))
> +	if (!ext2fs_inode_has_valid_blocks2(fs, EXT2_INODE(&inode)))
> 		goto clear_inode;
>=20
> 	/* Inline data inodes don't have blocks to iterate */
> @@ -1921,10 +1922,22 @@ static void deallocate_inode(e2fsck_t ctx, =
ext2_ino_t ino, char* block_buf)
> 		ctx->flags |=3D E2F_FLAG_ABORT;
> 		return;
> 	}
> +
> +	if ((ino !=3D quota_type2inum(PRJQUOTA, fs->super)) &&
> +	    (ino !=3D fs->super->s_orphan_file_inum) &&
> +	    (ino =3D=3D EXT2_ROOT_INO || ino >=3D =
EXT2_FIRST_INODE(ctx->fs->super)) &&
> +	    !(inode.i_flags & EXT4_EA_INODE_FL)) {
> +		if (del_block.num > 0)
> +			quota_data_sub(ctx->qctx, &inode, ino,
> +				       del_block.num * =
EXT2_CLUSTER_SIZE(fs->super));
> +		quota_data_inodes(ctx->qctx, (struct ext2_inode_large =
*)&inode,
> +				  ino, -1);
> +	}
> +
> clear_inode:
> 	/* Inode may have changed by block_iterate, so reread it */
> -	e2fsck_read_inode(ctx, ino, &inode, "deallocate_inode");
> -	e2fsck_clear_inode(ctx, ino, &inode, 0, "deallocate_inode");
> +	e2fsck_read_inode(ctx, ino, EXT2_INODE(&inode), =
"deallocate_inode");
> +	e2fsck_clear_inode(ctx, ino, EXT2_INODE(&inode), 0, =
"deallocate_inode");
> }
>=20
> /*


Cheers, Andreas






--Apple-Mail=_29909484-59C8-4939-8E4F-3DD950891FD2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYO4owACgkQcqXauRfM
H+ArRQ/9GLbcyZP+Nu+glWMh5jTKs1ZHRlibcUNxYPNr1aQjKx3DlbId2tmnfPh4
Jyod75T9Q+wcUDeGcgWoUPI1Lm3c99twDLWFFllCswN1MUStZBc4lvpCjJS+Z8Ur
CLpbJ6jyC/0/4uck8/GtrIJplWqct+dOFMACW/ilq9Px/J2/P1POUBK0olxg1Vzb
uJKWVGsZaP4w/xSXnazdU+UhHlSbGXld75pFYwIC98eTKfXl/50iFuxabX1t4ifG
lDrNx1fMHI9vKGumRfGE7SVPGqbKi6zNHitpMv8f85VTcLzMjh+CHm7En+bwCA0G
4W4f6pSm9Y646vzsw9oowHYzau3zJdGbmyyeg97Q4B1Q5t00bL/cAmo7ZO2mWFH/
9LazzRdLyTfy9urDnc8PsSF3AgKifnOZPv1IMs5MJ2IHHq4fUA2jqOBV1yrqY5gE
YbZ8OaHiNYL6xR2iyFk7+UNT8HylZhfJCffcdur3AyBNj5drX+tfo67tvGDJPi79
Vz2xJ9ZelJQwQZ8wmBpJSb7qd/W8ZmSlNKheoCZ59WKR8brdq2fseM7Sw8gX7UZl
61E9eB/algOWGdCubazATB1EgfvQqZBMzPEc2O6bKv+TP+VnoLKjGutqDYJ3uOcD
H6d3rJZltU2K18eTqe+nIxZ1goZQJHvDtFs9aEvAsIuUg4bsruQ=
=P8OP
-----END PGP SIGNATURE-----

--Apple-Mail=_29909484-59C8-4939-8E4F-3DD950891FD2--

