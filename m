Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A9E7874B3
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 17:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbjHXP4w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240359AbjHXP4m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 11:56:42 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4481993
        for <linux-ext4@vger.kernel.org>; Thu, 24 Aug 2023 08:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692892595;
        bh=fwUjvnxzVnmsEiAOrfjB+FNh7kAdG9BB9yUg6zBi0eg=;
        h=From:To:Cc:Subject:Date;
        b=ZgrBnhUR9jmG9n7esCLYa0mn1VXZzdKiH9nC/zcJBPdLkngjXIS7MSsRpRzhbg2A+
         QbbPMh2HP5KN3QkpEifZT8Rrc6fYeRZQ59L+DBasEkU8jRxGZ0NP5iUfpRL9tED6QP
         e6xf8M+EkcW0dRRhN0oZDbECsxZ5lU/fuonPmCCo=
Received: from fedora.. ([120.244.20.128])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id E219D627; Thu, 24 Aug 2023 23:56:33 +0800
X-QQ-mid: xmsmtpt1692892593tzqvb6la5
Message-ID: <tencent_53CBCB1668358AE862684E453DF37B722008@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69fHH+fNjXM4UQRtPHld0MsHOcY9ui6Lx/hLF+54I3UzFv9Am+rO
         wFsIfah3VgecQuvhOsTkJPcCBEW5BCoXISVuCrEN4EDsKz/eSGWmd86YaD3dolG5gDtf6r6sHKqi
         m5HldYljmGDUvQ/BDionK0DyA3rK1fb517j/+O+0JgY3q9SFntRehW+M1ODzYzs9+7KZEozQ/LUC
         Za9C8GpeySnGx5PNwyaEA8wvPWK2O+uQyofaxhIDiKC6AbKJwtomMvB1T33PEv3TCB5qyhFV66ml
         7EJbOK4FuxcVfTCWBk1RSILdOI6JrapajGcQR15YuuDux/lHh6DRg4vP14bw6xpuRNkxsBlIknAR
         cD02/MiYRKXVi78oM+BKMr5WM+NqndblrWVU0rAZKXciyUS0XXx4wofYA1ed6s2g8+C4+SX0+17t
         3V0P+cNfzQJAJ7hVi9gcMHJ2XYndPFfXh+kykpe2prDd+fcrnuzIOhaSsNsxFZHWe8/qDzEsa0e+
         F+gU6zxIUBPFriNG/dfsghNBc/c38SZWtuvHAE4dwnYdo6IEFT5W1tFE+z7Z9JLAnMbd3zFQ1qXc
         FOJFeHMKlt2aXJnjqlRcVWla562yTCBHs3qkdM+zHMCXQhV5xZZsU7kOayvYH5iRo8kqPzklSLHf
         1NIGzVla56W12frc+IR30fIfJiaaXWbpAgpF4Nu4H2KtgpjUd0ow0mxPvSk0mBpdskkKNbD4QlCY
         zKywcLHhbXa5XbdgOJ6guImZZ+eCxKjhLD9d8So84n8NPTuEldfC0/FtU5BBrPEMB10z7VY5rFhJ
         wuRXza8s8hWPlD0b4MlIKetW7u4ttxE9jyVTQa9r5ftMSBXKyFYQDhDLpPbqDH9uHGHFpgUs6XCR
         p7Y6rJV/Ufcp4VRpru1IGZxwSMhxInr0mAqbD8bZgpTCc6ksCtQJjB8am8qktDHrEeaUaAK2GHOM
         399bPxuFCIMojLk3NFVi/SjMcOFMIx4hKeIHYLBD/j3VCArP1JvDzR6tLF2RowNSjPEY4iqt8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Wang Jianjian <wangjianjian0@foxmail.com>
To:     linux-ext4@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com
Cc:     Wang Jianjian <wangjianjian0@foxmail.com>
Subject: [PATCH] ext4/mballoc: No need to generate from free list
Date:   Thu, 24 Aug 2023 23:56:31 +0800
X-OQ-MSGID: <20230824155631.20895-1-wangjianjian0@foxmail.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Commit 7a2fcbf7f85('ext4: don't use blocks freed but
not yet committed in buddy cache init) walk the rbtree of
freed data and mark them free in buddy to avoid reuse them
before journal committing them, However, it is unnecessary to
do that, because we have extra page references to buddy and bitmap
pages, they will be released iff journal has committed and after
process freed data.

Fixes: 7a2fcbf7f85('ext4: don't use blocks freed but not yet committed in buddy cache init')
Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>
---
 fs/ext4/mballoc.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..b512a134a5fb 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -404,8 +404,6 @@ static const char * const ext4_groupinfo_slab_names[NR_GRPINFO_CACHES] = {
 
 static void ext4_mb_generate_from_pa(struct super_block *sb, void *bitmap,
 					ext4_group_t group);
-static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
-						ext4_group_t group);
 static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);
 
 static bool ext4_mb_good_group(struct ext4_allocation_context *ac,
@@ -1274,7 +1272,6 @@ static int ext4_mb_init_cache(struct page *page, char *incore, gfp_t gfp)
 
 			/* mark all preallocated blks used in in-core bitmap */
 			ext4_mb_generate_from_pa(sb, data, group);
-			ext4_mb_generate_from_freelist(sb, data, group);
 			ext4_unlock_group(sb, group);
 
 			/* set incore so that the buddy information can be
@@ -4440,30 +4437,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	return false;
 }
 
-/*
- * the function goes through all block freed in the group
- * but not yet committed and marks them used in in-core bitmap.
- * buddy must be generated from this bitmap
- * Need to be called with the ext4 group lock held
- */
-static void ext4_mb_generate_from_freelist(struct super_block *sb, void *bitmap,
-						ext4_group_t group)
-{
-	struct rb_node *n;
-	struct ext4_group_info *grp;
-	struct ext4_free_data *entry;
-
-	grp = ext4_get_group_info(sb, group);
-	n = rb_first(&(grp->bb_free_root));
-
-	while (n) {
-		entry = rb_entry(n, struct ext4_free_data, efd_node);
-		mb_set_bits(bitmap, entry->efd_start_cluster, entry->efd_count);
-		n = rb_next(n);
-	}
-	return;
-}
-
 /*
  * the function goes through all preallocation in this group and marks them
  * used in in-core bitmap. buddy must be generated from this bitmap
-- 
2.34.3

