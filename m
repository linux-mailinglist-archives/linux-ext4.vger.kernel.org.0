Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE41A1EFC
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDHKqN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id v23so2880508pfm.1
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ws6JihLZVQXUPNY9KIQBSbq4h/d2hpaWaq4K4VnEKlk=;
        b=ar0+YFrzoFrfQF7DPnQaqon/YhNJgQmNLrt5SOHhIWQTqH2UgjZsIQPMPAUTrYncLK
         chg9hiJy4MLDnBoZMceXhZtbZYTpGQqOk1OgjLXF85bT8yN4kVVW9gud/r2CRhdhSyOJ
         X5EEZ+fIZISKVWwEQ0IioXyFLQLGxrr0XubBZclPF42xW9XkrbQ+Tj0CYUItsygT9nDR
         5E58Opj2cImTV+zYUiEvElUyK5dYAy+7UxoEi6zFAt2LfG+q1w+EEWSRrJCJ1E6CUE8G
         MlYD4Y7ChIlSGyR000vD+skV+a2jbJkxrUigulnbDqVF4IuewsBMM6TQfCmIG7Ybq+BS
         o/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ws6JihLZVQXUPNY9KIQBSbq4h/d2hpaWaq4K4VnEKlk=;
        b=iujREvDiU6qmctAU98CTwaGWzbxlvGhzV2RlTJHZVofUP6wWpgbtA3HeY9pO8OwzP+
         1S7MUzeSz6vkLvvWfruJI/BG75furhkJuGytfIl+H6jf2LmpXtc4usiNiIpMCWRC7Chm
         Hexy48C6FHStJZwztMd7fHrPOJWk6ryujvPQ970ok5D78dlFZY9gkivhcDuAVeYLaEPp
         uL8tM5enQFry11Rhbt5kAnXNDv3d1FIQxLChTHrDHUnVZzJSS9shtWXrBGqhoVGdyb0m
         x+WA8pR7wbbyZSmwjMAkennMoibw1frXRgSDTm3SUn35VPHWyQeBIIKYcruirxCobm7F
         QwjA==
X-Gm-Message-State: AGi0PubBhjOroYsMT/oDeGrcw2HPz1mnhX/j7D9uVYg7FqKFUEY4Yiuo
        UXYAUp0xPE3P+Pf7DHQfVYpbcXgQ6Wk=
X-Google-Smtp-Source: APiQypIJBQT095vw4OQj7vyOXsWX7uFNYBdLh7FddyTqJLTDmOdgUldvkPg6EFTZlHG2fIC2xfHqzg==
X-Received: by 2002:aa7:984e:: with SMTP id n14mr7216167pfq.291.1586342771595;
        Wed, 08 Apr 2020 03:46:11 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:11 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 18/46] e2fsck: optimize the inserting of dir_info_db
Date:   Wed,  8 Apr 2020 19:44:46 +0900
Message-Id: <1586342714-12536-19-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Binary search is now used when inserting an dir info to the array.
Memmove is now used when moving array. Both of them improves
the performance of inserting.

This patch is also a prepartion for the merging of two dir db
arrays.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/dirinfo.c | 154 +++++++++++++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 58 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index cceadac3..c5183261 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -7,6 +7,7 @@
 
 #undef DIRINFO_DEBUG
 
+#include <assert.h>
 #include "config.h"
 #include "e2fsck.h"
 #include <sys/stat.h>
@@ -122,6 +123,89 @@ static void setup_db(e2fsck_t ctx)
 				       "directory map");
 }
 
+/*
+ * Return the min index that has ino larger or equal to @ino
+ * If not found, return -1
+ */
+static int e2fsck_dir_info_min_larger_equal(struct dir_info_db *dir_info,
+					    ext2_ino_t ino)
+{
+	int		low = 0;
+	int		high = dir_info->count - 1;
+	int		mid;
+	int		tmp_ino;
+	int 		index = -1;
+
+	while (low <= high) {
+		mid = (low + high) / 2;
+		tmp_ino = dir_info->array[mid].ino;
+		if (ino == tmp_ino) {
+			return mid;
+		} else if (ino < tmp_ino) {
+			/*
+			 * The mid ino is larger than @ino, remember the index
+			 * here so we won't miss this ino
+			 */
+			index = mid;
+			high = mid - 1;
+		} else {
+			low = mid + 1;
+		}
+	}
+	return index;
+}
+
+/*
+ *
+ * Insert an inode into the sorted array. The array should have at least one
+ * free slot.
+ *
+ * Normally, add_dir_info is called with each inode in
+ * sequential order; but once in a while (like when pass 3
+ * needs to recreate the root directory or lost+found
+ * directory) it is called out of order.  In those cases, we
+ * need to move the dir_info entries down to make room, since
+ * the dir_info array needs to be sorted by inode number for
+ * get_dir_info()'s sake.
+ */
+static void e2fsck_insert_dir_info(struct dir_info_db *dir_info, ext2_ino_t ino, ext2_ino_t parent)
+{
+	int			 index;
+	struct dir_info		*dir;
+	int			 dir_size = sizeof(*dir);
+	struct dir_info		*array = dir_info->array;
+	int			 array_count = dir_info->count;
+
+	/*
+	 * Removing this check won't break anything. But since seqential ino
+	 * inserting happens a lot, this check avoids binary search.
+	 */
+	if (array_count == 0 || array[array_count - 1].ino < ino) {
+		dir = &array[array_count];
+		dir_info->count++;
+		goto out;
+	}
+
+	index = e2fsck_dir_info_min_larger_equal(dir_info, ino);
+	if (index >= 0 && array[index].ino == ino) {
+		dir = &array[index];
+		goto out;
+	}
+	if (index < 0) {
+		dir = &array[array_count];
+		dir_info->count++;
+		goto out;
+	}
+
+	dir = &array[index];
+	memmove((char *)dir + dir_size, dir, dir_size * (array_count - index));
+	dir_info->count++;
+out:
+	dir->ino = ino;
+	dir->dotdot = parent;
+	dir->parent = parent;
+}
+
 /*
  * This subroutine is called during pass1 to create a directory info
  * entry.  During pass1, the passed-in parent is 0; it will get filled
@@ -171,30 +255,7 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 	}
 #endif
 
-	/*
-	 * Normally, add_dir_info is called with each inode in
-	 * sequential order; but once in a while (like when pass 3
-	 * needs to recreate the root directory or lost+found
-	 * directory) it is called out of order.  In those cases, we
-	 * need to move the dir_info entries down to make room, since
-	 * the dir_info array needs to be sorted by inode number for
-	 * get_dir_info()'s sake.
-	 */
-	if (ctx->dir_info->count &&
-	    ctx->dir_info->array[ctx->dir_info->count-1].ino >= ino) {
-		for (i = ctx->dir_info->count-1; i > 0; i--)
-			if (ctx->dir_info->array[i-1].ino < ino)
-				break;
-		dir = &ctx->dir_info->array[i];
-		if (dir->ino != ino)
-			for (j = ctx->dir_info->count++; j > i; j--)
-				ctx->dir_info->array[j] = ctx->dir_info->array[j-1];
-	} else
-		dir = &ctx->dir_info->array[ctx->dir_info->count++];
-
-	dir->ino = ino;
-	dir->dotdot = parent;
-	dir->parent = parent;
+	e2fsck_insert_dir_info(ctx->dir_info, ino, parent);
 }
 
 /*
@@ -204,7 +265,7 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct dir_info_db	*db = ctx->dir_info;
-	int			low, high, mid;
+	int			 index;
 
 	if (!db)
 		return 0;
@@ -245,43 +306,20 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 	if (db->last_lookup && db->last_lookup->ino == ino)
 		return db->last_lookup;
 
-	low = 0;
-	high = ctx->dir_info->count-1;
-	if (ino == ctx->dir_info->array[low].ino) {
-#ifdef DIRINFO_DEBUG
-		printf("(%d,%d,%d)\n", ino,
-		       ctx->dir_info->array[low].dotdot,
-		       ctx->dir_info->array[low].parent);
-#endif
-		return &ctx->dir_info->array[low];
-	}
-	if (ino == ctx->dir_info->array[high].ino) {
-#ifdef DIRINFO_DEBUG
-		printf("(%d,%d,%d)\n", ino,
-		       ctx->dir_info->array[high].dotdot,
-		       ctx->dir_info->array[high].parent);
-#endif
-		return &ctx->dir_info->array[high];
-	}
+	index = e2fsck_dir_info_min_larger_equal(ctx->dir_info, ino);
+	if (index < 0)
+		return NULL;
 
-	while (low < high) {
-		mid = (low+high)/2;
-		if (mid == low || mid == high)
-			break;
-		if (ino == ctx->dir_info->array[mid].ino) {
+	assert(ino <= ctx->dir_info->array[index].ino);
+	if (ino == ctx->dir_info->array[index].ino) {
 #ifdef DIRINFO_DEBUG
-			printf("(%d,%d,%d)\n", ino,
-			       ctx->dir_info->array[mid].dotdot,
-			       ctx->dir_info->array[mid].parent);
+		printf("(%d,%d,%d)\n", ino,
+		       ctx->dir_info->array[index].dotdot,
+		       ctx->dir_info->array[index].parent);
 #endif
-			return &ctx->dir_info->array[mid];
-		}
-		if (ino < ctx->dir_info->array[mid].ino)
-			high = mid;
-		else
-			low = mid;
+		return &ctx->dir_info->array[index];
 	}
-	return 0;
+	return NULL;
 }
 
 static void e2fsck_put_dir_info(e2fsck_t ctx EXT2FS_NO_TDB_UNUSED,
-- 
2.25.2

