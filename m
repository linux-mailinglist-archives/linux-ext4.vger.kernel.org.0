Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CA2C7B83
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 22:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgK2V6Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 16:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2V6Q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 16:58:16 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077B8C0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:57:30 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id q3so1123368pgr.3
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 13:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=F0eOK7D3eKoR9gMz8uloSvvTJbF+St4TB1uZItUXXZo=;
        b=E9PSDYC40b97vkGNWGp6i5gdYA2gYWA2XQUlDb8HEyJT+DRUbBivnwZ7JaHxVI8tpv
         o7ZVMBtqiY+nvx9W/ENFx9g+xFGo7oJjs4mbqhL3iCMX7tEDr1dCuvzIqsxlrz6a17R/
         gt9y6HnaBRwOyeAUHIsv+wKPSTpNbGCbO2UWrn317GXpcsgS9h2dq+c3o4zz+XtoKLtw
         HP+tI0moQQayd5TD8V/rubfun99/rZSxYKkOowZQaVf7Ow6TyNukaGf9H0/rA2dceDns
         nlc0+0hBOVsNqi1ZhQEwKARDQTUVOyVmjE9yuP1W5fYCP3IDB+XA1rIMr9v0uMdZ4J2v
         ocIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=F0eOK7D3eKoR9gMz8uloSvvTJbF+St4TB1uZItUXXZo=;
        b=hS9u9+sBvnHSCO2gPgLlaXQrLcAN5cT5arl//3YWZOe59zBiq1fhg+6zP2Ggs9Gu9e
         1PRhD8H1P9QFeG33O+hDiwBevUubVCmdx7/jHqbj203Yq2dh1g3qFuR0Xx5fTG5LDo2y
         d79aWyD9Dcv4VzcPAu5udovo9F2Jup+aZPOC/pnEMf/0Nfj4+C1ob3FBDEer3wc8pBE6
         QQR4ojGSjclufCAz10Nco2bXQnca/m6AOjrad0WMo6Hu6XIwMJ4RWuxlqWz8hNX+3XxK
         fJhLf0Xrx5tJQQCPLVLsBWqoEVaSUpKtxb0EMu8IYMn3t9kkWqwc95KpyEJhKhFaGkwX
         LVTQ==
X-Gm-Message-State: AOAM533CCGHsRlWJCFhwlNl6vYuML2GpGh4WXDA5GtDywIkUN3OkYJnG
        hM9XKGJPszNptJbvkquUD5rrNg==
X-Google-Smtp-Source: ABdhPJwvKyH81EsvtU0WHlbUI8bqD8Qt/UjF1Qqo+FGWI1fhzLVne5aJG2E+SWRgRIwTPLMTbFh1Iw==
X-Received: by 2002:a62:52d7:0:b029:18b:7093:fb88 with SMTP id g206-20020a6252d70000b029018b7093fb88mr15784836pfb.76.1606687049514;
        Sun, 29 Nov 2020 13:57:29 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id t19sm1674859pgk.86.2020.11.29.13.57.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 13:57:28 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <CA656726-A5EA-4D72-9C40-95933085354A@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A337D44F-FFFD-42EC-AC8F-C2FF575732E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 06/12] ext4: Simplify ext4 error translation
Date:   Sun, 29 Nov 2020 14:57:26 -0700
In-Reply-To: <20201127113405.26867-7-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-7-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A337D44F-FFFD-42EC-AC8F-C2FF575732E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> We convert errno's to ext4 on-disk format error codes in
> save_error_info(). Add a function and a bit of macro magic to make =
this
> simpler.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

In hindsight, it would have been better (IMHO) if the EXT4_ERR_* values =
mapped
to the standard x86_64 errors in errno.h, since that is what most =
admins/users
are familiar with (e.g. 5 =3D EIO, 12 =3D ENOMEM, 28 =3D ENOSPC, 30 =3D =
EROFS).  That
would avoid the need to look up the EXT4_ERR_* values, since it doesn't =
look
like dumpe2fs even handles these fields yet.

I guess I never noticed the original patch when it was submitted, so =
water under
the bridge, I guess...

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 95 =
++++++++++++++++++++++++---------------------------------
> 1 file changed, 40 insertions(+), 55 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 7948c07d0a90..8add06d08495 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -551,76 +551,61 @@ static bool system_going_down(void)
> 		|| system_state =3D=3D SYSTEM_RESTART;
> }
>=20
> +struct ext4_err_translation {
> +	int code;
> +	int errno;
> +};
> +
> +#define EXT4_ERR_TRANSLATE(err) { .code =3D EXT4_ERR_##err, .errno =3D =
err }
> +
> +static struct ext4_err_translation err_translation[] =3D {
> +	EXT4_ERR_TRANSLATE(EIO),
> +	EXT4_ERR_TRANSLATE(ENOMEM),
> +	EXT4_ERR_TRANSLATE(EFSBADCRC),
> +	EXT4_ERR_TRANSLATE(EFSCORRUPTED),
> +	EXT4_ERR_TRANSLATE(ENOSPC),
> +	EXT4_ERR_TRANSLATE(ENOKEY),
> +	EXT4_ERR_TRANSLATE(EROFS),
> +	EXT4_ERR_TRANSLATE(EFBIG),
> +	EXT4_ERR_TRANSLATE(EEXIST),
> +	EXT4_ERR_TRANSLATE(ERANGE),
> +	EXT4_ERR_TRANSLATE(EOVERFLOW),
> +	EXT4_ERR_TRANSLATE(EBUSY),
> +	EXT4_ERR_TRANSLATE(ENOTDIR),
> +	EXT4_ERR_TRANSLATE(ENOTEMPTY),
> +	EXT4_ERR_TRANSLATE(ESHUTDOWN),
> +	EXT4_ERR_TRANSLATE(EFAULT),
> +};
> +
> +static int ext4_errno_to_code(int errno)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(err_translation); i++)
> +		if (err_translation[i].errno =3D=3D errno)
> +			return err_translation[i].code;
> +	return EXT4_ERR_UNKNOWN;
> +}
> +
> static void __save_error_info(struct super_block *sb, int error,
> 			      __u32 ino, __u64 block,
> 			      const char *func, unsigned int line)
> {
> 	struct ext4_super_block *es =3D EXT4_SB(sb)->s_es;
> -	int err;
>=20
> 	EXT4_SB(sb)->s_mount_state |=3D EXT4_ERROR_FS;
> 	if (bdev_read_only(sb->s_bdev))
> 		return;
> +	/* We default to EFSCORRUPTED error... */
> +	if (error =3D=3D 0)
> +		error =3D EFSCORRUPTED;
> 	es->s_state |=3D cpu_to_le16(EXT4_ERROR_FS);
> 	ext4_update_tstamp(es, s_last_error_time);
> 	strncpy(es->s_last_error_func, func, =
sizeof(es->s_last_error_func));
> 	es->s_last_error_line =3D cpu_to_le32(line);
> 	es->s_last_error_ino =3D cpu_to_le32(ino);
> 	es->s_last_error_block =3D cpu_to_le64(block);
> -	switch (error) {
> -	case EIO:
> -		err =3D EXT4_ERR_EIO;
> -		break;
> -	case ENOMEM:
> -		err =3D EXT4_ERR_ENOMEM;
> -		break;
> -	case EFSBADCRC:
> -		err =3D EXT4_ERR_EFSBADCRC;
> -		break;
> -	case 0:
> -	case EFSCORRUPTED:
> -		err =3D EXT4_ERR_EFSCORRUPTED;
> -		break;
> -	case ENOSPC:
> -		err =3D EXT4_ERR_ENOSPC;
> -		break;
> -	case ENOKEY:
> -		err =3D EXT4_ERR_ENOKEY;
> -		break;
> -	case EROFS:
> -		err =3D EXT4_ERR_EROFS;
> -		break;
> -	case EFBIG:
> -		err =3D EXT4_ERR_EFBIG;
> -		break;
> -	case EEXIST:
> -		err =3D EXT4_ERR_EEXIST;
> -		break;
> -	case ERANGE:
> -		err =3D EXT4_ERR_ERANGE;
> -		break;
> -	case EOVERFLOW:
> -		err =3D EXT4_ERR_EOVERFLOW;
> -		break;
> -	case EBUSY:
> -		err =3D EXT4_ERR_EBUSY;
> -		break;
> -	case ENOTDIR:
> -		err =3D EXT4_ERR_ENOTDIR;
> -		break;
> -	case ENOTEMPTY:
> -		err =3D EXT4_ERR_ENOTEMPTY;
> -		break;
> -	case ESHUTDOWN:
> -		err =3D EXT4_ERR_ESHUTDOWN;
> -		break;
> -	case EFAULT:
> -		err =3D EXT4_ERR_EFAULT;
> -		break;
> -	default:
> -		err =3D EXT4_ERR_UNKNOWN;
> -	}
> -	es->s_last_error_errcode =3D err;
> +	es->s_last_error_errcode =3D ext4_errno_to_code(error);
> 	if (!es->s_first_error_time) {
> 		es->s_first_error_time =3D es->s_last_error_time;
> 		es->s_first_error_time_hi =3D es->s_last_error_time_hi;
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_A337D44F-FFFD-42EC-AC8F-C2FF575732E5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EGUcACgkQcqXauRfM
H+CpvQ/7BRcRmA07Jf/mrBHztdMfpi2HC2ZQH1iuRL0JQOaRX7Xu2kta3VLmWRlm
BmGiw0WwT5icfNOJgw9jlvRg4LP9QwZSK1wc///vxJth0/iJcjlqZfy7Owu1BIpD
qnx8AvdhT1WWVx02VcCRXAksCFBCl73XPMmdHsDRAQE7lFXuxXgOWTE5Slb2hPS6
1ZRVdcKxm+hw8fEQxx5vgonUMA7IwcnsoPvNnuZqi8kAZ0RydWypiMR0xe/K5LHa
BcQn+4O6U+a59iI1cFKuvgt35PkkYnP88ZWJGLz3frKbReJtpHE6sMI4sq718Dsl
UIVrn2liOTWQKiZnzkVm1STGmP+wpxCpL0AQT7haG1WA58GZgHJ4MN0azwF/P65K
VZ0vT0jjh7CDYYdRhYdH79cMUgwHmnFKiaOzrr+5PlS7eoHtPOROz7BA1U7bS8e4
eUpDSZqJvIHtmd3mu6Pa4Kq/3LUoUWWsGVXeSFeZ1kP+Ms1fSPbhrHPsLqUX0dsn
njXVEwk6skprGnbMI+gg7/DsjWl6U3EW0xVU5zQhSqvhZTVGCTEUL67epm7342kS
k2E79UXRe2JYc1F2N5HEVRPIT4576Lunlp9bVcUTYodL+l9GvAIEqW/6dYQzhXTt
dblI4g2qmWe8lFxwRvj/WuBesrXDWeY/1EIPt6qlKPGuVNNLsWQ=
=CSRK
-----END PGP SIGNATURE-----

--Apple-Mail=_A337D44F-FFFD-42EC-AC8F-C2FF575732E5--
