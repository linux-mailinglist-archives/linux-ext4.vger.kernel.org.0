Return-Path: <linux-ext4+bounces-7401-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 088E6A97F6D
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 08:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62853B5914
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 06:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAF266F1B;
	Wed, 23 Apr 2025 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9oA3iZa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5A1264602;
	Wed, 23 Apr 2025 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745390537; cv=none; b=a4kq2yTijD/2Lw9BjXjOKXszHMMkTUJHYH+hPT0FciCthq2tapnffJrQmoZ2n4kE6GHHpaIgkDhCk9S/NVaQ9Zf28TyjSUCrDFYwV8YyeMqztatL0dWZYkmo1q4LNuxsxte30klL/2Yg/nS+oWz2vi5g0fEq70Z5gXcHyaEszK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745390537; c=relaxed/simple;
	bh=3VxIuXFl2ytwRowrLZ0PdPz/7egrytRaVJpFr76s8/k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eQj6CGzsESg/m66A1Fv0LAFOTyWYf1M9M+QXLbThc3zZg4IDSv8bpR8hE0pWipPnWQGWAsb4L3Sox329rnb6oUXze8TUOCSWCYwXzHzlFFqp1Rtl3NFunKTC0bN69iLOMh8zjJ+/LYmRiookMHbTheBs63PCY+df3HgXOMOhDRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9oA3iZa; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3014678689aso4750758a91.0;
        Tue, 22 Apr 2025 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745390535; x=1745995335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSeNH4gc+wouF2utUEjF2WmOFa/LNnPpsNuFtN9l9UE=;
        b=V9oA3iZa2SKTv584RvVXjbPTI12Hj2vPpZsZj2sp5Ra97XA7rjfSn/hWoTwmB+OLE0
         /7R0vdXeh06eglz3e1DzCN6x9Hg1AFZrFA2ca9jBuDxaU9fWl5ZENVNjsKz2RC8erhCB
         uf/XjyeaSPxPJJG/hg2x4aa1pJ5L657g7maikj3B9ZkjJbyM92I5sHqKNdVYPV71hCAf
         Ue55mPIhpssIfSFDyb6Tmakp58FxrRyanbO2PKcnnZUzCtfxS2UeEGAhps3aetdlUoyB
         hAt24FWIzMNnDya8sldPDsT6uN/Zk+eUI3c0ONGea195E//+crYgf//AikI6Jvhlw4QI
         T+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745390535; x=1745995335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fSeNH4gc+wouF2utUEjF2WmOFa/LNnPpsNuFtN9l9UE=;
        b=XhadA3SmNBmD1KVDWWACbIOBUxIxjWmIWfwXK+RcrTnIryfXOkHqn2mYJWOQW36cfX
         24zc6hVI3AhZr/WCdmB+d69ImcKitDWNv4Vc9jIyXEkN5apMaqwumAQdwdZUqLF0JRRp
         B58WQxah8aqEKeoCf4Sz6AczvYBc5RhXmiq2g0FSdwAIm9ufu0PQTypHd7rlolzm1ylU
         a0I+6mQRwfxktxpJRaKbPjZK2/W40V8He6wvCXjJYFc1Qh7l4m8yi0YoQ/M+2t/ccSoq
         zcamxBaBw7MOFcaTQPajVyF0G93s3LiV/2U1A8SZ/UJKP9WquBQm5eY2hZlFEfaeE9+u
         BS3w==
X-Forwarded-Encrypted: i=1; AJvYcCWxJwIrBwnxQgiElDgteRHNYfMLbot5yYy94QqJJhhz3cPPdBzFt1wUtDKjNstRm1G3bmJcv2uqe1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw38y7oX6lkhrinJZdwCGF+47uQCKr24dDrfgm2nDDKIexeTn3P
	jHpFuSIhg1HPsDPds9fc1zKXrowCNqmb9jVVnr3v5zHBXHBgVsq76SpkpQ==
X-Gm-Gg: ASbGncsnJHG7oeHkSZ56bcvwWK55y3uvkL5BEJdKBztcjK1bQ1S10UWHXUa9ZP2bvaS
	Cj1LHkKrKWqsUy4YztkfLpz+WGogVxrgtO+eI9RUt88N4lmQcrnHSMheajOUxGX0bbUK6ONP7TF
	/feXSm245o/xmJusstXk2eJgLGcKv35ZNhTz65lBdLmVVegS/meJ5NJ0zDbZ58YV4/UnI6gwFj0
	tKf1HtGSb3n9HICs8NU/HOkvHQLT/GnjOFf4wrbGkt2pt/GWK+aUhupOkOlpyD3X0GM+QtmKPa5
	8Om/xTJyvIynf5vpwTF3Yo2bYnn63+CF644CBNBIEtN9
X-Google-Smtp-Source: AGHT+IGAWFXxhL9BlAvalZtne94uoR1HKsIwm7vZPMmcLMSD4bmxBSD4tZN1DppLOyVJLyF14YNq8A==
X-Received: by 2002:a17:90b:270d:b0:2ff:5357:1c7e with SMTP id 98e67ed59e1d1-3087bb6954amr25780086a91.20.1745390534444;
        Tue, 22 Apr 2025 23:42:14 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9f051csm897705a91.4.2025.04.22.23.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 23:42:14 -0700 (PDT)
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
Subject: [PATCH v1 1/2] common: Move exit related functions to a common/exit
Date: Wed, 23 Apr 2025 06:41:34 +0000
Message-Id: <d0b7939a277e8a16566f04e449e9a1f97da28b9d.1745390030.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745390030.git.nirjhar.roy.lists@gmail.com>
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

[1] https://lore.kernel.org/linux-xfs/Z_UJ7XcpmtkPRhTr@dread.disaster.area/
Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check           |  1 +
 common/btrfs    |  2 +-
 common/ceph     |  2 ++
 common/config   | 17 +----------------
 common/dump     |  1 +
 common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/ext4     |  2 +-
 common/populate |  2 +-
 common/preamble |  1 +
 common/punch    |  6 +-----
 common/rc       | 29 +---------------------------
 common/repair   |  1 +
 common/xfs      |  1 +
 13 files changed, 63 insertions(+), 52 deletions(-)
 create mode 100644 common/exit

diff --git a/check b/check
index 9451c350..67355c52 100755
--- a/check
+++ b/check
@@ -51,6 +51,7 @@ rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
 
 SRC_GROUPS="generic"
 export SRC_DIR="tests"
+. common/exit
 
 usage()
 {
diff --git a/common/btrfs b/common/btrfs
index 3725632c..9e91ee71 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -1,7 +1,7 @@
 #
 # Common btrfs specific functions
 #
-
+. common/exit
 . common/module
 
 # The recommended way to execute simple "btrfs" command.
diff --git a/common/ceph b/common/ceph
index df7a6814..89e36403 100644
--- a/common/ceph
+++ b/common/ceph
@@ -2,6 +2,8 @@
 # CephFS specific common functions.
 #
 
+. common/exit
+
 # _ceph_create_file_layout <filename> <stripe unit> <stripe count> <object size>
 # This function creates a new empty file and sets the file layout according to
 # parameters.  It will exit if the file already exists.
diff --git a/common/config b/common/config
index eada3971..6a60d144 100644
--- a/common/config
+++ b/common/config
@@ -38,7 +38,7 @@
 # - this script shouldn't make any assertions about filesystem
 #   validity or mountedness.
 #
-
+. common/exit
 . common/test_names
 
 # all tests should use a common language setting to prevent golden
@@ -96,15 +96,6 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
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
@@ -121,12 +112,6 @@ set_mkfs_prog_path_with_opts()
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
 
diff --git a/common/dump b/common/dump
index 09859006..4701a956 100644
--- a/common/dump
+++ b/common/dump
@@ -3,6 +3,7 @@
 # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # Functions useful for xfsdump/xfsrestore tests
+. common/exit
 
 # --- initializations ---
 rm -f $seqres.full
diff --git a/common/exit b/common/exit
new file mode 100644
index 00000000..ad7e7498
--- /dev/null
+++ b/common/exit
@@ -0,0 +1,50 @@
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
+_die()
+{
+        echo $@
+        _exit 1
+}
+
+die_now()
+{
+	_exit 1
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
diff --git a/common/ext4 b/common/ext4
index f88fa532..ab566c41 100644
--- a/common/ext4
+++ b/common/ext4
@@ -1,7 +1,7 @@
 #
 # ext4 specific common functions
 #
-
+. common/exit
 __generate_ext4_report_vars() {
 	__generate_blockdev_report_vars TEST_LOGDEV
 	__generate_blockdev_report_vars SCRATCH_LOGDEV
diff --git a/common/populate b/common/populate
index 50dc75d3..a17acc9e 100644
--- a/common/populate
+++ b/common/populate
@@ -4,7 +4,7 @@
 #
 # Routines for populating a scratch fs, and helpers to exercise an FS
 # once it's been fuzzed.
-
+. common/exit
 . ./common/quota
 
 _require_populate_commands() {
diff --git a/common/preamble b/common/preamble
index ba029a34..0f306412 100644
--- a/common/preamble
+++ b/common/preamble
@@ -3,6 +3,7 @@
 # Copyright (c) 2021 Oracle.  All Rights Reserved.
 
 # Boilerplate fstests functionality
+. common/exit
 
 # Standard cleanup function.  Individual tests can override this.
 _cleanup()
diff --git a/common/punch b/common/punch
index 64d665d8..637f463f 100644
--- a/common/punch
+++ b/common/punch
@@ -3,6 +3,7 @@
 # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # common functions for excersizing hole punches with extent size hints etc.
+. common/exit
 
 _spawn_test_file() {
 	echo "# spawning test file with $*"
@@ -222,11 +223,6 @@ _filter_bmap()
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
diff --git a/common/rc b/common/rc
index 9bed6dad..945f5134 100644
--- a/common/rc
+++ b/common/rc
@@ -2,6 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 # Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
+. common/exit
 . common/config
 
 BC="$(type -P bc)" || BC=
@@ -1798,28 +1799,6 @@ _do()
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
@@ -3835,12 +3814,6 @@ _link_out_file()
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
diff --git a/common/repair b/common/repair
index fd206f8e..db6a1b5c 100644
--- a/common/repair
+++ b/common/repair
@@ -3,6 +3,7 @@
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # Functions useful for xfs_repair tests
+. common/exit
 
 _zero_position()
 {
diff --git a/common/xfs b/common/xfs
index 96c15f3c..c236146c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1,6 +1,7 @@
 #
 # XFS specific common functions.
 #
+. common/exit
 
 __generate_xfs_report_vars() {
 	__generate_blockdev_report_vars TEST_RTDEV
-- 
2.34.1


