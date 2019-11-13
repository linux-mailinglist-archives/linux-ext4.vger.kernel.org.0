Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C86D0FBAA2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Nov 2019 22:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKMVZN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Nov 2019 16:25:13 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45306 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfKMVZN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Nov 2019 16:25:13 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so2491016pfn.12
        for <linux-ext4@vger.kernel.org>; Wed, 13 Nov 2019 13:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xxrpTocA7Arl+pu/JhJptg8YHwGpBKD/mYlLNOaJphY=;
        b=TZQoeHED5Os20pjbZbRYVkulkFWgn4rDW+pc4WTgOq/eSxEhkVfb0/OVZFodlRoqc5
         +o9RaFeuRmImkiaKTAMfAahLs3JCUo8Wd9jIpdZ6ePNol7dVHEPH5+a4vHzIAUxsUoOj
         QvfKwPhFyhAa9nKoXDf4mwgNQcZJCzJV0OkAqpoXjYBGN076LL1m6EYTMNCkbKH1dEfC
         yBa64V2+fmkMirdFOlcLdADE/10b7rxeUkh58vYbwzYF0ZzMe7L3KcFkckZl0+qIkijh
         wkWaH1FJhuD60nq3aiJVXjks5A29B/YIPjGAjpp26IJpYdRxwJMCI0WD7SnS8vcKeKh9
         do3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xxrpTocA7Arl+pu/JhJptg8YHwGpBKD/mYlLNOaJphY=;
        b=frIYEeJEqmNaJFTsh1+7umJJXJ9tkhnUdJIsNLI+s7jxh3eu5O4YWpmDTKz/sYWy24
         e1oEnzSetcpaPI9v52EzNgcL6zcqTNnG9AzinVnbI1iK3zwi64rby2XGocy2wy9OhfXy
         mrV0g8tmdr0/4Ln5z8eFnYPdX389LLqdaNlC0XV6BjA+Rt9cnMzu0qEjG1qQEA2r72zc
         NDsYo4BQYLjVeh4R6FI+ut2beoI7DCGErdmJKvDY0tdQV0dclSRoKbwtc4+CwomJcS9w
         yi0mgmblKYvoasUnQrhLtnoivhH0VrsNZlkSvJ4GM+j0IFC2g+3prTxMzeLhy+gKmPI4
         NJKA==
X-Gm-Message-State: APjAAAWJYI0Gae29K5cE72AeHs/UatD0zvClak7bXHD9xTprCVnRF4CD
        4vMuoeYuP8mJZFacVSbPgiI8SA==
X-Google-Smtp-Source: APXvYqzEObJZ0P1CRNByLUWvio0DjJ9OVuZZc9XIkv9Qm5QlogdfRhMPlYkf5jS9OI8q3Q5yfTK5/w==
X-Received: by 2002:a17:90a:d204:: with SMTP id o4mr2253860pju.40.1573680312067;
        Wed, 13 Nov 2019 13:25:12 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id r15sm4279122pfh.81.2019.11.13.13.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:25:11 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <30E5EDB7-7C38-4EBB-946A-E6C1E03AC80E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_188C6787-0DFE-44CA-BB7E-0E9473AE6131";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: work around deleting a file with i_nlink == 0
 safely
Date:   Wed, 13 Nov 2019 14:25:28 -0700
In-Reply-To: <20191112032903.8828-1-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        stable@kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <20191112032903.8828-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_188C6787-0DFE-44CA-BB7E-0E9473AE6131
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 11, 2019, at 8:29 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> If the file system is corrupted such that a file's i_links_count is
> too small, then it's possible that when unlinking that file, i_nlink
> will already be zero.  Previously we were working around this kind of
> corruption by forcing i_nlink to one; but we were doing this before
> trying to delete the directory entry --- and if the file system is
> corrupted enough that ext4_delete_entry() fails, then we exit with
> i_nlink elevated, and this causes the orphan inode list handling to be
> FUBAR'ed, such that when we unmount the file system, the orphan inode
> list can get corrupted.
>=20
> A better way to fix this is to simply skip trying to call drop_nlink()
> if i_nlink is already zero, thus moving the check to the place where
> it makes the most sense.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D205433
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> Cc: stable@kernel.org
> ---
> fs/ext4/namei.c | 11 +++++------
> 1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a67cae3c8ff5..a856997d87b5 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -3196,18 +3196,17 @@ static int ext4_unlink(struct inode *dir, =
struct dentry *dentry)
> 	if (IS_DIRSYNC(dir))
> 		ext4_handle_sync(handle);
>=20
> -	if (inode->i_nlink =3D=3D 0) {
> -		ext4_warning_inode(inode, "Deleting file '%.*s' with no =
links",
> -				   dentry->d_name.len, =
dentry->d_name.name);
> -		set_nlink(inode, 1);
> -	}
> 	retval =3D ext4_delete_entry(handle, dir, de, bh);
> 	if (retval)
> 		goto end_unlink;
> 	dir->i_ctime =3D dir->i_mtime =3D current_time(dir);
> 	ext4_update_dx_flag(dir);
> 	ext4_mark_inode_dirty(handle, dir);
> -	drop_nlink(inode);
> +	if (inode->i_nlink =3D=3D 0)
> +		ext4_warning_inode(inode, "Deleting file '%.*s' with no =
links",
> +				   dentry->d_name.len, =
dentry->d_name.name);
> +	else
> +		drop_nlink(inode);
> 	if (!inode->i_nlink)
> 		ext4_orphan_add(handle, inode);
> 	inode->i_ctime =3D current_time(inode);
> --
> 2.23.0
>=20


Cheers, Andreas






--Apple-Mail=_188C6787-0DFE-44CA-BB7E-0E9473AE6131
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3MdMgACgkQcqXauRfM
H+DR0Q//XzH+Qdyt5ed5C8OxvwaGNPMzHHQhfjzUGSXd/Val5t++Ev7ipvkY5Omq
mmrtYZgA9gtx4eY6GEOVGSQOy+4AeAxuOdFQseR/DiKZ5Vo0pylIKujGPzA/IgoK
ITc37K/akz7ayi6rGrMCcUH8dh9lHOyK01U9LKmfLrZXQNYp33edzKwHrh9RtonB
6wJfcFzfLeoTHIcwFzKCl7QCL94eNztOGe1nt0Vb5tJZYZD92Z/bj1ukYwusP0z7
FytdzwGBljSsw0RZxzJPiH8J1sOFXQn4tJedM9FdRZpL4H8ZZsZxvVQCba89u3nU
BqCvh8yCkFW+RN6xBkMzCM/Wry1T663mhTXDKT/6/+NJavg1asJGWu/bc+DctTBz
hwNXvH0/ImDkCRyPzoMsHWvVlDTiceF4F70vBKwb7rKS9PSzdcGfnEXE8Z968Czd
FZDrWplUS9wbSCDxBeswnG0flfzHnjo7N/FT7vgQyjJjAJh4b57Z+xpyvE4mFovG
z95nSS2F1F75iKM5jnfDOWwocD7ynEIyweZd/EZ+UAdCDA5HvKBf9GDKhmYxGeV0
p0luFgRrYgGUIHRjvq3YHuVKNFhnCR1lnjU/DclqlKjQKWOYHRQ3dlsmITtNeD8u
aqMwzMkyfsbL8hCVKH5+VaKNrBdpS1yosy4SR++jdd+XKgn014M=
=X65q
-----END PGP SIGNATURE-----

--Apple-Mail=_188C6787-0DFE-44CA-BB7E-0E9473AE6131--
