Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A1A676967
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjAUUhb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjAUUgx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A919429147
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F344FCE0923
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27774C4339C
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333406;
        bh=B9R8R3t5HPAhhdCpD8MlmH+F8GSfsOpGUd7azl8fQOo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lr3yH7gZO82KIIcWf3zYwg87Lzrbb5wTG5TdFsB7siJ29LcL6a+ylTO6rM8jeeAvf
         e25hbAyeVLaCSw/Sq5R1yMbD9V8ZjKST+gMWFkmDbnEHXKLT8S8BtvbWLecEi/vriO
         2dSVk75fHbJsZIg+b7LQfhbGAtsMIwlUl1RIExtUlkFaHtCGgTt4pp7pw2EJ3HLqEK
         PVOENDIE92dnbBC3C4Y5LFJK7rLCQLSOUa165lFdK+ZvVvCyqr5fUvz0NV1W6/SnYz
         umoKlTx5tZb2q4cNQF8SUYmLDyuwxvZhPoy1MC2ZWzVz7H0jyuiRDF8lqK6ka8ICsv
         x280nSatBCK9w==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 38/38] Add a configuration file for GitHub Actions
Date:   Sat, 21 Jan 2023 12:32:30 -0800
Message-Id: <20230121203230.27624-39-ebiggers@kernel.org>
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

Add a workflow file for GitHub Actions, with jobs that build and test
e2fsprogs on various platforms with various options.

The workflow is configured to run on pushes only, since e2fsprogs does
not use GitHub pull requests.

This will work on any e2fsprogs fork on Github that has GitHub Actions
enabled.  For example, the results for the testing I've been doing are
at https://github.com/ebiggers/e2fsprogs/actions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 .github/workflows/ci.yml | 116 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 .github/workflows/ci.yml

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
new file mode 100644
index 000000000..29482178d
--- /dev/null
+++ b/.github/workflows/ci.yml
@@ -0,0 +1,116 @@
+name: CI
+on: [push]
+env:
+  DEF_CFLAGS: -O2 -g -Wall
+
+jobs:
+  gcc-build-and-test:
+    name: Build and test with gcc
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - run: ./configure CC=gcc CFLAGS="$DEF_CFLAGS"
+    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 install V=1 DESTDIR=$PWD/installdir
+    - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
+
+  clang-build-and-test:
+    name: Build and test with clang
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - name: Install dependencies
+      run: |
+        sudo apt-get update
+        sudo apt-get install -y clang
+    - run: ./configure CC=clang CFLAGS="$DEF_CFLAGS"
+    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 install V=1 DESTDIR=$PWD/installdir
+    - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
+
+  i386-build-and-test:
+    name: Build and test with gcc -m32
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - name: Install dependencies
+      run: |
+        sudo apt-get update
+        sudo apt-get install -y gcc-multilib
+    - run: ./configure CC=gcc CFLAGS="$DEF_CFLAGS -m32" LDFLAGS="-m32"
+    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -m32 -Werror"
+    - run: make -j8 install V=1 DESTDIR=$PWD/installdir
+    - run: make -j8 uninstall V=1 DESTDIR=$PWD/installdir
+
+  asan-build-and-test:
+    name: Build and test with ASAN enabled
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - name: Install dependencies
+      run: |
+        sudo apt-get update
+        sudo apt-get install -y clang
+    - run: echo "ASAN_CFLAGS=$DEF_CFLAGS -fsanitize=address -fno-sanitize-recover=address" >> $GITHUB_ENV
+    - run: ./configure CC=clang CFLAGS="$ASAN_CFLAGS" LDFLAGS="$ASAN_CFLAGS"
+    - run: make -j8 check V=1 CFLAGS="$ASAN_CFLAGS -Werror"
+
+  ubsan-build-and-test:
+    name: Build and test with UBSAN enabled
+    runs-on: ubuntu-latest
+    steps:
+    - uses: actions/checkout@v2
+    - name: Install dependencies
+      run: |
+        sudo apt-get update
+        sudo apt-get install -y clang
+    - run: echo "UBSAN_CFLAGS=$DEF_CFLAGS -fsanitize=undefined -fno-sanitize-recover=undefined" >> $GITHUB_ENV
+    - run: ./configure CC=clang CFLAGS="$UBSAN_CFLAGS" LDFLAGS="$UBSAN_CFLAGS"
+    - run: make -j8 check V=1 CFLAGS="$UBSAN_CFLAGS -Werror"
+
+  macos-build-and-test:
+    name: Build and test on macOS
+    runs-on: macos-latest
+    steps:
+    - uses: actions/checkout@v2
+    - run: ./configure CFLAGS="$DEF_CFLAGS"
+      # -Wno-error=deprecated-declarations is needed to suppress known warnings
+      # due to e2fsprogs' use of sbrk(0) and daemon().
+    - run: make -j8 check V=1 CFLAGS="$DEF_CFLAGS -Werror -Wno-error=deprecated-declarations"
+    - run: make -j8 install DESTDIR=$PWD/installdir
+    - run: make -j8 uninstall DESTDIR=$PWD/installdir
+
+  windows-msys2-build:
+    name: Build mke2fs on Windows with ${{matrix.sys}}
+    runs-on: windows-latest
+    strategy:
+      matrix:
+        include:
+        - { sys: mingw32, env: i686 }
+        - { sys: mingw64, env: x86_64 }
+    defaults:
+      run:
+        shell: msys2 {0}
+    steps:
+    - uses: actions/checkout@v2
+    - uses: msys2/setup-msys2@v2
+      with:
+        msystem: ${{matrix.sys}}
+        update: true
+        install: >
+          make
+          mingw-w64-${{matrix.env}}-cc
+    # For now the only parts that actually build for Windows are mke2fs and its
+    # dependencies: all libraries except libss.  The build system doesn't want
+    # to build just those parts, though, so do it one step at a time...
+    - run: ./configure CFLAGS="$DEF_CFLAGS"
+    - run: make -j8 subs V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/et/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/uuid/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/blkid/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/ext2fs/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/support/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C lib/e2p/ all V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: make -j8 -C misc/ mke2fs V=1 CFLAGS="$DEF_CFLAGS -Werror"
+    - run: touch image.ext4
+    - run: misc/mke2fs.exe -T ext4 image.ext4 128M
-- 
2.39.0

