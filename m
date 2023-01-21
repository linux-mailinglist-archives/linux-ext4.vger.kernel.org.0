Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B7B676951
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjAUUg6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75582914D
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FF860B6F
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10359C4339B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333401;
        bh=M78gt9zP9T00zp2vGV3Z7oX3MalKPygbcYQUv4SYmTc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=vDnOI5zFKGXdDTNP9yxRoPmdcE3DnAyZ6wDT6xAtHJ5XKFxnhfMCMcqep/uehJPa6
         MxFPk07ndofVA+oNYpmRDefAt3MtBr5J7zBx9hBnVfNlz4Nva6SoEhsWDDxgCfwLLQ
         0O56ySD/MoInsjUaUrcjaDe6l1gIuzQalR5JAChAGQobClHvE1cK/Ce1EQw0yAobAM
         wlx+lXLrQmIhOr5IsCMNdmlbajB94gKcdTzWjwqsnp8C9k/oVm3UQZV62/Z+10k3nW
         0jXED/hpyRZeEGrU1cE19UAyYaJ7Hs5bD56QxwDwAzb8zGM8n/Z2eIH9nbzehvig/R
         HVJsyDxft3XPA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 14/38] lib/et: fix "unused variable" warnings when !HAVE_FCNTL
Date:   Sat, 21 Jan 2023 12:32:06 -0800
Message-Id: <20230121203230.27624-15-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230121203230.27624-1-ebiggers@kernel.org>
References: <20230121203230.27624-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In init_debug(), avoid -Wunused-variable and -Wunused-but-set-variable
warnings when HAVE_FCNTL is not defined by only declaring 'fd' and
'flags' when HAVE_FCNTL is defined.  This affected Windows builds.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/et/Android.bp      |  3 ---
 lib/et/error_message.c | 10 +++++-----
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/et/Android.bp b/lib/et/Android.bp
index 07f3c277e..565feb594 100644
--- a/lib/et/Android.bp
+++ b/lib/et/Android.bp
@@ -31,9 +31,6 @@ cc_library {
     target: {
         windows: {
             enabled: true,
-            cflags: [
-                "-Wno-unused-variable",
-            ],
         },
     },
 
diff --git a/lib/et/error_message.c b/lib/et/error_message.c
index cd9f57f56..8b9474ffa 100644
--- a/lib/et/error_message.c
+++ b/lib/et/error_message.c
@@ -235,7 +235,6 @@ static FILE *debug_f = 0;
 static void init_debug(void)
 {
 	char	*dstr, *fn, *tmp;
-	int	fd, flags;
 
 	if (debug_mask & DEBUG_INIT)
 		return;
@@ -257,10 +256,12 @@ static void init_debug(void)
 	if (!debug_f)
 		debug_f = fopen("/dev/tty", "a");
 	if (debug_f) {
-		fd = fileno(debug_f);
-#if defined(HAVE_FCNTL)
+#ifdef HAVE_FCNTL
+		int fd = fileno(debug_f);
+
 		if (fd >= 0) {
-			flags = fcntl(fd, F_GETFD);
+			int flags = fcntl(fd, F_GETFD);
+
 			if (flags >= 0)
 				flags = fcntl(fd, F_SETFD, flags | FD_CLOEXEC);
 			if (flags < 0) {
@@ -274,7 +275,6 @@ static void init_debug(void)
 #endif
 	} else
 		debug_mask = DEBUG_INIT;
-
 }
 
 /*
-- 
2.39.0

