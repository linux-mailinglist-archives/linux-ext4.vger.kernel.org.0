Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8445B181D
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 11:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiIHJK5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 05:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiIHJKv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 05:10:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698A99B7D;
        Thu,  8 Sep 2022 02:10:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 67D6622AE9;
        Thu,  8 Sep 2022 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662628240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TxW0nswTE1xcIJ8762DBIkIeOfhvNnUbpYK3mr2ADcA=;
        b=omOTbZnG7ZtT/+msLgPFiupSzqzfz6PWf0ZQzyxsFvr+2w41Ovp5KbqnsO2nSPmK5atgqf
        XA1PeM6WBHR8k7y3u9CIY2NRE5GCUZCn7O2NG5RoI9/NM88Kzoy0RW9PSNY0ZBICwGc0Ii
        byZwKXbeOzfsDd2ogPZTwt/lotlKJ3w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662628240;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=TxW0nswTE1xcIJ8762DBIkIeOfhvNnUbpYK3mr2ADcA=;
        b=mBBSmJSDnX2+tMF/6jNewVNM2OLQE8EZ3WWhaspIV6rFaUTlJLnckb3cZlzzmveU/7aKLN
        3E6QQBa8KKatrfBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BDAA13A6D;
        Thu,  8 Sep 2022 09:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ualkFpCxGWPWPwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 08 Sep 2022 09:10:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E48C1A067E; Thu,  8 Sep 2022 11:10:39 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] mbcache: Avoid nesting of cache->c_list_lock under bit locks
Date:   Thu,  8 Sep 2022 11:10:32 +0200
Message-Id: <20220908091032.10513-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2089; h=from:subject; bh=dRJj3j9qfjEl6wYp/YsGfWVb12vOG36l+ern9zbLpCQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjGbGC9duuau5H/8u1XvR/jnI288SB12rOUZo41awT Mr3qGX+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYxmxggAKCRCcnaoHP2RA2VC4CA DSr6mnDQ+GmRI+9UKxbEX6oPTOMrtelKFNhJ6dGLD/AuClpviLsxHcQrJFTSSKfOQb9jHpD/f4mQbB 9hmkpA6NnNaOVxkooLs8khFseUVaH2m3q/sND/Lxh2e705O429Tmt1i+5wp175Y3anzV6V7IA+cdm0 U963MgZusPasmH78DdAXEC32I5Z3TcQnbVSR0jSB4hH8sTVvYm1mJ5q++sVcuaWUSP/vO4HA8zMOqT t+jwOULBptCfgsx3jGM2/y8NGBMAE6Xvu42d3jlWLcqX1dKxcffgIaWIXXNewVWJ59gt6hGI8uUo7k Pwuqt7qw86iRm9BkGYo+hZu/ZhSZuC
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

Commit 307af6c87937 ("mbcache: automatically delete entries from cache
on freeing") started nesting cache->c_list_lock under the bit locks
protecting hash buckets of the mbcache hash table in
mb_cache_entry_create(). This causes problems for real-time kernels
because there spinlocks are sleeping locks while bitlocks stay atomic.
Luckily the nesting is easy to avoid by holding entry reference until
the entry is added to the LRU list. This makes sure we cannot race with
entry deletion.

Fixes: 307af6c87937 ("mbcache: automatically delete entries from cache on freeing")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/mbcache.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/mbcache.c b/fs/mbcache.c
index 47ccfcbe0a22..e272ad738faf 100644
--- a/fs/mbcache.c
+++ b/fs/mbcache.c
@@ -90,8 +90,14 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&entry->e_list);
-	/* Initial hash reference */
-	atomic_set(&entry->e_refcnt, 1);
+	/*
+	 * We create entry with two references. One reference is kept by the
+	 * hash table, the other reference is used to protect us from
+	 * mb_cache_entry_delete_or_get() until the entry is fully setup. This
+	 * avoids nesting of cache->c_list_lock into hash table bit locks which
+	 * is problematic for RT.
+	 */
+	atomic_set(&entry->e_refcnt, 2);
 	entry->e_key = key;
 	entry->e_value = value;
 	entry->e_reusable = reusable;
@@ -106,15 +112,12 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
 		}
 	}
 	hlist_bl_add_head(&entry->e_hash_list, head);
-	/*
-	 * Add entry to LRU list before it can be found by
-	 * mb_cache_entry_delete() to avoid races
-	 */
+	hlist_bl_unlock(head);
 	spin_lock(&cache->c_list_lock);
 	list_add_tail(&entry->e_list, &cache->c_list);
 	cache->c_entry_count++;
 	spin_unlock(&cache->c_list_lock);
-	hlist_bl_unlock(head);
+	mb_cache_entry_put(cache, entry);
 
 	return 0;
 }
-- 
2.35.3

