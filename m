Return-Path: <linux-ext4+bounces-2926-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9957913A6D
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781842822F3
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D83181313;
	Sun, 23 Jun 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4JzeWVg9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD6F148825;
	Sun, 23 Jun 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144688; cv=none; b=mM8aK7jmT33RfIx8zg1ALF109RF2TmFiACNNIg9Lob3Qi57ZX0p4OV7bIIi7FrmdtoC4w+qY1VL/5mKLJTCv+geAjAdInK6EJzJN2w54RVxQGm2zEl+Vaf8fyvykx5gpD+qd0NtfrwIYdTMhD4hyywmo1RfsIdTXnno9QdVKw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144688; c=relaxed/simple;
	bh=CDzUvo6AWDgITGjMZ9a8NVpeMd4mGmL39VXdo0ShCjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJUI42t2lHUm0GnJplw6xWPhklqPjsEBKNyaXn7RSrZndxsyhF/57/C+AmBjcdm/XdQydzIXlBdK+tuVmgh7L2YPvAFsYpFaWRkd4Se0V1BLV/f+kRXVYsJ9uJkmK4/rFZttmq/9OLshoroW2XEIz7vDL4IXaV0mkxPuJu3VeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4JzeWVg9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hibX8+O5pzwtShKXDSdWNYkeICakHRikG7l/oSjWBFE=; b=4JzeWVg9KHTtD3iDEFO4hqbrjN
	ZGtINUzAqh5RaPGH3MD4bxUCCV9OtkVpP+zqcvWO4rYMhV1X+rmUa8lnZXAJDR5oIXyaxRyZQOwCL
	y2TdrcRV4qB8PMPFA+ab7PBv3tGDZ0jUc9taNOebNvy3t1AlvyD9/euEIP2ZhkdCRostQH+04B/5g
	GTOzY4Da0Pa4PWNltLzP9jb5fUra03qIBhSae53lrstuPqeULY9Jh5qkeKWEtrpf96FAadJ9EnGgf
	lOm0+7VK2wey2vVPkXviqF0rV3vvNBfErG87l6zDt69uDcQFMPeGyxj2toylX/7mH1gDOW+j6W6xU
	dQYzuD0g==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM45-0000000Dwzs-2jzb;
	Sun, 23 Jun 2024 12:11:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 7/8] generic/746: clean up fs support
Date: Sun, 23 Jun 2024 14:10:36 +0200
Message-ID: <20240623121103.974270-8-hch@lst.de>
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

Use a single case statement for fs-specific options and to check if
this test is supported at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/746 | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/tests/generic/746 b/tests/generic/746
index 0e6387fe4..b13fd98a1 100755
--- a/tests/generic/746
+++ b/tests/generic/746
@@ -9,23 +9,32 @@
 . ./common/preamble
 _begin_fstest auto trim fiemap
 
-_supported_fs ext4 xfs btrfs
+_supported_fs generic
 _require_test
 _require_loop
 _require_fstrim
 _require_xfs_io_command "fiemap"
-if [ "$FSTYP" = "btrfs" ]; then
+
+_require_fs_space $TEST_DIR 307200
+fssize=$(_small_fs_size_mb 300)           # 200m phys/virt size
+
+case "$FSTYP" in
+btrfs)
+	_require_btrfs_command inspect-internal dump-super
+	_require_btrfs_command inspect-internal dump-tree
+
 	# 3g for btrfs to have distinct bgs
 	_require_fs_space $TEST_DIR 3145728
 	fssize=3000
-else
-	_require_fs_space $TEST_DIR 307200
-	fssize=$(_small_fs_size_mb 300)           # 200m phys/virt size
-fi
-
-[ "$FSTYP" = "ext4" ] && _require_dumpe2fs
-[ "$FSTYP" = "btrfs" ] && _require_btrfs_command inspect-internal dump-super
-[ "$FSTYP" = "btrfs" ] && _require_btrfs_command inspect-internal dump-tree
+	;;
+ext4)
+	_require_dumpe2fs
+	;;
+xfs)
+	;;
+*)
+	_notrun "Requires fs-specific way to check discard ranges"
+esac
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.43.0


