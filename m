Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7086E3B7EF3
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 10:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbhF3IaR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 04:30:17 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:9329 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbhF3IaO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 04:30:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GFDrM02kKz74JB
        for <linux-ext4@vger.kernel.org>; Wed, 30 Jun 2021 16:23:31 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:27:34 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500014.china.huawei.com
 (7.185.36.153) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 30 Jun
 2021 16:27:34 +0800
From:   wuguanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wuguanghao3@huawei.com>
Subject: [PATCH v2 10/12] hashmap: change return value type of ext2fs_hashmap_add()
Date:   Wed, 30 Jun 2021 16:27:22 +0800
Message-ID: <20210630082724.50838-11-wuguanghao3@huawei.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210630082724.50838-2-wuguanghao3@huawei.com>
References: <20210630082724.50838-2-wuguanghao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

In ext2fs_hashmap_add(), new entry is allocated by calling
malloc(). If malloc() return NULL, it will cause a
segmentation fault problem.

Here, we change return value type of ext2fs_hashmap_add()
from void to int. If allocating new entry fails, we will
return 1, and the callers should also verify the return
value of ext2fs_hashmap_add().

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: Wu Guanghao <wuguanghao3@huawei.com>
---
 contrib/android/base_fs.c | 12 +++++++++---
 lib/ext2fs/fileio.c       | 10 ++++++++--
 lib/ext2fs/hashmap.c      | 12 ++++++++++--
 lib/ext2fs/hashmap.h      |  4 ++--
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/contrib/android/base_fs.c b/contrib/android/base_fs.c
index 652317e2..d3e00d18 100644
--- a/contrib/android/base_fs.c
+++ b/contrib/android/base_fs.c
@@ -110,10 +110,16 @@ struct ext2fs_hashmap *basefs_parse(const char *file, const char *mountpoint)
 	if (!entries)
 		goto end;
 
-	while ((entry = basefs_readline(f, mountpoint, &err)))
-		ext2fs_hashmap_add(entries, entry, entry->path,
+	while ((entry = basefs_readline(f, mountpoint, &err))) {
+		err = ext2fs_hashmap_add(entries, entry, entry->path,
 				   strlen(entry->path));
-
+		if (err) {
+			free_base_fs_entry(entry);
+			fclose(f);
+			ext2fs_hashmap_free(entries);
+			return NULL;
+		}
+	}
 	if (err) {
 		fclose(f);
 		ext2fs_hashmap_free(entries);
diff --git a/lib/ext2fs/fileio.c b/lib/ext2fs/fileio.c
index a0b5d971..818f7f05 100644
--- a/lib/ext2fs/fileio.c
+++ b/lib/ext2fs/fileio.c
@@ -475,8 +475,14 @@ errcode_t ext2fs_file_write(ext2_file_t file, const void *buf,
 
 			if (new_block) {
 				new_block->physblock = file->physblock;
-				ext2fs_hashmap_add(fs->block_sha_map, new_block,
-					new_block->sha, sizeof(new_block->sha));
+				int ret = ext2fs_hashmap_add(fs->block_sha_map,
+						new_block, new_block->sha,
+						sizeof(new_block->sha));
+				if (ret) {
+					retval = EXT2_ET_NO_MEMORY;
+					free(new_block);
+					goto fail;
+				}
 			}
 
 			if (bmap_flags & BMAP_SET) {
diff --git a/lib/ext2fs/hashmap.c b/lib/ext2fs/hashmap.c
index ffe61ce9..7278edaf 100644
--- a/lib/ext2fs/hashmap.c
+++ b/lib/ext2fs/hashmap.c
@@ -36,6 +36,9 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
 {
 	struct ext2fs_hashmap *h = calloc(sizeof(struct ext2fs_hashmap) +
 				sizeof(struct ext2fs_hashmap_entry) * size, 1);
+	if (!h)
+		return NULL;
+
 	h->size = size;
 	h->free = free_fct;
 	h->hash = hash_fct;
@@ -43,12 +46,15 @@ struct ext2fs_hashmap *ext2fs_hashmap_create(
 	return h;
 }
 
-void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
-			size_t key_len)
+int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
+		void *data, const void *key, size_t key_len)
 {
 	uint32_t hash = h->hash(key, key_len) % h->size;
 	struct ext2fs_hashmap_entry *e = malloc(sizeof(*e));
 
+	if (!e)
+		return -1;
+
 	e->data = data;
 	e->key = key;
 	e->key_len = key_len;
@@ -62,6 +68,8 @@ void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
 	h->first = e;
 	if (!h->last)
 		h->last = e;
+
+	return 0;
 }
 
 void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
diff --git a/lib/ext2fs/hashmap.h b/lib/ext2fs/hashmap.h
index dcfa7455..0c09d2bd 100644
--- a/lib/ext2fs/hashmap.h
+++ b/lib/ext2fs/hashmap.h
@@ -27,8 +27,8 @@ struct ext2fs_hashmap_entry {
 struct ext2fs_hashmap *ext2fs_hashmap_create(
 				uint32_t(*hash_fct)(const void*, size_t),
 				void(*free_fct)(void*), size_t size);
-void ext2fs_hashmap_add(struct ext2fs_hashmap *h, void *data, const void *key,
-			size_t key_len);
+int ext2fs_hashmap_add(struct ext2fs_hashmap *h,
+		       void *data, const void *key,size_t key_len);
 void *ext2fs_hashmap_lookup(struct ext2fs_hashmap *h, const void *key,
 			    size_t key_len);
 void *ext2fs_hashmap_iter_in_order(struct ext2fs_hashmap *h,
-- 
2.19.1

