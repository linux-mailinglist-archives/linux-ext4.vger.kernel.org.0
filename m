Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605C077C6C7
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Aug 2023 06:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbjHOExk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Aug 2023 00:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjHOExA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Aug 2023 00:53:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81DABF
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:52:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-565331f1c9eso2867675a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 14 Aug 2023 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1692075177; x=1692679977;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6s+ZNSV4Ccz0WfN9DpQYK//fUD15FdA0HZgd5pG9ryk=;
        b=WB6d/AbCODzsLGz1Q+MgUjXm4Nt1rCsOZ3wHlFEnKJYI1Sk0FwfMaqsCviL52H99Lc
         8VoewxX8lmS73HSRB93M3k8qT7jQtNpfktqC1ALhCx45pLigQeiNrTe/BAtK964rlZ1d
         hhmKW5jcCGDQEFrT3J6i/DDrF6v6MzOXxy3YFk+Egcopqq+ANCAp19OpzP1x5mNd4nnG
         +UgbkYlnZGrl/bWkFdT/l3EdciVH10OnwiHfEccb+e6cYDhZG5cyyBuo5u9rkNEZNdbU
         WcqvQWSAyVX/mEpIE5TS6Ht9XrKcBZp86jZt3y+wQYuLp5bLfPCKMLlFwg85FvoKGxY/
         la7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075177; x=1692679977;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6s+ZNSV4Ccz0WfN9DpQYK//fUD15FdA0HZgd5pG9ryk=;
        b=FDHT1tU9mQS8O7ydn1+KNfZTkDF6zzElJ4IC2iu7Rbr5R+iNgdSCR3VsYhbD7KBFMY
         l5FplSxdtAlzWkwIrG/brv/OchepSCpiR+kcBOdl7lv9IesVtiXq6ps/9WYUsCcXk5cr
         J+Y5z+C9rTqRg6eh2L0AYM079DlnIrZxB9N2AwVXgxYP91LFGhunXarQjSbVMDC5AEut
         R6m0bh1VLCijrNkgta5yzNm1uB+eCVSwAW3/OeTLtBd55lpEpEz77q1AfnDlESJ+2dk3
         gsTPG1fmtRrKXZmqhgpKjjHPXcint/8+yyAaC+4rFFE4HfsgxzFoF3EQoUTFtORLljRE
         9JRg==
X-Gm-Message-State: AOJu0Yx6ktM94LG7HjaBceZ0kr1jE8uASYaL33Kr3wocbalDoR9BDrsv
        O3hroleQwKzlprNrJNGMfG/jZ4NJW9OIIZf4YLU=
X-Google-Smtp-Source: AGHT+IHkQL5PcP56nlSkKQb+cGiABSgpJZYG4JPYmAivnWdQe38PTKw7GgpisnUTExQ5xUJsbcHEww==
X-Received: by 2002:a17:903:110c:b0:1bc:2c58:ad97 with SMTP id n12-20020a170903110c00b001bc2c58ad97mr10791569plh.22.1692075177129;
        Mon, 14 Aug 2023 21:52:57 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id je1-20020a170903264100b001bb9aadfb04sm10317370plb.220.2023.08.14.21.52.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Aug 2023 21:52:56 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <1FD4874D-0E9C-442C-9FC1-AC35DCFD0A3C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_336A133B-A3A9-4784-B0B4-BE18239A9157";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 1/1] mke2fs: the -d option can now handle tarball input
Date:   Mon, 14 Aug 2023 22:52:54 -0600
In-Reply-To: <20230812150204.462962-2-josch@mister-muffin.de>
Cc:     linux-ext4@vger.kernel.org
To:     Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
References: <605DCBDE-A388-4B98-BF5A-38773F15E3F4@dilger.ca>
 <20230812150204.462962-2-josch@mister-muffin.de>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_336A133B-A3A9-4784-B0B4-BE18239A9157
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 12, 2023, at 9:02 AM, Johannes Schauer Marin Rodrigues =
<josch@mister-muffin.de> wrote:
>=20
> If archive.h is available during compilation, enable mke2fs to read a
> tarball as input. Since libarchive.so.13 is opened with dlopen,
> libarchive is not a hard library dependency of the resulting binary.
>=20
> This enables the creation of filesystems containing files which would
> otherwise need superuser privileges to create (like device nodes, =
which
> are also not allowed in unshared user namespaces). By reading from
> standard input when the filename is a dash (-), mke2fs can be used as
> part of a shell pipeline without temporary files.
>=20
> A round-trip from tarball to ext4 to tarball yields bit-by-bit =
identical
> results.
>=20
> Signed-off-by: Johannes Schauer Marin Rodrigues =
<josch@mister-muffin.de>

Hi Johannes,
thanks for the updated patch.  Review comments inline.

I think this looks useful, and the code is now isolated enough that it
could be easily managed in the future.  It is looking in reasonable =
shape,
but could use another round of updates to make the patch a bit cleaner.

The big question is whether Ted will accept it.

Cheers, Andreas


> diff --git a/MCONFIG.in b/MCONFIG.in
> index 82c75a28..cb3ec759 100644
> --- a/MCONFIG.in
> +++ b/MCONFIG.in
> @@ -141,6 +141,7 @@ LIBFUSE =3D @FUSE_LIB@
> LIBSUPPORT =3D $(LIBINTL) $(LIB)/libsupport@STATIC_LIB_EXT@
> LIBBLKID =3D @LIBBLKID@ @PRIVATE_LIBS_CMT@ $(LIBUUID)
> LIBINTL =3D @LIBINTL@
> +LIBARCHIVE =3D @ARCHIVE_LIB@
> SYSLIBS =3D @LIBS@ @PTHREAD_LIBS@
> DEPLIBSS =3D $(LIB)/libss@LIB_EXT@
> DEPLIBCOM_ERR =3D $(LIB)/libcom_err@LIB_EXT@
> diff --git a/configure b/configure
> index 72c39b4d..27b97c3b 100755
> --- a/configure
> +++ b/configure
> @@ -704,6 +704,7 @@ SEM_INIT_LIB
> FUSE_CMT
> FUSE_LIB
> CLOCK_GETTIME_LIB
> +ARCHIVE_LIB
> MAGIC_LIB
> SOCKET_LIB
> SIZEOF_TIME_T

I think this part of the configure change is correct, to add =
ARCHIVE_LIB.

> @@ -8678,7 +8679,7 @@ else $as_nop
>       *-*-aix*)
>         cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> /* end confdefs.h.  */
> -#if defined __powerpc64__ || defined __LP64__
> +#if defined __powerpc64__ || defined _ARCH_PPC64
>                 int ok;
>                #else
>                 error fail
> @@ -8969,7 +8970,7 @@ rm -f core conftest.err conftest.$ac_objext =
conftest.beam conftest.$ac_ext
>            # be generating 64-bit code.
>            cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> /* end confdefs.h.  */
> -#if defined __powerpc64__ || defined __LP64__
> +#if defined __powerpc64__ || defined _ARCH_PPC64
>                    int ok;
>                   #else
>                    error fail

These parts of the change is specific to your system and should probably
be removed from the patch.

[snip some similar random changes]

> @@ -13539,6 +13522,57 @@ if test "$ac_cv_func_dlopen" =3D yes ; then
>    MAGIC_LIB=3D$DLOPEN_LIB
> fi
>=20
> +{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for =
archive_read_new in -larchive" >&5
> +printf %s "checking for archive_read_new in -larchive... " >&6; }
> +if test ${ac_cv_lib_archive_archive_read_new+y}
> +then :
> +  printf %s "(cached) " >&6
> +else $as_nop
> +  ac_check_lib_save_LIBS=3D$LIBS
> +LIBS=3D"-larchive  $LIBS"
> +cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> +/* end confdefs.h.  */
> +
> +/* Override any GCC internal prototype to avoid an error.
> +   Use char because int might match the return type of a GCC
> +   builtin and then its argument prototype would still apply.  */
> +char archive_read_new ();
> +int
> +main (void)
> +{
> +return archive_read_new ();
> +  ;
> +  return 0;
> +}
> +_ACEOF
> +if ac_fn_c_try_link "$LINENO"
> +then :
> +  ac_cv_lib_archive_archive_read_new=3Dyes
> +else $as_nop
> +  ac_cv_lib_archive_archive_read_new=3Dno
> +fi
> +rm -f core conftest.err conftest.$ac_objext conftest.beam \
> +    conftest$ac_exeext conftest.$ac_ext
> +LIBS=3D$ac_check_lib_save_LIBS
> +fi
> +{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: =
$ac_cv_lib_archive_archive_read_new" >&5
> +printf "%s\n" "$ac_cv_lib_archive_archive_read_new" >&6; }
> +if test "x$ac_cv_lib_archive_archive_read_new" =3D xyes
> +then :
> +  ARCHIVE_LIB=3D-larchive
> +ac_fn_c_check_header_compile "$LINENO" "archive.h" =
"ac_cv_header_archive_h" "$ac_includes_default"
> +if test "x$ac_cv_header_archive_h" =3D xyes
> +then :
> +  printf "%s\n" "#define HAVE_ARCHIVE_H 1" >>confdefs.h
> +
> +fi
> +
> +fi
> +
> +if test "$ac_cv_func_dlopen" =3D yes ; then
> +   ARCHIVE_LIB=3D$DLOPEN_LIB
> +fi
> +
> { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for =
clock_gettime in -lrt" >&5
> printf %s "checking for clock_gettime in -lrt... " >&6; }
> if test ${ac_cv_lib_rt_clock_gettime+y}

This is the part specific to the ARCHIVE_LIB check, which is fine.

> @@ -14803,11 +14837,11 @@ if test x$ac_prog_cxx_stdcxx =3D xno
> then :
>   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for $CXX =
option to enable C++11 features" >&5
> printf %s "checking for $CXX option to enable C++11 features... " >&6; =
}
> -if test ${ac_cv_prog_cxx_11+y}
> +if test ${ac_cv_prog_cxx_cxx11+y}
> then :
>   printf %s "(cached) " >&6
> else $as_nop
> -  ac_cv_prog_cxx_11=3Dno
> +  ac_cv_prog_cxx_cxx11=3Dno
> ac_save_CXX=3D$CXX
> cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> /* end confdefs.h.  */
> @@ -14849,11 +14883,11 @@ if test x$ac_prog_cxx_stdcxx =3D xno
> then :
>   { printf "%s\n" "$as_me:${as_lineno-$LINENO}: checking for $CXX =
option to enable C++98 features" >&5
> printf %s "checking for $CXX option to enable C++98 features... " >&6; =
}
> -if test ${ac_cv_prog_cxx_98+y}
> +if test ${ac_cv_prog_cxx_cxx98+y}
> then :
>   printf %s "(cached) " >&6
> else $as_nop
> -  ac_cv_prog_cxx_98=3Dno
> +  ac_cv_prog_cxx_cxx98=3Dno
> ac_save_CXX=3D$CXX
> cat confdefs.h - <<_ACEOF >conftest.$ac_ext
> /* end confdefs.h.  */
> @@ -15193,7 +15227,7 @@ fi
>=20
>=20
> if test $pkg_failed =3D yes; then
> -   	{ printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
> +        { printf "%s\n" "$as_me:${as_lineno-$LINENO}: result: no" >&5
> printf "%s\n" "no" >&6; }
>=20
> if $PKG_CONFIG --atleast-pkgconfig-version 0.20; then

These are again specific to your system or configure version and should
be removed from the patch.

[snip similar random changes and boilerplate Makefile changes]

> diff --git a/misc/create_inode.c b/misc/create_inode.c
> index a3a34cd9..6382f17e 100644
> --- a/misc/create_inode.c
> +++ b/misc/create_inode.c
> @@ -1069,14 +1067,49 @@ errcode_t populate_fs2(ext2_filsys fs, =
ext2_ino_t parent_ino,
> 	file_info.path_max_len =3D 255;
> 	file_info.path =3D calloc(file_info.path_max_len, 1);
>=20
> -	retval =3D set_inode_xattr(fs, root, source_dir);
> +	/* interpret input as tarball either if it's "-" (stdin) or if =
it's
> +	 * a regular file (or a symlink pointing to a regular file)
> +	 */
> +	if (strcmp(source, "-") =3D=3D 0) {
> +#ifdef HAVE_ARCHIVE_H
> +		retval =3D __populate_fs_from_tar(fs, parent_ino, NULL, =
root, &hdlinks,
> +					   &file_info, fs_callbacks);
> +#else
> +		com_err(__func__, 0,
> +			_("you need to compile e2fsprogs with libarchive =
to "
> +			  "be able to process tarballs"));
> +		retval =3D 1;
> +#endif

Rather than having an inline #ifdef here, this could be structured like
the following in create_file_libarchive.c:

#ifdef HAVE_ARCHIVE_H
errcode_t __populate_fs_from_tar(...)
{
	:
	[ proper implementation ]
}
#else
errcode_t __populate_fs_from_tar(...)
{
	com_err(__func__, 0, _("you need to compile ..."));

	return 1;
}
#endif

and then the code here only calls:

		retval =3D __populate_fs_from_tar(fs, ...);

and the code is not complicated depending on if it is compiled in or =
not.

> +	if (S_ISREG(st.st_mode)) {
> +#ifdef HAVE_ARCHIVE_H
> +		retval =3D __populate_fs_from_tar(fs, parent_ino, =
source, root, &hdlinks,
> +					   &file_info, fs_callbacks);
> +#else
> +		com_err(__func__, 0,
> +			_("you need to compile e2fsprogs with libarchive =
to be "
> +			  "able to process tarballs"));
> +		retval =3D 1;
> +#endif

This would be handled similarly.

> diff --git a/misc/create_inode_libarchive.c =
b/misc/create_inode_libarchive.c
> new file mode 100644
> index 00000000..26c3b4dc
> --- /dev/null
> +++ b/misc/create_inode_libarchive.c
> @@ -0,0 +1,677 @@
> +/*
> + * create_inode_libarchive.c --- create an inode from libarchive =
input
> + *
> + * Copyright (C) 2023 Johannes Schauer Marin Rodrigues =
<josch@debian.org>
> + *
> + * %Begin-Header%
> + * This file may be redistributed under the terms of the GNU library
> + * General Public License, version 2.
> + * %End-Header%
> + */
> +
> +#define _FILE_OFFSET_BITS 64
> +#define _LARGEFILE64_SOURCE 1
> +#define _GNU_SOURCE 1
> +
> +#include "config.h"
> +
> +#ifdef HAVE_ARCHIVE_H
> +
> +#include <ext2fs/ext2_types.h>
> +
> +#include "create_inode.h"
> +#include "support/nls-enable.h"
> +
> +/* 64KiB is the minimum blksize to best minimize system call =
overhead. */
> +#define COPY_FILE_BUFLEN 65536

If we expect larger files, having a 1MB or 16MB buffer is not outrageous
these days, and would probably improve the performance noticeably.

[snip]

> +/* Rounds qty up to a multiple of siz. siz should be a power of 2
> + */
> +static inline unsigned int __rndup(unsigned int qty, unsigned int =
siz)

I'm sure we can afford a few extra "e" here and write "size", and write
round_up() to make this code more readable...

> +{
> +	return (qty + (siz - 1)) & ~(siz - 1);
> +}
> +

[snip]

> +errcode_t __populate_fs_from_tar(ext2_filsys fs, ext2_ino_t root_ino,
> +				 const char *source_tar, ext2_ino_t =
root,
> +				 struct hdlinks_s *hdlinks,
> +				 struct file_info *target,
> +				 struct fs_ops_callbacks *fs_callbacks)
> +{
> +	char *path2, *path3, *dir, *name;
> +	unsigned int uid, gid, mode;
> +	unsigned long ctime, mtime;
> +	struct archive *a;
> +	struct archive_entry *entry;
> +	errcode_t retval =3D 0;
> +	locale_t archive_locale;
> +	locale_t old_locale;
> +	ext2_ino_t dirinode, tmpino;
> +	const struct stat *st;
> +
> +	if (!libarchive_available()) {
> +		com_err(__func__, 0,
> +			_("you need libarchive to be able to process =
tarballs"));
> +		return 1;
> +	}

[snip]

> +out:
> +	dl_archive_read_close(a);
> +	dl_archive_read_free(a);
> +	uselocale(old_locale);
> +	freelocale(archive_locale);
> +	return retval;
> +}

The "not supported" code would go here:

#else

errcode_t __populate_fs_from_tar(...)
{
	com_err(__func__, 0, _("you need to compile ..."));

	return 1;
}

> +#endif

[snip]


Cheers, Andreas






--Apple-Mail=_336A133B-A3A9-4784-B0B4-BE18239A9157
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmTbBKYACgkQcqXauRfM
H+COkg//SZ1f78Ekd0J/c70kLcttA8fyjFhYI3D1NbKNx9H4Qw4DAwXLhOlCGBwH
pFFYuMd4cI7kWHZ2mtsdc582DoPIWQhX+NXMm0wFIsTDEGBvwRmET5wx7PsSp0Z3
VNqtvZ+b5gKooLsrfBQlDpUQWnhRq9cP9wpYitDsnK+PZ3/N4s1crNpug1KrSOCw
dQA3Ss6QyhAsuUuMzdb78H/zFE5rU7fdSa+n9YxWTu/BtweJB3L5h3wU36aL4XAZ
+SxMeI7R89++oWaQp+Zvt1raH1lNJwlxamxerWgBWm2RqD5TnsHWjhihEPnNDwAU
3x9LIRRMmyiUed84TSxmKtqGXuMq5PfXVV9Vb6nwkhWLqFIZDwEKfVXwidOJJOSo
FG4zscqVSggaeFzIFZTdpCBaSb3axn9PI2cs8FvG5Z8WL5wJ17n0tOMH+M9MnDw5
kmy1UMFq/ibgwFF/dtTkonVi//LN214pnSRhSY2h/qU9MNlG+z57gU2TkERi2E83
voXXVoECIbTGs9lfbGDpN2kdT9ZMhg8sd0YLjznrq3AP+guLAJsrl+29aw1T8gvH
7ngpLSbiPPXEAqgE5xtyYGvQgrcwxib+CCNKLu9AihgvWHLviU1sSjoB8SD1Ovc+
Fiiq+iKU1R9qsFpIBgDqyANqJFDJ409W9gCrRs+2liTLQgZHCcQ=
=t8z9
-----END PGP SIGNATURE-----

--Apple-Mail=_336A133B-A3A9-4784-B0B4-BE18239A9157--
