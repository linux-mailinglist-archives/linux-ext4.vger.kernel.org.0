Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA831094AC
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Nov 2019 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbfKYUfm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Nov 2019 15:35:42 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37247 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKYUfm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Nov 2019 15:35:42 -0500
Received: by mail-pj1-f68.google.com with SMTP id bb19so3578752pjb.4
        for <linux-ext4@vger.kernel.org>; Mon, 25 Nov 2019 12:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=dPQ6h7zFD1Oyhpvy1I4x06EbAiDf8R0y0ApMKnWZvr4=;
        b=NFxYfGv/HncILw/twOPsiJnyKxN1kgTDHLbUbgJ6RFjfreov9M7YyVX4jycgwHFN0N
         KdT3c67RyOQzUSOGiSardLlFjiP8+0QEnFDalVZ4NSyFbJXGe1DFHDUjJgdVjrM0pAWr
         qwD1X4xmr2GuDB4piXhHujXBWLjzAXobSKt2nOSiPMcX8wo4BxLsDiTbPzEcgeiY9hc6
         NT1rAEGTodac2TQFrnAY2EGvRTyis0IIokwBIps4sAeK402Z/EodsGQz933VkOW7V3O3
         zjt+KXVDb4VM9vr2kHE6klwZz86/Ay4AWEPFSCu+OD+DP7RYVFIRPVlvgs7BLxJgen9n
         1vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=dPQ6h7zFD1Oyhpvy1I4x06EbAiDf8R0y0ApMKnWZvr4=;
        b=WCt/m1c0e+oBJnXxO1G8zbb6Y8cJpLtpqAk6CybERehQPxqnhaKlP+kBiXRTWJhk28
         ON5M+MfP6hdMCIIR6tbsuWV5xRxK4BUNvw9fnqD0F4SQ4JfFcKde1Dm/La3DaQnOs0nB
         A4Sk5LKAmn7FpX6FT8SPTNGpNhr790tBwwsQvieMN7AY12zW0aJqbVJn1e9/sARGNMaD
         VB0A/EUc4S+3JMMRSDe+4apJbAb9CeJssUfItUeW3GoPt+sS3bPvr8q0OYjEJtLY6Y4X
         xXTniGuWVxA3Sh0qwX29jKv1fcfaMqJh+uyzr57NBPF4N5l5cDaHzYBDEBIk+siCE563
         CViw==
X-Gm-Message-State: APjAAAV7SiQ8LmOJzxXWX97GMjtnlKrB1tf7YZ1M4J5bJ0LNSwwMmohA
        xLkJBcDQIyCPMx/VjfEr9NYYoQ==
X-Google-Smtp-Source: APXvYqzVO8iAQ5MjYfDOwABQW45SoSRKHVaCBm154YZvjPAOB+Yzt2AwT/nHNlEXoM6bkg3x9IeZaw==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr1113269pjb.99.1574714140026;
        Mon, 25 Nov 2019 12:35:40 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c28sm9453193pgc.65.2019.11.25.12.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 12:35:39 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <112BB9E8-55D1-4F4A-9872-63DCB8C804EF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F3EFE867-C13C-4206-8F13-7B22BD096AF0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Unnecessarily bad cache behavior for ext4_getattr()
Date:   Mon, 25 Nov 2019 13:35:36 -0700
In-Reply-To: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wivmk_j6KbTX+Er64mLrG8abXZo0M10PNdAnHc8fWXfsQ@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F3EFE867-C13C-4206-8F13-7B22BD096AF0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 24, 2019, at 5:19 PM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> It looks from profiles like ext4_getattr() is fairly expensive,
> because it unnecessarily accesses the extended inode information and
> causes extra cache misses.
>=20
> On an empty kernel allmodconfig build (which is a lot of "stat()"
> calls by Make, and a lot of silly string stuff in user space due to
> all the make variable games we play), ext4_getattr() was something
> like 1% of the time according to the profile I gathered. It might be
> bogus - maybe the cacheline ends up being accessed later anyway, but
> it _looked_ like it was the whole "i_extra_isize" access that missed
> in the cache.
>=20
> That's all for gathering the STATX_BTIME information, that the caller
> doesn't even *want*.
>=20
> How about a patch like the attached?

I think that looks quite reasonable.  I was going to comment that the
nanosecond timestamps for [amc]time are also stored in the "extra_isize"
part of the inode, but in this callpath they are already stored in the
VFS inode and do not need to be extracted each time.

So I'd think your patch should be good, modulo 80-column line wrap.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


>  fs/ext4/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..617dc8835f5f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5700,7 +5700,7 @@ int ext4_getattr(const struct path *path, struct =
kstat *stat,
>  	struct ext4_inode_info *ei =3D EXT4_I(inode);
>  	unsigned int flags;
>=20
> -	if (EXT4_FITS_IN_INODE(raw_inode, ei, i_crtime)) {
> +	if ((query_flags & STATX_BTIME) && EXT4_FITS_IN_INODE(raw_inode, =
ei, i_crtime)) {
>  		stat->result_mask |=3D STATX_BTIME;
>  		stat->btime.tv_sec =3D ei->i_crtime.tv_sec;
>  		stat->btime.tv_nsec =3D ei->i_crtime.tv_nsec;

Cheers, Andreas






--Apple-Mail=_F3EFE867-C13C-4206-8F13-7B22BD096AF0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3cOxgACgkQcqXauRfM
H+AUkQ/8CsXZlodRBKWhhPQL21jL+FQnwsttSCsn2pSDxtx2PjM6/5CilGot/83a
teKflF0dqus+bLKclBvP82hbE0m5szNxNIfDjb25WWhLuhyu9lQw4WcqIFjp51pz
8je68rOFdVFkCSl4ZeQYS4bv9Piwe+/jDqQCI9TpqOBON8vhSFBA+vO5tEkS3NlZ
H4Bk9j76H7Q3O7h+bwfPlla8x+L7l6iLLYbLrFe0DPPMM9eM03CWTfFlV1t+ytcI
1d4j1tjqOO1ITB6+JH+OPr2++aPSK6SICRw+BlkDm/L/A1ndZzV+DMeJZwMY+OjO
Nmvi4SG308dfL82Nxccm0ziAK40A0gbJt8Ut39uoERwLs55HV1fAwPXfs/CmHwRF
moyYpaoEpz8CjXa/NPWjeB3YEPgE3hnqayUhVKphGnC5Jk0XL6WkfJiBSBLesiOv
WQvVSWcWSKDGdamnl6ybJDZ43wmjjaBI5fksHw3OApqBk51YfmduDsl16K18tRXh
dZs1FG+T3gbbAsTBT0Ts/TIYdcObgnAO0pomZRD1elpyF9zzVyO5qMlySBj0kHnE
TVWhfe9PHsZLE3N7lkiAffVHSvy7PDeCb0eBUeiexSaF/4cZ3D4y86+tgZHSrHyu
+K4XP5e0uPHLQ84aW14gyOfVZe9IRuSPk7+PXrDJ3Z6jVGU6XiE=
=6npK
-----END PGP SIGNATURE-----

--Apple-Mail=_F3EFE867-C13C-4206-8F13-7B22BD096AF0--
