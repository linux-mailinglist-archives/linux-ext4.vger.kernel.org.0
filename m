Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334D77E4D74
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Nov 2023 00:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbjKGXeY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Nov 2023 18:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344740AbjKGXeK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Nov 2023 18:34:10 -0500
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B0425B3
        for <linux-ext4@vger.kernel.org>; Tue,  7 Nov 2023 15:33:31 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     linux-ext4@vger.kernel.org
Cc:     Mike Gilbert <floppym@gentoo.org>, Sam James <sam@gentoo.org>
Subject: [PATCH e2fsprogs 2/2] lib/ext2fs: llseek: simplify linux section
Date:   Tue,  7 Nov 2023 23:33:22 +0000
Message-ID: <20231107233323.2013334-2-sam@gentoo.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231107233323.2013334-1-sam@gentoo.org>
References: <20231107233323.2013334-1-sam@gentoo.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Mike Gilbert <floppym@gentoo.org>

On 32-bit musl systems, off_t is always 8 bytes regardless of
_FILE_OFFSET_BITS. The previous code did not cover this case.

The previous #ifdef logic was rather confusing, so I reworked it into a
more understandable form.

Bug: https://bugs.gentoo.org/908892
Signed-off-by: Mike Gilbert <floppym@gentoo.org>
Closes: https://github.com/tytso/e2fsprogs/pull/150
Signed-off-by: Sam James <sam@gentoo.org>
---
 lib/ext2fs/llseek.c | 67 ++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/lib/ext2fs/llseek.c b/lib/ext2fs/llseek.c
index 45f21d09..9118b23f 100644
--- a/lib/ext2fs/llseek.c
+++ b/lib/ext2fs/llseek.c
@@ -35,68 +35,32 @@
 
 #ifdef __linux__
 
-#if defined(HAVE_LSEEK64) && defined(HAVE_LSEEK64_PROTOTYPE)
-
-#define my_llseek lseek64
-
-#else
-#if defined(HAVE_LLSEEK)
-#include <sys/syscall.h>
-
-#ifndef HAVE_LLSEEK_PROTOTYPE
-extern long long llseek (int fd, long long offset, int origin);
-#endif
-
-#define my_llseek llseek
-
-#else	/* ! HAVE_LLSEEK */
-
-#if SIZEOF_LONG == SIZEOF_LONG_LONG || _FILE_OFFSET_BITS+0 == 64
-
-#define my_llseek lseek
-
-#else /* SIZEOF_LONG != SIZEOF_LONG_LONG */
-
 #include <linux/unistd.h>
 
-#ifndef __NR__llseek
-#define __NR__llseek            140
-#endif
-
-#ifndef __i386__
-static int _llseek (unsigned int, unsigned long,
-		   unsigned long, ext2_loff_t *, unsigned int);
-
-static _syscall5(int,_llseek,unsigned int,fd,unsigned long,offset_high,
-		 unsigned long, offset_low,ext2_loff_t *,result,
-		 unsigned int, origin);
-#endif
-
 static ext2_loff_t my_llseek (int fd, ext2_loff_t offset, int origin)
 {
-	ext2_loff_t result;
+#if SIZEOF_OFF_T >= 8
+	return lseek(fd, offset, origin);
+#elif HAVE_LSEEK64_PROTOTYPE
+	return lseek64(fd, offset, origin);
+#elif HAVE_LLSEEK_PROTOTYPE
+	return llseek(fd, offset, origin);
+#elif defined(__NR__llseek)
+	loff_t result;
 	int retval;
-
-#ifndef __i386__
-	retval = _llseek(fd, ((unsigned long long) offset) >> 32,
+	retval = syscall(__NR__llseek, fd,
+		(unsigned long)(offset >> 32),
+		(unsigned long)(offset & 0xffffffff),
+		&result, origin);
+	return (retval == -1 ? retval : result);
 #else
-	retval = syscall(__NR__llseek, fd, (unsigned long long) (offset >> 32),
+	errno = ENOSYS;
+	return -1;
 #endif
-			  ((unsigned long long) offset) & 0xffffffff,
-			&result, origin);
-	return (retval == -1 ? (ext2_loff_t) retval : result);
 }
 
-#endif	/* SIZE_LONG == SIZEOF_LONG_LONG */
-
-#endif /* HAVE_LLSEEK */
-#endif /* defined(HAVE_LSEEK64) && defined(HAVE_LSEEK64_PROTOTYPE) */
-
 ext2_loff_t ext2fs_llseek (int fd, ext2_loff_t offset, int origin)
 {
-#if SIZEOF_OFF_T >= SIZEOF_LONG_LONG
-	return my_llseek (fd, offset, origin);
-#else
 	ext2_loff_t result;
 	static int do_compat = 0;
 
@@ -117,7 +81,6 @@ ext2_loff_t ext2fs_llseek (int fd, ext2_loff_t offset, int origin)
 		return -1;
 	}
 	return result;
-#endif
 }
 
 #else /* !linux */
-- 
2.42.1

