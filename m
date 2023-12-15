Return-Path: <linux-ext4+bounces-473-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F20D5815406
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 23:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B2FDB21754
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 22:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80B18EB8;
	Fri, 15 Dec 2023 22:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr+mGJVF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F52218EAC
	for <linux-ext4@vger.kernel.org>; Fri, 15 Dec 2023 22:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A91EC433C7;
	Fri, 15 Dec 2023 22:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702680976;
	bh=slOznQaAdlKxRyFGZYrnK6ZcEMDD98cl2AyFxTj2SEc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=nr+mGJVFJmuuLV6joOKmRVaXv9CzxvEPe1uuvMJymTtNpGg+Z+2CRh5FSJZzVOgXR
	 GiTlySmS3/5Zclh3ECxbWiXw4AdfqIXb7qvMk6HQMFpGbI7idvjyADDWcjK4ObEMl2
	 +XA4FUTqiTkJtwsYbIL5bTZDkbIk01Zgn9WjCXyvm80P+UFMBjQaeeB5pM9TSbrc6i
	 PPaT6gVzemtdbe5DIuaAYI/hl4rQ40TiKKCrtbZ0PpYLWX4Ouy6DhoNQSVJ/nHZFRg
	 9q/ulQzFUjZwzn/ZoQ2btx2XHShk1qMiD+mXBScKJx1/boUyWb63Y0wN5AxOkCKS/u
	 xtGEaCwi9vCUw==
Date: Fri, 15 Dec 2023 14:56:16 -0800
Subject: [PATCH 2/2] e2fsprogs: don't allow udisks to automount ext4
 filesystems with no prompt
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Message-ID: <170268089768.2679199.6471937911328594372.stgit@frogsfrogsfrogs>
In-Reply-To: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The unending stream of syzbot bug reports and overwrought filing of CVEs
for corner case handling (i.e. things that distract from actual user
complaints) in ext4 has generated all sorts of of overheated rhetoric
about how every bug is a Serious Security Issue(tm) because anyone can
craft a malicious filesystem on a USB stick, insert the stick into a
victim machine, and mount will trigger a bug in the kernel driver that
leads to some compromise or DoS or something.

I thought that nobody would be foolish enough to automount an ext4
filesystem.  What a fool I was!  It turns out that udisks can be told
that it's okay to automount things, and then GNOME will do exactly that.
Including mounting mangled ext4 filesystems!

<delete angry rant about poor decisionmaking and armchair fs developers
blasting us on X while not actually doing any of the work>

Turn off /this/ idiocy by adding a udev rule to tell udisks not to
automount ext4 filesystems.

This will not stop a logged in user from unwittingly inserting a
malicious storage device and pressing [mount] and getting breached.
This is not a substitute for a thorough audit of all codebases.  This is
not a substitute for lklfuse.  This does not solve the general problem
of in-kernel fs drivers being a huge attack surface.  I just want a
vacation from the sh*tstorm of bad ideas and threat models that I never
agreed to support.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 scrub/Makefile.in   |   12 ++++++++++--
 scrub/ext4.rules.in |   13 +++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 scrub/ext4.rules.in


diff --git a/scrub/Makefile.in b/scrub/Makefile.in
index 387f6504..d0c5c11b 100644
--- a/scrub/Makefile.in
+++ b/scrub/Makefile.in
@@ -18,6 +18,7 @@ CONFFILES=	e2scrub.conf
 
 ifeq ($(HAVE_UDEV),yes)
 UDEV_RULES	= e2scrub.rules
+UDISKS_RULES	= ext4.rules
 INSTALLDIRS_TGT	+= installdirs-udev
 INSTALL_TGT	+= install-udev
 UNINSTALL_TGT	+= uninstall-udev
@@ -39,7 +40,7 @@ INSTALL_TGT	+= install-systemd install-libprogs
 UNINSTALL_TGT	+= uninstall-systemd uninstall-libprogs
 endif
 
-all:: $(PROGS) $(MANPAGES) $(CONFFILES) $(UDEV_RULES) $(SERVICE_FILES) $(CRONTABS) $(LIBPROGS)
+all:: $(PROGS) $(MANPAGES) $(CONFFILES) $(UDEV_RULES) $(UDISKS_RULES) $(SERVICE_FILES) $(CRONTABS) $(LIBPROGS)
 
 e2scrub: $(DEP_SUBSTITUTE) e2scrub.in
 	$(E) "	SUBST $@"
@@ -111,6 +112,10 @@ install-udev: installdirs-udev
 		$(ES) "	INSTALL $(UDEV_RULES_DIR)/$$i"; \
 		$(INSTALL_DATA) $$i $(DESTDIR)$(UDEV_RULES_DIR)/96-$$i; \
 	done
+	$(Q) for i in $(UDISKS_RULES); do \
+		$(ES) "	INSTALL $(UDEV_RULES_DIR)/$$i"; \
+		$(INSTALL_DATA) $$i $(DESTDIR)$(UDEV_RULES_DIR)/64-$$i; \
+	done
 
 install-crond: installdirs-crond
 	$(Q) if test -n "$(CRONTABS)" ; then \
@@ -153,6 +158,9 @@ uninstall-udev:
 	for i in $(UDEV_RULES); do \
 		$(RM) -f $(DESTDIR)$(UDEV_RULES_DIR)/96-$$i; \
 	done
+	for i in $(UDISKS_RULES); do \
+		$(RM) -f $(DESTDIR)$(UDEV_RULES_DIR)/64-$$i; \
+	done
 
 uninstall-crond:
 	if test -n "$(CRONTABS)" ; then \
@@ -181,7 +189,7 @@ uninstall: $(UNINSTALL_TGT)
 	done
 
 clean::
-	$(RM) -f $(PROGS) $(MANPAGES) $(CONFFILES) $(UDEV_RULES) $(SERVICE_FILES) $(CRONTABS) $(LIBPROGS)
+	$(RM) -f $(PROGS) $(MANPAGES) $(CONFFILES) $(UDEV_RULES) $(UDISKS_RULES) $(SERVICE_FILES) $(CRONTABS) $(LIBPROGS)
 
 mostlyclean: clean
 distclean: clean
diff --git a/scrub/ext4.rules.in b/scrub/ext4.rules.in
new file mode 100644
index 00000000..6fe5a7a8
--- /dev/null
+++ b/scrub/ext4.rules.in
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright (C) 2023 Oracle.  All rights reserved.
+# Author: Darrick J. Wong <djwong@kernel.org>
+#
+# Don't let udisks automount ext4 filesystems without even asking a user.
+# This doesn't eliminate filesystems as an attack surface; it only prevents
+# evil maid attacks when all sessions are locked.
+#
+# According to http://storaged.org/doc/udisks2-api/latest/udisks.8.html,
+# supplying UDISKS_AUTO=0 here changes the HintAuto property of the block
+# device abstraction to mean "do not automatically start" (e.g. mount).
+SUBSYSTEM=="block", ENV{ID_FS_TYPE}=="ext2|ext3|ext4|ext4dev|jbd", ENV{UDISKS_AUTO}="0"


