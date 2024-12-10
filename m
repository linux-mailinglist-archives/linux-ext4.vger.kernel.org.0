Return-Path: <linux-ext4+bounces-5534-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC3E9EA930
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 07:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A082318891A3
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2024 06:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8276F22B8D9;
	Tue, 10 Dec 2024 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ce0SxAHM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A112422CBD7;
	Tue, 10 Dec 2024 06:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733813957; cv=none; b=bqhVUYUFFeCCRx7X7rWka2HMt904m6RZcPoKSm7TnizfNeIHyAV6Pcb+LTSmZoS5OXg4l2wSotejAjp++M9aKv6oh3XmL9pEAl4vqhSmNsDp+5JuMLy5zbm5YMX3aYm1qjnP3P15Ee3LBdgU9VutfQz9SQsUY/GQko9pnVZTTdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733813957; c=relaxed/simple;
	bh=3U1+1mcgLRusWA3OhSpalZGNFUoBRHRWCNuX8D0HCv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVJn9xvpKkTgFCMbH+F9RQJj9iJEtSUgPR41xAarecHRdiMTywFYc8l3PRq5nWrQVtDHFtMNzDftxKIAUdOWqRdIUDm3WfrzpznbpeqmmeqZg90mSWdC8yADV/xPN/n/5XWiVgNgjqc/05OlmpgGijjLrYnsdCG1LF5OifIZrHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ce0SxAHM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1ru4Ka/4wfXoXb85GeJUZZs+ZdGGzoJYsPSj+tCHEB0=; b=Ce0SxAHM3OUIe7mTlkhFwA6+mJ
	9ozaHlXYBVRsd8OL67a+MNJqx9VGmrmv6TydQ6gqHVRAAS/xqOs7CN4iGCAwkt8pFlQ1zwhB9DJIR
	Gru5AjKTmgT03hZlu52EtYsdWaPb7YyBfphxF3kd9qmdX7X40D3/cHx7YLkUnwBdJb1e85M/UdNUO
	eHSTEknJJDeOyt8v3nRq+ocTzF80UxVA3tI/HpzXj0PdJkqn/otJzpoeg2VjbPyGhGWRJmzvMYY20
	+pmLkCavuT/vbx3qaiVUWpnnUYKFlxNfr9u29Vr+kFePAwv317pUI2EmGLJ9cJFaP4pBaSPskvY+m
	d+Prl0bw==;
Received: from 2a02-8389-2341-5b80-e2a6-542f-4e27-82ec.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e2a6:542f:4e27:82ec] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tKuDC-0000000AUes-478o;
	Tue, 10 Dec 2024 06:59:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/4] replace _supported_fs with _exclude_fs
Date: Tue, 10 Dec 2024 07:58:28 +0100
Message-ID: <20241210065900.1235379-5-hch@lst.de>
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

Tests don't require a list of supported file systems, as that is deducted
from the test directory name.  Instead we exclude specific file systems
from a few common tests, and pick the extN variants supported for the
ext4 directory.

Replace _supported_fs with a new _exclude_fs that takes only a single
file systems as the argument, making it easier to explain why the file
system is not supported.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/rc            | 30 ++++++++----------------------
 tests/ext-common/002 |  2 +-
 tests/ext-common/036 |  3 ++-
 tests/ext-common/037 |  2 +-
 tests/ext-common/038 |  3 +--
 tests/ext-common/039 |  3 ++-
 tests/ext-common/043 |  2 +-
 tests/generic/187    |  8 +++++---
 tests/generic/294    |  2 +-
 tests/generic/357    |  2 +-
 tests/generic/362    |  3 ++-
 tests/generic/465    |  2 +-
 tests/generic/500    |  2 +-
 tests/generic/631    |  4 +++-
 tests/generic/679    |  2 +-
 tests/generic/699    |  3 ++-
 tests/generic/732    |  4 +++-
 tests/generic/740    |  7 ++++++-
 18 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/common/rc b/common/rc
index 796d98e5cada..5ef5038a6d23 100644
--- a/common/rc
+++ b/common/rc
@@ -1766,30 +1766,16 @@ _fail()
     exit 1
 }
 
-# tests whether $FSTYP is one of the supported filesystems for a test
 #
-_check_supported_fs()
-{
-	local res=1
-	local f
-
-	for f; do
-		# ^FS means black listed fs
-		if [ "$f" = "^$FSTYP" ]; then
-			return 1
-		elif [ "$f" = "generic" ] || [[ "$f" == "^"* ]]; then
-			# ^FS implies "generic ^FS"
-			res=0
-		elif [ "$f" = "$FSTYP" ]; then
-			return 0
-		fi
-	done
-	return $res
-}
-
-_supported_fs()
+# Tests whether $FSTYP should be exclude from this test.
+#
+# In general this should be avoided in favor of feature tests, and when this
+# helper has to be used, it should include a comment on why a specific file
+# system is excluded.
+#
+_exclude_fs()
 {
-	_check_supported_fs $* || \
+	[ "$1" = "$FSTYP" ] && \
 		_notrun "not suitable for this filesystem type: $FSTYP"
 }
 
diff --git a/tests/ext-common/002 b/tests/ext-common/002
index 7b3d5918bde9..6c1e1d926973 100755
--- a/tests/ext-common/002
+++ b/tests/ext-common/002
@@ -29,7 +29,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ^ext2
+_exclude_fs ext2
 
 _require_scratch_nocheck
 _require_scratch_shutdown
diff --git a/tests/ext-common/036 b/tests/ext-common/036
index 729d842df6e7..4a1471fd4cb5 100755
--- a/tests/ext-common/036
+++ b/tests/ext-common/036
@@ -15,7 +15,8 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ^ext2
+_exclude_fs ext2
+
 _require_scratch
 
 echo "Silence is golden"
diff --git a/tests/ext-common/037 b/tests/ext-common/037
index 3f2232f0de60..dea02a79927a 100755
--- a/tests/ext-common/037
+++ b/tests/ext-common/037
@@ -15,7 +15,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ^ext2
+_exclude_fs ext2
 
 # nofsck as we modify sb via debugfs
 _require_scratch_nocheck
diff --git a/tests/ext-common/038 b/tests/ext-common/038
index 09d3b10bdcf2..07b090b11f13 100755
--- a/tests/ext-common/038
+++ b/tests/ext-common/038
@@ -10,9 +10,8 @@
 . ./common/preamble
 _begin_fstest auto quick
 
-# Import common functions.
+_exclude_fs ext2
 
-_supported_fs ^ext2
 _require_scratch
 _require_command "$DEBUGFS_PROG" debugfs
 
diff --git a/tests/ext-common/039 b/tests/ext-common/039
index be766668df60..2e99c8ff9ffd 100755
--- a/tests/ext-common/039
+++ b/tests/ext-common/039
@@ -56,7 +56,8 @@ chattr_opt: $chattr_opt" >>$seqres.full
 	done
 }
 
-_supported_fs ^ext2
+_exclude_fs ext2
+
 _require_scratch
 _exclude_scratch_mount_option dax
 
diff --git a/tests/ext-common/043 b/tests/ext-common/043
index cf0bef4e7407..8d124ba36f72 100755
--- a/tests/ext-common/043
+++ b/tests/ext-common/043
@@ -12,7 +12,7 @@ _begin_fstest auto quick
 # Import common functions.
 . ./common/filter
 
-_supported_fs ^ext2
+_exclude_fs ext2
 
 _require_scratch
 _require_test_program "t_get_file_time"
diff --git a/tests/generic/187 b/tests/generic/187
index 2a06aff35e58..536ce9fa9ab8 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -28,10 +28,12 @@ _cleanup()
 . ./common/filter
 . ./common/reflink
 
+# btrfs can't fragment free space.
+_exclude_fs btrfs
+
+# This test is unreliable on NFS, as it depends on the exported filesystem.
+_exclude_fs nfs
 
-# btrfs can't fragment free space. This test is unreliable on NFS, as it
-# depends on the exported filesystem.
-_supported_fs ^btrfs ^nfs
 _require_scratch_reflink
 _require_cp_reflink
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/294 b/tests/generic/294
index 54b89a26294f..b07459116371 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -16,7 +16,7 @@ _begin_fstest auto quick
 
 # NFS will optimize away the on-the-wire lookup before attempting to
 # create a new file (since that means an extra round trip).
-_supported_fs ^nfs
+_exclude_fs nfs
 
 _require_scratch
 _require_symlinks
diff --git a/tests/generic/357 b/tests/generic/357
index 8db31f8b0432..51c6d5efd2d7 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -26,7 +26,7 @@ _cleanup()
 
 # For NFS, a reflink is just a CLONE operation, and after that
 # point it's dealt with by the server.
-_supported_fs ^nfs
+_exclude_fs nfs
 
 _require_scratch_swapfile
 _require_scratch_reflink
diff --git a/tests/generic/362 b/tests/generic/362
index 2396ec7d3a57..3a1993e81d4b 100755
--- a/tests/generic/362
+++ b/tests/generic/362
@@ -11,7 +11,8 @@
 _begin_fstest auto quick
 
 # NFS forbade open with O_APPEND|O_DIRECT
-_supported_fs ^nfs
+_exclude_fs nfs
+
 _require_test
 _require_odirect
 _require_test_program dio-append-buf-fault
diff --git a/tests/generic/465 b/tests/generic/465
index f8c4ea9671a2..5b49040e3ad0 100755
--- a/tests/generic/465
+++ b/tests/generic/465
@@ -20,7 +20,7 @@ _cleanup()
 # Import common functions.
 . ./common/filter
 
-_supported_fs ^nfs
+_exclude_fs nfs
 
 _require_aiodio aio-dio-append-write-read-race
 _require_test_program "feature"
diff --git a/tests/generic/500 b/tests/generic/500
index ba6e902ec96b..c5492a09246c 100755
--- a/tests/generic/500
+++ b/tests/generic/500
@@ -41,7 +41,7 @@ _require_dm_target thin-pool
 # and since we've filled the thinp device it'll return EIO, which will make
 # btrfs flip read only, making it fail this test when it just won't work right
 # for us in the first place.
-_supported_fs ^btrfs
+_exclude_fs btrfs
 
 # Require underlying device support discard
 _scratch_mkfs >>$seqres.full 2>&1
diff --git a/tests/generic/631 b/tests/generic/631
index 642d47863987..8e2cf9c63b77 100755
--- a/tests/generic/631
+++ b/tests/generic/631
@@ -37,8 +37,10 @@ _cleanup()
 
 _require_scratch
 _require_attrs trusted
-_supported_fs ^overlay
+
+_exclude_fs overlay
 _require_extra_fs overlay
+
 _fixed_by_kernel_commit 6da1b4b1ab36 \
 	"xfs: fix an ABBA deadlock in xfs_rename"
 
diff --git a/tests/generic/679 b/tests/generic/679
index 4c74101c5834..741ddf21502f 100755
--- a/tests/generic/679
+++ b/tests/generic/679
@@ -23,7 +23,7 @@ _require_xfs_io_command "fiemap"
 #
 #   https://lore.kernel.org/linux-btrfs/20220315164011.GF8241@magnolia/
 #
-_supported_fs ^xfs
+_exclude_fs xfs
 
 rm -f $seqres.full
 
diff --git a/tests/generic/699 b/tests/generic/699
index 3079a861df74..620a40aa3921 100755
--- a/tests/generic/699
+++ b/tests/generic/699
@@ -21,8 +21,9 @@ _cleanup()
 	rm -r -f $tmp.*
 }
 
-_supported_fs ^overlay
+_exclude_fs overlay
 _require_extra_fs overlay
+
 _require_scratch
 _require_chown
 _require_idmapped_mounts
diff --git a/tests/generic/732 b/tests/generic/732
index e907a009fe16..83caa0bc915c 100755
--- a/tests/generic/732
+++ b/tests/generic/732
@@ -24,7 +24,9 @@ _cleanup()
 # This case give a assumption that the same mount options for
 # different mount point will share the same superblock, which won't
 # sucess for the follow fs.
-_supported_fs ^nfs ^overlay ^tmpfs
+_exclude_fs nfs
+_exclude_fs overlay
+_exclude_fs tmpfs
 
 _require_test
 _require_scratch
diff --git a/tests/generic/740 b/tests/generic/740
index 903e891db0fd..10817521cc93 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -14,7 +14,12 @@ _begin_fstest mkfs auto quick
 
 # a bunch of file systems don't support foreign fs detection
 # ext* do support it, but disable the feature when called non-interactively
-_supported_fs ^ext2 ^ext3 ^ext4 ^jfs ^ocfs2 ^udf
+_exclude_fs ext2
+_exclude_fs ext3
+_exclude_fs ext4
+_exclude_fs jfs
+_exclude_fs ocfs2
+_exclude_fs udf
 
 _require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
-- 
2.45.2


