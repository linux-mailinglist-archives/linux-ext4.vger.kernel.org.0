Return-Path: <linux-ext4+bounces-7580-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C984AA4B83
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8188517B1D2
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Apr 2025 12:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7E2586E2;
	Wed, 30 Apr 2025 12:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqQAMJjC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4D231847;
	Wed, 30 Apr 2025 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017175; cv=none; b=GtrZT/DlxLLToB5eNul6ccIe9KgEHwxn4FAiwhzn649/8ngcu4SUnszsTne4RempaRwx0FJ70ZZ3l1jtcLAVF76+DbkM5cTFHlAReFak2/SM2SHHhuvHLEZoHuLAEv6xdtZDOrJ3oxL/PJgKaCtBb547sa8XmljBC3nVY+AVuRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017175; c=relaxed/simple;
	bh=QW1xU/MWVgKnRf+1WAIksoJWGOlTxTsAs3j2NFoJXwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4idOr2KG0G7r+ZR/15AybUENxCrteqoOy5e/cT8bm3rUlw28LgAU86XGOVoRLthtqSMZ/5DekaVRVop1bQbq22G5zV3lWC4X4yjUFpdEfpxkohiraeZ13deehVUPNtfYXKcroSppr7LsIo4hsoB0WrKsVDdDJZsNgrvm7fNC2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqQAMJjC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so5779768a12.3;
        Wed, 30 Apr 2025 05:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746017173; x=1746621973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3mKcYYOZ8zeQR7W/dGnPrX6u9yRnOjXXsCqq42klaU=;
        b=EqQAMJjCktd+W0ZTT7H4RoHwoDGCJRU3WX0QAJrxj9HBsIGF4wHmWAlsP4dzRqzszy
         lv/ZXqKkQ1PIL5F4oiUS3RIM6zJCUWzzTSQIvDmB92EERelRajbgNum5vucoiHNQpeo/
         VLpqFQFMW1OGgVdhEqgFvHRQSiaA5Rx01KQl5QX6BN0qdJixsoBZIyQEKwO4Lx6k4X7l
         NUFPrF7b8M7/pf6PRM60okS9hVu28IICyQQbO3nMlIn0xONjNJ5E9SiZMZLq5hfO8pTo
         7HE+UClK+NrcfQuBLjLBRPFpomuC+bNfXDikNZtHgJBiigDud5sYcp25mSodYtBqyXcQ
         8Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746017173; x=1746621973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3mKcYYOZ8zeQR7W/dGnPrX6u9yRnOjXXsCqq42klaU=;
        b=OtYSxbM/tQgECsoLpAWXPfqOW5Y0R40X5zyFfNiev1+jjGdD99GTS0OQev9C6ZF7t4
         II2X+qptzO2aYVBOoD8Yn4h20PnqxvkTjImIJgVddNHRHGc0ssdSfSb0l7ZY8yn+UntL
         jFAvPm2d3Yz3UIBr/x5QbwemFaUaNj8Qw+SoYTvmndgvgyd93E/l7b8Q7Z5orGgapBJT
         8QMzMDruAf/OXwFg40SkoKv3kIzmd2l7olEJ8Bgfqh5uWjEsHvMkof03J0rPE3DI0sIg
         TOdleWQhB4PlUfVZZ17C9JVYAGjtuqyy+8Y+ii9HFc2gEHJWCEckl/slRcwXzIOvoYOp
         2lNw==
X-Forwarded-Encrypted: i=1; AJvYcCXTSTDtcjIh0JmS+dzuLXMsiHO+ycEMoHPLkQWYi5+S2G2CWrFDhoTVnXH1EvGfRnjd6aa6th5XXeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7MxiPeNv0sW9d5RBG/RiY0i68JxJebDAlbBoHAnSMGuCZfV7v
	Zcy/Zpabjr8rHg/NC3vSzj93yU96ryKbgdykNHBPfSTftHe8iUEFirIJWA==
X-Gm-Gg: ASbGncuGypd+45thoJMzb2ByflltvdPU/Qkp098E43kPwAG+2W67NhbCLUiLk/QwW0E
	HRQHfylR0LDl0A1MW6bdSe89zxbtKYyKbWZMd7s9Uj109ANp3QnLVKgqa9vrxlXMFoTTY0diC9o
	jbEEj7krt0YTYyB1c6LcixdZR21GtEwdGoHb3SfF8/LnTz26j0dwa7n50H9ylYF5cV0VAwxbRDC
	PU2ar1Rn6gszFArV4r8gYTaPjrqAUUO/K1uIoyC5OOIrFQiXqZtpDQllVJW9FD8ZPdB2ouYUSxc
	ZD1pOVEKL7RFyf7QnVylqmTqJZIbuuqMkxhasGJ2GAc3
X-Google-Smtp-Source: AGHT+IFVBoSaO+FpP2IZjbes5fAkbGpNG0PWblZJydZL0lnqkPByszUT1cdIFK69gHRRZ+Dgv5+QLA==
X-Received: by 2002:a17:90b:5249:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-30a332e1e1cmr4609312a91.2.1746017172431;
        Wed, 30 Apr 2025 05:46:12 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a349e4a40sm1476540a91.6.2025.04.30.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 05:46:12 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 1/2] common: Move exit related functions to a common/exit
Date: Wed, 30 Apr 2025 12:45:22 +0000
Message-Id: <7363438118ab8730208ba9f35e81449b2549f331.1746015588.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
References: <cover.1746015588.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new file common/exit that will contain all the exit
related functions. This will remove the dependencies these functions
have on other non-related helper files and they can be indepedently
sourced. This was suggested by Dave Chinner[1].
While moving the exit related functions, remove _die() and die_now()
and replace die_now with _fatal(). It is of no use to keep the
unnecessary wrappers.

[1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check           |  2 ++
 common/config   | 17 -----------------
 common/exit     | 39 +++++++++++++++++++++++++++++++++++++++
 common/preamble |  3 +++
 common/punch    | 39 +++++++++++++++++----------------------
 common/rc       | 28 ----------------------------
 6 files changed, 61 insertions(+), 67 deletions(-)
 create mode 100644 common/exit

diff --git a/check b/check
index 9451c350..bd84f213 100755
--- a/check
+++ b/check
@@ -46,6 +46,8 @@ export DIFF_LENGTH=${DIFF_LENGTH:=10}
 
 # by default don't output timestamps
 timestamp=${TIMESTAMP:=false}
+. common/exit
+. common/test_names
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
diff --git a/common/config b/common/config
index eada3971..22b52432 100644
--- a/common/config
+++ b/common/config
@@ -39,8 +39,6 @@
 #   validity or mountedness.
 #
 
-. common/test_names
-
 # all tests should use a common language setting to prevent golden
 # output mismatches.
 export LANG=C
@@ -96,15 +94,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
 
-# This functions sets the exit code to status and then exits. Don't use
-# exit directly, as it might not set the value of "$status" correctly, which is
-# used as an exit code in the trap handler routine set up by the check script.
-_exit()
-{
-	test -n "$1" && status="$1"
-	exit "$status"
-}
-
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
@@ -121,12 +110,6 @@ set_mkfs_prog_path_with_opts()
 	fi
 }
 
-_fatal()
-{
-    echo "$*"
-    _exit 1
-}
-
 export MKFS_PROG="$(type -P mkfs)"
 [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
 
diff --git a/common/exit b/common/exit
new file mode 100644
index 00000000..222c79b7
--- /dev/null
+++ b/common/exit
@@ -0,0 +1,39 @@
+##/bin/bash
+
+# This functions sets the exit code to status and then exits. Don't use
+# exit directly, as it might not set the value of "$status" correctly, which is
+# used as an exit code in the trap handler routine set up by the check script.
+_exit()
+{
+	test -n "$1" && status="$1"
+	exit "$status"
+}
+
+_fatal()
+{
+    echo "$*"
+    _exit 1
+}
+
+# just plain bail out
+#
+_fail()
+{
+    echo "$*" | tee -a $seqres.full
+    echo "(see $seqres.full for details)"
+    _exit 1
+}
+
+# bail out, setting up .notrun file. Need to kill the filesystem check files
+# here, otherwise they are set incorrectly for the next test.
+#
+_notrun()
+{
+    echo "$*" > $seqres.notrun
+    echo "$seq not run: $*"
+    rm -f ${RESULT_DIR}/require_test*
+    rm -f ${RESULT_DIR}/require_scratch*
+
+    _exit 0
+}
+
diff --git a/common/preamble b/common/preamble
index ba029a34..51d03396 100644
--- a/common/preamble
+++ b/common/preamble
@@ -33,6 +33,9 @@ _register_cleanup()
 # explicitly as a member of the 'all' group.
 _begin_fstest()
 {
+	. common/exit
+	. common/test_names
+
 	if [ -n "$seq" ]; then
 		echo "_begin_fstest can only be called once!"
 		_exit 1
diff --git a/common/punch b/common/punch
index 64d665d8..ddbe757a 100644
--- a/common/punch
+++ b/common/punch
@@ -222,11 +222,6 @@ _filter_bmap()
 	_coalesce_extents
 }
 
-die_now()
-{
-	_exit 1
-}
-
 # test the different corner cases for zeroing a range:
 #
 #	1. into a hole
@@ -305,7 +300,7 @@ _test_generic_punch()
 	$XFS_IO_PROG -f -c "truncate $_20k" \
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	echo "	2. into allocated space"
@@ -316,7 +311,7 @@ _test_generic_punch()
 		-c "pwrite 0 $_20k" $sync_cmd \
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	if [ "$unwritten_tests" ]; then
@@ -328,7 +323,7 @@ _test_generic_punch()
 			-c "$alloc_cmd 0 $_20k" \
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 	fi
 
@@ -340,7 +335,7 @@ _test_generic_punch()
 		-c "pwrite $_8k $_8k" $sync_cmd \
 		-c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	if [ "$unwritten_tests" ]; then
@@ -352,7 +347,7 @@ _test_generic_punch()
 			-c "$alloc_cmd $_8k $_8k" \
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 	fi
 
@@ -364,7 +359,7 @@ _test_generic_punch()
 		-c "pwrite 0 $_8k" $sync_cmd \
 		 -c "$zero_cmd $_4k $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	if [ "$unwritten_tests" ]; then
@@ -377,7 +372,7 @@ _test_generic_punch()
 			-c "$alloc_cmd $_8k $_8k" \
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 
 		echo "	8. unwritten -> hole"
@@ -388,7 +383,7 @@ _test_generic_punch()
 			-c "$alloc_cmd 0 $_8k" \
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 
 		echo "	9. unwritten -> data"
@@ -400,7 +395,7 @@ _test_generic_punch()
 			-c "pwrite $_8k $_8k" $sync_cmd \
 			-c "$zero_cmd $_4k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 	fi
 
@@ -412,7 +407,7 @@ _test_generic_punch()
 		-c "pwrite $_8k $_4k" $sync_cmd \
 		-c "$zero_cmd $_4k $_12k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	echo "	11. data -> hole -> data"
@@ -426,7 +421,7 @@ _test_generic_punch()
 		-c "$punch_cmd $_8k $_4k" \
 		-c "$zero_cmd $_4k $_12k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	if [ "$unwritten_tests" ]; then
@@ -439,7 +434,7 @@ _test_generic_punch()
 			-c "pwrite $_8k $_4k" $sync_cmd \
 			-c "$zero_cmd $_4k $_12k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 
 		echo "	13. data -> unwritten -> data"
@@ -452,7 +447,7 @@ _test_generic_punch()
 			-c "pwrite $_12k $_8k" -c "fsync" \
 			-c "$zero_cmd $_4k $_12k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 	fi
 
@@ -466,7 +461,7 @@ _test_generic_punch()
 			-c "pwrite 0 $_20k" $sync_cmd \
 			-c "$zero_cmd $_12k $_8k" \
 			-c "$map_cmd -v" $testfile | $filter_cmd
-		[ $? -ne 0 ] && die_now
+		[ $? -ne 0 ] && _fatal
 		_md5_checksum $testfile
 	fi
 
@@ -483,7 +478,7 @@ _test_generic_punch()
 		-c "pwrite 0 $_20k" $sync_cmd \
 		-c "$zero_cmd 0 $_8k" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	_md5_checksum $testfile
 
 	# If zero_cmd is fcollpase, don't check unaligned offsets
@@ -512,7 +507,7 @@ _test_generic_punch()
 		-c "fadvise -d" \
 		-c "$map_cmd -v" $testfile | $filter_cmd
 	diff $testfile $testfile.2
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	rm -f $testfile.2
 	_md5_checksum $testfile
 
@@ -532,7 +527,7 @@ _test_generic_punch()
 		-c "$zero_cmd 128 128" \
 		-c "$map_cmd -v" $testfile | $filter_cmd | \
 			 sed -e "s/\.\.[0-9]*\]/..7\]/"
-	[ $? -ne 0 ] && die_now
+	[ $? -ne 0 ] && _fatal
 	od -x $testfile | head -n -1
 }
 
diff --git a/common/rc b/common/rc
index 9bed6dad..fac9b6da 100644
--- a/common/rc
+++ b/common/rc
@@ -1798,28 +1798,6 @@ _do()
     return $ret
 }
 
-# bail out, setting up .notrun file. Need to kill the filesystem check files
-# here, otherwise they are set incorrectly for the next test.
-#
-_notrun()
-{
-    echo "$*" > $seqres.notrun
-    echo "$seq not run: $*"
-    rm -f ${RESULT_DIR}/require_test*
-    rm -f ${RESULT_DIR}/require_scratch*
-
-    _exit 0
-}
-
-# just plain bail out
-#
-_fail()
-{
-    echo "$*" | tee -a $seqres.full
-    echo "(see $seqres.full for details)"
-    _exit 1
-}
-
 #
 # Tests whether $FSTYP should be exclude from this test.
 #
@@ -3835,12 +3813,6 @@ _link_out_file()
 	_link_out_file_named $seqfull.out "$features"
 }
 
-_die()
-{
-        echo $@
-        _exit 1
-}
-
 # convert urandom incompressible data to compressible text data
 _ddt()
 {
-- 
2.34.1


