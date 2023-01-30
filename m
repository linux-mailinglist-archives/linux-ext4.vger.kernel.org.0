Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF0D681D8F
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jan 2023 22:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjA3V6u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Jan 2023 16:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjA3V6t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Jan 2023 16:58:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDED955BA
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 13:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C102B816AA
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 21:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D017C433D2
        for <linux-ext4@vger.kernel.org>; Mon, 30 Jan 2023 21:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675115926;
        bh=IEkR+ORMT6+6WywS/Pc5QonUeN2iLsVYX0k1DYBMx0c=;
        h=From:To:Subject:Date:From;
        b=ii7QNjk5TPEMHw2Leonyg4VtH5pKUTWOrOa4WmwkBfpF+nMmDAPA0VatnrT3jbjrs
         wBNh3ACx0ApPwe2HXQy0QnJ/aeZDfO/FnW/M87aG56pwkfb5xN7O2pWP9V4L62sE9B
         VIYk0BN/yS31QjVecIZ7UAtfjj1OLA+YLD1zXQryK+VVY8mxe2cMDKFv0gT7qTGKD6
         gC7Xhr27zhFxhZM+E6HsYWppEdzG806prvodUaQvoGbNv7n/eIVitHVoQhuxmb6FVI
         3N0Z9DVVe4YMjY6YMVb3xDeGsehSU39sn+HkipVwyV1TzizpaKPU1s3bvEZmm2NGT3
         2BsNvZ9q0DgTA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH] lib/support: don't assume qsort_r() is always available on Linux
Date:   Mon, 30 Jan 2023 21:58:29 +0000
Message-Id: <20230130215829.863455-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
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

Since commit 4e5f24ae4267 ("Use an autoconf test to detect for a BSD- or
GNU-style qsort_r function"), e2fsck fails to build for Android because
lib/support/sort_r.h assumes that qsort_r() is always available on
"Linux", but in fact it's not supported by Android's libc.

Rename _SORT_R_LINUX to _SORT_R_GNU to clarify that it's really the
glibc convention for qsort_r(), not the "Linux" convention per se, and
make sort_r.h stop setting it automatically when __linux__ is defined.

Note: this change does *not* prevent glibc's qsort_r() from being used
when e2fsprogs is built using the autotools-based build system, as
'configure' checks for qsort_r() too.  This change just affects the
fallback behavior for when qsort_r() was not already detected.

Fixes: 4e5f24ae4267 ("Use an autoconf test to detect for a BSD- or GNU-style qsort_r function")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/support/sort_r.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/support/sort_r.h b/lib/support/sort_r.h
index ebf78378..8473ca83 100644
--- a/lib/support/sort_r.h
+++ b/lib/support/sort_r.h
@@ -25,12 +25,12 @@ void sort_r(void *base, size_t nel, size_t width,
 #define _SORT_R_INLINE inline
 
 #if (defined HAVE_GNU_QSORT_R)
-#  define _SORT_R_LINUX
+#  define _SORT_R_GNU
 #elif (defined HAVE_BSD_QSORT_R)
 #  define _SORT_R_BSD
 #elif (defined __gnu_hurd__ || defined __GNU__ || \
-       defined __linux__ || defined __MINGW32__ || defined __GLIBC__)
-#  define _SORT_R_LINUX
+       defined __MINGW32__ || defined __GLIBC__)
+#  define _SORT_R_GNU
 #elif (defined __APPLE__ || defined __MACH__ || defined __DARWIN__ || \
      defined __FreeBSD__ || defined __DragonFly__)
 #  define _SORT_R_BSD
@@ -264,7 +264,7 @@ static _SORT_R_INLINE void sort_r_simple(void *base, size_t nel, size_t w,
 
   #endif
 
-  #if defined _SORT_R_LINUX
+  #if defined _SORT_R_GNU
 
     typedef int(* __compar_d_fn_t)(const void *, const void *, void *);
     extern void qsort_r(void *base, size_t nel, size_t width,
@@ -280,7 +280,7 @@ static _SORT_R_INLINE void sort_r_simple(void *base, size_t nel, size_t w,
                                                   const void *_b, void *_arg),
                                     void *arg)
   {
-    #if defined _SORT_R_LINUX
+    #if defined _SORT_R_GNU
 
       #if defined __GLIBC__ && ((__GLIBC__ < 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ < 8))
 
@@ -319,7 +319,7 @@ static _SORT_R_INLINE void sort_r_simple(void *base, size_t nel, size_t w,
 
 #undef _SORT_R_INLINE
 #undef _SORT_R_WINDOWS
-#undef _SORT_R_LINUX
+#undef _SORT_R_GNU
 #undef _SORT_R_BSD
 
 #endif /* SORT_R_H_ */

base-commit: b0101535a35c07975227128875204fab07e72996
-- 
2.39.1.456.gfc5497dd1b-goog

