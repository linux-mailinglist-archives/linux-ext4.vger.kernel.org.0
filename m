Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDB19BC0
	for <lists+linux-ext4@lfdr.de>; Fri, 10 May 2019 12:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfEJKg7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 May 2019 06:36:59 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40331 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfEJKg7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 May 2019 06:36:59 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so3015641pfn.7;
        Fri, 10 May 2019 03:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=34gwlOJkeJY6G5wyiRP5dNE8+dAulYaywrUwBHw8bTk=;
        b=ZMJ3FJjgW09dJz9YFZ6K1KzMjJhN/CZxz/kNMsncir9e1GgiKfoeWjuGqwaRZ+bI0f
         pkOmmAAB1nA/vN3LsgdH52mY08OlmodQT8eUgy+kNiD4d5XFnVuK5F/DvnZrhYStcIxc
         uqWVk0722pQccw0jSU5DJbn2Nz3Ytha2wWoJWfRiOn790MtGs/xTge5pXTo6JJYciQtk
         /ApRo/D8SBuJiDkEieEEM6Hq+vfCnhQSFvy62JvGA0oAaaW0VymaYykNObLWiKjgwG81
         Iafj4kw4jHQJ+O9XxdsRaywgEhDhuXOekouVIYuzXo/SnBFteqJFG2CL7HL+1S6Nlnzy
         pRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=34gwlOJkeJY6G5wyiRP5dNE8+dAulYaywrUwBHw8bTk=;
        b=FUNT3YlLHSsjexFmaHL4ZZ2tj6dFU1QaCCW1HwFgFgRZotLRzrarSgm6V3w7KVoAod
         F3CH/NtlmWD6IAtT0Z2kijGStHfkSoxuB9zOJNxVUhc289C67ovax5yXyJmJ5b6hdUZA
         tim5PJB9vE6SMEo1EE8Yg191LbFRpNj1zuFc5oKvfh3hjjJg2/OM8IIviA/JDYcheGQy
         eUP0hiKl4FiU0TloZyaRD3yhZZq8uEhVunCTI+gA05hhZfLVA2b1gsxPf4wbQRTw6bV1
         e7XVzjoNgttm/JOgMPR57kLoeh4sJ7i3E5QT3KfhL+FC0l9a/eCvNaKWnUU9ctD+rilM
         Mozg==
X-Gm-Message-State: APjAAAURXbQYNU+iL4ESnFIkHz+RLRMNACgjMS0kNktbxo9IalyckXrG
        Q/pWDClrJGgN9eZNX6Ni7T8=
X-Google-Smtp-Source: APXvYqyJs1YtnUEAHdWkGq2tkD8ZzY3OjX+2cl8yCH9+xdqT90MJfrEXdvFz7JRQvVvgLq/uix+CDg==
X-Received: by 2002:a63:b70f:: with SMTP id t15mr9956239pgf.351.1557484618110;
        Fri, 10 May 2019 03:36:58 -0700 (PDT)
Received: from izt4n3nohp3b5a1z8j8uuaz.localdomain ([149.129.49.136])
        by smtp.gmail.com with ESMTPSA id m21sm14750938pff.146.2019.05.10.03.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 03:36:57 -0700 (PDT)
From:   Chengguang Xu <cgxu519@gmail.com>
To:     jack@suse.com, tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmail.com>
Subject: [PATCH v2] jbd2: fix potential double free
Date:   Fri, 10 May 2019 18:36:48 +0800
Message-Id: <1557484608-23514-1-git-send-email-cgxu519@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When fail from creating cache jbd2_inode_cache, we will
destroy previously created cache jbd2_handle_cache twice.
This patch fixes it by sperating each cache
initialization/destruction to individual function.

Signed-off-by: Chengguang Xu <cgxu519@gmail.com>
---
v2:
- Seperate cache initialization/destruction to individual function.

 fs/jbd2/journal.c     | 51 +++++++++++++++++++++++++++----------------
 fs/jbd2/revoke.c      | 32 +++++++++++++++++----------
 fs/jbd2/transaction.c |  8 ++++---
 include/linux/jbd2.h  |  8 ++++---
 4 files changed, 62 insertions(+), 37 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 37e16d969925..0f1ac43d0560 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2299,7 +2299,7 @@ static void jbd2_journal_destroy_slabs(void)
 	}
 }
 
-static int jbd2_journal_create_slab(size_t size)
+static int __init jbd2_journal_create_slab(size_t size)
 {
 	static DEFINE_MUTEX(jbd2_slab_create_mutex);
 	int i = order_base_2(size) - 10;
@@ -2375,22 +2375,19 @@ static struct kmem_cache *jbd2_journal_head_cache;
 static atomic_t nr_journal_heads = ATOMIC_INIT(0);
 #endif
 
-static int jbd2_journal_init_journal_head_cache(void)
+static int __init jbd2_journal_init_journal_head_cache(void)
 {
-	int retval;
-
-	J_ASSERT(jbd2_journal_head_cache == NULL);
+	J_ASSERT(!jbd2_journal_head_cache);
 	jbd2_journal_head_cache = kmem_cache_create("jbd2_journal_head",
 				sizeof(struct journal_head),
 				0,		/* offset */
 				SLAB_TEMPORARY | SLAB_TYPESAFE_BY_RCU,
 				NULL);		/* ctor */
-	retval = 0;
 	if (!jbd2_journal_head_cache) {
-		retval = -ENOMEM;
 		printk(KERN_EMERG "JBD2: no memory for journal_head cache\n");
+		return -ENOMEM;
 	}
-	return retval;
+	return 0;
 }
 
 static void jbd2_journal_destroy_journal_head_cache(void)
@@ -2636,28 +2633,38 @@ static void __exit jbd2_remove_jbd_stats_proc_entry(void)
 
 struct kmem_cache *jbd2_handle_cache, *jbd2_inode_cache;
 
+static int __init jbd2_journal_init_inode_cache(void)
+{
+	J_ASSERT(!jbd2_inode_cache);
+	jbd2_inode_cache = KMEM_CACHE(jbd2_inode, 0);
+	if (!jbd2_inode_cache) {
+		pr_emerg("JBD2: failed to create inode cache\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int __init jbd2_journal_init_handle_cache(void)
 {
+	J_ASSERT(!jbd2_handle_cache);
 	jbd2_handle_cache = KMEM_CACHE(jbd2_journal_handle, SLAB_TEMPORARY);
-	if (jbd2_handle_cache == NULL) {
+	if (!jbd2_handle_cache) {
 		printk(KERN_EMERG "JBD2: failed to create handle cache\n");
 		return -ENOMEM;
 	}
-	jbd2_inode_cache = KMEM_CACHE(jbd2_inode, 0);
-	if (jbd2_inode_cache == NULL) {
-		printk(KERN_EMERG "JBD2: failed to create inode cache\n");
-		kmem_cache_destroy(jbd2_handle_cache);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
+static void jbd2_journal_destroy_inode_cache(void)
+{
+	kmem_cache_destroy(jbd2_inode_cache);
+	jbd2_inode_cache = NULL;
+}
+
 static void jbd2_journal_destroy_handle_cache(void)
 {
 	kmem_cache_destroy(jbd2_handle_cache);
 	jbd2_handle_cache = NULL;
-	kmem_cache_destroy(jbd2_inode_cache);
-	jbd2_inode_cache = NULL;
 }
 
 /*
@@ -2668,11 +2675,15 @@ static int __init journal_init_caches(void)
 {
 	int ret;
 
-	ret = jbd2_journal_init_revoke_caches();
+	ret = jbd2_journal_init_revoke_record_cache();
+	if (ret == 0)
+		ret = jbd2_journal_init_revoke_table_cache();
 	if (ret == 0)
 		ret = jbd2_journal_init_journal_head_cache();
 	if (ret == 0)
 		ret = jbd2_journal_init_handle_cache();
+	if (ret == 0)
+		ret = jbd2_journal_init_inode_cache();
 	if (ret == 0)
 		ret = jbd2_journal_init_transaction_cache();
 	return ret;
@@ -2680,9 +2691,11 @@ static int __init journal_init_caches(void)
 
 static void jbd2_journal_destroy_caches(void)
 {
-	jbd2_journal_destroy_revoke_caches();
+	jbd2_journal_destroy_revoke_record_cache();
+	jbd2_journal_destroy_revoke_table_cache();
 	jbd2_journal_destroy_journal_head_cache();
 	jbd2_journal_destroy_handle_cache();
+	jbd2_journal_destroy_inode_cache();
 	jbd2_journal_destroy_transaction_cache();
 	jbd2_journal_destroy_slabs();
 }
diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index a1143e57a718..69b9bc329964 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -178,33 +178,41 @@ static struct jbd2_revoke_record_s *find_revoke_record(journal_t *journal,
 	return NULL;
 }
 
-void jbd2_journal_destroy_revoke_caches(void)
+void jbd2_journal_destroy_revoke_record_cache(void)
 {
 	kmem_cache_destroy(jbd2_revoke_record_cache);
 	jbd2_revoke_record_cache = NULL;
+}
+
+void jbd2_journal_destroy_revoke_table_cache(void)
+{
 	kmem_cache_destroy(jbd2_revoke_table_cache);
 	jbd2_revoke_table_cache = NULL;
 }
 
-int __init jbd2_journal_init_revoke_caches(void)
+int __init jbd2_journal_init_revoke_record_cache(void)
 {
 	J_ASSERT(!jbd2_revoke_record_cache);
-	J_ASSERT(!jbd2_revoke_table_cache);
-
 	jbd2_revoke_record_cache = KMEM_CACHE(jbd2_revoke_record_s,
 					SLAB_HWCACHE_ALIGN|SLAB_TEMPORARY);
-	if (!jbd2_revoke_record_cache)
-		goto record_cache_failure;
 
+	if (!jbd2_revoke_record_cache) {
+		pr_emerg("JBD2: failed to create revoke_record cache\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+int __init jbd2_journal_init_revoke_table_cache(void)
+{
+	J_ASSERT(!jbd2_revoke_table_cache);
 	jbd2_revoke_table_cache = KMEM_CACHE(jbd2_revoke_table_s,
 					     SLAB_TEMPORARY);
-	if (!jbd2_revoke_table_cache)
-		goto table_cache_failure;
-	return 0;
-table_cache_failure:
-	jbd2_journal_destroy_revoke_caches();
-record_cache_failure:
+	if (!jbd2_revoke_table_cache) {
+		pr_emerg("JBD2: failed to create revoke_table cache\n");
 		return -ENOMEM;
+	}
+	return 0;
 }
 
 static struct jbd2_revoke_table_s *jbd2_journal_init_revoke_table(int hash_size)
diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index f940d31c2adc..8ca4fddc705f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -42,9 +42,11 @@ int __init jbd2_journal_init_transaction_cache(void)
 					0,
 					SLAB_HWCACHE_ALIGN|SLAB_TEMPORARY,
 					NULL);
-	if (transaction_cache)
-		return 0;
-	return -ENOMEM;
+	if (!transaction_cache) {
+		pr_emerg("JBD2: failed to create transaction cache\n");
+		return -ENOMEM;
+	}
+	return 0;
 }
 
 void jbd2_journal_destroy_transaction_cache(void)
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index c2ffff5f9ae2..6c9870e16b19 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1318,7 +1318,7 @@ extern void		__wait_on_journal (journal_t *);
 
 /* Transaction cache support */
 extern void jbd2_journal_destroy_transaction_cache(void);
-extern int  jbd2_journal_init_transaction_cache(void);
+extern int __init jbd2_journal_init_transaction_cache(void);
 extern void jbd2_journal_free_transaction(transaction_t *);
 
 /*
@@ -1446,8 +1446,10 @@ static inline void jbd2_free_inode(struct jbd2_inode *jinode)
 /* Primary revoke support */
 #define JOURNAL_REVOKE_DEFAULT_HASH 256
 extern int	   jbd2_journal_init_revoke(journal_t *, int);
-extern void	   jbd2_journal_destroy_revoke_caches(void);
-extern int	   jbd2_journal_init_revoke_caches(void);
+extern void	   jbd2_journal_destroy_revoke_record_cache(void);
+extern void	   jbd2_journal_destroy_revoke_table_cache(void);
+extern int __init jbd2_journal_init_revoke_record_cache(void);
+extern int __init jbd2_journal_init_revoke_table_cache(void);
 
 extern void	   jbd2_journal_destroy_revoke(journal_t *);
 extern int	   jbd2_journal_revoke (handle_t *, unsigned long long, struct buffer_head *);
-- 
2.20.1

