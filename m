Return-Path: <linux-ext4+bounces-8764-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C24AF096D
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 05:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465CC1C2072A
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Jul 2025 03:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002991E261F;
	Wed,  2 Jul 2025 03:51:05 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D5B1DE881
	for <linux-ext4@vger.kernel.org>; Wed,  2 Jul 2025 03:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751428264; cv=none; b=JeAXH9bJDLys83y7XroSNmyZTHpvgZHjUvHmGDNgfpG88YRqiuCoU/AIjgj9aLAC5aZ7x5/6dbKTwPAlf2MR66fcGXvcZkFHDw69bAuaWo9BBjOBPf6ZME2ghd64hyThw05MuJqAJIBEfyDFaLXf5ZSJ216vkjbbBP1apTVI3M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751428264; c=relaxed/simple;
	bh=TyKsrs4z0nYC5XSxWpu3AfXs/99DTNb3CO+ru5rhiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jox+mQ3Dd4zWDWA5IQ/RucTBg7erQbsS58OVCN+Z/89vo+BQ+WUTWZpgnX4gxSP938JrKdm7CftVAU5ay6Ez/HKWuiq32wqEOWBfUFk/mLGsrD1UMtobuOKQ8OU0cw3xehh90P59w3y29zo5qwfNjeIT5xMPk1tOd/JIWGcjejM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-121.bstnma.fios.verizon.net [108.26.156.121])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5623ope8025209
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Jul 2025 23:50:52 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9A0292E00D6; Tue, 01 Jul 2025 23:50:51 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] fuse2fs.1: fix formatting of newly added options in the man page
Date: Tue,  1 Jul 2025 23:50:44 -0400
Message-ID: <20250702035044.47373-2-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702035044.47373-1-tytso@mit.edu>
References: <20250702035044.47373-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 misc/fuse2fs.1.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/fuse2fs.1.in b/misc/fuse2fs.1.in
index d485ccbdc..21f576074 100644
--- a/misc/fuse2fs.1.in
+++ b/misc/fuse2fs.1.in
@@ -54,7 +54,7 @@ do not replay the journal and mount the file system read-only
 \fB-o\fR fuse2fs_debug
 enable fuse2fs debugging
 .TP
-.BR -o kernel
+\fB-o\fR kernel
 Behave more like the kernel ext4 driver in the following ways:
 Allows processes owned by other users to access the filesystem.
 Uses the kernel's permissions checking logic instead of fuse2fs's.
@@ -63,10 +63,10 @@ Note that these options can still be overridden (e.g.
 .I nosuid
 ) later.
 .TP
-.BR -o direct
+\fB-o\fR direct
 Use O_DIRECT to access the block device.
 .TP
-.BR -o cache_size
+\fB-o\fR cache_size
 Set the disk cache size to this quantity.
 The quantity may contain the suffixes k, m, or g.
 By default, the size is 32MB.
-- 
2.47.2


