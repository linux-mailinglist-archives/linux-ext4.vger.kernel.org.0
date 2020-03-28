Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49371969E6
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Mar 2020 23:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgC1W41 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 18:56:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34856 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbgC1W41 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 18:56:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so6563118pfb.2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Mar 2020 15:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ctQN5z6mXvPjKVtQAIn1xpsVr1yTLpU7DQXTZS7BhX8=;
        b=MhRO67tMKo2Ulq7fji/fBnvQlGdu75S6izjP0M32i7jVGRuFHpK3Q8C7xIHOlzGxxQ
         Caq8cEO5YTbCSnNbQaDz+S6SjNmR7NYrpVAR6pagqCrYutx2OmY/A+ngOskNERzz31VQ
         MFI/jFNS3Xh8CtLRkGNvlQoShuh9hJkKuQeyLHbiDgHoOS5nkVqpX3RUiBThSXULRnss
         /09Q0P95vmiMMsCG/gDwlXV863dEdi9PgHIekEV4pVaJlbPRlDE4nZqvw3enAN72eKsB
         vNhTjjA9TcYZHn55oLKuJdtYWvjfgCgfIx5JGAGCNRtQbastmSQ6Oo01ZkiginxaZmo3
         E5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ctQN5z6mXvPjKVtQAIn1xpsVr1yTLpU7DQXTZS7BhX8=;
        b=bM/AdjB2DFnANtqiNrtEekLIO/yOt8po4BUH1g2GS467jCHzzg6YpUcc8ipV3ICo64
         FJ2CS2nmg4+2+qkC+FdxkNATi9ufrzlnPVTcwioVhBJ2C3/6fNSA6MC0U4tPi8ZlXcFu
         f8ue9fxpPM42Jp6he471Z7qwPlPnozvegMdpN9J6Z3xt+9vXZnWRpw7Q2In4cn1mNXKV
         bzXFF5mPVb8jlIMC5LWyqLaVmMjiOCy6xgLrthp6bGfTa/bhC96Pk9i7wY/UYyAlrsny
         G/Uu5CVMIlGmgUbMLk/njFK2Ru6fCgO5L+XxWmxYvVYlrEf/V8wHsG+JP2PkK28Jc6sw
         vUIA==
X-Gm-Message-State: ANhLgQ3ObhNIw5xt7IiZbR/Q/PqxCoNU7aKSGv5LphBTgRGTqB5xgWio
        cEHeGW0UaLTsjuUlVyRE6wFXIAaYbqE=
X-Google-Smtp-Source: ADFU+vuWwIpx+IF64Qf1yjE3OkWOOC0EY9SoEk/7LcztnvMNxtPf69dSG5kzJ83aow8r+i2kOU132Q==
X-Received: by 2002:a62:170f:: with SMTP id 15mr5871661pfx.12.1585436184078;
        Sat, 28 Mar 2020 15:56:24 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id i2sm6672620pfr.203.2020.03.28.15.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 15:56:23 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9A60C390-349E-4A90-A812-F04EB5A82136@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_F63E371E-7DE0-4E39-AA37-37BCA6247266";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v1 08/50] fs/ext4/ialloc.c: Replace % with
 reciprocal_scale() TO BE VERIFIED
Date:   Sat, 28 Mar 2020 16:56:17 -0600
In-Reply-To: <202003281643.02SGh9vH007105@sdf.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>
To:     George Spelvin <lkml@sdf.org>
References: <202003281643.02SGh9vH007105@sdf.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_F63E371E-7DE0-4E39-AA37-37BCA6247266
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 18, 2019, at 7:32 PM, George Spelvin <lkml@sdf.org> wrote:
>=20
> This came about as part of auditing prandom_u32() usage, but
> this is a special case: sometimes the starting value comes
> from prandom_u32, and sometimes it comes from a hash of a name.
>=20
> Does the name hash algorithm have to be stable? In that case, this
> change would alter it.  But it appears to use s_hash_seed which
> is regenerated on "e2fsck -D", so maybe changing it isn't a big deal.

This function is only selecting a starting group when searching for
a place to allocate a directory.  It does not need to be stable.

The use of the name hash was introduced in the following commit:

    f157a4aa98a18bd3817a72bea90d48494e2586e7
    Author:     Theodore Ts'o <tytso@mit.edu>
    AuthorDate: Sat Jun 13 11:09:42 2009 -0400

    ext4: Use hash of topdir directory name for Orlov parent group

    Instead of using a random number to determine the goal parent group
    for Orlov top directories, use a hash of the directory name.  This
    allows for repeatable results when trying to benchmark filesystem
    layout algorithms.

    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

So I think the current patch is fine.  The for-loop construct of
using "++g =3D=3D ngroups && (g =3D 0)" to wrap "g" around is new to me,
but looks correct.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Signed-off-by: George Spelvin <lkml@sdf.org>
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: linux-ext4@vger.kernel.org
> ---
> fs/ext4/ialloc.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 7db0c8814f2ec..a4ea89b3ed368 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -457,9 +457,8 @@ static int find_group_orlov(struct super_block =
*sb, struct inode *parent,
> 			grp =3D hinfo.hash;
> 		} else
> 			grp =3D prandom_u32();
> -		parent_group =3D (unsigned)grp % ngroups;
> -		for (i =3D 0; i < ngroups; i++) {
> -			g =3D (parent_group + i) % ngroups;
> +		g =3D parent_group =3D reciprocal_scale(grp, ngroups);
> +		for (i =3D 0; i < ngroups; i++, ++g =3D=3D ngroups && (g =
=3D 0)) {
> 			get_orlov_stats(sb, g, flex_size, &stats);
> 			if (!stats.free_inodes)
> 				continue;
> --
> 2.26.0
>=20


Cheers, Andreas






--Apple-Mail=_F63E371E-7DE0-4E39-AA37-37BCA6247266
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/1hEACgkQcqXauRfM
H+DHTA//Wi+ebx7YL3LXS/maT9+NTXDFJyQ0PurF/Mhtu7JrHxV7Epsi+2Xs6AED
ShIWr1jK5ETRGXLSXcv97rv5NTj1P21Jp50zXhveOMPUzFXb3kRpn7Wpj81+xPci
sdSQylCeUb9KIuqjdrTpo65THNu3h68R9Kl/+U3r+mdT5s1OM9pMbFFNKoBlX7I/
zoCl6dXFCEYYFssWqukNh1GKARctNJTo5pzc8u+LgCIlCROuCFhRcEaqHv2aSYhB
C6zULpgm1ImO/PUEn3Bbv4YvqER6RFlKcnAuLUJg+vkOJhbWYLhhqwoSeCEB+RF6
G0RTEUlgsi6Kq7oXySP5jj9/vOyrDlztHJjChYOnw6oarlR9UorYQBoF8xNHt7jV
tseJ7vVI5MqC2fYin6r9+swIwTwbIP0Lr1N8AEuzKBRddiocUAH3jXkp6k+PpdZA
EV6NsT1Qxxi9Tu9XrPU9GH/gDX48a9i24MMqeUCc4CFHW308KpSr5LBP9u3YYiog
zbT9k/MkbtvK+OfqTfsBk5cyeXXkdLI5rS5YSOI/88C9nb5OdOPv2e8yZCH5lVMx
cpzb4moamIAz+f6pwi+KlQ/qI6vjxAjc72iIyVNFxnCO32KJ1edS+fH5kHATSLpd
Y8+aQ2SULhkCudM1QcEFIRKkwEQRxnwm8SG59i4i2LgLJFsZM0A=
=jXV1
-----END PGP SIGNATURE-----

--Apple-Mail=_F63E371E-7DE0-4E39-AA37-37BCA6247266--
