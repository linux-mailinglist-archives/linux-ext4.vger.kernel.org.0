Return-Path: <linux-ext4+bounces-12250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43182CB2043
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 06:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 769CA30CCA53
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Dec 2025 05:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7727A92E;
	Wed, 10 Dec 2025 05:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xpHyt9SF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B92283FC3;
	Wed, 10 Dec 2025 05:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345730; cv=none; b=AYyj/yvwqvg8RM+pJHETRMPdpLMBBgbjMu0A4LnA5Gw5cNT27U1/fY1ScFy7GJKvkvjJbluYBSQmTM91npqd0s+Hpuxsr/EhF5+9aYUkv6IU37+acAJrCH+qW9HsV94TlTiGkC3xsPF5g2RKcDuLerBxD6gSbozmajdLcckSkhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345730; c=relaxed/simple;
	bh=YXGcQRsSaa9nPcG8MG05fqkWsh5NAHmkCu0mh6nH7VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP2QrTmHgCm96RfPpnz64sOt3fv0/zeIyKDoqjYU02KXC6y1n7X6YXWlg1hieTSOAJ/7oOjUZ0AeA5HzlSAJcpH9He+4ynl5FV+kw2One4AuH95XmY44NzAaL8PqMi3SucORIKpMu1mAu0pISgwWhR6izU/xC3GOMuIb9wXM+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xpHyt9SF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KefBb5Z3856tWNxQSKFE+aSrODcBKdmrzjetMa8kbBI=; b=xpHyt9SFZlVlv6QwJVF+fV1Q8U
	dL0gz8vWwlOuyC0YQyV9u2oHmtcpxpdo04v4DZUf1rwQkX+6EyeLzoS0764nNSjH7Qc/taZpr+ZiJ
	A/BNWN1mJqYu3dPg+hJgv8GPclJ+Pni5xyAudW/gC0d/iUpdKrIYgei4H3fJWkYltKgnBTkNFZGT0
	a6s2mdz21NI1glRyQbmeQvN8jlnMUMGuUQRdiD6lKOx4pRgTrCukyYvxZXl5hY9bwgDrDxuboroU8
	youbEaCatfbceIbtCecaKtO7a4w4Yp9+ts3WPPsrPN1U4XawUM/UhVHIUubW90CpMRFSM+LejnLsL
	Gy5sdnfA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTD4B-0000000F93y-0D0Z;
	Wed, 10 Dec 2025 05:48:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 02/12] ext4/006: call e2fsck directly
Date: Wed, 10 Dec 2025 06:46:48 +0100
Message-ID: <20251210054831.3469261-3-hch@lst.de>
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

_check_scratch_fs takes an optional device name, but no optional
arguments.  Call e2fsck directly for this extN-specific test instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/ext4/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/006 b/tests/ext4/006
index 2ece22a4bd1e..07dcf356b0bc 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -44,7 +44,7 @@ repair_scratch() {
 	res=$?
 	if [ "${res}" -eq 0 ]; then
 		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
-		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
+		e2fsck -n >> "${FSCK_LOG}" 2>&1
 		res=$?
 	fi
 	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"
-- 
2.47.3


