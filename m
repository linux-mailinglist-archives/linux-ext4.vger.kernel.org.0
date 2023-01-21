Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15CD676953
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjAUUhA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjAUUgs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D72914E
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7961F60B7B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41232C433EF
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333401;
        bh=JJxKR1qmF1fpj6MF1LNU0zO21axSqPlQdcLzTLWTYyU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SnMJMRekj8eUv7CSQDBY6RxsiPn5plpXGdJj3A7/bJTa/xtTzPpiDlv4fjHErQcb1
         ykQg7BLKAB8/BhA4wFZDKVXQZ9MFRs4VwgF2QeQQ/AqKtNfhODBkjG3M4J8OhkGrAW
         PBLulBsxt+Unfeqxjf1X5tx6DkGITX3LAHs/Frjp0CPIMv4pgKu3Th8g/wNCFsNQQP
         6+ynXNd3vf2bYn7WMsnYeDQl5eTWpICTutDvlmFQoHfZE1ifY9kJ/OrG3BGApH7SUS
         e7OD5x6NuQzz+wquHc7EM9CL6IE09ulEsT3EzlXg30M7XP+hmaJ3aj7Y6iuKbyjtxT
         Pc/a3pDMPXRXw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 15/38] lib/ext2fs: remove 32-bit x86 bitops assembly
Date:   Sat, 21 Jan 2023 12:32:07 -0800
Message-Id: <20230121203230.27624-16-ebiggers@kernel.org>
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

The EXT2FS_ADDR() macro is causing -Warray-bounds warnings because it
(sort of) dereferences past the end of the input array.  It's not a
"real" dereference, since the result is passed as a memory operand to
inline asm.  But in the C language sense, it is a dereference.

Instead of trying to fix this code, let's consider that libext2fs *only*
implements the bit operations in assembly for 32-bit x86, which is
rarely used anymore.  The fact that compilers have also improved, and no
one has implemented these for another architecture, even x86_64,
suggests it's not useful either.  So, let's just remove this outdated
code, which was maybe useful in the 90s, but now just causes problems.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/ext2fs/bitops.c | 14 +------
 lib/ext2fs/bitops.h | 97 ---------------------------------------------
 2 files changed, 2 insertions(+), 109 deletions(-)

diff --git a/lib/ext2fs/bitops.c b/lib/ext2fs/bitops.c
index c4a1d4e09..ce2acc460 100644
--- a/lib/ext2fs/bitops.c
+++ b/lib/ext2fs/bitops.c
@@ -19,14 +19,8 @@
 #include "ext2_fs.h"
 #include "ext2fs.h"
 
-#ifndef _EXT2_HAVE_ASM_BITOPS_
-
 /*
- * For the benefit of those who are trying to port Linux to another
- * architecture, here are some C-language equivalents.  You should
- * recode these in the native assembly language, if at all possible.
- *
- * C language equivalents written by Theodore Ts'o, 9/26/92.
+ * C language bitmap functions written by Theodore Ts'o, 9/26/92.
  * Modified by Pete A. Zaitcev 7/14/95 to be portable to big endian
  * systems, as well as non-32 bit systems.
  */
@@ -65,8 +59,6 @@ int ext2fs_test_bit(unsigned int nr, const void * addr)
 	return (mask & *ADDR);
 }
 
-#endif	/* !_EXT2_HAVE_ASM_BITOPS_ */
-
 void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
 			const char *description)
 {
@@ -78,9 +70,7 @@ void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
 #endif
 }
 
-/*
- * C-only 64 bit ops.
- */
+/* Bitmap functions that take a 64-bit offset */
 
 int ext2fs_set_bit64(__u64 nr, void * addr)
 {
diff --git a/lib/ext2fs/bitops.h b/lib/ext2fs/bitops.h
index 505b3c9c3..9edf59447 100644
--- a/lib/ext2fs/bitops.h
+++ b/lib/ext2fs/bitops.h
@@ -219,14 +219,6 @@ extern errcode_t ext2fs_find_first_set_generic_bmap(ext2fs_generic_bitmap bitmap
  * functions at all; they will be included as normal functions in
  * inline.c
  */
-#ifdef NO_INLINE_FUNCS
-#if (defined(__GNUC__) && (defined(__i386__) || defined(__i486__) || \
-			   defined(__i586__)))
-	/* This prevents bitops.c from trying to include the C */
-	/* function version of these functions */
-#define _EXT2_HAVE_ASM_BITOPS_
-#endif
-#endif /* NO_INLINE_FUNCS */
 
 #if (defined(INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
 #ifdef INCLUDE_INLINE_FUNCS
@@ -285,90 +277,6 @@ _INLINE_ void ext2fs_fast_clear_bit64(__u64 nr, void * addr)
 	*ADDR &= (unsigned char) ~(1 << (nr & 0x07));
 }
 
-
-#if ((defined __GNUC__) && !defined(_EXT2_USE_C_VERSIONS_) && \
-     (defined(__i386__) || defined(__i486__) || defined(__i586__)))
-
-#define _EXT2_HAVE_ASM_BITOPS_
-#define _EXT2_HAVE_ASM_SWAB_
-
-/*
- * These are done by inline assembly for speed reasons.....
- *
- * All bitoperations return 0 if the bit was cleared before the
- * operation and != 0 if it was not.  Bit 0 is the LSB of addr; bit 32
- * is the LSB of (addr+1).
- */
-
-/*
- * Some hacks to defeat gcc over-optimizations..
- */
-struct __dummy_h { unsigned long a[100]; };
-#define EXT2FS_ADDR (*(struct __dummy_h *) addr)
-#define EXT2FS_CONST_ADDR (*(const struct __dummy_h *) addr)
-
-_INLINE_ int ext2fs_set_bit(unsigned int nr, void * addr)
-{
-	int oldbit;
-
-	addr = (void *) (((unsigned char *) addr) + (nr >> 3));
-	__asm__ __volatile__("btsl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (EXT2FS_ADDR)
-		:"r" (nr & 7));
-	return oldbit;
-}
-
-_INLINE_ int ext2fs_clear_bit(unsigned int nr, void * addr)
-{
-	int oldbit;
-
-	addr = (void *) (((unsigned char *) addr) + (nr >> 3));
-	__asm__ __volatile__("btrl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"+m" (EXT2FS_ADDR)
-		:"r" (nr & 7));
-	return oldbit;
-}
-
-_INLINE_ int ext2fs_test_bit(unsigned int nr, const void * addr)
-{
-	int oldbit;
-
-	addr = (const void *) (((const unsigned char *) addr) + (nr >> 3));
-	__asm__ __volatile__("btl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit)
-		:"m" (EXT2FS_CONST_ADDR),"r" (nr & 7));
-	return oldbit;
-}
-
-_INLINE_ __u32 ext2fs_swab32(__u32 val)
-{
-#ifdef EXT2FS_REQUIRE_486
-	__asm__("bswap %0" : "=r" (val) : "0" (val));
-#else
-	__asm__("xchgb %b0,%h0\n\t"	/* swap lower bytes	*/
-		"rorl $16,%0\n\t"	/* swap words		*/
-		"xchgb %b0,%h0"		/* swap higher bytes	*/
-		:"=q" (val)
-		: "0" (val));
-#endif
-	return val;
-}
-
-_INLINE_ __u16 ext2fs_swab16(__u16 val)
-{
-	__asm__("xchgb %b0,%h0"		/* swap bytes		*/ \
-		: "=q" (val) \
-		:  "0" (val)); \
-		return val;
-}
-
-#undef EXT2FS_ADDR
-
-#endif	/* i386 */
-
-
-#if !defined(_EXT2_HAVE_ASM_SWAB_)
-
 _INLINE_ __u16 ext2fs_swab16(__u16 val)
 {
 	return (val >> 8) | (__u16) (val << 8);
@@ -380,8 +288,6 @@ _INLINE_ __u32 ext2fs_swab32(__u32 val)
 		((val<<8)&0xFF0000) | (val<<24));
 }
 
-#endif /* !_EXT2_HAVE_ASM_SWAB */
-
 _INLINE_ __u64 ext2fs_swab64(__u64 val)
 {
 	return (ext2fs_swab32((__u32) (val >> 32)) |
@@ -691,12 +597,9 @@ _INLINE_ void ext2fs_fast_unmark_block_bitmap_range2(ext2fs_block_bitmap bitmap,
 #undef _INLINE_
 #endif
 
-#ifndef _EXT2_HAVE_ASM_BITOPS_
 extern int ext2fs_set_bit(unsigned int nr,void * addr);
 extern int ext2fs_clear_bit(unsigned int nr, void * addr);
 extern int ext2fs_test_bit(unsigned int nr, const void * addr);
-#endif
-
 extern int ext2fs_set_bit64(__u64 nr,void * addr);
 extern int ext2fs_clear_bit64(__u64 nr, void * addr);
 extern int ext2fs_test_bit64(__u64 nr, const void * addr);
-- 
2.39.0

