Return-Path: <linux-ext4+bounces-11601-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5075BC3DA55
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE893AB91B
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1692A254AFF;
	Thu,  6 Nov 2025 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2Gou+GJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEED30AABC
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762468936; cv=none; b=gqOh8ivpi6r+Nip0c2b2vQsjfTWD6H59qgd0/4KIDHQxn5y0n9QDnQ18vJKLwBtTewQAxMOnCBmmQ9ehUuV8C7cuS7sKJ5km/bEUZRgvm7f77c/0GIdJPw2mA18jK1dxO7V1BuA+ntcMrOZbzEQL9eN9pM14+eq1fYJ+CIEU4U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762468936; c=relaxed/simple;
	bh=mJ74ekS9Ht4NFWDJ2POBmeOV5+Z4kY4/gRIBlqBViKE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+X+cA2bjJwXnsEVR5/59gZXfkRczZvowbSzWVVDmhOB5cnOXnWm7DLFuWMZDbi/xugVozZ1Kav2Mipw6AjWok+wPok7jjkh8P8QFaU0VhK6dnznF0VWi+SxhhuK4cf7Avd23RgNB7pMS2vcIfmKGFyhhOahBV9ZrrkSTBKAy/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2Gou+GJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0517AC4CEF7;
	Thu,  6 Nov 2025 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762468936;
	bh=mJ74ekS9Ht4NFWDJ2POBmeOV5+Z4kY4/gRIBlqBViKE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=o2Gou+GJIJRJtYGgO6z9snEfJsmPbyispq5QQn/nLlIKckGpnmJVPl96Q9pCYHhr1
	 SMha0NxgpeT5rKDiFod8KAcu8N+PAvi1Y7BL8+8CkHQepK0D566O5Ao71uTf72hvJA
	 X8ByC72IM4ZB6D7uGS3CMmXv4Mhfa8em8GX4E98eOw4JbfUh0PLdslvOTxibghQFwo
	 KAV9z/TlYHzqdIFiKwrFTqz1NvsKEp0jOjChCtB9LR2y5zAoJcx5VNyTxwCobyglHg
	 zeMBKxZktw722kcfnRsRkexq00B5jB6qN10chsz987uzI+G802C0hWkVmb2F5o4iUw
	 IfMmAXseMbu9A==
Date: Thu, 06 Nov 2025 14:42:15 -0800
Subject: [PATCH 1/4] fuse2fs: bump library version
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795262.2864102.2395161166327271892.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
References: <176246795228.2864102.6424613500490349959.stgit@frogsfrogsfrogs>
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
index 356644beed651e..71750b1a8ee972 100755
--- a/configure
+++ b/configure
@@ -14687,14 +14687,14 @@ fi
 
 if test "$FUSE_LIB" = "-lfuse3"
 then
-	FUSE_USE_VERSION=35
+	FUSE_USE_VERSION=314
 	CFLAGS="$fuse3_CFLAGS $CFLAGS"
 	FUSE_LIB="$fuse3_LIBS"
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
index f065cd395cf33c..0591999b52b019 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1431,13 +1431,13 @@ AC_SUBST(FUSE_LIB)
 AC_SUBST(FUSE_CMT)
 if test "$FUSE_LIB" = "-lfuse3"
 then
-	FUSE_USE_VERSION=35
+	FUSE_USE_VERSION=314
 	CFLAGS="$fuse3_CFLAGS $CFLAGS"
 	FUSE_LIB="$fuse3_LIBS"
 	AC_CHECK_HEADERS([pthread.h fuse.h], [],
 		[AC_MSG_FAILURE([Cannot find fuse3 fuse2fs headers.])],
 [#define _FILE_OFFSET_BITS	64
-#define FUSE_USE_VERSION 35
+#define FUSE_USE_VERSION 314
 #ifdef __linux__
 #include <linux/fs.h>
 #include <linux/falloc.h>


