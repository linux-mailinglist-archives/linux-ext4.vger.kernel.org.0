Return-Path: <linux-ext4+bounces-10117-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56432B58A0F
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 02:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB6E3B89CB
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD85819E98C;
	Tue, 16 Sep 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCJjPdo0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5B8482EB
	for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983792; cv=none; b=E6jjjek4FkHSh2W6fWMVAQuyI1HoxOvBgUF4X+iBBRxzPk9AECX3mZa4JT7IHQU1sI6Vf0vkzM+frpwYnmMIG8xolTy+rr+0XOm0a11tptMYB2+V9Rlncf7bHda7BepH+A817QB89aPRzYVXmsrC3lGVx/xNFrkYScZKACpX2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983792; c=relaxed/simple;
	bh=mJ74ekS9Ht4NFWDJ2POBmeOV5+Z4kY4/gRIBlqBViKE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9hrEqlkVPbFVGr/JYmkA+b8mTUJ74weO9JqltjcVFlevhW87zJ1c1yJXp5k/78aINCo49pf6yxM2xFfkdoQY0MWxdP6Q3kjF5ldDZK1QrOUFE0+a38ZGXNpKXNbc0/jKkFYRFjf1RIpslSdnge35D1vRL8/iu0LRKwIEjpRYig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCJjPdo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EDD0C4CEF1;
	Tue, 16 Sep 2025 00:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983792;
	bh=mJ74ekS9Ht4NFWDJ2POBmeOV5+Z4kY4/gRIBlqBViKE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=oCJjPdo0j48/TgK/WCYlO74n167rgF1lt3EpqcQOJehvzMs7rRYdDvB8eppMT5/Eu
	 nwSKmccsiOjqgCefnEmfpRnVrUlpfTSAnQl97mBIT/ZWLM+/xFdqgMAlslae5scm81
	 tNW+goHlvC7ADRnLyXfB2/Ui5+D5EIWv/V9Umphph/mxWauwALm69+VVuoGoDOk378
	 M4rsUJHIwjT2ucsqQU/+DnHh5bUyfZilfp2Tc7Im+35TZisC3pZLpKBcn0/M5kUaVS
	 OBEtyYzemi6DHSS8THMnhz6F/wvb4pyk+Pkb/0JOU0c+5KJLOJ5KsaGnjM7wEpHWCy
	 7uI/p1E0XGe8Q==
Date: Mon, 15 Sep 2025 17:49:51 -0700
Subject: [PATCH 1/4] fuse2fs: bump library version
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <175798160493.389044.3056000552150112338.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
References: <175798160460.389044.17475177319582767798.stgit@frogsfrogsfrogs>
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


