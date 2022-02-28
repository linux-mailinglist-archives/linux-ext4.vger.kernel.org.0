Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9B4C7EBA
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 00:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiB1Xub (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 18:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiB1Xub (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 18:50:31 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A42119873
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:49:47 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d17so12578116pfl.0
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=5eLPyv9GYaYv8JfqDraQW+/d0kVtcC5QEY7In8MUAgs=;
        b=MEosQw1ERLlcb+OwQ04jm3E4FYsTEgUYPmiEkF/Rcedg98E134oD0U5KTHbLYGYasJ
         KK4mD54ZCbySLVP7pc0xpUfkyoIKIJL3DH+Mk/NZ2qRg4Is8TuBEKGhzx3hRbf3jYoVs
         PneWVvFUUUbCHQpa2dFO5oi097idhhAsJbCFv9a0+bP5QT2dJPelASetzqg5MW0Bidf1
         LvZTGy0INYfG5xOWlaQtY68FVcuP6tZGhDGshtHdt84TzGUKGikXrn/cdmZC+mxSGzbf
         sxg0qmDV64+oKiZhEj+XjAI+L8OqjbybQlri5d8FaOWSIjNqSxFMA4pL27MS2wyJUXRc
         JfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=5eLPyv9GYaYv8JfqDraQW+/d0kVtcC5QEY7In8MUAgs=;
        b=wv2RWPzQBikt7eBEeK93uTtRZHHtbZidIaUJqdgWis/XjAyIoaQZm1CLqdtnueXhfZ
         UB12/Wr48ezOIt0txi+ROsXHTsYFV6rdQKVgoOHoHw+nzR98IbveHp0mqL2NjUy3qHVj
         iNormEcpCPQhusBaMqEMUQly0IwRwU1HUFR50ifIPA3lwlVbmUoZpjkFjQfjErrFNVg/
         NAZLKDgtAlG4htqc5kiP9if6AStGhqrIPZc5gFusVwx1FnkSckwUM2JGkfjdwlIsv0+2
         m1RIzYAs+gJ6HoGb2XlMpgyaxAfWIHcZ5U3Y+dPAs4fBuh83NUKpC81WWkKTrBPnUa6m
         e0Fw==
X-Gm-Message-State: AOAM531M/dAjJVhnZ3Weu5mfSiH2lM+WcPk3+hLZDHZYBcNtqXEsw0If
        +lwjCg/YNFN8z+jdxvyph57Ef7MpGDifrA==
X-Google-Smtp-Source: ABdhPJzrvJAp2WL1rrngrMQCsh+FbTlYkA8cYVHkh4x8ewumuRLAl0JMyBBUwyxvv46ODf5AAsy4Pw==
X-Received: by 2002:a05:6a00:1a07:b0:4f3:eba5:42ae with SMTP id g7-20020a056a001a0700b004f3eba542aemr12971015pfv.53.1646092186814;
        Mon, 28 Feb 2022 15:49:46 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm14213333pfh.46.2022.02.28.15.49.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:49:46 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <07A89A7C-93D0-4B86-BCE7-BC77F671C67C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_39F772CF-8919-4126-AAF4-D52C6A0548FC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] e2fsprogs: use mallinfo2 instead of mallinfo if
 available
Date:   Mon, 28 Feb 2022 16:49:43 -0700
In-Reply-To: <20220217092500.40525-3-lczerner@redhat.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Lukas Czerner <lczerner@redhat.com>
References: <20220217092500.40525-1-lczerner@redhat.com>
 <20220217092500.40525-3-lczerner@redhat.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,LONGWORDS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_39F772CF-8919-4126-AAF4-D52C6A0548FC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 17, 2022, at 2:25 AM, Lukas Czerner <lczerner@redhat.com> wrote:
>=20
> mallinfo has been deprecated with GNU C library version 2.33 in favor =
of
> mallinfo2 which works exactly the same as mallinfo but with larger =
field
> widths. Use mallinfo2 if available.
>=20
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Nice that a replacement for mallinfo() API was finally added to glibc.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> configure               |  2 +-
> configure.ac            |  1 +
> e2fsck/iscan.c          | 11 ++++++++++-
> e2fsck/util.c           | 11 ++++++++++-
> lib/config.h.in         |  3 +++
> resize/resource_track.c | 13 ++++++++++---
> 6 files changed, 35 insertions(+), 6 deletions(-)
>=20
> diff --git a/configure b/configure
> index effd929d..530bc77c 100755
> --- a/configure
> +++ b/configure
> @@ -11254,7 +11254,7 @@ fi
> if test -n "$DLOPEN_LIB" ; then
>    ac_cv_func_dlopen=3Dyes
> fi
> -for ac_func in  	__secure_getenv 	add_key 	=
backtrace 	chflags 	dlopen 	fadvise64 	fallocate 	=
fallocate64 	fchown 	fcntl 	fdatasync 	fstat64 	fsync 	=
ftruncate64 	futimes 	getcwd 	getdtablesize 	getentropy 	=
gethostname 	getmntinfo 	getpwuid_r 	getrandom 	=
getrlimit 	getrusage 	jrand48 	keyctl 	llistxattr 	=
llseek 	lseek64 	mallinfo 	mbstowcs 	memalign 	=
mempcpy 	mmap 	msync 	nanosleep 	open64 	pathconf 	=
posix_fadvise 	posix_fadvise64 	posix_memalign 	prctl 	pread 	=
pwrite 	pread64 	pwrite64 	secure_getenv 	setmntent 	=
setresgid 	setresuid 	snprintf 	srandom 	stpcpy 	=
strcasecmp 	strdup 	strnlen 	strptime 	strtoull 	=
sync_file_range 	sysconf 	usleep 	utime 	utimes 	valloc
> +for ac_func in  	__secure_getenv 	add_key 	=
backtrace 	chflags 	dlopen 	fadvise64 	fallocate 	=
fallocate64 	fchown 	fcntl 	fdatasync 	fstat64 	fsync 	=
ftruncate64 	futimes 	getcwd 	getdtablesize 	getentropy 	=
gethostname 	getmntinfo 	getpwuid_r 	getrandom 	=
getrlimit 	getrusage 	jrand48 	keyctl 	llistxattr 	=
llseek 	lseek64 	mallinfo 	mallinfo2 	mbstowcs 	=
memalign 	mempcpy 	mmap 	msync 	nanosleep 	open64 	=
pathconf 	posix_fadvise 	posix_fadvise64 	posix_memalign 	=
prctl 	pread 	pwrite 	pread64 	pwrite64 	secure_getenv 	=
setmntent 	setresgid 	setresuid 	snprintf 	srandom 	=
stpcpy 	strcasecmp 	strdup 	strnlen 	strptime 	strtoull =
	sync_file_range 	sysconf 	usleep 	utime 	utimes 	=
valloc
> do :
>   as_ac_var=3D`$as_echo "ac_cv_func_$ac_func" | $as_tr_sh`
> ac_fn_c_check_func "$LINENO" "$ac_func" "$as_ac_var"
> diff --git a/configure.ac b/configure.ac
> index dff3d1ca..8acc4e1c 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1214,6 +1214,7 @@ AC_CHECK_FUNCS(m4_flatten([
> 	llseek
> 	lseek64
> 	mallinfo
> +	mallinfo2
> 	mbstowcs
> 	memalign
> 	mempcpy
> diff --git a/e2fsck/iscan.c b/e2fsck/iscan.c
> index 607e4752..33c6a4cd 100644
> --- a/e2fsck/iscan.c
> +++ b/e2fsck/iscan.c
> @@ -109,7 +109,16 @@ void print_resource_track(const char *desc,
> 		printf("%s: ", desc);
>=20
> #define kbytes(x)	(((unsigned long long)(x) + 1023) / 1024)
> -#ifdef HAVE_MALLINFO
> +#ifdef HAVE_MALLINFO2
> +	if (1) {
> +		struct mallinfo2 malloc_info =3D mallinfo2();
> +
> +		printf("Memory used: %lluk/%lluk (%lluk/%lluk), ",
> +		       kbytes(malloc_info.arena), =
kbytes(malloc_info.hblkhd),
> +		       kbytes(malloc_info.uordblks),
> +		       kbytes(malloc_info.fordblks));
> +	} else
> +#elif defined HAVE_MALLINFO
> 	/* don't use mallinfo() if over 2GB used, since it returns "int" =
*/
> 	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
> 		struct mallinfo	malloc_info =3D mallinfo();
> diff --git a/e2fsck/util.c b/e2fsck/util.c
> index 3fe3c988..42740d9e 100644
> --- a/e2fsck/util.c
> +++ b/e2fsck/util.c
> @@ -430,7 +430,16 @@ void print_resource_track(e2fsck_t ctx, const =
char *desc,
> 		log_out(ctx, "%s: ", desc);
>=20
> #define kbytes(x)	(((unsigned long long)(x) + 1023) / 1024)
> -#ifdef HAVE_MALLINFO
> +#ifdef HAVE_MALLINFO2
> +	if (1) {
> +		struct mallinfo2 malloc_info =3D mallinfo2();
> +
> +		log_out(ctx, _("Memory used: %lluk/%lluk (%lluk/%lluk), =
"),
> +			kbytes(malloc_info.arena), =
kbytes(malloc_info.hblkhd),
> +			kbytes(malloc_info.uordblks),
> +			kbytes(malloc_info.fordblks));
> +	} else
> +#elif defined HAVE_MALLINFO
> 	/* don't use mallinfo() if over 2GB used, since it returns "int" =
*/
> 	if ((char *)sbrk(0) - (char *)track->brk_start < 2LL << 30) {
> 		struct mallinfo	malloc_info =3D mallinfo();
> diff --git a/lib/config.h.in b/lib/config.h.in
> index 9c9de65d..b5856bb5 100644
> --- a/lib/config.h.in
> +++ b/lib/config.h.in
> @@ -208,6 +208,9 @@
> /* Define to 1 if you have the `mallinfo' function. */
> #undef HAVE_MALLINFO
>=20
> +/* Define to 1 if you have the `mallinfo2' function. */
> +#undef HAVE_MALLINFO2
> +
> /* Define to 1 if you have the <malloc.h> header file. */
> #undef HAVE_MALLOC_H
>=20
> diff --git a/resize/resource_track.c b/resize/resource_track.c
> index f0efe114..f4667060 100644
> --- a/resize/resource_track.c
> +++ b/resize/resource_track.c
> @@ -63,8 +63,10 @@ void print_resource_track(ext2_resize_t rfs, struct =
resource_track *track,
> #ifdef HAVE_GETRUSAGE
> 	struct rusage r;
> #endif
> -#ifdef HAVE_MALLINFO
> -	struct mallinfo	malloc_info;
> +#ifdef HAVE_MALLINFO2
> +	struct mallinfo2 malloc_info;
> +#elif defined HAVE_MALLINFO
> +	struct mallinfo malloc_info;
> #endif
> 	struct timeval time_end;
>=20
> @@ -76,8 +78,13 @@ void print_resource_track(ext2_resize_t rfs, struct =
resource_track *track,
> 	if (track->desc)
> 		printf("%s: ", track->desc);
>=20
> -#ifdef HAVE_MALLINFO
> #define kbytes(x)	(((unsigned long)(x) + 1023) / 1024)
> +#ifdef HAVE_MALLINFO2
> +	malloc_info =3D mallinfo2();
> +	printf("Memory used: %luk/%luk (%luk/%luk), ",
> +		kbytes(malloc_info.arena), kbytes(malloc_info.hblkhd),
> +		kbytes(malloc_info.uordblks), =
kbytes(malloc_info.fordblks));
> +#elif defined HAVE_MALLINFO
>=20
> 	malloc_info =3D mallinfo();
> 	printf("Memory used: %luk/%luk (%luk/%luk), ",
> --
> 2.34.1
>=20


Cheers, Andreas






--Apple-Mail=_39F772CF-8919-4126-AAF4-D52C6A0548FC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIdX5cACgkQcqXauRfM
H+DPYBAArZNJTkZ64edLbWljPOk6F6ucwFrK40HgBg1ojrFdYFwfIKphumAdmcde
JcloiEsIC8m3dg5ud0BBJHbHUPoG/UddLTEfh4UoK9AUkmRVwq50TxBPwl4xqmAy
Lp9YJM4Pvn5+B+wqUQKUA+VKVVU/1vs95rRoegFJL6lmalxouHUXSz7Bel+FNPFE
+N1HQugDL/1lPbjgNJjc+Bi5CoNwoy0OppNkoCbSAGl2GiJXJFqzq/iyM9nbK08f
SRnJyaRr3Kf4wGuBerrwDatwjaM0NPBGOQ05srZnHA4X0JyLR1e9WyV9jrzijDNy
x7acU/QuKQIje51Gd8cDw+6p8Laj7gMAuUp/OiW4YklDAKZMX71zTsYGrslBFQRe
Ya2QArZPGzObRWLrl0iNHFsIpLa+/Ex9Ue81tdTfpKZdoWwLRHe41vtElG738aNM
B0vkzLrWrPAJHOkSpGGMKVPxChfWU3n3Js+KVFwIg8s7QM4wpNKP1mBYUgbLi8Kd
uh7hH1larxP5BOWuw71N4wTW46WfpThCWlvm1Mqx/ZJCAaaWbx+UvREiDDuZrT1u
EAtVQFEyZm4qj+tksdYVWfXYPbFo+qo4UJ6bot54y8njzm4cnr8hMKvnTkd1cCHi
RXHC//UdxAHqkgmQ5bCZr3CGpvzKnWX9MHOTt9HzsN44886DjWE=
=GfMG
-----END PGP SIGNATURE-----

--Apple-Mail=_39F772CF-8919-4126-AAF4-D52C6A0548FC--
