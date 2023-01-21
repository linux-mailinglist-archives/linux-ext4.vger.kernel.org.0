Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD7676941
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjAUUgm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUUgl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A3128D32
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B4960B6A
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FCD3C433A4
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333399;
        bh=HX09Cuo3sj19yD8wnataeATkDbzkFtj6TJWC2V9XPIc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uYK9Ybb9I7MRM7DKODLzf3D4azE9ezFH8wlQXSZ1fn0XX8nobVsK4SF0I+8kH0FXi
         9lZkWeAfZeVujd2DnO3zVyDNP3qYb902BsjO+cR+O9g+koxBHNkixL9wPzdeXeKQeI
         /TzWwQO93ytSUNTkiZyQm+xDzOXK8KIAIhxTQaVRQ+xLkrwI9lUiIXRD23uG93GpBB
         /qTqo/b3JWIfvovv3ak8kNNYywLtirRhPmISF6H5UCDbL5amAU8Ck7whO9VouI2EGQ
         6mlnwFaH36abt2WoVx8DDBMeyBXjhG/HnVZcVfGtUX+pYS5evBf9UVZOPZpypKEcll
         5fNDfoQCS+tVQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 06/38] lib, misc: eliminate dependency on Winsock
Date:   Sat, 21 Jan 2023 12:31:58 -0800
Message-Id: <20230121203230.27624-7-ebiggers@kernel.org>
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

Currently Windows builds of e2fsprogs rely on the Windows Socket API
(Winsock) to provide htonl() and ntohl().  For this to actually work,
though, HAVE_WINSOCK_H needs to be defined, and the binaries need to be
linked to -lws2_32.  The Android.bp files do this; however, the
autotools-based build system does not.

Since htonl() and ntohl() are trivial, let's instead just add a file
include/mingw/arpa/inet.h with definitions for these.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/mingw/arpa/inet.h | 5 +++++
 lib/e2p/Android.bp        | 4 ----
 lib/ext2fs/Android.bp     | 2 --
 lib/ext2fs/jfs_compat.h   | 4 ----
 misc/Android.bp           | 1 -
 util/android_config.h     | 1 -
 6 files changed, 5 insertions(+), 12 deletions(-)
 create mode 100644 include/mingw/arpa/inet.h

diff --git a/include/mingw/arpa/inet.h b/include/mingw/arpa/inet.h
new file mode 100644
index 000000000..55dfa3691
--- /dev/null
+++ b/include/mingw/arpa/inet.h
@@ -0,0 +1,5 @@
+#pragma once
+
+/* Windows is always little endian. */
+#define htonl	__builtin_bswap32
+#define ntohl	__builtin_bswap32
diff --git a/lib/e2p/Android.bp b/lib/e2p/Android.bp
index 6f0620af0..050d869b3 100644
--- a/lib/e2p/Android.bp
+++ b/lib/e2p/Android.bp
@@ -59,10 +59,6 @@ cc_library {
                 "-Wno-unused-variable",
                 "-Wno-error=typedef-redefinition",
             ],
-
-            host_ldlibs: [
-                "-lws2_32",
-            ],
         },
     },
 
diff --git a/lib/ext2fs/Android.bp b/lib/ext2fs/Android.bp
index 365ca709f..eb4482d79 100644
--- a/lib/ext2fs/Android.bp
+++ b/lib/ext2fs/Android.bp
@@ -126,8 +126,6 @@ cc_library {
                 "-Wno-unused-variable",
                 "-Wno-error=typedef-redefinition",
             ],
-
-            host_ldlibs: ["-lws2_32"],
         },
     },
 
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index e11cf494e..0e96b56c1 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -7,11 +7,7 @@
 #ifdef HAVE_NETINET_IN_H
 #include <netinet/in.h>
 #endif
-#ifdef HAVE_WINSOCK_H
-#include <winsock.h>
-#else
 #include <arpa/inet.h>
-#endif
 #include <stdbool.h>
 
 #define printk printf
diff --git a/misc/Android.bp b/misc/Android.bp
index 78e18e420..2baeac2ad 100644
--- a/misc/Android.bp
+++ b/misc/Android.bp
@@ -91,7 +91,6 @@ cc_binary {
                 "-Wno-error"
             ],
             ldflags: ["-static"],
-            host_ldlibs: ["-lws2_32"],
             enabled: true
         },
         android: {
diff --git a/util/android_config.h b/util/android_config.h
index 6ac16fec1..90b8f8a8f 100644
--- a/util/android_config.h
+++ b/util/android_config.h
@@ -36,7 +36,6 @@
 
 #if defined(_WIN32)
 # define HAVE_LINUX_TYPES_H 1
-# define HAVE_WINSOCK_H 1
 #endif
 #if defined(__APPLE__) || defined(__linux__)
 # define HAVE_FCNTL 1
-- 
2.39.0

