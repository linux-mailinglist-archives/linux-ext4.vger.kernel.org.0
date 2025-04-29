Return-Path: <linux-ext4+bounces-7527-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5922AA03C6
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 08:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158C616FB97
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 06:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835582750F6;
	Tue, 29 Apr 2025 06:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh/NkL0c"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C31E515;
	Tue, 29 Apr 2025 06:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909625; cv=none; b=Zd78DFTWXk1s4EHC7PFRUYTfmM6Qh+dUgS1NWW8fhKAE2j/pFzmwu7JB3TTrr17yvWqySH9Rku8GTXhU9XHsREpofqnPtnVdpsryaZRWJK6D7v3CA9UzeB6BXq+2gQrC5io51qFB6OHsKIYoURuwfD0gTOhg+oEqYcqw1J1vB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909625; c=relaxed/simple;
	bh=85IvaB6Bjzz7ZANOAMsM2e1QOhztnC0AP8nq8HpkJdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jUwhM/tF4feR+H/NjuAwFSEp22v/+a5Y7s2f9W//S4JC4ZyQxp5cn8Xw+0Z/MHT2eFFNjgW1+3oJmP/uIgrcZVc/mEuo/zh19WaQ3d3DUMljIonwKecz2nFcJHhlD7p2f8Q04bfyGJl21YsdOL/GCBs8E0nYEUBEEsh673E2OMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lh/NkL0c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227d6b530d8so61057085ad.3;
        Mon, 28 Apr 2025 23:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745909622; x=1746514422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxn5sHYzQkb9RCUUQS2vRuRcY7fhgWnjkEBgGN2FXQk=;
        b=Lh/NkL0c18BYE6rdsinTo1+/gmg48laiK1BP3/QiHj0Ul6MWGbU4kQfapzZM3++lNd
         0Tr1Vs9dDL2WRDCJX197TfbpmHaSAKOe0u2oMN7ykeJETqceRrL+g+hcCBZD9NJ3jX0Q
         DYgGg1TpMqtoiM2Yprh4zof5rV0XqLiEEXwZLbPMhbei9Dn07OSJxoTfntG0gxa0Qf+O
         yNW9Nk+9QT+r1YV56rUzzj4ncebt9kFJnzz4XNzwPkrq+VCez8EnNubhWs7gifhNe603
         8au6OgggS1Fk2pG4jdhmI0u+uPSw4LvpMiTBN2y+HY12fhonIUry4UMVMKEqXlnh5ZbS
         YiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909622; x=1746514422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxn5sHYzQkb9RCUUQS2vRuRcY7fhgWnjkEBgGN2FXQk=;
        b=SY6tF71VRzOCH2KH0yyehV4u0rBylDE9Hsb7iS9e9hyUKuXw2sPIJ1v1yZjvI1B3WX
         s5sr8VEXYaJuUTU219zWpom3HhJGUemDX6sg/nfMXy2cv+NB75G1mvaSYwDoroZmxMrG
         fSZ0906mWcICsi8QeZwMEUw28XkGPv2iIw5sAkvzicbTQWVwltGlw2FpvngwPTFubn+o
         3i+pO+bJhyQ+ZgOAdWpOcIpTjGmg2GVc4rgP80hA1wM5Pxd+p89RPWDuHm3nd16p0IYN
         P3SiC6M9oeRPjTzk9rEoTQCqlucAlbjFtGeZ89vBAA8wQyH/IVDo6e1YYVtn7nBlWWMw
         cp6g==
X-Forwarded-Encrypted: i=1; AJvYcCVhybcTVXwwx3EZ/3kbW2e+NoykragiyeZAyKsdANBhP3OUaZ4AWaVIGyo3+/1G2kYHp1Kb68tDBT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyckcCoQNcR/ophqE6vSfwEce59DdFX4YTr0VR7NXacILgqdw25
	iC0thWUlGInEIvd5xvHbABUBQSt3JekcnZDN5/4fdQtcW5XxHY5Y9hHIiA==
X-Gm-Gg: ASbGncvlhEGd+X00D9MK6v/2D3lydpZ45kYjMjI22hmdktjemVeQkUNscJVcsqePWwR
	Qhfkd0yjEW02ooXB1Lr4poDYKWmuR/DblhEYXY9xZRP0TamQz/8u2nNG2/ASQbtsoBWmm0k9acX
	w8fv6hlO1PNcWAecEBrzDXf1TNHBjG9/7hfpJSV/uW4x2ZTAI8bD5HZFBDQCz96dubw/Kl6GxPx
	0dzcM9RfJT5wEJay5/12BTYaPfRgI6xaDI2jfALHTha0h8ty1MrC6jz7//O3PMNyUhDNBcXMghX
	D/Vl2V1H7GlbUBAnpI7eLzA6dekKEuHN0A3IiDv6kMRCNmgN2Ez5zKI=
X-Google-Smtp-Source: AGHT+IGaGhM2XrJw+VU4eAPVNMk0jLnnwNxC1CwQ52SsCGoPB2F9X1zYJTGQwSxcp23fcLJjWiXvNQ==
X-Received: by 2002:a17:902:e841:b0:216:410d:4c53 with SMTP id d9443c01a7336-22de6f1527amr29224405ad.41.1745909622447;
        Mon, 28 Apr 2025 23:53:42 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ddf3c9d1dsm24149805ad.244.2025.04.28.23.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 23:53:42 -0700 (PDT)
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
Subject: [PATCH v2 1/2] common: Move exit related functions to a common/exit
Date: Tue, 29 Apr 2025 06:52:53 +0000
Message-Id: <a2e20e1d74360a76fd2a1ef553cac6094897bff2.1745908976.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745908976.git.nirjhar.roy.lists@gmail.com>
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
 common/config   | 17 +----------------
 common/exit     | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 common/preamble |  1 +
 common/punch    |  5 -----
 common/rc       | 28 ---------------------------
 5 files changed, 52 insertions(+), 49 deletions(-)
 create mode 100644 common/exit

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
diff --git a/common/preamble b/common/preamble
index ba029a34..9b6b4b26 100644
--- a/common/preamble
+++ b/common/preamble
@@ -33,6 +33,7 @@ _register_cleanup()
 # explicitly as a member of the 'all' group.
 _begin_fstest()
 {
+	. common/exit
 	if [ -n "$seq" ]; then
 		echo "_begin_fstest can only be called once!"
 		_exit 1
diff --git a/common/punch b/common/punch
index 64d665d8..4e8ebcd7 100644
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


