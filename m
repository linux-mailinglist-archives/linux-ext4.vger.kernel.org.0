Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088CD3953B1
	for <lists+linux-ext4@lfdr.de>; Mon, 31 May 2021 03:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEaBeg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 May 2021 21:34:36 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2415 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbhEaBef (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 May 2021 21:34:35 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ftd493LFMz66wH
        for <linux-ext4@vger.kernel.org>; Mon, 31 May 2021 09:29:13 +0800 (CST)
Received: from dggpemm500014.china.huawei.com (7.185.36.153) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:32:55 +0800
Received: from [10.174.179.184] (10.174.179.184) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 09:32:54 +0800
Subject: [PATCH V2 10/12] hashmap: change return value type of,
 ext2fs_hashmap_add()
From:   Wu Guanghao <wuguanghao3@huawei.com>
To:     <linux-ext4@vger.kernel.org>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>
CC:     <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Message-ID: <48cc9049-3538-1010-f45a-2475a3ff5166@huawei.com>
Date:   Mon, 31 May 2021 09:32:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <00ad4a90-8a40-24c1-98d9-eb5f0da42436@huawei.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.184]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
