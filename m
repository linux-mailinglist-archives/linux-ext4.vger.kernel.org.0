Return-Path: <linux-ext4+bounces-12259-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57BFCB2055
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39775300910E
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6606B311946;
	Wed, 10 Dec 2025 05:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GuwJWF7r"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F72D47F4;
	Wed, 10 Dec 2025 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345778; cv=none; b=UoAf+bqlqWgBInq7NkbaxoarTP5wUZfuOq/fsvU4Nr/5zo7nyR5YPaY7lJNQRsHgUezk1IIP0q56VGDHsequlHY3AXJFReUEHZK3CtE2OwNgFCwZqFqOZV+5m9Du8IjNVjWV+vtHVn6STo00CtcHelk4A3xDRpe2HTBla1zLQd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345778; c=relaxed/simple;
	bh=uqiRg/Znn+zirTlrkj3O/I8HwchCXpSmaLIsOMqw+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OwYmRWaZ47/Dwq4KjjJcrVez4p5dEBP5HO+n1UkmKWVIIgkmRyuFh9DDoomwkh/St3YMSK8wAg3tkO0MUOYrjhbnlbCKerVKPD5sutkyx4FVvYJZFBMK3r3888bGRkBDfHfIivKusGaRoxy+2vrhY4qn1dlCZ45OL4Cqzi2P1Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GuwJWF7r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=craJ3cKO6XjBzl2tIRYiAmh8w2EueEbhqNxAudlydms=; b=GuwJWF7rVlJ+QamIS/5JccP1NL
	/EuIigutJxAYnHZMvKH0FR1CqithvtYgJ0Vvcr8sXyVl/FSdIcXGoTHx4ePwjWwga3NKYHs3I1sDG
	BMUTNe7P/UMFbtnfUspFcwdPyBa5as3zZKl1urK/ugZ8ab3KxeHUMZgyCbQv4EtAPlzelR+PUnKcl
	yxpwi/ctIwBV48RbA3c1F4st39f59kTmjaGFMgu9uJa5EsXiQFyQRYSu4Mdj6jqyVafHiSXHd8aJW
	WfTBbEa0xVfWH6r+AmOesqRj8jsgxmicNtkA3+8Rv3yk3YnnRe+ltNYPQghCOBbxbDRquUW3pQY0Z
	DZQ/sQeA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4x-0000000F99x-32le;
	Wed, 10 Dec 2025 05:49:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 11/12] xfs/530: require a real SCRATCH_RTDEV
Date: Wed, 10 Dec 2025 06:46:57 +0100
Message-ID: <20251210054831.3469261-12-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251210054831.3469261-1-hch@lst.de>
References: <20251210054831.3469261-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Require a real SCRATCH_RTDEV instead of faking one up using a loop
device, as otherwise the options specified in MKFS_OPTIONS might
not actually work the configuration.

Note that specifying a rtextsize doesn't work for zoned file systems,
so _notrun when mkfs fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/530     | 42 +++++++++++++-----------------------------
 tests/xfs/530.out |  1 -
 2 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/tests/xfs/530 b/tests/xfs/530
index 4a41127e3b82..ffc9e902e1b7 100755
--- a/tests/xfs/530
+++ b/tests/xfs/530
@@ -10,36 +10,22 @@
 . ./common/preamble
 _begin_fstest auto quick realtime growfs
 
-# Override the default cleanup function.
-_cleanup()
-{
-	cd /
-	_scratch_unmount >> $seqres.full 2>&1
-	[ -n "$rt_loop_dev" ] && _destroy_loop_device $rt_loop_dev
-	rm -f $tmp.* $TEST_DIR/$seq.rtvol
-}
-
-# Import common functions.
 . ./common/filter
 . ./common/inject
 . ./common/populate
 
-
-# Note that we don't _require_realtime because we synthesize a rt volume
-# below.
-_require_test
+_require_scratch
+_require_realtime
 _require_xfs_debug
 _require_test_program "punch-alternating"
 _require_xfs_io_error_injection "reduce_max_iextents"
 _require_xfs_io_error_injection "bmap_alloc_minlen_extent"
-_require_scratch_nocheck
 
 echo "* Test extending rt inodes"
 
 _scratch_mkfs | _filter_mkfs >> $seqres.full 2> $tmp.mkfs
 . $tmp.mkfs
 
-echo "Create fake rt volume"
 nr_bitmap_blks=25
 nr_bits=$((nr_bitmap_blks * dbsize * 8))
 
@@ -50,17 +36,12 @@ else
 	rtextsz=$dbsize
 fi
 
-rtdevsz=$((nr_bits * rtextsz))
-truncate -s $rtdevsz $TEST_DIR/$seq.rtvol
-rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
-
 echo "Format and mount rt volume"
-
-export USE_EXTERNAL=yes
-export SCRATCH_RTDEV=$rt_loop_dev
-_scratch_mkfs -d size=$((1024 * 1024 * 1024)) \
-	      -r size=${rtextsz},extsize=${rtextsz} >> $seqres.full
-_try_scratch_mount || _notrun "Couldn't mount fs with synthetic rt volume"
+_try_scratch_mkfs_xfs \
+	-d size=$((1024 * 1024 * 1024)) \
+	-r size=${rtextsz},extsize=${rtextsz} >> $seqres.full 2>&1 || \
+	_notrun "Couldn't created crafted fs (zoned?)"
+_try_scratch_mount || _notrun "Couldn't mount crafted fs"
 
 # If we didn't get the desired realtime volume and the same blocksize as the
 # first format (which we used to compute a specific rt geometry), skip the
@@ -92,7 +73,12 @@ echo "Inject bmap_alloc_minlen_extent error tag"
 _scratch_inject_error bmap_alloc_minlen_extent 1
 
 echo "Grow realtime volume"
-$XFS_GROWFS_PROG -r $SCRATCH_MNT >> $seqres.full 2>&1
+# growfs expects sizes in FSB units
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+rtdevsz=$((nr_bits * rtextsz))
+
+$XFS_GROWFS_PROG -R $((rtdevsize / fsbsize)) $SCRATCH_MNT \
+	>> $seqres.full 2>&1
 if [[ $? == 0 ]]; then
 	echo "Growfs succeeded; should have failed."
 	exit 1
@@ -115,8 +101,6 @@ echo "Check filesystem"
 _check_scratch_fs
 
 _scratch_unmount &> /dev/null
-_destroy_loop_device $rt_loop_dev
-unset rt_loop_dev
 
 # success, all done
 status=0
diff --git a/tests/xfs/530.out b/tests/xfs/530.out
index 6ddb572f9435..3c508b4564f7 100644
--- a/tests/xfs/530.out
+++ b/tests/xfs/530.out
@@ -1,6 +1,5 @@
 QA output created by 530
 * Test extending rt inodes
-Create fake rt volume
 Format and mount rt volume
 Consume free space
 Create fragmented filesystem
-- 
2.47.3


