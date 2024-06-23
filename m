Return-Path: <linux-ext4+bounces-2920-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BEA913A67
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C53BB20A57
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3027C18130A;
	Sun, 23 Jun 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HyczKEbx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD4D180A90;
	Sun, 23 Jun 2024 12:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144674; cv=none; b=UPSvZgBwEi263V2tp4LD2JRqSYwiwmYiyUnehwIhqeuOP7/dpT1wuO8NysodzowH8pA8t1H5A0hFs++QebBr4WBmobIFZ8tQxwiWZzC5eDASCfMFIb7mY8DmSyKcRNgkw55p9VEGFcY37TVDcxQY2e1htrBU0Y9jhxsf8vrpREA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144674; c=relaxed/simple;
	bh=0heEtFkpLZfHEOeVyMevmqMfHtw+rEEpdGYxVT1JqqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nsDHtmx5TLgALIuQhz23+xaLFhRHWcvNmcgqim8uWjfS6vCasMkc/+zFC6Gqk8Cmt47TQ07CmCVxTWQ5b25S/Honac3N2LnsoBgHR2b4/RoMJSnUfRyEZPqW1x8QqWyb+PPWvREyvSkf54Eh5ItpXejo7cUcWg0QVZWPgyfWjMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HyczKEbx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=aIa/QCgZ4g8a6ia3YqWt2m8fJyod81OrtMO+VxY6FZA=; b=HyczKEbxzTlL7nuUx+hmZf9VJv
	Z+Ne+g8r0fXYFG6PzEIUDNCpt6howeaMIKLg83+3W7EhHjVSw2vrEdz5HPrVBkx57CyUAMm5tKMnV
	Pu9t854AbGcaZXXtbXKNNrqEE+WWQvZwHai6zmoP3HcdozTkiufVyv7pbfKePUF3F7U9/P64fw5m8
	ACgQHXtVKrGvCHM/c6M4H6ErM3Cdd0kdQq08HrhXlpNURr2D12M3PCJPJG8FN6V1b45eB/PI1aLFE
	GL9BAWNiWZKXvBmBt30JupT5onZY06PZFTv+fIvg8uFA5RK6veRIMc8tmaCW30g7OWN8srIsdpkV9
	JpNej5nA==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM3q-0000000DwxH-0Uj5;
	Sun, 23 Jun 2024 12:11:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 1/8] remove support for ext4dev
Date: Sun, 23 Jun 2024 14:10:30 +0200
Message-ID: <20240623121103.974270-2-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

ext4dev is a long deprecated alias for ext4 that was used during early
ext4 development.  Drop support for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 common/config     | 6 +++---
 common/defrag     | 2 +-
 common/quota      | 4 ++--
 common/rc         | 8 ++++----
 tests/generic/740 | 1 -
 5 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/common/config b/common/config
index a1cd14de6..22740c0af 100644
--- a/common/config
+++ b/common/config
@@ -361,7 +361,7 @@ _common_mount_opts()
 	overlay)
 		echo $OVERLAY_MOUNT_OPTIONS
 		;;
-	ext2|ext3|ext4|ext4dev)
+	ext2|ext3|ext4)
 		# acls & xattrs aren't turned on by default on ext$FOO
 		echo "-o acl,user_xattr $EXT_MOUNT_OPTIONS"
 		;;
@@ -454,7 +454,7 @@ _mkfs_opts()
 _fsck_opts()
 {
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev)
+	ext2|ext3|ext4)
 		export FSCK_OPTIONS="-nf"
 		;;
 	reiser*)
@@ -500,7 +500,7 @@ _source_specific_fs()
 		[ "$MKFS_EXT4_PROG" = "" ] && _fatal "mkfs.ext4 not found"
 		. ./common/ext4
 		;;
-	ext2|ext3|ext4dev)
+	ext2|ext3)
 		. ./common/ext4
 		;;
 	f2fs)
diff --git a/common/defrag b/common/defrag
index 1381a4dd3..055d0d0e9 100644
--- a/common/defrag
+++ b/common/defrag
@@ -12,7 +12,7 @@ _require_defrag()
         _require_xfs_io_command "falloc"
         DEFRAG_PROG="$XFS_FSR_PROG"
 	;;
-    ext4|ext4dev)
+    ext4)
 	testfile="$TEST_DIR/$$-test.defrag"
 	donorfile="$TEST_DIR/$$-donor.defrag"
 	bsize=`_get_block_size $TEST_DIR`
diff --git a/common/quota b/common/quota
index 4c1d3dcd7..3bf7d552e 100644
--- a/common/quota
+++ b/common/quota
@@ -12,7 +12,7 @@ _require_quota()
     [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
-    ext2|ext3|ext4|ext4dev|f2fs|reiserfs)
+    ext2|ext3|ext4|f2fs|reiserfs)
 	if [ ! -d /proc/sys/fs/quota ]; then
 	    _notrun "Installed kernel does not support quotas"
 	fi
@@ -344,7 +344,7 @@ _check_quota_usage()
 
 	VFS_QUOTA=0
 	case $FSTYP in
-	ext2|ext3|ext4|ext4dev|f2fs|reiserfs|gfs2|bcachefs)
+	ext2|ext3|ext4|f2fs|reiserfs|gfs2|bcachefs)
 		VFS_QUOTA=1
 		quotaon -f -u -g $SCRATCH_MNT 2>/dev/null
 		;;
diff --git a/common/rc b/common/rc
index 7100373cb..afc33bbc2 100644
--- a/common/rc
+++ b/common/rc
@@ -240,7 +240,7 @@ _scratch_options()
     "xfs")
 	_scratch_xfs_options "$@"
 	;;
-    ext2|ext3|ext4|ext4dev)
+    ext2|ext3|ext4)
 	_scratch_ext4_options "$@"
 	;;
     esac
@@ -1038,7 +1038,7 @@ _try_scratch_mkfs_sized()
 	btrfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-s ?+([0-9]+).*/\1/p'`
 		;;
-	ext2|ext3|ext4|ext4dev|reiser4|ocfs2|reiserfs)
+	ext2|ext3|ext4|reiser4|ocfs2|reiserfs)
 		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*-b ?+([0-9]+).*/\1/p'`
 		;;
 	udf)
@@ -1095,7 +1095,7 @@ _try_scratch_mkfs_sized()
 			_scratch_mkfs_xfs -d size=$fssize $rt_ops -b size=$blocksize
 		fi
 		;;
-	ext2|ext3|ext4|ext4dev)
+	ext2|ext3|ext4)
 		# Can't use _scratch_mkfs_ext4 here because the block count has
 		# to come after the device path.
 		if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ]; then
@@ -1199,7 +1199,7 @@ _scratch_mkfs_geom()
 		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
 	fi
 	;;
-    ext4|ext4dev)
+    ext4)
 	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
 	;;
     *)
diff --git a/tests/generic/740 b/tests/generic/740
index 6ed248617..3deba86b3 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -48,7 +48,6 @@ do
 	[ $fs = ext2 ] && preargs="-F"
 	[ $fs = ext3 ] && preargs="-F"
 	[ $fs = ext4 ] && preargs="-F"
-	[ $fs = ext4dev ] && preargs="-F"
 	# jffs2 mkfs requires '-r $directory' and '-o $image'
 	[ $fs = jffs2 ] && preargs="-r /proc/fs -o"
 
-- 
2.43.0


