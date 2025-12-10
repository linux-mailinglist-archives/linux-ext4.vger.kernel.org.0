Return-Path: <linux-ext4+bounces-12252-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0C6CB2058
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3BC030E92E6
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F862F9C39;
	Wed, 10 Dec 2025 05:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QDCo/jVm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04425277C8D;
	Wed, 10 Dec 2025 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345741; cv=none; b=JcNQmATqP2TFuHxyhd2jyBpvGcyWIveF+VJSGa93ENbQu9sLfPpPPE3bwSTAbk4ulegvJXq0CXWzM28rG5M5fTJ9Y+9W+MTE8cq53YnvrybCXnKI4Pjd9UsY5T9+AEnPSjSOM6FMYehZsq/cCTM2VWoXhVyR7WLSZqyZix6WVb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345741; c=relaxed/simple;
	bh=oSGGf81S5WvYeF1BoSHRA/lEuKmyvi5qmkdmX7MfxNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qA1GJW3utt3rsw2IjvkABZtZ1lEpNYvIDqfl5nquXCuB/5EPoPm4KJDDrWPDQ60T7fs9mGRwTrR4AlXlVBtCwAjkoaqz5H1nVWRxdgEZn3oFRb5wXRrSav+Rf/3PoW+K8GHL2V+fnojjDrpY2WZUKNWwBziyN+lvPelHfRVT+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QDCo/jVm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FX3NgsVImQ0GyQZ6X5OVeE3hMatQkyu5wMhyECln7Ss=; b=QDCo/jVmyONRqTd1lUwQ8Q+cRW
	jzUSo8i2P+fGTUaBSKxP+rwYgFypHoH4PlsvfQd68bWGzqVQ6eeJOAeho3qA/Ac3ElfOOMMBMhKbr
	pwnr7YiZ+KQpz7LAvzOfLfXDwnnnglX++Gcj7R5bugBmWJWhv5Pv+zcBNC033dHfOLXfM21V57y9R
	XPNJYZV8eesg1rxRPbGhKVPihizk53Ca8LUZjFVOrt5rCkawmT4BgtKXzEjxT5DPzjEYEBstVfbpN
	m30cqo2jw/2lIKysWnWebhe4KDm4ys1qWoMRj0fBe7S6mei9n3CnpPUu3duh6PqHEVOf90xpcnDW1
	OAgv3rYQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4L-0000000F94m-152c;
	Wed, 10 Dec 2025 05:48:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 04/12] ext4/032: use _check_dev_fs
Date: Wed, 10 Dec 2025 06:46:50 +0100
Message-ID: <20251210054831.3469261-5-hch@lst.de>
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

_check_dev_fs is the new designated helper to check file systems on
arbitrary devices, use that instead of _check_generic_filesystem, which
is just an implementation detail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/ext4/032 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 690fcf066c11..043ae4f53505 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -66,7 +66,7 @@ ext4_online_resize()
 	$UMOUNT_PROG ${IMG_MNT}
 
 	echo "+++ check fs" | tee -a $seqres.full
-	_check_generic_filesystem $LOOP_DEVICE >> $seqres.full 2>&1 || \
+	_check_dev_fs $LOOP_DEVICE >> $seqres.full 2>&1 || \
 		_fail "fsck should not fail"
 	_destroy_loop_device $LOOP_DEVICE && LOOP_DEVICE=
 }
-- 
2.47.3


