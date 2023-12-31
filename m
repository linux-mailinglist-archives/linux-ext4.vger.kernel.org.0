Return-Path: <linux-ext4+bounces-585-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AE820DD8
	for <lists+linux-ext4@lfdr.de>; Sun, 31 Dec 2023 21:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8652824B2
	for <lists+linux-ext4@lfdr.de>; Sun, 31 Dec 2023 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1290BA31;
	Sun, 31 Dec 2023 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnNsYJlE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF9BA22
	for <linux-ext4@vger.kernel.org>; Sun, 31 Dec 2023 20:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D38C433C7;
	Sun, 31 Dec 2023 20:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704055143;
	bh=00Y7g+olzX4bppVZYA1ttdwIS+tHcsXT9ycYWSH7Kk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnNsYJlEcpPPekBjBK33Lkcb7/bHvyu3ejoH4oMUfxENek+lBKYzi44OYkbsj/u7A
	 LMw+XQE+nu3g2ihZAOTJD5okSVmY++cEqrGvUpH7pzeXRlytQB5XgDMlH5Gg9sXill
	 h5R6S57vmdGyTCCKKeTn4Vg6MNgn6ZCnsPz7YMw3t+aRJzPfJmyyy9FqIf+ZKxhfuN
	 baUv6tE6Ftr+nOVV6sWLvtzBl3zD/2KhPucRXRHw8JyXsAAeG08QH/2SjkIcMMDs5P
	 lNoRGI2EWa4ob2qTqo+oBbCoPPm2HEmIyhLwMkWu1SRjw2kDs9AWxOFJpLoRYf7cyg
	 VD5m/7R2KJQYg==
Date: Sun, 31 Dec 2023 12:39:03 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, Neal Gompa <neal@gompa.dev>
Subject: [PATCH 3/2] e2scrub_fail: move executable script to /usr/libexec
Message-ID: <20231231203903.GC36164@frogsfrogsfrogs>
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

Per FHS 3.0, non-PATH executable binaries are supposed to live under
/usr/libexec, not /usr/lib.  e2scrub_fail is an executable script, so
move it to libexec in case some distro some day tries to mount /usr/lib
as noexec or something.  Also, there's no reason why these scripts need
to be put under an arch-dependent path.

Cc: Neal Gompa <neal@gompa.dev>
Link: https://refspecs.linuxfoundation.org/FHS_3.0/fhs/ch04s07.html
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 MCONFIG.in                     |    2 +-
 debian/e2fsprogs.install       |    4 ++--
 scrub/Makefile.in              |   10 +++++-----
 scrub/e2scrub_all.cron.in      |    2 +-
 scrub/e2scrub_fail@.service.in |    2 +-
 util/subst.conf.in             |    2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/MCONFIG.in b/MCONFIG.in
index 82c75a28..2b1872fa 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -34,7 +34,7 @@ man8dir = $(mandir)/man8
 infodir = @infodir@
 datadir = @datadir@
 pkgconfigdir = $(libdir)/pkgconfig
-pkglibdir = $(libdir)/e2fsprogs
+pkglibexecdir = @libexecdir@/e2fsprogs
 
 HAVE_UDEV = @have_udev@
 UDEV_RULES_DIR = @pkg_udev_rules_dir@
diff --git a/debian/e2fsprogs.install b/debian/e2fsprogs.install
index 8cf07a6f..b50078d3 100755
--- a/debian/e2fsprogs.install
+++ b/debian/e2fsprogs.install
@@ -16,8 +16,8 @@ sbin/resize2fs
 sbin/tune2fs
 usr/bin/chattr
 usr/bin/lsattr
-[linux-any] usr/lib/*/e2fsprogs/e2scrub_all_cron
-[linux-any] usr/lib/*/e2fsprogs/e2scrub_fail
+[linux-any] usr/libexec/e2fsprogs/e2scrub_all_cron
+[linux-any] usr/libexec/e2fsprogs/e2scrub_fail
 usr/sbin/e2freefrag
 [linux-any] usr/sbin/e4crypt
 [linux-any] usr/sbin/e4defrag
diff --git a/scrub/Makefile.in b/scrub/Makefile.in
index d0c5c11b..c97a1dd5 100644
--- a/scrub/Makefile.in
+++ b/scrub/Makefile.in
@@ -95,8 +95,8 @@ installdirs-crond:
 	$(Q) $(MKDIR_P) $(DESTDIR)$(CROND_DIR)
 
 installdirs-libprogs:
-	$(E) "	MKDIR_P $(pkglibdir)"
-	$(Q) $(MKDIR_P) $(DESTDIR)$(pkglibdir)
+	$(E) "	MKDIR_P $(pkglibexecdir)"
+	$(Q) $(MKDIR_P) $(DESTDIR)$(pkglibexecdir)
 
 installdirs-systemd:
 	$(E) "	MKDIR_P $(SYSTEMD_SYSTEM_UNIT_DIR)"
@@ -125,8 +125,8 @@ install-crond: installdirs-crond
 
 install-libprogs: $(LIBPROGS) installdirs-libprogs
 	$(Q) for i in $(LIBPROGS); do \
-		$(ES) "	INSTALL $(pkglibdir)/$$i"; \
-		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(pkglibdir)/$$i; \
+		$(ES) "	INSTALL $(pkglibexecdir)/$$i"; \
+		$(INSTALL_PROGRAM) $$i $(DESTDIR)$(pkglibexecdir)/$$i; \
 	done
 
 install-systemd: $(SERVICE_FILES) installdirs-systemd
@@ -169,7 +169,7 @@ uninstall-crond:
 
 uninstall-libprogs:
 	for i in $(LIBPROGS); do \
-		$(RM) -f $(DESTDIR)$(pkglibdir)/$$i; \
+		$(RM) -f $(DESTDIR)$(pkglibexecdir)/$$i; \
 	done
 
 uninstall-systemd:
diff --git a/scrub/e2scrub_all.cron.in b/scrub/e2scrub_all.cron.in
index 395fb2ab..8e2640d4 100644
--- a/scrub/e2scrub_all.cron.in
+++ b/scrub/e2scrub_all.cron.in
@@ -1,2 +1,2 @@
-30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=1 @pkglibdir@/e2scrub_all_cron
+30 3 * * 0 root test -e /run/systemd/system || SERVICE_MODE=1 @pkglibexecdir@/e2scrub_all_cron
 10 3 * * * root test -e /run/systemd/system || SERVICE_MODE=1 @root_sbindir@/e2scrub_all -A -r
diff --git a/scrub/e2scrub_fail@.service.in b/scrub/e2scrub_fail@.service.in
index ae65a1da..462daee2 100644
--- a/scrub/e2scrub_fail@.service.in
+++ b/scrub/e2scrub_fail@.service.in
@@ -4,7 +4,7 @@ Documentation=man:e2scrub(8)
 
 [Service]
 Type=oneshot
-ExecStart=@pkglibdir@/e2scrub_fail "%f"
+ExecStart=@pkglibexecdir@/e2scrub_fail "%f"
 User=mail
 Group=mail
 SupplementaryGroups=systemd-journal
diff --git a/util/subst.conf.in b/util/subst.conf.in
index 0da45541..5af5e356 100644
--- a/util/subst.conf.in
+++ b/util/subst.conf.in
@@ -23,4 +23,4 @@ root_sbindir		@root_sbindir@
 root_bindir		@root_bindir@
 libdir			@libdir@
 $exec_prefix		@exec_prefix@
-pkglibdir		@libdir@/e2fsprogs
+pkglibexecdir		@libexecdir@/e2fsprogs

