Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C491634F57
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Nov 2022 06:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbiKWFFG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 00:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiKWFFF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 00:05:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE851EC0B5
        for <linux-ext4@vger.kernel.org>; Tue, 22 Nov 2022 21:05:02 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 140so16340112pfz.6
        for <linux-ext4@vger.kernel.org>; Tue, 22 Nov 2022 21:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZajetla5ZaKZLHH2dp0LWPJT0X+c4jbpciiPml8+oA=;
        b=Ud6aQPhWgALnNRpl8aCTdTUhjHMy+JO09WtdN/bFvknzsDTzfb2L2wEVgxtD85zFr0
         jROP0xmS0RItGt6UvqfkGYqDWX3e/dxjVdQ8jLRx5JNg+4mMw/fdVMyc43MIUBHDXH/Y
         WrSmv20FzkY8dPZ2pClfRUrGwF2Rjlwo6HTJ+KVtlUsOOatCVUXqCQsbliuWa8EPdN5a
         kCzVpvEeT3s5trTIBC9Qi21HvUBbeKTQU7ocBJo2NfthliAG88XuEqUlX7JUXv4pFE/z
         T7hee0KDt+EFq/9j7jlsFFpPiTlQ5/bxYYV+T28CtDvWLJhMJx2yM+MLFL0RawSoZfm4
         ACXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZajetla5ZaKZLHH2dp0LWPJT0X+c4jbpciiPml8+oA=;
        b=CrTJ3wTml8/DJnTjmRLdB2rv5rGA44V77lFL2gezH6gcMowzzJDf/HZ6I4Oq2Ikfe5
         Wfapu64pEKcarpf+hYZJZqaLtOKD1erquZIGX5509+NMJ1htNykJcH3qcdkj93wI9l+j
         CngCahSZCEotnXHqe/ixMVTXLYmn5zn/8E7JuhzsgVenU+Eis3RUXgz3OXBJ1Dc1hQNY
         8ZPiYGYj4zKm/1yEFfegF409bYs0CymEPV41uHNF6cd9Egx/OFwlgR08+kZOMaIS5VuR
         HXfeqX8FZguLYqmifNgh13O8YqooxYQTOnfMNy8844inUUplPGdKa6BccpkwRhb2bi+g
         nquQ==
X-Gm-Message-State: ANoB5plTxl1LJNUgdxTNGwipz2Q7KUZPZRJdNOAmdIFMynuDBFrpBxPV
        hWNuOVwW/lZ6Stft6LE1PDq66g==
X-Google-Smtp-Source: AA0mqf4Ot3cGIAoHXPfyhRlSdaWW4nhtfqMY+XmSg/UFOmtTWdplTLDMaG8iTggCJqFKaUlT7zM1ag==
X-Received: by 2002:a63:eb16:0:b0:477:5f10:204f with SMTP id t22-20020a63eb16000000b004775f10204fmr6372714pgh.144.1669179902118;
        Tue, 22 Nov 2022 21:05:02 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001766a3b2a26sm1317649pli.105.2022.11.22.21.05.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Nov 2022 21:05:01 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <687F4A01-A443-4B5A-87B7-5958F2B3267F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E6494C82-B718-445C-8F14-47E5482AD6AC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFCv1 02/72] gen_bitmaps: Fix ext2fs_compare_generic_bmap/bitmap
 logic
Date:   Tue, 22 Nov 2022 22:04:58 -0700
In-Reply-To: <da2a28305637aef648846f9bf75d269c0f7c6e57.1667822611.git.ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Li Xi <lixi@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <da2a28305637aef648846f9bf75d269c0f7c6e57.1667822611.git.ritesh.list@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_E6494C82-B718-445C-8F14-47E5482AD6AC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 7, 2022, at 5:20 AM, Ritesh Harjani (IBM) <ritesh.list@gmail.com> =
wrote:
>=20
> Currently this function was not correctly comparing against the right
> length of the bitmap. Also when we compare bitarray v/s rbtree bitmap
> the value returned by ext2fs_test_generic_bmap() could be different in
> these two implementations. Hence only check against boolean value.
>=20
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> lib/ext2fs/gen_bitmap.c   |  9 ++++++---
> lib/ext2fs/gen_bitmap64.c | 10 +++++++---
> 2 files changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/ext2fs/gen_bitmap.c b/lib/ext2fs/gen_bitmap.c
> index 1536d4b3..f7764fca 100644
> --- a/lib/ext2fs/gen_bitmap.c
> +++ b/lib/ext2fs/gen_bitmap.c
> @@ -385,10 +385,13 @@ errcode_t =
ext2fs_compare_generic_bitmap(errcode_t magic, errcode_t neq,

        if ((bm1->start !=3D bm2->start) ||
            (bm1->end !=3D bm2->end) ||
            (memcmp(bm1->bitmap, bm2->bitmap,
> 		    (size_t) (bm1->end - bm1->start)/8)))
> 		return neq;
>=20
> -	for (i =3D bm1->end - ((bm1->end - bm1->start) % 8); i <=3D =
bm1->end; i++)

On first review it appears that this is only comparing at most the last =
7 bits
before "end", which appears to be wrong.  However, if you include the =
context
earlier in the function (which I've added above), it is using memcmp() =
to compare
the majority of the bitmaps in byte-wise order, so this is only needs to =
compare
the remaining bits, and doing the full bitwise scan is much less =
efficient.

I was going to say that the "start" value needs to be added to the =
bitmap offset
for the comparison, but I don't think that is correct either.  Looking =
at the
code (and thinking about it some more), it doesn't make sense to =
allocate space
for bits before "start", so this must be a virtual offset, and the =
*actual* bits
are always starting at "bitmap", so the above code is correct, AFAICS.

In summary, I don't think this patch will introduce a visible defect, =
but it
makes the comparisons orders of magnitude less efficient when comparing =
each
bit individually instead of using memcmp() that is likely hardware =
accelerated.

It may well be that the calling convention of this code is such that it =
is
always called with end=3Dbyte-aligned value so this code is never used, =
but that
doesn't mean it shouldn't be coded properly, in case that isn't true in =
the future.

> -		if (ext2fs_fast_test_block_bitmap(gen_bm1, i) !=3D
> -		    ext2fs_fast_test_block_bitmap(gen_bm2, i))
> +	for (i =3D bm1->start; i <=3D bm1->end; i++) {
> +		int ret1, ret2;
> +		ret1 =3D !!ext2fs_fast_test_block_bitmap(gen_bm1, i);
> +		ret2 =3D !!ext2fs_fast_test_block_bitmap(gen_bm2, i);

Strictly speaking, the !! here is not needed, and ! is enough for =
comparing
the inequality of the two values.  However, this is only used for 0-7 =
bits
and isn't performance critical since the memcmp() does the heavy =
lifting.

> +		if (ret1 !=3D ret2)
> 			return neq;
> +	}
>=20
> 	return 0;
> }
> diff --git a/lib/ext2fs/gen_bitmap64.c b/lib/ext2fs/gen_bitmap64.c
> index c860c10e..f7710afd 100644
> --- a/lib/ext2fs/gen_bitmap64.c
> +++ b/lib/ext2fs/gen_bitmap64.c
> @@ -629,10 +629,14 @@ errcode_t ext2fs_compare_generic_bmap(errcode_t =
neq,
> 	    (bm1->end !=3D bm2->end))

Conversely, *this* version of the function is *not* doing the memcmp() =
of
the bulk of the bitmap contents, so it would appear to have a bug that =
the
patch fixes, but in a very slow manner.  It would be better to use =
memcmp().

> 		return neq;
>=20
> -	for (i =3D bm1->end - ((bm1->end - bm1->start) % 8); i <=3D =
bm1->end; i++)
> -		if (ext2fs_test_generic_bmap(gen_bm1, i) !=3D
> -		    ext2fs_test_generic_bmap(gen_bm2, i))
> +	for (i =3D bm1->start; i < bm1->end; i++) {
> +		int ret1, ret2;
> +		ret1 =3D !!ext2fs_test_generic_bmap(gen_bm1, i);
> +		ret2 =3D !!ext2fs_test_generic_bmap(gen_bm2, i);

Cheers, Andreas






--Apple-Mail=_E6494C82-B718-445C-8F14-47E5482AD6AC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmN9qfsACgkQcqXauRfM
H+Cu4RAAvtywDltWzXLk0naWq4gEU7b1nbSDgfFnkGU340jzeo6+YIT80lyF/e4u
UYHks7u70S1mkHBIzaJqaiIBHntyDyA+ZUPXQ8oDFbUnj/G3QcawHquF4pBdDeqm
BT8N80479pk9MualSVKNDRWdA2G3OS6K560xPRvGUedQytvoNgHdWjm7ruUG+C1l
WtohKkMIS+uwOAnbGlMdpWabK9XIQvfnQE+TIqxSFWNPT5+RZgBsVJq5vFtQyH4v
gcm1zaVIJbn9zMFMrBmcFKTFRUbtKdUspWG68S0sBLoRF3av4h9ya9uEmGLb3ZAb
jtEIXOD0wNTwHAUAF3pE4XwspQF5aEepcOtir5KZuQyou9O+mh9CaS7GHF6mas70
S7I9tds8Kd5hCjYMaciP3RmRWBe4jsun1C0xS5fTAugrLOvx0Zh7kxEL0wGdJgo0
ivx+CmBYYMGJ2VYPudbJixJdh/YMXwA6H8vNtbmDfdMdZGR0QEtiK1GHUJdEr7T9
47ZmwqyW/1jh3WaMlIqoEk0hoxQar+epBw72n9ynWZ0l2GIGj4CzX/pF0+l2yixf
LGRt58/m7YBKAOaL2p9igu70u8UzFhb6JE/SghHnXsIczBungAX8jYCKO0FsKIz3
K6o0wznEuBt8R/kJRvvzn4EE62O+C7DCiPg/uQ7RbcAgGxE3AeI=
=IyHS
-----END PGP SIGNATURE-----

--Apple-Mail=_E6494C82-B718-445C-8F14-47E5482AD6AC--
