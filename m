Return-Path: <linux-ext4+bounces-12255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 852DECB2064
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB36130D3311
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121AF2F9C39;
	Wed, 10 Dec 2025 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2F8xFhDg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECAC2DF3EA;
	Wed, 10 Dec 2025 05:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345758; cv=none; b=hSvn1O4M77i7EuKT9Dpnxwehy7jflarB9DgSbkury3BvquZRnNMAzZrCAp44xXyYTp4LYqHm18OFfwlo/bHnmgyot4MqN7kct/lBiD+nkFuCchRkUkcw3GM81ALDURGOv5lktUFiItI921us7CVEeYgrBPVhAa29kBgwZ95xh7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345758; c=relaxed/simple;
	bh=k9L+YyhRJE3xTlZUscoeJj26sNWSSum74QLU4QIYfMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2oKbSbqmaQyq8P5yb5ODW37HwIsNt+I3AdC8WWof84rHkxNqGCFUh7PlfxojKX1WcI7nFYOCWN4diSaMb6FrTVxln0Ch/j357WQR7Dpt8FW78574gH7zMYnR0KiwWYPD761fRQQB4Q84h1M7aSfESz16XwrbzvdnlAGx23GL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2F8xFhDg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=wnaeDdQ53vQlLT/n8+/nY4FXaGGu9YPRrEkuK8lIBcc=; b=2F8xFhDg1u6yIyzR9ku/rDOqqB
	GihIi7z82WVoYXV1FpVNJYapByoAqFZVz3LOaE/U5ubJvLvk9bUbvlZvXmxXReiQS5pJFHUj1tB/b
	NYkRZVSQ7TnUuCa6JVRnadtMgf1jOGnpGSL153HtDO8c6Svrrkz1WKKAaDQuEY2A1KQFM1KQjZOoB
	G+pOV6BU37Bjjj7IJ82zEUHHmjxaIZgOtlvfCf6AdkvSE6w+BMmHB2JL7JQBVABpASVuOU48o9pPr
	A2p4cVsq7N6OqTCtKp20pt/evfpvPQdIp+65MNJ3mUpJ0Sv4izFJH+AZK8i6GmyN+WjFWPdwxaAJd
	Uor9e5ZQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4e-0000000F97b-0tIu;
	Wed, 10 Dec 2025 05:49:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 07/12] xfs/185: don't use SCRATCH_{,RT}DEV helpers
Date: Wed, 10 Dec 2025 06:46:53 +0100
Message-ID: <20251210054831.3469261-8-hch@lst.de>
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

This tests creates loop-based data and rt devices for testing.  Don't
override SCRATCH_{,RT}DEV and don't use the helpers based on it because
the options specified in MKFS_OPTIONS might not work for this
configuration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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


