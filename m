Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5088577C6EA
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 07:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjHOFJE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 01:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbjHOFIr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 01:08:47 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60181710
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 22:08:45 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbf8cb694aso43160485ad.3
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692076125; x=1692680925;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=r7tte+plJKJWbXJ3TqXh3XS9J2gsreuIQFsYJkhhVNs=;
        b=e6+KVUq2VYke+ErFWrfQoXR9ZIlJ7etPt29ZMUc7ajCjIOKnxf8BLR1QZm7sJMcrxu
         hbmFi0DfePX8SYlo4bUZf/W60ZxfjyMYiOu4wSv5zgmulatGbaLku8l7sKAqfrcVdpvE
         57F6u7Sw3pBsy5hQ/TrCsfGxxaPkbMpSJFoFmlX7XB9QRJjR7alxfQ9uKbsedzBMsQ8m
         lrpTY5KNecraGrAipsXljQRnyZyaX16kLDM53XcC53hyqWwNAtqzCZAm8rNeMXtq7uzs
         WZ4lkwqfsmvzKmawwz484X9IFWRRIiZ3RNNMOg0QAV63Ep8bfk5zXCD05t3FNDnyeOd9
         KHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692076125; x=1692680925;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7tte+plJKJWbXJ3TqXh3XS9J2gsreuIQFsYJkhhVNs=;
        b=jn9j4GYxtZEvwLVAJ1boupntEGthQgTjL2diMPcZUpsXKjy7zlTpiKGpiol1Uu0yQx
         Cr6OIyhbgy8B9Gi08jZW+g2Pp+ybt8FFQbgy0CyKF6J/lHsbzo+r8d/flMu2eZqonulL
         Nc64yA1GRWv4tw7QKeA+nJRGf4TeKkZesjftMU/4K9SJvV+5PoM/6sAlOxNSPS+cvs5B
         yMuOoW//VKPrKZBhWhzBD2C1qFI7/aY8C2tFkRFzEiuyjDcRZJeO1U4bO0X6rXWbrF7r
         PF+VC6GE+qy/ZlTNS0du20h7+IOML3dDUvU7Wim1lTdzqkoRvMRNpwF89Ug72zmHLTHN
         7XcQ==
X-Gm-Message-State: AOJu0YzJF2nm5xrCMYIkNWFPWkUqTgSpYHOVDO2K3mxULj68pFrCPNa4
        FYRK1Af0Z2njn5pG7DLS3hhnxA==
X-Google-Smtp-Source: AGHT+IFGg/2OENTsVNtdIizK1qv1uAwvDWGTtzAv89IzupzPnogcxJw8CL4heNtOiVNGybM4RXRhzg==
X-Received: by 2002:a17:902:c94e:b0:1b8:4baa:52ff with SMTP id i14-20020a170902c94e00b001b84baa52ffmr12695588pla.47.1692076125063;
        Mon, 14 Aug 2023 22:08:45 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d50100b001bc445e249asm10313106plg.124.2023.08.14.22.08.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:08:44 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F5157873-C7F5-43C6-BABE-2B495F976493@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E2F3F60A-BA2E-4774-ACBB-52F13529EDD4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/2] e2fsprogs: support EXT2_FLAG_BG_TRIMMED and
 EXT2_FLAGS_TRACK_TRIM
Date:   Mon, 14 Aug 2023 23:08:42 -0600
In-Reply-To: <20230811061905.301124-2-dongyangli@ddn.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Shuichi Ihara <sihara@ddn.com>, wangshilong1991@gmail.com
To:     Li Dongyang <dongyangli@ddn.com>
References: <20230811061905.301124-1-dongyangli@ddn.com>
 <20230811061905.301124-2-dongyangli@ddn.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E2F3F60A-BA2E-4774-ACBB-52F13529EDD4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 11, 2023, at 12:19 AM, Li Dongyang <dongyangli@ddn.com> wrote:
>=20
> This adds EXT2_FLAG_BG_TRIMMED, which is used on block group
> descriptors during mke2fs after discard is done.
> The EXT2_FLAG_BG_TRIMMED flag is cleared on the block group when
> we free blocks.
>=20
> Introduce EXT2_FLAGS_TRACK_TRIM, which is a new super block flag,
> to indicate whether we should honour the EXT2_FLAG_BG_TRIMMED
> set on each block group.
> EXT2_FLAGS_TRACK_TRIM itself can be turned on/off via tune2fs.
>=20
> Make dumpe2fs aware of the new flags.

Ted, I think this patch is uncontroversial, and could be landed as-is.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

>=20
> Cc: Shuichi Ihara <sihara@ddn.com>
> Cc: Andreas Dilger <adilger@dilger.ca>
> Cc: Wang Shilong <wangshilong1991@gmail.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> ---
> lib/e2p/ls.c             |  4 ++++
> lib/ext2fs/alloc_stats.c |  8 ++++++--
> lib/ext2fs/ext2_fs.h     |  2 ++
> misc/dumpe2fs.c          |  2 ++
> misc/mke2fs.c            |  9 +++++++++
> misc/tune2fs.8.in        |  8 ++++++++
> misc/tune2fs.c           | 10 ++++++++++
> 7 files changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/e2p/ls.c b/lib/e2p/ls.c
> index 0b74aea2b..4b356eca6 100644
> --- a/lib/e2p/ls.c
> +++ b/lib/e2p/ls.c
> @@ -162,6 +162,10 @@ static void print_super_flags(struct =
ext2_super_block * s, FILE *f)
> 		fputs("test_filesystem ", f);
> 		flags_found++;
> 	}
> +	if (s->s_flags & EXT2_FLAGS_TRACK_TRIM) {
> +		fputs("track_trim ", f);
> +		flags_found++;
> +	}
> 	if (flags_found)
> 		fputs("\n", f);
> 	else
> diff --git a/lib/ext2fs/alloc_stats.c b/lib/ext2fs/alloc_stats.c
> index 6f98bcc7c..4e03f92a4 100644
> --- a/lib/ext2fs/alloc_stats.c
> +++ b/lib/ext2fs/alloc_stats.c
> @@ -70,10 +70,12 @@ void ext2fs_block_alloc_stats2(ext2_filsys fs, =
blk64_t blk, int inuse)
> #endif
> 		return;
> 	}
> -	if (inuse > 0)
> +	if (inuse > 0) {
> 		ext2fs_mark_block_bitmap2(fs->block_map, blk);
> -	else
> +	} else {
> 		ext2fs_unmark_block_bitmap2(fs->block_map, blk);
> +		ext2fs_bg_flags_clear(fs, group, EXT2_BG_TRIMMED);
> +	}
> 	ext2fs_bg_free_blocks_count_set(fs, group, =
ext2fs_bg_free_blocks_count(fs, group) - inuse);
> 	ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
> 	ext2fs_group_desc_csum_set(fs, group);
> @@ -139,6 +141,8 @@ void ext2fs_block_alloc_stats_range(ext2_filsys =
fs, blk64_t blk,
> 			ext2fs_bg_free_blocks_count(fs, group) -
> 			inuse*n/EXT2FS_CLUSTER_RATIO(fs));
> 		ext2fs_bg_flags_clear(fs, group, EXT2_BG_BLOCK_UNINIT);
> +		if (inuse < 0)
> +			ext2fs_bg_flags_clear(fs, group, =
EXT2_BG_TRIMMED);
> 		ext2fs_group_desc_csum_set(fs, group);
> 		ext2fs_free_blocks_count_add(fs->super, -inuse * =
(blk64_t) n);
> 		blk +=3D n;
> diff --git a/lib/ext2fs/ext2_fs.h b/lib/ext2fs/ext2_fs.h
> index 0fc9c09a5..88e1114c9 100644
> --- a/lib/ext2fs/ext2_fs.h
> +++ b/lib/ext2fs/ext2_fs.h
> @@ -223,6 +223,7 @@ struct ext4_group_desc
> #define EXT2_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not =
initialized */
> #define EXT2_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not initialized =
*/
> #define EXT2_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to =
zero */
> +#define EXT2_BG_TRIMMED		0x0008 /* Block group was =
trimmed */
>=20
> /*
>  * Data structures used by the directory indexing feature
> @@ -563,6 +564,7 @@ struct ext2_inode *EXT2_INODE(struct =
ext2_inode_large *large_inode)
> #define EXT2_FLAGS_SIGNED_HASH		0x0001  /* Signed =
dirhash in use */
> #define EXT2_FLAGS_UNSIGNED_HASH	0x0002  /* Unsigned dirhash in =
use */
> #define EXT2_FLAGS_TEST_FILESYS		0x0004	/* OK for use on =
development code */
> +#define EXT2_FLAGS_TRACK_TRIM		0x0008	/* Track trim =
status in each bg */
> #define EXT2_FLAGS_IS_SNAPSHOT		0x0010	/* This is a =
snapshot image */
> #define EXT2_FLAGS_FIX_SNAPSHOT		0x0020	/* Snapshot =
inodes corrupted */
> #define EXT2_FLAGS_FIX_EXCLUDE		0x0040	/* Exclude =
bitmaps corrupted */
> diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
> index 7c080ed9f..afe569dff 100644
> --- a/misc/dumpe2fs.c
> +++ b/misc/dumpe2fs.c
> @@ -131,6 +131,8 @@ static void print_bg_opts(ext2_filsys fs, dgrp_t =
i)
>  		     &first);
> 	print_bg_opt(bg_flags, EXT2_BG_INODE_ZEROED, "ITABLE_ZEROED",
>  		     &first);
> +	print_bg_opt(bg_flags, EXT2_BG_TRIMMED, "TRIMMED",
> +		     &first);
> 	if (!first)
> 		fputc(']', stdout);
> 	fputc('\n', stdout);
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 4a9c1b092..bbfcde478 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -3154,6 +3154,15 @@ int main (int argc, char *argv[])
> 	/* Can't undo discard ... */
> 	if (!noaction && discard && dev_size && (io_ptr !=3D =
undo_io_manager)) {
> 		retval =3D mke2fs_discard_device(fs);
> +		if (!retval) {
> +			dgrp_t i;
> +
> +			fs->super->s_flags |=3D EXT2_FLAGS_TRACK_TRIM;
> +			for (i =3D 0; i < fs->group_desc_count; i++) {
> +				ext2fs_bg_flags_set(fs, i, =
EXT2_BG_TRIMMED);
> +				ext2fs_group_desc_csum_set(fs, i);
> +			}
> +		}
> 		if (!retval && io_channel_discard_zeroes_data(fs->io)) {
> 			if (verbose)
> 				printf("%s",
> diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
> index dcf108c1f..2eb7e88ed 100644
> --- a/misc/tune2fs.8.in
> +++ b/misc/tune2fs.8.in
> @@ -273,6 +273,14 @@ mounted using experimental kernel code, such as =
the ext4dev file system.
> .B ^test_fs
> Clear the test_fs flag, indicating the file system should only be =
mounted
> using production-level file system code.
> +.TP
> +.B track_trim
> +Set a flag in the file system superblock to make fstrim save the trim =
status
> +in each block group and skip the block groups already been trimmed.
> +.TP
> +.B ^track_trim
> +Clear the track_trim flag to make fstrim ignore the trim status saved =
in
> +each block group, and trim every block group.
> .RE
> .TP
> .B \-f
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index 458f7cf6a..dd9e8eab0 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -2312,6 +2312,14 @@ static int parse_extended_opts(ext2_filsys fs, =
const char *opts)
> 			sb->s_flags &=3D ~EXT2_FLAGS_TEST_FILESYS;
> 			printf("Clearing test filesystem flag\n");
> 			ext2fs_mark_super_dirty(fs);
> +		} else if (!strcmp(token, "track_trim")) {
> +			sb->s_flags |=3D EXT2_FLAGS_TRACK_TRIM;
> +			printf("Setting track_trim flag\n");
> +			ext2fs_mark_super_dirty(fs);
> +		} else if (!strcmp(token, "^track_trim")) {
> +			sb->s_flags &=3D ~EXT2_FLAGS_TRACK_TRIM;
> +			printf("Clearing track_trim flag\n");
> +			ext2fs_mark_super_dirty(fs);
> 		} else if (strcmp(token, "stride") =3D=3D 0) {
> 			if (!arg) {
> 				r_usage++;
> @@ -2458,6 +2466,8 @@ static int parse_extended_opts(ext2_filsys fs, =
const char *opts)
> 			"\tforce_fsck\n"
> 			"\ttest_fs\n"
> 			"\t^test_fs\n"
> +			"\ttrack_trim\n"
> +			"\t^track_trim\n"
> 			"\tencoding=3D<encoding>\n"
> 			"\tencoding_flags=3D<flags>\n"));
> 		free(buf);
> --
> 2.41.0
>=20


Cheers, Andreas






--Apple-Mail=_E2F3F60A-BA2E-4774-ACBB-52F13529EDD4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTbCFoACgkQcqXauRfM
H+Dg2xAAiwt+n4hBU/nFtq+Jo3aH27nom41BSDjyMD4BKYDv29d/5kbnPdBlQc4I
4PIbj94EJ0YauHr4EAg7zNl0eVsMDgsONTCxYucd/sNOPjoTa9WxaqnCz0FR9T0m
khOkKtpNZl4jZ1QCG7kbVCewNCJbe18F7FE/VbEUs3Q2B8GFJn23akIt/ZrqWHk4
ATyVJt6G+ayFI3OLdN+5FJ6ssoSe/F/C2bGPYivbHw130hJFRgZ2nZ074Ue1u3Oh
mfMac6vaiMuMBKZZUNtG1UAvbskSZ+Iu2GtOW+FsOFB3YyPwkAn+xKGOohqE4aQx
44gJPb2t4u5+is4RWPEmX1bpCgQfA54itr5qdifmrPubD6i124HnihNcji5UGuvP
i6zFM7ttVGf1A9xFLKPdQsJVtX03n+O3cLopnR2NH/sGOtSijWnsUbf7ZZHndupu
9CMWKM0+CneEhmE3lruGnXAVMepYV2Dsyq+7znDcRkPN4pnsgesCg3NrtGH8L3Nf
Gt2yKrDLqxjB6uhpADy5TePrfl742Neul9F0MrlLeB9NU+3WZZsq+aSN6FerWkLb
tW41c1MRFeyudnRD4bY5RtlDrBlW6FOri6JhCGqcghrmbDbyvge6PeqOYNFlLheF
Ljjee5k0YCQMsMbpo4E0GnetHi/pgl5b0Tfp7thTcWMB4SATjdM=
=fDgz
-----END PGP SIGNATURE-----

--Apple-Mail=_E2F3F60A-BA2E-4774-ACBB-52F13529EDD4--
