Return-Path: <linux-ext4+bounces-10319-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 018F0B8D209
	for <lists+linux-ext4@lfdr.de>; Sun, 21 Sep 2025 00:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E181B24378
	for <lists+linux-ext4@lfdr.de>; Sat, 20 Sep 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D3E1FFC7B;
	Sat, 20 Sep 2025 22:52:09 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from omta004.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49921AE844
	for <linux-ext4@vger.kernel.org>; Sat, 20 Sep 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.97.99.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758408729; cv=none; b=imV7yaLWx3CGubRqaxHbfDTS8JcQCrxD3dNtEqqVdiSfGImHmv73+V3S2p8Nmz4oVHjcf4d0fd8HAPJxez/L2DYuKE4Tzk8khOuZmYGLy/Ll/6B2RDVJ4KmqFdO7MeinAKI8VJm7t8j2A2Jr2AvfEmYzeKMaBe0Ksk2DPCAHUfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758408729; c=relaxed/simple;
	bh=HbZRebVSLZ2ZAhTPgLiDDIZG66/IB6HKN+iU9fCSESg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FZ6cyWIZlmih9JXV5KfnTBdZh0MQKvw8MFz3fBNiCvdtxaYeUXcLryysLOBTUz3dsArGWcYw1MLX6Cl4PqhSZodXK6iO0TOLmyCoXwQ1vm+hnfPYvuruF/ZZGEzLgKtLZx6RhsDOgJ5RhzGpK3Mb70nn/wNu+jJKTLdDaxEtPDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; arc=none smtp.client-ip=3.97.99.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: from shw-obgw-4004a.ext.cloudfilter.net ([10.228.9.227])
	by cmsmtp with ESMTPS
	id zyhFuENN2PzKy06PWvo3Vp; Sat, 20 Sep 2025 22:50:30 +0000
Received: from cabot.adilger.int ([70.77.200.158])
	by cmsmtp with ESMTP
	id 06PVv7PNnJhBP06PWvVS42; Sat, 20 Sep 2025 22:50:30 +0000
X-Authority-Analysis: v=2.4 cv=QY3Fvdbv c=1 sm=1 tr=0 ts=68cf2fb6
 a=0Thh8+fbYSyN3T2vM72L7A==:117 a=0Thh8+fbYSyN3T2vM72L7A==:17 a=RPJ6JBhKAAAA:8
 a=pW_UiiHLKQQn-clGnroA:9 a=fa_un-3J20JGBB2Tu-mn:22
From: Andreas Dilger <adilger@dilger.ca>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH] doc: fix mke2fs.8 Extended Options formatting
Date: Sat, 20 Sep 2025 16:50:30 -0600
Message-Id: <20250920225030.29470-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
X-CMAE-Envelope: MS4xfJqZfB9Omswl6CNHbnok5AO59aerMzOlZOd3y6CQaIJTCHibk3vouhN0pfBm9nAbEJYGV+QDv1J5p2kz/cRFUYL41TtVZNcQM2nGvrcEaTFjoFJ7aE8F
 diL/cEmmlfkDAYcu6wdtUXTzqhZc9eJySAtfItJIvmAvHMwougG67ExsdY7p8MSPTb7KxDMefx3YYGi1oO5adci5P2EXMUX2V89HWfRVVeJqz9VOtFN6JpxC
 dtunxghRAdKIxX5O+M7m3A==
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

The two consecutive .TP macros cause bad formatting for the
remaining options.  Remove one.

Signed-off-by: Andreas Dilger <adilger@dilger.ca>
---
 misc/mke2fs.8.in | 1 -
 1 file changed, 1 deletion(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 13ddef47baa3..4532a33079a6 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -369,7 +369,6 @@ be 0, 1, or 2 backup superblocks created in the file system.
 Create the file system at an offset from the beginning of the device or
 file.  This can be useful when creating disk images for virtual machines.
 .TP
-.TP
 .BI orphan_file_size= size
 Set size of the file for tracking unlinked but still open inodes and inodes
 with truncate in progress. Larger file allows for better scalability, reserving
-- 
2.14.3 (Apple Git-98)


