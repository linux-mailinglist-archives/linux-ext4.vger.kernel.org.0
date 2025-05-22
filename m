Return-Path: <linux-ext4+bounces-8139-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBD3AC0104
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 02:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 799EB1BC4141
	for <lists+linux-ext4@lfdr.de>; Thu, 22 May 2025 00:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27F5645;
	Thu, 22 May 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD7KFHN4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98440380
	for <linux-ext4@vger.kernel.org>; Thu, 22 May 2025 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747872461; cv=none; b=JfT5PV4tPsoe/Clcl4Ds7ek76hTBrcKjA3iFh37nyFRNxtb0U8ZKU1FHHwm37viSRk1/Jv10QAz4loamfhkT96GtEmONLJsVP+bG+gfoGnjZt6EFWsJDyzMk76pO2PP8ohqyEAI+vmN99UGC6h9j8q/5nVgCWd4ZHfeBoJUHJrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747872461; c=relaxed/simple;
	bh=l0DR+cECVKsWgLemyTEMBeQc3in9jyx6CAtUfOiCnLs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2zudb1qCgagqtjyiuYWSp+9TbSO0zSe6EC/wzL7JRLY05rfoqy8sXYODme1Zyaif+yFxDMA3BXk1YD0uBVjrGkMYTKci2DXYaz46g5ppm2xnpVUlj6ekjbp8zJX75UxRooAGXkze0zqLMMEEQjyVC3hsTYz6MLEbnaTTtZ1ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD7KFHN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D4FC4CEE4;
	Thu, 22 May 2025 00:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747872461;
	bh=l0DR+cECVKsWgLemyTEMBeQc3in9jyx6CAtUfOiCnLs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nD7KFHN45P2D3DNpY/kWCfJMHspDrvzppcIQDty/EPFX/VFDB9HX5u7p7TUDv3SXU
	 8c19eFTDDz2wgVuCNC0uQFZS0yh01xsaDEThSqfpuWe1ixDXzm0WGPLzrB7iwWrSE6
	 n7xYIE9x7HHmxqk4QNUg/Go3HWRvQYSUPNIkTxS5cj4PmpIkQUPtGyR7fjIiNnXGJ+
	 PJF/seh5xn6mjwoJaonhRmRJeL9GvmClpFvqHF2ekOJfvcsWh5NVHnDtoT37/Nm4ye
	 if+GlDWVlVPKLHYAsHbiSwKjNrIqzoK1vxUQVZ22sRPdGN+EObhV9YkHZWDNnVVT1r
	 A5XPsw/g1L+9w==
Date: Wed, 21 May 2025 17:07:40 -0700
Subject: [PATCH 1/3] fuse2fs: bump library version
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <174787197861.1484400.16732577067413839405.stgit@frogsfrogsfrogs>
In-Reply-To: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
References: <174787197833.1484400.960875804610238864.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Bump the library version so we can take advantage of new functionality
since libfuse 3.5.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 configure    |    4 ++--
 configure.ac |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff --git a/configure b/configure
index dfc6bb4a5daa2e..1f7dbe24ee1ab1 100755
--- a/configure
+++ b/configure
@@ -14513,14 +14513,14 @@ fi
 
 if test "$FUSE_LIB" = "-lfuse3"
 then
-	FUSE_USE_VERSION=35
+	FUSE_USE_VERSION=314
 	CFLAGS="$CFLAGS $fuse3_CFLAGS"
 	LDFLAGS="$LDFLAGS $fuse3_LDFLAGS"
 	       for ac_header in pthread.h fuse.h
 do :
   as_ac_Header=`printf "%s\n" "ac_cv_header_$ac_header" | $as_tr_sh`
 ac_fn_c_check_header_compile "$LINENO" "$ac_header" "$as_ac_Header" "#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 35
+#define FUSE_USE_VERSION 314
 #ifdef __linux__
 #include <linux/fs.h>
 #include <linux/falloc.h>
diff --git a/configure.ac b/configure.ac
index 7f28701534a905..c7f193b4ed06bf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1413,13 +1413,13 @@ AC_SUBST(FUSE_LIB)
 AC_SUBST(FUSE_CMT)
 if test "$FUSE_LIB" = "-lfuse3"
 then
-	FUSE_USE_VERSION=35
+	FUSE_USE_VERSION=314
 	CFLAGS="$CFLAGS $fuse3_CFLAGS"
 	LDFLAGS="$LDFLAGS $fuse3_LDFLAGS"
 	AC_CHECK_HEADERS([pthread.h fuse.h], [],
 		[AC_MSG_FAILURE([Cannot find fuse3 fuse2fs headers.])],
 [#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 35
+#define FUSE_USE_VERSION 314
 #ifdef __linux__
 #include <linux/fs.h>
 #include <linux/falloc.h>


