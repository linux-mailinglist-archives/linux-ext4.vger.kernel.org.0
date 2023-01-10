Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EE2663804
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Jan 2023 05:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjAJEKu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Jan 2023 23:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjAJEKr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 9 Jan 2023 23:10:47 -0500
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFD535929
        for <linux-ext4@vger.kernel.org>; Mon,  9 Jan 2023 20:10:45 -0800 (PST)
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
        by cmsmtp with ESMTP
        id ExqppvWCAl2xSF5yHpzumM; Tue, 10 Jan 2023 04:10:45 +0000
Received: from centos7.dilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id F5yGpZ10Z3fOSF5yGpExhL; Tue, 10 Jan 2023 04:10:45 +0000
X-Authority-Analysis: v=2.4 cv=J8G5USrS c=1 sm=1 tr=0 ts=63bce545
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=HIemJr-ISWl06myyT58A:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] build: split version and release in configure
Date:   Mon,  9 Jan 2023 21:10:39 -0700
Message-Id: <1673323839-14670-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.3.1
X-CMAE-Envelope: MS4xfNOsYC2LJNah9IqvewjlxrRXKW2b+GMPpH/5XsUlAV1N6tNGLfxLG7g7rXxNVc0Y7RZ3Z/11j7esGgNbF9427DEs0sSkbCoHiXFVUtNd2ByPZ2ilIkZm
 j7Zj47fk6BfjQ7VVi7HsiQf1JsijFGijnxZR+kz9EldCuewvpJv1uEkf0y4vrUEkxl0ih9XlGyeY/spjLikgNuQN7wP5o2vtvKn8ljVwTYLhWVtwQKVbePYj
 /H2+P3dwuzK+IMa4MeJX7Q==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update configure.ac to separate Version from Release if there is
a '-' in version.h::E2FSPROGS_VERSION (e.g. "1.46.6-rc1").

Simplify the generation of E2FSPROGS_VERESION, E2FSPROGS_DATE and
E2FSPROGS_DAY to avoid multiple grep/awk/sed/tr stages.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 configure           | 17 +++++++++--------
 configure.ac        | 18 ++++++++++--------
 util/gen-tarball.in |  7 ++++---
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index caf6661df318..ea364e551eca 100755
--- a/configure
+++ b/configure
@@ -824,6 +824,7 @@ build_cpu
 build
 E2FSPROGS_DATE
 E2FSPROGS_PKGVER
+E2FSPROGS_PKGREL
 E2FSPROGS_VERSION
 E2FSPROGS_DAY
 E2FSPROGS_MONTH
@@ -4581,11 +4582,9 @@ fi
 MCONFIG=./MCONFIG
 
 BINARY_TYPE=bin
-E2FSPROGS_VERSION=`grep E2FSPROGS_VERSION ${srcdir}/version.h  \
-	| awk '{print $3}' | tr \" " " | awk '{print $1}'`
-E2FSPROGS_DATE=`grep E2FSPROGS_DATE ${srcdir}/version.h | awk '{print $3}' \
-	| tr \" " " | awk '{print $1}'`
-E2FSPROGS_DAY=$(echo $E2FSPROGS_DATE | awk -F- '{print $1}' | sed -e '/^[1-9]$/s/^/0/')
+E2FSPROGS_VERSION=`awk -F\" '/E2FSPROGS_VERS/ { print $2 }' ${srcdir}/version.h`
+E2FSPROGS_DATE=`awk -F\" '/E2FSPROGS_DATE/ { print $2 }' ${srcdir}/version.h`
+E2FSPROGS_DAY=$(echo $E2FSPROGS_DATE | awk -F- '{ printf "%02d", $1 }')
 MONTH=`echo $E2FSPROGS_DATE | awk -F- '{print $2}'`
 YEAR=`echo $E2FSPROGS_DATE | awk -F- '{print $3}'`
 
@@ -4614,17 +4613,19 @@ Dec)	MONTH_NUM=12; E2FSPROGS_MONTH="December" ;;
 printf "%s\n" "$as_me: WARNING: Unknown month $MONTH??" >&2;} ;;
 esac
 
-base_ver=`echo $E2FSPROGS_VERSION | \
-	       sed -e 's/-WIP//' -e 's/pre-//' -e 's/-PLUS//'`
+base_ver=`echo $E2FSPROGS_VERSION | sed -e 's/pre-//' -e 's/-.*//'`
+base_rel=`echo $E2FSPROGS_VERSION | awk -F- '{ print $2 }'`
 
 date_spec=${E2FSPROGS_YEAR}.${MONTH_NUM}.${E2FSPROGS_DAY}
 
 case $E2FSPROGS_VERSION in
 *-WIP|pre-*)
-	E2FSPROGS_PKGVER="$base_ver~WIP.$date_spec"
+	E2FSPROGS_PKGVER="$base_ver"
+	E2FSPROGS_PKGREL="WIP.$date_spec"
 	;;
 *)
 	E2FSPROGS_PKGVER="$base_ver"
+	E2FSPROGS_PKGREL="$base_rel"
 	;;
 esac
 
diff --git a/configure.ac b/configure.ac
index 4ece83e9ba22..0dc28d2316cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -11,11 +11,9 @@ BINARY_TYPE=bin
 dnl
 dnl This is to figure out the version number and the date....
 dnl
-E2FSPROGS_VERSION=`grep E2FSPROGS_VERSION ${srcdir}/version.h  \
-	| awk '{print $3}' | tr \" " " | awk '{print $1}'`
-E2FSPROGS_DATE=`grep E2FSPROGS_DATE ${srcdir}/version.h | awk '{print $3}' \
-	| tr \" " " | awk '{print $1}'`
-E2FSPROGS_DAY=$(echo $E2FSPROGS_DATE | awk -F- '{print $1}' | sed -e '/^[[1-9]]$/s/^/0/')
+E2FSPROGS_VERSION=`awk -F\" '/E2FSPROGS_VERS/ { print $2 }' ${srcdir}/version.h`
+E2FSPROGS_DATE=`awk -F\" '/E2FSPROGS_DATE/ { print $2 }' ${srcdir}/version.h`
+E2FSPROGS_DAY=$(echo $E2FSPROGS_DATE | awk -F- '{ printf "%02d", $1 }')
 MONTH=`echo $E2FSPROGS_DATE | awk -F- '{print $2}'`
 YEAR=`echo $E2FSPROGS_DATE | awk -F- '{print $3}'`
 
@@ -43,27 +41,31 @@ Dec)	MONTH_NUM=12; E2FSPROGS_MONTH="December" ;;
 *)	AC_MSG_WARN([Unknown month $MONTH??]) ;;
 esac
 
-base_ver=`echo $E2FSPROGS_VERSION | \
-	       sed -e 's/-WIP//' -e 's/pre-//' -e 's/-PLUS//'`
+base_ver=`echo $E2FSPROGS_VERSION | sed -e 's/pre-//' -e 's/-.*//'`
+base_rel=`echo $E2FSPROGS_VERSION | awk -F- '{ print $2 }'`
 
 date_spec=${E2FSPROGS_YEAR}.${MONTH_NUM}.${E2FSPROGS_DAY}
 
 case $E2FSPROGS_VERSION in
 *-WIP|pre-*)
-	E2FSPROGS_PKGVER="$base_ver~WIP.$date_spec"
+	E2FSPROGS_PKGVER="$base_ver"
+	E2FSPROGS_PKGREL="WIP.$date_spec"
 	;;
 *)
 	E2FSPROGS_PKGVER="$base_ver"
+	E2FSPROGS_PKGREL="$base_rel"
 	;;
 esac
 
 unset DATE MONTH YEAR base_ver pre_vers date_spec
 AC_MSG_RESULT([Generating configuration file for e2fsprogs version $E2FSPROGS_VERSION])
+AC_MSG_RESULT([Package version ${E2FSPROGS_PKGVER} release ${E2FSPROGS_PKGREL}])
 AC_MSG_RESULT([Release date is ${E2FSPROGS_MONTH}, ${E2FSPROGS_YEAR}])
 AC_SUBST(E2FSPROGS_YEAR)
 AC_SUBST(E2FSPROGS_MONTH)
 AC_SUBST(E2FSPROGS_DAY)
 AC_SUBST(E2FSPROGS_VERSION)
+AC_SUBST(E2FSPROGS_PKGREL)
 AC_SUBST(E2FSPROGS_PKGVER)
 AC_SUBST(E2FSPROGS_DATE)
 dnl
diff --git a/util/gen-tarball.in b/util/gen-tarball.in
index 997bd935f730..650d3b5930ae 100644
--- a/util/gen-tarball.in
+++ b/util/gen-tarball.in
@@ -5,7 +5,8 @@
 srcdir=@srcdir@
 top_srcdir=@top_srcdir@
 top_dir=`cd $top_srcdir; pwd`
-base_ver=`echo @E2FSPROGS_VERSION@ | sed -e 's/-WIP//' -e 's/pre-//' -e 's/-PLUS//'`
+base_ver=`echo @E2FSPROGS_PKGVER@`
+base_rel=`echo @E2FSPROGS_PKGREL@`
 base_e2fsprogs=`basename $top_dir`
 exclude=/tmp/exclude$$
 GZIP=gzip
@@ -16,12 +17,12 @@ GZIP=gzip
 # using a non-standard directory name for WIP releases.  dpkg-source
 # complains, but life goes on.
 #
-deb_pkgver=`echo @E2FSPROGS_PKGVER@ | sed -e 's/~/-/g'`
+deb_pkgver="$base_ver${base_rel:+-$base_rel}"
     
 case $1 in
     debian|ubuntu)
 	SRCROOT="e2fsprogs-$deb_pkgver"
-	tarout="e2fsprogs_@E2FSPROGS_PKGVER@.orig.tar.gz"
+	tarout="e2fsprogs_$deb_pkgver.orig.tar.gz"
 	;;
    all|*)
 	SRCROOT="e2fsprogs-$base_ver"
-- 
1.8.3.1

