Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CEE7A5626
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 01:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjIRXTL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjIRXTK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 19:19:10 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF897
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:19:04 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-563f8e8a53dso3882190a12.3
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695079144; x=1695683944; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VGeiIqNpBDSzAoazEXx3Ha6eeJTiO9hAjOxFxArSoRA=;
        b=yNM59+b3R1yRRX9ggekRfDsockJd0FZFxILBUBiKwwMgOWtFpgZBdAgc1NiKJrdD6T
         yQTAwDO+FYthgJ82Po1s64TgiJPAc7HAk8oDYidB6Uog75V/suMQL4nRnCOXHjhZg/QS
         aqeVVzO92fKCU40/33eaq8PrQ0T8jCT+GVyjrIC9wA3VzMPoZ/8jeom/U14B1zwmelA8
         leA0JTdv61IBd1sYTzjWieEeTTiPQWJsvssCOWoU1lbkgc17dzWDcdeiWiAzzLzfAmeg
         K2IsnvH2dmFMdtSFXl4w21jSvp64u/6YKie4mbd/aKtyDhPN4nqZa8gUXro7YKtJXNmU
         cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695079144; x=1695683944;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VGeiIqNpBDSzAoazEXx3Ha6eeJTiO9hAjOxFxArSoRA=;
        b=bbqvPiOd8vqAhFRZT8IJX+iSFiQydAAoFcf6tJxWFlyNNQyAqBpPvKnzdjEwgMmLvw
         OjqF4jbMZ2YtgolOWVFDg0enuVBkOMGSa8ZxtftKseMO2vh4nuv3QDh9FI+EZFIRf+eT
         snoBmV6e7ruLDWEjHA5HjrFSTqf9iT6jaV49bTM+YUYdOP2LKNY8JQsfzBvfBCeiDexp
         H5dzeEx/hMZuozw/wgLBC/CTazry21e2bKRH5XfwVSt6toN96sBZwZtOeo4G0xE3kR9E
         d9UzoEdUUSx39NRexQnqcGt4ikk6VqlK2X3tQY85Hzp/3CCNq7wfkazxkRpBjwaSRD9F
         7yUg==
X-Gm-Message-State: AOJu0Yz/25gwnBx/x9akLy89rCnIvmDsOM4QmMlIoXF+/7j9LSjBEei5
        P3vnX5jxB/Rqkhmcp2td97FouA==
X-Google-Smtp-Source: AGHT+IG9fsab5OqvktXABl3RMlTK80b+v8rvcnrOyPCJs8GZNrN+oTKJnk6Hi1Tw3ADNmRt16mP3SQ==
X-Received: by 2002:a05:6a20:5648:b0:154:b4cb:2e8c with SMTP id is8-20020a056a20564800b00154b4cb2e8cmr8890488pzc.24.1695079143878;
        Mon, 18 Sep 2023 16:19:03 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b7-20020a170902b60700b001b9f032bb3dsm8797794pls.3.2023.09.18.16.19.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 16:19:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8C4A25B6-B59F-4C59-9999-167A8B9604F6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_736F693F-E3C3-4E3E-BF9F-55FE1DDE9F24";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/5] move a journal checksum code into common place
Date:   Mon, 18 Sep 2023 17:19:01 -0600
In-Reply-To: <20220804095618.887684-2-alexey.lyashkov@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
 <20220804095618.887684-2-alexey.lyashkov@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_736F693F-E3C3-4E3E-BF9F-55FE1DDE9F24
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 4, 2022, at 3:56 AM, Alexey Lyashkov <alexey.lyashkov@gmail.com> =
wrote:
>=20
> e2fsck and debugfs have own copy a journal checksum functions,
> kill duplicates and move into support library.

Missing a Signed-off-by: line.

It would be better to name the new file "jbd2_user.c" if patch is =
refreshed,
or Ted can rename and amend the commit locally.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> debugfs/journal.c       | 50 ---------------------------------
> e2fsck/journal.c        | 60 ++++-----------------------------------
> lib/support/Android.bp  |  1 +
> lib/support/Makefile.in |  7 +++--
> lib/support/jfs_user.c  | 62 +++++++++++++++++++++++++++++++++++++++++
> lib/support/jfs_user.h  |  6 ++++
> 6 files changed, 79 insertions(+), 107 deletions(-)
> create mode 100644 lib/support/jfs_user.c
>=20
> diff --git a/debugfs/journal.c b/debugfs/journal.c
> index 095fff00..dac17800 100644
> --- a/debugfs/journal.c
> +++ b/debugfs/journal.c
> @@ -43,56 +43,6 @@ static int bh_count =3D 0;
>  */
> #undef USE_INODE_IO
>=20
> -/* Checksumming functions */
> -static int ext2fs_journal_verify_csum_type(journal_t *j,
> -					   journal_superblock_t *jsb)
> -{
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 1;
> -
> -	return jsb->s_checksum_type =3D=3D JBD2_CRC32C_CHKSUM;
> -}
> -
> -static __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
> -{
> -	__u32 crc, old_crc;
> -
> -	old_crc =3D jsb->s_checksum;
> -	jsb->s_checksum =3D 0;
> -	crc =3D ext2fs_crc32c_le(~0, (unsigned char *)jsb,
> -			       sizeof(journal_superblock_t));
> -	jsb->s_checksum =3D old_crc;
> -
> -	return crc;
> -}
> -
> -static int ext2fs_journal_sb_csum_verify(journal_t *j,
> -					 journal_superblock_t *jsb)
> -{
> -	__u32 provided, calculated;
> -
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 1;
> -
> -	provided =3D ext2fs_be32_to_cpu(jsb->s_checksum);
> -	calculated =3D ext2fs_journal_sb_csum(jsb);
> -
> -	return provided =3D=3D calculated;
> -}
> -
> -static errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
> -					    journal_superblock_t *jsb)
> -{
> -	__u32 crc;
> -
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 0;
> -
> -	crc =3D ext2fs_journal_sb_csum(jsb);
> -	jsb->s_checksum =3D ext2fs_cpu_to_be32(crc);
> -	return 0;
> -}
> -
> /* Kernel compatibility functions for handling the journal.  These =
allow us
>  * to use the recovery.c file virtually unchanged from the kernel, so =
we
>  * don't have to do much to keep kernel and user recovery in sync.
> diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> index d3002a62..46a9bcb7 100644
> --- a/e2fsck/journal.c
> +++ b/e2fsck/journal.c
> @@ -38,56 +38,6 @@ static int bh_count =3D 0;
>  */
> #undef USE_INODE_IO
>=20
> -/* Checksumming functions */
> -static int e2fsck_journal_verify_csum_type(journal_t *j,
> -					   journal_superblock_t *jsb)
> -{
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 1;
> -
> -	return jsb->s_checksum_type =3D=3D JBD2_CRC32C_CHKSUM;
> -}
> -
> -static __u32 e2fsck_journal_sb_csum(journal_superblock_t *jsb)
> -{
> -	__u32 crc, old_crc;
> -
> -	old_crc =3D jsb->s_checksum;
> -	jsb->s_checksum =3D 0;
> -	crc =3D ext2fs_crc32c_le(~0, (unsigned char *)jsb,
> -			       sizeof(journal_superblock_t));
> -	jsb->s_checksum =3D old_crc;
> -
> -	return crc;
> -}
> -
> -static int e2fsck_journal_sb_csum_verify(journal_t *j,
> -					 journal_superblock_t *jsb)
> -{
> -	__u32 provided, calculated;
> -
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 1;
> -
> -	provided =3D ext2fs_be32_to_cpu(jsb->s_checksum);
> -	calculated =3D e2fsck_journal_sb_csum(jsb);
> -
> -	return provided =3D=3D calculated;
> -}
> -
> -static errcode_t e2fsck_journal_sb_csum_set(journal_t *j,
> -					    journal_superblock_t *jsb)
> -{
> -	__u32 crc;
> -
> -	if (!jbd2_journal_has_csum_v2or3(j))
> -		return 0;
> -
> -	crc =3D e2fsck_journal_sb_csum(jsb);
> -	jsb->s_checksum =3D ext2fs_cpu_to_be32(crc);
> -	return 0;
> -}
> -
> /* Kernel compatibility functions for handling the journal.  These =
allow us
>  * to use the recovery.c file virtually unchanged from the kernel, so =
we
>  * don't have to do much to keep kernel and user recovery in sync.
> @@ -1330,8 +1280,8 @@ static errcode_t e2fsck_journal_load(journal_t =
*journal)
> 	    jbd2_has_feature_checksum(journal))
> 		return EXT2_ET_CORRUPT_JOURNAL_SB;
>=20
> -	if (!e2fsck_journal_verify_csum_type(journal, jsb) ||
> -	    !e2fsck_journal_sb_csum_verify(journal, jsb))
> +	if (!ext2fs_journal_verify_csum_type(journal, jsb) ||
> +	    !ext2fs_journal_sb_csum_verify(journal, jsb))
> 		return EXT2_ET_CORRUPT_JOURNAL_SB;
>=20
> 	if (jbd2_journal_has_csum_v2or3(journal))
> @@ -1419,7 +1369,7 @@ static void e2fsck_journal_reset_super(e2fsck_t =
ctx, journal_superblock_t *jsb,
> 	for (i =3D 0; i < 4; i ++)
> 		new_seq ^=3D u.val[i];
> 	jsb->s_sequence =3D htonl(new_seq);
> -	e2fsck_journal_sb_csum_set(journal, jsb);
> +	ext2fs_journal_sb_csum_set(journal, jsb);
>=20
> 	mark_buffer_dirty(journal->j_sb_buffer);
> 	ll_rw_block(REQ_OP_WRITE, 0, 1, &journal->j_sb_buffer);
> @@ -1459,7 +1409,7 @@ static void e2fsck_journal_release(e2fsck_t ctx, =
journal_t *journal,
> 		jsb->s_sequence =3D htonl(journal->j_tail_sequence);
> 		if (reset)
> 			jsb->s_start =3D 0; /* this marks the journal as =
empty */
> -		e2fsck_journal_sb_csum_set(journal, jsb);
> +		ext2fs_journal_sb_csum_set(journal, jsb);
> 		mark_buffer_dirty(journal->j_sb_buffer);
> 	}
> 	brelse(journal->j_sb_buffer);
> @@ -1602,7 +1552,7 @@ no_has_journal:
> 		ctx->fs->super->s_state |=3D EXT2_ERROR_FS;
> 		ext2fs_mark_super_dirty(ctx->fs);
> 		journal->j_superblock->s_errno =3D 0;
> -		e2fsck_journal_sb_csum_set(journal, =
journal->j_superblock);
> +		ext2fs_journal_sb_csum_set(journal, =
journal->j_superblock);
> 		mark_buffer_dirty(journal->j_sb_buffer);
> 	}
>=20
> diff --git a/lib/support/Android.bp b/lib/support/Android.bp
> index a0b064dd..efa0f955 100644
> --- a/lib/support/Android.bp
> +++ b/lib/support/Android.bp
> @@ -29,6 +29,7 @@ cc_library {
>         "quotaio.c",
>         "quotaio_tree.c",
>         "quotaio_v2.c",
> +        "jfs_user.c"
>     ],
>     shared_libs: [
>         "libext2fs",
> diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
> index f3c7981e..04fbcf31 100644
> --- a/lib/support/Makefile.in
> +++ b/lib/support/Makefile.in
> @@ -23,7 +23,8 @@ OBJS=3D		cstring.o \
> 		quotaio.o \
> 		quotaio_v2.o \
> 		quotaio_tree.o \
> -		dict.o
> +		dict.o \
> +		jfs_user.o
>=20
> SRCS=3D		$(srcdir)/argv_parse.c \
> 		$(srcdir)/cstring.c \
> @@ -36,7 +37,9 @@ SRCS=3D		$(srcdir)/argv_parse.c \
> 		$(srcdir)/quotaio.c \
> 		$(srcdir)/quotaio_tree.c \
> 		$(srcdir)/quotaio_v2.c \
> -		$(srcdir)/dict.c
> +		$(srcdir)/dict.c \
> +		$(srcdir)/jfs_user.c
> +
>=20
> LIBRARY=3D libsupport
> LIBDIR=3D support
> diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
> new file mode 100644
> index 00000000..4ff1b5c1
> --- /dev/null
> +++ b/lib/support/jfs_user.c
> @@ -0,0 +1,62 @@
> +#define DEBUGFS
> +#include "jfs_user.h"
> +
> +/*
> + * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
> + * This creates a larger static binary, and a smaller binary using
> + * shared libraries.  It's also probably slightly less CPU-efficient,
> + * which is why it's not on by default.  But, it's a good way of
> + * testing the functions in inode_io.c and fileio.c.
> + */
> +#undef USE_INODE_IO
> +
> +/* Checksumming functions */
> +int ext2fs_journal_verify_csum_type(journal_t *j,
> +				    journal_superblock_t *jsb)
> +{
> +	if (!jbd2_journal_has_csum_v2or3(j))
> +		return 1;
> +
> +	return jsb->s_checksum_type =3D=3D JBD2_CRC32C_CHKSUM;
> +}
> +
> +__u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
> +{
> +	__u32 crc, old_crc;
> +
> +	old_crc =3D jsb->s_checksum;
> +	jsb->s_checksum =3D 0;
> +	crc =3D ext2fs_crc32c_le(~0, (unsigned char *)jsb,
> +			       sizeof(journal_superblock_t));
> +	jsb->s_checksum =3D old_crc;
> +
> +	return crc;
> +}
> +
> +int ext2fs_journal_sb_csum_verify(journal_t *j,
> +				  journal_superblock_t *jsb)
> +{
> +	__u32 provided, calculated;
> +
> +	if (!jbd2_journal_has_csum_v2or3(j))
> +		return 1;
> +
> +	provided =3D ext2fs_be32_to_cpu(jsb->s_checksum);
> +	calculated =3D ext2fs_journal_sb_csum(jsb);
> +
> +	return provided =3D=3D calculated;
> +}
> +
> +errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
> +				     journal_superblock_t *jsb)
> +{
> +	__u32 crc;
> +
> +	if (!jbd2_journal_has_csum_v2or3(j))
> +		return 0;
> +
> +	crc =3D ext2fs_journal_sb_csum(jsb);
> +	jsb->s_checksum =3D ext2fs_cpu_to_be32(crc);
> +	return 0;
> +}
> +
> diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
> index 4ad2005a..8bdbf85b 100644
> --- a/lib/support/jfs_user.h
> +++ b/lib/support/jfs_user.h
> @@ -212,6 +212,12 @@ _INLINE_ void =
jbd2_descriptor_block_csum_set(journal_t *j,
> #undef _INLINE_
> #endif
>=20
> +/* Checksumming functions */
> +int ext2fs_journal_verify_csum_type(journal_t *j, =
journal_superblock_t *jsb);
> +__u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb);
> +int ext2fs_journal_sb_csum_verify(journal_t *j, journal_superblock_t =
*jsb);
> +errcode_t ext2fs_journal_sb_csum_set(journal_t *j, =
journal_superblock_t *jsb);
> +
> /*
>  * Kernel compatibility functions are defined in journal.c
>  */
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_736F693F-E3C3-4E3E-BF9F-55FE1DDE9F24
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUI2uUACgkQcqXauRfM
H+AbSBAAju8AeMkT8OUO5Bt4OFWfvRfRPDCWFgxcBKjmdPqcWxXAiz9MXZJxwTCv
7KXoNYlq+ckPXVNhaQx2crLkwkSplvnKgOwg8v9uYx+sRPjepI13K6Sz+fo73Yxs
CeDduZCQNF0ZXOQCR+kRJ72MxJvTtUKp+e1ovoztO1ZMtqMjSPjGj17moibQKYp5
IRHc6wIeh9LnvhAKJ0AUOh8mNNGBmaKiILO4P8XuKNZu2qg6mAFJwKsZOW1t8viC
mo6c2Pp1XlUDLzNP0R2o+YbKFDPXzkEOPgPmP+3FF+LnWOab0l2ZfDWBfBEm3H/B
rQmMTEaTpqG4bxC3bu8Cpgs1RpS10gEISFdKL85DwGe4C7hfLf932J68Qg/xNVDp
SQD01LeR6mxC6zjasNGG84KERaijOQxsCFRow0RtkltDrX2nYX6bii/qeBjzk3v8
vDDmBCvoOjh/Brt1UWM+hYAl4/Vf7vb7qQ3dET0SJYbQMoonDNlO2ujXZ7RLZIpS
v/w2G8r+oyygHV5ELCQnAuLs8EgVBsO3tBzFuNQy5ih41huTXUCjRBJVuXhiuqSC
CvE4DbRUbsNV5a6dzmMj005dH0n+vT+ONcuEQOKAwyy/TpTPgMmlkO+hpWXGBcZG
ASK3M1aBrPlGSaUDnYPnFaRKQp0U11hCBThQnMejjv5jEEkQNOk=
=Gw9k
-----END PGP SIGNATURE-----

--Apple-Mail=_736F693F-E3C3-4E3E-BF9F-55FE1DDE9F24--
