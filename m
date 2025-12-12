Return-Path: <linux-ext4+bounces-12328-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44458CB8429
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A0783095266
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3736330FC2A;
	Fri, 12 Dec 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWPyz6mO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310730F800;
	Fri, 12 Dec 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527799; cv=none; b=HWka7qpA07sS8lpHqq9dJgKGhj043yDuGNtJlr6AzPGFYO8xUnpX9ti011QMAhzjgQKgUuninrDSKaQMucedawrxuujAKYi31DDBnUBCml8avNkAhyRc5xupNAxCkpgc/yrIhOoB3/6kwBKyuTDfXMWJhLggRXZOhVjp4pDa00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527799; c=relaxed/simple;
	bh=uqiRg/Znn+zirTlrkj3O/I8HwchCXpSmaLIsOMqw+7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TubDYdOHzY3SWYLo5ozZEtv99v/ySiW3xxFJqjPUqoRkKrJf+4VV4K0dwTkN3qPJtlxTV77nRygquLTJ6Jscpo7Am28ipsigTXw48mUHSvkH2IwakL7QcYJHVSTlAMuf8Q6ttMIHAS7YSnRFT9/clyIlRfO0daEgowpnQBcC2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lWPyz6mO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=craJ3cKO6XjBzl2tIRYiAmh8w2EueEbhqNxAudlydms=; b=lWPyz6mODSaoDerM/4bEwqz5L5
	EQ+hLnJWvOFWdsXEgs2lKC+QShx7QXErhK8z4mOt5AzWWdrySHCRkQqPBtuYmN/wfwF/bTqtrw4VZ
	kBSIewQ6Bs/m8I86oAIj9z2+ubGes8vf6xJBlkm3fgf/mxdUubUcWLdg5pkUGWsFctF52bNK8IYEQ
	PzWgNpUs9aZS4Najz+f29BEUgOp/b5AZG7t8YpgMCbQUTmetzRsr7CDN9UtblYQNugtFdGrgbopHe
	UBGOGsa37IdqpRy46tkqyquLTgiito/NEaFnEYY52OzH36YzUaBtUq7ns1diD7+0gkEDhXRK+jJCR
	Xzwx8vIw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyQn-00000000GFN-1D0M;
	Fri, 12 Dec 2025 08:23:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 12/13] xfs/530: require a real SCRATCH_RTDEV
Date: Fri, 12 Dec 2025 09:22:00 +0100
Message-ID: <20251212082210.23401-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251212082210.23401-1-hch@lst.de>
References: <20251212082210.23401-1-hch@lst.de>
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


