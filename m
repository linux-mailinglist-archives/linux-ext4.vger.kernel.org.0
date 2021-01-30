Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D388309336
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 10:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhA3JVq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 04:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhA3JVS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 04:21:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68055C061354
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 00:36:04 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id q2so6798292plk.4
        for <linux-ext4@vger.kernel.org>; Sat, 30 Jan 2021 00:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=RNlJNYNgnElZHRtL8Zwmtssc99rGYNQj+91NvVRXL3k=;
        b=WicKk5a2EvlEDaROQRYSVXWJDUCuwiseNdMU5Q/ZjvU6lRJJhyGgxe/hBEFeTUknDI
         UH/6O+ah/UOpPVTudg7Xutj9WMR8Rfq9O20qqQrwSSu17YgMPgn2VNnkyRzf33J+H5fJ
         HFNE7teu7WlT7+CnNlPzHniXYBcpyjmMVw07kjcJMK4odTzpLbHLdpC7xoni/9hPPHzP
         hbrcyD9aKutuQRCAM21ViHXYPImagpV8uGj5RghZMntSZILv+94ihRY1HXB0IdYg9LuD
         Tcnr+ydLNnLSHRWz2qP+h+UMzberFCFJNRnS7OclR+7WCYUCELNVel4dIjSx5MUJXqEl
         ffKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=RNlJNYNgnElZHRtL8Zwmtssc99rGYNQj+91NvVRXL3k=;
        b=mwOf6B9r7dicWA0cqD8N8EpQHOOnDD1y+uYqQfuXadlLpwQtl1ArtANgHl65C9/wAP
         swJKElZ6ZH3VrFwoQC/psNXHVD6pmjZCmaPzzyKvoKJBr4831H5Ikxr8OvCuy/jxMVlg
         WPR/ZRoMqibe/qQNcpeES8Tp3CTSAvoB2d8TF+pZNQsf5nA5MVLH6E7X5g37/o+Pi/I9
         VsZruk/txglsQP98K/mAw28l7Wekaww6WaH4Oiu+aWaPMc+2tBPsQUfSLkf5FCy0clpO
         tfMyLmrpCatZB3Jqhy/bRJpogKJ4yynJZSlfqIx/aovXl9o2brJexKMuhwuOg4sVwLRU
         dc/Q==
X-Gm-Message-State: AOAM533zbVutX3NzVeYdCbvxBQJceo51/Md+cgxgymWVQCWMnjXFRtey
        QlcchilwIJ99fNdgphDw9INx8RQTKeiRYJzA
X-Google-Smtp-Source: ABdhPJxzHltOBMU5z4wF3bhPpY7yykqpHqScmMpu+waZHxXM2apnHTALdEBwWv88/fVVhiGLlLGfUQ==
X-Received: by 2002:a17:902:201:b029:e1:20bc:74ca with SMTP id 1-20020a1709020201b02900e120bc74camr2738119plc.31.1611995763917;
        Sat, 30 Jan 2021 00:36:03 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id l1sm4549938pgt.26.2021.01.30.00.36.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jan 2021 00:36:03 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <4355ABE0-1F4E-41C3-8927-D99C63EBFEB1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_59D80FA6-B31D-45A1-A1AF-1FFC6E7FB907";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/4] ext4: add MB_NUM_ORDERS macro
Date:   Sat, 30 Jan 2021 01:36:02 -0700
In-Reply-To: <20210129222931.623008-2-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?utf-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210129222931.623008-1-harshadshirwadkar@gmail.com>
 <20210129222931.623008-2-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_59D80FA6-B31D-45A1-A1AF-1FFC6E7FB907
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 3:29 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
> A few arrays in mballoc.c use the total number of valid orders as
> their size. Currently, this value is set as "sb->s_blocksize_bits +
> 2". This makes code harder to read. So, instead add a new macro
> MB_NUM_ORDERS(sb) to make the code more readable.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

There were a few cases that _looked_ incorrect, because =
MB_NUM_ORDERS(sb)
was replacing "sb->s_blocksize_bits + 1", but they also changed "<=3D" =
to "<"
so they appear to be correct...

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 15 ++++++++-------
> fs/ext4/mballoc.h |  5 +++++
> 2 files changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091fee10..625242e5c683 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -756,7 +756,7 @@ mb_set_largest_free_order(struct super_block *sb, =
struct ext4_group_info *grp)
>=20
> 	grp->bb_largest_free_order =3D -1; /* uninit */
>=20
> -	bits =3D sb->s_blocksize_bits + 1;
> +	bits =3D MB_NUM_ORDERS(sb) - 1;
> 	for (i =3D bits; i >=3D 0; i--) {
> 		if (grp->bb_counters[i] > 0) {
> 			grp->bb_largest_free_order =3D i;
> @@ -1930,7 +1930,7 @@ void ext4_mb_simple_scan_group(struct =
ext4_allocation_context *ac,
> 	int max;
>=20
> 	BUG_ON(ac->ac_2order <=3D 0);
> -	for (i =3D ac->ac_2order; i <=3D sb->s_blocksize_bits + 1; i++) =
{
> +	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(sb); i++) {
> 		if (grp->bb_counters[i] =3D=3D 0)
> 			continue;
>=20
> @@ -2315,13 +2315,13 @@ ext4_mb_regular_allocator(struct =
ext4_allocation_context *ac)
> 	 * We also support searching for power-of-two requests only for
> 	 * requests upto maximum buddy size we have constructed.
> 	 */
> -	if (i >=3D sbi->s_mb_order2_reqs && i <=3D sb->s_blocksize_bits =
+ 2) {
> +	if (i >=3D sbi->s_mb_order2_reqs && i <=3D MB_NUM_ORDERS(sb)) {
> 		/*
> 		 * This should tell if fe_len is exactly power of 2
> 		 */
> 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) =3D=3D 0)
> 			ac->ac_2order =3D array_index_nospec(i - 1,
> -							   =
sb->s_blocksize_bits + 2);
> +							   =
MB_NUM_ORDERS(sb));
> 	}
>=20
> 	/* if stream allocation is enabled, use global goal */
> @@ -2806,7 +2806,7 @@ int ext4_mb_init(struct super_block *sb)
> 	unsigned max;
> 	int ret;
>=20
> -	i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_offsets);
> +	i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_offsets);
>=20
> 	sbi->s_mb_offsets =3D kmalloc(i, GFP_KERNEL);
> 	if (sbi->s_mb_offsets =3D=3D NULL) {
> @@ -2814,7 +2814,7 @@ int ext4_mb_init(struct super_block *sb)
> 		goto out;
> 	}
>=20
> -	i =3D (sb->s_blocksize_bits + 2) * sizeof(*sbi->s_mb_maxs);
> +	i =3D MB_NUM_ORDERS(sb) * sizeof(*sbi->s_mb_maxs);
> 	sbi->s_mb_maxs =3D kmalloc(i, GFP_KERNEL);
> 	if (sbi->s_mb_maxs =3D=3D NULL) {
> 		ret =3D -ENOMEM;
> @@ -2840,7 +2840,8 @@ int ext4_mb_init(struct super_block *sb)
> 		offset_incr =3D offset_incr >> 1;
> 		max =3D max >> 1;
> 		i++;
> -	} while (i <=3D sb->s_blocksize_bits + 1);
> +	} while (i < MB_NUM_ORDERS(sb));
> +
>=20
> 	spin_lock_init(&sbi->s_md_lock);
> 	spin_lock_init(&sbi->s_bal_lock);
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index e75b4749aa1c..68111a10cfee 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -78,6 +78,11 @@
>  */
> #define MB_DEFAULT_MAX_INODE_PREALLOC	512
>=20
> +/*
> + * Number of valid buddy orders
> + */
> +#define MB_NUM_ORDERS(sb)		((sb)->s_blocksize_bits + 2)
> +
> struct ext4_free_data {
> 	/* this links the free block information from sb_info */
> 	struct list_head		efd_list;
> --
> 2.30.0.365.g02bc693789-goog
>=20


Cheers, Andreas






--Apple-Mail=_59D80FA6-B31D-45A1-A1AF-1FFC6E7FB907
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAVGnIACgkQcqXauRfM
H+AK0w/+O7XmUGcHv858sPQ0USqeAotcwQYJTy4CYTfu+dMpN5iagstRHplTGZHN
Zc1gItBG0Mx7zzYy7ENWbSNAgoyoB4dEVc7RY5fcl2ZSlPaUUtAp49ggKR5uynNP
XXi5ervcjM1uxwjoxJ4WryHbxHjAExSr84NH31KnBMolE2mZWSiLlpsBYPXVwXmh
ONySLKiiyvZwuCPvQ2EkOCSn0iNFsNb06QDOfdU2LBQ2T1WjoIetlnSapeM1Uxcr
zRQtX6FNdwNFXD074OiP+91Ylbto8PoA1xmrbXYK95WGGkAewddA59lb0baKYgcI
0CdfSmJeoX4pb6vtEalQyKmW+CR7A1c9wNgG0uwkwxRRWII1+eOM953aFs9xafC9
Tse36isrZ+kcjyja459ngLWIx4Uzz/rZeVJg6BlzJVzBiDd9uBj6bZ6wKmuLcUmt
bAduZOAab3NF7aRTtzAtBs13gvxiSw3341J+qP06Udf4TdNtqmZiyiVIlsnCI+nz
eShxZJCqwgMr+BSNNfiFCSNmZHdCntibMl7r+lvNrpQAdKshf47fqic0umd5IRNv
1tXe51umTTp7vMsG+49d/2p6reAGaACL/t5jvFc+0ZedY/Gxx9dUVT36VwTdswjl
T18+YqWGzqnOh0AtyHZjXo1jbmvosqdyIrCu8v/aEkDxB8uGYko=
=FzbL
-----END PGP SIGNATURE-----

--Apple-Mail=_59D80FA6-B31D-45A1-A1AF-1FFC6E7FB907--
