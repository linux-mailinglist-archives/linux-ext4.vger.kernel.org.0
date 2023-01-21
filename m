Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D2676964
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjAUUhS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjAUUgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2208F29405
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E98E760ADD
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D3EC4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333405;
        bh=G0jzgh7IdyeVDxBwCIN9i7zDEFV94xVS5Dm7rVHXGvg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DgIWQhX0aeqPT2Z52629tb6cjTmogpUQW4d0K7jr+2bQUKxa74nK+NdZ5rftILrWP
         nQ4xvUY9gmknrHLnHB1fjAXJ2ScF2FzDew4byX+wr15Fgjqyub2dNJWWHJWeDDtuj7
         WTL3OKqBf8PvcLJog+v8AHGPmVP1yzuY2/t/VmVXxDBt8377x3z0mDh2gA1J9DkQtQ
         uGAbeG1T6hESgvMW8l/gH8IdDADhBjxSJOlVm81l3D7tXOo21fa/y5qIkMYqD3usio
         hyWhl2cpcoj/OwBQZ2HbQ3cHiuX8092P9oRIHfx8yY3EnQum2Y1HXrVuSP7AToBzXE
         r7f3QvjzU0QyA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 36/38] misc/util.c: enable MinGW alarm() when building for Windows
Date:   Sat, 21 Jan 2023 12:32:28 -0800
Message-Id: <20230121203230.27624-37-ebiggers@kernel.org>
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

To compile for Windows, this file needs MinGW's implementation of
alarm().  To expose that definition, some macros must be defined before
including the system headers.  This was done in Android.bp, but it was
not done in the autotools-based build system.  Define these macros in
the source file itself so that all build systems work.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 misc/Android.bp | 2 --
 misc/util.c     | 5 +++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/misc/Android.bp b/misc/Android.bp
index 2baeac2ad..2b1620ac6 100644
--- a/misc/Android.bp
+++ b/misc/Android.bp
@@ -83,8 +83,6 @@ cc_binary {
         windows: {
             include_dirs: [ "external/e2fsprogs/include/mingw" ],
             cflags: [
-                "-D_POSIX",
-                "-D__USE_MINGW_ALARM",
                 // mke2fs.c has a warning from gcc which cannot be suppressed:
                 // passing argument 3 of 'ext2fs_get_device_size' from
                 // incompatible pointer type
diff --git a/misc/util.c b/misc/util.c
index e84ebab5b..3e83169f1 100644
--- a/misc/util.c
+++ b/misc/util.c
@@ -16,6 +16,11 @@
 #define _LARGEFILE64_SOURCE
 #endif
 
+#ifdef _WIN32
+#define _POSIX
+#define __USE_MINGW_ALARM
+#endif
+
 #include "config.h"
 #include <fcntl.h>
 #include <setjmp.h>
-- 
2.39.0

