Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2662DDA97
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Dec 2020 22:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgLQVKd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 16:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLQVKd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 16:10:33 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38537C0617A7
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 13:09:53 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id 4so207598plk.5
        for <linux-ext4@vger.kernel.org>; Thu, 17 Dec 2020 13:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=SJ3XQzrJUM2Ts9mckzdYNPQrSayfljmO0Ikzg9Zn5jw=;
        b=vuQQIAmqc8NK11tFUAVC+fYCHYlUcXAbVqlZOZD2Oa2vYzdVJL1jGpSqPB4XYAX/1A
         26covMhJRXpPy7oYibW9cu79XBnM+bTHpkqS7szdNJr5oARRg/qxrg5AdZI8qOBT3IPT
         qoPo7UNQAFUE2aXh32NB4xXZWc/X2GcA/I70mCt/otHE0P9IysaUHr3L2531FwD485bj
         hiBzbbzUbZA+0BfgeUPU18dCYm1kYDHkxtL1Ouf5T5b14U1nORCTqyzycSV/J5ThVVrQ
         glny4XSZB+QqQ0Bl6sSenn1TUaXLYY5Z5EGAAKWbkIAByvYf/v1Drkav7qv9kj8Wrrue
         Ec7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=SJ3XQzrJUM2Ts9mckzdYNPQrSayfljmO0Ikzg9Zn5jw=;
        b=rezl8yZ9U0LbmoPGKXhjfYtpzkpfknd5IhQrxEqw/YgHJXHE37leHO8y1K7fC36vWX
         UGmG69FapFDiPsI1sRgEumdH8oL7XkHSkMDqNMj7ZFTeXwepPVt2CiSU7l8goLGooEly
         4V3tAxeZGRwrSE6eJdyfDpmDNffReUaxpSPPsPnWqA2vdS+mNQhtHe01Y5s3UtekJRxi
         vaz3EFjE1D/kynVGrHUAF2fbPwQ+hSA1pvBQWshDa/StXGpWEN4mXY5bVqWVMOBJpEKJ
         wobmRo8CG2ACmlshuloBqqaSyRQUyBnynyjr2sORqeWmhAiWg0WGJ7RfXuc4tJ0W/4Kh
         45hQ==
X-Gm-Message-State: AOAM531afWEDxT84oFFdzVS5RA0RslmsOUAgaLPKSoVIE9P5SmDkvZcl
        4wNeUYEmhXOyNrfeEbQv6korKw==
X-Google-Smtp-Source: ABdhPJxxWb86hTJzrkduuHOZWcQK6/Og9gpbFxD/Xi4fZ9dHs+06Bzl/Iotw7Op6Ln6ipbOkwkLq9g==
X-Received: by 2002:a17:902:9a06:b029:da:1d45:2c63 with SMTP id v6-20020a1709029a06b02900da1d452c63mr961864plp.31.1608239392663;
        Thu, 17 Dec 2020 13:09:52 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w4sm6784105pfd.52.2020.12.17.13.09.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:09:51 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <CA1BD917-22BD-4AAD-877D-BDF41B36D945@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5922C4CF-2628-4D69-93BC-3AAAECC71D02";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Don't leak old mountpoint samples
Date:   Thu, 17 Dec 2020 14:09:48 -0700
In-Reply-To: <X9ujIOJG/HqMr88R@mit.edu>
Cc:     Richard Weinberger <richard@nod.at>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <20201201151301.22025-1-richard@nod.at> <X9ujIOJG/HqMr88R@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5922C4CF-2628-4D69-93BC-3AAAECC71D02
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 17, 2020, at 11:27 AM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Tue, Dec 01, 2020 at 04:13:01PM +0100, Richard Weinberger wrote:
>> As soon the first file is opened, ext4 samples the mountpoint
>> of the filesystem in 64 bytes of the super block.
>> It does so using strlcpy(), this means that the remaining bytes
>> in the super block string buffer are untouched.
>> If the mount point before had a longer path than the current one,
>> it can be reconstructed.
>>=20
>> Consider the case where the fs was mounted to "/media/johnjdeveloper"
>> and later to "/".
>> The the super block buffer then contains "/\x00edia/johnjdeveloper".
>>=20
>> This case was seen in the wild and caused confusion how the name
>> of a developer ands up on the super block of a filesystem used
>> in production...
>>=20
>> Fix this by clearing the string buffer before writing to it,
>>=20
>> Signed-off-by: Richard Weinberger <richard@nod.at>
>=20
> Thank for reporting this issue.  In fact, the better fix is to use
> strncpy().  See my revised patch for an explanation of why....
>=20
> commit cdc9ad7d3f201a77749432878fb4caa490862de6
> Author: Theodore Ts'o <tytso@mit.edu>
> Date:   Thu Dec 17 13:24:15 2020 -0500
>=20
>    ext4: don't leak old mountpoint samples
>=20
>    When the first file is opened, ext4 samples the mountpoint of the
>    filesystem in 64 bytes of the super block.  It does so using
>    strlcpy(), this means that the remaining bytes in the super block
>    string buffer are untouched.  If the mount point before had a =
longer
>    path than the current one, it can be reconstructed.
>=20
>    Consider the case where the fs was mounted to =
"/media/johnjdeveloper"
>    and later to "/".  The super block buffer then contains
>    "/\x00edia/johnjdeveloper".
>=20
>    This case was seen in the wild and caused confusion how the name
>    of a developer ands up on the super block of a filesystem used
>    in production...
>=20
>    Fix this by using strncpy() instead of strlcpy().  The superblock
>    field is defined to be a fixed-size char array, and it is already
>    marked using __nonstring in fs/ext4/ext4.h.  The consumer of the =
field
>    in e2fsprogs already assumes that in the case of a 64+ byte mount
>    path, that s_last_mounted will not be NUL terminated.
>=20
>    Reported-by: Richard Weinberger <richard@nod.at>
>    Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Color me confused, but I don't see how this change makes any difference?
If "cp" is only "/" then it will *still* not overwrite =
"edia/johnjdeveloper"
at the end of the s_last_mounted array.  To my mind, the only difference
between using strlcpy() and strncpy() would be whether the last byte in
the array can be used or not, but doesn't affect the remaining bytes.

>=20
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 1cd3d26e3217..349b27f0dda0 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -810,7 +810,7 @@ static int ext4_sample_last_mounted(struct =
super_block *sb,
> 	if (err)
> 		goto out_journal;
> 	lock_buffer(sbi->s_sbh);
> -	strlcpy(sbi->s_es->s_last_mounted, cp,
> +	strncpy(sbi->s_es->s_last_mounted, cp,
> 		sizeof(sbi->s_es->s_last_mounted));
> 	ext4_superblock_csum_set(sb);
> 	unlock_buffer(sbi->s_sbh);


Cheers, Andreas






--Apple-Mail=_5922C4CF-2628-4D69-93BC-3AAAECC71D02
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/byR0ACgkQcqXauRfM
H+Am6w//ZN6w43WO7QUFjSXw37PwstnJVOObTkPWPAtgBNDndIQzdZvQMMrlWtC+
ZBNMd5US6GP6KQwwG6dopRX5MvJdrw5NkUIC2VBRCHHKPUe9G/rwNQXiNAsNZM7D
IOiKKDFjni7k9Yo0RBAQCKE3RfqRj0BbsI6qgcKaWatn3XGbDL8HXNgHpdIsSnZl
8s4i8jbvr63ZiGp3ZhQEP2ker2yTFMiztJLtUCIToEEdje0xNdolJzUmvI44+epz
oi1PFYGzV/xbKAVdd+uYvJg9wNS1v/UCxPsP1eap3ogyxBT0TpZdojcbvR6ZFqEo
tiX3uWs1W1mUKQPUgTCNVjfCuyACWm7ktPIARtWy2gvDRXylRaqZVZ/7kKLntWFM
kqw6f6wVLpLwnyObjBiS14IuukVLsYS319ET0vQ0Y7sxEjukLnTWbn57phhzUlTn
eYtNonbOS2UCfZjtIT7TV2wyTYKtaQTedPg6rCVG6K5xqmcooc9MsGE7Nbfv54pd
MnV35lIWWDOEWIeSwkS3wfrEazhZH56XYaW5hNB9bHcVS3UGEE2HmxwMwLKUJfIH
bHg9QQEKl4tABtqwdud2Z+JWB6L1SSD0e+odpXzLZesEohcHlPKJsWjqgxqz/TNS
pz6iZs0PayDxwFAB7OSn1uw4ywktWeseoMKbnqXbEWqZGH9Nbd8=
=ttEJ
-----END PGP SIGNATURE-----

--Apple-Mail=_5922C4CF-2628-4D69-93BC-3AAAECC71D02--
