Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6426D2C7BA6
	for <lists+linux-ext4@lfdr.de>; Sun, 29 Nov 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgK2WOk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 Nov 2020 17:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgK2WOk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 Nov 2020 17:14:40 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70198C0613CF
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:13:54 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id l1so5379749pld.5
        for <linux-ext4@vger.kernel.org>; Sun, 29 Nov 2020 14:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0E/3RQ1fTdNRlAc+fuAofLzgG/dssigPR72A1EL4lI8=;
        b=CALVwZQHf1vttj3EpoQPP+y7Bw9B0Hye2tIn/TLdh29Tbr0ywAcKxwioNOV8yyMfF8
         HZZ9YCUfjbUR+PuW6RH88J/J39kouRNQdLm8H4+gzPrjSDymxFi3OqEExqgAaCpxhkOD
         zue3/a7M9EvCvHeOytEWEJYLLthwNO51eylBY4pP+q6UYd0INd86K0VW/ca/Rz40YsVU
         gcaHrc/azL3qCehP4n57waqtzPlptG5ZYfJEmIDTQpQntToBSLWtkHH/cC5M/nA3ycsP
         OGMcv/mdHWwp4NqYOf69vpIkdKZjKYm1N+bIPWbs/ds+7s+vltBPqyCDH1zCK25AVwEV
         Q9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0E/3RQ1fTdNRlAc+fuAofLzgG/dssigPR72A1EL4lI8=;
        b=Q1rIH3upV7VV67BiCMXQLjG6j0+DPKQky9MHAxBSPNzfSAvRZwo8ToG0xo5VR3vlCI
         zqA32zRq3svn/+LThYtdn38RATSPJD8rqdctjGVtSs+ZuFzUc70c4eJu1son6Rttz4iE
         J/mr7K+zTJ5VwRpvk27rAR6P1nmUl6fotFn1ABC4F9fiBNp8X9Qj++kpXEDG31Oxfmtw
         jItkaM5KFLtJ3jEsjv0YaseutLc04V8MlH15bBdePdh6HWYRJQaFjXu73osILiAYiW4q
         Ou2M/DtfL3HzenDt9fVp9LFLXgW+uG3p1hSgVClJLFKpHyVt0EUs7Lxu4AeaEmMRj/qw
         BMvg==
X-Gm-Message-State: AOAM533Qdi2NlFBLqVN0wRCYkGztYjEMaeh950cUqX0vduJL5T3QhQB9
        iILy31eCHWSNNNZGFK7Tozqm6A==
X-Google-Smtp-Source: ABdhPJylRwo22m7UZ0UzOPOMCYcPybWW+B/U+JDmSU56DgIUMBlpusQqSPBGADnq7u9NZL7yGhKutg==
X-Received: by 2002:a17:90a:34cb:: with SMTP id m11mr22399060pjf.181.1606688033997;
        Sun, 29 Nov 2020 14:13:53 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k17sm19902348pji.50.2020.11.29.14.13.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 14:13:53 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3D0D6321-5CFD-4AE0-B88D-B8ED12F97739@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C262FF56-6A88-4357-9BAB-C8F06E08B972";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 05/12] ext4: Move functions in super.c
Date:   Sun, 29 Nov 2020 15:13:51 -0700
In-Reply-To: <20201127113405.26867-6-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201127113405.26867-1-jack@suse.cz>
 <20201127113405.26867-6-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C262FF56-6A88-4357-9BAB-C8F06E08B972
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 27, 2020, at 4:33 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Just move error info related functions in super.c close to
> ext4_handle_error(). We'll want to combine save_error_info() with
> ext4_handle_error() and this makes change more obvious and saves a
> forward declaration as well. No functional change.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/super.c | 196 =
++++++++++++++++++++++++++++----------------------------
> 1 file changed, 98 insertions(+), 98 deletions(-)
>=20
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dddaadc55475..7948c07d0a90 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -423,104 +423,6 @@ static time64_t __ext4_get_tstamp(__le32 *lo, =
__u8 *hi)
> #define ext4_get_tstamp(es, tstamp) \
> 	__ext4_get_tstamp(&(es)->tstamp, &(es)->tstamp ## _hi)
>=20
> -static void __save_error_info(struct super_block *sb, int error,
> -			      __u32 ino, __u64 block,
> -			      const char *func, unsigned int line)
> -{
> -	struct ext4_super_block *es =3D EXT4_SB(sb)->s_es;
> -	int err;
> -
> -	EXT4_SB(sb)->s_mount_state |=3D EXT4_ERROR_FS;
> -	if (bdev_read_only(sb->s_bdev))
> -		return;
> -	es->s_state |=3D cpu_to_le16(EXT4_ERROR_FS);
> -	ext4_update_tstamp(es, s_last_error_time);
> -	strncpy(es->s_last_error_func, func, =
sizeof(es->s_last_error_func));
> -	es->s_last_error_line =3D cpu_to_le32(line);
> -	es->s_last_error_ino =3D cpu_to_le32(ino);
> -	es->s_last_error_block =3D cpu_to_le64(block);
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
> -	if (!es->s_first_error_time) {
> -		es->s_first_error_time =3D es->s_last_error_time;
> -		es->s_first_error_time_hi =3D es->s_last_error_time_hi;
> -		strncpy(es->s_first_error_func, func,
> -			sizeof(es->s_first_error_func));
> -		es->s_first_error_line =3D cpu_to_le32(line);
> -		es->s_first_error_ino =3D es->s_last_error_ino;
> -		es->s_first_error_block =3D es->s_last_error_block;
> -		es->s_first_error_errcode =3D es->s_last_error_errcode;
> -	}
> -	/*
> -	 * Start the daily error reporting function if it hasn't been
> -	 * started already
> -	 */
> -	if (!es->s_error_count)
> -		mod_timer(&EXT4_SB(sb)->s_err_report, jiffies + =
24*60*60*HZ);
> -	le32_add_cpu(&es->s_error_count, 1);
> -}
> -
> -static void save_error_info(struct super_block *sb, int error,
> -			    __u32 ino, __u64 block,
> -			    const char *func, unsigned int line)
> -{
> -	__save_error_info(sb, error, ino, block, func, line);
> -	if (!bdev_read_only(sb->s_bdev))
> -		ext4_commit_super(sb, 1);
> -}
> -
> /*
>  * The del_gendisk() function uninitializes the disk-specific data
>  * structures, including the bdi structure, without telling anyone
> @@ -649,6 +551,104 @@ static bool system_going_down(void)
> 		|| system_state =3D=3D SYSTEM_RESTART;
> }
>=20
> +static void __save_error_info(struct super_block *sb, int error,
> +			      __u32 ino, __u64 block,
> +			      const char *func, unsigned int line)
> +{
> +	struct ext4_super_block *es =3D EXT4_SB(sb)->s_es;
> +	int err;
> +
> +	EXT4_SB(sb)->s_mount_state |=3D EXT4_ERROR_FS;
> +	if (bdev_read_only(sb->s_bdev))
> +		return;
> +	es->s_state |=3D cpu_to_le16(EXT4_ERROR_FS);
> +	ext4_update_tstamp(es, s_last_error_time);
> +	strncpy(es->s_last_error_func, func, =
sizeof(es->s_last_error_func));
> +	es->s_last_error_line =3D cpu_to_le32(line);
> +	es->s_last_error_ino =3D cpu_to_le32(ino);
> +	es->s_last_error_block =3D cpu_to_le64(block);
> +	switch (error) {
> +	case EIO:
> +		err =3D EXT4_ERR_EIO;
> +		break;
> +	case ENOMEM:
> +		err =3D EXT4_ERR_ENOMEM;
> +		break;
> +	case EFSBADCRC:
> +		err =3D EXT4_ERR_EFSBADCRC;
> +		break;
> +	case 0:
> +	case EFSCORRUPTED:
> +		err =3D EXT4_ERR_EFSCORRUPTED;
> +		break;
> +	case ENOSPC:
> +		err =3D EXT4_ERR_ENOSPC;
> +		break;
> +	case ENOKEY:
> +		err =3D EXT4_ERR_ENOKEY;
> +		break;
> +	case EROFS:
> +		err =3D EXT4_ERR_EROFS;
> +		break;
> +	case EFBIG:
> +		err =3D EXT4_ERR_EFBIG;
> +		break;
> +	case EEXIST:
> +		err =3D EXT4_ERR_EEXIST;
> +		break;
> +	case ERANGE:
> +		err =3D EXT4_ERR_ERANGE;
> +		break;
> +	case EOVERFLOW:
> +		err =3D EXT4_ERR_EOVERFLOW;
> +		break;
> +	case EBUSY:
> +		err =3D EXT4_ERR_EBUSY;
> +		break;
> +	case ENOTDIR:
> +		err =3D EXT4_ERR_ENOTDIR;
> +		break;
> +	case ENOTEMPTY:
> +		err =3D EXT4_ERR_ENOTEMPTY;
> +		break;
> +	case ESHUTDOWN:
> +		err =3D EXT4_ERR_ESHUTDOWN;
> +		break;
> +	case EFAULT:
> +		err =3D EXT4_ERR_EFAULT;
> +		break;
> +	default:
> +		err =3D EXT4_ERR_UNKNOWN;
> +	}
> +	es->s_last_error_errcode =3D err;
> +	if (!es->s_first_error_time) {
> +		es->s_first_error_time =3D es->s_last_error_time;
> +		es->s_first_error_time_hi =3D es->s_last_error_time_hi;
> +		strncpy(es->s_first_error_func, func,
> +			sizeof(es->s_first_error_func));
> +		es->s_first_error_line =3D cpu_to_le32(line);
> +		es->s_first_error_ino =3D es->s_last_error_ino;
> +		es->s_first_error_block =3D es->s_last_error_block;
> +		es->s_first_error_errcode =3D es->s_last_error_errcode;
> +	}
> +	/*
> +	 * Start the daily error reporting function if it hasn't been
> +	 * started already
> +	 */
> +	if (!es->s_error_count)
> +		mod_timer(&EXT4_SB(sb)->s_err_report, jiffies + =
24*60*60*HZ);
> +	le32_add_cpu(&es->s_error_count, 1);
> +}
> +
> +static void save_error_info(struct super_block *sb, int error,
> +			    __u32 ino, __u64 block,
> +			    const char *func, unsigned int line)
> +{
> +	__save_error_info(sb, error, ino, block, func, line);
> +	if (!bdev_read_only(sb->s_bdev))
> +		ext4_commit_super(sb, 1);
> +}
> +
> /* Deal with the reporting of failure conditions on a filesystem such =
as
>  * inconsistencies detected or read IO failures.
>  *
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_C262FF56-6A88-4357-9BAB-C8F06E08B972
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/EHR8ACgkQcqXauRfM
H+Cmlw/8CQ5SWwyLausIl5PfaJi3oLZSN6dLSz6Rpz0YyHvL/nHOPQZbE6+1+YGU
2HzN7eUHTGNRa0LQe670wEg+VitP7fSmLJwJd6+/M1R+AAuNBicP7dCl4EKtoj+q
Tj/UQOh7sAil9ImbCOdo4ngh1n8qLSftlICBUcqKU8MxDlKVlyfcolyB/FqdevfK
RgXg6tpv7c/NQfWryUBKOJraR0J7YtVs5jpEqq/qJpORv4f4IbdNxOOI2QhMgLdA
DVs4weuzczKKnQlgMvmraHaVKDSzZaaYZ5Dn6SUkT4iLETWvpD5S3NS3J2KoWDu+
44gsQ46WaFO8D8FzrueZ761o1Gp9pckL9PQDMKAeU64/DxRg6jzYcS2KP71EAlrl
Io1Ms0lkMXCLrg8rmMdVirsltNtyrBMZJxc9Mye1Vg/vQ7narNUed9pHNHu6nzKu
9cecC8oSnnrm0w3KQEQsOONMK7pca9SChQImmpV922MpyHoxa/wjnoTBagmC2FeX
oK5/LcuJwszL4HUNKGJq/ZiVsNhc8iLI+fAKXytXkJAGJw73I99ysm4HpxUEOrGs
tL/8TxWeIK8111PrFGATeK2saMOWOOhsZDYtEQEVllnp4XYqYu/wfG+33YZz/9Dn
CLo7ObLJyy2VBivPgX0kVT3jVVmQ3Q7QTXl42SP43HClBJxQ9I8=
=Rb+i
-----END PGP SIGNATURE-----

--Apple-Mail=_C262FF56-6A88-4357-9BAB-C8F06E08B972--
