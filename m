Return-Path: <linux-ext4+bounces-6698-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E2A558CE
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 22:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319BA189692D
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 21:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7E207A10;
	Thu,  6 Mar 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="t70dbjDR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110B277020
	for <linux-ext4@vger.kernel.org>; Thu,  6 Mar 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296645; cv=none; b=Mcty+6GsOrRyyGynK39A3W4cZYu9VI4eXkZa1256IaXIoMY6U1LoQ97f828C2+UIFyT+pe9kYcgu3yh01UiUeZGX1jBHZt7LkgjCaIffMXzUn6glO2fcdNO6q139IQsNlOB/S5QWlP/HrxcuwFOCIKDMqRiIXNUdvnIcd6NeItM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296645; c=relaxed/simple;
	bh=AiR0DU52eslFdBh7e+pgyRnLfYWJ1U0nl0q1vcshKbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY3Ta/KQRGuG0yzS3Em8Fgm8LWrOxF8PrpFTwmrveRlQ2jyUBbKZ4coSOBtISS+UW3NkuRrDMGSn9FfbbYZreX0uAd06qvmBJM7ZQbiaMI6BRZZYWvLVd3M3NM1R8TKy1VqqSNOY46qJj8r0kUEaUkA5JForbw5RAD9qwll1d+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=t70dbjDR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22409077c06so25223375ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 06 Mar 2025 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1741296642; x=1741901442; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBweP0B09ntGSuAWsrY3fZWd3abEiIQrw7MYskEwZpA=;
        b=t70dbjDR/Jai1KZRV9T8iPL/TUv+4yZcKXpsnRlP3D2AuiPOAAjYPrDVygVUmqXKgE
         ZZSYprCyb8hYZ6p2E9iFRCaUmHf3iZDuBuiEZopzTNE3shH4VcGhhoJwr0WPhmPXAnck
         vTt4HlHSGfjvc8gupwEbQq9xxwqYPDfC+E/ABHzKFa456+2sdnyoVrGIToNQ9TeiU0mw
         5F8nW7I9T+UeY9G5JtNHPyj4rJGjmYgtPmCQj3CZrwHRDfTSsgcfEN5CS3KI+IpO7dH2
         oMYZaLKKCyQXs4Ie0IPNXmJum5F+6t4ldgj4bXagXc0svin3yVajJPdN6P2dX3+4JQyS
         1q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741296642; x=1741901442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBweP0B09ntGSuAWsrY3fZWd3abEiIQrw7MYskEwZpA=;
        b=wK9yg8pLDjUMr0dyVN9RYtYWAck55E4U5vDHoYe14596L8//X4QI9YYMbcl0pBpwy1
         G20JFV1nGXsEulLnK49qQZpsmW2y4JdFVzOAAlpUng5IckEUnehsFreIVDxeTjYeGDTA
         h2K26nNEMLiR2PU4F69Pofzcs2BzN/iR0UyHo3sttlrUqOdqlLiNV5Oh2mwkLYKYaOKh
         6DOrMNwjt7/raptn9eWBnji4CV7uVzFfa91pBX6pYQjHrvdBbA9DUzxS+FNtmCVn/6Wr
         GkyNHuYmC6cCVjDil99RJucVkoLD32+OZB+Lb5wotK7zaq0mlFQ+RkTtJNddHuxNHp7x
         N9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCW69e942JBejez44TgsjKldSaGZCClHsO8s7KpqHUUpyjCrIIAezim1bH7EKd37cZ5ufhyOrHg3Mshp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CjIGUnV/HDG/obeCqhrnalMchO0EXI5FNy5LuUGjbracQjb8
	vWiGgoetcFRUJLMEQxvCNz7PEhP5sX7ReuByWrYBy56DfVjge8HE8Vg1vOUywfo=
X-Gm-Gg: ASbGncug0IUUF7Cap5nqc7YsXHLDAokcaEOuQxCB0TOSUNfOpZfWFhpNdN0CdFsm/0A
	bgjJzxm/1Pyhmf6kluMXuzMXf6OTt+GZOBVvJcFx2qPaqIJ5Z/PLVG2S1fQAK6dZ/YREH1XlnxV
	I7gulZLXaFumNbjz8kI/yO0hwipK4xh8WgEcmIveaWvzNeOaSuDqqcXkGPtGobTtpk86x/FRK1h
	DIYEELz3KDXVH4RbEw6MDBSQYRjd36ICwN6xsZdiPCIiq0QE4zbOVaZv/r5BCXdBdjacZpkYZ2K
	vPfGE2CvQVyBVhvkC63LG+fBlg+y6/21ejyYs88aI0LRtzX60yJXEoDT30ZlXJZPQyrfPRq0/OJ
	P+hKLRC0/9w==
X-Google-Smtp-Source: AGHT+IHcX8bT6TXAq8vebw/1MmP/Ome/JNiO0yP6veJ7tbm3F3pBWDNWQO3mRZ+2g3hVVwtKBWdfEQ==
X-Received: by 2002:a17:902:f681:b0:224:179a:3b8f with SMTP id d9443c01a7336-22428a8cd24mr10809675ad.23.1741296641943;
        Thu, 06 Mar 2025 13:30:41 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a80f31sm17140035ad.118.2025.03.06.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:30:41 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tqIne-00000009lLu-0Mz7;
	Fri, 07 Mar 2025 08:30:38 +1100
Date: Fri, 7 Mar 2025 08:30:38 +1100
From: Dave Chinner <david@fromorbit.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org
Subject: Re: [PATCH v1 2/2] check,common/{preamble,rc},soak: Decoupling
 init_rc() call from sourcing common/rc
Message-ID: <Z8oT_tBYG-a79CjA@dread.disaster.area>
References: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
 <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d07e5657c2817c74e939894bb554424199fd290.1741248214.git.nirjhar.roy.lists@gmail.com>

On Thu, Mar 06, 2025 at 08:17:41AM +0000, Nirjhar Roy (IBM) wrote:
> Silently executing scripts during sourcing common/rc doesn't look good
> and also causes unnecessary script execution. Decouple init_rc() call
> and call init_rc() explicitly where required.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

FWIW, I've just done somethign similar for check-parallel. I need to
decouple common/config from common/rc and not run any code from
either common/config or common/rc.

I've included the patch below (it won't apply because there's all
sorts of refactoring for test list and config-section parsing in the
series before it), but it should give you an idea of how I think we
should be separating one-off initialisation environment varaibles,
common code inclusion and the repeated initialisation of section
specific parameters....

.....
> diff --git a/soak b/soak
> index d5c4229a..5734d854 100755
> --- a/soak
> +++ b/soak
> @@ -5,6 +5,7 @@
>  
>  # get standard environment, filters and checks
>  . ./common/rc
> +# ToDo: Do we need an init_rc() here? How is soak used?
>  . ./common/filter

I've also go a patch series that removes all these old 2000-era SGI
QE scripts that have not been used by anyone for the last 15
years. I did that to get rid of the technical debt that these
scripts have gathered over years of neglect. They aren't used, we
shouldn't even attempt to maintain them anymore.

-Dave.

-- 
Dave Chinner
david@fromorbit.com


fstests: separate sourcing common/rc and common/config from initialisation

From: Dave Chinner <dchinner@redhat.com>

The sourcing of common/rc causes code to be run. init_rc
is executed from common/rc, and it includes common/config which
also runs a couple of initialisation functions.

This is messy, because re-sourcing those files also does an awful
lot more setup work than running those a couple of init functions.

common/config only needs to be included once - everything that
scripts then depend on should be exported by it, and hence it should
only be included once from check/check-parallel to set up all the
environmental parameters for the entire run.

common/rc also only needs to be included once per context, but it
does not need to directly include common config nor does it need to
run init_rc in each individual test context.

Seperate out this mess. Include common/config directly where needed
and only use it to set up the environment. Move all the code that is
in common/config to common/rc so that common/config is not needed
for any purpose other than setting up the initial environment.
Move the initialisation functions to the scripts that include
common/config.

Config file and config section parsing can be run directly from check
and/or check-parallel; this is not needed for every context that
needs to know how what XFS_MKFS_PROG is set to...

Similarly, include common/rc only once, and only call init_rc or
_source_specific_fs() from the contexts that actually need that code
to be run.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check             |  24 +++---
 common/config     | 218 --------------------------------------------------
 common/preamble   |   1 +
 common/rc         | 234 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 tests/generic/367 |   7 +-
 tests/generic/749 |   3 +-
 6 files changed, 235 insertions(+), 252 deletions(-)

diff --git a/check b/check
index b4d31d138..b968a134a 100755
--- a/check
+++ b/check
@@ -43,10 +43,12 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
-# We need to include the test list processing first as argument parsing
-# requires test list parsing and setup.
+. ./common/config
+. ./common/config-sections
+. ./common/rc
 . ./common/test_list
 
+
 usage()
 {
     echo "Usage: $0 [options] [testlist]"'
@@ -183,11 +185,15 @@ while [ $# -gt 0 ]; do
 	shift
 done
 
-# we need common/rc, that also sources common/config. We need to source it
-# after processing args, overlay needs FSTYP set before sourcing common/config
-if ! . ./common/rc; then
-	echo "check: failed to source common/rc"
-	exit 1
+# now we have done argument parsing, overlay has FSTYP set and we can now
+# start processing the config files and setting up devices.
+_config_section_setup
+_canonicalize_devices
+init_rc
+
+if [ ! -z "$REPORT_LIST" ]; then
+	. ./common/report
+	_assert_report_list
 fi
 
 # If the test config specified a soak test duration, see if there are any
@@ -601,10 +607,6 @@ function run_section()
 			status=1
 			exit
 		fi
-		# Previous FSTYP derived from TEST_DEV could be changed, source
-		# common/rc again with correct FSTYP to get FSTYP specific configs,
-		# e.g. common/xfs
-		. common/rc
 		_tl_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
diff --git a/common/config b/common/config
index 571e52a58..03970bf54 100644
--- a/common/config
+++ b/common/config
@@ -40,7 +40,6 @@
 #
 
 . common/test_names
-. common/config-sections
 
 # all tests should use a common language setting to prevent golden
 # output mismatches.
@@ -348,220 +347,3 @@ if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
 	export SELINUX_MOUNT_OPTIONS
 fi
 
-_common_mount_opts()
-{
-	case $FSTYP in
-	9p)
-		echo $PLAN9_MOUNT_OPTIONS
-		;;
-	fuse)
-		echo $FUSE_MOUNT_OPTIONS
-		;;
-	xfs)
-		echo $XFS_MOUNT_OPTIONS
-		;;
-	udf)
-		echo $UDF_MOUNT_OPTIONS
-		;;
-	nfs)
-		echo $NFS_MOUNT_OPTIONS
-		;;
-	afs)
-		echo $AFS_MOUNT_OPTIONS
-		;;
-	cifs)
-		echo $CIFS_MOUNT_OPTIONS
-		;;
-	ceph)
-		echo $CEPHFS_MOUNT_OPTIONS
-		;;
-	glusterfs)
-		echo $GLUSTERFS_MOUNT_OPTIONS
-		;;
-	overlay)
-		echo $OVERLAY_MOUNT_OPTIONS
-		;;
-	ext2|ext3|ext4)
-		# acls & xattrs aren't turned on by default on ext$FOO
-		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
-		;;
-	f2fs)
-		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
-		;;
-	reiserfs)
-		# acls & xattrs aren't turned on by default on reiserfs
-		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
-		;;
-       reiser4)
-		# acls & xattrs aren't supported by reiser4
-		echo $REISER4_MOUNT_OPTIONS
-		;;
-	gfs2)
-		# acls aren't turned on by default on gfs2
-		echo "-o acl $GFS2_MOUNT_OPTIONS"
-		;;
-	tmpfs)
-		# We need to specify the size at mount, use 1G by default
-		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
-		;;
-	ubifs)
-		echo $UBIFS_MOUNT_OPTIONS
-		;;
-	*)
-		;;
-	esac
-}
-
-_mount_opts()
-{
-	export MOUNT_OPTIONS=$(_common_mount_opts)
-}
-
-_test_mount_opts()
-{
-	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
-}
-
-_mkfs_opts()
-{
-	case $FSTYP in
-	xfs)
-		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
-		;;
-	udf)
-		[ ! -z "$udf_fsize" ] && \
-			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
-		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
-		;;
-	nfs)
-		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
-		;;
-	afs)
-		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
-		;;
-	cifs)
-		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
-		;;
-	ceph)
-		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
-		;;
-	reiserfs)
-		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
-		;;
-       reiser4)
-		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
-		;;
-	gfs2)
-		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
-		;;
-	jfs)
-		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
-		;;
-	f2fs)
-		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
-		;;
-	btrfs)
-		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
-		;;
-	bcachefs)
-		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
-		;;
-	*)
-		;;
-	esac
-}
-
-_fsck_opts()
-{
-	case $FSTYP in
-	ext2|ext3|ext4)
-		export FSCK_OPTIONS="-nf"
-		;;
-	reiser*)
-		export FSCK_OPTIONS="--yes"
-		;;
-	f2fs)
-		export FSCK_OPTIONS=""
-		;;
-	*)
-		export FSCK_OPTIONS="-n"
-		;;
-	esac
-}
-
-# check necessary running dependences then source sepcific fs helpers
-_source_specific_fs()
-{
-	local fs=$1
-
-	if [ -z "$fs" ];then
-		fs=$FSTYP
-	fi
-
-	case "$fs" in
-	xfs)
-		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
-		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
-		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
-		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
-		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
-
-		. ./common/xfs
-		;;
-	udf)
-		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
-		;;
-	btrfs)
-		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
-
-		. ./common/btrfs
-		;;
-	ext4)
-		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
-		. ./common/ext4
-		;;
-	ext2|ext3)
-		. ./common/ext4
-		;;
-	f2fs)
-		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
-		;;
-	nfs)
-		. ./common/nfs
-		;;
-	afs)
-		;;
-	cifs)
-		;;
-	9p)
-		;;
-	fuse)
-		;;
-	ceph)
-		. ./common/ceph
-		;;
-	glusterfs)
-		;;
-	overlay)
-		. ./common/overlay
-		;;
-	reiser4)
-		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
-		;;
-	pvfs2)
-		;;
-	ubifs)
-		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
-		. ./common/ubifs
-		;;
-	esac
-}
-
-_config_section_setup
-_canonicalize_devices
-# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
-# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
-export TEST_DEV
-
-# make sure this script returns success
-/bin/true
diff --git a/common/preamble b/common/preamble
index 0c9ee2e03..1f40dd5d1 100644
--- a/common/preamble
+++ b/common/preamble
@@ -50,6 +50,7 @@ _begin_fstest()
 	_register_cleanup _cleanup
 
 	. ./common/rc
+	_source_specific_fs $FSTYP
 
 	# remove previous $seqres.full before test
 	rm -f $seqres.full $seqres.hints
diff --git a/common/rc b/common/rc
index 056112714..01f8cba2e 100644
--- a/common/rc
+++ b/common/rc
@@ -2,10 +2,11 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
-. common/config
-
 BC="$(type -P bc)" || BC=
 
+# make sure we have a standard umask
+umask 022
+
 # Don't use sync(1) directly if at all possible. In most cases we only need to
 # sync the fs under test, so we use syncfs if it is supported to prevent
 # disturbance of other tests that may be running concurrently.
@@ -250,17 +251,6 @@ _log_err()
     echo "(see $seqres.full for details)"
 }
 
-# make sure we have a standard umask
-umask 022
-
-# check for correct setup and source the $FSTYP specific functions now
-_source_specific_fs $FSTYP
-
-if [ ! -z "$REPORT_LIST" ]; then
-	. ./common/report
-	_assert_report_list
-fi
-
 _get_filesize()
 {
     stat -c %s "$1"
@@ -4895,6 +4885,8 @@ init_rc()
 		exit 1
 	fi
 
+	_source_specific_fs $FSTYP
+
 	# if $TEST_DEV is not mounted, mount it now as XFS
 	if [ -z "`_fs_type $TEST_DEV`" ]
 	then
@@ -4934,6 +4926,11 @@ init_rc()
 	# it is supported.
 	$XFS_IO_PROG -i -c quit 2>/dev/null && \
 		export XFS_IO_PROG="$XFS_IO_PROG -i"
+
+	# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems.
+	# TEST_DIR and QA_CHECK_FS are also checked by mkfs.xfs, but already
+	# exported elsewhere.
+	export TEST_DEV
 }
 
 # get real device path name by following link
@@ -5757,8 +5754,211 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
-init_rc
+_common_mount_opts()
+{
+	case $FSTYP in
+	9p)
+		echo $PLAN9_MOUNT_OPTIONS
+		;;
+	fuse)
+		echo $FUSE_MOUNT_OPTIONS
+		;;
+	xfs)
+		echo $XFS_MOUNT_OPTIONS
+		;;
+	udf)
+		echo $UDF_MOUNT_OPTIONS
+		;;
+	nfs)
+		echo $NFS_MOUNT_OPTIONS
+		;;
+	afs)
+		echo $AFS_MOUNT_OPTIONS
+		;;
+	cifs)
+		echo $CIFS_MOUNT_OPTIONS
+		;;
+	ceph)
+		echo $CEPHFS_MOUNT_OPTIONS
+		;;
+	glusterfs)
+		echo $GLUSTERFS_MOUNT_OPTIONS
+		;;
+	overlay)
+		echo $OVERLAY_MOUNT_OPTIONS
+		;;
+	ext2|ext3|ext4)
+		# acls & xattrs aren't turned on by default on ext$FOO
+		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
+		;;
+	f2fs)
+		echo "-o acl,user_xattr $F2FS_MOUNT_OPTIONS"
+		;;
+	reiserfs)
+		# acls & xattrs aren't turned on by default on reiserfs
+		echo "-o acl,user_xattr $REISERFS_MOUNT_OPTIONS"
+		;;
+       reiser4)
+		# acls & xattrs aren't supported by reiser4
+		echo $REISER4_MOUNT_OPTIONS
+		;;
+	gfs2)
+		# acls aren't turned on by default on gfs2
+		echo "-o acl $GFS2_MOUNT_OPTIONS"
+		;;
+	tmpfs)
+		# We need to specify the size at mount, use 1G by default
+		echo "-o size=1G $TMPFS_MOUNT_OPTIONS"
+		;;
+	ubifs)
+		echo $UBIFS_MOUNT_OPTIONS
+		;;
+	*)
+		;;
+	esac
+}
 
-################################################################################
-# make sure this script returns success
-/bin/true
+_mount_opts()
+{
+	export MOUNT_OPTIONS=$(_common_mount_opts)
+}
+
+_test_mount_opts()
+{
+	export TEST_FS_MOUNT_OPTS=$(_common_mount_opts)
+}
+
+_mkfs_opts()
+{
+	case $FSTYP in
+	xfs)
+		export MKFS_OPTIONS=$XFS_MKFS_OPTIONS
+		;;
+	udf)
+		[ ! -z "$udf_fsize" ] && \
+			UDF_MKFS_OPTIONS="$UDF_MKFS_OPTIONS -s $udf_fsize"
+		export MKFS_OPTIONS=$UDF_MKFS_OPTIONS
+		;;
+	nfs)
+		export MKFS_OPTIONS=$NFS_MKFS_OPTIONS
+		;;
+	afs)
+		export MKFS_OPTIONS=$AFS_MKFS_OPTIONS
+		;;
+	cifs)
+		export MKFS_OPTIONS=$CIFS_MKFS_OPTIONS
+		;;
+	ceph)
+		export MKFS_OPTIONS=$CEPHFS_MKFS_OPTIONS
+		;;
+	reiserfs)
+		export MKFS_OPTIONS="$REISERFS_MKFS_OPTIONS -q"
+		;;
+       reiser4)
+		export MKFS_OPTIONS=$REISER4_MKFS_OPTIONS
+		;;
+	gfs2)
+		export MKFS_OPTIONS="$GFS2_MKFS_OPTIONS -O -p lock_nolock"
+		;;
+	jfs)
+		export MKFS_OPTIONS="$JFS_MKFS_OPTIONS -q"
+		;;
+	f2fs)
+		export MKFS_OPTIONS="$F2FS_MKFS_OPTIONS"
+		;;
+	btrfs)
+		export MKFS_OPTIONS="$BTRFS_MKFS_OPTIONS"
+		;;
+	bcachefs)
+		export MKFS_OPTIONS=$BCACHEFS_MKFS_OPTIONS
+		;;
+	*)
+		;;
+	esac
+}
+
+_fsck_opts()
+{
+	case $FSTYP in
+	ext2|ext3|ext4)
+		export FSCK_OPTIONS="-nf"
+		;;
+	reiser*)
+		export FSCK_OPTIONS="--yes"
+		;;
+	f2fs)
+		export FSCK_OPTIONS=""
+		;;
+	*)
+		export FSCK_OPTIONS="-n"
+		;;
+	esac
+}
+
+# check necessary running dependences then source sepcific fs helpers
+_source_specific_fs()
+{
+	local fs=$1
+
+	if [ -z "$fs" ];then
+		fs=$FSTYP
+	fi
+
+	case "$fs" in
+	xfs)
+		[ "$XFS_LOGPRINT_PROG" = "" ] && _fatal "xfs_logprint not found"
+		[ "$XFS_REPAIR_PROG" = "" ] && _fatal "xfs_repair not found"
+		[ "$XFS_DB_PROG" = "" ] && _fatal "xfs_db not found"
+		[ "$MKFS_XFS_PROG" = "" ] && _fatal "mkfs_xfs not found"
+		[ "$XFS_INFO_PROG" = "" ] && _fatal "xfs_info not found"
+
+		. ./common/xfs
+		;;
+	udf)
+		[ "$MKFS_UDF_PROG" = "" ] && _fatal "mkfs_udf/mkudffs not found"
+		;;
+	btrfs)
+		[ "$MKFS_BTRFS_PROG" = "" ] && _fatal "mkfs.btrfs not found"
+
+		. ./common/btrfs
+		;;
+	ext4)
+		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
+		. ./common/ext4
+		;;
+	ext2|ext3)
+		. ./common/ext4
+		;;
+	f2fs)
+		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
+		;;
+	nfs)
+		. ./common/nfs
+		;;
+	afs)
+		;;
+	cifs)
+		;;
+	9p)
+		;;
+	fuse)
+		;;
+	ceph)
+		. ./common/ceph
+		;;
+	glusterfs)
+		;;
+	overlay)
+		. ./common/overlay
+		;;
+	reiser4)
+		[ "$MKFS_REISER4_PROG" = "" ] && _fatal "mkfs.reiser4 not found"
+		;;
+	pvfs2)
+		;;
+	ubifs)
+		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
+		. ./common/ubifs
+		;;
+	esac
+}
diff --git a/tests/generic/367 b/tests/generic/367
index ed371a02b..1c9c66730 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -10,13 +10,12 @@
 # i.e, with any file with allocated extents or delayed allocation. We also
 # check if the extsize value and the xflag bit actually got reflected after
 # setting/re-setting the extsize value.
-
-. ./common/config
-. ./common/filter
+#
 . ./common/preamble
-
 _begin_fstest ioctl quick
 
+. ./common/filter
+
 [ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
 	"xfs: Check for delayed allocations before setting extsize"
 
diff --git a/tests/generic/749 b/tests/generic/749
index fc7477380..aac8da20d 100755
--- a/tests/generic/749
+++ b/tests/generic/749
@@ -14,11 +14,10 @@
 # page, you should get a SIGBUS. This test verifies we zero-fill to page
 # boundary and ensures we get a SIGBUS if we write to data beyond the system
 # page size even if the block size is greater than the system page size.
+#
 . ./common/preamble
-. ./common/rc
 _begin_fstest auto quick prealloc
 
-# Import common functions.
 . ./common/filter
 
 _require_scratch_nocheck

