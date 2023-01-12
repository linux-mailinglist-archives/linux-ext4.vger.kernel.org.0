Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B82666795
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jan 2023 01:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjALAXK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Jan 2023 19:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjALAXJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Jan 2023 19:23:09 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5132E321B5
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 16:23:07 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 36so11676875pgp.10
        for <linux-ext4@vger.kernel.org>; Wed, 11 Jan 2023 16:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJ+18LhKFJwe0+8el9N3/mqB3hXiObw6xCpPHTzEGI=;
        b=xSAVyQkqIy+VgrPlFed9AT23sMF2WrrWQu+eS4TQyVKmUgVq2kin3IEBWONk2OBnMR
         5Xqfeh96to9QIMCb+DDBnLfHZiIWIKTijfhB3l4k/Le2osKprFsiqin0hXRZBrG71e5a
         bPW9vY9pM7DATfptsIqk9ecFEwaWlBzJbpHslFhB4pSIFef276qsy6AkXmMWFF3wiJpG
         m0KdZfVTAD0GmdRcwLxJHCEbjzy+0aIskXn9Po4xP9+4PMIdcFLOKbuzWh1JY6XGQYbD
         FWwNQfLnLPX3IqE6wXhz0+Z/oQ/FYBIDO/6HaI13jHyDvXysIUkxq13tDlz3klMhsKfp
         AxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJ+18LhKFJwe0+8el9N3/mqB3hXiObw6xCpPHTzEGI=;
        b=G5UFHgnqGlT8oe7SJKziq7/n/ksJ7HqRyfSK/b5vH1ZmyLnfWMTk4sxEULxvEQmsd3
         /d3RABSuzdH3Vs/3+SLvVeNe3bgdP81CSCTvgTTo2xQ3lubDpqo/E8yxVYHen6kkvt98
         6DWM/6uexU6Js0OHUtgDRNFmhAMwwoYvgFsGB3Z7/UtvuiC4Zn7Z754z18EcLv2Ai6wh
         uJLo/SLHfdqx1/vsVRs7tRfYfYDlPhAwBwNTzrGVig5ouNYI/7Dnf+kKfgeymyVTedJ9
         UENVPY9nevwIrbzhY/0yPo2Rp6p+tP1vOb354IZa28lgH9t164rS5NrqOd54omtcBVNp
         BlIw==
X-Gm-Message-State: AFqh2koj7E2T4wK+9fpjFjeq2OLcW7tWvilRhWfzsyubmZtzbVRQPjcE
        kxjI3l561NMuwltMFKQ1uvSarbBAeOrt6oH6LUY=
X-Google-Smtp-Source: AMrXdXt6owyCu04JFiclialT/Gd4tgDb++6VoYhwR6ZUGTkPImzVymNaNBnbEJjQ1I6boApkHZw5hA==
X-Received: by 2002:aa7:9156:0:b0:57e:f1a2:1981 with SMTP id 22-20020aa79156000000b0057ef1a21981mr79013921pfi.8.1673482986659;
        Wed, 11 Jan 2023 16:23:06 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id v67-20020a622f46000000b00581ad007a9fsm10501021pfv.153.2023.01.11.16.23.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2023 16:23:05 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3789097A-B108-4247-9CFE-886B1A068503@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_12C7456B-139B-452B-A198-8AEF40F7E9B0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] build: split version and release in configure
Date:   Wed, 11 Jan 2023 17:23:02 -0700
In-Reply-To: <1673323839-14670-1-git-send-email-adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <1673323839-14670-1-git-send-email-adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_12C7456B-139B-452B-A198-8AEF40F7E9B0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 9, 2023, at 9:10 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> Update configure.ac to separate Version from Release if there is
> a '-' in version.h::E2FSPROGS_VERSION (e.g. "1.46.6-rc1").
>=20
> Simplify the generation of E2FSPROGS_VERESION, E2FSPROGS_DATE and
> E2FSPROGS_DAY to avoid multiple grep/awk/sed/tr stages.
>=20
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>

Ted,
indirectly related to this patch,  I also noticed that configure.ac
is not setting the version or URL fields in AC_INIT, as is typical.
I'm not sure if that was intentional, or if AC_INIT usage predates
this functionality in autoconf?

That leaves the PACKAGE_NAME, PACKAGE_TARNAME, PACKAGE_BUGREPORT,
PACKAGE_URL, and PACKAGE_STRING macros undefined in the configure file,
and these are used in some messages, and can generate a warning in
some autoconf versions.

We could initialize some of these values from version.h if you prefer
to use that as the canonical version source, or do the reverse and
declare the release version via AC_INIT and #define PACKAGE_VERSION
and/or E2FSPROGS_VERSION defined in config.h instead of version.h?

I was looking at adding the following at the top of configure.ac:

AC_INIT([e2fsprogs],
        m4_esyscmd_s({awk -F\" '/E2FSPROGS_VER/ { print $2 }' =
version.h]),
        [https://tracker.debian.org/pkg/e2fsprogs/],
        [e2fsprogs],
        [https://e2fsprogs.sourceforge.net/])
dnl closing quote to make syntax highlighting happy"

so that it extracts the canonical version from version.h so your =
workflow
is not changed, but this does mean that "configure" would be modified =
for
each new release.  This generates the following defines in configure.ac:

PACKAGE_NAME=3D'e2fsprogs'
PACKAGE_TARNAME=3D'e2fsprogs'
PACKAGE_VERSION=3D1.46.6-rc1
PACKAGE_STRING=3D'e2fsprogs 1.46.6-rc1'
PACKAGE_BUGREPORT=3D'https://tracker.debian.org/pkg/e2fsprogs/'
PACKAGE_URL=3D'https://e2fsprogs.sourceforge.net/'

I was originally going to use sourceforge.net for the PACKAGE_BUGREPORT =
URL,
since that is the URL reported in most of the header files, but I had a
look at the issues there and they are all 10 years old.  It looks like
debian.org is the only place where issues are tracked.

Cheers, Andreas

> ---
> configure           | 17 +++++++++--------
> configure.ac        | 18 ++++++++++--------
> util/gen-tarball.in |  7 ++++---
> 3 files changed, 23 insertions(+), 19 deletions(-)
>=20
> diff --git a/configure b/configure
> index caf6661df318..ea364e551eca 100755
> --- a/configure
> +++ b/configure
> @@ -824,6 +824,7 @@ build_cpu
> build
> E2FSPROGS_DATE
> E2FSPROGS_PKGVER
> +E2FSPROGS_PKGREL
> E2FSPROGS_VERSION
> E2FSPROGS_DAY
> E2FSPROGS_MONTH
> @@ -4581,11 +4582,9 @@ fi
> MCONFIG=3D./MCONFIG
>=20
> BINARY_TYPE=3Dbin
> -E2FSPROGS_VERSION=3D`grep E2FSPROGS_VERSION ${srcdir}/version.h  \
> -	| awk '{print $3}' | tr \" " " | awk '{print $1}'`
> -E2FSPROGS_DATE=3D`grep E2FSPROGS_DATE ${srcdir}/version.h | awk =
'{print $3}' \
> -	| tr \" " " | awk '{print $1}'`
> -E2FSPROGS_DAY=3D$(echo $E2FSPROGS_DATE | awk -F- '{print $1}' | sed =
-e '/^[1-9]$/s/^/0/')
> +E2FSPROGS_VERSION=3D`awk -F\" '/E2FSPROGS_VERS/ { print $2 }' =
${srcdir}/version.h`
> +E2FSPROGS_DATE=3D`awk -F\" '/E2FSPROGS_DATE/ { print $2 }' =
${srcdir}/version.h`
> +E2FSPROGS_DAY=3D$(echo $E2FSPROGS_DATE | awk -F- '{ printf "%02d", $1 =
}')
> MONTH=3D`echo $E2FSPROGS_DATE | awk -F- '{print $2}'`
> YEAR=3D`echo $E2FSPROGS_DATE | awk -F- '{print $3}'`
>=20
> @@ -4614,17 +4613,19 @@ Dec)	MONTH_NUM=3D12; =
E2FSPROGS_MONTH=3D"December" ;;
> printf "%s\n" "$as_me: WARNING: Unknown month $MONTH??" >&2;} ;;
> esac
>=20
> -base_ver=3D`echo $E2FSPROGS_VERSION | \
> -	       sed -e 's/-WIP//' -e 's/pre-//' -e 's/-PLUS//'`
> +base_ver=3D`echo $E2FSPROGS_VERSION | sed -e 's/pre-//' -e 's/-.*//'`
> +base_rel=3D`echo $E2FSPROGS_VERSION | awk -F- '{ print $2 }'`
>=20
> date_spec=3D${E2FSPROGS_YEAR}.${MONTH_NUM}.${E2FSPROGS_DAY}
>=20
> case $E2FSPROGS_VERSION in
> *-WIP|pre-*)
> -	E2FSPROGS_PKGVER=3D"$base_ver~WIP.$date_spec"
> +	E2FSPROGS_PKGVER=3D"$base_ver"
> +	E2FSPROGS_PKGREL=3D"WIP.$date_spec"
> 	;;
> *)
> 	E2FSPROGS_PKGVER=3D"$base_ver"
> +	E2FSPROGS_PKGREL=3D"$base_rel"
> 	;;
> esac
>=20
> diff --git a/configure.ac b/configure.ac
> index 4ece83e9ba22..0dc28d2316cc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -11,11 +11,9 @@ BINARY_TYPE=3Dbin
> dnl
> dnl This is to figure out the version number and the date....
> dnl
> -E2FSPROGS_VERSION=3D`grep E2FSPROGS_VERSION ${srcdir}/version.h  \
> -	| awk '{print $3}' | tr \" " " | awk '{print $1}'`
> -E2FSPROGS_DATE=3D`grep E2FSPROGS_DATE ${srcdir}/version.h | awk =
'{print $3}' \
> -	| tr \" " " | awk '{print $1}'`
> -E2FSPROGS_DAY=3D$(echo $E2FSPROGS_DATE | awk -F- '{print $1}' | sed =
-e '/^[[1-9]]$/s/^/0/')
> +E2FSPROGS_VERSION=3D`awk -F\" '/E2FSPROGS_VERS/ { print $2 }' =
${srcdir}/version.h`
> +E2FSPROGS_DATE=3D`awk -F\" '/E2FSPROGS_DATE/ { print $2 }' =
${srcdir}/version.h`
> +E2FSPROGS_DAY=3D$(echo $E2FSPROGS_DATE | awk -F- '{ printf "%02d", $1 =
}')
> MONTH=3D`echo $E2FSPROGS_DATE | awk -F- '{print $2}'`
> YEAR=3D`echo $E2FSPROGS_DATE | awk -F- '{print $3}'`
>=20
> @@ -43,27 +41,31 @@ Dec)	MONTH_NUM=3D12; =
E2FSPROGS_MONTH=3D"December" ;;
> *)	AC_MSG_WARN([Unknown month $MONTH??]) ;;
> esac
>=20
> -base_ver=3D`echo $E2FSPROGS_VERSION | \
> -	       sed -e 's/-WIP//' -e 's/pre-//' -e 's/-PLUS//'`
> +base_ver=3D`echo $E2FSPROGS_VERSION | sed -e 's/pre-//' -e 's/-.*//'`
> +base_rel=3D`echo $E2FSPROGS_VERSION | awk -F- '{ print $2 }'`
>=20
> date_spec=3D${E2FSPROGS_YEAR}.${MONTH_NUM}.${E2FSPROGS_DAY}
>=20
> case $E2FSPROGS_VERSION in
> *-WIP|pre-*)
> -	E2FSPROGS_PKGVER=3D"$base_ver~WIP.$date_spec"
> +	E2FSPROGS_PKGVER=3D"$base_ver"
> +	E2FSPROGS_PKGREL=3D"WIP.$date_spec"
> 	;;
> *)
> 	E2FSPROGS_PKGVER=3D"$base_ver"
> +	E2FSPROGS_PKGREL=3D"$base_rel"
> 	;;
> esac
>=20
> unset DATE MONTH YEAR base_ver pre_vers date_spec
> AC_MSG_RESULT([Generating configuration file for e2fsprogs version =
$E2FSPROGS_VERSION])
> +AC_MSG_RESULT([Package version ${E2FSPROGS_PKGVER} release =
${E2FSPROGS_PKGREL}])
> AC_MSG_RESULT([Release date is ${E2FSPROGS_MONTH}, ${E2FSPROGS_YEAR}])
> AC_SUBST(E2FSPROGS_YEAR)
> AC_SUBST(E2FSPROGS_MONTH)
> AC_SUBST(E2FSPROGS_DAY)
> AC_SUBST(E2FSPROGS_VERSION)
> +AC_SUBST(E2FSPROGS_PKGREL)
> AC_SUBST(E2FSPROGS_PKGVER)
> AC_SUBST(E2FSPROGS_DATE)
> dnl
> diff --git a/util/gen-tarball.in b/util/gen-tarball.in
> index 997bd935f730..650d3b5930ae 100644
> --- a/util/gen-tarball.in
> +++ b/util/gen-tarball.in
> @@ -5,7 +5,8 @@
> srcdir=3D@srcdir@
> top_srcdir=3D@top_srcdir@
> top_dir=3D`cd $top_srcdir; pwd`
> -base_ver=3D`echo @E2FSPROGS_VERSION@ | sed -e 's/-WIP//' -e =
's/pre-//' -e 's/-PLUS//'`
> +base_ver=3D`echo @E2FSPROGS_PKGVER@`
> +base_rel=3D`echo @E2FSPROGS_PKGREL@`
> base_e2fsprogs=3D`basename $top_dir`
> exclude=3D/tmp/exclude$$
> GZIP=3Dgzip
> @@ -16,12 +17,12 @@ GZIP=3Dgzip
> # using a non-standard directory name for WIP releases.  dpkg-source
> # complains, but life goes on.
> #
> -deb_pkgver=3D`echo @E2FSPROGS_PKGVER@ | sed -e 's/~/-/g'`
> +deb_pkgver=3D"$base_ver${base_rel:+-$base_rel}"
>=20
> case $1 in
>     debian|ubuntu)
> 	SRCROOT=3D"e2fsprogs-$deb_pkgver"
> -	tarout=3D"e2fsprogs_@E2FSPROGS_PKGVER@.orig.tar.gz"
> +	tarout=3D"e2fsprogs_$deb_pkgver.orig.tar.gz"
> 	;;
>    all|*)
> 	SRCROOT=3D"e2fsprogs-$base_ver"
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_12C7456B-139B-452B-A198-8AEF40F7E9B0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmO/UuYACgkQcqXauRfM
H+DwpRAAqpk7miw5M544NN5uGklZFQVfy6IMUu2alfBOec+GTH6zhptSnEG+ALSH
QwRxExmjfvNscWdHXc5aO8nilA7Yx0iKJZYkZt/VconZhoXmfcuLwUSgFwMrAzrp
eCz6br5jPRhPaaCZLT2c3WAUbDoM1X6Njc6u7h9BE7Q3GjUdbI0YGWtjEEcEJuCy
gJdDRPyEjjJayCQgM2GUaOYaGA49LUzuoS5KB4v2pjzqImQKfTCNrI8R1fW4BQ4Z
lrhODgPpCgRoSR/Q9P+Xih5ejYmsatZNRxq2JbW1eLqrspRJ+rRYTu/gDROAibAo
tMUZzz7Hsi8IRd2lB1Sx3SSk3YsDRAK64wYN76Z2APRlPHuycOVd+rEiuiusaEvG
51V77D4chp9GksgKR72sDMmV+vQPOk9Jk0LfJT6IkSR8Bn4JWZN9CSnfjgFzAL57
5HhipZHMR6aQHohhRNCsBEDZ3VEhcGjMg+zRhm4tXOPmWEMgE5pr+iGNelV+XOZ8
VjbnTnnMrbr6PnNRNWKvnyF/psXoLPdxwj9fnmoERLGUbHrmfLBb6yUaLwh8BV6F
iB+eGlK0fXnbBlWFZgARqqc+WxxdcQUdnKpiI3RTQCKL2fWGp8U4vobaf0y4yuon
Rb4qSNNxRJWjh9AM+6pqg0z7TI7AZrIstZsf4SUmNk8OINbdKx4=
=Pbke
-----END PGP SIGNATURE-----

--Apple-Mail=_12C7456B-139B-452B-A198-8AEF40F7E9B0--
