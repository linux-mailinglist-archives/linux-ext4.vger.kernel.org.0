Return-Path: <linux-ext4+bounces-12327-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E9CB8418
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A23D30900A2
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5530FC1B;
	Fri, 12 Dec 2025 08:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbZyBKF0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D661D5147;
	Fri, 12 Dec 2025 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527793; cv=none; b=sSHWtTBNgNbo217gb7sinD8usZ+at2C2e6sn7Zp55c20s2Evz/oabekbNJV5w2VTq+NSbbOdWDlWc4q/iWZ8a+iIhyHs69RZd8i0bg5dPv4MI+X8xr3zCKuVQ1mAzaJ2rG+WbXBWEwkHJzK2YZed78Tb+OMl4w5vKEfsm5Kpy2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527793; c=relaxed/simple;
	bh=AKLpAgyw/27dUbqa1inhvV64N5cFo0jxwf6eIbR/as4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfeEa/8CjXqDD0p7bIRfo7JD1kzcesEOLueE9lZ8942ZM/0DbO8lK2x0TV2nwAck+8pxBqbhAUR9sA+Po5M1ODLc2VCVMO4JIkGzzyLO/fy8oYMoqawy9Yc9T8roXoV22u1X+ILGLHUc5vkZ7NO/OROHO1D0N+x14vdC4XofVi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nbZyBKF0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y3wraW0C9kJi2PUqLm2Ic4Z3H29aIsh5BN7KIbI3fic=; b=nbZyBKF0sHPn4dZCbhcdiW3E4m
	OO8o5UiXK89k768lr1mvx68P3+sfifUQmjD4yxft/DMiy/ew+KE2onzO4Y1e1hCiE3ANwMJnBVgQh
	Nih1hTJFMZE2jOK7wwTwxfQjA2sfFw/MynX8Y4ANxV8hqruxx51a8X0YaLcCwxDCogeHbiAc+Bk9h
	2JefP5doLxI16aRkAq9LVtnGL5Pg4RuDFODEukqvI6aRSyHkkS16A83D8aCeeiOUNy7+czHOxiqMG
	0fpEU8kPCCsdTjDgygupYzh0tno0EZBqx3S5wFOwVnjW2NMrKp4kj5ZOGuspJxOpPquyIyHuF8ciT
	LNTy1iDQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyQh-00000000GEG-1o4r;
	Fri, 12 Dec 2025 08:23:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 11/13] xfs/528: require a real SCRATCH_RTDEV
Date: Fri, 12 Dec 2025 09:21:59 +0100
Message-ID: <20251212082210.23401-12-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


