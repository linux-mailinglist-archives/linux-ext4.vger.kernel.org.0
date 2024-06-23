Return-Path: <linux-ext4+bounces-2924-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B7913A6B
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D351C20860
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA14181305;
	Sun, 23 Jun 2024 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDvgVz76"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21D180A98;
	Sun, 23 Jun 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144683; cv=none; b=RJOCpsUhDcRmM6K6EYfyra0TEfrvky1NJsnMyEpU7q0A85xMuiwAHJghN//YnZjrihM3LO92Oy6fWlvwzNiuw+u84vXz5nZXUoAqsQNymLU2A0w0Thz+fo7x2dI3XXArqW7WO94BoFR4FI1zIYAqyR/QhLf/tp9zi5GDopRLVu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144683; c=relaxed/simple;
	bh=Bhq83zOMbFFvnJc+Mezl9yJRqg3XDX/CVHOM0N7TxZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOwyctsgiZA18FCrxnnuQAmPUyRxoZaqT0eJXrKgNdyGT1DbE0AXpHQ4hD9VJVw+5gD7LzIXSqcqLB2FLjuoLMfzfFhcFtnl95lksekSOAhgEN5tXPF3eMEloeQFVs95CY2bAQ6EqDr+kvhqhIBJCcyakEpbLAe93pkFOUTkTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gDvgVz76; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=82Lg1zgoLm2gNxixpS3464vMMK1PGuPj3kQrl+fzX4w=; b=gDvgVz76BCXL1vUsT+tn6k5PyW
	VT0LCEyuQZfydslJMW5k+cmT2BupgrR4Cs+pTxik7S9JpkF+Ndum8w+X8pQuEU+LCJ8JWbwjg4DzB
	8o61rOg0+Sk2hICtBz0uAeoamh8M1yBns7OLVxPTUwOJcjUMovGcSEBXb3zFuf/+sYNlurUOXwlUj
	DDPwyj3UG1JbXDCVfLUcNA5o/Wpr+M31/CVlbBXpPuhh+Gk8Brl5o9CPm6r+oJ/zTAmdgB7bg2+vr
	8fzuiIxJWJ0JeVPEBnRbtpwl75yphpPeRdfPbTzRIGCcRAO82WngDj5REevPHNuaAgaFqpAsExywT
	+Gk9aryA==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM40-0000000DwyW-2TjE;
	Sun, 23 Jun 2024 12:11:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 5/8] generic/740: enable by default
Date: Sun, 23 Jun 2024 14:10:34 +0200
Message-ID: <20240623121103.974270-6-hch@lst.de>
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

Instead of limiting this test to a few file systems, opt out the
file systems supported in common/rc that don't support overwrite
checking at all, and those like extN that support it, but only when
run interactively.

Also remove support for really old mkfs.btrfs versions that lack
the overwrite check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index bac927227..903e891db 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -12,19 +12,16 @@ _begin_fstest mkfs auto quick
 # Import common functions.
 . ./common/filter
 
-# real QA test starts here
-_supported_fs xfs btrfs
+# a bunch of file systems don't support foreign fs detection
+# ext* do support it, but disable the feature when called non-interactively
+_supported_fs ^ext2 ^ext3 ^ext4 ^jfs ^ocfs2 ^udf
 
-_require_scratch_nocheck
-_require_no_large_scratch_dev
+_require_block_device "${SCRATCH_DEV}"
 # not all the FS support zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
 
-# mkfs.btrfs did not have overwrite detection at first
-if [ "$FSTYP" == "btrfs" ]; then
-	grep -q 'force overwrite' `echo $MKFS_BTRFS_PROG | awk '{print $1}'` || \
-		_notrun "Installed mkfs.btrfs does not support -f option"
-fi
+_require_scratch_nocheck
+_require_no_large_scratch_dev
 
 echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
-- 
2.43.0


