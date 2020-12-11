Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CA12D6F04
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 05:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395283AbgLKELY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 23:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLKEKw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 23:10:52 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3351CC0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 20:10:12 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id lj6so147708pjb.0
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 20:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=6A4UmfSJwWR6cIPWv5R/7cR6eUOyl+SyqLwQoxr+tKg=;
        b=sljbrt6HOSNK8a5GYXdVSgXsYD/Nt14i4DqXvSITCjr2tpCOVuwRwtz2QWxR6CfMt6
         5FErQKbjQLk6djv4FEVIymQXjcu8sNH95K+8sE5cBwcFwNm/uiH4ij01iRXV8rnWFnPN
         T2YDm5lleRrL9i6WVGToUvoO0hJLoHX7BDwCEih5DIru97B4XlNEYhGhXnT+yxP70Vdv
         m+BEb/FSa6ju0CNh5QxdGqHt11BT4ZKVePQPd7Kj8t6TROkX6kGBwH+nTitOa5bwFKlv
         9ySConJyMqxt3iTOqV2ApbtnF4j5lk9AtP7zQyaWZuQIydB+78GBVKrwj3YUP2n38Rnm
         zQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=6A4UmfSJwWR6cIPWv5R/7cR6eUOyl+SyqLwQoxr+tKg=;
        b=J0avZy1FDNx8EJLQncxeOrWONMBdXE0WQbC7PYFrlbIxHqu1SJXruubyBoSGwcQwCP
         3LWsMkgrypxMBMX1wBSEuCzU/EOdLHuUF/9b2O/oyARPg8P3tzm666aPcua2NMZaLgnm
         YWttaosKLomyV1ZYXbg5X89zhqpR4Vf6yZgl6/6LQKxS1UVqa8IbZCLILRG+Xpv/Iucl
         nwMdFn466DV6qGnXt8EXeTl5yrwuqV2zLml46Mpn30sjplQmhw35IGeW19w46GtWv9AS
         lCrGjb55vIYZkyneNczniujZ6n/WkCrpRQbFbGhrrDxWBBqpeUi+H6MHo0A1FmX1XRFZ
         /jHQ==
X-Gm-Message-State: AOAM533quDeXEYiXpSpv1eJcxP0eMZWbIGTrjin3HIz3qXccbuLxf3E0
        DIY4ePTNlTJLuLeh6/taLK5aJg==
X-Google-Smtp-Source: ABdhPJz8e+U7d/+PDcZLmvEO0fQPk1CoxR2ieCo/A+3FPw2I6s5oxw+7thWgnte5+ZQUVfUFk1a7bg==
X-Received: by 2002:a17:902:7689:b029:da:52:4586 with SMTP id m9-20020a1709027689b02900da00524586mr9105228pll.47.1607659811570;
        Thu, 10 Dec 2020 20:10:11 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x6sm9158227pfq.57.2020.12.10.20.10.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Dec 2020 20:10:10 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <89A599C9-4978-43C9-B2B4-82C9E746AC39@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_90BE92FD-6BDD-4CFF-B4FF-5D3252FD4057";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC 5/5] Enable threaded support for e2fsprogs'
 applications.
Date:   Thu, 10 Dec 2020 21:10:09 -0700
In-Reply-To: <20201205045856.895342-6-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-6-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_90BE92FD-6BDD-4CFF-B4FF-5D3252FD4057
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 4, 2020, at 9:58 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

My understanding is that as soon as the EXT2_FLAG_THREADS is added,
and if the backend supports CHANNEL_FLAGS_THREADS, then the pthread
code in the previous patch will "autothread" based on the number of
CPUs in the system.

That will be nice for debugfs, which would otherwise take ages to
start on a large filesystem if "-c" was not used (which also
precludes any kind of modifications).

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> debugfs/debugfs.c | 6 ++++--
> e2fsck/unix.c     | 2 +-
> misc/dumpe2fs.c   | 2 +-
> misc/e2freefrag.c | 2 +-
> misc/e2fuzz.c     | 4 ++--
> misc/e2image.c    | 3 ++-
> misc/fuse2fs.c    | 3 ++-
> misc/tune2fs.c    | 3 ++-
> resize/main.c     | 2 +-
> 9 files changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
> index 78e557792..132c5f9d9 100644
> --- a/debugfs/debugfs.c
> +++ b/debugfs/debugfs.c
> @@ -231,7 +231,8 @@ void do_open_filesys(int argc, char **argv, int =
sci_idx EXT2FS_ATTR((unused)),
> 	int	catastrophic =3D 0;
> 	blk64_t	superblock =3D 0;
> 	blk64_t	blocksize =3D 0;
> -	int	open_flags =3D EXT2_FLAG_SOFTSUPP_FEATURES | =
EXT2_FLAG_64BITS;
> +	int	open_flags =3D EXT2_FLAG_SOFTSUPP_FEATURES | =
EXT2_FLAG_64BITS |
> +		EXT2_FLAG_THREADS;
> 	char	*data_filename =3D 0;
> 	char	*undo_file =3D NULL;
>=20
> @@ -2532,7 +2533,8 @@ int main(int argc, char **argv)
> #endif
> 		"[-c]] [device]";
> 	int		c;
> -	int		open_flags =3D EXT2_FLAG_SOFTSUPP_FEATURES | =
EXT2_FLAG_64BITS;
> +	int		open_flags =3D EXT2_FLAG_SOFTSUPP_FEATURES |
> +				EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> 	char		*request =3D 0;
> 	int		exit_status =3D 0;
> 	char		*cmd_file =3D 0;
> diff --git a/e2fsck/unix.c b/e2fsck/unix.c
> index 1cb516721..dbeaeef5a 100644
> --- a/e2fsck/unix.c
> +++ b/e2fsck/unix.c
> @@ -1474,7 +1474,7 @@ int main (int argc, char *argv[])
> 	}
> 	ctx->superblock =3D ctx->use_superblock;
>=20
> -	flags =3D EXT2_FLAG_SKIP_MMP;
> +	flags =3D EXT2_FLAG_SKIP_MMP | EXT2_FLAG_THREADS;
> restart:
> #ifdef CONFIG_TESTIO_DEBUG
> 	if (getenv("TEST_IO_FLAGS") || getenv("TEST_IO_BLOCK")) {
> diff --git a/misc/dumpe2fs.c b/misc/dumpe2fs.c
> index d295ba4d4..82fb4e630 100644
> --- a/misc/dumpe2fs.c
> +++ b/misc/dumpe2fs.c
> @@ -665,7 +665,7 @@ int main (int argc, char ** argv)
>=20
> 	device_name =3D argv[optind++];
> 	flags =3D EXT2_FLAG_JOURNAL_DEV_OK | EXT2_FLAG_SOFTSUPP_FEATURES =
|
> -		EXT2_FLAG_64BITS;
> +		EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> 	if (force)
> 		flags |=3D EXT2_FLAG_FORCE;
> 	if (image_dump)
> diff --git a/misc/e2freefrag.c b/misc/e2freefrag.c
> index 9c23fadce..a9d16fc41 100644
> --- a/misc/e2freefrag.c
> +++ b/misc/e2freefrag.c
> @@ -363,7 +363,7 @@ static void collect_info(ext2_filsys fs, struct =
chunk_info *chunk_info, FILE *f)
> static void open_device(char *device_name, ext2_filsys *fs)
> {
> 	int retval;
> -	int flag =3D EXT2_FLAG_FORCE | EXT2_FLAG_64BITS;
> +	int flag =3D EXT2_FLAG_FORCE | EXT2_FLAG_64BITS | =
EXT2_FLAG_THREADS;
>=20
> 	retval =3D ext2fs_open(device_name, flag, 0, 0, unix_io_manager, =
fs);
> 	if (retval) {
> diff --git a/misc/e2fuzz.c b/misc/e2fuzz.c
> index 685cdbe29..1ace1df5a 100644
> --- a/misc/e2fuzz.c
> +++ b/misc/e2fuzz.c
> @@ -201,8 +201,8 @@ static int process_fs(const char *fsname)
> 	}
>=20
> 	/* Ensure the fs is clean and does not have errors */
> -	ret =3D ext2fs_open(fsname, EXT2_FLAG_64BITS, 0, 0, =
unix_io_manager,
> -			  &fs);
> +	ret =3D ext2fs_open(fsname, EXT2_FLAG_64BITS | =
EXT2_FLAG_THREADS,
> +			  0, 0, unix_io_manager, &fs);
> 	if (ret) {
> 		fprintf(stderr, "%s: failed to open filesystem.\n",
> 			fsname);
> diff --git a/misc/e2image.c b/misc/e2image.c
> index 892c5371e..e5e475653 100644
> --- a/misc/e2image.c
> +++ b/misc/e2image.c
> @@ -1482,7 +1482,8 @@ int main (int argc, char ** argv)
> 	ext2_filsys fs;
> 	char *image_fn, offset_opt[64];
> 	struct ext2_qcow2_hdr *header =3D NULL;
> -	int open_flag =3D EXT2_FLAG_64BITS | =
EXT2_FLAG_IGNORE_CSUM_ERRORS;
> +	int open_flag =3D EXT2_FLAG_64BITS | EXT2_FLAG_THREADS |
> +		EXT2_FLAG_IGNORE_CSUM_ERRORS;
> 	int img_type =3D 0;
> 	int flags =3D 0;
> 	int mount_flags =3D 0;
> diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
> index 4005894d3..c59572129 100644
> --- a/misc/fuse2fs.c
> +++ b/misc/fuse2fs.c
> @@ -3727,7 +3727,8 @@ int main(int argc, char *argv[])
> 	errcode_t err;
> 	char *logfile;
> 	char extra_args[BUFSIZ];
> -	int ret =3D 0, flags =3D EXT2_FLAG_64BITS | EXT2_FLAG_EXCLUSIVE;
> +	int ret =3D 0;
> +	int flags =3D EXT2_FLAG_64BITS | EXT2_FLAG_THREADS | =
EXT2_FLAG_EXCLUSIVE;
>=20
> 	memset(&fctx, 0, sizeof(fctx));
> 	fctx.magic =3D FUSE2FS_MAGIC;
> diff --git a/misc/tune2fs.c b/misc/tune2fs.c
> index f942c698a..e5186fe0c 100644
> --- a/misc/tune2fs.c
> +++ b/misc/tune2fs.c
> @@ -2950,7 +2950,8 @@ retry_open:
> 	if ((open_flag & EXT2_FLAG_RW) =3D=3D 0 || f_flag)
> 		open_flag |=3D EXT2_FLAG_SKIP_MMP;
>=20
> -	open_flag |=3D EXT2_FLAG_64BITS | EXT2_FLAG_JOURNAL_DEV_OK;
> +	open_flag |=3D EXT2_FLAG_64BITS | EXT2_FLAG_THREADS |
> +		EXT2_FLAG_JOURNAL_DEV_OK;
>=20
> 	/* keep the filesystem struct around to dump MMP data */
> 	open_flag |=3D EXT2_FLAG_NOFREE_ON_ERROR;
> diff --git a/resize/main.c b/resize/main.c
> index cb0bf6a0d..72a703f6a 100644
> --- a/resize/main.c
> +++ b/resize/main.c
> @@ -402,7 +402,7 @@ int main (int argc, char ** argv)
> 	if (!(mount_flags & EXT2_MF_MOUNTED))
> 		io_flags =3D EXT2_FLAG_RW | EXT2_FLAG_EXCLUSIVE;
>=20
> -	io_flags |=3D EXT2_FLAG_64BITS;
> +	io_flags |=3D EXT2_FLAG_64BITS | EXT2_FLAG_THREADS;
> 	if (undo_file) {
> 		retval =3D resize2fs_setup_tdb(device_name, undo_file, =
&io_ptr);
> 		if (retval)
> --
> 2.28.0
>=20


Cheers, Andreas






--Apple-Mail=_90BE92FD-6BDD-4CFF-B4FF-5D3252FD4057
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/S8SEACgkQcqXauRfM
H+CaJQ//VIX4HH1+0OAl4uczitH68C6vFqLazXr9YhBv3TdH0xZ4jK5owc3I61d6
r1s1MB1jcZx1qwYikfPst225Jz8cKxGSLpS57f+V0F9oC2ThUwRMtedbw270Tk9h
d/0ZIJOl6FIU66lBtqfrxn3E7Z3loAHPUe3B66+9lYJlvCrC3eqVJUH4Hg074J0J
aAZ6oDWd7d+PS9muy/+j5ccBTRobk7TxFjWCIn7ZVHdvUpkVidMn1wD/cxRMC1rQ
vKkj5gKyckKvvA9KkLdHHoG/Nj8NZOkrQuOjhxVjXYut365wQ4BS1mMnW2T7QqK7
cD7eQYrCQn7O7fCHHFoFgsRGogsr2kyhdu3N4zAAWM0d/ENu6wsqJT5QgsrO+qm7
eLBNxic4JRdO0JYXsgpX2TvTlZZQC6YqbBiL9pM8TlfFk/5Q8+bLHhPq+JYmHzWu
0FrtMIwncntHX+ybHVQEXB/m9HkKWEz8fd/flikW16sT4hUXG48d+VCoqLdc8oiW
4pgWR2O6Wm7GZVK16WrXhmVsACQo2JUwCjx2VB5SI5ex3iPe/xfZ5HF0XDC4weFn
F2Q/xUfxS04xx/XhhqEPwrrIAiAtlAxf07MlYwaX8DdYXgtMXro/GoqeNe1ryJvQ
xiT76ZqcJ+gpxaduVFVGmdiA+fcyxoSD/PW5Ti0rCpkxXtwyvYs=
=8HIc
-----END PGP SIGNATURE-----

--Apple-Mail=_90BE92FD-6BDD-4CFF-B4FF-5D3252FD4057--
