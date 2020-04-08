Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCC091A1F01
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Apr 2020 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDHKqX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Apr 2020 06:46:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgDHKqX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Apr 2020 06:46:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id 128so534078pge.12
        for <linux-ext4@vger.kernel.org>; Wed, 08 Apr 2020 03:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FMSn/bpiVdxm7dqeeMs1n0Fund38tS3pgY6V3KwE368=;
        b=eMaOsg34OG8dAGtclbrycjkU+OK97D8Z8Dtx/FmS044SgRh5ruFDvF418CPr1Tscum
         2hwdYPeVjVV/0bfYYxVpi+cDATPchAv2J0OpeEjn1x6wMTtrs8qhXugReludsqcwqO+U
         +cMMWn1B97YhB+XsYQcn6Y8bK1kBw4eDj6VLs4QBGLgx3uQU8tJsBLaGUIDlNa1NJJ8g
         xHCwOT1tb/4Qe1VedCdU4wqYkvE6ZX38PfaeEx65aN1XmO34f+t4hLUI9FUp+TBhD4bJ
         7AJ+WJzseI81jLPdkSVCkCPOAsJrsrcL33kxLkdZIDEFj7dd5Q/neIX6cs0s7HhzdZPk
         3t2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FMSn/bpiVdxm7dqeeMs1n0Fund38tS3pgY6V3KwE368=;
        b=Tb7lYqJym4wNQ9Wf/Btd6K8fgX/SW9D0hz7hUPYMeBnFFESxxecKbNIrCqki/eAC+v
         j3b+1u7isNLjLGPc33UCZ3HgCw3GIhvkrV5Q61HP6BTqeTw9V5iziBq38t6B8oOzg56r
         i7cb3Jl1XqPZn1wQoTNM/qTHdCDdO8juY4IQroLcH+yfANbwZBUIUCeYBS1QseEp5NGS
         +cGY/gpHyrsR4uObqn198HrHYCpP6ad4ezHQ8H84H4X9bHSYG71/V5Go72UqdZYLtpp0
         NL8Jmn1pjGxNWVovoS00HiB/PZ2ENvkmbmOhxZ0GGGInpBkU5Yql2Sm7YsgLPdZNBRml
         8I6A==
X-Gm-Message-State: AGi0PuaMpDHEaR7JWnWk6hyt5S8DThQwtF29s/+xUmULXshUHN8HE4Zf
        z/rjTc0BP+5KGQ+KDLoEeAlG9bnolD8=
X-Google-Smtp-Source: APiQypIasGoo2mn/UlhUjBP4KAZQBkZZmoIHGXbb3jiAibqsk4UMXfq/1mkfOdO5/xAcnxx0D25RMQ==
X-Received: by 2002:a62:ce8a:: with SMTP id y132mr6880613pfg.163.1586342782201;
        Wed, 08 Apr 2020 03:46:22 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y17sm16177024pfl.104.2020.04.08.03.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 03:46:21 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, sihara@ddn.com,
        Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH 23/46] e2fsck: merge dblist after thread finishes
Date:   Wed,  8 Apr 2020 19:44:51 +0900
Message-Id: <1586342714-12536-24-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c      | 18 +++++++++++++-----
 lib/ext2fs/dblist.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  1 +
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3501e2f7..1f47cbff 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2284,18 +2284,21 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	ext2fs_inode_bitmap inode_map;
 	ext2fs_block_bitmap block_map;
 	ext2_badblocks_list badblocks;
+	ext2_dblist dblist;
 
 	dest_io = dest->io;
 	dest_image_io = dest->image_io;
 	inode_map = dest->inode_map;
 	block_map = dest->block_map;
 	badblocks = dest->badblocks;
+	dblist = dest->dblist;
 	memcpy(dest, src, sizeof(struct struct_ext2_filsys));
 	dest->io = dest_io;
 	dest->image_io = dest_image_io;
 	dest->inode_map = inode_map;
 	dest->block_map = block_map;
 	dest->badblocks = badblocks;
+	dest->dblist = dblist;
 	/*
 	 * PASS1_MERGE_FS_BITMAP might return directly from this function,
 	 * so please do NOT leave any garbage behind after returning.
@@ -2304,11 +2307,16 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	PASS1_MERGE_FS_BITMAP(dest, src, block_map);
 
 	if (src->dblist) {
-		retval = ext2fs_copy_dblist(src->dblist, &dest->dblist);
-		if (retval)
-			return retval;
-		/* The ext2fs_copy_dblist() uses the src->fs as the fs */
-		dest->dblist->fs = dest;
+		if (dest->dblist) {
+			retval = ext2fs_merge_dblist(src->dblist, dest->dblist);
+			if (retval)
+				return retval;
+		} else {
+			/* The ext2fs_copy_dblist() uses the src->fs as the fs */
+			dest->dblist = src->dblist;
+			dest->dblist->fs = dest;
+			src->dblist = NULL;
+		}
 	}
 
 	if (src->badblocks) {
diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index bbdb221d..64caf843 100644
--- a/lib/ext2fs/dblist.c
+++ b/lib/ext2fs/dblist.c
@@ -119,6 +119,42 @@ errcode_t ext2fs_copy_dblist(ext2_dblist src, ext2_dblist *dest)
 	return 0;
 }
 
+/*
+ * Merge a directory block list @src to @dest
+ */
+errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest)
+{
+	int			 src_count = src->count;
+	int			 dest_count = dest->count;
+	int			 size = src->size + dest->size;
+	int			 size_entry = sizeof(struct ext2_db_entry2);
+	struct ext2_db_entry2	*array, *array2;
+	errcode_t		 retval;
+
+	if (src_count == 0)
+		return 0;
+
+	if (src->sorted || dest->sorted)
+		return EINVAL;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array2 = array;
+
+	memcpy(array, src->list, src_count * size_entry);
+	array += src_count;
+	memcpy(array, dest->list, dest_count * size_entry);
+	ext2fs_free_mem(&dest->list);
+
+	dest->list = array2;
+	dest->count = src_count + dest_count;
+	dest->size = size;
+
+	return 0;
+}
+
 /*
  * Close a directory block list
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index d4f6031a..6c872ed1 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1120,6 +1120,7 @@ extern errcode_t ext2fs_add_dir_block(ext2_dblist dblist, ext2_ino_t ino,
 				      blk_t blk, int blockcnt);
 extern errcode_t ext2fs_add_dir_block2(ext2_dblist dblist, ext2_ino_t ino,
 				       blk64_t blk, e2_blkcnt_t blockcnt);
+extern errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest);
 extern void ext2fs_dblist_sort(ext2_dblist dblist,
 			       EXT2_QSORT_TYPE (*sortfunc)(const void *,
 							   const void *));
-- 
2.25.2

