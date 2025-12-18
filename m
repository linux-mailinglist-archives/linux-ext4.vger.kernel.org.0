Return-Path: <linux-ext4+bounces-12427-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD980CCAACF
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4C13091CC9
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891A62DA759;
	Thu, 18 Dec 2025 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1rHdj93"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3E18DB01;
	Thu, 18 Dec 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043055; cv=none; b=FB3DYYEM7nO7LBZfh/7LHDcgqCzAY+aNrr/4Q7GEtm0pcvkYKTVs7CGRhlKmW4Hj9z7CwOHRtQyUbG06FUQppYkR9oe8Cf0QcsSwET/KaPIgrmWsffcuNHiR/U1uGuva+/b/PU3avb/zLYJx/LVpwO2c9mu+KT8ekwcpsqEOhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043055; c=relaxed/simple;
	bh=+ynCMuIpEgP00dLvOhe4vCQGGoABQ0jb70+y8o6Uqvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xaouln/rV98B3FyDFL/AEPgG9212Qdnv1oEo0cmILjkebgbKa6M9gD9OEhvza+YfhQzKdqgy+/44l5ARfD6hmV8Fb3Tk9+FPOJOpcXdmLYCPx0WRi6O2DkO+0xW0aG/Wzfbbn2Qrj/BYinbyQ9hrRvNg00w9/rt0L/u2mkfbnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B1rHdj93; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RKhqASIZcGds8wrjgvfnvpeSZWq5E1W7NP8bj4Rt5dc=; b=B1rHdj93FJZHMSj+WBAgDU3LO4
	VnXfU1NOTPphSqmzPCm5EW5OBL3YiF0fS2Ox8xyaqCqP+hQp3M7APyBSx5xHJBoAH1FtD2Kmx4xw0
	8JYKvSKcR3qsGvyeFFKvjOxs4rUb2qMrxg6OKcpy2ujwlrDgWM4mH8SOeZB8ObDBCDByv2pjni6Nz
	ErDJmgSm03ClGynB5kYGYQ5WSdaH15I2AyULevwsD6SGbW8qEoccQIWIwT+ahpGK3PZb5jMPA0WfE
	OcNj5VVcgLwfBYzZqVKDaugluaPE3OmsrjjR8BKShgxMBGggS42j9nnvGcXuAdaEtA5UpCRHXOgr2
	+S6mysqw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8TM-00000007xaT-3v5Q;
	Thu, 18 Dec 2025 07:30:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/13] xfs/185: don't use SCRATCH_{,RT}DEV helpers
Date: Thu, 18 Dec 2025 08:30:05 +0100
Message-ID: <20251218073023.1547648-8-hch@lst.de>
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

This tests creates loop-based data and rt devices for testing.  Don't
override SCRATCH_{,RT}DEV and don't use the helpers based on it because
the options specified in MKFS_OPTIONS might not work for this
configuration.  This also means that we will now never use a log device
for this test even if SCRATCH_LOGDEV was set, which is fine because the
log device is not relevant for what is tested.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 tests/xfs/185 | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/tests/xfs/185 b/tests/xfs/185
index 7aceb383ce46..84139be8e66e 100755
--- a/tests/xfs/185
+++ b/tests/xfs/185
@@ -22,12 +22,11 @@ _cleanup()
 {
 	cd /
 	rm -r -f $tmp.*
-	_scratch_unmount
+	umount $SCRATCH_MNT
 	test -n "$ddloop" && _destroy_loop_device "$ddloop"
 	test -n "$rtloop" && _destroy_loop_device "$rtloop"
 	test -n "$ddfile" && rm -f "$ddfile"
 	test -n "$rtfile" && rm -f "$rtfile"
-	test -n "$old_use_external" && USE_EXTERNAL="$old_use_external"
 }
 
 _require_test
@@ -64,16 +63,8 @@ rtminor=$(stat -c '%T' "$rtloop")
 test $ddmajor -le $rtmajor || \
 	_notrun "Data loopdev minor $ddminor larger than rt minor $rtminor"
 
-# Inject our custom-built devices as an rt-capable scratch device.
-# We avoid touching "require_scratch" so that post-test fsck will not try to
-# run on our synthesized scratch device.
-old_use_external="$USE_EXTERNAL"
-USE_EXTERNAL=yes
-SCRATCH_RTDEV="$rtloop"
-SCRATCH_DEV="$ddloop"
-
-_scratch_mkfs >> $seqres.full
-_try_scratch_mount >> $seqres.full || \
+$MKFS_XFS_PROG -r rtdev=$rtloop $ddloop  >> $seqres.full
+mount -o rtdev=$rtloop $ddloop $SCRATCH_MNT >> $seqres.full || \
 	_notrun "mount with injected rt device failed"
 
 # Create a file that we'll use to seed fsmap entries for the rt device,
-- 
2.47.3


