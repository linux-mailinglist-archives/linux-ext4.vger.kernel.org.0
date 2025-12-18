Return-Path: <linux-ext4+bounces-12429-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF549CCAA84
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEEA9301DE19
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F412DAFC7;
	Thu, 18 Dec 2025 07:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lpGCLWHV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8F12DC781;
	Thu, 18 Dec 2025 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043064; cv=none; b=Y5Y4s0VX+Cx4Exd48y4K82Ma7gG47Wdx32icOQKViJt/NltHUNssoqm6zsAK8oEkGVsdzqfIFcDWzQEVBNWeQEPnVQC47C6rMqE/e0ywpuFYfgogkW4Uv/qERCyjFtUFHgDU8kVH4NT30FfFQPWM4wVTltT6FUBy+yG0IE87NIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043064; c=relaxed/simple;
	bh=BzpEFegcC/ozfwE/J+Pkyt6HcmVsVXz9sgFuMA2fcps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0Tosp1iiTEe+kSIGE5etUgX5OXes2v29WL69l3eogebl3cQe+euk41S2KGIZOR4MS7i9TkRzjfHVtWUCQIJH/jAs1LHtco+Xj5AsbEQc7ShTqUIKQKX19g2JJlF8kuQZFvD/IyF6WrIrPB/3QxC7gjq3mohl1d2OWdgNPsIUnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lpGCLWHV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/jmkI/E190OCLkOlWHRC8ASYY+a8P/aZ00jedADxIHA=; b=lpGCLWHV/Rx8G51pWZVAtlkUTl
	+xWTecrc9zDamAe417SAdKk/lVrE9e3HypdPDIHQ4F1ymWq1gWMP9pZ9VnF21MRBr26pVFXhNsQYG
	k++VMjFX/BQnJQXO3VfWkWdpHtivqmImEYTR3VVUOP+7z+Qr7ajdmWrPECbnayzjB/IaiYE5Smdc+
	eSQHpidR+uy46voG4Fy4KbOjjWAaZVm3JSLT185v6Ob3HeYB4QfSJ1gKlRmQBLi3sxFnd89X1lG3F
	Mx5lrUhdltJCYpzUNXtRm4XCPBD/TqQFcu53hb05WxyGKpTedqFNJBZsG/bYAD06SKKfG0LPr7kWQ
	vgrM789A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8TV-00000007xb6-0uan;
	Thu, 18 Dec 2025 07:31:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 09/13] xfs/521: require a real SCRATCH_RTDEV
Date: Thu, 18 Dec 2025 08:30:07 +0100
Message-ID: <20251218073023.1547648-10-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218073023.1547648-1-hch@lst.de>
References: <20251218073023.1547648-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/521     | 33 ++++++++-------------------------
 tests/xfs/521.out |  1 -
 2 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/tests/xfs/521 b/tests/xfs/521
index 0da05a55a276..5cd6649c50c7 100755
--- a/tests/xfs/521
+++ b/tests/xfs/521
@@ -16,34 +16,16 @@
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
 
-# Note that we don't _require_realtime because we synthesize a rt volume
-# below.
-_require_scratch_nocheck
-_require_no_large_scratch_dev
-
-echo "Create fake rt volume"
-truncate -s 400m $TEST_DIR/$seq.rtvol
-rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
+_require_realtime
+_require_scratch
 
 echo "Format and mount 100m rt volume"
-export USE_EXTERNAL=yes
-export SCRATCH_RTDEV=$rtdev
 _scratch_mkfs -r size=100m > $seqres.full
-_try_scratch_mount || _notrun "Could not mount scratch with synthetic rt volume"
+_scratch_mount
 
-# zoned file systems only support zoned size-rounded RT device sizes
+# zoned file systems only support zone-size aligned RT device sizes
 _require_xfs_scratch_non_zoned
 
 testdir=$SCRATCH_MNT/test-$seq
@@ -58,7 +40,10 @@ echo "Create some files"
 _pwrite_byte 0x61 0 1m $testdir/original >> $seqres.full
 
 echo "Grow fs"
-$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
+# growfs expects sizes in FSB units
+fsbsize=$(_get_block_size $SCRATCH_MNT)
+$XFS_GROWFS_PROG -R $((400 * 1024 * 1024 / fsbsize)) $SCRATCH_MNT 2>&1 | \
+	  _filter_growfs >> $seqres.full
 _scratch_cycle_mount
 
 echo "Recheck 400m rt volume stats"
@@ -73,8 +58,6 @@ echo "Check filesystem"
 _check_scratch_fs
 
 _scratch_unmount
-_destroy_loop_device $rt_loop_dev
-unset rt_loop_dev
 
 # success, all done
 status=0
diff --git a/tests/xfs/521.out b/tests/xfs/521.out
index 007ab92c6db2..afd18bb0dc99 100644
--- a/tests/xfs/521.out
+++ b/tests/xfs/521.out
@@ -1,5 +1,4 @@
 QA output created by 521
-Create fake rt volume
 Format and mount 100m rt volume
 Check rt volume stats
 Create some files
-- 
2.47.3


