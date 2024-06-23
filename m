Return-Path: <linux-ext4+bounces-2923-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0DC913A6A
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC83B20C10
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4990181333;
	Sun, 23 Jun 2024 12:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mYx+2ik1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8D118132C;
	Sun, 23 Jun 2024 12:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144680; cv=none; b=aR2Q8Bhpulk1pE3hgdaRsAF2GZFvAP68sYW708nhw4izo2v201DPtJtFPPpqf0iMC5RSpiAp4BcZSO9kOvT6G93mU6hQ6elMywf698G0aT4MR7au1qBRcW3NAI3CkSEvFFmsnOzdwvEtngnGKWUTN2+3AQ/AEEXs9BajkJLhY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144680; c=relaxed/simple;
	bh=QGhNpqASfx6MwZkfwKOxHlZZ0N0N0OLOfhAUIIdND5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jx1mmRAXWfcmU0JLmm59CS31uVS9CwsD97eTQByedyDZk1GSzQAoYWrvZEgCcZrWzDQoNbdChJtMTadD23sZk//VnWMZyaQSfdQ/vWiWiF+00L2CyupUTrzTVXdX0RzipP/b88IJa5jZF6WgILIXh4fCKOX4QJj9o+bb4fmZacQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mYx+2ik1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c6FRbeLZHlNx3SeSODF86bsBLHuY+pvVrhZwXTDjmQY=; b=mYx+2ik1EPE1qGUm+OyPFHWWJo
	ETg+RFUnOw+o15VaKEsnwNHuYpz5azGAp9z/6PbaFPg8n9d20smo5O6xYFyIbueMqycrt5GbECNni
	ZpaSDgh/ptJPXJsAMzMuz1q7joIeiV65h/zCes+Dhf2+MxDlMrHcICRiWk+JRdstcIq7Lf0OI0mhj
	SBU6Xh1xLh4ttjzHscv/eoC0qfvSmuGa+aQn3O6JkCg3xsu1zQs3bhpVddRKMjdca2NDvxw4/ayBy
	0/4/Hb04ODpuCbd30mmyVDTX2s8wVawlcL1NdLjl/NilBxo3mnOV9bXHEAnZlC21oN7z+tBi5b88k
	9PtUZU5w==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM3y-0000000DwyA-02Po;
	Sun, 23 Jun 2024 12:11:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 4/8] generic/740: skip jffs2 as foreign fs earlier
Date: Sun, 23 Jun 2024 14:10:33 +0200
Message-ID: <20240623121103.974270-5-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Commit a633d252e3c4 ("shared/032: add options for jffs2") added a
check to skip checking the overwrite of jffs2, but only after
adding specific mkfs options for it and zeroing part of the device.

Switch to skipping it earlier in a more obvious place.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index 6a97ac69a..bac927227 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -46,8 +46,8 @@ do
 		preargs="-p lock_nolock -j 1"
 		;;
 	jffs2)
-		# jffs2 mkfs requires '-r $directory' and '-o $image'
-		preargs="-r /proc/fs -o"
+		# mkfs.jffs2 doesn't work like a normal mkfs and just fails
+		continue;
 		;;
 	jfs)
 		preop="echo Y |"
@@ -79,8 +79,6 @@ do
 
 	if [ $? -eq 0 ] ; then
 		# next, ensure we don't overwrite it
-		# jffs2 mkfs doesn't check overwrite case
-		[ $fs = jffs2 ] && continue
 
 		echo "=== Attempting $FSTYP overwrite of $fs..." >>$seqres.full
 		${MKFS_PROG} -t $FSTYP $SCRATCH_DEV >>$seqres.full 2>&1
-- 
2.43.0


