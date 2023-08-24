Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0F787C59
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjHYAA0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 20:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbjHYAAA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 20:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C1A1FE4
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 16:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4336C62503
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 23:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E33C433C8;
        Thu, 24 Aug 2023 23:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692921576;
        bh=sD4BYinDPC6Q+0py9qQohW4kgnXP+Dr1S/9j8Oc1ZI0=;
        h=Date:From:To:Cc:Subject:From;
        b=AXvmvfDW46Gm8mcoIslC2w6bwaLEzfBwQYPs9nXizTfFyKy8NA9eQR0hlvffcUR6p
         bbWPPq35PwBxnn45wxlSTzX8+E72oBj1bmFIDujmrg495GKXShLuEhxdYJkok7zr2T
         bnIsZvDcJVDxrMrYIJKcc6l7fpaRuzDoqa0zC/oD/noQAWekbvy+j+xop+EykuN2Hb
         IeHacIGbTT6/NEN3cjU0wEdIvUmHE47+a1EjzI99i4pM8TOzkYmrdR6mZ27csaJKH7
         gwmjR3le6RCrFm+5hDutPNcjwMScVd2a+96xxtek1K3k3jGfQlKnmermGEtvmXclaD
         ni1o8mSsVwW1Q==
Date:   Thu, 24 Aug 2023 16:59:36 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: [PATCH] e2fsprogs: don't allow udisks to automount ext4 filesystems
 with no prompt
Message-ID: <20230824235936.GA17891@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
