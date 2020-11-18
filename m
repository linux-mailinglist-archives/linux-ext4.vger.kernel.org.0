Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1982B80D6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Nov 2020 16:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgKRPlG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 10:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKRPlG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 10:41:06 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9AC0613D4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id u19so1573318qvx.4
        for <linux-ext4@vger.kernel.org>; Wed, 18 Nov 2020 07:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ADzWWIbV4bZJ8NdKcONNs35fekjgKDCN5MShyNoNJbQ=;
        b=pXUfNIDWimaahb1A/Khf6m26p1q6KND3vqTohWbSxwFyHQrMbeQjIV8+0j4AN7j++a
         sMoDs2twKXt/71Px6OH1ISPVjVZ+qaY+c2laIPzDymXrSWYi+68HL0+jVSAFFUXe2cDU
         ThXR3H/epxoK6MMj2uOB0IlEkYTKH2sPMT1NkJLwye/K8jCk3x0FWQhMeaqyxfXsxxYl
         qNWN57qUTBn5K65obREMd8Dx6rmmh29TdblKU3n/pWnAd8GADkUvAz+qXdF7hlrCvz9p
         i7MFPyYSsIPQD96ItsF/0mQepgji0I4Wx/QUC9qnqHEIAD96ILDGZsVUmDnRgjr68ntj
         GyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ADzWWIbV4bZJ8NdKcONNs35fekjgKDCN5MShyNoNJbQ=;
        b=gxSVwja/8txwr4oG9jg25tsjo50E3GBN/2G9FiWmKaPcrxbBGqyzXR7B4uePQOo3al
         qBl44rfnJS22LCiWu1/dARgXhLxy9OCEcHQ4sn0mX0TQyjcrGKi8Kan2/yWUJ0tMgofd
         BL5CYP6DRKdK8YxxkX9yV/Kh7A9hfYiOW8OXZwGlzD24JvlFNpMfXbgYiq72iB06UEab
         XTUEO8NEicQhbA50crhQVAg0Rw1VdvrKOBRhrAqkfg/35NGwXN4QgdD2F0dpn/nrNxmg
         ayOORSAnaHL7ueSCqN2mlnH3ROOCynQQWEexZntCe3mzpiEgtY5k4n7ocys6LAuiNvLH
         n49Q==
X-Gm-Message-State: AOAM530jwWhWX0Mj5Dr6MzGj55k378UUFJSUJjGuAjnSnNLlciG4OHDY
        tZHD3ad0fAswMji16hEv6csLLRdovGwlyzQBOJxQ57LCinoIQbEPeFfbkVHPAQFhYNd8Lc/iqsA
        UispgOsvnsduubctGjiyp7LMFoah+p7EcLTDPrxeIFYQ2ShW73wOrmXNDTLcPLQzXHVeBQ0G1vq
        N2rE//tuU=
X-Google-Smtp-Source: ABdhPJxjffYdN+iwhyvG8Rri3sB8dLnwgkMpGfcO9NHK2pbyUOw7tvCX8o1cNrvMH7pJYG6eNw2K7V6xjVOZTAv9TTs=
Sender: "saranyamohan via sendgmr" 
        <saranyamohan@saranyamohan.svl.corp.google.com>
X-Received: from saranyamohan.svl.corp.google.com ([100.116.76.178])
 (user=saranyamohan job=sendgmr) by 2002:ad4:45eb:: with SMTP id
 q11mr5533170qvu.20.1605714064894; Wed, 18 Nov 2020 07:41:04 -0800 (PST)
Date:   Wed, 18 Nov 2020 07:39:07 -0800
In-Reply-To: <20201118153947.3394530-1-saranyamohan@google.com>
Message-Id: <20201118153947.3394530-22-saranyamohan@google.com>
Mime-Version: 1.0
References: <20201118153947.3394530-1-saranyamohan@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH v3 21/61] e2fsck: merge dblist after thread finishes
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

Merge dblist properly.

Signed-off-by: Li Xi <lixi@ddn.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
---
 e2fsck/pass1.c      | 19 +++++++++++++++++++
 lib/ext2fs/dblist.c | 36 ++++++++++++++++++++++++++++++++++++
 lib/ext2fs/ext2fs.h |  1 +
 3 files changed, 56 insertions(+)

diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
index cdecd7c2..75298d9d 100644
--- a/e2fsck/pass1.c
+++ b/e2fsck/pass1.c
@@ -2244,12 +2244,14 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
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
@@ -2258,6 +2260,7 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	dest->inode_map = inode_map;
 	dest->block_map = block_map;
 	dest->badblocks = badblocks;
+	dest->dblist = dblist;
 	if (dest->dblist)
 		dest->dblist->fs = dest;
 
@@ -2276,6 +2279,19 @@ static int e2fsck_pass1_merge_fs(ext2_filsys dest, ext2_filsys src)
 	if (retval)
 		goto out;
 
+	if (src->dblist) {
+		if (dest->dblist) {
+			retval = ext2fs_merge_dblist(src->dblist,
+						     dest->dblist);
+			if (retval)
+				goto out;
+		} else {
+			dest->dblist = src->dblist;
+			dest->dblist->fs = dest;
+			src->dblist = NULL;
+		}
+	}
+
 	if (src->badblocks) {
 		if (dest->badblocks == NULL)
 			retval = ext2fs_badblocks_copy(src->badblocks,
@@ -2292,6 +2308,9 @@ out:
 		ext2fs_free_generic_bmap(src->block_map);
 	if (src->badblocks)
 		ext2fs_badblocks_list_free(src->badblocks);
+	if (src->dblist)
+		ext2fs_free_dblist(src->dblist);
+
 	return retval;
 }
 
diff --git a/lib/ext2fs/dblist.c b/lib/ext2fs/dblist.c
index bbdb221d..1fdd8f43 100644
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
+	unsigned long long src_count = src->count;
+	unsigned long long dest_count = dest->count;
+	unsigned long long size = src_count + dest_count;
+	size_t size_entry = sizeof(struct ext2_db_entry2);
+	struct ext2_db_entry2 *array, *array2;
+	errcode_t retval;
+
+	if (src_count == 0)
+		return 0;
+
+	if (src->sorted || (dest->sorted && dest_count != 0))
+		return EINVAL;
+
+	retval = ext2fs_get_array(size, size_entry, &array);
+	if (retval)
+		return retval;
+
+	array2 = array;
+	memcpy(array, src->list, src_count * size_entry);
+	array += src_count;
+	memcpy(array, dest->list, dest_count * size_entry);
+	ext2fs_free_mem(&dest->list);
+
+	dest->list = array2;
+	dest->count = src_count + dest_count;
+	dest->size = size;
+	dest->sorted = 0;
+
+	return 0;
+}
+
 /*
  * Close a directory block list
  *
diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 28662d44..0fa0e22f 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1122,6 +1122,7 @@ extern errcode_t ext2fs_add_dir_block(ext2_dblist dblist, ext2_ino_t ino,
 				      blk_t blk, int blockcnt);
 extern errcode_t ext2fs_add_dir_block2(ext2_dblist dblist, ext2_ino_t ino,
 				       blk64_t blk, e2_blkcnt_t blockcnt);
+extern errcode_t ext2fs_merge_dblist(ext2_dblist src, ext2_dblist dest);
 extern void ext2fs_dblist_sort(ext2_dblist dblist,
 			       EXT2_QSORT_TYPE (*sortfunc)(const void *,
 							   const void *));
-- 
2.29.2.299.gdc1121823c-goog

