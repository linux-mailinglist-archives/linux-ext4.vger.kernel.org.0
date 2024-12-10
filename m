Return-Path: <linux-ext4+bounces-5533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 744369EA92F
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D605162F94
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 06:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FDA22CBE6;
	Tue, 10 Dec 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3A6Dj6+Y"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453CB3594F;
	Tue, 10 Dec 2024 06:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813955; cv=none; b=EgPx30VFl36LRjRkh/Y8TQXWTU3bevnLeSZxfYF2Gp8F9lvXSRp++Ev7qpANkHoUOeXFxqGgoqXuNb8KbDj8UHSvkFFD3HeHGQ5obpGnQ36Qy5TtZH+6V9ymj/xrtRjm0FiJ4D0XfRh9OrwqmLLkCE3DkiKia3DlDnqBP+gWHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813955; c=relaxed/simple;
	bh=U0FTS8Gi8jS1yumEQY3S+E5F5KiFE2aeiMImvRdH+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kv00IfkeCmZ7rfYEiC6U39APVH3HZAOZrdzlLtkaMI1o4Yv4kwYi7sEURQBAHnYRNcJd644ImIoq528Kp/slqe2pwyyggEWj1Atc8uRqma9y6oo/M25fTpWa/vGR0PzmNrWAMIKMFZ7KNR69OBZudCK475rdjX9h4irZ/crjXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3A6Dj6+Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5ZvPA6bW6waN4/tm7zS4fslytrlAa4b9932hKe10UOY=; b=3A6Dj6+YPqbqTCBB6QA6W9z20m
	eCoga+CQKCR62lDOOj+r0KNA1TatEIWb4XpRvWRyG/4GDf+AfbG+TlGArmXEGRZG6QIrfP6FoM50M
	Jcpb3kBbh6VBMXckTycKXzfHcVb1cyi6y2e53ehnr8mltM7WmqUkAahNnBo4/LpPDYiys8dtbNDbn
	eNwBwGqQf3+lKrgylSXwTF+YSNBB6m5W4hcYjw/uBIe3doSDQzXfm7to7WqNvEMWFoFalg5f1RhEZ
	nrFAPGsaOpif8FeUdfNAoXkQXfMMcEgunY/+heWAXUv9a/YdXXT/Dk2eQiKMDOuBqd0oCajHFbqSx
	r8hT3Maw==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuDA-0000000AUeN-1Q25;
	Tue, 10 Dec 2024 06:59:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 3/4] ext-common: create a new test directory for ext* common tests
Date: Tue, 10 Dec 2024 07:58:27 +0100
Message-ID: <20241210065900.1235379-4-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210065900.1235379-1-hch@lst.de>
References: <20241210065900.1235379-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Split the tests shared with ext2 and ext3 from the ext4 directory.
This makes ext4 a normal file system specific directory and cuts down
the number of _supported_fs calls to a little more than a handful
for tests that can't run on ext2.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 check                              |  9 +++++----
 tests/{ext4 => ext-common}/002     |  2 +-
 tests/{ext4 => ext-common}/002.out |  0
 tests/{ext4 => ext-common}/036     |  2 +-
 tests/{ext4 => ext-common}/036.out |  0
 tests/{ext4 => ext-common}/037     |  2 +-
 tests/{ext4 => ext-common}/037.out |  0
 tests/{ext4 => ext-common}/038     |  2 +-
 tests/{ext4 => ext-common}/038.out |  0
 tests/{ext4 => ext-common}/039     |  2 +-
 tests/{ext4 => ext-common}/039.out |  0
 tests/{ext4 => ext-common}/040     |  1 -
 tests/{ext4 => ext-common}/040.out |  0
 tests/{ext4 => ext-common}/041     |  1 -
 tests/{ext4 => ext-common}/041.out |  0
 tests/{ext4 => ext-common}/042     |  3 ---
 tests/{ext4 => ext-common}/042.out |  0
 tests/{ext4 => ext-common}/043     |  2 +-
 tests/{ext4 => ext-common}/043.out |  0
 tests/{ext4 => ext-common}/053     |  1 -
 tests/{ext4 => ext-common}/053.out |  0
 tests/ext-common/Makefile          | 24 ++++++++++++++++++++++++
 tests/ext4/001                     |  1 -
 tests/ext4/003                     |  2 --
 tests/ext4/004                     |  2 --
 tests/ext4/005                     |  1 -
 tests/ext4/006                     |  2 --
 tests/ext4/007                     |  2 --
 tests/ext4/008                     |  2 --
 tests/ext4/009                     |  2 --
 tests/ext4/010                     |  2 --
 tests/ext4/011                     |  2 --
 tests/ext4/012                     |  2 --
 tests/ext4/013                     |  2 --
 tests/ext4/014                     |  2 --
 tests/ext4/015                     |  2 --
 tests/ext4/016                     |  2 --
 tests/ext4/017                     |  2 --
 tests/ext4/018                     |  2 --
 tests/ext4/019                     |  2 --
 tests/ext4/020                     |  1 -
 tests/ext4/021                     |  1 -
 tests/ext4/022                     |  1 -
 tests/ext4/023                     |  1 -
 tests/ext4/024                     |  1 -
 tests/ext4/025                     |  1 -
 tests/ext4/026                     |  1 -
 tests/ext4/027                     |  1 -
 tests/ext4/028                     |  1 -
 tests/ext4/029                     |  1 -
 tests/ext4/030                     |  2 --
 tests/ext4/031                     |  2 --
 tests/ext4/032                     |  2 --
 tests/ext4/033                     |  1 -
 tests/ext4/034                     |  3 ---
 tests/ext4/035                     |  1 -
 tests/ext4/044                     |  1 -
 tests/ext4/045                     |  2 --
 tests/ext4/046                     |  1 -
 tests/ext4/047                     |  1 -
 tests/ext4/048                     |  2 --
 tests/ext4/049                     |  1 -
 tests/ext4/050                     |  2 --
 tests/ext4/051                     |  1 -
 tests/ext4/052                     |  3 ---
 tests/ext4/054                     |  1 -
 tests/ext4/055                     |  1 -
 tests/ext4/056                     |  1 -
 tests/ext4/057                     |  1 -
 tests/ext4/058                     |  1 -
 tests/ext4/059                     |  1 -
 tests/ext4/060                     |  1 -
 tests/ext4/271                     |  1 -
 tests/ext4/301                     |  1 -
 tests/ext4/302                     |  1 -
 tests/ext4/303                     |  1 -
 tests/ext4/304                     |  1 -
 tests/ext4/305                     |  2 --
 tests/ext4/306                     |  2 --
 tests/ext4/307                     |  1 -
 80 files changed, 35 insertions(+), 102 deletions(-)
 rename tests/{ext4 => ext-common}/002 (99%)
 rename tests/{ext4 => ext-common}/002.out (100%)
 rename tests/{ext4 => ext-common}/036 (97%)
 rename tests/{ext4 => ext-common}/036.out (100%)
 rename tests/{ext4 => ext-common}/037 (96%)
 rename tests/{ext4 => ext-common}/037.out (100%)
 rename tests/{ext4 => ext-common}/038 (97%)
 rename tests/{ext4 => ext-common}/038.out (100%)
 rename tests/{ext4 => ext-common}/039 (98%)
 rename tests/{ext4 => ext-common}/039.out (100%)
 rename tests/{ext4 => ext-common}/040 (98%)
 rename tests/{ext4 => ext-common}/040.out (100%)
 rename tests/{ext4 => ext-common}/041 (98%)
 rename tests/{ext4 => ext-common}/041.out (100%)
 rename tests/{ext4 => ext-common}/042 (97%)
 rename tests/{ext4 => ext-common}/042.out (100%)
 rename tests/{ext4 => ext-common}/043 (97%)
 rename tests/{ext4 => ext-common}/043.out (100%)
 rename tests/{ext4 => ext-common}/053 (99%)
 rename tests/{ext4 => ext-common}/053.out (100%)
 create mode 100644 tests/ext-common/Makefile

diff --git a/check b/check
index 607d2456e6a1..f7998853e747 100755
--- a/check
+++ b/check
@@ -143,7 +143,7 @@ get_group_list()
 	local grp=$1
 	local grpl=""
 	local sub=$(dirname $grp)
-	local fsgroup="$FSTYP"
+	local fsgroups="$FSTYP"
 
 	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
 		# group is given as <subdir>/<group> (e.g. xfs/quick)
@@ -152,10 +152,11 @@ get_group_list()
 		return
 	fi
 
-	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 ]; then
-	    fsgroup=ext4
+	if [ "$FSTYP" = ext2 -o "$FSTYP" = ext3 -o "$FSTYP" = ext4 ]; then
+	    fsgroups="$fsgroups ext-common"
 	fi
-	for d in $SRC_GROUPS $fsgroup; do
+
+	for d in $SRC_GROUPS $fsgroups; do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
diff --git a/tests/ext4/002 b/tests/ext-common/002
similarity index 99%
rename from tests/ext4/002
rename to tests/ext-common/002
index 9c6eb5a04136..7b3d5918bde9 100755
--- a/tests/ext4/002
+++ b/tests/ext-common/002
@@ -29,7 +29,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4 ext3
+_supported_fs ^ext2
 
 _require_scratch_nocheck
 _require_scratch_shutdown
diff --git a/tests/ext4/002.out b/tests/ext-common/002.out
similarity index 100%
rename from tests/ext4/002.out
rename to tests/ext-common/002.out
diff --git a/tests/ext4/036 b/tests/ext-common/036
similarity index 97%
rename from tests/ext4/036
rename to tests/ext-common/036
index 045fe82ff956..729d842df6e7 100755
--- a/tests/ext4/036
+++ b/tests/ext-common/036
@@ -15,7 +15,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext3 ext4
+_supported_fs ^ext2
 _require_scratch
 
 echo "Silence is golden"
diff --git a/tests/ext4/036.out b/tests/ext-common/036.out
similarity index 100%
rename from tests/ext4/036.out
rename to tests/ext-common/036.out
diff --git a/tests/ext4/037 b/tests/ext-common/037
similarity index 96%
rename from tests/ext4/037
rename to tests/ext-common/037
index ac309d67aac5..3f2232f0de60 100755
--- a/tests/ext4/037
+++ b/tests/ext-common/037
@@ -15,7 +15,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext3 ext4
+_supported_fs ^ext2
 
 # nofsck as we modify sb via debugfs
 _require_scratch_nocheck
diff --git a/tests/ext4/037.out b/tests/ext-common/037.out
similarity index 100%
rename from tests/ext4/037.out
rename to tests/ext-common/037.out
diff --git a/tests/ext4/038 b/tests/ext-common/038
similarity index 97%
rename from tests/ext4/038
rename to tests/ext-common/038
index b594bd9cb2e2..09d3b10bdcf2 100755
--- a/tests/ext4/038
+++ b/tests/ext-common/038
@@ -12,7 +12,7 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-_supported_fs ext3 ext4
+_supported_fs ^ext2
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
diff --git a/tests/ext4/038.out b/tests/ext-common/038.out
similarity index 100%
rename from tests/ext4/038.out
rename to tests/ext-common/038.out
diff --git a/tests/ext4/039 b/tests/ext-common/039
similarity index 98%
rename from tests/ext4/039
rename to tests/ext-common/039
index 2830740eb3cf..be766668df60 100755
--- a/tests/ext4/039
+++ b/tests/ext-common/039
@@ -56,7 +56,7 @@ chattr_opt: $chattr_opt" >>$seqres.full
 	done
 }
 
-_supported_fs ext3 ext4
+_supported_fs ^ext2
 _require_scratch
 _exclude_scratch_mount_option dax
 
diff --git a/tests/ext4/039.out b/tests/ext-common/039.out
similarity index 100%
rename from tests/ext4/039.out
rename to tests/ext-common/039.out
diff --git a/tests/ext4/040 b/tests/ext-common/040
similarity index 98%
rename from tests/ext4/040
rename to tests/ext-common/040
index 5760058ad7d4..f22c655b4909 100755
--- a/tests/ext4/040
+++ b/tests/ext-common/040
@@ -21,7 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext2 ext3 ext4
 _require_scratch_nocheck
 _disable_dmesg_check
 _require_command "$DEBUGFS_PROG"
diff --git a/tests/ext4/040.out b/tests/ext-common/040.out
similarity index 100%
rename from tests/ext4/040.out
rename to tests/ext-common/040.out
diff --git a/tests/ext4/041 b/tests/ext-common/041
similarity index 98%
rename from tests/ext4/041
rename to tests/ext-common/041
index 76513db3f887..3df1b9db803d 100755
--- a/tests/ext4/041
+++ b/tests/ext-common/041
@@ -21,7 +21,6 @@ PIDS=""
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext2 ext3 ext4
 _require_scratch_nocheck
 _disable_dmesg_check
 _require_command "$DEBUGFS_PROG"
diff --git a/tests/ext4/041.out b/tests/ext-common/041.out
similarity index 100%
rename from tests/ext4/041.out
rename to tests/ext-common/041.out
diff --git a/tests/ext4/042 b/tests/ext-common/042
similarity index 97%
rename from tests/ext4/042
rename to tests/ext-common/042
index 0d97f6de4c2a..61fe948f2b61 100755
--- a/tests/ext4/042
+++ b/tests/ext-common/042
@@ -12,9 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-
-# Modify as appropriate.
-_supported_fs ext2 ext3 ext4
 _require_scratch
 
 _scratch_mkfs >> $seqres.full 2>&1
diff --git a/tests/ext4/042.out b/tests/ext-common/042.out
similarity index 100%
rename from tests/ext4/042.out
rename to tests/ext-common/042.out
diff --git a/tests/ext4/043 b/tests/ext-common/043
similarity index 97%
rename from tests/ext4/043
rename to tests/ext-common/043
index 0bbbb42ac41d..cf0bef4e7407 100755
--- a/tests/ext4/043
+++ b/tests/ext-common/043
@@ -12,7 +12,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext3 ext4
+_supported_fs ^ext2
 
 _require_scratch
 _require_test_program "t_get_file_time"
diff --git a/tests/ext4/043.out b/tests/ext-common/043.out
similarity index 100%
rename from tests/ext4/043.out
rename to tests/ext-common/043.out
diff --git a/tests/ext4/053 b/tests/ext-common/053
similarity index 99%
rename from tests/ext4/053
rename to tests/ext-common/053
index 4f20d217d5fd..5922ed571d8a 100755
--- a/tests/ext4/053
+++ b/tests/ext-common/053
@@ -39,7 +39,6 @@ echo "Silence is golden."
 SIZE=$((1024 * 1024))	# 1GB in KB
 LOGSIZE=$((10 *1024))	# 10MB in KB
 
-_supported_fs ext2 ext3 ext4
 _require_scratch_size $SIZE
 _require_quota
 _require_loop
diff --git a/tests/ext4/053.out b/tests/ext-common/053.out
similarity index 100%
rename from tests/ext4/053.out
rename to tests/ext-common/053.out
diff --git a/tests/ext-common/Makefile b/tests/ext-common/Makefile
new file mode 100644
index 000000000000..686d38410377
--- /dev/null
+++ b/tests/ext-common/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+THIS_DIR = ext-common
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(THIS_DIR)
+DIRT = group.list
+
+default: $(DIRT)
+
+include $(BUILDRULES)
+
+install: default
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group.list $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
diff --git a/tests/ext4/001 b/tests/ext4/001
index 4575cf6973bb..7d20794c90dc 100755
--- a/tests/ext4/001
+++ b/tests/ext4/001
@@ -14,7 +14,6 @@ _begin_fstest auto prealloc quick zero fiemap
 . ./common/filter
 . ./common/punch
 
-_supported_fs ext4
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fzero"
 _require_test
diff --git a/tests/ext4/003 b/tests/ext4/003
index e2b588d88849..5b5c5f5335b2 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -20,8 +20,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 _require_scratch_ext4_feature "bigalloc"
 
diff --git a/tests/ext4/004 b/tests/ext4/004
index ab2f838e9fac..6dee9d43130c 100755
--- a/tests/ext4/004
+++ b/tests/ext4/004
@@ -43,8 +43,6 @@ workout()
 	rm -rf restoresymtable
 }
 
-_supported_fs ext4
-
 _require_test
 _require_scratch
 
diff --git a/tests/ext4/005 b/tests/ext4/005
index a271fbbf641a..f162dee11d1e 100755
--- a/tests/ext4/005
+++ b/tests/ext4/005
@@ -17,7 +17,6 @@ _begin_fstest auto quick metadata ioctl rw
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 _require_command "$CHATTR_PROG" chattr
 
diff --git a/tests/ext4/006 b/tests/ext4/006
index d78620731148..a4c9fd5ca75b 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -28,8 +28,6 @@ if [ ! -x "$(type -P e2fuzz)" ]; then
 	_notrun "Couldn't find e2fuzz"
 fi
 
-_supported_fs ext4
-
 _require_scratch
 _require_attrs
 _require_populate_commands
diff --git a/tests/ext4/007 b/tests/ext4/007
index deedbd9e8fb3..3a1f05a46b6d 100755
--- a/tests/ext4/007
+++ b/tests/ext4/007
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/008 b/tests/ext4/008
index b4b20ac10d6d..fdd5fef82f91 100755
--- a/tests/ext4/008
+++ b/tests/ext4/008
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/009 b/tests/ext4/009
index 06a42fd77ffa..7b498d9777f4 100755
--- a/tests/ext4/009
+++ b/tests/ext4/009
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_xfs_io_command "falloc"
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
diff --git a/tests/ext4/010 b/tests/ext4/010
index 1139c79e80d5..a6c52c2044f9 100755
--- a/tests/ext4/010
+++ b/tests/ext4/010
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 _require_dumpe2fs
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
diff --git a/tests/ext4/011 b/tests/ext4/011
index cae4fb6b8476..9ef5f9f9e26d 100755
--- a/tests/ext4/011
+++ b/tests/ext4/011
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/012 b/tests/ext4/012
index f7f2b0fb4557..aaef6bf709c4 100755
--- a/tests/ext4/012
+++ b/tests/ext4/012
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/013 b/tests/ext4/013
index 7d2a9154a669..6814415cee6c 100755
--- a/tests/ext4/013
+++ b/tests/ext4/013
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/014 b/tests/ext4/014
index ffed795ad4e9..20ae684df994 100755
--- a/tests/ext4/014
+++ b/tests/ext4/014
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/015 b/tests/ext4/015
index 81feda5c9423..e405a3da96d6 100755
--- a/tests/ext4/015
+++ b/tests/ext4/015
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_scratch
diff --git a/tests/ext4/016 b/tests/ext4/016
index b7db4cfda649..00dcb61ec7b0 100755
--- a/tests/ext4/016
+++ b/tests/ext4/016
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/017 b/tests/ext4/017
index fc867442c3da..c29f6a741674 100755
--- a/tests/ext4/017
+++ b/tests/ext4/017
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/018 b/tests/ext4/018
index f7377f059fb8..d0e071c68def 100755
--- a/tests/ext4/018
+++ b/tests/ext4/018
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/019 b/tests/ext4/019
index 987972a80a37..35b291abd598 100755
--- a/tests/ext4/019
+++ b/tests/ext4/019
@@ -21,8 +21,6 @@ _cleanup()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
-
 _require_scratch
 test -n "${FORCE_FUZZ}" || _require_scratch_ext4_crc
 _require_attrs
diff --git a/tests/ext4/020 b/tests/ext4/020
index a2fb60fa8cc6..6a3a5a299c45 100755
--- a/tests/ext4/020
+++ b/tests/ext4/020
@@ -17,7 +17,6 @@ _begin_fstest auto quick ioctl rw defrag
 . ./common/filter
 . ./common/defrag
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 
diff --git a/tests/ext4/021 b/tests/ext4/021
index d69dc584dc58..8df8edb22591 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 
 # Import common functions.
 
-_supported_fs ext4
 _require_scratch
 _require_dumpe2fs
 
diff --git a/tests/ext4/022 b/tests/ext4/022
index 6b74ff892a35..f5701c1b43a0 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -18,7 +18,6 @@ do_setfattr()
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
 _require_scratch
 _require_dumpe2fs
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/023 b/tests/ext4/023
index b5217da33f15..4e26aae6535b 100755
--- a/tests/ext4/023
+++ b/tests/ext4/023
@@ -18,7 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/populate
 . ./common/fuzzy
 
-_supported_fs ext4
 _require_scratch
 
 echo "Format and populate"
diff --git a/tests/ext4/024 b/tests/ext4/024
index e58cb9918f25..0b05d7345f24 100755
--- a/tests/ext4/024
+++ b/tests/ext4/024
@@ -13,7 +13,6 @@ _begin_fstest auto quick encrypt dangerous
 # get standard environment and checks
 . ./common/encrypt
 
-_supported_fs ext4
 _require_scratch_encryption
 _require_command "$KEYCTL_PROG" keyctl
 
diff --git a/tests/ext4/025 b/tests/ext4/025
index ce3a3d21969b..2f9da4c7d957 100755
--- a/tests/ext4/025
+++ b/tests/ext4/025
@@ -13,7 +13,6 @@ _begin_fstest auto quick fuzzers dangerous
 # get standard environment and checks
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch_nocheck
 _require_command "$DEBUGFS_PROG" debugfs
 _require_scratch_ext4_feature "bigalloc,meta_bg,^resize_inode"
diff --git a/tests/ext4/026 b/tests/ext4/026
index 5bb2add23036..494de9bcdcae 100755
--- a/tests/ext4/026
+++ b/tests/ext4/026
@@ -16,7 +16,6 @@ _begin_fstest auto quick attr
 . ./common/filter
 . ./common/attr
 
-_supported_fs ext4
 _require_scratch
 _require_attrs
 _require_scratch_ext4_feature "ea_inode"
diff --git a/tests/ext4/027 b/tests/ext4/027
index 93de00f29481..50d999c25713 100755
--- a/tests/ext4/027
+++ b/tests/ext4/027
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 _require_xfs_io_command "fsmap"
 
diff --git a/tests/ext4/028 b/tests/ext4/028
index 30f3c4480c7c..244fd4442825 100755
--- a/tests/ext4/028
+++ b/tests/ext4/028
@@ -20,7 +20,6 @@ _cleanup()
 . ./common/filter
 . ./common/populate
 
-_supported_fs ext4
 _require_scratch
 _require_populate_commands
 _require_xfs_io_command "fsmap"
diff --git a/tests/ext4/029 b/tests/ext4/029
index 8a6969d2aaef..0912b04d4f0c 100755
--- a/tests/ext4/029
+++ b/tests/ext4/029
@@ -19,7 +19,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_logdev
 _require_scratch
 _require_xfs_io_command "fsmap"
diff --git a/tests/ext4/030 b/tests/ext4/030
index 80f34ccf3e49..c54a0131b6de 100755
--- a/tests/ext4/030
+++ b/tests/ext4/030
@@ -14,8 +14,6 @@ _begin_fstest auto quick dax
 # Import common functions.
 . ./common/filter
 
-# Modify as appropriate.
-_supported_fs ext4
 _require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_journal_corruption"
 _require_command "$CHATTR_PROG" chattr
diff --git a/tests/ext4/031 b/tests/ext4/031
index b583f825162f..1f129460f0f7 100755
--- a/tests/ext4/031
+++ b/tests/ext4/031
@@ -18,8 +18,6 @@ _begin_fstest auto quick dax
 SAVE_MOUNT_OPTIONS="$MOUNT_OPTIONS"
 MOUNT_OPTIONS=""
 
-# Modify as appropriate.
-_supported_fs ext4
 _require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_inline_corruption"
 _require_scratch_ext4_feature "inline_data"
diff --git a/tests/ext4/032 b/tests/ext4/032
index 238ab178363c..815502ef031b 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -83,8 +83,6 @@ _cleanup()
 
 # get standard environment and checks
 
-_supported_fs ext4
-
 _require_loop
 _require_scratch
 # We use resize_inode to make sure that block group descriptor table
diff --git a/tests/ext4/033 b/tests/ext4/033
index 53f7106e2c6b..be102bbdcdea 100755
--- a/tests/ext4/033
+++ b/tests/ext4/033
@@ -24,7 +24,6 @@ _cleanup()
 . ./common/filter
 . ./common/dmhugedisk
 
-_supported_fs ext4
 _require_scratch_nocheck
 _require_dmhugedisk
 _require_dumpe2fs
diff --git a/tests/ext4/034 b/tests/ext4/034
index cdd2e553f534..e50f9277e634 100755
--- a/tests/ext4/034
+++ b/tests/ext4/034
@@ -17,9 +17,6 @@ _begin_fstest auto quick quota fiemap prealloc
 . ./common/filter
 . ./common/quota
 
-
-# Modify as appropriate.
-_supported_fs ext4
 _require_scratch
 _require_quota
 _require_nobody
diff --git a/tests/ext4/035 b/tests/ext4/035
index cf221c5adb7d..e8da7481edf5 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -19,7 +19,6 @@ _begin_fstest auto quick resize
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 _exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
diff --git a/tests/ext4/044 b/tests/ext4/044
index 53006514dc72..ec8c0f4e7bc9 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -12,7 +12,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 _require_test_program "t_get_file_time"
 _require_metadata_journaling
diff --git a/tests/ext4/045 b/tests/ext4/045
index 587bedece4e1..3db87dbd1b39 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -16,8 +16,6 @@ LONG_DIR=2
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 _require_scratch_ext4_feature large_dir
 _require_test_program "t_create_short_dirs"
diff --git a/tests/ext4/046 b/tests/ext4/046
index 5c2100ce9253..b8e11b81a404 100755
--- a/tests/ext4/046
+++ b/tests/ext4/046
@@ -16,7 +16,6 @@ _begin_fstest auto prealloc quick
 . ./common/filter
 
 _require_check_dmesg
-_supported_fs ext4
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_scratch_size $((6 * 1024 * 1024)) #kB
diff --git a/tests/ext4/047 b/tests/ext4/047
index f67b615ab082..c0fce3a0f658 100755
--- a/tests/ext4/047
+++ b/tests/ext4/047
@@ -13,7 +13,6 @@ _begin_fstest auto quick dax
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch_dax_mountopt "dax=always"
 _require_dax_iflag
 _require_scratch_ext4_feature "inline_data"
diff --git a/tests/ext4/048 b/tests/ext4/048
index 99a2c7b8fe4d..c8981058e0b9 100755
--- a/tests/ext4/048
+++ b/tests/ext4/048
@@ -13,8 +13,6 @@ _begin_fstest auto quick dir
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
diff --git a/tests/ext4/049 b/tests/ext4/049
index 5b24e632a73b..6a86b16b2aa9 100755
--- a/tests/ext4/049
+++ b/tests/ext4/049
@@ -13,7 +13,6 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 
 sdev=$(_short_dev ${SCRATCH_DEV})
diff --git a/tests/ext4/050 b/tests/ext4/050
index 6ba0038e71f2..350f62907b04 100755
--- a/tests/ext4/050
+++ b/tests/ext4/050
@@ -13,8 +13,6 @@ _begin_fstest auto ioctl quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
diff --git a/tests/ext4/051 b/tests/ext4/051
index a1e35fa323d3..4317b86d2a8c 100755
--- a/tests/ext4/051
+++ b/tests/ext4/051
@@ -12,7 +12,6 @@
 . ./common/preamble
 _begin_fstest auto rw quick
 
-_supported_fs ext4
 _require_scratch
 _require_scratch_shutdown
 _require_command "$TUNE2FS_PROG" tune2fs
diff --git a/tests/ext4/052 b/tests/ext4/052
index edcdc02515f7..adcf632679b4 100755
--- a/tests/ext4/052
+++ b/tests/ext4/052
@@ -27,9 +27,6 @@ _cleanup()
 # Import common functions.
 # . ./common/filter
 
-
-# Modify as appropriate.
-_supported_fs ext4
 _require_test
 _require_loop
 _require_test_program "dirstress"
diff --git a/tests/ext4/054 b/tests/ext4/054
index 0dbe83640072..9b806bca8e46 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -17,7 +17,6 @@ _begin_fstest auto quick dangerous_fuzzers prealloc punch
 # Import common functions
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "pwrite"
diff --git a/tests/ext4/055 b/tests/ext4/055
index e1815c23727a..6f5704049b7c 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -17,7 +17,6 @@
 _begin_fstest auto quota
 
 _require_scratch_nocheck
-_supported_fs ext4
 _require_user fsgqa
 _require_user fsgqa2
 _require_command "$DEBUGFS_PROG" debugfs
diff --git a/tests/ext4/056 b/tests/ext4/056
index 8a290b11d697..fd471fde3038 100755
--- a/tests/ext4/056
+++ b/tests/ext4/056
@@ -26,7 +26,6 @@ ONLINE_RESIZE_BLOCK_LIMIT=$((256*1024*1024))
 
 STOP_ITER=255   # Arbitrary return code
 
-_supported_fs ext4
 _require_scratch_size $(($RESIZED_FS_SIZE/1024))
 _require_test_program "ext4_resize"
 
diff --git a/tests/ext4/057 b/tests/ext4/057
index 73cdf941a181..d8655e00150e 100755
--- a/tests/ext4/057
+++ b/tests/ext4/057
@@ -11,7 +11,6 @@ _begin_fstest auto ioctl
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 _require_test_program uuid_ioctl
 _require_command $UUIDGEN_PROG uuidgen
diff --git a/tests/ext4/058 b/tests/ext4/058
index f853649644db..c291547b38fd 100755
--- a/tests/ext4/058
+++ b/tests/ext4/058
@@ -13,7 +13,6 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-_supported_fs ext4
 _fixed_by_kernel_commit a08f789d2ab5 \
 	"ext4: fix bug_on ext4_mb_use_inode_pa"
 _require_scratch
diff --git a/tests/ext4/059 b/tests/ext4/059
index 50e788f0a169..6bb1c4bac44d 100755
--- a/tests/ext4/059
+++ b/tests/ext4/059
@@ -11,7 +11,6 @@
 . ./common/preamble
 _begin_fstest auto resize quick
 
-_supported_fs ext4
 _fixed_by_kernel_commit b55c3cd102a6 \
 	"ext4: add reserved GDT blocks check"
 
diff --git a/tests/ext4/060 b/tests/ext4/060
index 38d1c8f7b672..67d6e444c051 100755
--- a/tests/ext4/060
+++ b/tests/ext4/060
@@ -14,7 +14,6 @@
 . ./common/preamble
 _begin_fstest auto resize quick
 
-_supported_fs ext4
 _fixed_by_kernel_commit a6b3bfe176e8 \
 	"ext4: fix corruption during on-line resize"
 
diff --git a/tests/ext4/271 b/tests/ext4/271
index 6d60f40d3d25..62bb8a073934 100755
--- a/tests/ext4/271
+++ b/tests/ext4/271
@@ -12,7 +12,6 @@ _begin_fstest auto rw quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
 _require_scratch
 # this test needs no journal to be loaded, skip on journal related mount
 # options, otherwise mount would fail with "-o noload" mount option
diff --git a/tests/ext4/301 b/tests/ext4/301
index dd0c7d483761..855ebe3d0660 100755
--- a/tests/ext4/301
+++ b/tests/ext4/301
@@ -15,7 +15,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_odirect
diff --git a/tests/ext4/302 b/tests/ext4/302
index d73cf9bf84da..9e3c5e6939eb 100755
--- a/tests/ext4/302
+++ b/tests/ext4/302
@@ -16,7 +16,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_odirect
diff --git a/tests/ext4/303 b/tests/ext4/303
index d9be45674e40..8cfb69830687 100755
--- a/tests/ext4/303
+++ b/tests/ext4/303
@@ -16,7 +16,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_odirect
diff --git a/tests/ext4/304 b/tests/ext4/304
index 208b8a2ac119..7ef2e6508cd3 100755
--- a/tests/ext4/304
+++ b/tests/ext4/304
@@ -17,7 +17,6 @@ fio_config=$tmp.fio
 . ./common/filter
 . ./common/defrag
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_odirect
diff --git a/tests/ext4/305 b/tests/ext4/305
index acada44bc75a..ce4d7742db23 100755
--- a/tests/ext4/305
+++ b/tests/ext4/305
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 
 echo "Silence is golden"
diff --git a/tests/ext4/306 b/tests/ext4/306
index b5147caf547e..d657185cd5fe 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -22,8 +22,6 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ext4
-
 _require_scratch
 _require_command "$RESIZE2FS_PROG" resize2fs
 
diff --git a/tests/ext4/307 b/tests/ext4/307
index 8361f04312b2..b46be6b8b487 100755
--- a/tests/ext4/307
+++ b/tests/ext4/307
@@ -34,7 +34,6 @@ _workout()
 	run_check md5sum -c $out.md5sum
 }
 
-_supported_fs ext4
 _require_scratch
 _require_defrag
 _require_xfs_io_command "falloc"
-- 
2.45.2


