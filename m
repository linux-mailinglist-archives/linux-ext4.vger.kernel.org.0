Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFEB5717A9
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jul 2022 12:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiGLKym (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jul 2022 06:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGLKyl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 12 Jul 2022 06:54:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D079AE542
        for <linux-ext4@vger.kernel.org>; Tue, 12 Jul 2022 03:54:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C03D41F95A;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657623277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9ejacqbn+u2yIXfkSs1iv5FIAC6AHnAX0Hyp3RRdNA=;
        b=ZL70N2Chq3/HHe0pkHTBRzTkUlMyAxQa5ztD7H27+lPzqTcXq6wXQCmL2q3YjGtWNUivKA
        CEXX6kvBefUFRFS9gPtYFe4jeCFTSE145+IkE8re1UtebmiAh1KDREtRbO74YKX/9ESK3P
        w1RFtQxHLzemOkjxnRhm+B90GO/fl68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657623277;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9ejacqbn+u2yIXfkSs1iv5FIAC6AHnAX0Hyp3RRdNA=;
        b=4yApO4zUdlWyyiwstXoGI2G34G6EGbsd8OPd26b8H3iTnuPgHb5J7BsuJoP8Ph2Adt23qd
        uNpLvVjE+ssq5mCg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AFC972C14E;
        Tue, 12 Jul 2022 10:54:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3030EA0648; Tue, 12 Jul 2022 12:54:37 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/10] mbcache: Remove mb_cache_entry_delete()
Date:   Tue, 12 Jul 2022 12:54:28 +0200
Message-Id: <20220712105436.32204-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220712104519.29887-1-jack@suse.cz>
References: <20220712104519.29887-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; h=from:subject; bh=dRhu3Zz/2KILJl3o7+G9DWM5ng2KgDQoFdtTNIvFDYg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBizVLjIulPwmtByWC2a+MAOFdnOC3Xj8S0AkCYMFTN ILU5686JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYs1S4wAKCRCcnaoHP2RA2UJJCA DTiUkIs/l5ZQzK4ssgbReutEDblk/53Eb9LhzdYJKUhLVjwb71Cxxvz8fBzxEdNN1VHcke2K6hK6e6 1CGM3dRYJfVTnCsMO9BEcD43k6GAMlP4Xw7ePJN5cV0qOlk9TxupuvJOVkHphP/LNZijBI97xWEoax 5GESB65syWfBUFvjl9/RWQBV0PkAZph4sqrTcKXUlLVTbky2N9z1l7k0R80gMMHSa9VvtZDuOAzDPy wvQ305dxGHpprKly7AjUS9cD+OrN7IrpR2rG3aajdI8mmV9kzI7VYLyL8kapShXYMgppYbSyCJDTEV GpO7WrD3OYvye0VLeeJNFkJWpiLFn6
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
 fs/mbcache.c            | 37 -------------------------------------
 include/linux/mbcache.h |  1 -
 2 files changed, 38 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 2010bc80a3f2..d1ebb5df2856 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -230,43 +230,6 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
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
 /* mb_cache_entry_delete_or_get - remove a cache entry if it has no users
  * @cache - cache we work with
  * @key - key
diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
index 8eca7f25c432..452b579856d4 100644
--- a/include/linux/mbcache.h
+++ b/include/linux/mbcache.h
@@ -47,7 +47,6 @@ static inline int mb_cache_entry_put(struct mb_cache *cache,
 
 struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
 						    u32 key, u64 value);
-void mb_cache_entry_delete(struct mb_cache *cache, u32 key, u64 value);
 struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
 					  u64 value);
 struct mb_cache_entry *mb_cache_entry_find_first(struct mb_cache *cache,
-- 
2.35.3

