Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8815A4DCBB
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFTVik (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:47154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFTVij (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Jun 2019 17:38:39 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F1302085A;
        Thu, 20 Jun 2019 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561066717;
        bh=HeWLaZx8vNDd7SwrPn4f5AIlPq+mBHnG456nIkYnQjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rfIKpazNDw1bB4C0/XZpZm2Dww4Ln3wetmFc7WOjsnOQ1Sq6/yvmvnVxmNPqBtTJD
         xmP+5sfHRul6vItjTbM4Kl5tXBl997Ahf/M1u//ASjVYxdgU6N7dkNeV5LB2I1Sjhi
         q31wKs8W1kkDNx3SwhIpdTpis6qnIJqwMrzKKZL8=
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>
Subject: [RFC PATCH v2 2/8] common/verity: add common functions for testing fs-verity
Date:   Thu, 20 Jun 2019 14:36:08 -0700
Message-Id: <20190620213614.113685-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190620213614.113685-1-ebiggers@kernel.org>
References: <20190620213614.113685-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add common functions for setting up and testing fs-verity, a new feature
for read-only file-based authenticity protection.  fs-verity will be
supported by ext4 and f2fs, and perhaps by other filesystems later.
Running the fs-verity tests requires:

- A kernel with the fs-verity patches from
  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
  branch "fsverity" and configured with CONFIG_FS_VERITY.
- The fsverity utility program from
  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
- e2fsprogs v1.45.2 or later for ext4 tests, or f2fs-tools v1.11.0 or
  later for f2fs tests.

See the file Documentation/filesystems/fsverity.rst in the kernel tree
for more information about fs-verity.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config |   1 +
 common/verity | 189 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 190 insertions(+)
 create mode 100644 common/verity

diff --git a/common/config b/common/config
index bd64be62..001ddc45 100644
--- a/common/config
+++ b/common/config
@@ -212,6 +212,7 @@ export CHECKBASHISMS_PROG="$(type -P checkbashisms)"
 export XFS_INFO_PROG="$(type -P xfs_info)"
 export DUPEREMOVE_PROG="$(type -P duperemove)"
 export CC_PROG="$(type -P cc)"
+export FSVERITY_PROG="$(type -P fsverity)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/verity b/common/verity
new file mode 100644
index 00000000..86fb6585
--- /dev/null
+++ b/common/verity
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2018 Google LLC
+#
+# Functions for setting up and testing fs-verity
+
+_require_scratch_verity()
+{
+	_require_scratch
+	_require_command "$FSVERITY_PROG" fsverity
+
+	if ! _scratch_mkfs_verity &>>$seqres.full; then
+		# ext4: need e2fsprogs v1.44.5 or later (but actually v1.45.2+
+		#       is needed for some tests to pass, due to an e2fsck bug)
+		# f2fs: need f2fs-tools v1.11.0 or later
+		_notrun "$FSTYP userspace tools don't support fs-verity"
+	fi
+
+	# Try to mount the filesystem.  If this fails then either the kernel
+	# isn't aware of fs-verity, or the mkfs options were not compatible with
+	# verity (e.g. ext4 with block size != PAGE_SIZE).
+	if ! _try_scratch_mount &>>$seqres.full; then
+		_notrun "kernel is unaware of $FSTYP verity feature," \
+			"or mkfs options are not compatible with verity"
+	fi
+	_scratch_unmount
+
+	# The filesystem may be aware of fs-verity but have it disabled by
+	# CONFIG_FS_VERITY=n.  Detect support via sysfs.
+	if [ ! -e /sys/fs/$FSTYP/features/verity ]; then
+		_notrun "kernel $FSTYP isn't configured with verity support"
+	fi
+
+	# Merkle tree block size.  Currently all filesystems only support
+	# PAGE_SIZE for this.  This is also the default for 'fsverity enable'.
+	FSV_BLOCK_SIZE=$(get_page_size)
+}
+
+_scratch_mkfs_verity()
+{
+	case $FSTYP in
+	ext4|f2fs)
+		_scratch_mkfs -O verity
+		;;
+	*)
+		_notrun "No verity support for $FSTYP"
+		;;
+	esac
+}
+
+_scratch_mkfs_encrypted_verity()
+{
+	case $FSTYP in
+	ext4)
+		_scratch_mkfs -O encrypt,verity
+		;;
+	f2fs)
+		# f2fs-tools as of v1.11.0 doesn't allow comma-separated
+		# features with -O.  Instead -O must be supplied multiple times.
+		_scratch_mkfs -O encrypt -O verity
+		;;
+	*)
+		_notrun "$FSTYP not supported in _scratch_mkfs_encrypted_verity"
+		;;
+	esac
+}
+
+_fsv_scratch_begin_subtest()
+{
+	local msg=$1
+
+	rm -rf "${SCRATCH_MNT:?}"/*
+	echo -e "\n# $msg"
+}
+
+_fsv_enable()
+{
+	$FSVERITY_PROG enable "$@"
+}
+
+_fsv_measure()
+{
+        $FSVERITY_PROG measure "$@" | awk '{print $1}'
+}
+
+# Generate a file, then enable verity on it.
+_fsv_create_enable_file()
+{
+	local file=$1
+	shift
+
+	head -c $((FSV_BLOCK_SIZE * 2)) /dev/zero > "$file"
+	_fsv_enable "$file" "$@"
+}
+
+_fsv_have_hash_algorithm()
+{
+	local hash_alg=$1
+	local test_file=$2
+
+	rm -f $test_file
+	head -c 4096 /dev/zero > $test_file
+	if ! _fsv_enable --hash-alg=$hash_alg $test_file &>> $seqres.full; then
+		# no kernel support
+		return 1
+	fi
+	rm -f $test_file
+	return 0
+}
+
+#
+# _fsv_scratch_corrupt_bytes - Write some bytes to a file, bypassing the filesystem
+#
+# Write the bytes sent on stdin to the given offset in the given file, but do so
+# by writing directly to the extents on the block device, with the filesystem
+# unmounted.  This can be used to corrupt a verity file for testing purposes,
+# bypassing the restrictions imposed by the filesystem.
+#
+# The file is assumed to be located on $SCRATCH_DEV.
+#
+_fsv_scratch_corrupt_bytes()
+{
+	local file=$1
+	local offset=$2
+	local lstart lend pstart pend
+	local dd_cmds=()
+	local cmd
+
+	sync	# Sync to avoid unwritten extents
+
+	cat > $tmp.bytes
+	local end=$(( offset + $(stat -c %s $tmp.bytes ) ))
+
+	# For each extent that intersects the requested range in order, add a
+	# command that writes the next part of the data to that extent.
+	while read -r lstart lend pstart pend; do
+		lstart=$((lstart * 512))
+		lend=$(((lend + 1) * 512))
+		pstart=$((pstart * 512))
+		pend=$(((pend + 1) * 512))
+
+		if (( lend - lstart != pend - pstart )); then
+			_fail "Logical and physical extent lengths differ for file '$file'"
+		elif (( offset < lstart )); then
+			_fail "Hole in file '$file' at byte $offset.  Next extent begins at byte $lstart"
+		elif (( offset < lend )); then
+			local len=$((lend - offset))
+			local seek=$((pstart + (offset - lstart)))
+			dd_cmds+=("head -c $len | dd of=$SCRATCH_DEV oflag=seek_bytes seek=$seek status=none")
+			(( offset += len ))
+		fi
+	done < <($XFS_IO_PROG -r -c "fiemap $offset $((end - offset))" "$file" \
+		 | _filter_xfs_io_fiemap)
+
+	if (( offset < end )); then
+		_fail "Extents of file '$file' ended at byte $offset, but needed until $end"
+	fi
+
+	# Execute the commands to write the data
+	_scratch_unmount
+	for cmd in "${dd_cmds[@]}"; do
+		eval "$cmd"
+	done < $tmp.bytes
+	sync	# Sync to flush the block device's pagecache
+	_scratch_mount
+}
+
+#
+# _fsv_scratch_corrupt_merkle_tree - Corrupt a file's Merkle tree
+#
+# Like _fsv_scratch_corrupt_bytes(), but this corrupts the file's fs-verity
+# Merkle tree.  The offset is given as a byte offset into the Merkle tree.
+#
+_fsv_scratch_corrupt_merkle_tree()
+{
+	local file=$1
+	local offset=$2
+
+	case $FSTYP in
+	ext4|f2fs)
+		# ext4 and f2fs store the Merkle tree after the file contents
+		# itself, starting at the next 65536-byte aligned boundary.
+		(( offset += ($(stat -c %s $file) + 65535) & ~65535 ))
+		_fsv_scratch_corrupt_bytes $file $offset
+		;;
+	*)
+		_fail "_fsv_scratch_corrupt_merkle_tree() unimplemented on $FSTYP"
+		;;
+	esac
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

