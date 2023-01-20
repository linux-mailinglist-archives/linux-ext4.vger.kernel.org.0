Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22950674C6F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jan 2023 06:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjATFeI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Jan 2023 00:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjATFd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Jan 2023 00:33:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5367DFAD
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 21:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA592B8278C
        for <linux-ext4@vger.kernel.org>; Fri, 20 Jan 2023 00:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F080C433EF
        for <linux-ext4@vger.kernel.org>; Fri, 20 Jan 2023 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674175321;
        bh=tMsZSL8seYohTyLqgfozrGsZJGqjAghLDLvsowtA+HM=;
        h=From:To:Subject:Date:From;
        b=npf6MSx6XpQDwbw6MHUlmlWvIYd8hPQwub3xHmbhxiul04RfNwJ4OQvU/OG0C9RiS
         fk1mcEtNN4iRyNHeGGH9MNquM6Vfpq1JhRIi2+DmMV4RZhp4UBlfaoab2dfZhrQlzo
         1bYxKymNFs5KIbVEl9qiUomWZCWnJenotNc/FP4vnI4R9Lp/uufworZz2M5oJHg7TY
         lYhxDi/c2f1+kvVKrW174MGlyDM4zZ3MYdl/67I/62YEEqG8IhTYiC30eTNhTWmTXo
         vCX//eF9+gn6+17Ch3dYO08Fi+VGWRcUkLLmgaDxjLQLdtQ9CC74Ij4XsPpPG+oABW
         FOQCSSIzgJMDw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [e2fsprogs PATCH] e2fsck: use inline functions for kernel slab functions
Date:   Thu, 19 Jan 2023 16:40:34 -0800
Message-Id: <20230120004034.145647-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
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

The macros that e2fsck uses to implement kmalloc et al. use only some of
their arguments, so unlike standard function calls, they can cause
compiler warnings like:

./../e2fsck/revoke.c:141:8: warning: variable 'gfp_mask' set but not used [-Wunused-but-set-variable]

Fix this by providing a proper definition for each function, making sure
to match the function prototypes used in the kernel.

Remove the kmem_cache_t typedef, as it doesn't exist in the kernel.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 e2fsck/jfs_user.h | 53 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/e2fsck/jfs_user.h b/e2fsck/jfs_user.h
index 969cd1b92..6f81d8cdc 100644
--- a/e2fsck/jfs_user.h
+++ b/e2fsck/jfs_user.h
@@ -82,16 +82,9 @@ struct kdev_s {
 #define buffer_req(bh) 1
 #define do_readahead(journal, start) do {} while (0)
 
-typedef struct kmem_cache {
-	int	object_length;
-} kmem_cache_t;
-
-#define kmem_cache_alloc(cache, flags) malloc((cache)->object_length)
-#define kmem_cache_free(cache, obj) free(obj)
-#define kmem_cache_create(name, len, a, b, c) do_cache_create(len)
-#define kmem_cache_destroy(cache) do_cache_destroy(cache)
-#define kmalloc(len, flags) malloc(len)
-#define kfree(p) free(p)
+struct kmem_cache {
+	unsigned int	object_size;
+};
 
 #define cond_resched()	do { } while (0)
 
@@ -107,8 +100,15 @@ typedef struct kmem_cache {
  * functions.
  */
 #ifdef NO_INLINE_FUNCS
-extern kmem_cache_t *do_cache_create(int len);
-extern void do_cache_destroy(kmem_cache_t *cache);
+extern struct kmem_cache *kmem_cache_create(const char *name,
+					    unsigned int size,
+					    unsigned int align,
+					    unsigned int flags,
+					    void (*ctor)(void *));
+extern void kmem_cache_destroy(struct kmem_cache *s);
+extern void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags);
+extern void kmem_cache_free(struct kmem_cache *s, void *objp);
+extern void kfree(const void *objp);
 extern size_t journal_tag_bytes(journal_t *journal);
 extern __u32 __hash_32(__u32 val);
 extern __u32 hash_32(__u32 val, unsigned int bits);
@@ -139,19 +139,38 @@ extern void jbd2_descriptor_block_csum_set(journal_t *j,
 #endif /* __STDC_VERSION__ >= 199901L */
 #endif /* E2FSCK_INCLUDE_INLINE_FUNCS */
 
-_INLINE_ kmem_cache_t *do_cache_create(int len)
+_INLINE_ struct kmem_cache *kmem_cache_create(const char *name,
+					      unsigned int size,
+					      unsigned int align,
+					      unsigned int flags,
+					      void (*ctor)(void *))
 {
-	kmem_cache_t *new_cache;
+	struct kmem_cache *new_cache;
 
 	new_cache = malloc(sizeof(*new_cache));
 	if (new_cache)
-		new_cache->object_length = len;
+		new_cache->object_size = size;
 	return new_cache;
 }
 
-_INLINE_ void do_cache_destroy(kmem_cache_t *cache)
+_INLINE_ void kmem_cache_destroy(struct kmem_cache *s)
+{
+	free(s);
+}
+
+_INLINE_ void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
+{
+	return malloc(cachep->object_size);
+}
+
+_INLINE_ void kmem_cache_free(struct kmem_cache *s, void *objp)
+{
+	free(objp);
+}
+
+_INLINE_ void kfree(const void *objp)
 {
-	free(cache);
+	free((void *)objp);
 }
 
 /* generic hashing taken from the Linux kernel */

base-commit: 6695555e50a374f897965300568253f242a0b13b
-- 
2.39.0

