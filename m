Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF48E676956
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjAUUhC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680329157
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61A6660B7F
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE496C4339B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333402;
        bh=biRELdgM3R8+fJoxOyh4m11cf4MkKzKLRr029v4SWCI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eIoZ9d+DoTRYjPLaw1hpknbgKnpPJMUXnAsTXIDcm6GjMuqkMBvNixZ6hI8xeMkKo
         s0I9FRx0L8tn1wOB43t2VjQFUQ8KPYibCYNrTxH7P32HfY+90PgR3jDpCLKeFa+66b
         mM7MQS15uWVvbclB6RQERwYvI8TZTm8ycOwsHvQo1k9MkSMWLAlfHzmnxd7wGtoM2C
         2kNZJRFmc1xkvLVtXTNZ1b+jQbYIxyTPQ2P3ZtCd9tFHfN2Vnz0zlCicm21kb9icoM
         sXf2pqX03VYaOm+Rd57mm1L2+ac/tedtr27dq1Dxs0+/MBKKfkWPouAv95EO7lWhFH
         K24f2TRpsenWw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 22/38] lib/ss: fix 'make install' by creating man1dir
Date:   Sat, 21 Jan 2023 12:32:14 -0800
Message-Id: <20230121203230.27624-23-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

'make install' does not work because libss tries to install a man page
without creating the directory first.  Fix this.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ss/Makefile.in | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/ss/Makefile.in b/lib/ss/Makefile.in
index 40294db0b..bb5041893 100644
--- a/lib/ss/Makefile.in
+++ b/lib/ss/Makefile.in
@@ -125,10 +125,11 @@ ss.pc: $(srcdir)/ss.pc.in $(top_builddir)/config.status
 	$(Q) cd $(top_builddir); CONFIG_FILES=lib/ss/ss.pc ./config.status
 
 installdirs::
-	$(E) "	MKDIR_P $(libdir) $(includedir)/ss $(datadir)/ss $(bindir)"
+	$(E) "	MKDIR_P $(libdir) $(includedir)/ss $(datadir)/ss $(bindir) $(pkgconfigdir) $(man1dir)"
 	$(Q) $(MKDIR_P) $(DESTDIR)$(libdir) \
 		$(DESTDIR)$(includedir)/ss $(DESTDIR)$(datadir)/ss \
-		$(DESTDIR)$(bindir) $(DESTDIR)$(pkgconfigdir)
+		$(DESTDIR)$(bindir) $(DESTDIR)$(pkgconfigdir) \
+		$(DESTDIR)$(man1dir)
 
 install:: libss.a $(INSTALL_HFILES) installdirs ss_err.h mk_cmds ss.pc
 	$(E) "	INSTALL_DATA $(DESTDIR)$(libdir)/libss.a"
-- 
2.39.0

