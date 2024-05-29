Return-Path: <linux-ext4+bounces-2716-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1203F8D3E28
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 20:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF471F21FF6
	for <lists+linux-ext4@lfdr.de>; Wed, 29 May 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8875139588;
	Wed, 29 May 2024 18:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaFS3Qjo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0415B562
	for <linux-ext4@vger.kernel.org>; Wed, 29 May 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717006335; cv=none; b=SXhwU81xa41d3x18KLkqRtD+M571NmYZqciTcbEtysXvg7FQYYuKSMTeOydm76jDtOZEyQ9gmQpi5lpFvjOjbCYi1Pz2PHtMfNnkS/N2LDlxRSYFD6ZbrTiorsmIM1nRAwsCozEW9DFpL7dDI/xhzG521BkyCEs4fNmOmm/LyR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717006335; c=relaxed/simple;
	bh=/RywZShKPlclj5xK/MJ05qfgRf4DKfHi2ZPi+ASENIk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TxeVvvGOgUilrA9c5EhFVhPDXc71K2AfrxVDWjuqiP7Qh6E12R+sjJk3yz5Kjs8GVijiyMVCeq5zIPbaQ6LXcTAV/edDYkTqIVj7CAdtwBAWJq7sPJTT/g/1HdEiX+ezCGgxZAGIorqsugmAAye+Q50c4JvHWnq1lGLN7XpyJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaFS3Qjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA3AC113CC;
	Wed, 29 May 2024 18:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717006334;
	bh=/RywZShKPlclj5xK/MJ05qfgRf4DKfHi2ZPi+ASENIk=;
	h=Date:From:To:Subject:From;
	b=IaFS3QjoRVcSTfuXBvm8atMAmkwpjdEZHMnhTqV7KO91HPWeeFEVSuJqnSY3rvntQ
	 7dmYwHLmeIu+1k6o0scgN3O3ad6so2iJyjRn8cWtbGl9VxrCoulk+uw6mzWR5FQq1G
	 jLojNhOowu2RpLh3EiiiqALLPBTSDf0eDnKvKedBUgmwS5YvyGT2vj8ZkyMxkeBgoG
	 erw4Lwz6hzN4JWd7Wl2syqaFSP5AUno/VFzM2n4sKaYOOLA2Fum6N/Y5AQbAOek1Jk
	 14dhkCIwtyVecuy5FzROQS/sCXSf0c3yijFpcCadM2iiaeUl2uDDy7zJ0XZ4m2zn00
	 Vj8e8IPehFduQ==
Date: Wed, 29 May 2024 11:12:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>, linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] fuse2fs: explicitly set _FILE_OFFSET_BITS again
Message-ID: <20240529181214.GA52969@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

In commit 3ab99d9b602, the build system was changed not to set
_FILE_OFFSET_BITS explicitly due to some weird error on mips64el.
Unfortunately, this breaks the aarch64 Debian build because libfuse
2.9.9 requires this value to be set explicitly.  Restore this dumb
preprocessor symbol dependency with even more hackery as documented in
the commit.

Fixes: 3ab99d9b602 ("Remove explicit #define of _FILE_OFFSET_BITS")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 misc/fuse2fs.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index 56a0d545..01293868 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -26,7 +26,23 @@
 #endif
 #include <sys/ioctl.h>
 #include <unistd.h>
+#ifdef __SET_FOB_FOR_FUSE
+# error Do not set magic value __SET_FOB_FOR_FUSE!!!!
+#endif
+#ifndef _FILE_OFFSET_BITS
+/*
+ * Old versions of libfuse (e.g. Debian 2.9.9 package) required that the build
+ * system set _FILE_OFFSET_BITS explicitly, even if doing so isn't required to
+ * get a 64-bit off_t.  AC_SYS_LARGEFILE doesn't set any _FILE_OFFSET_BITS if
+ * it's not required (such as on aarch64), so we must inject it here.
+ */
+# define __SET_FOB_FOR_FUSE
+# define _FILE_OFFSET_BITS 64
+#endif /* _FILE_OFFSET_BITS */
 #include <fuse.h>
+#ifdef __SET_FOB_FOR_FUSE
+# undef _FILE_OFFSET_BITS
+#endif /* __SET_FOB_FOR_FUSE */
 #include <inttypes.h>
 #include "ext2fs/ext2fs.h"
 #include "ext2fs/ext2_fs.h"

