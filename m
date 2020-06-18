Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1AC1FF6D1
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jun 2020 17:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbgFRP3i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 11:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbgFRP3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 11:29:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00351C06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so2686568pjb.5
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 08:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yCvNQG2eDte7phry8MD3FQlz8aCNKOB0pw/UKfg9jfU=;
        b=nNhgMchn1FjvB2ddMfTDeN7bCyUjzKjNPtJc8j6tztEfpWk1n2NGXbQmCtPk+tOywu
         QMs5kTcrZA+5Lw+9tlwiJcMKoouGzyZT8u2W6KxBgkgJkM5kDxQYb9apdis2lPC4Sh2I
         i/woDJc7wXPrZNJzxGmKqW6Qw4E10Gp7KmkC7yEQqgtAquyFTk2KlXCG/9Iy1Sqmk14n
         uFyBiCEgSqMgbqdNEwMdEEf9RunVwVJiaoizy2WyncBleN8j/2+dTBQru2NLZwKLQFuC
         lSJQKmmoIYO4KSMo5paF0GCvxcGoWwBEc3zzeorGp3FZgBrRpg+UYFkkDEvRPk/1+ekK
         oo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yCvNQG2eDte7phry8MD3FQlz8aCNKOB0pw/UKfg9jfU=;
        b=EfTB2JbkGAXeBz6vMkDI3/fl9KuQgFGAXtG7BCeM4TDH0N2oMxT9Ph9JpYy98+X8PP
         BXmN7bWt1FoPZxTB/dzGidGj+zMcUeVQAd17dp+UA81mzNwoa2hg59Wg965uVs00wakQ
         NZlpP1YdAiCUnwvz66iNVBSdwmJS14JiftwZ//DFLJO8daj85IInasveLE7NjcMI9O8l
         CnX5Exe2Zl+z3cf5hcmEUHcIYwcWVtoc3e48I58ltERPWu/Nd0IzSEvVOgF2p6iAty7B
         7kSXmN912I/o0jcpTAwJGz9lOwD3aLykiGYi/5edxcas/sma0gwziAOEgpiGeSG3tokW
         bc9Q==
X-Gm-Message-State: AOAM53170pzBXblPq79l2IzU3e7/rLzQJq/SsuEP2uGfVDMUa7d/sCLM
        rSFQA1lTt388+5GbnXTmp7PTp+sbNac=
X-Google-Smtp-Source: ABdhPJzJbJxYF/s1Waq3ivTl+7sZag/LNea00QBco7L8/FHrnO7npXvOInaeuksiO9jN8b12b+vuCQ==
X-Received: by 2002:a17:902:8e82:: with SMTP id bg2mr4289752plb.198.1592494150200;
        Thu, 18 Jun 2020 08:29:10 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id y81sm3306650pfb.33.2020.06.18.08.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 08:29:09 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     lixi@ddn.com, adilger@dilger.ca, wangshilong1991@gmail.com,
        sihara@ddn.com, Wang Shilong <wshilong@ddn.com>
Subject: [RFC PATCH v2 24/51] e2fsck: merge dblist after thread finishes
Date:   Fri, 19 Jun 2020 00:27:27 +0900
Message-Id: <1592494074-28991-25-git-send-email-wangshilong1991@gmail.com>
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
 e2fsck/pass1.c      | 18 +++++++++++++-----
 lib/ext2fs/dblist.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  1 +
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index 3c04edfd..7accc76c 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2266,18 +2266,21 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2286,11 +2289,16 @@ static int _e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
index bbdb221d..046b1e68 100644
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
+	int			 size = src_count + dest_count;
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
index 5a094da3..37460a31 100644
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
2.25.4

