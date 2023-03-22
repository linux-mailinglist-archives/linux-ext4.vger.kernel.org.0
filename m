Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCBE6C410A
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 04:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCVDbE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 23:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjCVDa4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 23:30:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FE1521EB
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 20:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E2A03CE1752
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED269C4339E
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455851;
        bh=66AQ56/04mhYjEyUiKf393oDj5WdENXsAVT0hnBeAag=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HyHaf4t79+JiwCVyJULhLSZcdfDHaNoknsWg4Wz/2asPDxbzD4iMYVcpX9ixGEsSf
         nJE+vMGaIBaTtunFKgXGbcRyr0ebS2NHv4tdXKVa9FkEV2Om1getkGNRIVjJT5iXm2
         x3RWYHBDkWiy7zyveevJfoHfIAIPNDXTmnhixpIskD0GWpVMW4Jyi+D5LXXo3Q3Wqx
         PeMY5HPCtsaYgGulRfNCB3B9is/lvsTIPiU0mF7ILm/68E1jggwzOIZ3VlEhIqvJK0
         ru+24GIm4PP1nZo4rv+vg04FHn1SiMPsAMlI2XJyEvmuPekr+YjaCw3ReYVcLzdCqs
         +niF4S9ilnSwg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 3/3] ci.yml: test cross-compiling for Android
Date:   Tue, 21 Mar 2023 20:29:45 -0700
Message-Id: <20230322032945.31779-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322032945.31779-1-ebiggers@kernel.org>
References: <20230322032945.31779-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add jobs that cross-compile e2fsprogs for Android using the Android NDK.
These use the autotools-based build system, so they're a bit different
from the actual Android builds, but they should still be useful.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .github/workflows/ci.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 6b0f91506..0c14250a4 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -126,3 +126,36 @@ jobs:
       with:
         name: windows-${{matrix.env}}-config.h
         path: lib/config.h
+
+  # Jobs that cross-compile e2fsprogs for Android using the Android NDK.  Note
+  # that these use the autotools-based build system, which makes them a bit
+  # different from the actual Android builds from the Android source tree.
+  cross-compile-for-android:
+    name: Cross-compile for Android (${{matrix.arch}})
+    strategy:
+      matrix:
+        include:
+        - { arch: aarch64, target: aarch64-linux-android }
+        - { arch: armv7a, target: armv7a-linux-androideabi }
+        - { arch: i686, target: i686-linux-android }
+        - { arch: x86_64, target: x86_64-linux-android }
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v3
+    # See https://developer.android.com/ndk/guides/other_build_systems#autoconf
+    - name: configure
+      run: |
+        TOOLCHAIN=$ANDROID_NDK_LATEST_HOME/toolchains/llvm/prebuilt/linux-x86_64
+        API_LEVEL=29 # Android 10
+        export AR=$TOOLCHAIN/bin/llvm-ar
+        export CC=$TOOLCHAIN/bin/${{matrix.target}}${API_LEVEL}-clang
+        export AS=$CC
+        export LD=$TOOLCHAIN/bin/ld
+        export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
+        export STRIP=$TOOLCHAIN/bin/llvm-strip
+        ./configure --host=${{matrix.target}} CFLAGS="$DEF_CFLAGS"
+    - run: make -j8 V=1 CFLAGS_WARN="-Werror"
+    - uses: actions/upload-artifact@v3
+      with:
+        name: android-${{matrix.arch}}-config.h
+        path: lib/config.h
-- 
2.40.0

