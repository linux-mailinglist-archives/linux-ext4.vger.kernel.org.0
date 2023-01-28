Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06CF67FB6B
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 23:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjA1W6p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 17:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjA1W6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 17:58:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A4E233E0
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:58:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACBDC60C53
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2A1C4339E
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674946722;
        bh=S9EG6xTRy0n5rDDtlmHE3JRNqxIsKAYfyqOTfxAeQjM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hB9IjBs1RoQ7jzTklojbEJqQSjf1TVFx3N48qxGuJxDnj6zwPEQle/k7CNJmT5nP1
         26FQZBSdIbNlpQjKHSMAAWAs911iRMQCfOuWp/+13FPq67r+2JVXr2ppL8wpWIufWe
         pdUvC3RAroWZebxbvvlArd5EtUtGUG4KLLJfcZc9lfAqWfIpx7STItZDnmZRNFeF5B
         m84fntQXjeUG94n+OfeIbmqEuHGb2i15aIyP2F3JKmmKucylMtZLoAAueLAS9IjW/D
         yK8+OKXaIxGE34hFt+kBloY5y9yWdkwB6fisCO32SqccKOgTGW1ZT0wWpUKgav2D+U
         IU08VqntRUIAA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 4/4] lib/uuid: remove unneeded Windows UUID workaround
Date:   Sat, 28 Jan 2023 14:46:51 -0800
Message-Id: <20230128224651.59593-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128224651.59593-1-ebiggers@kernel.org>
References: <20230128224651.59593-1-ebiggers@kernel.org>
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

Some .c files in lib/uuid/ contain the following:

	#ifdef _WIN32
	#define _WIN32_WINNT 0x0500
	#include <windows.h>
	#define UUID MYUUID
	#endif

This seems to have been intended to allow the use of a local "UUID" type
without colliding with "UUID" in the Windows API.  However, this is
unnecessary because there's no local "UUID" type -- there's only uuid_t.

None of these .c files need the include of windows.h, either.

Finally, the unconditional definition of _WIN32_WINNT causes a compiler
warning when the user defines _WIN32_WINNT themself.

Since this code is unnecessary and is causing problems, just remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/uuid/Android.bp  | 2 --
 lib/uuid/gen_uuid.c  | 5 -----
 lib/uuid/tst_uuid.c  | 6 ------
 lib/uuid/uuid_time.c | 6 ------
 4 files changed, 19 deletions(-)

diff --git a/lib/uuid/Android.bp b/lib/uuid/Android.bp
index 67968dba3..daf30bb94 100644
--- a/lib/uuid/Android.bp
+++ b/lib/uuid/Android.bp
@@ -45,8 +45,6 @@ cc_library {
     ],
     target: {
         windows: {
-            // Cannot suppress the _WIN32_WINNT redefined warning.
-            cflags: ["-Wno-error"],
             include_dirs: [ "external/e2fsprogs/include/mingw" ],
             enabled: true
         },
diff --git a/lib/uuid/gen_uuid.c b/lib/uuid/gen_uuid.c
index a2225ccee..2f028867a 100644
--- a/lib/uuid/gen_uuid.c
+++ b/lib/uuid/gen_uuid.c
@@ -41,11 +41,6 @@
 
 #include "config.h"
 
-#ifdef _WIN32
-#define _WIN32_WINNT 0x0500
-#include <windows.h>
-#define UUID MYUUID
-#endif
 #include <stdio.h>
 #ifdef HAVE_UNISTD_H
 #include <unistd.h>
diff --git a/lib/uuid/tst_uuid.c b/lib/uuid/tst_uuid.c
index 649bfbc05..c1c290158 100644
--- a/lib/uuid/tst_uuid.c
+++ b/lib/uuid/tst_uuid.c
@@ -34,12 +34,6 @@
 
 #include "config.h"
 
-#ifdef _WIN32
-#define _WIN32_WINNT 0x0500
-#include <windows.h>
-#define UUID MYUUID
-#endif
-
 #include <stdio.h>
 #include <stdlib.h>
 
diff --git a/lib/uuid/uuid_time.c b/lib/uuid/uuid_time.c
index af837a2ca..b519d3c4b 100644
--- a/lib/uuid/uuid_time.c
+++ b/lib/uuid/uuid_time.c
@@ -36,12 +36,6 @@
 
 #include "config.h"
 
-#ifdef _WIN32
-#define _WIN32_WINNT 0x0500
-#include <windows.h>
-#define UUID MYUUID
-#endif
-
 #include <stdio.h>
 #ifdef HAVE_UNISTD_H
 #include <unistd.h>
-- 
2.39.1

