Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A5764D1AA
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 22:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiLNVVN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 16:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLNVVM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 16:21:12 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47122B1A3
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:21:10 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so579905pjj.4
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 13:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lp/aZLMOwvZZeD1dXcE9AnoO9OwVUKdE8l7U7N8qKBA=;
        b=QvYBwPSprOtzJs1gzwTrSTg4YR9owgVD7ruhrnMqdUhiho7GsIWoTCWEll3Zr4sYuk
         bB3h+WjS1cnwdnqCWP/WojxGQhJrdpq0pHCI9zaLn4pba5kBmhrO4EswvYTeC0+jUfZL
         koBlAHmdVlkahoAmLwAiv+lS9feHGYQFj46xmuOAKA2uHZJ/XLb3nALivZ2z4J8iWO47
         /GR/ee89SOf4FYKh+lgs+1lp8Ie7poD3aDuWJkmXskor2ncb/fvVpwGqpeXtJYkmVvYs
         nS8VVBb+flqybgZsqJeE4KE2iKl2lG/CWh6Z8k6QB0SdQcOIqasIm7d+9+IuGtpk4AcF
         nRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lp/aZLMOwvZZeD1dXcE9AnoO9OwVUKdE8l7U7N8qKBA=;
        b=8I/mZ4ZRUOQLSvefKQxdhVjxIo8xSme1f9QV4VFWApwLNMpdje6nDNuHVi9+Lbca20
         JmPvxLHJVY76zcOwxeFknrwh1naZMTRcmDHnjH61G3DFoSy6W4Ep82Xa6TNGMbzvAdJ+
         5NyesLoTogG0XIx6tykw47cn9gefAn0VD9u1+7hx0HElcFvvU3klgHLnmTBy5JlAiTtM
         uUN+eWdZ5t1CBZsIXveryngvDtzGek6BJ0d1s6wAZVBTDqrVkcKpGqjaaqiRhAQJOCUF
         AU+zeGxz0XmdDmtpQc1GN5L02l++b7q5p6Pi0GCuSBl+O54R1bFFCRMHQBKBKySG2cdn
         ykGw==
X-Gm-Message-State: ANoB5pn483R0KEIHcmdp/YmT/NvZg6OJKR+DzI7EaZMCvrt6JdGKRxyj
        7mh+aEIIHE4SV6ijwvWxwCUoFwGxuZXejY1O
X-Google-Smtp-Source: AA0mqf5lmdqKkfZZ1IAcM+8FHNppY8haGmw+g4jya0bYaj1frGNrTKvLVJjDftZTvjPFa8FbMKMRaA==
X-Received: by 2002:a05:6a21:8cc2:b0:9d:efbe:52bf with SMTP id ta2-20020a056a218cc200b0009defbe52bfmr31312826pzb.47.1671052870094;
        Wed, 14 Dec 2022 13:21:10 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i3-20020a626d03000000b00575d6dc996bsm276186pfc.161.2022.12.14.13.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 13:21:09 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1FD80A82-21EF-4BB6-9508-59569112C4D3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_438EC964-B5C2-4009-9E99-340029DCE6EA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 17/72] libext2fs: Add support for
 ext2fs_test_block_bitmap_range2_valid()
Date:   Wed, 14 Dec 2022 14:21:07 -0700
In-Reply-To: <9015303c19c1b3474d880409db60627b0a9de37f.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>, Li Xi <lixi@ddn.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <9015303c19c1b3474d880409db60627b0a9de37f.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_438EC964-B5C2-4009-9E99-340029DCE6EA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:21 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> From: Wang Shilong <wshilong@ddn.com>
>=20
> This adds the support in libext2fs to query whether the block range is
> valid or not (within range) given the block bitmap.
> Also to avoid duplicate warning messages in case of invalid blocks.
>=20
> This will be later used in pass1 of e2fsck is_blocks_used() function =
to
> check whether the given block range is valid or not to avoid duplicate
> warning resulting from ext2fs_test_block_bitmap_range2()
>=20
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I don't think this patch is correct?

> ---
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index c31f942f..a9637cb5 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -731,6 +731,39 @@ int =
ext2fs_test_block_bitmap_range2(ext2fs_block_bitmap gen_bmap,
> 	return bmap->bitmap_ops->test_clear_bmap_extent(bmap, block, =
num);
> }
>=20
> +int ext2fs_test_block_bitmap_range2_valid(ext2fs_block_bitmap bitmap,
> +					  blk64_t block, unsigned int =
num)
> +{
> +	ext2fs_generic_bitmap_64 bmap =3D =
(ext2fs_generic_bitmap_64)bitmap;
> +	__u64	end =3D block + num;
> +
> +	if (!bmap)
> +		return 0;
> +
> +	if (EXT2FS_IS_32_BITMAP(bmap)) {
> +		if ((block & ~0xffffffffULL) ||
> +		    ((block+num-1) & ~0xffffffffULL)) {
> +			return 0;
> +		}
> +	}

This is bailing out early if the requested bit is > 2^32, but that is
before cluster conversion below.  However, I think the bitmap is =
actually
stored in clusters, so the 2^32 check seems premature?

> +
> +	if (!EXT2FS_IS_64_BITMAP(bmap))
> +		return 0;
> +
> +	/* convert to clusters if necessary */
> +	block >>=3D bmap->cluster_bits;
> +	end +=3D (1 << bmap->cluster_bits) - 1;
> +	end >>=3D bmap->cluster_bits;
> +	num =3D end - block;
> +
> +	if ((block < bmap->start) || (block > bmap->end) ||
> +	    (block+num-1 > bmap->end))
> +		return 0;
> +
> +	return 1;
> +}

Cheers, Andreas






--Apple-Mail=_438EC964-B5C2-4009-9E99-340029DCE6EA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmOaPkMACgkQcqXauRfM
H+BRohAAg4K7YBGtS7w59A5IfMvpRo/ERtx12FfwftAHyawoVt+U37djDcE2reJ8
C4AjSb9y5aMajP4SXompkt5pMw5CU/cuqsNjqSy6Zvbt3TVDM7odFsxPye04q8O1
w64uKF0Z6q9clrxyx6BWVPglfNlGxYb/SKQu8rjZJc/hFStpaNwhfXsR1ZWVQsRR
HAkL/Yw1eD6nX6RWD6rl9xycgUkMKfbVhUFayd8ISM55U0ii14B1aDSmSK1G9bi1
M780o5uNtsiuBqTQBjztoNEkcrCfC/T7kyQ30/SiuXiMGBEdYbd9fSHTFgU9ffRP
8wBf8wtDbXkULUS1/sIT5y5o5gl9AqgbpZyMXnOhXFpofSlVHD9qOiKEKMgV0MBt
aFfa5EmrokYs+Uv6GwoEDdl5yP4SI/T9gIJFS6uGDIyt4oI43BkcQYBcXx6h/QhP
ega704Q8FG1gcYuQTbRCYLTvshEMqKco704VMG5ptOMmtBngKnW0dMdQ6+nSSrwi
/GxOPdv3fur9w1hYiolAXduDq15KgNtTJvm4NUybszwMz1kWjX/pk/A9YR62h7ec
CRYKL844MiejKZ1vgaQIFDGDre4NfETDSekWTTzn/vFsb1ZUK2Mbu2QceOy3b5Yf
04+328Arh6RXCKKUoIo1oApGvEFMsv8P1FphM/DwqVlkwuQtoRI=
=ue5o
-----END PGP SIGNATURE-----

--Apple-Mail=_438EC964-B5C2-4009-9E99-340029DCE6EA--
