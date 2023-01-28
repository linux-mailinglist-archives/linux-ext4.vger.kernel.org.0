Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60CA67FB6C
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 23:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbjA1W6p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 17:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjA1W6n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 17:58:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B17122A03
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:58:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DAE160C26
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7302BC433EF
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674946721;
        bh=2X8lgeo655rQ+0A49CCi05+HuhTOsBXlqkgk7n9JcpY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JDMJeOboAL77rzch9nxHNSoiX1nQwLcSzwyTatX12NuTZXr0x/A6iv5JeAv9lnTjx
         QhRrtSfzqxWC2Up+3We4aMQMtTY5giZn/cwnKkPeCuiGqR1x3jyHx5qcQEQmePXJOh
         RD4PGlc4Y1p2wlR/8ATnFURe3pglwaef1BEeFsNyrminAw65mhTiN0Yu7bfblMos5w
         fV5iEi345vM87016MzHHBQTiKHjArY/E0TEZm1AVJo4PsHCUPHQG/eUZYGJ4UoZ449
         Iv2GPoUTO0z4vtrqLs8QPrysiXA/5o3Eb1bDGPdtohOaNr8L7u9sHk7Rt+cy4YGKGG
         8v3/rE0zhbDXA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/4] ci.yml: ensure -Werror really gets used in all cases
Date:   Sat, 28 Jan 2023 14:46:48 -0800
Message-Id: <20230128224651.59593-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128224651.59593-1-ebiggers@kernel.org>
References: <20230128224651.59593-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

-Werror wasn't actually being used when building the libraries, as the
libraries use CFLAGS_STLIB instead of CFLAGS.

Use CFLAGS_WARN, which gets included in both.

Note: -Werror can't just be passed to 'configure' like the other flags
are, as it interferes with some of the configure checks.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .github/workflows/ci.yml | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 29482178d..97b15bfbb 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -10,7 +10,7 @@ jobs:
     steps:
     - uses: actions/checkout@v2
     - run: ./configure CC=gcc CFLAGS="$DEF_CFLAGS"
-    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror"
     - run: make -j8 install V=1 DESTDIR=$PWD/installdir
     - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
 
@@ -24,7 +24,7 @@ jobs:
         sudo apt-get update
         sudo apt-get install -y clang
     - run: ./configure CC=clang CFLAGS="$DEF_CFLAGS"
-    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror"
     - run: make -j8 install V=1 DESTDIR=$PWD/installdir
     - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
 
@@ -38,7 +38,7 @@ jobs:
         sudo apt-get update
         sudo apt-get install -y gcc-multilib
     - run: ./configure CC=gcc CFLAGS="$DEF_CFLAGS -m32" LDFLAGS="-m32"
-    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -m32 -Werror"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror"
     - run: make -j8 install V=1 DESTDIR=$PWD/installdir
     - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
 
@@ -53,7 +53,7 @@ jobs:
         sudo apt-get install -y clang
     - run: echo "ASAN_CFLAGS=$DEF_CFLAGS -fsanitize=address -fno-sanitize-recover=address" >> $GITHUB_ENV
     - run: ./configure CC=clang CFLAGS="$ASAN_CFLAGS" LDFLAGS="$ASAN_CFLAGS"
-    - run: make -j8 check V=1 CFLAGS="$ASAN_CFLAGS -Werror"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror"
 
   ubsan-build-and-test:
     name: Build and test with UBSAN enabled
@@ -66,7 +66,7 @@ jobs:
         sudo apt-get install -y clang
     - run: echo "UBSAN_CFLAGS=$DEF_CFLAGS -fsanitize=undefined -fno-sanitize-recover=undefined" >> $GITHUB_ENV
     - run: ./configure CC=clang CFLAGS="$UBSAN_CFLAGS" LDFLAGS="$UBSAN_CFLAGS"
-    - run: make -j8 check V=1 CFLAGS="$UBSAN_CFLAGS -Werror"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror"
 
   macos-build-and-test:
     name: Build and test on macOS
@@ -76,7 +76,7 @@ jobs:
     - run: ./configure CFLAGS="$DEF_CFLAGS"
       # -Wno-error=deprecated-declarations is needed to suppress known warnings
       # due to e2fsprogs' use of sbrk(0) and daemon().
-    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror -Wno-error=deprecated-declarations"
+    - run: make -j8 check V=1 CFLAGS_WARN="-Werror -Wno-error=deprecated-declarations"
     - run: make -j8 install DESTDIR=$PWD/installdir
     - run: make -j8 uninstall DESTDIR=$PWD/installdir
 
@@ -104,13 +104,13 @@ jobs:
     # dependencies: all libraries except libss.  The build system doesn't want
     # to build just those parts, though, so do it one step at a time...
     - run: ./configure CFLAGS="$DEF_CFLAGS"
-    - run: make -j8 subs V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/et/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/uuid/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/blkid/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/ext2fs/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/support/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C lib/e2p/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
-    - run: make -j8 -C misc/ mke2fs V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 subs V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/et/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/uuid/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/blkid/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/ext2fs/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/support/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C lib/e2p/ all V=1 CFLAGS_WARN="-Werror"
+    - run: make -j8 -C misc/ mke2fs V=1 CFLAGS_WARN="-Werror"
     - run: touch image.ext4
     - run: misc/mke2fs.exe -T ext4 image.ext4 128M

base-commit: 0352d353adbe6c5d6f1937e12c66e599b8657d72
-- 
2.39.1

