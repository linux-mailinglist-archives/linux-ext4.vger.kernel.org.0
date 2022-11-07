Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F761F30B
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 13:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiKGMZ6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 07:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiKGMZs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 07:25:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FE81B7B0
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 04:25:47 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id b62so10343361pgc.0
        for <linux-ext4@vger.kernel.org>; Mon, 07 Nov 2022 04:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH41vIADdp8GYBWaniI1xQi/8RWi01qwqHeYVy9cqW8=;
        b=er3aEvYPolTY4NH1Hckj4KznF3Ssal87y5sDo7wT3LkS/E1EbkRkq6EnTKhm3dJdg/
         JyMRisY1Ev/92wOv6N/T/BJn0mf6AE0Ia4i0S4hKGokrm4d2vtaf0QxfxqP6Zu10dVRT
         kdsGMa4otqTA6E8sJDwU5SgUALbdD7nntmheV8ZkYxPukbum0th9O18MriVPV3e5IXuf
         xN1k80UE7rp/OdyRGV3OAC1PiMaoAT+uFmkxIKYYPpbbMkM1LwG8yRthBwKXaPCAuTJG
         mSOp4nRu1uhj/8WNT5n3FM2ZyoiA/kQGMy068qJ//0pmAcnYW/uJaGu1Rv/7m1wwqhn9
         4nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mH41vIADdp8GYBWaniI1xQi/8RWi01qwqHeYVy9cqW8=;
        b=69xzIZTuS6jUBxDNJsUg/o6eNyixz1tlPcoirCzYAdqNDyp0p6E4MNVtjf4r7q4BA2
         i4Bru/AZXVvWoGNKX4mbwjbSLc+ueJ8l4TpG4BWeRyns0FaCsFPQhzEgrwV2jazCrHko
         iIh8cdrdB9kiKCSJ9BppiRn2yPZd0KuE7ezfKoXQNWct9hXU8FgH2fApD0QlsTQ9KAkW
         RQt6onAoHJywo+VRvfIB5yD7dzX/Igjpl8gowGDt12A8AVPpN2l1hcZMyAG5AjhJqjki
         gxtEObN5uuBXJQ9NH612Qqvp2qVGMPyn7A0Gx6K9IcFp3gArSJZ3ercFRrYZPIoVzAt6
         HctQ==
X-Gm-Message-State: ACrzQf2YgD00KPL3dFRyBKg/pp4r2GcLwdpTFl4hZ387CgI8dXQ5qSez
        eBSQ2/ab9i4PDoX0+FA/AP0=
X-Google-Smtp-Source: AMsMyM7CGJfNt0VTMJ1xKpvMWYmvOSVXBzxQU/Wq0cZcqlxf2byfpkhp1kfpfpD4pyijtZfcpuUAZg==
X-Received: by 2002:a05:6a00:1749:b0:56e:4586:4bc1 with SMTP id j9-20020a056a00174900b0056e45864bc1mr23091079pfc.41.1667823946802;
        Mon, 07 Nov 2022 04:25:46 -0800 (PST)
Received: from localhost ([2406:7400:63:f20b:312d:45b2:85c1:c486])
        by smtp.gmail.com with ESMTPSA id z11-20020aa79e4b000000b0056e8eb09d57sm4377459pfq.63.2022.11.07.04.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 04:25:46 -0800 (PST)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFCv1 33/72] e2fsck: optimize the inserting of dir_info_db
Date:   Mon,  7 Nov 2022 17:51:21 +0530
Message-Id: <b06d87088940bddfe0864a2b927c9b0482c6b792.1667822611.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667822611.git.ritesh.list@gmail.com>
References: <cover.1667822611.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 e2fsck/dirinfo.c | 172 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 60 deletions(-)

diff --git a/e2fsck/dirinfo.c b/e2fsck/dirinfo.c
index 49d624c5..5c360a90 100644
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
+	ext2_ino_t index;
+	struct dir_info *dir;
+	size_t dir_size = sizeof(*dir);
+	struct dir_info *array = dir_info->array;
+	ext2_ino_t array_count = dir_info->count;
+	int err;
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
2.37.3

