Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F23D30933F
	for <lists+linux-ext4@lfdr.de>; Sat, 30 Jan 2021 10:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhA3JXY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 30 Jan 2021 04:23:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbhA3JWL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 30 Jan 2021 04:22:11 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3393C061756
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 22:42:25 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so8106805pgc.8
        for <linux-ext4@vger.kernel.org>; Fri, 29 Jan 2021 22:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=mMUVNvkj7t+7T/73tupMioAu1L+Zp4DgVQjXC9IwOhM=;
        b=J4vDHS9PA6SLXiIlkoSmqggoWq3wD4t+NdU3YGV84mAsKuQubMSgAmp/MN5jbZAqbI
         WBFOhRo+oxHRC9Ez4Q80mvZtun5ZJXGOnCGPZmdLYjF2RryRE7KETw/RvlZSs+WaWimV
         YFgRrmkAeR6+3TUK5fDlVmsZYemJD0KZ5NB9bZmX5KqSI1d0cTYSmRMdvZ7ju6TEk54t
         LVKmjNicSQCZS6yGWnQYuzV4Ev8Nw4pHDcmG8Od7KB7YrQfXIQLK0Z82pLTRD2bNJx7T
         n+4h9tu5E+Lkz6fkdKz2pujLb92U+or41iuK5+S1KPs3TCmSx+j/V7WCKqyEI6L1PIy8
         vUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=mMUVNvkj7t+7T/73tupMioAu1L+Zp4DgVQjXC9IwOhM=;
        b=qELyMMVaxP7i9/Ihre3jS9wCnJlufZGOrMUdrnQit0ctyG1XgEMEBJTBdWDeGYUhRB
         XhZWSvkW7OMPT6sdNmjq06yJgFGquThizPM6zVyoqo9f6qJ/rgZ3I+Acp/LwJFbfBPLa
         /270qQSkirOi0AWGwD3SVKU6JXdWHXhmx3tew9TAFAqShNlduIdP7Qb6Ux0kPBwRUunM
         5foXojFhtvNnWcSTN15zIKMBqyDz2O6VJtOmzFUWSY5DR89odH53SjYA/Jcd4FkUpF2z
         NKr3DzOETj3Xy/iaGl04/fWw7jETBFXKTB3gyu24JINOstwkpqrLKhLsxHLPDn9SEiS3
         mxMA==
X-Gm-Message-State: AOAM5336PbqvTlsgFnaBuDHrO+XlNeCmE2vAc/uuv41bDmZwTRfID226
        /PF0YWiL6UGpB/ONOfuG/dXJww==
X-Google-Smtp-Source: ABdhPJwUT8VBR+w7tk8/oYiDWz4lS2MIn967cZ0+GZQ3D4xGnJqyzoa8UmwU/lf9Edq0V+WfKl5fLQ==
X-Received: by 2002:a63:605:: with SMTP id 5mr7898497pgg.144.1611988944536;
        Fri, 29 Jan 2021 22:42:24 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z2sm11078525pgl.49.2021.01.29.22.42.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jan 2021 22:42:23 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AAB32610-D238-4137-96DE-33655AAAB545@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_7F4BCA94-4C48-4AE3-93D5-5577EE984D3A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Remove unreachable code
Date:   Fri, 29 Jan 2021 23:42:20 -0700
In-Reply-To: <20210129185856.158310-1-viniciustinti@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
To:     Vinicius Tinti <viniciustinti@gmail.com>
References: <20210129185856.158310-1-viniciustinti@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_7F4BCA94-4C48-4AE3-93D5-5577EE984D3A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2021, at 11:58 AM, Vinicius Tinti <viniciustinti@gmail.com> =
wrote:
>=20
> By enabling -Wunreachable-code-aggressive on Clang the following code
> paths are unreachable.
>=20
> Commit dd73b5d5cb67 ("ext4: convert dx_probe() to use the ERR_PTR
> convention")
> Commit ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
>=20
> Clang warns:
>=20
> fs/ext4/namei.c:831:17: warning: code will never be executed
> [-Wunreachable-code]
>                        unsigned n =3D count - 1;
>                                     ^~~~~
> fs/ext4/namei.c:830:7: note: silence by adding parentheses to mark =
code as
> explicitly dead
>                if (0) { // linear search cross check
>                    ^
>                    /* DISABLES CODE */ ( )
>=20
> Signed-off-by: Vinicius Tinti <viniciustinti@gmail.com>
> ---
> fs/ext4/namei.c | 15 ---------------
> 1 file changed, 15 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index cf652ba3e74d..1f64dbd7237b 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -827,21 +827,6 @@ dx_probe(struct ext4_filename *fname, struct =
inode *dir,
> 				p =3D m + 1;
> 		}
>=20
> -		if (0) { // linear search cross check

I would rather put this block under "#ifdef DX_DEBUG" so that it is =
available
in the future for debugging problems with hashed directories.

> -			unsigned n =3D count - 1;
> -			at =3D entries;
> -			while (n--)
> -			{
> -				dxtrace(printk(KERN_CONT ","));
> -				if (dx_get_hash(++at) > hash)
> -				{
> -					at--;
> -					break;
> -				}
> -			}
> -			ASSERT(at =3D=3D p - 1);
> -		}
> -
> 		at =3D p - 1;
> 		dxtrace(printk(KERN_CONT " %x->%u\n",
> 			       at =3D=3D entries ? 0 : dx_get_hash(at),
> --
> 2.25.1
>=20


Cheers, Andreas






--Apple-Mail=_7F4BCA94-4C48-4AE3-93D5-5577EE984D3A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAU/8wACgkQcqXauRfM
H+BX7hAAtuP6GfFTB1/BBKJBQM7duFrsr4MGsKJyblsMboKopMPSu9tFRNIeaqgh
+LjmN4iPt7zZbVWpJBoh2eFO3H0dj64Mj5xCy/qG3o+aWTD71jVdJ1y6hs21SwG8
DEh28o2RfLmEkPseycpunio+awkwKWm9KHJNpzzu/pbm3ARdhNllW141vt/djymB
2ME7xw9ACyurF/L7oOmMwPuF/0OQ1LMCmsOvbVzyWWUmSal33Q2Di073EjpI7ghs
aaHXdp80Sh1JT0Y93fEF166WCsZaIjUOGUlXO1mLw1suBTCSxyvO/f/Jdf74amNk
tizr9X4oixOQ6670cY784y/SF7tu+e0Gkj8cRAWhYF6xI9XobFkA1d78HT3uCP69
f3xs+VDaLaYcy8nmqDpPMj/V9e0hj9FdiEaCRcusHgLcgCh4dIu6obRCQEvnzq/f
AFBQB9skoP56V+kuQ0nHHnYdj/EYo9bxpbF5NvlJutX74bDIEa93PFacUF9TbjkO
rQZRmv2JmCXfHx1b9oKoTLnuPEmstwvWVZn5MBy3f77JLl1FaDmxhY7IsMu7zM6F
OnqoQtWhwEtzgT28dYMWmFFQyx3FGgY6yDWWqx+EMZ/C7nSH8AnUGMFMpVlEGbbO
Fy07M7Wdy8ZBB2jPWyYlA750vD4huN+SuRUmk8nJh4T/wRgBMls=
=rYW5
-----END PGP SIGNATURE-----

--Apple-Mail=_7F4BCA94-4C48-4AE3-93D5-5577EE984D3A--
