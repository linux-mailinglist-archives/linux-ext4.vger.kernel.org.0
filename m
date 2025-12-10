Return-Path: <linux-ext4+bounces-12256-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B00CB2067
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78D4630FE000
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C080B30F819;
	Wed, 10 Dec 2025 05:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoTwi+TH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED42DF3EA;
	Wed, 10 Dec 2025 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345763; cv=none; b=uVYTerJhlO+H/7Q0OAX4h2yy6KiQzo0XLn6Gjf+BeNYXlrlem7U12xdcT2JxX5LOYH4PA1eWj6fY1go2Q0KDoeji/8FlX8Kd/3VYlsD8Sn11p7OiJsIRY+VwOgFj+RfHLwE61NijvynMU8LSDZS6fsQc7O3eYheueJ2HW1e0JQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345763; c=relaxed/simple;
	bh=lrrtt4kV0Sv/HFglb4fBJFxPc/rMJhhFfS31UZ3za/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcBHtUb6rMw+ymjowANWTUK9QjqEAcmZ27Z7oVf2ExcEmAWbmxAeE+Tjx1Ux3lujHvBw9UxUuL2UmNozv8/CAKLbRa/Sw1g91bu1TnkeAQqJxRU0a2upAKtQxeeYpjDN+0H9GVS0MTlYRUXk7mWTFbvCs3o9E6TOOE62vx1kris=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GoTwi+TH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tPSn0CuJbSM1ZQOZhbuItbhr50HcIQtXi2+qi9LOM8o=; b=GoTwi+THFO9MH3QDl+RLIlCUax
	wkQX1BFMV7M535njilaCtSJkQbzIJINnCKUirISGalfzecdSL3w6XIAekDFmYOknxLegIyh5PrNIu
	MqAoJr08+EfdmEtax93qVZ5xwtLlVg+v1OVtMLZAXsIrHaxdL8fcG3/THLtvKpuhY0qIKX3z4wr8h
	MHRZntNB8NuwtJqWcLzdVTQ2qLKIBX1eofephiDF2b0ED7Tb7zl6KD1V4mNYvyuC+TT6K22mmIGFf
	xfDp11sF5VOo3teUiveKYC97fma5ilEat+lNwWTDIZgcK0GTA6Qi0DUZ5j2RKt/zJUzGpuFZId4LL
	WxMEZqvA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4j-0000000F97x-1go1;
	Wed, 10 Dec 2025 05:49:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 08/12] xfs/424: don't use SCRATCH_DEV helpers
Date: Wed, 10 Dec 2025 06:46:54 +0100
Message-ID: <20251210054831.3469261-9-hch@lst.de>
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

This tests forces external devices to be disabled by calling mkfs.xfs
directly and overriding SCRATCH_{LOG,RT}DEV, but the options specified in
MKFS_OPTIONS might not work for this configuration.  Instead hard code
the calls to xfs_db and don't modify the scratch device configuration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/xfs/424 | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/tests/xfs/424 b/tests/xfs/424
index 6078d34897e7..61e9de375383 100755
--- a/tests/xfs/424
+++ b/tests/xfs/424
@@ -25,17 +25,11 @@ filter_dbval()
 	awk '{ print $4 }'
 }
 
-# Import common functions.
 . ./common/filter
 
-# Modify as appropriate
-
-# Since we have an open-coded mkfs call, disable the external devices and
-# don't let the post-check fsck actually run since it'll trip over us not
-# using the external devices.
+# Since we have an open-coded mkfs call, don't let the post-check fsck run since
+# it would trip over us not using the external devices.
 _require_scratch_nocheck
-export SCRATCH_LOGDEV=
-export SCRATCH_RTDEV=
 
 echo "Silence is golden."
 
@@ -62,30 +56,31 @@ for SECTOR_SIZE in $sector_sizes; do
 		grep -q 'finobt=1' && finobt_enabled=1
 
 	for TYPE in agf agi agfl sb; do
-		DADDR=`_scratch_xfs_db -c "$TYPE" -c "daddr" | filter_dbval`
-		_scratch_xfs_db -c "daddr $DADDR" -c "type $TYPE"
+		DADDR=`$XFS_DB_PROG -c "$TYPE" -c "daddr" $SCRATCH_DEV |
+			filter_dbval`
+		$XFS_DB_PROG -c "daddr $DADDR" -c "type $TYPE" $SCRATCH_DEV
 	done
 
-	DADDR=`_scratch_xfs_db -c "sb" -c "addr rootino" -c "daddr" |
+	DADDR=`$XFS_DB_PROG -c "sb" -c "addr rootino" -c "daddr" $SCRATCH_DEV |
 		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type inode"
-	DADDR=`_scratch_xfs_db -c "agf" -c "addr bnoroot" -c "daddr" |
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type inode" $SCRATCH_DEV
+	DADDR=`$XFS_DB_PROG -c "agf" -c "addr bnoroot" -c "daddr" $SCRATCH_DEV |
 		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type bnobt"
-	DADDR=`_scratch_xfs_db -c "agf" -c "addr cntroot" -c "daddr" |
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type bnobt" $SCRATCH_DEV
+	DADDR=`$XFS_DB_PROG -c "agf" -c "addr cntroot" -c "daddr" $SCRATCH_DEV |
 		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type cntbt"
-	DADDR=`_scratch_xfs_db -c "agi" -c "addr root" -c "daddr" |
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type cntbt" $SCRATCH_DEV
+	DADDR=`$XFS_DB_PROG -c "agi" -c "addr root" -c "daddr" $SCRATCH_DEV |
 		filter_dbval`
-	_scratch_xfs_db -c "daddr $DADDR" -c "type inobt"
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type inobt" $SCRATCH_DEV
 	if [ $finobt_enabled -eq 1 ]; then
-		DADDR=`_scratch_xfs_db -c "agi" -c "addr free_root" -c "daddr" |
-			filter_dbval`
-		_scratch_xfs_db -c "daddr $DADDR" -c "type finobt"
+		DADDR=`$XFS_DB_PROG -c "agi" -c "addr free_root" -c "daddr" $SCRATCH_DEV |
+			 filter_dbval`
+		$XFS_DB_PROG -c "daddr $DADDR" -c "type finobt" $SCRATCH_DEV
 	fi
 
-	_scratch_xfs_db -c "daddr $DADDR" -c "type text"
-	_scratch_xfs_db -c "daddr $DADDR" -c "type data"
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type text" $SCRATCH_DEV
+	$XFS_DB_PROG -c "daddr $DADDR" -c "type data" $SCRATCH_DEV
 done
 
 # success, all done
-- 
2.47.3


