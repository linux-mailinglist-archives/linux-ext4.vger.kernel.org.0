Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C206FD5A7
	for <lists+linux-ext4@lfdr.de>; Wed, 10 May 2023 06:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjEJE7i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 May 2023 00:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjEJE7h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 May 2023 00:59:37 -0400
X-Greylist: delayed 91 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 May 2023 21:59:34 PDT
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8AA120
        for <linux-ext4@vger.kernel.org>; Tue,  9 May 2023 21:59:34 -0700 (PDT)
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
        by cmsmtp with ESMTP
        id wQ9ppqHaP6Nwhwbtrp6XnV; Wed, 10 May 2023 04:58:03 +0000
Received: from centos7.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id wbtqpn8Qacyvuwbtqp377c; Wed, 10 May 2023 04:58:03 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=645b245b
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=RPJ6JBhKAAAA:8
 a=HIemJr-ISWl06myyT58A:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH RESEND] build: split version and release in configure
Date:   Tue,  9 May 2023 22:57:57 -0600
Message-Id: <1683694677-9366-1-git-send-email-adilger@dilger.ca>
X-Mailer: git-send-email 1.8.3.1
X-CMAE-Envelope: MS4xfKHG9DlWRST8IY6/s1DKwvh5qfiTD6LM1g9aS0Sk9UZJij8dyQT+RSDrXynD5n4lclHMewfR3yF0Km95W1oaV3CqCPs8eBqlW45MC1KQ98cuQP17v21W
 5T6PCqqyza+BE7TONmzQbnqfcEJPx64jSBJkKEEIC6PJ24Eox7n0o2u1oXO04Bg9Z0AbawyMWtFqW1vQPGOZLXn3TwJGe690st2ymn9sYKHdQD6T4H4hpTuh
 ImS3tU50BOEPN2Sj/Bth6Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Update configure.ac to separate Version from Release if there is
a '-' in version.h::E2FSPROGS_VERSION (e.g. "1.46.6-rc1").
Otherwise, the '-' in the version can make RPM building unhappy.

Simplify the generation of E2FSPROGS_VERESION, E2FSPROGS_DATE and
E2FSPROGS_DAY to avoid multiple grep/awk/sed/tr stages.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 configure           | 17 +++++++++--------
 configure.ac        | 18 ++++++++++--------
 util/gen-tarball.in |  7 ++++---
 3 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/configure b/configure
index b0e8d1bf8f87..9d616937a38a 100755
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
@@ -4583,11 +4584,9 @@ fi
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
 
@@ -4616,17 +4615,19 @@ Dec)	MONTH_NUM=12; E2FSPROGS_MONTH="December" ;;
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
index 017a96ffe290..5b4dd7940372 100644
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

