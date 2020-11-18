Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262002B80F1
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgKRPl7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbgKRPl6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E2EC0613D6
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id f5so1403153pfa.18
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JxnBQe88GuM4rIndOAjxTgYOiO3eiDXcKskI+rG/+KI=;
        b=pLOuQcrASmKWhw907+WAg4vizEODBbT5/xBrU5Qj6k+QZTgsYannD7PloWovrvTJL9
         Xs0U5XSw6D9z0A44heOuqZKxCdCexP7kfLD2imZIYbd2N9nKxIwfrTBQc/gCM/2cGgXA
         zDsnMEuBRPz8QAEpT2Qyw4Apjo9ZqJC1QBz9T8LxdlmHyNmIJet+2WUMnE1W4Nz3WNtA
         LiyDRx9sJuAgJacovVT21l6A+xVlpGj2mvlk6vJVNXx9XCs0kUzyWLQp/q6tleAB/KVL
         b4e2TJqCHxOQbhfapbDcKtBH3O7OoEonhOvF51IEDVKTPo+q9bQd23qZdbIqK0EMMfYK
         mX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JxnBQe88GuM4rIndOAjxTgYOiO3eiDXcKskI+rG/+KI=;
        b=ALPdrEZK9gZW7bSePBJNQkSm6BWb8zjOlvk7UCVgbZ2iwzLvsAgkVnrrf3acx8lRAN
         4tO360GWNiwDX6n37G2Uy0ovaOcfdRKR1wJdnU7IYoi34QnrotlAidNAoh0WapaJAw3Q
         UGVCVPabdSI1eYJeswmF+inRzDXNY9bOHF8mjiVAVolH/ox9Lvv/3hMrJKE6C/muhtJW
         m+yqafn4byfiuBKlHOa6VJ7fUVK6CQMQQ4PXKy3BY41Z8xLJV6XZHMeLSZB2TS31USmA
         vkgqKawdvf+41vIcBz4NYSHz0bLQDPvVeDCeXTomMlBhajYOy7wTMvko1qoj6KavqptG
         XeVg==
X-Gm-Message-State: AOAM530AZebbr9xCCmKJGl2FfH2sVZcKmVCbTnFVUOoYVqmAsF4sPuKF
        pjhMdX5G5udfYNdvF4UxJBjA7u9tp7JnTCS0moFmgqiyabSyTVA1+SIib0pQTNotbuoH9ZoPfNe
        8q6L7c24azVdsN4U+AAKfZ9Tf0M2fdRmSdGpoG7oBZL0NpPm6x95HQHbX92+0SRCVel7uTRODDV
        2xTaZpgjw=
X-Google-Smtp-Source: ABdhPJw5M/pssc0+RyTdq9zuIB9H2G4AgUOhKSAk8p01NbynalVUMbedC52CStU3pU1kjHSPHeYvzo2b2XzNz6ZWaFw=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a17:902:c154:b029:d6:efa5:4ce7 with
 SMTP id 20-20020a170902c154b02900d6efa54ce7mr4893452plj.73.1605714117781;
 Wed, 18 Nov 2020 07:41:57 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:35 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-50-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 49/61] e2fsck: fix build for make rpm
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

link e2fsck with -lpthread properly to make rpm pass.

Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 MCONFIG.in         | 1 +
 e2fsck/Makefile.in | 9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/MCONFIG.in b/MCONFIG.in
index 0598f21b..a85e24f1 100644
--- a/MCONFIG.in
+++ b/MCONFIG.in
@@ -146,6 +146,7 @@ DEPLIBUUID = @DEPLIBUUID@
 DEPLIBSUPPORT = $(LIB)/libsupport@STATIC_LIB_EXT@
 DEPLIBBLKID = @DEPLIBBLKID@ @PRIVATE_LIBS_CMT@ $(DEPLIBUUID)
 TESTENV = LD_LIBRARY_PATH="$(LIB):$${LD_LIBRARY_PATH}" DYLD_LIBRARY_PATH="$(LIB):$${DYLD_LIBRARY_PATH}"
+SEM_INIT_LIB = @SEM_INIT_LIB@
 
 STATIC_LIBSS = $(LIB)/libss@STATIC_LIB_EXT@ @DLOPEN_LIB@
 STATIC_LIBCOM_ERR = $(LIB)/libcom_err@STATIC_LIB_EXT@ @SEM_INIT_LIB@
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index 6e25d27d..0ec11952 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -16,20 +16,21 @@ MANPAGES=	e2fsck.8
 FMANPAGES=	e2fsck.conf.5
 
 LIBS= $(LIBSUPPORT) $(LIBEXT2FS) $(LIBCOM_ERR) $(LIBBLKID) $(LIBUUID) \
-	$(LIBINTL) $(LIBE2P) $(LIBMAGIC) $(SYSLIBS)
+	$(LIBINTL) $(LIBE2P) $(LIBMAGIC) $(SYSLIBS) $(SEM_INIT_LIB)
 DEPLIBS= $(DEPLIBSUPPORT) $(LIBEXT2FS) $(DEPLIBCOM_ERR) $(DEPLIBBLKID) \
 	 $(DEPLIBUUID) $(DEPLIBE2P)
 
 STATIC_LIBS= $(STATIC_LIBSUPPORT) $(STATIC_LIBEXT2FS) $(STATIC_LIBCOM_ERR) \
 	     $(STATIC_LIBBLKID) $(STATIC_LIBUUID) $(LIBINTL) $(STATIC_LIBE2P) \
-	     $(LIBMAGIC) $(SYSLIBS)
+	     $(LIBMAGIC) $(SYSLIBS) $(SEM_INIT_LIB)
 STATIC_DEPLIBS= $(DEPSTATIC_LIBSUPPORT) $(STATIC_LIBEXT2FS) \
 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBBLKID) \
 		$(DEPSTATIC_LIBUUID) $(DEPSTATIC_LIBE2P)
 
 PROFILED_LIBS= $(PROFILED_LIBSUPPORT) $(PROFILED_LIBEXT2FS) \
 	       $(PROFILED_LIBCOM_ERR) $(PROFILED_LIBBLKID) $(PROFILED_LIBUUID) \
-	       $(PROFILED_LIBE2P) $(LIBINTL) $(LIBMAGIC) $(SYSLIBS)
+	       $(PROFILED_LIBE2P) $(LIBINTL) $(LIBMAGIC) $(SYSLIBS) \
+	       $(SEM_INIT_LIB)
 PROFILED_DEPLIBS= $(DEPPROFILED_LIBSUPPORT) $(PROFILED_LIBEXT2FS) \
 		  $(DEPPROFILED_LIBCOM_ERR) $(DEPPROFILED_LIBBLKID) \
 		  $(DEPPROFILED_LIBUUID) $(DEPPROFILED_LIBE2P)
@@ -115,7 +116,7 @@ all-static:: e2fsck.static
 
 e2fsck: $(OBJS)  $(DEPLIBS)
 	$(E) "	LD $@"
-	$(Q) $(LD) $(ALL_LDFLAGS) $(RDYNAMIC) -o e2fsck $(OBJS) $(LIBS) 
+	$(Q) $(LD) $(ALL_LDFLAGS) $(RDYNAMIC) -o e2fsck $(OBJS) $(LIBS)
 
 e2fsck.static: $(OBJS) $(STATIC_DEPLIBS)
 	$(E) "	LD $@"
-- 
2.29.2.299.gdc1121823c-goog

