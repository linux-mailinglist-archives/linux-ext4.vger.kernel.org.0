Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0230118C3C6
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Mar 2020 00:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCSXez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Mar 2020 19:34:55 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53243 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgCSXez (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Mar 2020 19:34:55 -0400
Received: by mail-pj1-f65.google.com with SMTP id ng8so1688213pjb.2
        for <linux-ext4@vger.kernel.org>; Thu, 19 Mar 2020 16:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9ks04LkC445RWWUGnghtjjhLKnP8EMv3FbeXLn4Igw=;
        b=ffk1O/E3LPRW/VuGo8/ybGhPipOv0WdGtB8WtNlcSNB9l/2wtwVpeCWnUyoaXA6/Cp
         iya02diFTi3duEiQNGI0QsovYk5DQ6jMsL1jyHqSM66SyWxmTSKQ0WDS+fRiY+p4mNDI
         FA3rebaBEmoD2KaomhT5pXyyWtK/hskHv37jKRw2j45WiKn7qnglo3/x0GUYihMZcHu0
         scPQUnuuSj0zVAoG7A1W6sAJQptEJC0qpjfX1DBa4bOBNe57x+OtR1dGZydFtwlQ8Ns5
         UjV7aqYQoTE7oQqzIs+66E9xZJFdJfJWMLuXJQIhtCGYNSYvEQ+eRREb28vVCq3dR26u
         3Cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9ks04LkC445RWWUGnghtjjhLKnP8EMv3FbeXLn4Igw=;
        b=fnnJ/97xjd3DQUcuoQR+bfgGiERs2buEaBhtN4JwqW0uG8mFDFccuhBwQfx0f5FGDB
         9l1k3TTg+W9B88ECNc1F7jhB50lRlhKC27hfPRYSxyTneIqQrBjewVz5uez7xjU3J1XH
         OdK/ZTXyScDiyCIhnStvK7/6lNkZ9OGUXoAfKsHUl+vlWU3c/UpfZJ/Dk3xTd/SUlmUE
         fBsI1gvppmc44mdY/2V2WpA7fhbUz9Kk/Qf6UhQQDuhwCABdjneJ8fEzi7SBjhBfB2aW
         N/dkXPIaW3dL8Bof3QQ4SZ6TaVPmnJP+7Wc/xfXkpwBceFODS4QfmMFQc2VXdILOswlr
         q9gQ==
X-Gm-Message-State: ANhLgQ33Os5okzmMW5xKUD4NFCWBS9mXuCp2oSKA9EYnhGRqvZNlSBkO
        ZrkM+A2L2HUQIMg5ffQ5TkHLu800
X-Google-Smtp-Source: ADFU+vu2XtHgMwDjXRd53nk/SGz9Z4AbcLSTDPOd8bewDeHs4RKa2fgyFhL0XAoJs4Z3DOIASJj3ag==
X-Received: by 2002:a17:90a:cc0e:: with SMTP id b14mr6628665pju.75.1584660893071;
        Thu, 19 Mar 2020 16:34:53 -0700 (PDT)
Received: from harshads0.svl.corp.google.com ([2620:15c:2cd:202:ec1e:207a:e951:9a5b])
        by smtp.googlemail.com with ESMTPSA id j17sm204353pga.18.2020.03.19.16.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 16:34:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 3/7] ext2fs: make ext2fs_calculate_summary_stats() visible
Date:   Thu, 19 Mar 2020 16:34:29 -0700
Message-Id: <20200319233433.117144-4-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
References: <20200319233433.117144-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This function allows fast_commit code to recalculate summaries. Make
it visible and move it to lib.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
---
 lib/ext2fs/ext2fs.h     |  1 +
 lib/ext2fs/initialize.c | 58 +++++++++++++++++++++++++++++++++++++++++
 misc/tune2fs.c          | 57 ----------------------------------------
 resize/resize2fs.c      |  6 ++---
 4 files changed, 62 insertions(+), 60 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index c9499839..833b6ee7 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1484,6 +1484,7 @@ errcode_t ext2fs_write_ind_block(ext2_filsys fs, blk_t blk, void *buf);
 extern errcode_t ext2fs_initialize(const char *name, int flags,
 				   struct ext2_super_block *param,
 				   io_manager manager, ext2_filsys *ret_fs);
+extern errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs);
 
 /* icount.c */
 extern void ext2fs_free_icount(ext2_icount_t icount);
diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
index 96ec1cff..193aef80 100644
--- a/lib/ext2fs/initialize.c
+++ b/lib/ext2fs/initialize.c
@@ -575,3 +575,61 @@ cleanup:
 	ext2fs_free(fs);
 	return retval;
 }
+
+errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs)
+{
+	blk64_t		blk;
+	ext2_ino_t	ino;
+	unsigned int	group = 0;
+	unsigned int	count = 0;
+	int		total_free = 0;
+	int		group_free = 0;
+
+	/*
+	 * First calculate the block statistics
+	 */
+	for (blk = fs->super->s_first_data_block;
+	     blk < ext2fs_blocks_count(fs->super); blk++) {
+		if (!ext2fs_fast_test_block_bitmap2(fs->block_map, blk)) {
+			group_free++;
+			total_free++;
+		}
+		count++;
+		if ((count == fs->super->s_blocks_per_group) ||
+		    (blk == ext2fs_blocks_count(fs->super)-1)) {
+			ext2fs_bg_free_blocks_count_set(fs, group++,
+							group_free);
+			count = 0;
+			group_free = 0;
+		}
+	}
+	total_free = EXT2FS_C2B(fs, total_free);
+	ext2fs_free_blocks_count_set(fs->super, total_free);
+
+	/*
+	 * Next, calculate the inode statistics
+	 */
+	group_free = 0;
+	total_free = 0;
+	count = 0;
+	group = 0;
+
+	/* Protect loop from wrap-around if s_inodes_count maxed */
+	for (ino = 1; ino <= fs->super->s_inodes_count && ino > 0; ino++) {
+		if (!ext2fs_fast_test_inode_bitmap2(fs->inode_map, ino)) {
+			group_free++;
+			total_free++;
+		}
+		count++;
+		if ((count == fs->super->s_inodes_per_group) ||
+		    (ino == fs->super->s_inodes_count)) {
+			ext2fs_bg_free_inodes_count_set(fs, group++,
+							group_free);
+			count = 0;
+			group_free = 0;
+		}
+	}
+	fs->super->s_free_inodes_count = total_free;
+	ext2fs_mark_super_dirty(fs);
+	return 0;
+}
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f7629952..541be2d7 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2552,63 +2552,6 @@ err_out:
 	return retval;
 }
 
-static errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs)
-{
-	blk64_t		blk;
-	ext2_ino_t	ino;
-	unsigned int	group = 0;
-	unsigned int	count = 0;
-	int		total_free = 0;
-	int		group_free = 0;
-
-	/*
-	 * First calculate the block statistics
-	 */
-	for (blk = fs->super->s_first_data_block;
-	     blk < ext2fs_blocks_count(fs->super); blk++) {
-		if (!ext2fs_fast_test_block_bitmap2(fs->block_map, blk)) {
-			group_free++;
-			total_free++;
-		}
-		count++;
-		if ((count == fs->super->s_blocks_per_group) ||
-		    (blk == ext2fs_blocks_count(fs->super)-1)) {
-			ext2fs_bg_free_blocks_count_set(fs, group++,
-							group_free);
-			count = 0;
-			group_free = 0;
-		}
-	}
-	total_free = EXT2FS_C2B(fs, total_free);
-	ext2fs_free_blocks_count_set(fs->super, total_free);
-
-	/*
-	 * Next, calculate the inode statistics
-	 */
-	group_free = 0;
-	total_free = 0;
-	count = 0;
-	group = 0;
-
-	/* Protect loop from wrap-around if s_inodes_count maxed */
-	for (ino = 1; ino <= fs->super->s_inodes_count && ino > 0; ino++) {
-		if (!ext2fs_fast_test_inode_bitmap2(fs->inode_map, ino)) {
-			group_free++;
-			total_free++;
-		}
-		count++;
-		if ((count == fs->super->s_inodes_per_group) ||
-		    (ino == fs->super->s_inodes_count)) {
-			ext2fs_bg_free_inodes_count_set(fs, group++,
-							group_free);
-			count = 0;
-			group_free = 0;
-		}
-	}
-	fs->super->s_free_inodes_count = total_free;
-	ext2fs_mark_super_dirty(fs);
-	return 0;
-}
 
 #define list_for_each_safe(pos, pnext, head) \
 	for (pos = (head)->next, pnext = pos->next; pos != (head); \
diff --git a/resize/resize2fs.c b/resize/resize2fs.c
index 2443ff67..270e4deb 100644
--- a/resize/resize2fs.c
+++ b/resize/resize2fs.c
@@ -49,7 +49,7 @@ static errcode_t inode_scan_and_fix(ext2_resize_t rfs);
 static errcode_t inode_ref_fix(ext2_resize_t rfs);
 static errcode_t move_itables(ext2_resize_t rfs);
 static errcode_t fix_resize_inode(ext2_filsys fs);
-static errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs);
+static errcode_t resize2fs_calculate_summary_stats(ext2_filsys fs);
 static errcode_t fix_sb_journal_backup(ext2_filsys fs);
 static errcode_t mark_table_blocks(ext2_filsys fs,
 				   ext2fs_block_bitmap bmap);
@@ -211,7 +211,7 @@ errcode_t resize_fs(ext2_filsys fs, blk64_t *new_size, int flags,
 		goto errout;
 
 	init_resource_track(&rtrack, "calculate_summary_stats", fs->io);
-	retval = ext2fs_calculate_summary_stats(rfs->new_fs);
+	retval = resize2fs_calculate_summary_stats(rfs->new_fs);
 	if (retval)
 		goto errout;
 	print_resource_track(rfs, &rtrack, fs->io);
@@ -2740,7 +2740,7 @@ errout:
 /*
  * Finally, recalculate the summary information
  */
-static errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs)
+static errcode_t resize2fs_calculate_summary_stats(ext2_filsys fs)
 {
 	blk64_t		blk;
 	ext2_ino_t	ino;
-- 
2.25.1.696.g5e7596f4ac-goog

