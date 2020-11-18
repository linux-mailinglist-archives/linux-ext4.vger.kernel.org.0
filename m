Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16152B80CE
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgKRPk4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgKRPk4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:40:56 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC91C0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:56 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j12so1404239plj.20
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=9jrGCNRsBXFJQqCYwRQBYmUDmSfN/AuYXhamlTnyfhs=;
        b=P71L2gEdD+BeKAK0HYwSPsRe5/peghmLkSaOHKrVGdMobqvnSTbpqhug68acuM98St
         cTbgMtJYucpQ4OpOE5XeGXpM5ipeuJNRrLOBoYPoYcBM5AB1Byi2zETv2SzDo2VHpi5+
         UpiZI9m+/BGiD3bzhXPARF2ArRMnxB74ZwUuYilL+DCPVPYEe06Jt5RMqj/EPu15hyKZ
         mJouiMzOXecv2DW9CuKC2RQgOp/E8bOm+fo2mAttZuqIk4Kw0idsJgyG7RtepHhiByjb
         /59p/kEROoTn/IaZ3o3I04L29vhdcTQQVE7vlvxcBn9ynO7w/XPXbEEb8SywY6vmurnr
         w9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9jrGCNRsBXFJQqCYwRQBYmUDmSfN/AuYXhamlTnyfhs=;
        b=IayYsFOYnqcB0WNy4qSiD4Jq1GjzFWHtPu+wBh8kFLiFvOAztT7GHOI0CImhcRTw11
         P2DsGyJ1Y3CyaLxJiRRppX1F2+CzKTHriBDbuSEUbQrN0hvpY/4RAm8JzX9ATr/67igc
         pzE5jjpHkHKrXbizIZV9ccF+fDXtiBSjD7kQfdUfc3L/yNS08ZpMO9/A5hSvYtTxpNME
         UjBqRy5UQKKZupIruIOfUdCpnEP6KsN4Ji5JSLWxaPzKyZi76QP8UYnvTXBuieXLhhGD
         6L/MZCSMMWBmq3qFqHQ/0cRu8H6YE+tDlC6610V5ofbHCYgSAvcwqAUJst77KLY6J4sm
         UWHQ==
X-Gm-Message-State: AOAM533o7a6Q2OmV+2NQqtd0d5FVbQUMoBEzzQXTyxPAld+3RaMGlKsf
        TiMnE5D6l5mG6ZXauqd4jC00YlnMi46EE9BnUOvzzNPbPTwLTTlfl7Io1MiMiW1v1B0F2T1Szwl
        gtLbIIJd5kzoHbL1N4gc6yaYK8NMDyfz5CDxVVUhyJ/hso2GVuprCsbIVTAEODfPRxirZUytp+k
        Od2+uLAF0=
X-Google-Smtp-Source: ABdhPJxCTR3h6qOXxtdM2gC4J0ZCIC0sJzilBgzL9JE3tEwapyXcKoAhSIaDWVLBNqSSvLZyKUk6F7vWV6LKkDarfBI=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:a62:5c87:0:b029:197:5f13:b66c with
 SMTP id q129-20020a625c870000b02901975f13b66cmr4857020pfb.73.1605714055709;
 Wed, 18 Nov 2020 07:40:55 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:02 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-17-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 16/61] e2fsck: optimize the inserting of dir_info_db
From:   Saranya Muruganandam <saranyamohan@google.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>,
        Saranya Muruganandam <saranyamohan@google.com>
Content-Type: text/plain; charset="UTF-8"
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
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/dirinfo.c | 172 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 60 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 49d624c5..28baaca2 100644
--- a/e2fsck/dirinfo.c
+++ b/e2fsck/dirinfo.c
@@ -7,6 +7,7 @@
 
 #undef DIRINFO_DEBUG
 
+#include <assert.h>
 #include "config.h"
 #include "e2fsck.h"
 #include <sys/stat.h>
@@ -122,6 +123,104 @@ static void setup_db(e2fsck_t ctx)
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
+		/* sum may overflow, but result will fit into mid again */
+		mid = (unsigned long long)(low + high) / 2;
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
+	size_t			dir_size = sizeof(*dir);
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
@@ -171,30 +270,7 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
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
@@ -204,7 +280,8 @@ void e2fsck_add_dir_info(e2fsck_t ctx, ext2_ino_t ino, ext2_ino_t parent)
 static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 {
 	struct dir_info_db	*db = ctx->dir_info;
-	ext2_ino_t low, high, mid;
+	ext2_ino_t		index;
+	int			err;
 
 	if (!db)
 		return 0;
@@ -245,44 +322,19 @@ static struct dir_info *e2fsck_get_dir_info(e2fsck_t ctx, ext2_ino_t ino)
 	if (db->last_lookup && db->last_lookup->ino == ino)
 		return db->last_lookup;
 
-	low = 0;
-	high = ctx->dir_info->count - 1;
-	if (ino == ctx->dir_info->array[low].ino) {
+	err = e2fsck_dir_info_min_larger_equal(ctx->dir_info, ino, &index);
+	if (err < 0)
+		return NULL;
+	assert(ino <= ctx->dir_info->array[index].ino);
+	if (ino == ctx->dir_info->array[index].ino) {
 #ifdef DIRINFO_DEBUG
-		printf("(%u,%u,%u)\n", ino,
-		       ctx->dir_info->array[low].dotdot,
-		       ctx->dir_info->array[low].parent);
+		printf("(%d,%d,%d)\n", ino,
+		       ctx->dir_info->array[index].dotdot,
+		       ctx->dir_info->array[index].parent);
 #endif
-		return &ctx->dir_info->array[low];
+		return &ctx->dir_info->array[index];
 	}
-	if (ino == ctx->dir_info->array[high].ino) {
-#ifdef DIRINFO_DEBUG
-		printf("(%u,%u,%u)\n", ino,
-		       ctx->dir_info->array[high].dotdot,
-		       ctx->dir_info->array[high].parent);
-#endif
-		return &ctx->dir_info->array[high];
-	}
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
2.29.2.299.gdc1121823c-goog

