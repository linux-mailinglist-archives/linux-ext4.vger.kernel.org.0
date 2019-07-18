Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 717A76C944
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2019 08:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGRGZt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jul 2019 02:25:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40750 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfGRGZt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jul 2019 02:25:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so12380217pgj.7
        for <linux-ext4@vger.kernel.org>; Wed, 17 Jul 2019 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9T9/Jnsjj+C2IBXsZxElZoCvTStJARtkBTET10cnBUU=;
        b=dGohIK9GVJa5aOyfm0g3K2sCseFziIfx9UlSg1iQ3XN8ikisb6DnpM3kcdUGvTNwsw
         0ew/hR5OeIPrUsDo1lzffV5focfZYWFeBSIh1MbTeGSkYQY9K4uZIzJpyX0xIegKXlHF
         Ofv7EbsI9YfomPfGH5Ut8N+LgQZMnKL3Ryxf72U5kl6S18uOxfmM7CTfudbMfmf0/Cin
         FCezB0mEFsYkEcJl+t7jgGaqDJEJpcS318sstmqVulCYjFupbNEWGaPT4uJYsMtnlvqC
         aL0Qma2r2EdgzBQlzLSk/IzwNDI9rcS6RUL76ZD/zaBfrT8jhWo+tBHGajjG//iRQn2O
         JQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9T9/Jnsjj+C2IBXsZxElZoCvTStJARtkBTET10cnBUU=;
        b=fEVjQHbEz5eyAW1CB8NDM8vFnqEM39hSuWdUBBDCJpW7dq5xQLDbO9wzz0akAsFTjU
         CkloKGneGdJDswtow4a2kV0qu97vWJIoxFD4aHcULmwsFnkT1cml1wsaL+TzVNudwBJ4
         09vlCCG/yx7AaLKEpy8Vx9+OVrvKekKKOku77QQ7mKhGFuHFcnIBEHIsjssdYbVxChqK
         lxBneh0sLkttrqC+CssapiSvHgypfznNaf5DKvz2gAqLDhthtDtnvWDJjbsNqNFdn7FD
         FNyG/2nQFaooaSyUBbK0mIIyPYAd18X7I+Hsf5DHfIycXJGnSn1VN1VevuRVUre9q0mo
         WQIw==
X-Gm-Message-State: APjAAAWw2iSszlH4CK7wj3PQVGzNnL0SV6yz1/kCpcHhekw+0r4btFsR
        XwE8CtqBuUN2BZk15UxLSB4=
X-Google-Smtp-Source: APXvYqxwpwvpvb+EvUyNQXbdghCHxSZr0VS5xNKqNxJv02LAzFTaClt+atqKFEkbqh80pJFEmUyITw==
X-Received: by 2002:a17:90a:8c06:: with SMTP id a6mr50032888pjo.45.1563431148678;
        Wed, 17 Jul 2019 23:25:48 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id f3sm41074490pfg.165.2019.07.17.23.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 23:25:47 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D9B442DB-51C2-4AAC-8113-AE462E7DA637@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5BC3AC0D-AC2B-4712-BDD5-373BA2675BCC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] e2fsck: check for consistent encryption policies
Date:   Thu, 18 Jul 2019 00:25:42 -0600
In-Reply-To: <20190718011325.19516-1-ebiggers@kernel.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fscrypt@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20190718011325.19516-1-ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_5BC3AC0D-AC2B-4712-BDD5-373BA2675BCC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 17, 2019, at 7:13 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>=20
> From: Eric Biggers <ebiggers@google.com>
>=20
> By design, the kernel enforces that all files in an encrypted =
directory
> use the same encryption policy as the directory.  It's not possible to
> violate this constraint using syscalls.  Lookups of files that violate
> this constraint also fail, in case the disk was manipulated.
>=20
> But this constraint can also be violated by accidental filesystem
> corruption.  E.g., a power cut when using ext4 without a journal might
> leave new files without the encryption bit and/or xattr.  Thus, it's
> important that e2fsck correct this condition.
>=20
> Therefore, this patch makes the following changes to e2fsck:
>=20
> - During pass 1 (inode table scan), create a map from inode number to
>  encryption xattr for all encrypted inodes.  If an encrypted inode has
>  a missing or clearly invalid xattr, offer to clear the inode.
>=20
> - During pass 2 (directory structure check), verify that all regular
>  files, directories, and symlinks in encrypted directories use the
>  directory's encryption policy.  Offer to clear any directory entries
>  for which this isn't the case.
>=20
> Add a new test "f_bad_encryption" to test the new behavior.
>=20
> Due to the new checks, it was also necessary to update the existing =
test
> "f_short_encrypted_dirent" to add an encryption xattr to the test =
file,
> since it was missing one before, which is now considered invalid.
>=20
> Google-Bug-Id: 135138675
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
> index 2d359b38..10dcb582 100644
> --- a/e2fsck/e2fsck.h
> +++ b/e2fsck/e2fsck.h
> @@ -135,6 +135,22 @@ struct dx_dirblock_info {
> #define DX_FLAG_FIRST		4
> #define DX_FLAG_LAST		8
>=20
> +/*
> + * The encrypted file information structure; stores information for =
files which
> + * are encrypted.
> + */
> +struct encrypted_file {
> +	ext2_ino_t ino;
> +	void *xattr_value;
> +	size_t xattr_size;
> +};

This structure is pretty memory inefficient.  4 byte ino, 8 bytes =
pointer, then a
8 byte size. I don't think that we need a full size_t to store a valid =
xattr size,
given that is limited to 64KB currently, while size_t is an unsigned =
long.

It would save 8 bytes per inode to rearrange these, and add a unique =
prefix to make
the fields easier to find:

struct e2fsck_encrypted_file {
	ext2_ino_t   eef_ino;
	unsigned int eef_xattr_size;
	void        *eef_xattr_value;
};

> +struct encrypted_files {
> +	size_t count;
> +	size_t capacity;
> +	struct encrypted_file *files;
> +};

Searching for "encrypted_file" vs. "encrypted_files" is not great.  =
Maybe
"e2fsck_encrypted_(file_)list" or "e2fsck_encrypted_(file_)array"?  As =
above,
better to have a prefix for these structure fields, like "eel_" or =
"eea_".

> +int add_encrypted_file(e2fsck_t ctx, struct problem_context *pctx)
> +{
> +	pctx->errcode =3D get_encryption_xattr(ctx, ino, =
&file->xattr_value,
> +					     &file->xattr_size);
> +	if (pctx->errcode) {
> +		if (fix_problem(ctx, PR_1_MISSING_ENCRYPTION_XATTR, =
pctx))
> +			return -1;

At this point, you don't really know if the inode _should_ be encrypted,
or if it is a stray bit flip in the EXT4_ENCRYPT_STATE that resulted in
add_encrypted_file being called.  This results in the inode being =
deleted,
even though it is possible that it was never encrypted.  This =
determination
should be made later when the inode's parent directory is known.  Either
the parent also has an encryption flag+xattr and it _should_ have been
encrypted and should be cleared, or the parent doesn't have an =
encryption
flag+xattr and only the child inode flag should be cleared...

> +	} else if (!possibly_valid_encryption_xattr(file->xattr_value,
> +						    file->xattr_size)) {
> +		ext2fs_free_mem(&file->xattr_value);
> +		file->xattr_size =3D 0;
> +		if (fix_problem(ctx, PR_1_CORRUPT_ENCRYPTION_XATTR, =
pctx))
> +			return -1;
> +	}


I can see in this case, where the inode is flagged and the encryption =
xattr
exists (named "c" if I read correctly?), but is corrupt, then there =
isn't
much to do for the file.

> @@ -1415,18 +1478,21 @@ skip_checksum:
> 			}
>=20
> -		if (encrypted && (dot_state) > 1 &&
> -		    encrypted_check_name(ctx, dirent, &cd->pctx)) {

No need for () around "dot_state".


Cheers, Andreas






--Apple-Mail=_5BC3AC0D-AC2B-4712-BDD5-373BA2675BCC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0wEOcACgkQcqXauRfM
H+DiRg//SLlG922tFzGlKJkI1k2V9F1ocpL42Op21Lw4U7SsYjkxa53nmbPMIPH2
G5g7RM2OASe3X5nkkq+IFjUH53b+k4Gkf4qYt2oUBl60cRza3GX4S5+R5qfDLGog
0trXjJWIiw4AbQ/VAB3khX1bmaRABzXhEB50eMkcMk2xDrul0bwSV2TTzu4UrcNJ
mm4oCoRTjVIREJGWjsazYxfFP0UJVFDkuCTr68TJm24pDx8asI9pyZ8h1saLxCEW
uVuyNk3YXzOEVSm+LyYk84NW34dmftX2c40LxXuy5FE9lqyz4OKEBoxpzqLG1JDM
FvxIX1AbDkExJzgFnoH12O8G6TPl24iHgO65KaBqGPg+D/4WGAor7pousF5zElAf
AW263wkkc87fpnDiN8qmwp3gzP03B6HthJUmrZDpZ8G32S/oFUNtNRFKl+BKLjHy
jk3XwCiTW3udXfdngi/ctRc+ydtudGbnc0QjMP1F0Mf0TH/jevnvRLNCvGY2f6D9
fkLAtbsqjaWRnXxC8MR58FsnL7M4pxWgORy6Y6oSlWrPDTIu9ldrjEPTwI0P6UJp
+EWiK8DDDa4ryDdBwPSLiAjrHSL6Hn7O5OtqJSIK37ZnEeoGLQptbI1It9I+6M8Q
ar+bNwZ1rwo6AVQtHz0+HQ4Gc20WSKIX6XX94NyHPqs3jbrM39A=
=u0Er
-----END PGP SIGNATURE-----

--Apple-Mail=_5BC3AC0D-AC2B-4712-BDD5-373BA2675BCC--
