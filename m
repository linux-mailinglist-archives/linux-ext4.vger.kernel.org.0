Return-Path: <linux-ext4+bounces-7029-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10827A774B1
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD12916B1F0
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE891DE3CA;
	Tue,  1 Apr 2025 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQN/Uk0s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40384D599;
	Tue,  1 Apr 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489925; cv=none; b=ibSIbA64mvwt8e5tfwhnUTiXLNsTkHReTaYea2rRdJVK9mm4HLNIVkvne6cGPqbz74os0iAaxbKW3HoNuEXfRGXloNHWYeBYWOaGWS5RIc2k+AxN7rejrSk6Qi+fe9gMe5vNKfExf9nX8ZChgxSSSOIKrdeCfxLMeKEPBzRCVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489925; c=relaxed/simple;
	bh=R6IwBnIqnFmIIfk7j88twwImbVm2/mfszVVOTUXhXXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mtTG9X7ucMMYPkXvH5HV28b2jqvfneVTHN8HjgZd6sepnClNkWmj6NxON1HSu7gPf6ybNCHRsnUMsmEsHPZcTwZ6LZV1nHCfHXgmKkSI9ROVpXSCoYHhTxtGxkhgu6J6wxRJ3DdKR/Dvb/7VBQrPCD/grqsasnvyXhFb/eos33I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQN/Uk0s; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22423adf751so96097085ad.2;
        Mon, 31 Mar 2025 23:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489922; x=1744094722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeDpdQ11s16pTzYWJgxvhUuPR0NJcjLGzbI//8eUywo=;
        b=FQN/Uk0sHVhzodBLTTpyCQCCROoxISSBcBt6u24qD3bSleyULFo5gESgyIV1rN5vHw
         Kgfe8jJTyPcavAdWLBwnvpcyz87H03RlrbVRRViF6pd3Z+iuDjlNm1OfKnJ6MawlVUkR
         DMOVOjjBvPILe3caBqS9Tt7DkGLLMDq8gHr4fm5J8OvZ/Utcp6JPUFlHqc1bIiuSM/rB
         ACepNDkAZHVHENJmLU4AFkRvC8l/0NcD7F7ud78lSkTUYrz2zZN1q7YYD06q33YBwvWB
         BQf3Z4cNH8kFzwuHDcWhduMjWFHrRSJmD7RXJtUf2YnUekRPYXpNtQtbaTYY2AxrOvIo
         9hMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489922; x=1744094722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeDpdQ11s16pTzYWJgxvhUuPR0NJcjLGzbI//8eUywo=;
        b=ibPcDjIIl31DJUegqFL+BVdUaYcmCiGoAMZMjgX7yLlNo/N+V33njYsSDDfXn42BSe
         NC4zyvDHtTTYsxzJiXOx99DREbCrx6FRjN4cGcCLDr38s22stxZZSrlHXugpzUOIvCnk
         NdaEs+6TMYzSIgEwKinf2SunZlAPunqJnmdc2j1qv8VTazI/wtMUjcHrAxpSr90W96Yi
         ZLx/6RXUpGW/kymQ3p+I6UqJSvMTQMT9cWPfq2AanZq0Uw1spgikMpMwAliko2VCv52h
         222goEo3PmTKMOzJhKC5zIipK9sai0v4dCPyBDnqtFubCHPcor1EI0k+1tGTBS7NdedD
         J3cg==
X-Forwarded-Encrypted: i=1; AJvYcCVfGUp4dOpdo1mAIh+Eqpyr/ioWs3lHcXXyMnMHOhxxs5K4YOYud+IjzQyGwmdrDPnncbbvvkI8S5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFUvi34gXK0An0tSDCGXo5j4/q2l2pxSTSx6kcUd6IW0cBVr2N
	SGsknTAEJ3+eyVM4PYW1R9r7YHvLLGcMz69N/RmYUdrO+6OFo8hZ/NHC7sZB
X-Gm-Gg: ASbGncv9wimAd75GgbbtHP6STYA78YENoDtYgM0yIXKABQeYU5qQCFo/HQz6wt9v7fL
	qO3pqNjvugaws/ZxU98gOBoEJhXGhOEoEQT8usE2z5sfIU4qjNJqWzYmnvzihVVG4wq0IWGNXAw
	S7QGsEU/O5gRVme9Js+MM5dX/NlDnVJjLXBGgOBkY09pQ52ztS4348jMpWHM7vmiG3MHmK9u73C
	/6k2/NUuz5jIp5VhSEvgI9wSlBmOAXHbOwQ50kYnjG1IvIjRncuDtwz1H+GCyr3fFbxG8ueI9W3
	HgE4Uqalc/q8HN2OeMqMmntOOnWOfiMdA1b2bF6OxACq2ZDL
X-Google-Smtp-Source: AGHT+IEoKQUe4iLCDBC5Yg4jYvRDZLidhZJQmM1KZaRcvS6eTZ7NrElk5kh5PMeurfk9OA85f/lSxQ==
X-Received: by 2002:a05:6a00:3c8f:b0:737:9b:582a with SMTP id d2e1a72fcca58-739b611a1c2mr2837540b3a.24.1743489922282;
        Mon, 31 Mar 2025 23:45:22 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:45:21 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 5/5] common: exit --> _exit
Date: Tue,  1 Apr 2025 06:44:00 +0000
Message-Id: <f6c7e5647d5839ff3a5c7d34418ec56aba22bbc1.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace exit <return-val> with _exit <return-val> which
is introduced in the previous patch.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 common/btrfs    |   6 +--
 common/ceph     |   2 +-
 common/config   |   7 ++--
 common/ext4     |   2 +-
 common/populate |   2 +-
 common/preamble |   2 +-
 common/punch    |  12 +++---
 common/rc       | 103 +++++++++++++++++++++++-------------------------
 common/xfs      |   8 ++--
 9 files changed, 70 insertions(+), 74 deletions(-)

diff --git a/common/btrfs b/common/btrfs
index a3b9c12f..3725632c 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -80,7 +80,7 @@ _require_btrfs_mkfs_feature()
 {
 	if [ -z $1 ]; then
 		echo "Missing feature name argument for _require_btrfs_mkfs_feature"
-		exit 1
+		_exit 1
 	fi
 	feat=$1
 	$MKFS_BTRFS_PROG -O list-all 2>&1 | \
@@ -104,7 +104,7 @@ _require_btrfs_fs_feature()
 {
 	if [ -z $1 ]; then
 		echo "Missing feature name argument for _require_btrfs_fs_feature"
-		exit 1
+		_exit 1
 	fi
 	feat=$1
 	modprobe btrfs > /dev/null 2>&1
@@ -214,7 +214,7 @@ _check_btrfs_filesystem()
 	if [ $ok -eq 0 ]; then
 		status=1
 		if [ "$iam" != "check" ]; then
-			exit 1
+			_exit 1
 		fi
 		return 1
 	fi
diff --git a/common/ceph b/common/ceph
index d6f24df1..df7a6814 100644
--- a/common/ceph
+++ b/common/ceph
@@ -14,7 +14,7 @@ _ceph_create_file_layout()
 
 	if [ -e $fname ]; then
 		echo "File $fname already exists."
-		exit 1
+		_exit 1
 	fi
 	touch $fname
 	$SETFATTR_PROG -n ceph.file.layout \
diff --git a/common/config b/common/config
index eb6af35a..4c5435b7 100644
--- a/common/config
+++ b/common/config
@@ -123,8 +123,7 @@ set_mkfs_prog_path_with_opts()
 _fatal()
 {
     echo "$*"
-    status=1
-    exit 1
+    _exit 1
 }
 
 export MKFS_PROG="$(type -P mkfs)"
@@ -868,7 +867,7 @@ get_next_config() {
 		echo "Warning: need to define parameters for host $HOST"
 		echo "       or set variables:"
 		echo "       $MC"
-		exit 1
+		_exit 1
 	fi
 
 	_check_device TEST_DEV required $TEST_DEV
@@ -879,7 +878,7 @@ get_next_config() {
 	if [ ! -z "$SCRATCH_DEV_POOL" ]; then
 		if [ ! -z "$SCRATCH_DEV" ]; then
 			echo "common/config: Error: \$SCRATCH_DEV ($SCRATCH_DEV) should be unset when \$SCRATCH_DEV_POOL ($SCRATCH_DEV_POOL) is set"
-			exit 1
+			_exit 1
 		fi
 		SCRATCH_DEV=`echo $SCRATCH_DEV_POOL | awk '{print $1}'`
 		export SCRATCH_DEV
diff --git a/common/ext4 b/common/ext4
index e1b336d3..f88fa532 100644
--- a/common/ext4
+++ b/common/ext4
@@ -182,7 +182,7 @@ _require_scratch_ext4_feature()
 {
     if [ -z "$1" ]; then
         echo "Usage: _require_scratch_ext4_feature feature"
-        exit 1
+        _exit 1
     fi
     $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
 		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
diff --git a/common/populate b/common/populate
index 7352f598..50dc75d3 100644
--- a/common/populate
+++ b/common/populate
@@ -1003,7 +1003,7 @@ _fill_fs()
 
 	if [ $# -ne 4 ]; then
 		echo "Usage: _fill_fs filesize dir blocksize switch_user"
-		exit 1
+		_exit 1
 	fi
 
 	if [ $switch_user -eq 0 ]; then
diff --git a/common/preamble b/common/preamble
index c92e55bb..ba029a34 100644
--- a/common/preamble
+++ b/common/preamble
@@ -35,7 +35,7 @@ _begin_fstest()
 {
 	if [ -n "$seq" ]; then
 		echo "_begin_fstest can only be called once!"
-		exit 1
+		_exit 1
 	fi
 
 	seq=`basename $0`
diff --git a/common/punch b/common/punch
index 43ccab69..6567b9d1 100644
--- a/common/punch
+++ b/common/punch
@@ -172,16 +172,16 @@ _filter_fiemap_flags()
 	$AWK_PROG -e "$awk_script" | _coalesce_extents
 }
 
-# Filters fiemap output to only print the 
+# Filters fiemap output to only print the
 # file offset column and whether or not
 # it is an extent or a hole
 _filter_hole_fiemap()
 {
 	$AWK_PROG '
 		$3 ~ /hole/ {
-			print $1, $2, $3; 
+			print $1, $2, $3;
 			next;
-		}   
+		}
 		$5 ~ /0x[[:xdigit:]]+/ {
 			print $1, $2, "extent";
 		}' |
@@ -225,7 +225,7 @@ _filter_bmap()
 die_now()
 {
 	status=1
-	exit
+	_exit
 }
 
 # test the different corner cases for zeroing a range:
@@ -276,7 +276,7 @@ _test_generic_punch()
 		u)	unwritten_tests=
 		;;
 		?)	echo Invalid flag
-		exit 1
+		_exit 1
 		;;
 		esac
 	done
@@ -552,7 +552,7 @@ _test_block_boundaries()
 		d)	sync_cmd=
 		;;
 		?)	echo Invalid flag
-		exit 1
+		_exit 1
 		;;
 		esac
 	done
diff --git a/common/rc b/common/rc
index 038c22f6..02dddc91 100644
--- a/common/rc
+++ b/common/rc
@@ -909,8 +909,7 @@ _mkfs_dev()
 	# output stored mkfs output
 	cat $tmp.mkfserr >&2
 	cat $tmp.mkfsstd
-	status=1
-	exit 1
+	_exit 1
     fi
     rm -f $tmp.mkfserr $tmp.mkfsstd
 }
@@ -1575,7 +1574,7 @@ _get_pids_by_name()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _get_pids_by_name process-name" 1>&2
-	exit 1
+	_exit 1
     fi
 
     # Algorithm ... all ps(1) variants have a time of the form MM:SS or
@@ -1609,7 +1608,7 @@ _df_device()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _df_device device" 1>&2
-	exit 1
+	_exit 1
     fi
 
     # Note that we use "==" here so awk doesn't try to interpret an NFS over
@@ -1641,7 +1640,7 @@ _df_dir()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _df_dir device" 1>&2
-	exit 1
+	_exit 1
     fi
 
     $DF_PROG $1 2>/dev/null | $AWK_PROG -v what=$1 '
@@ -1667,7 +1666,7 @@ _used()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _used device" 1>&2
-	exit 1
+	_exit 1
     fi
 
     _df_device $1 | $AWK_PROG '{ sub("%", "") ; print $6 }'
@@ -1680,7 +1679,7 @@ _fs_type()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _fs_type device" 1>&2
-	exit 1
+	_exit 1
     fi
 
     #
@@ -1705,7 +1704,7 @@ _fs_options()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _fs_options device" 1>&2
-	exit 1
+	_exit 1
     fi
 
     $AWK_PROG -v dev=$1 '
@@ -1720,7 +1719,7 @@ _is_block_dev()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _is_block_dev dev" 1>&2
-	exit 1
+	_exit 1
     fi
 
     local dev=$1
@@ -1739,7 +1738,7 @@ _is_char_dev()
 {
 	if [ $# -ne 1 ]; then
 		echo "Usage: _is_char_dev dev" 1>&2
-		exit 1
+		_exit 1
 	fi
 
 	local dev=$1
@@ -1772,7 +1771,7 @@ _do()
 	echo -n "$note... "
     else
 	echo "Usage: _do [note] cmd" 1>&2
-	status=1; exit
+	_exit 1
     fi
 
     (eval "echo '---' \"$cmd\"") >>$seqres.full
@@ -1793,7 +1792,7 @@ _do()
     then
 	[ $# -ne 2 ] && echo
 	eval "echo \"$cmd\" failed \(returned $ret\): see $seqres.full"
-	status=1; exit
+	_exit 1
     fi
 
     return $ret
@@ -1809,8 +1808,7 @@ _notrun()
     rm -f ${RESULT_DIR}/require_test*
     rm -f ${RESULT_DIR}/require_scratch*
 
-    status=0
-    exit
+    _exit 0
 }
 
 # just plain bail out
@@ -1819,8 +1817,7 @@ _fail()
 {
     echo "$*" | tee -a $seqres.full
     echo "(see $seqres.full for details)"
-    status=1
-    exit 1
+    _exit 1
 }
 
 #
@@ -2049,14 +2046,14 @@ _require_scratch_nocheck()
 
     _check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
     local err=$?
-    [ $err -le 1 ] || exit 1
+    [ $err -le 1 ] || _exit 1
     if [ $err -eq 0 ]
     then
         # if it's mounted, unmount it
         if ! _scratch_unmount
         then
             echo "failed to unmount $SCRATCH_DEV"
-            exit 1
+            _exit 1
         fi
     fi
     rm -f ${RESULT_DIR}/require_scratch "$RESULT_DIR/.skip_orebuild" "$RESULT_DIR/.skip_rebuild"
@@ -2273,13 +2270,13 @@ _require_test()
 
     _check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR
     local err=$?
-    [ $err -le 1 ] || exit 1
+    [ $err -le 1 ] || _exit 1
     if [ $err -ne 0 ]
     then
 	if ! _test_mount
 	then
 		echo "!!! failed to mount $TEST_DEV on $TEST_DIR"
-		exit 1
+		_exit 1
 	fi
     fi
     touch ${RESULT_DIR}/require_test
@@ -2391,7 +2388,7 @@ _require_block_device()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _require_block_device <dev>" 1>&2
-		exit 1
+		_exit 1
 	fi
 	if [ "`_is_block_dev "$1"`" == "" ]; then
 		_notrun "require $1 to be valid block disk"
@@ -2404,7 +2401,7 @@ _require_local_device()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _require_local_device <dev>" 1>&2
-		exit 1
+		_exit 1
 	fi
 	if [ "`_is_block_dev "$1"`" != "" ]; then
 		return 0
@@ -2512,7 +2509,7 @@ _zone_type()
 	local target=$1
 	if [ -z $target ]; then
 		echo "Usage: _zone_type <device>"
-		exit 1
+		_exit 1
 	fi
 	local sdev=`_short_dev $target`
 
@@ -2528,7 +2525,7 @@ _require_zoned_device()
 	local target=$1
 	if [ -z $target ]; then
 		echo "Usage: _require_zoned_device <device>"
-		exit 1
+		_exit 1
 	fi
 
 	local type=`_zone_type ${target}`
@@ -2668,7 +2665,7 @@ _run_aiodio()
     if [ -z "$1" ]
     then
         echo "usage: _run_aiodio command_name" 2>&1
-        status=1; exit 1
+        _exit 1
     fi
 
     _require_aiodio $1
@@ -2880,7 +2877,7 @@ _require_xfs_io_command()
 	if [ -z "$1" ]
 	then
 		echo "Usage: _require_xfs_io_command command [switch]" 1>&2
-		exit 1
+		_exit 1
 	fi
 	local command=$1
 	shift
@@ -3364,7 +3361,7 @@ _is_dev_mounted()
 
 	if [ $# -lt 1 ]; then
 		echo "Usage: _is_dev_mounted <device> [fstype]" 1>&2
-		exit 1
+		_exit 1
 	fi
 
 	findmnt -rncv -S $dev -t $fstype -o TARGET | head -1
@@ -3378,7 +3375,7 @@ _is_dir_mountpoint()
 
 	if [ $# -lt 1 ]; then
 		echo "Uasge: _is_dir_mountpoint <dir> [fstype]" 1>&2
-		exit 1
+		_exit 1
 	fi
 
 	findmnt -rncv -t $fstype -o TARGET $dir | head -1
@@ -3391,7 +3388,7 @@ _remount()
     if [ $# -ne 2 ]
     then
 	echo "Usage: _remount device ro/rw" 1>&2
-	exit 1
+	_exit 1
     fi
     local device=$1
     local mode=$2
@@ -3399,7 +3396,7 @@ _remount()
     if ! mount -o remount,$mode $device
     then
         echo "_remount: failed to remount filesystem on $device as $mode"
-        exit 1
+        _exit 1
     fi
 }
 
@@ -3417,7 +3414,7 @@ _umount_or_remount_ro()
     if [ $# -ne 1 ]
     then
 	echo "Usage: _umount_or_remount_ro <device>" 1>&2
-	exit 1
+	_exit 1
     fi
 
     local device=$1
@@ -3435,7 +3432,7 @@ _mount_or_remount_rw()
 {
 	if [ $# -ne 3 ]; then
 		echo "Usage: _mount_or_remount_rw <opts> <dev> <mnt>" 1>&2
-		exit 1
+		_exit 1
 	fi
 	local mount_opts=$1
 	local device=$2
@@ -3516,7 +3513,7 @@ _check_generic_filesystem()
     if [ $ok -eq 0 ]; then
 	status=1
 	if [ "$iam" != "check" ]; then
-		exit 1
+		_exit 1
 	fi
 	return 1
     fi
@@ -3582,7 +3579,7 @@ _check_udf_filesystem()
     if [ $# -ne 1 -a $# -ne 2 ]
     then
 	echo "Usage: _check_udf_filesystem device [last_block]" 1>&2
-	exit 1
+	_exit 1
     fi
 
     if [ ! -x $here/src/udf_test ]
@@ -3776,7 +3773,7 @@ _get_os_name()
 		echo 'linux'
 	else
 		echo Unknown operating system: `uname`
-		exit
+		_exit
 	fi
 }
 
@@ -3837,7 +3834,7 @@ _link_out_file()
 _die()
 {
         echo $@
-        exit 1
+        _exit 1
 }
 
 # convert urandom incompressible data to compressible text data
@@ -3994,7 +3991,7 @@ _require_scratch_dev_pool()
 		if _mount | grep -q $i; then
 			if ! _unmount $i; then
 		            echo "failed to unmount $i - aborting"
-		            exit 1
+		            _exit 1
 		        fi
 		fi
 		# To help better debug when something fails, we remove
@@ -4403,7 +4400,7 @@ _require_batched_discard()
 {
 	if [ $# -ne 1 ]; then
 		echo "Usage: _require_batched_discard mnt_point" 1>&2
-		exit 1
+		_exit 1
 	fi
 	_require_fstrim
 
@@ -4630,7 +4627,7 @@ _require_chattr()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _require_chattr <attr>"
-		exit 1
+		_exit 1
 	fi
 	local attribute=$1
 
@@ -4649,7 +4646,7 @@ _get_total_inode()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_total_inode <mnt>"
-		exit 1
+		_exit 1
 	fi
 	local nr_inode;
 	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $3}'`
@@ -4660,7 +4657,7 @@ _get_used_inode()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_used_inode <mnt>"
-		exit 1
+		_exit 1
 	fi
 	local nr_inode;
 	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $4}'`
@@ -4671,7 +4668,7 @@ _get_used_inode_percent()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_used_inode_percent <mnt>"
-		exit 1
+		_exit 1
 	fi
 	local pct_inode;
 	pct_inode=`$DF_PROG -i $1 | tail -1 | awk '{ print $6 }' | \
@@ -4683,7 +4680,7 @@ _get_free_inode()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_free_inode <mnt>"
-		exit 1
+		_exit 1
 	fi
 	local nr_inode;
 	nr_inode=`$DF_PROG -i $1 | tail -1 | awk '{print $5}'`
@@ -4696,7 +4693,7 @@ _get_available_space()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_available_space <mnt>"
-		exit 1
+		_exit 1
 	fi
 	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $5 }'
 }
@@ -4707,7 +4704,7 @@ _get_total_space()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _get_total_space <mnt>"
-		exit 1
+		_exit 1
 	fi
 	$DF_PROG -B 1 $1 | tail -n1 | awk '{ print $3 }'
 }
@@ -4952,7 +4949,7 @@ init_rc()
 	if [ "$TEST_DEV" = ""  ]
 	then
 		echo "common/rc: Error: \$TEST_DEV is not set"
-		exit 1
+		_exit 1
 	fi
 
 	# if $TEST_DEV is not mounted, mount it now as XFS
@@ -4966,7 +4963,7 @@ init_rc()
 			if ! _test_mount
 			then
 				echo "common/rc: could not mount $TEST_DEV on $TEST_DIR"
-				exit 1
+				_exit 1
 			fi
 		fi
 	fi
@@ -4979,7 +4976,7 @@ init_rc()
 		# mount point, because it is about to be unmounted and formatted.
 		# Another fs type for scratch is fine (bye bye old fs type).
 		_check_mounted_on SCRATCH_DEV $SCRATCH_DEV SCRATCH_MNT $SCRATCH_MNT
-		[ $? -le 1 ] || exit 1
+		[ $? -le 1 ] || _exit 1
 	fi
 
 	# Figure out if we need to add -F ("foreign", deprecated) option to xfs_io
@@ -5029,7 +5026,7 @@ _get_file_block_size()
 {
 	if [ -z $1 ] || [ ! -d $1 ]; then
 		echo "Missing mount point argument for _get_file_block_size"
-		exit 1
+		_exit 1
 	fi
 
 	case "$FSTYP" in
@@ -5076,7 +5073,7 @@ _get_block_size()
 {
 	if [ -z $1 ] || [ ! -d $1 ]; then
 		echo "Missing mount point argument for _get_block_size"
-		exit 1
+		_exit 1
 	fi
 	stat -f -c %S $1
 }
@@ -5146,14 +5143,14 @@ _run_hugepage_fsx() {
 	fi
 	cat $tmp.hugepage_fsx
 	rm -f $tmp.hugepage_fsx
-	test $res -ne 0 && exit 1
+	test $res -ne 0 && _exit 1
 	return 0
 }
 
 # run fsx or exit the test
 run_fsx()
 {
-	_run_fsx "$@" || exit 1
+	_run_fsx "$@" || _exit 1
 }
 
 _require_statx()
@@ -5318,7 +5315,7 @@ _get_max_file_size()
 {
 	if [ -z $1 ] || [ ! -d $1 ]; then
 		echo "Missing mount point argument for _get_max_file_size"
-		exit 1
+		_exit 1
 	fi
 
 	local mnt=$1
diff --git a/common/xfs b/common/xfs
index 81d568d3..96c15f3c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -553,7 +553,7 @@ _require_xfs_db_command()
 {
 	if [ $# -ne 1 ]; then
 		echo "Usage: _require_xfs_db_command command" 1>&2
-		exit 1
+		_exit 1
 	fi
 	command=$1
 
@@ -789,7 +789,7 @@ _check_xfs_filesystem()
 
 	if [ $# -ne 3 ]; then
 		echo "Usage: _check_xfs_filesystem device <logdev>|none <rtdev>|none" 1>&2
-		exit 1
+		_exit 1
 	fi
 
 	extra_mount_options=""
@@ -1014,7 +1014,7 @@ _check_xfs_filesystem()
 	if [ $ok -eq 0 ]; then
 		status=1
 		if [ "$iam" != "check" ]; then
-			exit 1
+			_exit 1
 		fi
 		return 1
 	fi
@@ -1379,7 +1379,7 @@ _require_xfs_spaceman_command()
 {
 	if [ -z "$1" ]; then
 		echo "Usage: _require_xfs_spaceman_command command [switch]" 1>&2
-		exit 1
+		_exit 1
 	fi
 	local command=$1
 	shift
-- 
2.34.1


