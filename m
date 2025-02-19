Return-Path: <linux-ext4+bounces-6510-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189D1A3C9D3
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 21:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4519F189BF2A
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2025 20:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411962343C7;
	Wed, 19 Feb 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="x4hoK2L6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D7D23535B
	for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997011; cv=none; b=OAyTsn1Xrh6QS30PXmo43NNSAnixIsqlFGrJqGJAKdqeEUp9oI3FKTgkqABbZD6bOYSRw/NMvQ+EVfzDmUViYIZTyoTzv0cKX9YVxmNLNC5E8FsFG6OYwKHUSqMk93OwQnbh+KsGVYp684eIIsrYNRSEM2LyN6kyYgn4jjtw/rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997011; c=relaxed/simple;
	bh=agcAZTtCPEDR9ECCrPsnTHdYgihI+pNsOVEZfSJB8Eo=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=UEeI/+NnG8V3GsptUQqqgC8IlZlL2h+KeKI3NOBwzdopGFmqnDUDIrudPiheW36nz6zYWXb836ToBuvpzuV/wivt+0u242IZAw+mgbB1TElMHsgmnGE3DEEpMoDBD+n9RBFCTzck4cGPobHBUbUgcs1vHs53/RA2rQourszRkuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=x4hoK2L6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc3027c7aeso430917a91.0
        for <linux-ext4@vger.kernel.org>; Wed, 19 Feb 2025 12:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1739997008; x=1740601808; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IM5/bBKSRhOMp7tRYlIMLz0JTidMots2L+oKVitZ9NA=;
        b=x4hoK2L67hiJ5/nxLq5w9DD90egI32AM1Z/tdnjKjLtf54k4yMtFPqJxk0+DH3/wAB
         TmobDBFQbYn3sKJPTME/h3s29aV00mfugN57E1u3E9PArlaYwIdnguupYxeoqgnvsmnI
         H4g34NNDgugqUJSL/aYh0Lm0uPj7M+BE/tfrcr35Y4Q3Pb2wLMZvTScxW5sFhxFr1jwJ
         M/hwMro+iVHTJMc7L8CLWiEbldopBwi9zv7IPBa2hVYFTrjmBHnO7Ox5WwjfW1bTfKuu
         7dDNpiLpRevN6nGaBasrZtdqbzuHECRV7Q1bsgfemPOL+hVoUj7qsXz/z3xmOz7H0MdY
         5LvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997008; x=1740601808;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IM5/bBKSRhOMp7tRYlIMLz0JTidMots2L+oKVitZ9NA=;
        b=jR2Na6v0HNGD6oo6B7i4OPPwIVWnoS/v0ERfmYeDvjGSHLwx2C+JSgMTJRMkot+p9y
         YxnB1GkuGALca8G9xoH/pzfr+w0WtSdccA5ACTINxNsbQEnwK0vZuheV9fvkkkolwkRC
         4MafjcNMCRbxBP84m+l2byZF14bcN3BsXEvoBlFHOgWseEuswq2D+vHGOZCePV2Gplgn
         JUBCcTf7g8NIBrI29F6jNKsCmv9Ymv60mlFX1zKFYOpF4QWMPESwjBd55X6YZi8lZgHF
         Z3eIBSV6m24+mbd4lblAdYDhsL65XPFdWZc132kDgtvSLwnuoLZTqIebfyzsdtb50ZPR
         9Iew==
X-Gm-Message-State: AOJu0YzQEkvsweifx64Uss+F2Ex5qc1bHdoP6TuhLfQWMcmmS4b7uxCu
	4RjBEmNMfwydjvOZ7MNXwdm/BoTlcJoIZo7aeeLV9rA7ipxFQS1m0PMvqfoF9lE=
X-Gm-Gg: ASbGncvvFBirBnnSAZ8ORZoj11BIolMFXAH2qvFiUlG4YyHCC+9/OGz5jMVbUgM1JO6
	HpN9eORcd9C8VzQz5/7hHEyDvmSR7Tpe0x5vY3ZUw+aZOyDE/XZ+viRf6MYbLb6vGdWaJ/+3rL3
	SjnonRIAmJJpCZiYQza8tGd1+7z4ira6OCRZkEiSgu2fVKF5ECV2cIeog3Lzrd11L28+qvqAfEC
	d5CKshEMXOEyP/9aSVG+wJkBQqQqawZiJu8vTq5OAaTnk7XGbI7EL3dq1/kpXRrxpTmH6r2R0kf
	+lgHQ7ugh6UswnTr2GcjFJ0EoPLy/Jvw5BQL/kMxpuxZs+/4cYaL9xPXF6StrWeB
X-Google-Smtp-Source: AGHT+IFjyy4bfeeo5J0lClyXEb1mZzR3vUQswTGSwjs6tMSREqw+AnsxFGrWJ42gLFa+Kmp5rdKrZg==
X-Received: by 2002:a17:90a:8281:b0:2fc:c262:ef4b with SMTP id 98e67ed59e1d1-2fcc262f032mr4052471a91.18.1739997008279;
        Wed, 19 Feb 2025 12:30:08 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98f0d17sm14691840a91.21.2025.02.19.12.30.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:30:07 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <9ED1B796-23FE-422A-B6C9-5BEAE4FAA912@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_DC74386C-9B2A-45D6-968E-09FF92ACCB06";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -v2] ext4: introduce linear search for dentries
Date: Wed, 19 Feb 2025 13:30:05 -0700
In-Reply-To: <20250213201021.464223-1-tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 krisman@suse.de,
 drosen@google.com
To: Theodore Ts'o <tytso@mit.edu>
References: <20250212164448.111211-1-tytso@mit.edu>
 <20250213201021.464223-1-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_DC74386C-9B2A-45D6-968E-09FF92ACCB06
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Feb 13, 2025, at 1:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> This patch addresses an issue where some files in case-insensitive
> directories become inaccessible due to changes in how the kernel
> function, utf8_casefold(), generates case-folded strings from the
> commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
> points").
>=20
> There are good reasons why this change should be made; it's actually
> quite stupid that Unicode seems to think that the characters =E2=9D=A4 =
and =E2=9D=A4=EF=B8=8F
> should be casefolded.  Unfortimately because of the backwards
> compatibility issue, this commit was reverted in 231825b2e1ff.
>=20
> This problem is addressed by instituting a brute-force linear fallback
> if a lookup fails on case-folded directory, which does result in a
> performance hit when looking up files affected by the changing how
> thekernel treats ignorable Uniode characters, or when attempting to
> look up non-existent file names.  So this fallback can be disabled by
> setting an encoding flag if in the future, the system administrator or
> the manufacturer of a mobile handset or tablet can be sure that there
> was no opportunity for a kernel to insert file names with incompatible
> encodings.

I don't have the full context here, but falling back to a full directory
scan for every failed lookup in a casefolded directory would be *very*
expensive for a large directory.

This could be made conditional upon a much narrower set of conditions:
- if the filename has non-ASCII characters (already uncommon)
- if the filename contains characters that may be case folded =
(normalized?)

This avoids a huge performance hit for every name lookup in very common
workloads that do not need it (i.e. most computer-generated filenames =
are
still only using ASCII characters).

Also, depending on the size of the directory vs. the number of =
case-folded
(normalized?) characters in the filename, it might be faster to do
2^(ambiguous_chars) htree lookups instead of a linear scan of the whole =
dir.

That could be checked easily whether 2^(ambiguous_chars) < dir blocks, =
since
the htree leaf blocks will always be fully scanned anyway once found.  =
That
could be a big win if there are only a few remapped characters in a =
filename.

Cheers, Andreas

>=20
> Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code =
points")
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
> ---
> v2:
>   * Fix compile failure when CONFIG_UNICODE is not enabled
>   * Added reviewed-by from Gabriel Krisman
>=20
> fs/ext4/namei.c    | 14 ++++++++++----
> include/linux/fs.h | 10 +++++++++-
> 2 files changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 536d56d15072..820e7ab7f3a3 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
> 		 * sure cf_name was properly initialized before
> 		 * considering the calculated hash.
> 		 */
> -		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
> +		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
> +		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
> 		    (fname->hinfo.hash !=3D EXT4_DIRENT_HASH(de) ||
> 		     fname->hinfo.minor_hash !=3D =
EXT4_DIRENT_MINOR_HASH(de)))
> 			return false;
> @@ -1595,10 +1596,15 @@ static struct buffer_head =
*__ext4_find_entry(struct inode *dir,
> 		 * return.  Otherwise, fall back to doing a search the
> 		 * old fashioned way.
> 		 */
> -		if (!IS_ERR(ret) || PTR_ERR(ret) !=3D ERR_BAD_DX_DIR)
> +		if (IS_ERR(ret) && PTR_ERR(ret) =3D=3D ERR_BAD_DX_DIR)
> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx =
failed, "
> +				       "falling back\n"));
> +		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
> +			 *res_dir =3D=3D NULL && IS_CASEFOLDED(dir))
> +			dxtrace(printk(KERN_DEBUG "ext4_find_entry: =
casefold "
> +				       "failed, falling back\n"));
> +		else
> 			goto cleanup_and_exit;
> -		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
> -			       "falling back\n"));
> 		ret =3D NULL;
> 	}
> 	nblocks =3D dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2c3b2f8a621f..aa4ec39202c3 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1258,11 +1258,19 @@ extern int send_sigurg(struct file *file);
> #define SB_NOUSER       BIT(31)
>=20
> /* These flags relate to encoding and casefolding */
> -#define SB_ENC_STRICT_MODE_FL	(1 << 0)
> +#define SB_ENC_STRICT_MODE_FL		(1 << 0)
> +#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
>=20
> #define sb_has_strict_encoding(sb) \
> 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
>=20
> +#if IS_ENABLED(CONFIG_UNICODE)
> +#define sb_no_casefold_compat_fallback(sb) \
> +	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
> +#else
> +#define sb_no_casefold_compat_fallback(sb) (1)
> +#endif
> +
> /*
>  *	Umount options
>  */
> --
> 2.45.2
>=20
>=20


Cheers, Andreas






--Apple-Mail=_DC74386C-9B2A-45D6-968E-09FF92ACCB06
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAme2P00ACgkQcqXauRfM
H+CGlg//aaumiF+BISYR5P5V6zZeUI7iNDtRA7jSkeqqbyExMuFtJOQEfwrFJrwn
XXGHc0cyyoWwN9TyBMWCgPu1eJe92qqdHSGfm6oJ1bkXiH9gtV/TZU2QbWIu7j5v
3DyrkzxLBmLqJdp/DnJYxIAAhE91Smjf9Xy7kn/27+LYjDPuwNDEljbMFlmXXkiK
+0gpSEzWFDmRVElUhFMJymP0V3MmqpNs9lCCT261JSZSG5qvnoFnnLbW8W1uoqku
wnalHDdgDYkcY12Zh+JgWaxJtc7vAfUFVco9NYNaOm2usrky1w4w0yEQyRJPsMHP
FNPSseCxqclE8vpvqPQTQiJRmS0iaGpsbLT2uqqsj1AmTCWXQ4lSZBemrHr2cuwy
7Aip6ohlOPY0/ZsxULmN5Ixib3sz33pswxW7OhB3nre1rh3Ox2z8XSUa7XcURhJl
epZ/GkSizu3pKzOdTeSUy9tffPhOBQsHm/QBgp4qi/Kez5bUrs4Anw/uIwit+Im9
+Ip6BK5m/7ykUrBLfuetgNAGnVwV1LErr8HhadiB+bT2DY7RTqZ1oE/uug/CV5xP
PRaI5lAIWkeNTfvgOC0fnyGceg9TaC20B3v8LKznWFncBI5uWYJ1DrDdXJRHkqau
5zDh+TPVQ05xAWASGCMNvyVoz4bqgM2TrrmyDXHmoPlPNdDhREU=
=Vk+z
-----END PGP SIGNATURE-----

--Apple-Mail=_DC74386C-9B2A-45D6-968E-09FF92ACCB06--

