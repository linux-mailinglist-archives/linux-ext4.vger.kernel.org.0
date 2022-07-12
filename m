Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121465717B1
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 12:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiGLKyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 06:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiGLKym (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 06:54:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A8AE3B7
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 03:54:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C77A722963;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657623277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17a8n8cNIsjxy+dpG0AQcORQokD95WhTPEj9IZ/hrcQ=;
        b=GEuByCRLKYBRwjNlIfue6URUe+uInOFXFVAHvkPpbYYgR9c9RSE7Bn7bX6GAASDn8KZT2M
        9sHDAvZ4x2W+PHHMcH3vksyBpFOQz053QyT0KpTx6Hvw8v+b+HY8t3ZhTofhkGHtLejX40
        bwprcS8bQdEMlIcyqSlNKVn+6a/TM+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657623277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=17a8n8cNIsjxy+dpG0AQcORQokD95WhTPEj9IZ/hrcQ=;
        b=Ao43EmwIg2BjfEdVeMKg3X4zlUivcgBXEaK8wyWnuo6V51OygYSUl9c7517a3HlnMg6piZ
        bBRjp29jAmyO17CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ACDB52C14B;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 37613A0649; Tue, 12 Jul 2022 12:54:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 10/10] mbcache: Automatically delete entries from cache on freeing
Date:   Tue, 12 Jul 2022 12:54:29 +0200
Message-Id: <20220712105436.32204-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712104519.29887-1-jack@suse.cz>
References: <20220712104519.29887-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8795; h=from:subject; bh=rgobwFBxqplTMO13ExOpjkviByvpaD9zDjN2av5wl94=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLOBj3hsSqRNd+2SVQj/auHoswqq8mJ7V73TR7qJ3aK1yht 6tvfyWjMwsDIwSArpsiyOvKi9rV5Rl1bQzVkYAaxMoFMYeDiFICJLFvI/j/71+/wwEM8rN5zn7v6hI Tq5Fm3JnjycyaeZF32oU7mhJ2OJ7+mTecPJ233/S0xiuGq/vOCOmyelrY/MVNO3CcX89HQ5+fGxY3d mjntTKri2S8Y77/dWRHkktnemq0QMbHg06S1nZlhsU8dX5a6rUjekeFl/Y7BjYE3RVXuQft3+ZBjH9 QUTL30P/ZpTc/vPnzCWaqu5vupn2vUefUeL3n2jzmDOTd1ue6aoALxsrjSZ00SXByvF+9bn3YtZ9H1 +cfZ/7xJEo0wvazpnsESuGAXU9EVH/ck5eKdQgxbbLkn8X94ZHarUc3T52zu5I6zO2/lHS+t4U/Lf2 H3VzpkY5Zd4OeVRWrPpD/aWQMA
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

Use the fact that entries with elevated refcount are not removed from
the hash and just move removal of the entry from the hash to the entry
freeing time. When doing this we also change the generic code to hold
one reference to the cache entry, not two of them, which makes code
somewhat more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mbcache.c            | 108 +++++++++++++++-------------------------
 include/linux/mbcache.h |  24 ++++++---
 2 files changed, 55 insertions(+), 77 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index d1ebb5df2856..96f1d49d30a5 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -90,7 +90,7 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&entry->e_list);
-	/* One ref for hash, one ref returned */
+	/* Initial hash reference */
 	atomic_set(&entry->e_refcnt, 1);
 	entry->e_key = key;
 	entry->e_value = value;
@@ -106,21 +106,28 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 		}
 	}
 	hlist_bl_add_head(&entry->e_hash_list, head);
-	hlist_bl_unlock(head);
-
+	/*
+	 * Add entry to LRU list before it can be found by
+	 * mb_cache_entry_delete() to avoid races
+	 */
 	spin_lock(&cache->c_list_lock);
 	list_add_tail(&entry->e_list, &cache->c_list);
-	/* Grab ref for LRU list */
-	atomic_inc(&entry->e_refcnt);
 	cache->c_entry_count++;
 	spin_unlock(&cache->c_list_lock);
+	hlist_bl_unlock(head);
 
 	return 0;
 }
 EXPORT_SYMBOL(mb_cache_entry_create);
 
-void __mb_cache_entry_free(struct mb_cache_entry *entry)
+void __mb_cache_entry_free(struct mb_cache *cache, struct mb_cache_entry *entry)
 {
+	struct hlist_bl_head *head;
+
+	head = mb_cache_entry_head(cache, entry->e_key);
+	hlist_bl_lock(head);
+	hlist_bl_del(&entry->e_hash_list);
+	hlist_bl_unlock(head);
 	kmem_cache_free(mb_entry_cache, entry);
 }
 EXPORT_SYMBOL(__mb_cache_entry_free);
@@ -134,7 +141,7 @@ EXPORT_SYMBOL(__mb_cache_entry_free);
  */
 void mb_cache_entry_wait_unused(struct mb_cache_entry *entry)
 {
-	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 3);
+	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 2);
 }
 EXPORT_SYMBOL(mb_cache_entry_wait_unused);
 
@@ -155,10 +162,9 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
 	while (node) {
 		entry = hlist_bl_entry(node, struct mb_cache_entry,
 				       e_hash_list);
-		if (entry->e_key == key && entry->e_reusable) {
-			atomic_inc(&entry->e_refcnt);
+		if (entry->e_key == key && entry->e_reusable &&
+		    atomic_inc_not_zero(&entry->e_refcnt))
 			goto out;
-		}
 		node = node->next;
 	}
 	entry = NULL;
@@ -218,10 +224,9 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 	head = mb_cache_entry_head(cache, key);
 	hlist_bl_lock(head);
 	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
-		if (entry->e_key == key && entry->e_value == value) {
-			atomic_inc(&entry->e_refcnt);
+		if (entry->e_key == key && entry->e_value == value &&
+		    atomic_inc_not_zero(&entry->e_refcnt))
 			goto out;
-		}
 	}
 	entry = NULL;
 out:
@@ -244,37 +249,25 @@ EXPORT_SYMBOL(mb_cache_entry_get);
 struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
 						    u32 key, u64 value)
 {
-	struct hlist_bl_node *node;
-	struct hlist_bl_head *head;
 	struct mb_cache_entry *entry;
 
-	head = mb_cache_entry_head(cache, key);
-	hlist_bl_lock(head);
-	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
-		if (entry->e_key == key && entry->e_value == value) {
-			if (atomic_read(&entry->e_refcnt) > 2) {
-				atomic_inc(&entry->e_refcnt);
-				hlist_bl_unlock(head);
-				return entry;
-			}
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
-			return NULL;
-		}
-	}
-	hlist_bl_unlock(head);
+	entry = mb_cache_entry_get(cache, key, value);
+	if (!entry)
+		return NULL;
+
+	/*
+	 * Drop the ref we got from mb_cache_entry_get() and the initial hash
+	 * ref if we are the last user
+	 */
+	if (atomic_cmpxchg(&entry->e_refcnt, 2, 0) != 2)
+		return entry;
 
+	spin_lock(&cache->c_list_lock);
+	if (!list_empty(&entry->e_list))
+		list_del_init(&entry->e_list);
+	cache->c_entry_count--;
+	spin_unlock(&cache->c_list_lock);
+	__mb_cache_entry_free(cache, entry);
 	return NULL;
 }
 EXPORT_SYMBOL(mb_cache_entry_delete_or_get);
@@ -306,42 +299,24 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
 				     unsigned long nr_to_scan)
 {
 	struct mb_cache_entry *entry;
-	struct hlist_bl_head *head;
 	unsigned long shrunk = 0;
 
 	spin_lock(&cache->c_list_lock);
 	while (nr_to_scan-- && !list_empty(&cache->c_list)) {
 		entry = list_first_entry(&cache->c_list,
 					 struct mb_cache_entry, e_list);
-		if (entry->e_referenced || atomic_read(&entry->e_refcnt) > 2) {
+		/* Drop initial hash reference if there is no user */
+		if (entry->e_referenced ||
+		    atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
 			entry->e_referenced = 0;
 			list_move_tail(&entry->e_list, &cache->c_list);
 			continue;
 		}
 		list_del_init(&entry->e_list);
 		cache->c_entry_count--;
-		/*
-		 * We keep LRU list reference so that entry doesn't go away
-		 * from under us.
-		 */
 		spin_unlock(&cache->c_list_lock);
-		head = mb_cache_entry_head(cache, entry->e_key);
-		hlist_bl_lock(head);
-		/* Now a reliable check if the entry didn't get used... */
-		if (atomic_read(&entry->e_refcnt) > 2) {
-			hlist_bl_unlock(head);
-			spin_lock(&cache->c_list_lock);
-			list_add_tail(&entry->e_list, &cache->c_list);
-			cache->c_entry_count++;
-			continue;
-		}
-		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
-			hlist_bl_del_init(&entry->e_hash_list);
-			atomic_dec(&entry->e_refcnt);
-		}
-		hlist_bl_unlock(head);
-		if (mb_cache_entry_put(cache, entry))
-			shrunk++;
+		__mb_cache_entry_free(cache, entry);
+		shrunk++;
 		cond_resched();
 		spin_lock(&cache->c_list_lock);
 	}
@@ -433,11 +408,6 @@ void mb_cache_destroy(struct mb_cache *cache)
 	 * point.
 	 */
 	list_for_each_entry_safe(entry, next, &cache->c_list, e_list) {
-		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
-			hlist_bl_del_init(&entry->e_hash_list);
-			atomic_dec(&entry->e_refcnt);
-		} else
-			WARN_ON(1);
 		list_del(&entry->e_list);
 		WARN_ON(atomic_read(&entry->e_refcnt) != 1);
 		mb_cache_entry_put(cache, entry);
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 452b579856d4..2da63fd7b98f 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -13,8 +13,16 @@ struct mb_cache;
 struct mb_cache_entry {
 	/* List of entries in cache - protected by cache->c_list_lock */
 	struct list_head	e_list;
-	/* Hash table list - protected by hash chain bitlock */
+	/*
+	 * Hash table list - protected by hash chain bitlock. The entry is
+	 * guaranteed to be hashed while e_refcnt > 0.
+	 */
 	struct hlist_bl_node	e_hash_list;
+	/*
+	 * Entry refcount. Once it reaches zero, entry is unhashed and freed.
+	 * While refcount > 0, the entry is guaranteed to stay in the hash and
+	 * e.g. mb_cache_entry_try_delete() will fail.
+	 */
 	atomic_t		e_refcnt;
 	/* Key in hash - stable during lifetime of the entry */
 	u32			e_key;
@@ -29,20 +37,20 @@ void mb_cache_destroy(struct mb_cache *cache);
 
 int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 			  u64 value, bool reusable);
-void __mb_cache_entry_free(struct mb_cache_entry *entry);
+void __mb_cache_entry_free(struct mb_cache *cache,
+			   struct mb_cache_entry *entry);
 void mb_cache_entry_wait_unused(struct mb_cache_entry *entry);
-static inline int mb_cache_entry_put(struct mb_cache *cache,
-				     struct mb_cache_entry *entry)
+static inline void mb_cache_entry_put(struct mb_cache *cache,
+				      struct mb_cache_entry *entry)
 {
 	unsigned int cnt = atomic_dec_return(&entry->e_refcnt);
 
 	if (cnt > 0) {
-		if (cnt <= 3)
+		if (cnt <= 2)
 			wake_up_var(&entry->e_refcnt);
-		return 0;
+		return;
 	}
-	__mb_cache_entry_free(entry);
-	return 1;
+	__mb_cache_entry_free(cache, entry);
 }
 
 struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
-- 
2.35.3

