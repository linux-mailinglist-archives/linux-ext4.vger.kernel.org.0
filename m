Return-Path: <linux-ext4+bounces-12424-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784ECCAAC0
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 08:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FCE307A9F7
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Dec 2025 07:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906552DAFCC;
	Thu, 18 Dec 2025 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FRPy77wd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9672DBF76;
	Thu, 18 Dec 2025 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043045; cv=none; b=KXgQUtDHjfp45mIVm1r+h8hglSPNdyLm3ZoepbBeuUpV4Zn/Is3Ky/PIiTj1MZS3jbqZhxDjqwfGe+e79V9NydDbnZ/dkbxegrBpFSH/KWYpXF8JqFFaRUImpniqf8dlDI+oaY9mOPQahIaP2GK8VUU/FulnX3FEMhrHNQZ+oCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043045; c=relaxed/simple;
	bh=Hjcykj7wIODStwDaqXLdzBOO6ugsZfy6936Xnj+La1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NedvknIOzvIVo783vhipGH04LfxzWVy6YGEw1YQ4Uld3fhV9FDrg2CqWK41WVq975qXjzw3BF+x5yNWQNB6fjcO81etkWgmxl0muaTpWfGWyhUGRnbYqiAK1KNueaPtiHwrRNC05wDI7ygZzS6/r6Gkzfq2H0fX5qrgchrzS+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FRPy77wd; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XuM0sfmfG5mkUNZFG0KWkz9z4Ny5zS0hFr1gSEZPUII=; b=FRPy77wdua0pnClyAz4KcziUjt
	JIqxfUdSwlxPdE8FCdlPMVYc3Ha3Ko4d7bsiy4S3nqaiY013pyK8lHhZg1sbn49QkvL6hy8RMRwni
	ORPAgUtMWGWh5HuF/ERfaelWHI7IVOTsNwyDR3Da2dSh6Bl6uSbxA25O/IPZnuQmy+aErBryVZsgf
	pw94isHnEQxuE68ZPUThuuFeXN19e9SseV/sgw/i4fzgbqOJj5iNdE8KsBYxTyBJYVZHNguEPPcwG
	f2TdCaL+ExueGfWeIT/T8ahBTWaDsfTW8+r5OGMQlY8EXusOdOJ7ID71JdN2lnqirAvNHzzuID/7O
	KAnJB7Zg==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vW8TC-00000007xZK-1wrM;
	Thu, 18 Dec 2025 07:30:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: Anand Jain <asj@kernel.org>,
	Filipe Manana <fdmanana@suse.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	fstests@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH 04/13] ext4/032: use _check_dev_fs
Date: Thu, 18 Dec 2025 08:30:02 +0100
Message-ID: <20251218073023.1547648-5-hch@lst.de>
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

_check_dev_fs is the new designated helper to check file systems on
arbitrary devices, use that instead of _check_generic_filesystem, which
is just an implementation detail.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Anand Jain <asj@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


