Return-Path: <linux-ext4+bounces-12431-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7612CCAAE1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 098B230AB7ED
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243D82DCF72;
	Thu, 18 Dec 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eDNMagaH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79902DCC03;
	Thu, 18 Dec 2025 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043074; cv=none; b=ck7pLUo/fSntfa8Qt3nw24/UxZ5m+mqEzR7zW5+1XhZXezX30WXi7Je0QSl14BaTgTXFgWWD0rk0L6s5r1PFFPODAOQmCDqlFKpmusIMToAZ4CTKY0zt9IU1HJTeaWGHgZ5CwmUaryVu6sQj9PhIA9qFsrN6ctBj2oE+EzFF3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043074; c=relaxed/simple;
	bh=UqyQckytFnAju3+hGqwpEJkkxK0MRS9I+iU3xSorEvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijgRUp3sq72QONF9zEmfZt0I+cFQ/AsyoLWK+1eaifzb/M2VVe4ByxCsUjiWqRBfVyl33DcZ1cYoy2Tg/HTYvwQfHHY8Ia7u0iWqI/nUONF+f1NAvT/kUMpHSZanv4dVAu4s2IQydNL4vRJOK4VXlW548tk3XizlmqLH694mhqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eDNMagaH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8g9xRyT4RvDs5SubYZuhLbHGZQ0f5+8YEWC4JnZ/hbE=; b=eDNMagaHa/aSpmiiKYGN8O2vGj
	UX2fQfF+Hn7DNpBB/WLAY/cQr6M58Z1E+B3fNxNUGyEmPHKmFUBimu7NzhV2vAfQA4xONt7EPYsbR
	59b31yebhO4bdnThlOOp50HS6RA10Q+4eX0rX5l1B6RIAu/ryeNguaQpXviv8FnmmijTH2XD+6wT0
	m6kkT/pIfdEMVm7QUPTji/+zxHWySEsSV7CgiHnALTiLGNonZOZSM/XOeAJPA6dujSWY6QmfsFclt
	9JU6IAcNieQrWsHuTQP7551f2KfEeeyvzkDmZfAMHheRugoPYWt9I+PpnBI1qnB1RaBqtiK76nAiZ
	of6iXnvw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8Td-00000007xc8-2jUg;
	Thu, 18 Dec 2025 07:31:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 11/13] xfs/528: require a real SCRATCH_RTDEV
Date: Thu, 18 Dec 2025 08:30:09 +0100
Message-ID: <20251218073023.1547648-12-hch@lst.de>
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
 tests/xfs/528     | 34 ++++------------------------------
 tests/xfs/528.out |  2 --
 2 files changed, 4 insertions(+), 32 deletions(-)

diff --git a/tests/xfs/528 b/tests/xfs/528
index a1efbbd27b96..c0db3028b24a 100755
--- a/tests/xfs/528
+++ b/tests/xfs/528
@@ -10,27 +10,16 @@
 . ./common/preamble
 _begin_fstest auto quick insert zero collapse punch rw realtime
 
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
 
-_require_loop
 _require_command "$FILEFRAG_PROG" filefrag
 _require_xfs_io_command "fpunch"
 _require_xfs_io_command "fzero"
 _require_xfs_io_command "fcollapse"
 _require_xfs_io_command "finsert"
-# Note that we don't _require_realtime because we synthesize a rt volume
-# below.  This also means we cannot run the post-test check.
-_require_scratch_nocheck
+
+_require_realtime
+_require_scratch
 
 log() {
 	echo "$@" | tee -a $seqres.full
@@ -63,7 +52,6 @@ test_ops() {
 	local lunaligned_off=$unaligned_sz
 
 	log "Format rtextsize=$rextsize"
-	_scratch_unmount
 	_scratch_mkfs -r extsize=$rextsize >> $seqres.full
 	_try_scratch_mount || \
 		_notrun "Could not mount rextsize=$rextsize with synthetic rt volume"
@@ -151,29 +139,15 @@ test_ops() {
 
 	log "Check everything, rextsize=$rextsize"
 	_check_scratch_fs
+	_scratch_unmount
 }
 
-echo "Create fake rt volume"
-$XFS_IO_PROG -f -c "truncate 400m" $TEST_DIR/$seq.rtvol
-rt_loop_dev=$(_create_loop_device $TEST_DIR/$seq.rtvol)
-
-echo "Make sure synth rt volume works"
-export USE_EXTERNAL=yes
-export SCRATCH_RTDEV=$rt_loop_dev
-_scratch_mkfs > $seqres.full
-_try_scratch_mount || \
-	_notrun "Could not mount with synthetic rt volume"
-
 # power of two
 test_ops 262144
 
 # not a power of two
 test_ops 327680
 
-_scratch_unmount
-_destroy_loop_device $rt_loop_dev
-unset rt_loop_dev
-
 # success, all done
 status=0
 exit
diff --git a/tests/xfs/528.out b/tests/xfs/528.out
index 0e081706618c..08de4c28b16c 100644
--- a/tests/xfs/528.out
+++ b/tests/xfs/528.out
@@ -1,6 +1,4 @@
 QA output created by 528
-Create fake rt volume
-Make sure synth rt volume works
 Format rtextsize=262144
 Test regular write, rextsize=262144
 2dce060217cb2293dde96f7fdb3b9232  SCRATCH_MNT/write
-- 
2.47.3


