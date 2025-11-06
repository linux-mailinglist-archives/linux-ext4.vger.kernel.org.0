Return-Path: <linux-ext4+bounces-11607-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98615C3DA83
	for <lists+linux-ext4@lfdr.de>; Thu, 06 Nov 2025 23:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92D374E5977
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Nov 2025 22:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1815A2FB985;
	Thu,  6 Nov 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVql+dKX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07262F83C5
	for <linux-ext4@vger.kernel.org>; Thu,  6 Nov 2025 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469032; cv=none; b=RGCluVldJ7AoWgYPpzja2fDQmpw5UnQsFztjrgZRo4OIwpdAGmXB6vaBkdqa3fawl25esGQaYA1ua0GVdKrw6C8zyxc0ZQKIH7SXXND+RgPXm943ygYKVn36wKZkq/ph3NzEr0Bg2Vm7yWTYWwH9vNSMkMQqiGDUyji+ce1a3NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469032; c=relaxed/simple;
	bh=5KAvIxe5nDFE5H1Ai+vu/6fP5neo5ARLDPuVhO5HFEM=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NW2oRfA+Tq0Ud/nz5EnsZr+C61rPLBC8tlXK3+c7Q75SbMAcimyEbExDLs4cuKsXWWaAgGqaBFv2meiK44fHg8tojFLAPO/V2j36qSNeQ4NCunnM80yqvQGiE1p6X0+4uMsLa8Lj2f3HTctyKD+Yo+HvufB1Sk1PuYqeEZUNMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVql+dKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EBAC16AAE;
	Thu,  6 Nov 2025 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469032;
	bh=5KAvIxe5nDFE5H1Ai+vu/6fP5neo5ARLDPuVhO5HFEM=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=HVql+dKX+O0failhUtITHoSoz7UqbUSmsvM9ou58OhPd91fuoSynX0746/x8rE/WH
	 Yn+virDuAV11ekGr9HtdX9XZxo9IWqsUwueoE2L/PEtawz35FxPnA6hBQFdvppeVDQ
	 iTaN1s6sNfSw6TUs2zT/rI2sNXhnRn15ES6s+ilEbXQH6W+CI9Zc5IE490wXEJo0Rv
	 k4N9kg3HMZoarBzleT41GX5BPMHpucpwOUs5bj1H8S1Vc1WUVhB9YiPIRnxwcGJdcx
	 b7prkW0ao8GuDL1B2Hp9FTLewtCPcZUTcCosDuGr2G+vkjqVBXvtPzPnCvrnJUDtE1
	 8Oj2fNaYdwYZg==
Date: Thu, 06 Nov 2025 14:43:51 -0800
Subject: [PATCH 03/23] debian: create new package for fuse4fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <176246795621.2864310.812685734936596808.stgit@frogsfrogsfrogs>
In-Reply-To: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
References: <176246795459.2864310.10641701647593035148.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new package for fuse4fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debian/control         |   12 +++++++++++-
 debian/fuse4fs.install |    2 ++
 debian/fuse4fs.links   |    3 +++
 debian/rules           |   11 +++++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 debian/fuse4fs.install
 create mode 100644 debian/fuse4fs.links


diff --git a/debian/control b/debian/control
index fb3487cd32b99a..04df691d81b230 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: e2fsprogs
 Section: admin
 Priority: important
 Maintainer: Theodore Y. Ts'o <tytso@mit.edu>
-Build-Depends: dpkg-dev (>= 1.22.5), gettext, texinfo, pkgconf, libarchive-dev <!nocheck>, libfuse3-dev [linux-any kfreebsd-any] <!pkg.e2fsprogs.no-fuse2fs>, debhelper-compat (= 12), dh-exec, libblkid-dev, uuid-dev, m4, udev [linux-any], systemd [linux-any], systemd-dev [linux-any], cron [linux-any], dh-sequence-movetousr
+Build-Depends: dpkg-dev (>= 1.22.5), gettext, texinfo, pkgconf, libarchive-dev <!nocheck>, libfuse3-dev [linux-any kfreebsd-any] <!pkg.e2fsprogs.no-fuse2fs> <!pkg.e2fsprogs.no-fuse4fs>, debhelper-compat (= 12), dh-exec, libblkid-dev, uuid-dev, m4, udev [linux-any], systemd [linux-any], systemd-dev [linux-any], cron [linux-any], dh-sequence-movetousr
 Rules-Requires-Root: no
 Standards-Version: 4.7.2
 Homepage: http://e2fsprogs.sourceforge.net
@@ -21,6 +21,16 @@ Description: ext2 / ext3 / ext4 file system driver for FUSE
  writing from devices or image files containing ext2, ext3, and ext4
  file systems.
 
+Package: fuse4fs
+Build-Profiles: <!pkg.e2fsprogs.no-fuse4fs>
+Priority: optional
+Depends: ${shlibs:Depends}, ${misc:Depends}, fuse3
+Architecture: linux-any kfreebsd-any
+Description: ext2 / ext3 / ext4 file system driver for FUSE
+ fuse4fs is a faster FUSE file system client that supports reading and
+ writing from devices or image files containing ext2, ext3, and ext4
+ file systems.
+
 Package: fuseext2
 Build-Profiles: <!pkg.e2fsprogs.no-fuse2fs>
 Depends: fuse2fs (>= 1.47.1-2), ${misc:Depends}
diff --git a/debian/fuse4fs.install b/debian/fuse4fs.install
new file mode 100644
index 00000000000000..17bdc90e33cb67
--- /dev/null
+++ b/debian/fuse4fs.install
@@ -0,0 +1,2 @@
+usr/bin/fuse4fs
+usr/share/man/man1/fuse4fs.1
diff --git a/debian/fuse4fs.links b/debian/fuse4fs.links
new file mode 100644
index 00000000000000..825017e11b951e
--- /dev/null
+++ b/debian/fuse4fs.links
@@ -0,0 +1,3 @@
+/usr/bin/fuse4fs          /usr/bin/ext4
+/usr/bin/fuse4fs          /usr/bin/ext3
+/usr/bin/fuse4fs          /usr/bin/ext2
diff --git a/debian/rules b/debian/rules
index c88675c9228bd0..b680eb33ceac9e 100755
--- a/debian/rules
+++ b/debian/rules
@@ -12,6 +12,7 @@ export LC_ALL ?= C
 
 ifeq ($(DEB_HOST_ARCH_OS), hurd)
 SKIP_FUSE2FS=yes
+SKIP_FUSE4FS=yes
 endif
 
 ifeq ($(DEB_HOST_ARCH_OS), linux)
@@ -22,6 +23,9 @@ endif
 ifneq ($(filter pkg.e2fsprogs.no-fuse2fs,$(DEB_BUILD_PROFILES)),)
 SKIP_FUSE2FS=yes
 endif
+ifneq ($(filter pkg.e2fsprogs.no-fuse4fs,$(DEB_BUILD_PROFILES)),)
+SKIP_FUSE4FS=yes
+endif
 
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
@@ -60,6 +64,9 @@ COMMON_CONF_FLAGS = --enable-elf-shlibs --disable-ubsan \
 ifneq ($(SKIP_FUSE2FS),)
 COMMON_CONF_FLAGS +=  --disable-fuse2fs
 endif
+ifneq ($(SKIP_FUSE4FS),)
+COMMON_CONF_FLAGS +=  --disable-fuse4fs
+endif
 
 ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
 CC ?= $(DEB_HOST_GNU_TYPE)-gcc
@@ -189,6 +196,10 @@ endif
 ifeq ($(SKIP_FUSE2FS),)
 	dh_shlibdeps -pfuse2fs -l${stdbuilddir}/lib \
 		-- -Ldebian/e2fsprogs.shlibs.local
+endif
+ifeq ($(SKIP_FUSE4FS),)
+	dh_shlibdeps -pfuse4fs -l${stdbuilddir}/lib \
+		-- -Ldebian/e2fsprogs.shlibs.local
 endif
 	dh_shlibdeps --remaining-packages -l${stdbuilddir}/lib
 


