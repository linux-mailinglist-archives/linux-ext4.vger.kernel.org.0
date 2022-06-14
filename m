Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B4D54B55D
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jun 2022 18:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbiFNQGV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jun 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354455AbiFNQGL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jun 2022 12:06:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B524541639
        for <linux-ext4@vger.kernel.org>; Tue, 14 Jun 2022 09:06:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 14F4F1F9A9;
        Tue, 14 Jun 2022 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655222765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfvpzBTSY2CcQQ5fmdXCkwtL4YvnafHwxH5ik6bxfQ8=;
        b=aUlR7gxd4gxIt/ij2kc8yF438nGzXOKflHIkErTByY4Z8GF+iPPUqPMzWGPYEn8SCsUdhF
        AS9KcQwnyjSGFss5Wxes+mWNlLq0xHMdUjNE0J5UPGxO9Sf1dKvNmLURvHQTa/RsTiB41L
        8GPFcLs2iI/ou7uOpOyaEund7OgGLWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655222765;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfvpzBTSY2CcQQ5fmdXCkwtL4YvnafHwxH5ik6bxfQ8=;
        b=dPVxupHydhXpkopHhlCkNUGwaiW6RCFevg5pGch2fKKpFMJ7neVpAo/Sm/2LVsJTNifo1/
        oJyR4aCkr0J6fMBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 081072C14F;
        Tue, 14 Jun 2022 16:06:05 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 05169A063D; Tue, 14 Jun 2022 18:06:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/10] mbcache: Remove mb_cache_entry_delete()
Date:   Tue, 14 Jun 2022 18:05:23 +0200
Message-Id: <20220614160603.20566-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220614124146.21594-1-jack@suse.cz>
References: <20220614124146.21594-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2893; h=from:subject; bh=V4ETyThY8DgRS5cO3vwUiJUVd0xX30ITCRAr6jJt5a0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqLHCYjDl2LxH14cxwfWQVYayjicRqEovy/Q8cz2R cXrmZruJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqixwgAKCRCcnaoHP2RA2W/rB/ 9rUdPh0LxlRKKZk4VfkH2QQd5WZ4fd4Kyi5F2HCLWMly0ShWdBrK/F5W2P99bushv1zHef/J3Svl6R Ug3WoPvy3WE/d+pXDO+XMbhltG3nZlfwtcDo6tx9O6ehtywbZqzRC0Cg5720JDUyVNjE8CajcI7qAV oMNlA/TqULVtMCqnIEnnY3lPuGZvmZ0v/XyhNi6EeN2egQDWzxsl68ZxIDQga0B/MuiNh4akEqLLz7 8zvS3Rd1Hb+A5er0IgRU2toVsQvz6eNC5waQGv5qsR5x3MK91SpusxnzcuBUuU3ACA6yU3oPp589lZ Wd0NVO/BmVJdfP3QZ2bMvY5Esu/QEu
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Nobody uses mb_cache_entry_delete() anymore. Remove it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mbcache.c            | 41 ++---------------------------------------
 include/linux/mbcache.h |  1 -
 2 files changed, 2 insertions(+), 40 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 1ae66b2c75f4..c7b28a4e96da 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -11,7 +11,7 @@
 /*
  * Mbcache is a simple key-value store. Keys need not be unique, however
  * key-value pairs are expected to be unique (we use this fact in
- * mb_cache_entry_delete()).
+ * mb_cache_entry_try_delete()).
  *
  * Ext2 and ext4 use this cache for deduplication of extended attribute blocks.
  * Ext4 also uses it for deduplication of xattr values stored in inodes.
@@ -230,44 +230,7 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 }
 EXPORT_SYMBOL(mb_cache_entry_get);
 
-/* mb_cache_entry_delete - try to remove a cache entry
- * @cache - cache we work with
- * @key - key
- * @value - value
- *
- * Remove entry from cache @cache with key @key and value @value.
- */
-void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value)
-{
-	struct hlist_bl_node *node;
-	struct hlist_bl_head *head;
-	struct mb_cache_entry *entry;
-
-	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
-	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
-		if (entry->e_key == key && entry->e_value == value) {
-			/* We keep hash list reference to keep entry alive */
-			hlist_bl_del_init(&entry->e_hash_list);
-			hlist_bl_unlock(head);
-			spin_lock(&cache->c_list_lock);
-			if (!list_empty(&entry->e_list)) {
-				list_del_init(&entry->e_list);
-				if (!WARN_ONCE(cache->c_entry_count == 0,
-		"mbcache: attempt to decrement c_entry_count past zero"))
-					cache->c_entry_count--;
-				atomic_dec(&entry->e_refcnt);
-			}
-			spin_unlock(&cache->c_list_lock);
-			mb_cache_entry_put(cache, entry);
-			return;
-		}
-	}
-	hlist_bl_unlock(head);
-}
-EXPORT_SYMBOL(mb_cache_entry_delete);
-
-/* mb_cache_entry_try_delete - try to remove a cache entry
+/* mb_cache_entry_try_delete - remove a cache entry
  * @cache - cache we work with
  * @key - key
  * @value - value
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 1176fdfb8d53..3b25c3004ea9 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -47,7 +47,6 @@ static inline int mb_cache_entry_put(struct mb_cache *cache,
 
 struct mb_cache_entry *mb_cache_entry_try_delete(struct mb_cache *cache,
 						 u32 key, u64 value);
-void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value);
 struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 					  u64 value);
 struct mb_cache_entry *mb_cache_entry_find_first(struct mb_cache *cache,
-- 
2.35.3

