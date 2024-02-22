Return-Path: <linux-ext4+bounces-1356-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168D785F500
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 10:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C537428B376
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Feb 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63616383BA;
	Thu, 22 Feb 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SGMMX+tU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6D3838B;
	Thu, 22 Feb 2024 09:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595430; cv=none; b=cuucCXjH/BiJUPXaLTdTuytRDgFgJDuaa23+xSjTHf8ZPH3YV71Muu9s/Oy1mYDmuYjnUc7a0uFNz1I7zIy62De085nNFP6fKI6jOdHh72ptzasdSyJRoGHRzV0iT6G6OUnbsSrjA++ypP+P9JXWKUFeaXlGqSw8mR5BObwQwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595430; c=relaxed/simple;
	bh=wuS36pgyjSNs/ogediuzQ/fu3+v3MZF+PzsLiJWfCaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXO1azEauqScAfhw1mjGUyHHx0RrOMDnAY87iIzLfOXbwo+Or1PnhYuD0AXuaaO5buqMKF0HGU8G3EBwiOuBstvper9g8J5ePJ54rh/QX1JXrRWLr+gzlfMJ1rUq/pJbfcoA1YQVf9Szsa5AwWzCPc3mrGTnKcJAfLYwShhbmp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SGMMX+tU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 89452C0005;
	Thu, 22 Feb 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708595425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hGYuUJFgrI15CK+VXlL89d6fj/B/fl7Hd4ibHpQQ3KA=;
	b=SGMMX+tUc+sP2bykHxfLsuxEN+EsguNYlYz7vz798IulInkM0flyvlMsF1z01uuwex3ITm
	vF6ey8B9W4r4C/osNoMy6FcxX/h5fu9rXHDl/AHyBMjBI53qgaVzY3f5nyN1r9vMad7OH1
	Wlu+RWr/ByatFEApwGI6+PoCJz/DC8cph17OyqdD/0J0Lf1vCePfGbqbJkk9t1hzRWpYdx
	+XWaaqmgC5SPNoKerh6O/cBJXMIYJRortoGzoMO3a+LwPkZHmA5mJYo7J+jMcouJl6eQEC
	1unoDOE9SLCFktt6TJ3cD/X0Jp0kRE/NxbsAsihec4zQ2SY0eMriskHURHo+iQ==
From: michael.opdenacker@bootlin.com
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] ext2: mark as deprecated
Date: Thu, 22 Feb 2024 10:50:01 +0100
Message-Id: <20240222095001.137660-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: michael.opdenacker@bootlin.com

From: Michael Opdenacker <michael.opdenacker@bootlin.com>

Add a DEPRECATED keyword to the kernel parameter description,
to warn users that this filesystem doesn't support dates beyond 2038.

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 fs/ext2/Kconfig | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ext2/Kconfig b/fs/ext2/Kconfig
index 74d98965902e..49e4660ae436 100644
--- a/fs/ext2/Kconfig
+++ b/fs/ext2/Kconfig
@@ -1,16 +1,30 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config EXT2_FS
-	tristate "Second extended fs support"
+	tristate "Second extended fs support (DEPRECATED)"
 	select BUFFER_HEAD
 	select FS_IOMAP
 	select LEGACY_DIRECT_IO
 	help
 	  Ext2 is a standard Linux file system for hard disks.
 
-	  To compile this file system support as a module, choose M here: the
-	  module will be called ext2.
+	  It is deprecated because even if the filesystem is created with
+	  256 byte inodes (mkfs.ext2 -I 256), the filesystem driver will stick
+	  to 32 bit dates. Because of this, this filesystem does not support
+	  dates beyond 03:14:07 UTC on 19 January 2038.
 
-	  If unsure, say Y.
+	  Ext2 users are advised to migrate their partitions to ext4:
+
+	  $ tune2fs -O extents,uninit_bg,dir_index,has_journal /dev/sda1
+	  $ e2fsck -pf /dev/sda1
+
+	  Ext4 is also a working solution for very small partitions
+	  as it can be created without a journal:
+
+	  $ mkfs.ext4 -O ^has_journal /dev/sda1
+
+	  This code is kept as a simple reference for filesystem developers.
+
+	  If unsure, say N.
 
 config EXT2_FS_XATTR
 	bool "Ext2 extended attributes"
-- 
2.34.1


