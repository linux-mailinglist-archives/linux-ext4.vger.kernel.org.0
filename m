Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D191FF6B6
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbgFRP3E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731524AbgFRP27 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:28:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CE9C0613EE
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j12so716084pfn.10
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jD407iw4GPL2Bvrd/AZ6eu2gYx67VGCwMJid+Q+1gPw=;
        b=e4fF51EHArFSszRGTM+RfDzV/cEEg+9NnjULQZEsPAmZOvOeVD1TsdUOQuFIHfeu2X
         fEz5RKbzNrjuHjhbnDqKKm4WBusFBQJKbOxRsj8nSuEvneurT3n/mchh1wox7TKCJIst
         fEz7c+xhyQMcWDp9ppqilsAuJYWSIU5R9mg7wcTq4TQN93K2bfpNUNauQjjElK1JNEnf
         WFEeVkAk2717TaNG3eKbXqpWcyRbewmASE6ZTjV7wmrLpksOWTPnX46lDlQq9W2yyF57
         a8ZoMv3S5bm/lO0JZMK2t1J7sGAq/5HTb6MkK3N0fBFRlIGuEaCqkyqjWPA4P50gqNGG
         j8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jD407iw4GPL2Bvrd/AZ6eu2gYx67VGCwMJid+Q+1gPw=;
        b=SdIObTM+iRIoN4V5yOOwt1WYWk6oYBPI/9n4UYLoLmYfPjzM61YorAGTz8DPDOrnUB
         1LFgIK5HqDN1eQkCiKV/OuxTnriR++hhmZxzAiqhGXQc0feR8/QI6UBCXgt4OoiaDdqj
         LJR4M3TVG7YRjHQOqUbQzFw7q6Sqn8qSOZ/td7lEfxnOI9E06BFFMT+ZWTFbUa9zYMVA
         CXtDRjMmOk0CwaE3RDfFKlJJuygUWDX6f7LFhS1q2HZjJltZVQoZMkF3UvY7K5CBnDwd
         mNiwgLM5pTcknELXiEqDb/sSIe6lkMtyhADh8DEKjYaXVMMk4ACXXTlNlkDl+QRPQdjl
         0eSA==
X-Gm-Message-State: AOAM530IivrdttRfL9xj9x3CXtKUWWEfR8a5aGElBHHPR8pSFkFIKXHQ
        a7WXgMcyuPNvjpt+lleWUNBcelMesPQ=
X-Google-Smtp-Source: ABdhPJysSPhxo/9XmEZinN3VOUgadi/noSzBTJcjNl3yC6N8mp9bcIAgSGiw6PlEnQS7FzVhxdjimw==
X-Received: by 2002:a63:d918:: with SMTP id r24mr3763141pgg.119.1592494138412;
        Thu, 18 Jun 2020 08:28:58 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.28.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:28:57 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 19/51] e2fsck: optimize the inserting of dir_info_db
Date:   Fri, 19 Jun 2020 00:27:22 +0900
Message-Id: <1592494074-28991-20-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/dirinfo.c | 171 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 111 insertions(+), 60 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 49d624c5..f299620f 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -7,6 +7,7 @@
 
 #undef DIRINFO_DEBUG
 
+#include <assert.h>
 #include "config.h"
 #include "e2fsck.h"
 #include <sys/stat.h>
@@ -122,6 +123,103 @@ static void setup_db(e2fsck_t ctx)
 				       "directory map");
 }
 
+/*
+ * Return the min index that has ino larger or equal to @ino
+ * If not found, return -ENOENT
+ */
+static int
+e2fsck_dir_info_min_larger_equal(struct dir_info_db *dir_info,
+				 ext2_ino_t ino, ext2_ino_t *index)
+{
+	ext2_ino_t low = 0;
+	ext2_ino_t mid, high;
+	ext2_ino_t tmp_ino;
+	int found = 0;
+
+	if (dir_info->count == 0)
+		return -ENOENT;
+
+	high = dir_info->count - 1;
+	while (low <= high) {
+		mid = (low + high) / 2;
+		tmp_ino = dir_info->array[mid].ino;
+		if (ino == tmp_ino) {
+			*index = mid;
+			found = 1;
+			return 0;
+		} else if (ino < tmp_ino) {
+			/*
+			 * The mid ino is larger than @ino, remember the index
+			 * here so we won't miss this ino
+			 */
+			*index = mid;
+			found = 1;
+			if (mid == 0)
+				break;
+			high = mid - 1;
+		} else {
+			low = mid + 1;
+		}
+	}
+
+	if (found)
+		return 0;
+
+	return -ENOENT;
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
+	ext2_ino_t		index;
+	struct dir_info		*dir;
+	int			dir_size = sizeof(*dir);
+	struct dir_info		*array = dir_info->array;
+	ext2_ino_t		array_count = dir_info->count;
+	int			err;
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
+	err = e2fsck_dir_info_min_larger_equal(dir_info, ino, &index);
+	if (err >= 0 && array[index].ino == ino) {
+		dir = &array[index];
+		goto out;
+	}
+	if (err < 0) {
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
@@ -171,30 +269,7 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
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
@@ -204,7 +279,8 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct dir_info_db	*db = ctx->dir_info;
-	ext2_ino_t low, high, mid;
+	ext2_ino_t		index;
+	int			err;
 
 	if (!db)
 		return 0;
@@ -245,44 +321,19 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 	if (db->last_lookup && db->last_lookup->ino == ino)
 		return db->last_lookup;
 
-	low = 0;
-	high = ctx->dir_info->count - 1;
-	if (ino == ctx->dir_info->array[low].ino) {
-#ifdef DIRINFO_DEBUG
-		printf("(%u,%u,%u)\n", ino,
-		       ctx->dir_info->array[low].dotdot,
-		       ctx->dir_info->array[low].parent);
-#endif
-		return &ctx->dir_info->array[low];
-	}
-	if (ino == ctx->dir_info->array[high].ino) {
+	err = e2fsck_dir_info_min_larger_equal(ctx->dir_info, ino, &index);
+	if (err < 0)
+		return NULL;
+	assert(ino <= ctx->dir_info->array[index].ino);
+	if (ino == ctx->dir_info->array[index].ino) {
 #ifdef DIRINFO_DEBUG
-		printf("(%u,%u,%u)\n", ino,
-		       ctx->dir_info->array[high].dotdot,
-		       ctx->dir_info->array[high].parent);
+		printf("(%d,%d,%d)\n", ino,
+		       ctx->dir_info->array[index].dotdot,
+		       ctx->dir_info->array[index].parent);
 #endif
-		return &ctx->dir_info->array[high];
+		return &ctx->dir_info->array[index];
 	}
-
-	while (low < high) {
-		/* sum may overflow, but result will fit into mid again */
-		mid = (unsigned long long)(low + high) / 2;
-		if (mid == low || mid == high)
-			break;
-		if (ino == ctx->dir_info->array[mid].ino) {
-#ifdef DIRINFO_DEBUG
-			printf("(%u,%u,%u)\n", ino,
-			       ctx->dir_info->array[mid].dotdot,
-			       ctx->dir_info->array[mid].parent);
-#endif
-			return &ctx->dir_info->array[mid];
-		}
-		if (ino < ctx->dir_info->array[mid].ino)
-			high = mid;
-		else
-			low = mid;
-	}
-	return 0;
+	return NULL;
 }
 
 static void e2fsck_put_dir_info(e2fsck_t ctx EXT2FS_NO_TDB_UNUSED,
-- 
2.25.4

