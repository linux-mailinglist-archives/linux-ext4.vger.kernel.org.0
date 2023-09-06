Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846C4793E03
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Sep 2023 15:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjIFNtO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Sep 2023 09:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbjIFNtN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 6 Sep 2023 09:49:13 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA53CF1;
        Wed,  6 Sep 2023 06:49:09 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230906134907euoutp01c524043146f2ae2f6c49b4a425185d21~CU29Jp6JC0254502545euoutp01g;
        Wed,  6 Sep 2023 13:49:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230906134907euoutp01c524043146f2ae2f6c49b4a425185d21~CU29Jp6JC0254502545euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694008147;
        bh=eBBcSc+Mu9ilRNWi6Na0uuTYLwK0AFMk3elf7n3fnVQ=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=bvn+LMUnM1fbKDe05u3CAIDn2f9a+DdgsZU3bTnMU2NptaNj95YHzyGwQsmYJPdjw
         xW3LQ4xPNN/e41oa4PUzfL2LPgK54/ZNROP4wlvWeIIPLi/Qc+0spDGn7tTwGfRdEV
         zA/sAe6yAbQ/ePE4z5n0BsNwckfV/ZqGgWC/pFRg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230906134907eucas1p20cb71f852ca748a1e11e28f0547d5f74~CU29C7acd1821918219eucas1p20;
        Wed,  6 Sep 2023 13:49:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.F8.37758.35388F46; Wed,  6
        Sep 2023 14:49:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f~CU28oqR8P0948109481eucas1p1w;
        Wed,  6 Sep 2023 13:49:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906134906eusmtrp23ffa5b3695b69b114aee60fd21e34d02~CU28oFHQ21439914399eusmtrp2e;
        Wed,  6 Sep 2023 13:49:06 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-81-64f88353befe
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 8C.54.14344.25388F46; Wed,  6
        Sep 2023 14:49:06 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230906134906eusmtip1c2fb837fd03a11894258e12bb4b660ec~CU28br4es2834628346eusmtip1W;
        Wed,  6 Sep 2023 13:49:06 +0000 (GMT)
Received: from localhost (106.210.248.249) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 6 Sep 2023 14:49:05 +0100
Date:   Wed, 6 Sep 2023 15:49:04 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     <fsverity@lists.linux.dev>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] fsverity: move sysctl registration out of
 signature.c
Message-ID: <20230906134904.4zbqdldrq2k4rqfn@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="ucoocnlqckxxzdbe"
Content-Disposition: inline
In-Reply-To: <20230705212743.42180-3-ebiggers@kernel.org>
X-Originating-IP: [106.210.248.249]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87rBzT9SDO63sFqs3fOH2aLz0X82
        i0uPV7BbzJx3B8ha5O7A6rFpVSebx4vNMxk9di/4zOTxeZNcAEsUl01Kak5mWWqRvl0CV8aq
        C/OZC/YpVyx59pS1gfGhbBcjB4eEgInEuk+8XYxcHEICKxgljrw+ywLhfGGUeDDtKCuE85lR
        YnPLGqAMJ1jHijsLoKqWM0pcWtzBCFc1aekrRpAqIYEtjBI/rxSB2CwCKhK79q5gBrHZBHQk
        zr+5wwyyW0RATeLYUn+QXmaBdkaJLVNeg9UICwRIXJ36kgnE5hUwl5h7cQEzhC0ocXLmE7Ar
        mAUqJFonfGQHmcMsIC2x/B8HSJhTwFLiTMsJJohDlSWO9d6BOrpW4tSWW1Dx/xwSe1ZEQ9gu
        Ej/O9kDVCEu8Or6FHcKWkfi/cz4TyG0SApMZJfb/+8AO4axmlFjW+BVqkrVEy5UnUB2OEr9+
        f2aBBCqfxI23ghB38klM2jadGSLMK9HRJgRRrSax+t4blgmMyrOQfDYLyWezED6DCOtILNj9
        iQ1DWFti2cLXzBC2rcS6de9ZFjCyr2IUTy0tzk1PLTbOSy3XK07MLS7NS9dLzs/dxAhMVKf/
        Hf+6g3HFq496hxiZOBgPMaoANT/asPoCoxRLXn5eqpII7zv5bylCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamNrKrSfYTInZJPqQP9byv9LcBGGOhe2T
        ju286jjjD1fOPl7LN8Vhne8tWwX7Hqa/u2OZ+G6lNafmfP53QXOCu6742ye/Xsxx2PFawdnP
        QawK/n9vpJ23fh4kcfadcapo4Fvxd7cnZ6yw1Vbe276MZ8eldAFjkykx8qrVeZr6E1b8KpYs
        3LQzV9+u5sX/3zwx9q36CzeYHVJwqOvrf1O63knqc2qXi9/SmEMZLzSZ/0j5WXnK2YUYmXws
        iDTbwZtxZfIs2YNebjJ1C7Kcp5+VFX2/9uS1zZvW3N3UF799YpXcHPEJQTumXmGMqJ5y/HB1
        h8CFjD+zl01zPuvEdo+Bi0vH8dnGr5MlLzfE35v5WomlOCPRUIu5qDgRAAhYMMXPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7pBzT9SDGavVLNYu+cPs0Xno/9s
        Fpcer2C3mDnvDpC1yN2B1WPTqk42jxebZzJ67F7wmcnj8ya5AJYoPZui/NKSVIWM/OISW6Vo
        QwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYzJu44wFexRrljY1c3ewHhftouR
        k0NCwERixZ0FLF2MXBxCAksZJea8/cYKkZCR2PjlKpQtLPHnWhcbRNFHRomPFx+wQjhbGCX6
        Dy1hAqliEVCR2LV3BTOIzSagI3H+zR0gm4NDREBN4thSf5B6ZoF2RoktU16DxYUF/CTa71WC
        lPMKmEvMvbgArFVIIF1i+r73LBBxQYmTM5+wgJQzC5RJfFomCWFKSyz/xwFSwSlgKXGm5QQT
        xJnKEsd677BA2LUSn/8+Y5zAKDwLyaBZCINmIQwCqWAW0JK48e8lE4awtsSyha+ZIWxbiXXr
        3rMsYGRfxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERir24793LKDceWrj3qHGJk4GA8xqgB1
        Ptqw+gKjFEtefl6qkgjvO/lvKUK8KYmVValF+fFFpTmpxYcYTYEhOJFZSjQ5H5hE8kriDc0M
        TA1NzCwNTC3NjJXEeT0LOhKBgZNYkpqdmlqQWgTTx8TBKdXANHtnerCX0OxykzVLd/stnHcg
        WOKzZ9P/+9VZNbr72lukEvduvH1t7Se+O31ZBmvX/Io8teT9Q6mSlwvecB1ybY203mdUsqXr
        4OxWecVtpo9e60+RVJnMa1ilcveYNo8s7+aCVUpTRGMnSKwvOSfiFrnpvdwq5dORIupa5SxW
        z+zb9m4+77RhT+cvlcb//qrivdoT/7k/D1ZY9sj/ZJPMuzXRbAJCDssq3+6odKteuPd2pWPh
        435Do93Cx21j1H6mvmJ/cWZruL3LPDl27aLA3ohJz/Jy3M/xXp9y5ldywSVdturyJbts5IRb
        lPJ2KKzp1tloZrPsBsuyKEafmmRz9qftXnGfdSY+7/g0z7FRiaU4I9FQi7moOBEA3VBoZGoD
        AAA=
X-CMS-MailID: 20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f
X-Msg-Generator: CA
X-RootMTR: 20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f
References: <20230705212743.42180-1-ebiggers@kernel.org>
        <20230705212743.42180-3-ebiggers@kernel.org>
        <CGME20230906134906eucas1p18f20ec4bd1aa89ce9c8c6495255d442f@eucas1p1.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--ucoocnlqckxxzdbe
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2023 at 02:27:43PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>=20
> Currently the registration of the fsverity sysctls happens in
> signature.c, which couples it to CONFIG_FS_VERITY_BUILTIN_SIGNATURES.
>=20
> This makes it hard to add new sysctls unrelated to builtin signatures.
>=20
> Also, some users have started checking whether the directory
> /proc/sys/fs/verity exists as a way to tell whether fsverity is
> supported.  This isn't the intended method; instead, the existence of
> /sys/fs/$fstype/features/verity should be checked, or users should just
> try to use the fsverity ioctls.  Regardlesss, it should be made to work
> as expected without a dependency on CONFIG_FS_VERITY_BUILTIN_SIGNATURES.
>=20
> Therefore, move the sysctl registration into init.c.  With
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES, nothing changes.  Without it, but
> with CONFIG_FS_VERITY, an empty list of sysctls is now registered.
>=20
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/verity/fsverity_private.h |  1 +
>  fs/verity/init.c             | 32 ++++++++++++++++++++++++++++++++
>  fs/verity/signature.c        | 33 +--------------------------------
>  3 files changed, 34 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/verity/fsverity_private.h b/fs/verity/fsverity_private.h
> index c5ab9023dd2d3..d071a6e32581e 100644
> --- a/fs/verity/fsverity_private.h
> +++ b/fs/verity/fsverity_private.h
> @@ -123,6 +123,7 @@ void __init fsverity_init_info_cache(void);
>  /* signature.c */
> =20
>  #ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> +extern int fsverity_require_signatures;
>  int fsverity_verify_signature(const struct fsverity_info *vi,
>  			      const u8 *signature, size_t sig_size);
> =20
> diff --git a/fs/verity/init.c b/fs/verity/init.c
> index bcd11d63eb1ca..a29f062f6047b 100644
> --- a/fs/verity/init.c
> +++ b/fs/verity/init.c
> @@ -9,6 +9,37 @@
> =20
>  #include <linux/ratelimit.h>
> =20
> +#ifdef CONFIG_SYSCTL
> +static struct ctl_table_header *fsverity_sysctl_header;
> +
> +static struct ctl_table fsverity_sysctl_table[] =3D {
> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> +	{
> +		.procname       =3D "require_signatures",
> +		.data           =3D &fsverity_require_signatures,
> +		.maxlen         =3D sizeof(int),
> +		.mode           =3D 0644,
> +		.proc_handler   =3D proc_dointvec_minmax,
> +		.extra1         =3D SYSCTL_ZERO,
> +		.extra2         =3D SYSCTL_ONE,
> +	},
> +#endif
> +	{ }
> +};
> +
Just to double check: When CONFIG_FS_VERITY_BUILTIN_SIGNATURES is not
defined then you expect an empty directory under "fs/verity". right?

I'm double checking as part of the ongoing "removing the sentinel" patch
set. Latest patchset here
https://lore.kernel.org/all/20230906-jag-sysctl_remove_empty_elem_arch-v1-0=
-3935d4854248@samsung.com/.
The filesystem chunk has not yet been publish, but I'm making it ready
for when that time comes.

> +static void __init fsverity_init_sysctl(void)
> +{
> +	fsverity_sysctl_header =3D register_sysctl("fs/verity",
> +						 fsverity_sysctl_table);
> +	if (!fsverity_sysctl_header)
> +		panic("fsverity sysctl registration failed");
> +}
> +#else /* CONFIG_SYSCTL */
> +static inline void fsverity_init_sysctl(void)
> +{
> +}
> +#endif /* !CONFIG_SYSCTL */
> +
>  void fsverity_msg(const struct inode *inode, const char *level,
>  		  const char *fmt, ...)
>  {
> @@ -36,6 +67,7 @@ static int __init fsverity_init(void)
>  	fsverity_check_hash_algs();
=2E..

Best
--=20

Joel Granados

--ucoocnlqckxxzdbe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmT4g04ACgkQupfNUreW
QU95Awv+IWRBDMnRlyC8SI39Y97CyTwG88WqKXVu85qYFaB+PWy5zW9o3TOynS59
OqTWAaLIKbLPznFkrUZQEueX8+EJSe2YINHIrJOgYqcNlNWWtUNChIBR63M4YWVo
qb0MEo9nQCPTH/nEE9IEIe76FCAUY+gDM72foSAn4pBRReyAi1s+d24iSZSqtj/d
qGKLVBpHela44W8Cpver9fdrQjS+oaURE6ILdJoaY7FayTqit8/ucee8juN4/71A
rJaJM9dLaNNOBt76kdZXqG3ti0S6KqimLZU5I+m6jHiVtioaZ0BUArnnFfOcPEV/
TT3Ff69oPrxP5dcgc18lwaR3vdoqvUVF86JAzHvxnEK41UX9VvG07YjfMGn6zwE/
TzkEs2+rgLfVVbENuIK+caYIbOOskbn/QLLJRq1+auqlR0MM5/iIHz1m+i38gOg6
hR4LE5sVTymhgwJEJcU6IKHTKCsERQIGw9M/1izdrRlc5nbBC4V+UeMCBOI5TFMg
ePDqmVBB
=oK9W
-----END PGP SIGNATURE-----

--ucoocnlqckxxzdbe--
