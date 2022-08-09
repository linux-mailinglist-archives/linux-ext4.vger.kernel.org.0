Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF3B58E16F
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 23:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiHIVBv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 17:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiHIVA6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 17:00:58 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202DD2C11F;
        Tue,  9 Aug 2022 14:00:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0BBABCE193E;
        Tue,  9 Aug 2022 21:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BB9C433D6;
        Tue,  9 Aug 2022 21:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660078847;
        bh=eiPQn7cGJWMMHAwHakKJ/wtSzsCU8/1/HqgFWIpiSmA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CDc0UiQ181b/IYCs2KdlG3ndQ1eY/evu1DA73yHQkwsnejOETtPODF6tSlzJdytgl
         dukmm2EHJ+llXzkQtCEIS/ix5aKAxWhd2SYpFm05e9TmaU7Nt6P1Q57oZDVGtFvLWl
         krpi7oQQ07Mw8dGGoGxOwDGc00ahy006RSG/H7Zb7PtevOuQ2GWSyJhcpul3MV2StR
         WENhUjPgD0ZKNH6Qg7/jR2Vo6qB0SKekggNuBCb8yW1WfXs5pd5lOgXCighGAjjvEL
         D364uitUCOSSq6XXZhx64NX12plpvaXij5Y04y4Yz766y05n9xMK+DA2dZiT7KyLgJ
         u4+cSWag8lsiA==
Subject: [PATCH 1/3] common/rc: move ext4-specific helpers into a separate
 common/ext4 file
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 09 Aug 2022 14:00:46 -0700
Message-ID: <166007884681.3276300.8815951431509313240.stgit@magnolia>
In-Reply-To: <166007884125.3276300.15348421560641051945.stgit@magnolia>
References: <166007884125.3276300.15348421560641051945.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Move the ext4-specific parts of common/rc into a separate file and
source it when we test that.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 common/config |    4 +
 common/ext4   |  156 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc     |  153 --------------------------------------------------------
 3 files changed, 160 insertions(+), 153 deletions(-)
 create mode 100644 common/ext4


diff --git a/common/config b/common/config
index c30eec6d..5eaae447 100644
--- a/common/config
+++ b/common/config
@@ -512,6 +512,10 @@ _source_specific_fs()
 		;;
 	ext4)
 		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
+		. ./common/ext4
+		;;
+	ext2|ext3|ext4dev)
+		. ./common/ext4
 		;;
 	f2fs)
 		[ "$MKFS_F2FS_PROG" = "" ] && _fatal "mkfs.f2fs not found"
diff --git a/common/ext4 b/common/ext4
new file mode 100644
index 00000000..287705af
--- /dev/null
+++ b/common/ext4
@@ -0,0 +1,156 @@
+#
+# ext4 specific common functions
+#
+
+_setup_large_ext4_fs()
+{
+	local fs_size=$1
+	local tmp_dir=/tmp/
+
+	[ "$LARGE_SCRATCH_DEV" != yes ] && return 0
+	[ -z "$SCRATCH_DEV_EMPTY_SPACE" ] && SCRATCH_DEV_EMPTY_SPACE=0
+	[ $SCRATCH_DEV_EMPTY_SPACE -ge $fs_size ] && return 0
+
+	# Default free space in the FS is 50GB, but you can specify more via
+	# SCRATCH_DEV_EMPTY_SPACE
+	local space_to_consume=$(($fs_size - 50*1024*1024*1024 - $SCRATCH_DEV_EMPTY_SPACE))
+
+	# mount the filesystem and create 16TB - 4KB files until we consume
+	# all the necessary space.
+	_try_scratch_mount 2>&1 >$tmp_dir/mnt.err
+	local status=$?
+	if [ $status -ne 0 ]; then
+		echo "mount failed"
+		cat $tmp_dir/mnt.err >&2
+		rm -f $tmp_dir/mnt.err
+		return $status
+	fi
+	rm -f $tmp_dir/mnt.err
+
+	local file_size=$((16*1024*1024*1024*1024 - 4096))
+	local nfiles=0
+	while [ $space_to_consume -gt $file_size ]; do
+
+		xfs_io -F -f \
+			-c "truncate $file_size" \
+			-c "falloc -k 0 $file_size" \
+			$SCRATCH_MNT/.use_space.$nfiles 2>&1
+		status=$?
+		if [ $status -ne 0 ]; then
+			break;
+		fi
+
+		space_to_consume=$(( $space_to_consume - $file_size ))
+		nfiles=$(($nfiles + 1))
+	done
+
+	# consume the remaining space.
+	if [ $space_to_consume -gt 0 ]; then
+		xfs_io -F -f \
+			-c "truncate $space_to_consume" \
+			-c "falloc -k 0 $space_to_consume" \
+			$SCRATCH_MNT/.use_space.$nfiles 2>&1
+		status=$?
+	fi
+	export NUM_SPACE_FILES=$nfiles
+
+	_scratch_unmount
+	if [ $status -ne 0 ]; then
+		echo "large file prealloc failed"
+		cat $tmp_dir/mnt.err >&2
+		return $status
+	fi
+	return 0
+}
+
+_scratch_mkfs_ext4()
+{
+	local mkfs_cmd="$MKFS_EXT4_PROG -F"
+	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
+	local tmp=`mktemp -u`
+	local mkfs_status
+
+	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
+	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
+	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
+
+	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
+	mkfs_status=$?
+
+	if [ $mkfs_status -eq 0 -a "$LARGE_SCRATCH_DEV" = yes ]; then
+		# manually parse the mkfs output to get the fs size in bytes
+		local fs_size=`cat $tmp.mkfsstd | awk ' \
+			/^Block size/ { split($2, a, "="); bs = a[2] ; } \
+			/ inodes, / { blks = $3 } \
+			/reserved for the super user/ { resv = $1 } \
+			END { fssize = bs * blks - resv; print fssize }'`
+
+		_setup_large_ext4_fs $fs_size
+		mkfs_status=$?
+	fi
+
+	# output mkfs stdout and stderr
+	cat $tmp.mkfsstd
+	cat $tmp.mkfserr >&2
+	rm -f $tmp.mkfserr $tmp.mkfsstd
+
+	return $mkfs_status
+}
+
+_ext4_metadump()
+{
+	local device="$1"
+	local dumpfile="$2"
+	local compressopt="$3"
+
+	test -n "$E2IMAGE_PROG" || _fail "e2image not installed"
+	$E2IMAGE_PROG -Q "$device" "$dumpfile"
+	[ "$compressopt" = "compress" ] && [ -n "$DUMP_COMPRESSOR" ] &&
+		$DUMP_COMPRESSOR -f "$dumpfile" &>> "$seqres.full"
+}
+
+# this test requires the ext4 kernel support crc feature on scratch device
+#
+_require_scratch_ext4_crc()
+{
+	_scratch_mkfs_ext4 >/dev/null 2>&1
+	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
+	_try_scratch_mount >/dev/null 2>&1 \
+	   || _notrun "Kernel doesn't support metadata_csum feature"
+	_scratch_unmount
+}
+
+# Check whether the specified feature whether it is supported by
+# mkfs.ext4 and the kernel.
+_require_scratch_ext4_feature()
+{
+    if [ -z "$1" ]; then
+        echo "Usage: _require_scratch_ext4_feature feature"
+        exit 1
+    fi
+    $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
+		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
+	|| _notrun "mkfs.ext4 doesn't support $1 feature"
+    _try_scratch_mount >/dev/null 2>&1 \
+	|| _notrun "Kernel doesn't support the ext4 feature(s): $1"
+    _scratch_unmount
+}
+
+# Disable extent zeroing for ext4 on the given device
+_ext4_disable_extent_zeroout()
+{
+	local dev=${1:-$TEST_DEV}
+	local sdev=`_short_dev $dev`
+
+	[ -f /sys/fs/ext4/$sdev/extent_max_zeroout_kb ] && \
+		echo 0 >/sys/fs/ext4/$sdev/extent_max_zeroout_kb
+}
+
+_require_scratch_richacl_ext4()
+{
+	_scratch_mkfs -O richacl >/dev/null 2>&1 \
+		|| _notrun "can't mkfs $FSTYP with option -O richacl"
+	_try_scratch_mount >/dev/null 2>&1 \
+		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
+	_scratch_unmount
+}
diff --git a/common/rc b/common/rc
index 197c9415..52dd3b41 100644
--- a/common/rc
+++ b/common/rc
@@ -559,113 +559,6 @@ _scratch_do_mkfs()
 	return $mkfs_status
 }
 
-_setup_large_ext4_fs()
-{
-	local fs_size=$1
-	local tmp_dir=/tmp/
-
-	[ "$LARGE_SCRATCH_DEV" != yes ] && return 0
-	[ -z "$SCRATCH_DEV_EMPTY_SPACE" ] && SCRATCH_DEV_EMPTY_SPACE=0
-	[ $SCRATCH_DEV_EMPTY_SPACE -ge $fs_size ] && return 0
-
-	# Default free space in the FS is 50GB, but you can specify more via
-	# SCRATCH_DEV_EMPTY_SPACE
-	local space_to_consume=$(($fs_size - 50*1024*1024*1024 - $SCRATCH_DEV_EMPTY_SPACE))
-
-	# mount the filesystem and create 16TB - 4KB files until we consume
-	# all the necessary space.
-	_try_scratch_mount 2>&1 >$tmp_dir/mnt.err
-	local status=$?
-	if [ $status -ne 0 ]; then
-		echo "mount failed"
-		cat $tmp_dir/mnt.err >&2
-		rm -f $tmp_dir/mnt.err
-		return $status
-	fi
-	rm -f $tmp_dir/mnt.err
-
-	local file_size=$((16*1024*1024*1024*1024 - 4096))
-	local nfiles=0
-	while [ $space_to_consume -gt $file_size ]; do
-
-		xfs_io -F -f \
-			-c "truncate $file_size" \
-			-c "falloc -k 0 $file_size" \
-			$SCRATCH_MNT/.use_space.$nfiles 2>&1
-		status=$?
-		if [ $status -ne 0 ]; then
-			break;
-		fi
-
-		space_to_consume=$(( $space_to_consume - $file_size ))
-		nfiles=$(($nfiles + 1))
-	done
-
-	# consume the remaining space.
-	if [ $space_to_consume -gt 0 ]; then
-		xfs_io -F -f \
-			-c "truncate $space_to_consume" \
-			-c "falloc -k 0 $space_to_consume" \
-			$SCRATCH_MNT/.use_space.$nfiles 2>&1
-		status=$?
-	fi
-	export NUM_SPACE_FILES=$nfiles
-
-	_scratch_unmount
-	if [ $status -ne 0 ]; then
-		echo "large file prealloc failed"
-		cat $tmp_dir/mnt.err >&2
-		return $status
-	fi
-	return 0
-}
-
-_scratch_mkfs_ext4()
-{
-	local mkfs_cmd="$MKFS_EXT4_PROG -F"
-	local mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \" | grep -v \"^$\""
-	local tmp=`mktemp -u`
-	local mkfs_status
-
-	[ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ] && \
-	    $mkfs_cmd -O journal_dev $MKFS_OPTIONS $SCRATCH_LOGDEV && \
-	    mkfs_cmd="$mkfs_cmd -J device=$SCRATCH_LOGDEV"
-
-	_scratch_do_mkfs "$mkfs_cmd" "$mkfs_filter" $* 2>$tmp.mkfserr 1>$tmp.mkfsstd
-	mkfs_status=$?
-
-	if [ $mkfs_status -eq 0 -a "$LARGE_SCRATCH_DEV" = yes ]; then
-		# manually parse the mkfs output to get the fs size in bytes
-		local fs_size=`cat $tmp.mkfsstd | awk ' \
-			/^Block size/ { split($2, a, "="); bs = a[2] ; } \
-			/ inodes, / { blks = $3 } \
-			/reserved for the super user/ { resv = $1 } \
-			END { fssize = bs * blks - resv; print fssize }'`
-
-		_setup_large_ext4_fs $fs_size
-		mkfs_status=$?
-	fi
-
-	# output mkfs stdout and stderr
-	cat $tmp.mkfsstd
-	cat $tmp.mkfserr >&2
-	rm -f $tmp.mkfserr $tmp.mkfsstd
-
-	return $mkfs_status
-}
-
-_ext4_metadump()
-{
-	local device="$1"
-	local dumpfile="$2"
-	local compressopt="$3"
-
-	test -n "$E2IMAGE_PROG" || _fail "e2image not installed"
-	$E2IMAGE_PROG -Q "$device" "$dumpfile"
-	[ "$compressopt" = "compress" ] && [ -n "$DUMP_COMPRESSOR" ] &&
-		$DUMP_COMPRESSOR -f "$dumpfile" &>> "$seqres.full"
-}
-
 # Capture the metadata of a filesystem in a dump file for offline analysis.
 # This is not supported by all filesystem types, so this function should only
 # be used after a test has already failed.
@@ -2245,33 +2138,6 @@ _require_non_zoned_device()
 	fi
 }
 
-# this test requires the ext4 kernel support crc feature on scratch device
-#
-_require_scratch_ext4_crc()
-{
-	_scratch_mkfs_ext4 >/dev/null 2>&1
-	dumpe2fs -h $SCRATCH_DEV 2> /dev/null | grep -q metadata_csum || _notrun "metadata_csum not supported by this filesystem"
-	_try_scratch_mount >/dev/null 2>&1 \
-	   || _notrun "Kernel doesn't support metadata_csum feature"
-	_scratch_unmount
-}
-
-# Check whether the specified feature whether it is supported by
-# mkfs.ext4 and the kernel.
-_require_scratch_ext4_feature()
-{
-    if [ -z "$1" ]; then
-        echo "Usage: _require_scratch_ext4_feature feature"
-        exit 1
-    fi
-    $MKFS_EXT4_PROG -F $MKFS_OPTIONS -O "$1" \
-		    $SCRATCH_DEV 512m >/dev/null 2>&1 \
-	|| _notrun "mkfs.ext4 doesn't support $1 feature"
-    _try_scratch_mount >/dev/null 2>&1 \
-	|| _notrun "Kernel doesn't support the ext4 feature(s): $1"
-    _scratch_unmount
-}
-
 # this test requires that external log/realtime devices are not in use
 #
 _require_nonexternal()
@@ -2894,16 +2760,6 @@ _require_fail_make_request()
  not found. Seems that CONFIG_FAULT_INJECTION_DEBUG_FS kernel config option not enabled"
 }
 
-# Disable extent zeroing for ext4 on the given device
-_ext4_disable_extent_zeroout()
-{
-	local dev=${1:-$TEST_DEV}
-	local sdev=`_short_dev $dev`
-
-	[ -f /sys/fs/ext4/$sdev/extent_max_zeroout_kb ] && \
-		echo 0 >/sys/fs/ext4/$sdev/extent_max_zeroout_kb
-}
-
 # The default behavior of SEEK_HOLE is to always return EOF.
 # Filesystems that implement non-default behavior return the offset
 # of holes with SEEK_HOLE. There is no way to query the filesystem
@@ -3001,15 +2857,6 @@ _require_scratch_richacl_xfs()
 	_scratch_unmount
 }
 
-_require_scratch_richacl_ext4()
-{
-	_scratch_mkfs -O richacl >/dev/null 2>&1 \
-		|| _notrun "can't mkfs $FSTYP with option -O richacl"
-	_try_scratch_mount >/dev/null 2>&1 \
-		|| _notrun "kernel doesn't support richacl feature on $FSTYP"
-	_scratch_unmount
-}
-
 _require_scratch_richacl_support()
 {
 	_scratch_mount

