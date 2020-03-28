Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0D196A0B
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Mar 2020 00:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgC1XYQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Mar 2020 19:24:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33905 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgC1XYP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Mar 2020 19:24:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so6188731pgl.1
        for <linux-ext4@vger.kernel.org>; Sat, 28 Mar 2020 16:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=DybGt/aLklu8RKi7knmW4OfNcLLWZhmmt2tZ6YCw5H4=;
        b=dy2onVBJbVk/yybJVI7D7TS9B1MMy7jbCtOuHk+b1AkMbtkySEtz3j982wfk+ChVrz
         1j+C1rYdcrBjPAxq3y0KCJBcsOVEYsST9IY3MPWn0GlyQIz5MBhhtfmaXpGkFO1+1Vf4
         lxP/wWYlgSZofOwW0H4k+SgbhYh+tLYcc+jxLjbrKQOKEFU0vyaMxsUbkIY/6MPimi7H
         9fcrFodm0rtYoMPeFDAeRsx/DgnxtJdK1uuHIBRLluQRxRbyYeFpumJ5AJsd36LoJCz5
         0RuD7lQhcw8gUtjN2cYqLyquXwe4SMtqh8Al2qYhCDnuqyN1ivB0UbkakrOeENXgCzmK
         PTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=DybGt/aLklu8RKi7knmW4OfNcLLWZhmmt2tZ6YCw5H4=;
        b=YhX90wDzgw0kdVGyteIpjXnucbiJr+T1VNJeDccE6sUYh3FMIzP2KncTXm9cmhwJhv
         MMzwkX+wReulXIOo+f1e+KOt2AUgZqUzynTwhdYtx4aDyy2l4xlgYm6iFNwmuxz5WK/h
         RCemk7H97AA5pNLJ/dZ9sINVxIONJv6LAPsZzNAD0AJc1JOXue5vZ0uEj2JWiGKjnJ3S
         6cYBXXn4wVRoeW1JZuYp+N+/bOxW5E1zjvcd7BeqnUEH2x/hC61CSeW4bHB7qG8Mn8Rr
         ZxgwO5nS3sCr2IiHndEhD6R2w7JLiwJ0P1J4F7BmEUz0WZw640j5F/6t5gIQnvCZFuGw
         QTaw==
X-Gm-Message-State: ANhLgQ2LXQZb3BbieD62nPI2B+kICIWpAyR5teIY2E5jxt5fNf0R6Cko
        Hf74YPDB4g6uSFeROcMI6NlnLPRVuUc=
X-Google-Smtp-Source: ADFU+vtArzPhX1ttILuqsn/XfwiBpe4kVbhM9/MbUA+kxkazIQFxMqfMA5MCOWjYJ7Spsk5GkH9yAQ==
X-Received: by 2002:a63:cb4a:: with SMTP id m10mr6249463pgi.259.1585437852459;
        Sat, 28 Mar 2020 16:24:12 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y131sm6892196pfb.78.2020.03.28.16.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 16:24:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <34AB07FF-1872-46EB-B7B6-5CE24EFB39C6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D17841AA-B3F2-4A33-946F-C25AFAE866F5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/2] ext4: return lblk from ext4_find_entry
Date:   Sat, 28 Mar 2020 17:24:10 -0600
In-Reply-To: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D17841AA-B3F2-4A33-946F-C25AFAE866F5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> This patch makes ext4_find_entry and related routines to return
> logical block address of the dirent block. This logical block address
> is used in the directory shrinking code to perform reverse lookup and
> verify that the lookup was successful.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
> fs/ext4/namei.c | 54 +++++++++++++++++++++++++++++--------------------
> 1 file changed, 32 insertions(+), 22 deletions(-)

Would it make sense to add the "lblk" field to struct ext4_renament,
rather than adding an extra argument for all of these functions?

Otherwise, the patch looks OK.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> static void ext4_rename_delete(handle_t *handle, struct ext4_renament =
*ent,
> -			       int force_reread)
> +			       int force_reread, ext4_lblk_t lblk)
> {
> 	int retval;
> 	/*
> @@ -3593,7 +3600,8 @@ static void ext4_rename_delete(handle_t *handle, =
struct ext4_renament *ent,
> 		retval =3D ext4_find_delete_entry(handle, ent->dir,
> 						&ent->dentry->d_name);
> 	} else {
> -		retval =3D ext4_delete_entry(handle, ent->dir, ent->de, =
ent->bh);
> +		retval =3D ext4_delete_entry(handle, ent->dir, ent->de, =
ent->bh,
> +					   lblk);
> 		if (retval =3D=3D -ENOENT) {
> 			retval =3D ext4_find_delete_entry(handle, =
ent->dir,
> 							=
&ent->dentry->d_name);
> @@ -3679,6 +3687,7 @@ static int ext4_rename(struct inode *old_dir, =
struct dentry *old_dentry,
> 	struct inode *whiteout =3D NULL;
> 	int credits;
> 	u8 old_file_type;
> +	ext4_lblk_t lblk;
>=20
> 	if (new.inode && new.inode->i_nlink =3D=3D 0) {
> 		EXT4_ERROR_INODE(new.inode,
> @@ -3706,7 +3715,8 @@ static int ext4_rename(struct inode *old_dir, =
struct dentry *old_dentry,
> 			return retval;
> 	}
>=20
> -	old.bh =3D ext4_find_entry(old.dir, &old.dentry->d_name, =
&old.de, NULL);
> +	old.bh =3D ext4_find_entry(old.dir, &old.dentry->d_name, =
&old.de, NULL,
> +				 &lblk);
> 	if (IS_ERR(old.bh))
> 		return PTR_ERR(old.bh);
> 	/*
> @@ -3720,7 +3730,7 @@ static int ext4_rename(struct inode *old_dir, =
struct dentry *old_dentry,
> 		goto end_rename;
>=20
> 	new.bh =3D ext4_find_entry(new.dir, &new.dentry->d_name,
> -				 &new.de, &new.inlined);
> +				 &new.de, &new.inlined, NULL);
> 	if (IS_ERR(new.bh)) {
> 		retval =3D PTR_ERR(new.bh);
> 		new.bh =3D NULL;
> @@ -3817,7 +3827,7 @@ static int ext4_rename(struct inode *old_dir, =
struct dentry *old_dentry,
> 		/*
> 		 * ok, that's it
> 		 */
> -		ext4_rename_delete(handle, &old, force_reread);
> +		ext4_rename_delete(handle, &old, force_reread, lblk);
> 	}
>=20
> 	if (new.inode) {
> @@ -3900,7 +3910,7 @@ static int ext4_cross_rename(struct inode =
*old_dir, struct dentry *old_dentry,
> 		return retval;
>=20
> 	old.bh =3D ext4_find_entry(old.dir, &old.dentry->d_name,
> -				 &old.de, &old.inlined);
> +				 &old.de, &old.inlined, NULL);
> 	if (IS_ERR(old.bh))
> 		return PTR_ERR(old.bh);
> 	/*
> @@ -3914,7 +3924,7 @@ static int ext4_cross_rename(struct inode =
*old_dir, struct dentry *old_dentry,
> 		goto end_rename;
>=20
> 	new.bh =3D ext4_find_entry(new.dir, &new.dentry->d_name,
> -				 &new.de, &new.inlined);
> +				 &new.de, &new.inlined, NULL);
> 	if (IS_ERR(new.bh)) {
> 		retval =3D PTR_ERR(new.bh);
> 		new.bh =3D NULL;
> --
> 2.25.1.696.g5e7596f4ac-goog
>=20


Cheers, Andreas






--Apple-Mail=_D17841AA-B3F2-4A33-946F-C25AFAE866F5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5/3JoACgkQcqXauRfM
H+BrNA/+KHU0JftNZYfkXn6XZVHCfvVfzNltLUG8DANiSfoiD4O3LjPiZT9/OFAn
5tkYfw05zCKBWvh0gcJ9SIjZHBrthvqCwDVQY6hXtM4JVTZa5xiZDHsSFCIgyBNs
j7ku8rP4ABVFMnmIKiP1UpbMix02xXkMTdsHLaDu0KVKQVenGMNp5KbBq8c9naAh
bX4kiXvoavrRXPsM9NKVyR7HXVsuSDFSpoHgyGsMzU5NMYLKwIqYIOvYI2irqfUv
KIm+u4JzX6xwAFBYX0z97kofNg1Rq5sjqUTKeKFr9A70shvhDzysTwrF0OLAZ7G9
k4nePYlz9jnWyvvWvQjlKHVJPI7qq5HZPCrRb6rCB6G2xtNtRWLZXfBkgKvpWIbp
zYLTUVTm/O4GzsJnLX4fQ3zkAnb7n2lTmQHJZqB9fnI7KY25qfYK51ndYG+SZyJc
rhrpr2HKh3Xrs1TWHCNl8NzkFNzOdmThOzhJ3lpYxtv0TDVE2OBXfhIPlMtj5Hu6
SaPhmol3NNIqZDN0grywHea0Ozl3HWwhBBABLYIwj6KLax6EgGXhjPNJj+TSXPgC
YEKFSMN+G6s+WhCWe+tdptWhuQjlHAvelA03Dt7P98XNW1P1JRMMkBhfBYm5qJlR
ClYtV5oOl0XlxbisMbWd5YxWx89PICd98e00ITUmk+pBA9rK2YA=
=MyI9
-----END PGP SIGNATURE-----

--Apple-Mail=_D17841AA-B3F2-4A33-946F-C25AFAE866F5--
