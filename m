Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D732D642E
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Dec 2020 18:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392982AbgLJR5T (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Dec 2020 12:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392977AbgLJR5S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Dec 2020 12:57:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3A3C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g18so4936562pgk.1
        for <linux-ext4@vger.kernel.org>; Thu, 10 Dec 2020 09:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/eNY1WQz1Vgmy9hBhfq4jSiPd18cYJ+UJEWgNBkc/90=;
        b=bBfr58Vlr5WioUk8Gt74jDp84VLIZZODXU1VfT1GMiU6hU8dznlt5nT6f0uMojA8qW
         w2UeU6i9DFQKDZ/lVPWiLHXR2BVqzRXAzbgl+fUYIdXlZl5ouJNnHlTe9FTs0Goy/GN6
         lpLa0OlN1PMribIKEg2BqI3gEzojY6lG8y/2UfIOW0W3WMhu2sUMmxONuh0eMO5UZzhn
         4hEP7Zmhv3EDZbD4GFMFtq7fnWaV2sA5cKJgVwVSbhaa4mBPaxAlQIu+b6yAzpuWu7Cz
         QX7aRHTvsMNJwkdH4VuvADv+DjGWsPYw9VM+vnxekxB0XuhSE8q8Uo3nUfWupanmDQVH
         KiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/eNY1WQz1Vgmy9hBhfq4jSiPd18cYJ+UJEWgNBkc/90=;
        b=nvc9keoyC14mVXxB+lE2hqb6EufsyyP2Ipl60lKD5bFUYiwgLOKuD0ulsTzpB56smt
         lapGiD7Gj/6Vq/f+9FMaaBsuET36chhIhzcKkCOJRdeyis96hHws6Fo08XRjsSQol0at
         S5ZmFHjKrOnHrYkNMvNW+RbuVwbTkUCSksWSHdzmbtfO1fziU2jr/kQPoiGK+5BxeiFk
         1ss357rCE4B2DzFMhf/Ku76MLvRv8dmY/cz2NvpcnVQzn8izZjeGsXOWfkioGCrgBbDi
         0HNTTmrmLN+Eaasf5cMrz1tZceU1Ds23fKcV6nphj+k3It1bBsB903CkOrroEJAxFskj
         1BaQ==
X-Gm-Message-State: AOAM533UIllOFH6hogTkxhemx4iHJey5Wmj/kzownCYs5ZgDTGGlQjUm
        B3otPrElMd9xKlxO+EZcQS1l62cmDxw=
X-Google-Smtp-Source: ABdhPJx4ID357k+0o71xl7Mv6SI/x9AeUMn5doPkekZXna90nPd6wx18Wko55FsRXskP4WjGMI7ySA==
X-Received: by 2002:a62:de01:0:b029:19e:a3f6:8eef with SMTP id h1-20020a62de010000b029019ea3f68eefmr6250530pfg.48.1607622997420;
        Thu, 10 Dec 2020 09:56:37 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:a6ae:11ff:fe11:86a2])
        by smtp.googlemail.com with ESMTPSA id u24sm7433517pfm.81.2020.12.10.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:56:36 -0800 (PST)
From:   harshadshirwadkar@gmail.com
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 01/15] ext2fs: move calculate_summary_stats to ext2fs lib
Date:   Thu, 10 Dec 2020 09:55:54 -0800
Message-Id: <20201210175608.3265541-2-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
References: <20201210175608.3265541-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

The function calculate_summary_stats sets the global metadata of the
file system. Tune2fs had this function defined statically in
tune2fs.c. Fast commit replay needs this function to set global
metadata at the end of the replay phase. So, move this function to
libext2fs.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Reviewed-by: Theodore Ts'o <tytso@mit.edu>
---
 lib/ext2fs/ext2fs.h     |  1 +
 lib/ext2fs/initialize.c | 94 +++++++++++++++++++++++++++++++++++++++++
 misc/tune2fs.c          | 59 +-------------------------
 resize/resize2fs.c      |  6 +--
 4 files changed, 99 insertions(+), 61 deletions(-)

diff --git a/lib/ext2fs/ext2fs.h b/lib/ext2fs/ext2fs.h
index 69c8a3ff..a8a6e091 100644
--- a/lib/ext2fs/ext2fs.h
+++ b/lib/ext2fs/ext2fs.h
@@ -1484,6 +1484,7 @@ errcode_t ext2fs_write_ind_block(ext2_filsys fs, blk_t blk, void *buf);
 extern errcode_t ext2fs_initialize(const char *name, int flags,
 				   struct ext2_super_block *param,
 				   io_manager manager, ext2_filsys *ret_fs);
+extern errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs, int super_only);
 
 /* icount.c */
 extern void ext2fs_free_icount(ext2_icount_t icount);
diff --git a/lib/ext2fs/initialize.c b/lib/ext2fs/initialize.c
index 96ec1cff..edd692bb 100644
--- a/lib/ext2fs/initialize.c
+++ b/lib/ext2fs/initialize.c
@@ -575,3 +575,97 @@ cleanup:
 	ext2fs_free(fs);
 	return retval;
 }
+
+errcode_t ext2fs_calculate_summary_stats(ext2_filsys fs, int super_only)
+{
+	blk64_t		blk;
+	ext2_ino_t	ino;
+	unsigned int	group = 0;
+	unsigned int	count = 0;
+	int		total_free = 0;
+	int		group_free = 0;
+	int		last_allocated = 0;
+	int		uninit;
+
+	/*
+	 * First calculate the block statistics
+	 */
+	uninit = 1;
+	for (blk = fs->super->s_first_data_block;
+	     blk < ext2fs_blocks_count(fs->super); blk++) {
+		if (!ext2fs_fast_test_block_bitmap2(fs->block_map, blk)) {
+			group_free++;
+			total_free++;
+		} else {
+			uninit = 0;
+		}
+		count++;
+		if ((count == fs->super->s_blocks_per_group) ||
+		    (blk == ext2fs_blocks_count(fs->super)-1)) {
+			ext2fs_bg_free_blocks_count_set(fs, group,
+							group_free);
+			if (!super_only) {
+				if (uninit && blk !=
+					ext2fs_blocks_count(fs->super) - 1)
+					ext2fs_bg_flags_set(fs, group,
+							EXT2_BG_BLOCK_UNINIT);
+				else
+					ext2fs_bg_flags_clear(fs, group,
+							EXT2_BG_BLOCK_UNINIT);
+			}
+			count = 0;
+			group_free = 0;
+			uninit = 1;
+			group++;
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
+	last_allocated = 0;
+	count = 0;
+	group = 0;
+
+	/* Protect loop from wrap-around if s_inodes_count maxed */
+	for (ino = 1; ino <= fs->super->s_inodes_count && ino > 0; ino++) {
+		if (!ext2fs_test_inode_bitmap2(fs->inode_map, ino)) {
+			group_free++;
+			total_free++;
+		} else {
+			last_allocated = ino;
+		}
+		count++;
+		if ((count == fs->super->s_inodes_per_group) ||
+		    (ino == fs->super->s_inodes_count)) {
+			if (!super_only) {
+				if (last_allocated) {
+					ext2fs_bg_flags_clear(fs, group,
+						EXT2_BG_INODE_UNINIT);
+					ext2fs_bg_itable_unused_set(fs, group,
+						fs->super->s_inodes_per_group -
+						(last_allocated %
+						fs->super->s_inodes_per_group));
+				} else {
+					ext2fs_bg_flags_set(fs, group,
+						EXT2_BG_INODE_UNINIT);
+					ext2fs_bg_itable_unused_set(fs, group,
+									0);
+				}
+				ext2fs_bg_free_inodes_count_set(fs, group,
+								group_free);
+			}
+			group++;
+			count = 0;
+			group_free = 0;
+			last_allocated = 0;
+		}
+	}
+	fs->super->s_free_inodes_count = total_free;
+	ext2fs_mark_super_dirty(fs);
+	return 0;
+}
diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index f942c698..670ed9e0 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -2603,63 +2603,6 @@ err_out:
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
@@ -2738,7 +2681,7 @@ static int resize_inode(ext2_filsys fs, unsigned long new_size)
 	if (retval)
 		goto err_out_undo;
 
-	ext2fs_calculate_summary_stats(fs);
+	ext2fs_calculate_summary_stats(fs, 1 /* super only */);
 
 	fs->super->s_state |= EXT2_VALID_FS;
 	/* mark super block and block bitmap as dirty */
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
2.29.2.576.ga3fc446d84-goog

