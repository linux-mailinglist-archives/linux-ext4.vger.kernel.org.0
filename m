Return-Path: <linux-ext4+bounces-12432-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F0259CCAAE7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CDE2300A36D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77A22DD608;
	Thu, 18 Dec 2025 07:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkYoVyxQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA72DCBEC;
	Thu, 18 Dec 2025 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043077; cv=none; b=t+E0jy0cpaygJ4GkyIIN2mV08n3dMR8VNoXCnXiL2PcXUVw2SzWXEak7bJ8lqK6FlLSyabe0Yus8WQDn+EIttPPh9kYFRCsdbBc7ZTG+n/pFJULWyxFsLVusvKQWKSdQLBK5aivPVIf90N4QMnS4c4p2cWs2+Wq4ovNkFzIFgZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043077; c=relaxed/simple;
	bh=34/VR3jof2pRNLMfvO1cFxAm6Ao600eYkym/9yULwaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfLLOsuL+9Ptl14vD0AZ6JV62u8DcnZcCi6sl3Cag+uDDwM0ShkROedKW9cy7IoVtWeqenwABkS3UINlwAV9w81XTf3mNUqg6BnWh7CAw5MiPzHqq+ZkN+rg17raGkojb6PXfQhTEnEp/o4v5ifGsCiOxvfsP84ha+KCLfgvfbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kkYoVyxQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NNr6fE0Mj6QNHWc9XND6yH5u2QKuOV/mMVlbblK1H0g=; b=kkYoVyxQ2SE1jvNYc42fJ9B0lF
	irqdgjiK/a4uf1hveZYlOsHU8+oJ2f+xblnnxtbKBbAw4zjgi/NoJ7GuqmCD85zcEpcXhC/IwqQph
	J7NGXk+kEi3M+4OdKKeSgwce1xZgDs5wJlYzb5wDpCwhqgTRHltiyt4lFcUkp3dZtt2DMWXLiFOtV
	C7ohQTtD0+3wa/u4PutO0a4b2UKMOnMS1Km9aXi/Co3dYmvmYAG/CU87VOSeAuLlNZZp39A5LnHC7
	n0ro1KzZLgjuWTXe5zuAtJNm27UGk3Sa86dK8iid52ntXccUX0P1ld+j9vknrZUl/LYaDPMiYAjkC
	hCEbZKAA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8Th-00000007xce-2zYm;
	Thu, 18 Dec 2025 07:31:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 12/13] xfs/530: require a real SCRATCH_RTDEV
Date: Thu, 18 Dec 2025 08:30:10 +0100
Message-ID: <20251218073023.1547648-13-hch@lst.de>
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

Note that specifying a rtextsize doesn't work for zoned file systems,
so _notrun when mkfs fails.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


