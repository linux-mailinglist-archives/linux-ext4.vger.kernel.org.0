Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE752037A3
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jun 2020 15:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbgFVNOu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jun 2020 09:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgFVNOu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jun 2020 09:14:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3E0C061573
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 06:14:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b16so8371002pfi.13
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jun 2020 06:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u5LMvCrHiVc4+R89dGCd+0uwsmV2LFZgnS4bVPEgYM4=;
        b=HFFhJUbImxIrVb3WcbgKcSOI8iaxAMSmlLaUJbk9Q7Z6NH8HOzxgNQfYv+xQbqs9iH
         QYfeMKlJ2psGq9dvGa1bI97vw5eHz+aOPGBIlK3Cb1EYv8irbMQUHzYazlS57M3kK/S7
         PhQrVSQYWjQh0kFzpcA6Xi+z2JPC3GQEybtxTibIkG09YkUdzkQiCFReNDYCHSpR6WxQ
         YXv8wZUiBhR1VDEYvvSp9eOz8odNkC0L3c2vvQv+yDBulIlgrEKwd/idX3SH1k0wNyDj
         GtdHQzigeLcX/Gmgd4w3636zDxRve4WGl9D7Ki+58ExWLmGaVUnEgiQKKtB6u8fLuOiq
         F7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u5LMvCrHiVc4+R89dGCd+0uwsmV2LFZgnS4bVPEgYM4=;
        b=GjO9hEnYPGQw06WAxHM/qsvVbZ5YaunsWRaDo+8zRYZyZODGIDQgBKUuucDrVphRrU
         v92hXIHdvy6srp15FY05LF+EhI9sb1iPhpU0xQimqF8a9ADqG87EbRx27CowR8v8u4nj
         oRMo7FEtHdFoMB8AHBIqzZxwCP1zBijOppHWK9u9E/RNBXJTW8758vpAHZ1lkZdav7L0
         Bx6Xwn5ecSeQm35cHgCxIR49AWeultAWjW+hnfi4rEmuIWz3PAHmqHvBKwAJtSq7BpvV
         1hg3MC3urimarDSFN5vv/+xR8vCOVTjK8g2lTz4oAPapWJxDDA6JgOSUFZEtVZoylrUD
         HB4Q==
X-Gm-Message-State: AOAM5334f4lpoLZfnQSvBbpf9RSxKu0G0TTxefv/RNNSlut5f204WOEI
        YIviuDCrxB0zduyLkAQT8Gfh7KpzIOk=
X-Google-Smtp-Source: ABdhPJxfs9rfj7BKWsjv22GaXg4OEPIxKdnwiK3Gqm8xTL/QbA1zZxZxy1CR/AGxg99NVwzUKwaTsA==
X-Received: by 2002:a65:6447:: with SMTP id s7mr11884420pgv.320.1592831689398;
        Mon, 22 Jun 2020 06:14:49 -0700 (PDT)
Received: from localhost.localdomain (ftp.datadirectnet.jp. [182.171.80.51])
        by smtp.gmail.com with ESMTPSA id v62sm2652291pfb.119.2020.06.22.06.14.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:14:48 -0700 (PDT)
From:   Wang Shilong <wangshilong1991@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize trim
Date:   Mon, 22 Jun 2020 22:14:36 +0900
Message-Id: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Wang Shilong <wshilong@ddn.com>

Currently WAS_TRIMMED flag is not persistent, whenever filesystem was
remounted, fstrim need walk all block groups again, the problem with
this is FSTRIM could be slow on very large LUN SSD based filesystem.

To avoid this kind of problem, we introduce a block group flag
EXT4_BG_WAS_TRIMMED, the side effect of this is we need introduce
extra one block group dirty write after trimming block group.

And When clearing TRIMMED flag, block group will be journalled
anyway, so it won't introduce any overhead.

Cc: Shuichi Ihara <sihara@ddn.com>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Wang Shilong <wangshilong1991@gmail.com>
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
v2->v3:
don't renumber EXT4_GROUP_INFO_* bits.
v1->v2:
call ext4_journal_get_write_access() before modify buffer.
---
 fs/ext4/ext4.h      | 14 +++++------
 fs/ext4/ext4_jbd2.h |  3 ++-
 fs/ext4/mballoc.c   | 59 +++++++++++++++++++++++++++++++++------------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 42f5060f3cdf..252754da2f1b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -368,6 +368,7 @@ struct flex_groups {
 #define EXT4_BG_INODE_UNINIT	0x0001 /* Inode table/bitmap not in use */
 #define EXT4_BG_BLOCK_UNINIT	0x0002 /* Block bitmap not in use */
 #define EXT4_BG_INODE_ZEROED	0x0004 /* On-disk itable initialized to zero */
+#define EXT4_BG_WAS_TRIMMED	0x0008 /* block group was trimmed */
 
 /*
  * Macro-instructions used to manage group descriptors
@@ -3138,7 +3139,6 @@ struct ext4_group_info {
 };
 
 #define EXT4_GROUP_INFO_NEED_INIT_BIT		0
-#define EXT4_GROUP_INFO_WAS_TRIMMED_BIT		1
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT_BIT	2
 #define EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT	3
 #define EXT4_GROUP_INFO_BBITMAP_CORRUPT		\
@@ -3153,12 +3153,12 @@ struct ext4_group_info {
 #define EXT4_MB_GRP_IBITMAP_CORRUPT(grp)	\
 	(test_bit(EXT4_GROUP_INFO_IBITMAP_CORRUPT_BIT, &((grp)->bb_state)))
 
-#define EXT4_MB_GRP_WAS_TRIMMED(grp)	\
-	(test_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_SET_TRIMMED(grp)	\
-	(set_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
-#define EXT4_MB_GRP_CLEAR_TRIMMED(grp)	\
-	(clear_bit(EXT4_GROUP_INFO_WAS_TRIMMED_BIT, &((grp)->bb_state)))
+#define EXT4_MB_GDP_WAS_TRIMMED(gdp)	\
+	(gdp->bg_flags & cpu_to_le16(EXT4_BG_WAS_TRIMMED))
+#define EXT4_MB_GDP_SET_TRIMMED(gdp)	\
+	(gdp->bg_flags |= cpu_to_le16(EXT4_BG_WAS_TRIMMED))
+#define EXT4_MB_GDP_CLEAR_TRIMMED(gdp)	\
+	(gdp->bg_flags &= ~cpu_to_le16(EXT4_BG_WAS_TRIMMED))
 
 #define EXT4_MAX_CONTENTION		8
 #define EXT4_CONTENTION_THRESHOLD	2
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index 00dc668e052b..a37e438f4b4d 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -123,7 +123,8 @@
 #define EXT4_HT_MOVE_EXTENTS     9
 #define EXT4_HT_XATTR           10
 #define EXT4_HT_EXT_CONVERT     11
-#define EXT4_HT_MAX             12
+#define EXT4_HT_FS_TRIM		12
+#define EXT4_HT_MAX             13
 
 /**
  *   struct ext4_journal_cb_entry - Base structure for callback information.
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c0a331e2feb0..235a316584d0 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2923,15 +2923,6 @@ static void ext4_free_data_in_buddy(struct super_block *sb,
 	rb_erase(&entry->efd_node, &(db->bb_free_root));
 	mb_free_blocks(NULL, &e4b, entry->efd_start_cluster, entry->efd_count);
 
-	/*
-	 * Clear the trimmed flag for the group so that the next
-	 * ext4_trim_fs can trim it.
-	 * If the volume is mounted with -o discard, online discard
-	 * is supported and the free blocks will be trimmed online.
-	 */
-	if (!test_opt(sb, DISCARD))
-		EXT4_MB_GRP_CLEAR_TRIMMED(db);
-
 	if (!db->bb_free_root.rb_node) {
 		/* No more items in the per group rb tree
 		 * balance refcounts from ext4_mb_free_metadata()
@@ -5084,8 +5075,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 					 " group:%d block:%d count:%lu failed"
 					 " with %d", block_group, bit, count,
 					 err);
-		} else
-			EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
+		}
 
 		ext4_lock_group(sb, block_group);
 		mb_clear_bits(bitmap_bh->b_data, bit, count_clusters);
@@ -5095,6 +5085,14 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 	ret = ext4_free_group_clusters(sb, gdp) + count_clusters;
 	ext4_free_group_clusters_set(sb, gdp, ret);
 	ext4_block_bitmap_csum_set(sb, block_group, gdp, bitmap_bh);
+	/*
+	 * Clear the trimmed flag for the group so that the next
+	 * ext4_trim_fs can trim it.
+	 * If the volume is mounted with -o discard, online discard
+	 * is supported and the free blocks will be trimmed online.
+	 */
+	if (!test_opt(sb, DISCARD))
+		EXT4_MB_GDP_CLEAR_TRIMMED(gdp);
 	ext4_group_desc_csum_set(sb, block_group, gdp);
 	ext4_unlock_group(sb, block_group);
 
@@ -5348,8 +5346,15 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_grpblk_t next, count = 0, free_count = 0;
 	struct ext4_buddy e4b;
 	int ret = 0;
+	struct ext4_group_desc *gdp;
+	struct buffer_head *gdp_bh;
 
 	trace_ext4_trim_all_free(sb, group, start, max);
+	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
+	if (!gdp) {
+		ret = -EIO;
+		return ret;
+	}
 
 	ret = ext4_mb_load_buddy(sb, group, &e4b);
 	if (ret) {
@@ -5360,7 +5365,7 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	bitmap = e4b.bd_bitmap;
 
 	ext4_lock_group(sb, group);
-	if (EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) &&
+	if (EXT4_MB_GDP_WAS_TRIMMED(gdp) &&
 	    minblocks >= atomic_read(&EXT4_SB(sb)->s_last_trim_minblks))
 		goto out;
 
@@ -5399,14 +5404,38 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 			break;
 	}
 
-	if (!ret) {
+	if (!ret)
 		ret = count;
-		EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	}
 out:
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
+	if (ret > 0) {
+		int err;
+		handle_t *handle;
 
+		handle = ext4_journal_start_sb(sb, EXT4_HT_FS_TRIM, 1);
+		if (IS_ERR(handle)) {
+			ret = PTR_ERR(handle);
+			goto out_return;
+		}
+		err = ext4_journal_get_write_access(handle, gdp_bh);
+		if (err) {
+			ret = err;
+			goto out_journal;
+		}
+		ext4_lock_group(sb, group);
+		EXT4_MB_GDP_SET_TRIMMED(gdp);
+		ext4_group_desc_csum_set(sb, group, gdp);
+		ext4_unlock_group(sb, group);
+		err = ext4_handle_dirty_metadata(handle, NULL, gdp_bh);
+		if (err)
+			ret = err;
+out_journal:
+		err = ext4_journal_stop(handle);
+		if (err)
+			ret = err;
+	}
+out_return:
 	ext4_debug("trimmed %d blocks in the group %d\n",
 		count, group);
 
-- 
2.25.4

