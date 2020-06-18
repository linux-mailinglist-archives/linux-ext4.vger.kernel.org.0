Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286FA1FF6CE
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgFRP3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731463AbgFRP3G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7871AC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so676489pls.5
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gOkfjlKRClr11rdyIbtSA0yZIIgBKtqX1TwSs84LoRY=;
        b=pRSooAmKZqkpcfqBUJW6F0C0cicbF/Q/ey/uehkDHMXwhCasfNqj0k4X4WS1EbTX8L
         KhVz0uzkbqJ5fHseRMmYQyya4zzlKPTmXKBtGUsk/icMkEuoSh3vOGt2QBib0WoZkdDr
         wyy5ITlrdyUx1f9WFCCI/sG236/TuU9W8m6LZILh5dOcoXMc95cX+Emb7v808J8uKR+c
         Dx/+1Z6i4iuuJ/IInPAwAZ5sWPi2A4Cr4dWA6XEWjX3XMVwweIz2zPHc0KM1f39nieoX
         xqqGvq4R7K7oFNlb8fHNcxaUVDlbm+d1xk/aic7I2QJv10KBDL/zDaq2Uy9bWW47M4xG
         7URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gOkfjlKRClr11rdyIbtSA0yZIIgBKtqX1TwSs84LoRY=;
        b=XxN0dUQVRTuZACmKoxaGOcbveDIMdm0Jz1eMAx7mljICbxYLVJZCt9KFa+OyUTIG+g
         bDbeVm00Wu26/sI1SMSW7IJqPiw9hfmqcEfNiA/XQlhEGYaUKjLN2CJ43dwdWfFB8Maq
         s+nJWPNr6Ie92iS7CXijE+QOKQuCXQWoliJsTLa8x/igRG0MZoKbZviOrMOIxeq2VC/S
         kNDjpTD7BkSxWDFdOSIC4RlDKo68A0XZGWc4WgPfOrtG5xjJ/B2jCEymxuLE8WgGvSIa
         q+pmtJHy5zJ16xpZR4Cw94pWWiyIoUvMkPk2A0WTmEm7S8QHH2eD9jShaRUFAYMVOQJr
         LdLg==
X-Gm-Message-State: AOAM533GjCnWL3OxSqSbCtaGD2mm1SzefM3sYe7XzQGrwXoPgR2Seej+
        sffIwlFyc7MOaTMOX9upaoXFc/K2D7Y=
X-Google-Smtp-Source: ABdhPJyJNuePyuVCqU9gyMB4hAr0zPWYihR4Ls6QtcPQxUh0RsG1b4D1N9zt67Qn9e4lqFmYOoQgQg==
X-Received: by 2002:a17:90a:7c07:: with SMTP id v7mr4727493pjf.38.1592494145473;
        Thu, 18 Jun 2020 08:29:05 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:04 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 22/51] e2fsck: merge badblocks after thread finishes
Date:   Fri, 19 Jun 2020 00:27:25 +0900
Message-Id: <1592494074-28991-23-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
References: <1592494074-28991-1-git-send-email-wangshilong1991@gmail.com>
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
index 7a839d4b..e343ec00 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2265,16 +2265,19 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2291,7 +2294,10 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
index 0f23983b..addc3d26 100644
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
+	int		 size = src_count + dest_count;
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
index d5b1af2f..bdb72251 100644
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
2.25.4

