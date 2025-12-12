Return-Path: <linux-ext4+bounces-12318-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BF1CB83E7
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 09:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C854F307CA3C
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Dec 2025 08:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA5E30FC15;
	Fri, 12 Dec 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pGoxkJRq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EDB30F800;
	Fri, 12 Dec 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765527745; cv=none; b=RczwQ5USEw0IK577xblkqm/bIOaZ4yE+pqv3+O+pV2UKAuzW78KkbKb3dvdE1yhesgF8N/Esf3he922ajghGqOtlHBEGLXFwc8oCJZDLJGaBscq7xUN/m4RfstrrXZ3IULY0M99TcKHiM3sqJg5A71fobmAtn7xiRWGM+4k+W0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765527745; c=relaxed/simple;
	bh=u/m3mR9gwclKb/wqg4nUBQf9CCEtxLnOY78b8RQSg3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTyi4iwGbKdmRQJFsplTJs4vMSoar6MhjVGLBFfUW/bHS+2zTkUGmu9RC65J7lKililAK39IMH7K4kMcnfLAxkXhcggbfPoEXhi6QHOSLTkLjgmUVfwi+XRLAxIhm35BbiJfuCwst6/xhWkj05rXyzxessyyTpuJ5iwYYerra2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pGoxkJRq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Vmuy4eAm7i9DMdVUSzsdlgQXOUPADC8TYZHCuJQd+wM=; b=pGoxkJRqJjHQ7f4+cuwO5qazx4
	JMqTj35i0Oz4Vk085Dx1d2/ZjkRcYPius4wYywKrprBNuxPiiqC0hWsTozwnhBpns+fft/d4ysSZW
	weKzIDVdYuEG2/tHXr+icLx1PYQBZ8Viwipto2vdWyYWtapENKKx1GT67eAC91jouxthY4/zwcAJj
	1tAXi0b+MX7OluR76cRa2wgmF+4f67WY4ikCx9boLhYfS0IVbB12lKKT/00cpx35OYoGaC8X95EOm
	wXCvFk1EaCV5SszPA2TERgwQKMVy0NHosGtGyYA1prX1p38CGfDIz0FkGPXQ9E8JG/MTPi9rWr8QO
	SlRa5/NA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyPv-00000000G5N-0zRR;
	Fri, 12 Dec 2025 08:22:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 02/13] ext4/006: call e2fsck directly
Date: Fri, 12 Dec 2025 09:21:50 +0100
Message-ID: <20251212082210.23401-3-hch@lst.de>
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

_check_scratch_fs takes an optional device name, but no optional
arguments.  Call e2fsck directly for this extN-specific test instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/ext4/006 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/006 b/tests/ext4/006
index 2ece22a4bd1e..ab78e79d272d 100755
--- a/tests/ext4/006
+++ b/tests/ext4/006
@@ -44,7 +44,7 @@ repair_scratch() {
 	res=$?
 	if [ "${res}" -eq 0 ]; then
 		echo "++ allegedly fixed, reverify" >> "${FSCK_LOG}"
-		_check_scratch_fs -n >> "${FSCK_LOG}" 2>&1
+		e2fsck -n "${SCRATCH_DEV}" >> "${FSCK_LOG}" 2>&1
 		res=$?
 	fi
 	echo "++ fsck returns ${res}" >> "${FSCK_LOG}"
-- 
2.47.3


