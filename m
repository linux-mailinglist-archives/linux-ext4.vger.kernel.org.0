Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B9267694C
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Jan 2023 21:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjAUUgx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 21 Jan 2023 15:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjAUUgr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 21 Jan 2023 15:36:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6811D2914B
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 12:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E3C1B80880
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A120FC433A7
        for <linux-ext4@vger.kernel.org>; Sat, 21 Jan 2023 20:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674333399;
        bh=whuH9yPE9amH85pSRITB4jYCMo0rheLcLtdVhHG7Hys=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=se023mMtw7kiavtRInQkp0DCu741IFudNClGUlnCC+Cg3oAoIpTRR5Xl37rHAl5du
         QRROlYJATJCZMhBmYIu7VoO1t06cKaUKjNTRFNHUPJ4CFBPSXYYjgXcAKds8HMYlKL
         n99iAZ1LAk0imUyooq9fmhuPj+M6Ufq0mIZLKgK96MKAB99z6w8ddpHD9gPHnHlmI8
         uMLk9Jk6gubyAZGUWlAb6H5SckWgSqcs+/XFdEOeom6zgjMlth5/v35iSrJquSUuSd
         HQTfZ/P1WwRxW0E9w6XxHUnfCT69jYcoIIVfH9GKA5Acd8dep0qnlkfzcDAmNiKU2Z
         xaP7GwifDH7lA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 07/38] lib/blkid: remove 32-bit x86 byteswap assembly
Date:   Sat, 21 Jan 2023 12:31:59 -0800
Message-Id: <20230121203230.27624-8-ebiggers@kernel.org>
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

libblkid contains 32-bit x86 assembly language implementations of 16-bit
and 32-bit byteswaps.  However, modern compilers can easily generate the
bswap instruction automatically from the corresponding C expression.
And no one ever bothered to add assembly for x86_64 or other
architectures, anyway.  So let's just remove this outdated code, which
was maybe useful in the 90s, but is no longer useful.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/blkid/probe.h | 43 -------------------------------------------
 1 file changed, 43 deletions(-)

diff --git a/lib/blkid/probe.h b/lib/blkid/probe.h
index dea4081d0..063a5b5c0 100644
--- a/lib/blkid/probe.h
+++ b/lib/blkid/probe.h
@@ -814,46 +814,6 @@ struct exfat_entry_label {
 #define _INLINE_ static inline
 #endif
 
-static __u16 blkid_swab16(__u16 val);
-static __u32 blkid_swab32(__u32 val);
-static __u64 blkid_swab64(__u64 val);
-
-#if ((defined __GNUC__) && \
-     (defined(__i386__) || defined(__i486__) || defined(__i586__)))
-
-#define _BLKID_HAVE_ASM_BITOPS_
-
-_INLINE_ __u32 blkid_swab32(__u32 val)
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
-_INLINE_ __u16 blkid_swab16(__u16 val)
-{
-	__asm__("xchgb %b0,%h0"		/* swap bytes		*/ \
-		: "=q" (val) \
-		:  "0" (val)); \
-		return val;
-}
-
-_INLINE_ __u64 blkid_swab64(__u64 val)
-{
-	return (blkid_swab32(val >> 32) |
-		(((__u64) blkid_swab32(val & 0xFFFFFFFFUL)) << 32));
-}
-#endif
-
-#if !defined(_BLKID_HAVE_ASM_BITOPS_)
-
 _INLINE_  __u16 blkid_swab16(__u16 val)
 {
 	return (val >> 8) | (val << 8);
@@ -870,9 +830,6 @@ _INLINE_ __u64 blkid_swab64(__u64 val)
 	return (blkid_swab32(val >> 32) |
 		(((__u64) blkid_swab32(val & 0xFFFFFFFFUL)) << 32));
 }
-#endif
-
-
 
 #ifdef WORDS_BIGENDIAN
 #define blkid_le16(x) blkid_swab16(x)
-- 
2.39.0

