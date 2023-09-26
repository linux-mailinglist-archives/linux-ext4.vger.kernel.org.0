Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E99E7AF580
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Sep 2023 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjIZUrf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Sep 2023 16:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIZUrf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 26 Sep 2023 16:47:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D964E4
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 13:47:28 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c3d6d88231so71077975ad.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Sep 2023 13:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695761248; x=1696366048; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IosRwe3r2xWqmmraCSzNjRuyoEKPGQnm2PAcWFBvljE=;
        b=Iadlym8y1OFfFR+GoATaEylNmBJ6l52S7nySBWZsDb4ekAvhI0hs5iwvZr9Rx9Ugoy
         Yb1LF1KrTALvH9Z4Ys50oq4Q51B7XnKSUOdA79B80ki7z4fRi/aJdmfEQV500nh94xUE
         JZoHPd9LuoQ2KeMbsFpwyniG108wolVyOsrEeIoQIM+leN97FiSZgUQXYfd+Xk+7yykq
         emump3NQa2iWim+BYhQiPd9V6CnQqMApBOXbtrR5kOph6LXfaqOH/kJUDH+jcf7E8mIp
         0jWAaTvSAxfMiDVYVhv9aimJ8xI0B5wzfWENF5LNHQp8ydcOyz8AozJskDg2xlO0RR+K
         QLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695761248; x=1696366048;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IosRwe3r2xWqmmraCSzNjRuyoEKPGQnm2PAcWFBvljE=;
        b=jrJfralDZ0an+AFsS5XycOvb7Zxtlv5TC9Wa91O8tQq5sQrZoWC0gCCodgMS0/FAXE
         y06ZWm88uk46ZIeCLNWKDuHnqGIz18lhAQDBwzF2bPyoDCE0RTbiZiS0k157ncJP3kJa
         lkRZzUnSU5BUKIJsr6l3wVvcIe69OHPMoeCNbxNz+gE/4q/A1RB7vZYvEuWgZ6s5KcSe
         nWk+3ycp0i1cniw6PtBbv03eF7nDH+VdbHNkcDJF4piyBoMYP/5TL4Jje0Do7kO9xMZa
         ssTrq1RmlWCVq0m4z4PuWFZW1NSGqdAvOqm4lnjWZ+xKQBOFmx1bmWCljGdGzg5/BJ16
         9BYQ==
X-Gm-Message-State: AOJu0YxZk2xocfwia3IaCG2QjIkdZ0ZmZOCJKI20Cv4uSLKxg4N/mGN9
        rP4pZHyTQSJNUqv+tRYeX2JngFckyjVBACUpOUw=
X-Google-Smtp-Source: AGHT+IHcIa4vyKGySjzof309L6579lMxfCGr+QsMTFSJVNm84pIOkpfoUTkpgWIUT9FDRlMD+l8z5w==
X-Received: by 2002:a17:902:e844:b0:1c3:f4fa:b1a2 with SMTP id t4-20020a170902e84400b001c3f4fab1a2mr10782473plg.8.1695761247632;
        Tue, 26 Sep 2023 13:47:27 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902b28500b001c62b9a51a4sm2539724plr.239.2023.09.26.13.47.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 13:47:26 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E5C0A205-1123-4D79-86DE-FDAEE106F53C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0FDEC728-94F9-4B23-874D-32B3F6AA4F73";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] mke2fs: set free blocks accurately for groups has GDT
Date:   Tue, 26 Sep 2023 14:47:25 -0600
In-Reply-To: <20230925060801.1397581-1-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230925060801.1397581-1-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0FDEC728-94F9-4B23-874D-32B3F6AA4F73
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 25, 2023, at 12:08 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> This patch is part of the preparation required to allow
> GDT blocks expand beyond a single group,
> it introduces 2 new interfaces:
> - ext2fs_count_used_blocks(), to return the blocks used
> in the bitmap range.
> - ext2fs_reserve_super_and_bgd2() to return blocks used by
> superblock/GDT blocks for every group, by looking up blocks used.
>=20
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> lib/ext2fs/alloc_sb.c     | 28 ++++++++++++++++++++++++++--
> lib/ext2fs/ext2fs.h       |  6 ++++++
> lib/ext2fs/gen_bitmap64.c | 17 +++++++++++++++--
> lib/ext2fs/initialize.c   | 30 ++++++++++++++++++++----------
> misc/mke2fs.c             |  2 +-
> 5 files changed, 68 insertions(+), 15 deletions(-)
>=20
> diff --git a/lib/ext2fs/alloc_sb.c b/lib/ext2fs/alloc_sb.c
> index 8530b40f6..e92739ecc 100644
> --- a/lib/ext2fs/alloc_sb.c
> +++ b/lib/ext2fs/alloc_sb.c
> @@ -46,8 +46,7 @@ int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
> 				 ext2fs_block_bitmap bmap)
> {
> 	blk64_t	super_blk, old_desc_blk, new_desc_blk;
> -	blk_t	used_blks;
> -	int	old_desc_blocks, num_blocks;
> +	blk_t	used_blks, old_desc_blocks, num_blocks;
>=20
> 	ext2fs_super_and_bgd_loc2(fs, group, &super_blk,
> 				  &old_desc_blk, &new_desc_blk, =
&used_blks);
> @@ -79,3 +78,28 @@ int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
>=20
> 	return num_blocks  ;
> }
> +
> +/*
> + * This function reserves the superblock and block group descriptors
> + * for a given block group and returns the number of blocks used by =
the
> + * super block and group descriptors by looking up the block bitmap.
> + */
> +errcode_t ext2fs_reserve_super_and_bgd2(ext2_filsys fs,
> +				        dgrp_t group,
> +				        ext2fs_block_bitmap bmap,
> +				        blk_t *desc_blocks)
> +{
> +	blk64_t	num_blocks;
> +	errcode_t retval =3D 0;
> +
> +	ext2fs_reserve_super_and_bgd(fs, group, bmap);
> +
> +	retval =3D ext2fs_count_used_blocks(fs,
> +					ext2fs_group_first_block2(fs, =
group),
> +					ext2fs_group_last_block2(fs, =
group),
> +					&num_blocks);
> +	if (!retval)
> +		*desc_blocks =3D num_blocks;
> +
> +	return retval;
> +}
> diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
> index 72c60d2b5..ae79a3443 100644
> --- a/lib/ext2fs/ext2fs.h
> +++ b/lib/ext2fs/ext2fs.h
> @@ -795,6 +795,10 @@ errcode_t ext2fs_alloc_range(ext2_filsys fs, int =
flags, blk64_t goal,
> extern int ext2fs_reserve_super_and_bgd(ext2_filsys fs,
> 					dgrp_t group,
> 					ext2fs_block_bitmap bmap);
> +extern errcode_t ext2fs_reserve_super_and_bgd2(ext2_filsys fs,
> +					       dgrp_t group,
> +					       ext2fs_block_bitmap bmap,
> +					       blk_t *desc_blocks);
> extern void ext2fs_set_block_alloc_stats_callback(ext2_filsys fs,
> 						  void =
(*func)(ext2_filsys fs,
> 							       blk64_t =
blk,
> @@ -1483,6 +1487,8 @@ errcode_t =
ext2fs_convert_subcluster_bitmap(ext2_filsys fs,
> 					   ext2fs_block_bitmap *bitmap);
> errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
> 				     blk64_t end, blk64_t *out);
> +errcode_t ext2fs_count_used_blocks(ext2_filsys fs, blk64_t start,
> +				   blk64_t end, blk64_t *out);
>=20
> /* get_num_dirs.c */
> extern errcode_t ext2fs_get_num_dirs(ext2_filsys fs, ext2_ino_t =
*ret_num_dirs);
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index 4289e8155..5936dcf53 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -945,8 +945,8 @@ errcode_t =
ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap,
> 	return ENOENT;
> }
>=20
> -errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
> -				     blk64_t end, blk64_t *out)
> +errcode_t ext2fs_count_used_blocks(ext2_filsys fs, blk64_t start,
> +				   blk64_t end, blk64_t *out)
> {
> 	blk64_t		next;
> 	blk64_t		tot_set =3D 0;
> @@ -975,6 +975,19 @@ errcode_t ext2fs_count_used_clusters(ext2_filsys =
fs, blk64_t start,
> 			break;
> 	}
>=20
> +	if (!retval)
> +		*out =3D tot_set;
> +	return retval;
> +}
> +
> +errcode_t ext2fs_count_used_clusters(ext2_filsys fs, blk64_t start,
> +				     blk64_t end, blk64_t *out)
> +{
> +	blk64_t		tot_set =3D 0;
> +	errcode_t	retval =3D 0;
> +
> +	retval =3D ext2fs_count_used_blocks(fs, start, end, &tot_set);
> +
> 	if (!retval)
> 		*out =3D EXT2FS_NUM_B2C(fs, tot_set);
> 	return retval;
> diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
> index edd692bb9..90012f732 100644
> --- a/lib/ext2fs/initialize.c
> +++ b/lib/ext2fs/initialize.c
> @@ -521,6 +521,15 @@ ipg_retry:
> 	csum_flag =3D ext2fs_has_group_desc_csum(fs);
> 	reserved_inos =3D super->s_first_ino;
> 	for (i =3D 0; i < fs->group_desc_count; i++) {
> +		blk_t grp_free_blocks;
> +		ext2_ino_t inodes;
> +
> +		retval =3D ext2fs_reserve_super_and_bgd2(fs, i,
> +						       fs->block_map,
> +						       &numblocks);
> +		if (retval)
> +			goto cleanup;
> +
> 		/*
> 		 * Don't set the BLOCK_UNINIT group for the last group
> 		 * because the block bitmap needs to be padded.
> @@ -530,24 +539,25 @@ ipg_retry:
> 				ext2fs_bg_flags_set(fs, i,
> 						    =
EXT2_BG_BLOCK_UNINIT);
> 			ext2fs_bg_flags_set(fs, i, =
EXT2_BG_INODE_UNINIT);
> -			numblocks =3D super->s_inodes_per_group;
> +			inodes =3D super->s_inodes_per_group;
> 			if (reserved_inos) {
> -				if (numblocks > reserved_inos) {
> -					numblocks -=3D reserved_inos;
> +				if (inodes > reserved_inos) {
> +					inodes -=3D reserved_inos;
> 					reserved_inos =3D 0;
> 				} else {
> -					reserved_inos -=3D numblocks;
> -					numblocks =3D 0;
> +					reserved_inos -=3D inodes;
> +					inodes =3D 0;
> 				}
> 			}
> -			ext2fs_bg_itable_unused_set(fs, i, numblocks);
> +			ext2fs_bg_itable_unused_set(fs, i, inodes);
> 		}
> -		numblocks =3D ext2fs_reserve_super_and_bgd(fs, i, =
fs->block_map);
> -		if (fs->super->s_log_groups_per_flex)
> +
> +		if (!fs->super->s_log_groups_per_flex)
> 			numblocks +=3D 2 + fs->inode_blocks_per_group;
>=20
> -		free_blocks +=3D numblocks;
> -		ext2fs_bg_free_blocks_count_set(fs, i, numblocks);
> +		grp_free_blocks =3D ext2fs_group_blocks_count(fs, i) - =
numblocks;
> +		free_blocks +=3D grp_free_blocks;
> +		ext2fs_bg_free_blocks_count_set(fs, i, grp_free_blocks);
> 		ext2fs_bg_free_inodes_count_set(fs, i, =
fs->super->s_inodes_per_group);
> 		ext2fs_bg_used_dirs_count_set(fs, i, 0);
> 		ext2fs_group_desc_csum_set(fs, i);
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 4a9c1b092..72c9da12e 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -3522,7 +3522,7 @@ no_journal:
> 			       fs->super->s_mmp_update_interval);
> 	}
>=20
> -	overhead +=3D fs->super->s_first_data_block;
> +	overhead +=3D EXT2FS_NUM_B2C(fs, fs->super->s_first_data_block);
> 	if (!super_only)
> 		fs->super->s_overhead_clusters =3D overhead;
>=20
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_0FDEC728-94F9-4B23-874D-32B3F6AA4F73
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUTQ10ACgkQcqXauRfM
H+B2Pw/+NAj86Sbjtno2LoEf+iednn7oivmCjuh0KNSfLxsrxivNo2FDw+jLMlP2
3+XHppKs0XDsbHvjV0tdFc3jSNEOMp9VXSztpBTFHcWvA34F2a72oN1DVBW6wYAU
zN4t3wEZR/Hz1YskTecB79sjbMc/tetfiZsYSHWQt6+Kd1LRL0BAHO3WRQoBK9OM
WTzkvVzXcGss4bI5z+W5mS0h35vEKPGtp2KVM7ktp4eRAkgq9zLBKof+XG9pQT+3
SPHk6pYQGnemYbFvKtPhOlFVq/zwZ5AXfEcbVhL1ZYe0uPyLP3ZKG6GeSb6bYg9e
7U5GeuVgUgp1TI/smDrcNoxcgQdhv8pq7pIvjyjslyrXKwX5zn44iOfLd1gwstfP
Yk4i8Qq2fRgSOEhs0L6Sv+rJ8y0xBLTrk0GwVf3kDFTrxMWq1ueRT0RjokMMRs+/
2E+gzZvwfM3RXWGTdFG8KePtmw5xYoD+ifyKYwK/pCjoR+v2nBUX3tJNcRc6BoP9
DwHu0TxCLjOl9tnnnCsQUhzQEDJlL5nZAuSb/x6ODOMP3WErQAjLS4DtjcfqUC+8
GTK4jD2F/+Z1+Rh34HMGFrPQqLNCcD8kdgr5e9cZ3WQ2r0/WxdaznabsSax/Q0MZ
unujIapRUcer/BhdiDVnHtSuwy8sTeqcmW4EjsDdR85hcTAzkrU=
=BGbZ
-----END PGP SIGNATURE-----

--Apple-Mail=_0FDEC728-94F9-4B23-874D-32B3F6AA4F73--
