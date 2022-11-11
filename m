Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F716259C4
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Nov 2022 12:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbiKKLtP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Nov 2022 06:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiKKLtI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Nov 2022 06:49:08 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB17E532F7
        for <linux-ext4@vger.kernel.org>; Fri, 11 Nov 2022 03:49:06 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N7xjj4lHszJnW5;
        Fri, 11 Nov 2022 19:46:01 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 11 Nov 2022 19:49:05 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 11 Nov
 2022 19:49:04 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <snitzer@kernel.org>, <Martin.Wilck@suse.com>, <ejt@redhat.com>,
        <jack@suse.cz>, <tytso@mit.edu>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>
CC:     <dm-devel@redhat.com>, <linux-ext4@vger.kernel.org>
Subject: [dm-devel] [PATCH 2/3] dm bufio: Split main logic out of dm_bufio_client creation/destroy
Date:   Fri, 11 Nov 2022 20:10:28 +0800
Message-ID: <20221111121029.3985561-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221111121029.3985561-1-chengzhihao1@huawei.com>
References: <20221111121029.3985561-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Split main logic excepts shrinker register/unregister out of
dm_bufio_client creation/destroy, the extracted code is wrapped
into new helpers __do_init and __do_destroy.
This commit is prepare to support dm_bufio_client resetting.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/md/dm-bufio.c    | 144 +++++++++++++++++++++++++++------------
 include/linux/dm-bufio.h |   4 +-
 2 files changed, 101 insertions(+), 47 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index bb786c39545e..5859d69d6944 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1731,31 +1731,17 @@ static unsigned long dm_bufio_shrink_count(struct shrinker *shrink, struct shrin
 	return count;
 }
 
-/*
- * Create the buffering interface
- */
-struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsigned block_size,
-					       unsigned reserved_buffers, unsigned aux_size,
-					       void (*alloc_callback)(struct dm_buffer *),
-					       void (*write_callback)(struct dm_buffer *),
-					       unsigned int flags)
-{
-	int r;
-	struct dm_bufio_client *c;
-	unsigned i;
+static int __do_init(struct dm_bufio_client *c, struct block_device *bdev,
+		     unsigned int block_size, unsigned int reserved_buffers,
+		     unsigned int aux_size,
+		     void (*alloc_callback)(struct dm_buffer *),
+		     void (*write_callback)(struct dm_buffer *),
+		     unsigned int flags)
+{
+	int r = 0;
+	unsigned int i;
 	char slab_name[27];
 
-	if (!block_size || block_size & ((1 << SECTOR_SHIFT) - 1)) {
-		DMERR("%s: block size not specified or is not multiple of 512b", __func__);
-		r = -EINVAL;
-		goto bad_client;
-	}
-
-	c = kzalloc(sizeof(*c), GFP_KERNEL);
-	if (!c) {
-		r = -ENOMEM;
-		goto bad_client;
-	}
 	c->buffer_tree = RB_ROOT;
 
 	c->bdev = bdev;
@@ -1829,6 +1815,63 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	INIT_WORK(&c->shrink_work, shrink_work);
 	atomic_long_set(&c->need_shrink, 0);
 
+	return 0;
+
+bad:
+	while (!list_empty(&c->reserved_buffers)) {
+		struct dm_buffer *b = list_entry(c->reserved_buffers.next,
+						 struct dm_buffer, lru_list);
+		list_del(&b->lru_list);
+		free_buffer(b);
+	}
+	kmem_cache_destroy(c->slab_cache);
+	c->slab_cache = NULL;
+	kmem_cache_destroy(c->slab_buffer);
+	c->slab_buffer = NULL;
+	dm_io_client_destroy(c->dm_io);
+bad_dm_io:
+	c->dm_io = NULL;
+	mutex_destroy(&c->lock);
+	c->need_reserved_buffers = 0;
+	if (c->no_sleep) {
+		static_branch_dec(&no_sleep_enabled);
+		c->no_sleep = false;
+	}
+	return r;
+}
+
+/*
+ * Create the buffering interface
+ */
+struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev,
+					       unsigned int block_size,
+					       unsigned int reserved_buffers,
+					       unsigned int aux_size,
+					       void (*alloc_callback)(struct dm_buffer *),
+					       void (*write_callback)(struct dm_buffer *),
+					       unsigned int flags)
+{
+	int r;
+	struct dm_bufio_client *c;
+	char slab_name[27];
+
+	if (!block_size || block_size & ((1 << SECTOR_SHIFT) - 1)) {
+		DMERR("%s: block size not specified or is not multiple of 512b", __func__);
+		r = -EINVAL;
+		goto bad_client;
+	}
+
+	c = kzalloc(sizeof(*c), GFP_KERNEL);
+	if (!c) {
+		r = -ENOMEM;
+		goto bad_client;
+	}
+
+	r = __do_init(c, bdev, block_size, reserved_buffers, aux_size,
+		      alloc_callback, write_callback, flags);
+	if (r)
+		goto bad_do_init;
+
 	c->shrinker.count_objects = dm_bufio_shrink_count;
 	c->shrinker.scan_objects = dm_bufio_shrink_scan;
 	c->shrinker.seeks = 1;
@@ -1856,36 +1899,19 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 	kmem_cache_destroy(c->slab_cache);
 	kmem_cache_destroy(c->slab_buffer);
 	dm_io_client_destroy(c->dm_io);
-bad_dm_io:
 	mutex_destroy(&c->lock);
 	if (c->no_sleep)
 		static_branch_dec(&no_sleep_enabled);
+bad_do_init:
 	kfree(c);
 bad_client:
 	return ERR_PTR(r);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_client_create);
 
-/*
- * Free the buffering interface.
- * It is required that there are no references on any buffers.
- */
-void dm_bufio_client_destroy(struct dm_bufio_client *c)
+static void __do_destroy(struct dm_bufio_client *c)
 {
-	unsigned i;
-
-	drop_buffers(c);
-
-	unregister_shrinker(&c->shrinker);
-	flush_work(&c->shrink_work);
-
-	mutex_lock(&dm_bufio_clients_lock);
-
-	list_del(&c->client_list);
-	dm_bufio_client_count--;
-	__cache_size_refresh();
-
-	mutex_unlock(&dm_bufio_clients_lock);
+	unsigned int i;
 
 	BUG_ON(!RB_EMPTY_ROOT(&c->buffer_tree));
 	BUG_ON(c->need_reserved_buffers);
@@ -1905,11 +1931,39 @@ void dm_bufio_client_destroy(struct dm_bufio_client *c)
 		BUG_ON(c->n_buffers[i]);
 
 	kmem_cache_destroy(c->slab_cache);
+	c->slab_cache = NULL;
 	kmem_cache_destroy(c->slab_buffer);
-	dm_io_client_destroy(c->dm_io);
+	c->slab_buffer = NULL;
+	if (c->dm_io) {
+		dm_io_client_destroy(c->dm_io);
+		c->dm_io = NULL;
+	}
 	mutex_destroy(&c->lock);
-	if (c->no_sleep)
+	if (c->no_sleep) {
 		static_branch_dec(&no_sleep_enabled);
+		c->no_sleep = false;
+	}
+}
+
+/*
+ * Free the buffering interface.
+ * It is required that there are no references on any buffers.
+ */
+void dm_bufio_client_destroy(struct dm_bufio_client *c)
+{
+	drop_buffers(c);
+
+	unregister_shrinker(&c->shrinker);
+	flush_work(&c->shrink_work);
+
+	mutex_lock(&dm_bufio_clients_lock);
+	list_del(&c->client_list);
+	dm_bufio_client_count--;
+	__cache_size_refresh();
+	mutex_unlock(&dm_bufio_clients_lock);
+
+	__do_destroy(c);
+
 	kfree(c);
 }
 EXPORT_SYMBOL_GPL(dm_bufio_client_destroy);
diff --git a/include/linux/dm-bufio.h b/include/linux/dm-bufio.h
index 15d9e15ca830..ee4f19c170ab 100644
--- a/include/linux/dm-bufio.h
+++ b/include/linux/dm-bufio.h
@@ -26,8 +26,8 @@ struct dm_buffer;
  * Create a buffered IO cache on a given device
  */
 struct dm_bufio_client *
-dm_bufio_client_create(struct block_device *bdev, unsigned block_size,
-		       unsigned reserved_buffers, unsigned aux_size,
+dm_bufio_client_create(struct block_device *bdev, unsigned int block_size,
+		       unsigned int reserved_buffers, unsigned int aux_size,
 		       void (*alloc_callback)(struct dm_buffer *),
 		       void (*write_callback)(struct dm_buffer *),
 		       unsigned int flags);
-- 
2.31.1

