Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30D84C7EBB
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Mar 2022 00:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiB1Xut (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Feb 2022 18:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiB1Xus (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 28 Feb 2022 18:50:48 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FEA119873
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:50:08 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id ay5so9239766plb.1
        for <linux-ext4@vger.kernel.org>; Mon, 28 Feb 2022 15:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=u8Abd/MrDKI+DWZcXVtOCY+RsYPUFer65FcYkMxNbn0=;
        b=pLTGKY7ajJRo3wYjk/IwD7mJ3+YdL8dQieNpBeL8t9dtuFjMooQ04NZCe7mVBt6X9c
         GPLVkfSRYQdpVRSOCpUyB5u2TxMvbbp+0LwcINIPfluiCTw5EEVLZzBJ0kbo/0hhdDJZ
         xXVCTBHQQep6qBunmj/5aWtAgTt/uHFaq110SOmefseGMVU7epSH0wWli7dFSs6ssUjF
         h6lZsbQooGZsxb5J0SfGa3thS12lMegOq6hhsR26jXb58zcRS6Pinq+LDkFtfi/BfP6x
         SauW9pgASdHbNDLIKSnR/qjrYPk8XuxlUj+oyOE+BVgLX7UYYA/0fD2MUjKCvn4AV858
         TTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=u8Abd/MrDKI+DWZcXVtOCY+RsYPUFer65FcYkMxNbn0=;
        b=fjf6Q2seYUqLVvOmdHMlYJwrU1Zl/R/4y18VZYezej4THBiUaYolH6Azfp2ECdx5hb
         UO2caoQLokrZ38kxpv/ObHpjVZnsh8e7BGK17efFhSBZmtoHGxl7uGv1tNzPNnnnyy/E
         1VWUJF4FxPRkNvxhRCBGiLvs4wPUIiPFIPC6MFBVxBFOA2mowdhn6UEwXtjXSr2EpCYb
         /9Uz4rZ9S1MUTURfnmJWdvMugsQKPUut2P29p8E6rZOda8n7OVTgmD0RM8y2VSfYaDWe
         UeTxW+flEEKsp1VYKuLFs9WgXXUO84efFC+ctq5EK70r3IlGCb862p/hp9o5lErwHEb+
         jsoQ==
X-Gm-Message-State: AOAM532dH1y8lfdiYCQVHh4dBhAxsNy7Gjoe8osFKp81ISMbIKVBfU39
        KmjqZh/CDe+d+CV8bicDh88BKnRb76cvHQ==
X-Google-Smtp-Source: ABdhPJxg9UEEF5mhooE2LBblkVRxbAR7gchJy5pFhOIcp9LR+fkFKHf8HHB4jEGOs7TETXeFkzLG9w==
X-Received: by 2002:a17:902:d0d2:b0:14f:d360:c103 with SMTP id n18-20020a170902d0d200b0014fd360c103mr22495830pln.7.1646092207659;
        Mon, 28 Feb 2022 15:50:07 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id u25-20020a62ed19000000b004f140515d56sm14213333pfh.46.2022.02.28.15.50.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Feb 2022 15:50:07 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <A6BAF3BC-96A6-4EBB-82DB-BBB3AF078BA0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2BBCF1DB-5776-4C6B-BD6A-64CD08C7A3BF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 3/3] e2fsprogs: use mallinfo2 instead of mallinfo if
 available
Date:   Mon, 28 Feb 2022 16:50:06 -0700
In-Reply-To: <20220217092500.40525-3-lczerner@redhat.com>
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org
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


--Apple-Mail=_2BBCF1DB-5776-4C6B-BD6A-64CD08C7A3BF
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






--Apple-Mail=_2BBCF1DB-5776-4C6B-BD6A-64CD08C7A3BF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmIdX64ACgkQcqXauRfM
H+CmWBAAoiNV+ll2z+T6lSoZKMTirPVZQRhuwW34PcdWfgREPB0MiNeX5MYfB4of
rhmVHk3uW4GPFbBQB9MYwqQNkHqAjqUjAy/Zx37H5eKUt96st34Y9xspiaWUCsnb
8r1/GJ4h4cNZRFZ2fDuOxJQilkTsnpG/BYMJscaOLc2jWaPcXypa+mQ+I/TaEzyb
8i7RedqLTuT9mjeCkSMBjio2hWe5joeY0mwPhgqdowB7ffUjb79BuvjUgo31oGep
EjLVxoXqMbemZOhT72i6q5EDzQdGDLzbhMMymbqHGtcPtLGN64sbsDSDFmlmDocr
eG7/ix2AZVrF1y9B3m/otf/e9K5sMPEUeukwJRS516PnEnORbKvUecU2+NcKP9mE
fn1I7AvO1J8m4yg6feCjkSbBVLtX+NLTjJJpIo9y9Zae7m3iGrwjoC8BvwkCZHI3
+QpkcKl593vDH0dkd5oradJoBXgPM1fQbIzEXzz+gRmzlEuXmMzvqcP7m+n61xqN
5dM+RROzcc7VAYCSQvnHFlP/2+mqORKaTCaUO9JgFadulxAcD+hDB+eLjEa4EK6l
n8KkP5ysPGaof/jvG+P3xOjoVHcl9JCGw1bzKVCX2we2bncn302EhzqHUtvOYqTH
3wGf0CjjbBAWciMgBLwN5fTR6Sg19JSJCnDD5udx5jgQhZHoHvI=
=tDPK
-----END PGP SIGNATURE-----

--Apple-Mail=_2BBCF1DB-5776-4C6B-BD6A-64CD08C7A3BF--
