Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37A666C70
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 09:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjALIcb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Jan 2023 03:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjALIcW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Jan 2023 03:32:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A9BDF21
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 00:32:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s13-20020a17090a6e4d00b0022900843652so1282801pjm.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Jan 2023 00:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=X/W0JcpOeXGf9V/96A1YjPvC27Sm7xaFBA4eB0fmtRs=;
        b=vA3UmjnoTl+OqXVt7lXUOXqxTG/CCfbvtxriq5TVraGFyoDpT3SUD22aAW+N6penma
         o8Ve1WI9875U89PZXYUKP44wjoKEE/HdfGafKNpvgEgi5BMxmhLiGVhNkgp9ZOvpRl12
         qIJfrQSeExVHCTU3k4nohvrURF2eJjTddESaOp1jTVRCEj+uWydri6sJ5+KxYuphc48y
         WBPYPfmc1JDJrsMYnmjlztdaGO5EC257PHvlREI827YJjYE5HMsRJhokpbZKFYQjeMjh
         Jx4N3W/eqrDri2fvLoYvbVCv9KdO3OHtmmQiOgRFkShpZG7/Btp9C4h/poG2qDilGPrU
         0tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/W0JcpOeXGf9V/96A1YjPvC27Sm7xaFBA4eB0fmtRs=;
        b=4qko9CMcLMzPAIBJc8qd6IgPyhbLP1on40LSMa5Mezt5THr1AUwaX8c2Y7uU5eEQbP
         tiUTVD3T9tgYpoiBvb0jZM931/mjGb9+az7Xfv49XBn4P0lSArikFcdK36nGR1wC3iMd
         nApUia6kIQ9B8/EOps7ht/k4ETvZyHIHasce69yLJHjT4IcA4ZslsNGcRJ9RDgR5buJp
         axBk4UTN0cQYSrgypjXQq1Izi/ifi/42PZ1NHCTgg18Hz+zfw+1nAD8zggJwGyQ6hPVP
         BkSt5d57/z/lLFvkOZmBOLO6SxEn3S6tfIsN2LrnTnV91x3ozoPk69lrdeRhmkRaE5LD
         aeQg==
X-Gm-Message-State: AFqh2krsEVV0HZ9SEiwyjAo1L7uMUAHwC1HLSnxWCGVZfPh5bqDOe/oU
        zZ3139pDKBMSGw1hdWH7yMRtGCswP+oE5q1QG98=
X-Google-Smtp-Source: AMrXdXuYuu9AFbaRntvwI/pCVqzp2fidjSfT7+zHsjurs+KwStpScXd9IL8clFKq99kkQ3IJBdPUEQ==
X-Received: by 2002:a17:90a:1588:b0:223:1a17:55c3 with SMTP id m8-20020a17090a158800b002231a1755c3mr78590742pja.41.1673512339558;
        Thu, 12 Jan 2023 00:32:19 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090a890300b00218cd71781csm10233960pjn.51.2023.01.12.00.32.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jan 2023 00:32:18 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <99F35207-7E6C-498E-9F4F-05569781B0C0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_86DD2579-2856-4ADB-83E1-141ABFA4300A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: optimize clone_file on large devices
Date:   Thu, 12 Jan 2023 01:32:16 -0700
In-Reply-To: <20221219130544.259410-1-dongyangli@ddn.com>
Cc:     linux-ext4@vger.kernel.org
To:     Li Dongyang <dongyangli@ddn.com>
References: <20221219130544.259410-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_86DD2579-2856-4ADB-83E1-141ABFA4300A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 19, 2022, at 6:05 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> When cloning multiply-claimed blocks for an inode,
> clone_file() uses ext2fs_block_iterate3() to iterate
> every block calling clone_file_block().
> clone_file_block() calls check_if_fs_cluster(), even
> the block is not on the block_dup_map, which could take
> a long time on a large device.
>=20
> Only check if it's metadata block when we need to clone
> it.
>=20
> Test block_metadata_map in check_if_fs_block()
> and check_if_fs_cluster(), so we don't need to go over
> each bg every time. The metadata blocks are already
> marked in the bitmap.
>=20
> Before this patch on a 500TB device with 3 files having
> 3 multiply-claimed blocks between them, pass1b is stuck
> for more than 48 hours without progressing,
> before e2fsck was terminated.
> After this patch pass1b could finish in 180 seconds.
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> e2fsck/pass1b.c             | 73 ++++++-------------------------------
> tests/f_dup_resize/expect.1 |  3 +-
> 2 files changed, 13 insertions(+), 63 deletions(-)
>=20
> diff --git a/e2fsck/pass1b.c b/e2fsck/pass1b.c
> index 92c746c1d..950af5be0 100644
> --- a/e2fsck/pass1b.c
> +++ b/e2fsck/pass1b.c
> @@ -90,7 +90,7 @@ static void delete_file(e2fsck_t ctx, ext2_ino_t =
ino,
> 			struct dup_inode *dp, char *block_buf);
> static errcode_t clone_file(e2fsck_t ctx, ext2_ino_t ino,
> 			    struct dup_inode *dp, char* block_buf);
> -static int check_if_fs_block(e2fsck_t ctx, blk64_t test_block);
> +static int check_if_fs_block(e2fsck_t ctx, blk64_t block);
> static int check_if_fs_cluster(e2fsck_t ctx, blk64_t cluster);
>=20
> static void pass1b(e2fsck_t ctx, char *block_buf);
> @@ -815,8 +815,6 @@ static int clone_file_block(ext2_filsys fs,
> 		should_write =3D 0;
>=20
> 	c =3D EXT2FS_B2C(fs, blockcnt);
> -	if (check_if_fs_cluster(ctx, EXT2FS_B2C(fs, *block_nr)))
> -		is_meta =3D 1;
>=20
> 	if (c =3D=3D cs->dup_cluster && cs->alloc_block) {
> 		new_block =3D cs->alloc_block;
> @@ -894,6 +892,8 @@ cluster_alloc_ok:
> 				return BLOCK_ABORT;
> 			}
> 		}
> +		if (check_if_fs_cluster(ctx, EXT2FS_B2C(fs, *block_nr)))
> +			is_meta =3D 1;
> 		cs->save_dup_cluster =3D (is_meta ? NULL : p);
> 		cs->save_blocknr =3D *block_nr;
> 		*block_nr =3D new_block;
> @@ -1021,37 +1021,9 @@ errout:
>  * This routine returns 1 if a block overlaps with one of the =
superblocks,
>  * group descriptors, inode bitmaps, or block bitmaps.
>  */
> -static int check_if_fs_block(e2fsck_t ctx, blk64_t test_block)
> +static int check_if_fs_block(e2fsck_t ctx, blk64_t block)
> {
> -	ext2_filsys fs =3D ctx->fs;
> -	blk64_t	first_block;
> -	dgrp_t	i;
> -
> -	first_block =3D fs->super->s_first_data_block;
> -	for (i =3D 0; i < fs->group_desc_count; i++) {
> -
> -		/* Check superblocks/block group descriptors */
> -		if (ext2fs_bg_has_super(fs, i)) {
> -			if (test_block >=3D first_block &&
> -			    (test_block <=3D first_block + =
fs->desc_blocks))
> -				return 1;
> -		}
> -
> -		/* Check the inode table */
> -		if ((ext2fs_inode_table_loc(fs, i)) &&
> -		    (test_block >=3D ext2fs_inode_table_loc(fs, i)) &&
> -		    (test_block < (ext2fs_inode_table_loc(fs, i) +
> -				   fs->inode_blocks_per_group)))
> -			return 1;
> -
> -		/* Check the bitmap blocks */
> -		if ((test_block =3D=3D ext2fs_block_bitmap_loc(fs, i)) =
||
> -		    (test_block =3D=3D ext2fs_inode_bitmap_loc(fs, i)))
> -			return 1;
> -
> -		first_block +=3D fs->super->s_blocks_per_group;
> -	}
> -	return 0;
> +	return ext2fs_test_block_bitmap2(ctx->block_metadata_map, =
block);
> }
>=20
> /*
> @@ -1061,37 +1033,14 @@ static int check_if_fs_block(e2fsck_t ctx, =
blk64_t test_block)
> static int check_if_fs_cluster(e2fsck_t ctx, blk64_t cluster)
> {
> 	ext2_filsys fs =3D ctx->fs;
> -	blk64_t	first_block;
> -	dgrp_t	i;
> -
> -	first_block =3D fs->super->s_first_data_block;
> -	for (i =3D 0; i < fs->group_desc_count; i++) {
> -
> -		/* Check superblocks/block group descriptors */
> -		if (ext2fs_bg_has_super(fs, i)) {
> -			if (cluster >=3D EXT2FS_B2C(fs, first_block) &&
> -			    (cluster <=3D EXT2FS_B2C(fs, first_block +
> -						   fs->desc_blocks)))
> -				return 1;
> -		}
> +	blk64_t	block =3D EXT2FS_C2B(fs, cluster);
> +	int i;
>=20
> -		/* Check the inode table */
> -		if ((ext2fs_inode_table_loc(fs, i)) &&
> -		    (cluster >=3D EXT2FS_B2C(fs,
> -					   ext2fs_inode_table_loc(fs, =
i))) &&
> -		    (cluster <=3D EXT2FS_B2C(fs,
> -					   ext2fs_inode_table_loc(fs, i) =
+
> -					   fs->inode_blocks_per_group - =
1)))
> +	for (i =3D 0; i < EXT2FS_CLUSTER_RATIO(fs); i++) {
> +		if (ext2fs_test_block_bitmap2(ctx->block_metadata_map,
> +					      block + i))
> 			return 1;
> -
> -		/* Check the bitmap blocks */
> -		if ((cluster =3D=3D EXT2FS_B2C(fs,
> -					   ext2fs_block_bitmap_loc(fs, =
i))) ||
> -		    (cluster =3D=3D EXT2FS_B2C(fs,
> -					   ext2fs_inode_bitmap_loc(fs, =
i))))
> -			return 1;
> -
> -		first_block +=3D fs->super->s_blocks_per_group;
> 	}
> +
> 	return 0;
> }
> diff --git a/tests/f_dup_resize/expect.1 b/tests/f_dup_resize/expect.1
> index e0d869795..8a2764d32 100644
> --- a/tests/f_dup_resize/expect.1
> +++ b/tests/f_dup_resize/expect.1
> @@ -11,7 +11,8 @@ Pass 1D: Reconciling multiply-claimed blocks
> (There are 1 inodes containing multiply-claimed blocks.)
>=20
> File /debugfs (inode #12, mod time Mon Apr 11 00:00:00 2005)
> -  has 4 multiply-claimed block(s), shared with 1 file(s):
> +  has 4 multiply-claimed block(s), shared with 2 file(s):
> +	<filesystem metadata>
> 	<The group descriptor inode> (inode #7, mod time Mon Apr 11 =
06:13:20 2005)
> Clone multiply-claimed blocks? yes
>=20
> --
> 2.37.3
>=20


Cheers, Andreas






--Apple-Mail=_86DD2579-2856-4ADB-83E1-141ABFA4300A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmO/xZAACgkQcqXauRfM
H+AxlQ/+M1zCgpSpFqIltYcCWO+YCRZhTrfanxHsKooJcLkDhP5IX2UhXa9iz2AY
+4t5IJ2d0FDhqxwVjc4bvIV9v3Ey/N7objgfb8tLHVc4V+TC0l0PSsflrCWvAoYj
g70uliE+NReevmoPkCOAtzfrZuJR4COpPYL9J7XQU5STdqt3CVFENnSha7C0es/G
arXt8kEOgVxgVW/TzQwe0J+JAgYptvXdki85PWH2LeTdwpZ2cuyU07v4+XkD298L
30jiJ0O47K1PFTFFLmoUc+56C9XRAuDgi6T4+70CYKjiUdGqz/ccdURik7pGiVr7
RLS/b6WLYTtuaPyrDtyTPx+KpjVU1N5luhbMbOvLvUQ2u0BvRHT2CMHYWqCvwP2w
tlfNM1UUt8lEkMTU/82C0g9szNd2MRtmA0aGOuGml5mnrgGcputfq5DiRqVALxf4
Y59BYTX4lNj7pSi8sq+JDRq7mQ9LUMpoTVfc1O8uMG1EH5xZD34+LFhu8ynrUOOm
yIGWETb/MTPpDPXn5pCDiOE9FNaWg9QOhNj/1d+B9238AiXiGoIVaPI1dx0vG6cV
Uc3+AHo6QLqJJgUcaBnW3EZKHpgx+SZkiE6AhM/fSCv/d6Tn5L40+Bzml88zgtAm
HxfFwMqzU5Jm15Gpuh5fd8kQ+eNnLQN1DjcrZ0TUSD6UV9se8SU=
=OdKd
-----END PGP SIGNATURE-----

--Apple-Mail=_86DD2579-2856-4ADB-83E1-141ABFA4300A--
