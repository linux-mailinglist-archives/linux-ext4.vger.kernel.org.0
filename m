Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B72C1A1EFF
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgDHKqU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35630 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id k5so3163656pga.2
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeYaeqeHKbr3ZeQnojCuWLsnAWyh32SFKAIBBhWg3Tw=;
        b=hJ+HoF2W37XF/se/2BM2PElP1tXHxLiHYlYhonKPO2vqp5KGeHsQKuwhs4pW2ztUTt
         U/Fee6DI0vsMiUu1Aj7bSL01qTEBDj0dBWVnJ+uIh9zXeDE18nrIhjfqHbz6UX/NJ8Nn
         zZJnem4akHuU9LPV30PXBh4cyv/62w48+PQ+Y9CZ3yTxza3ZKkBj4Qg/AjuSFRqGGbh6
         eiZ00AXlsZH2qMO2gxLGTs5y18I1KdIImTjRld2BSXbCumnUVfQVFNJZ3WX6bUXQEGTO
         Z2WcBp1mtzzS0mTGhc5PRz7Dlm4eF6qSW/fMCiWw6vmDEbwpUOg8RoDjyVzFa5wr2X0a
         ttiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeYaeqeHKbr3ZeQnojCuWLsnAWyh32SFKAIBBhWg3Tw=;
        b=KB7Rouzs17Jsp10kZc71W68V6ZVemlmlw3I41Myb7pEcOMckxEVqlWOMYLmSyFXw/N
         vAeKaAViFwPHz7XNEDu8wMhhWiIzcwg0BhVGrCueVYLJH69lRUoP0PlCXX3JzyqrLa0z
         PKAX7bFxZwRLpprbD0xgtWhbmzMttq0m6zhIQLEmC5gPKoLChkWaabto6gzAhWi7hOuH
         lQczWQeuk9u1VCkECZOFXG3bKb1BOz19cSHEyyu6lsRg9tfYhpljpcyF/qzyQAQncXvS
         t4wrrFqWfNMx0RwFoNpcg3AgLHnPfRTMml3Xzkvsq7re4ocAIkq4XMTUiGdPV51doaH7
         A/Lg==
X-Gm-Message-State: AGi0PuYqIWPY3k8/IE6/HurGi5nXC+L4oKh9daN3pn4uV/efgz356wrM
        Keh/UPZUobVoZ0ufg2U1fdfA9iXBJjo=
X-Google-Smtp-Source: APiQypIYfppn4soSmyCTuhiMihlJkBcNd3yp+B7kf8WNFvI4vw4Hjrl+GskqcWwJxqJQxNwVHu9l7g==
X-Received: by 2002:a62:2ad0:: with SMTP id q199mr7397721pfq.48.1586342777936;
        Wed, 08 Apr 2020 03:46:17 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:17 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 21/46] e2fsck: merge badblocks after thread finishes
Date:   Wed,  8 Apr 2020 19:44:49 +0900
Message-Id: <1586342714-12536-22-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
References: <1586342714-12536-1-git-send-email-wangshilong1991@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Li Xi <lixi@ddn.com>

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 e2fsck/pass1.c         |  8 ++++-
 lib/ext2fs/badblocks.c | 75 ++++++++++++++++++++++++++++++++++++++----
 lib/ext2fs/ext2fs.h    |  2 ++
 lib/ext2fs/ext2fsP.h   |  1 -
 4 files changed, 77 insertions(+), 9 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 56004c9b..79a9eddf 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2283,16 +2283,19 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	io_channel dest_image_io;
 	ext2fs_inode_bitmap inode_map;
 	ext2fs_block_bitmap block_map;
+	ext2_badblocks_list badblocks;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
 	inode_map = dest->inode_map;
 	block_map = dest->block_map;
+	badblocks = dest->badblocks;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
 	dest->inode_map = inode_map;
 	dest->block_map = block_map;
+	dest->badblocks = badblocks;
 	/*
 	 * PASS1_MERGE_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
@@ -2309,7 +2312,10 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	}
 
 	if (src->badblocks) {
-		retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		if (dest->badblocks == NULL)
+			retval = ext2fs_badblocks_copy(src->badblocks, &dest->badblocks);
+		else
+			retval = ext2fs_badblocks_merge(src->badblocks, dest->badblocks);
 		if (retval)
 			goto out_dblist;
 	}
diff --git a/lib/ext2fs/badblocks.c b/lib/ext2fs/badblocks.c
index 0f23983b..568634ff 100644
--- a/lib/ext2fs/badblocks.c
+++ b/lib/ext2fs/badblocks.c
@@ -11,6 +11,7 @@
 
 #include "config.h"
 #include <stdio.h>
+#include <assert.h>
 #include <string.h>
 #if HAVE_UNISTD_H
 #include <unistd.h>
@@ -56,6 +57,65 @@ static errcode_t make_u32_list(int size, int num, __u32 *list,
 	return 0;
 }
 
+/*
+ * Merge list from src to dest
+ */
+static errcode_t merge_u32_list(ext2_u32_list src, ext2_u32_list dest)
+{
+	errcode_t	 retval;
+	int		 src_count = src->num;
+	int		 dest_count = dest->num;
+	int		 size = src->size + dest->size;
+	int		 size_entry = sizeof(blk_t);
+	blk_t		*array;
+	blk_t		*array_ptr;
+	blk_t		*src_array = src->list;
+	blk_t		*dest_array = dest->list;
+	int		 src_index = 0;
+	int		 dest_index = 0;
+
+	if (src->num == 0)
+		return 0;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array_ptr = array;
+	/*
+	 * This can be improved by binary search and memcpy, but codes would
+	 * be complexer. And if number of bad blocks is small, the optimization
+	 * won't improve performance a lot.
+	 */
+	while (src_index < src_count || dest_index < dest_count) {
+		if (src_index >= src_count) {
+			memcpy(array_ptr, &dest_array[dest_index],
+			       (dest_count - dest_index) * size_entry);
+			break;
+		}
+		if (dest_index >= dest_count) {
+			memcpy(array_ptr, &src_array[src_index],
+			       (src_count - src_index) * size_entry);
+			break;
+		}
+		if (src_array[src_index] < dest_array[dest_index]) {
+			*array_ptr = src_array[src_index];
+			src_index++;
+		} else {
+			assert(src_array[src_index] > dest_array[dest_index]);
+			*array_ptr = dest_array[dest_index];
+			dest_index++;
+		}
+		array_ptr++;
+	}
+
+	ext2fs_free_mem(&dest->list);
+	dest->list = array;
+	dest->num = src_count + dest_count;
+	dest->size = size;
+	return 0;
+}
+
 
 /*
  * This procedure creates an empty u32 list.
@@ -79,13 +139,7 @@ errcode_t ext2fs_badblocks_list_create(ext2_badblocks_list *ret, int size)
  */
 errcode_t ext2fs_u32_copy(ext2_u32_list src, ext2_u32_list *dest)
 {
-	errcode_t	retval;
-
-	retval = make_u32_list(src->size, src->num, src->list, dest);
-	if (retval)
-		return retval;
-	(*dest)->badblocks_flags = src->badblocks_flags;
-	return 0;
+	return make_u32_list(src->size, src->num, src->list, dest);
 }
 
 errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
@@ -95,6 +149,13 @@ errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 			       (ext2_u32_list *) dest);
 }
 
+errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+				 ext2_badblocks_list dest)
+{
+	return merge_u32_list((ext2_u32_list) src,
+			      (ext2_u32_list) dest);
+}
+
 /*
  * This procedure frees a badblocks list.
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 2cc6d76e..1404e14a 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -814,6 +814,8 @@ extern int ext2fs_badblocks_list_iterate(ext2_badblocks_iterate iter,
 extern void ext2fs_badblocks_list_iterate_end(ext2_badblocks_iterate iter);
 extern errcode_t ext2fs_badblocks_copy(ext2_badblocks_list src,
 				       ext2_badblocks_list *dest);
+extern errcode_t ext2fs_badblocks_merge(ext2_badblocks_list src,
+					ext2_badblocks_list dest);
 extern int ext2fs_badblocks_equal(ext2_badblocks_list bb1,
 				  ext2_badblocks_list bb2);
 extern int ext2fs_u32_list_count(ext2_u32_list bb);
diff --git a/lib/ext2fs/ext2fsP.h b/lib/ext2fs/ext2fsP.h
index ad8b7d52..02df759a 100644
--- a/lib/ext2fs/ext2fsP.h
+++ b/lib/ext2fs/ext2fsP.h
@@ -34,7 +34,6 @@ struct ext2_struct_u32_list {
 	int	num;
 	int	size;
 	__u32	*list;
-	int	badblocks_flags;
 };
 
 struct ext2_struct_u32_iterate {
-- 
2.25.2

