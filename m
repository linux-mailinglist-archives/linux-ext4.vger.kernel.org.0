Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B882AA67D
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 16:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKGP6u (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Nov 2020 10:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgKGP6t (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Nov 2020 10:58:49 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDBEC0613D2
        for <linux-ext4@vger.kernel.org>; Sat,  7 Nov 2020 07:58:48 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id g11so2384170pll.13
        for <linux-ext4@vger.kernel.org>; Sat, 07 Nov 2020 07:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+lZahwwfV9r2OInABAfNirNFAo1rXbypb6sLrp5REfw=;
        b=CQUHCzSUj+ZhNwrLn9kTJnY3IOW6OqQ3vUOi5/x13kKq7MgkcN4px0PaGhyAu3wEUo
         hgzQfs6i+jXkIaVUMDtNnrftt4OotYHME/GEBeX8g7FlqjpoPJH47nxWQD9nmEsVdVAi
         zZPIzERzrUZQBFGXc604cbebfXZPV7oCRMZ4okZ4s9GxSo+O9FWCSiseo6/CDhvTfl2C
         gAGLsDjqt0OuGbTCcRtl9BsaE1drwpuPm7QAzMCSrY5p1vvxAvIbfBsaKCbey83VzuwP
         gai9tNcb3oG3Zz4bP4d95LgeCORB7O2dqd66qFEa9SEPHTmjOQ1aTmLAwLkJ0XWa3rmc
         iTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+lZahwwfV9r2OInABAfNirNFAo1rXbypb6sLrp5REfw=;
        b=GTdW5rPudcDqlqmRXDeyH/U6WxTzZBc9WKyIy+xnyefbVuPXlB/XHyw79N3TFBvV6Z
         MU0iVrRo3bIWUmizaNzOted2RnBLty8rKau3PJUHysMrzQH31SVfmb16KSmZE3rDv2he
         mx+pULi4ddSlkxJ8fHnNYcxuYxcQdbUTH3cOV4oM/OmDSI0HZeX92F2vxfnfkauPRjbR
         XOxVsgZ8bAnsXvOHVXZYeHGBtIUAhYAi28Xp53EolLUFwBSGnFpDACy2mDkQuV9dUDze
         DbgiTVLNlJ46ZZJBKjZh/aVok3F0Cv3WYsUbsWzDPNcH5iwQGXUPHHjPA6SonRZVXotu
         gAoQ==
X-Gm-Message-State: AOAM5332o3cis/wxWm2DZVvt/DMj9iyqCd5VooQZdtU4fDNY34JegXlI
        Ln9KPQnXp1qdUR6gXJwkHnSPXMMi7vo=
X-Google-Smtp-Source: ABdhPJxCXPGCdcIfDepJKgKyzn0cnsSUOfmPNWoSNF5riodvKPX0jlG1nLg4EnagOFFNhgXF0TAz8A==
X-Received: by 2002:a17:902:8508:b029:d5:af79:8b40 with SMTP id bj8-20020a1709028508b02900d5af798b40mr5890736plb.28.1604764728478;
        Sat, 07 Nov 2020 07:58:48 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id e81sm6049956pfh.104.2020.11.07.07.58.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 07:58:48 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/8] ext4: add a helper function to validate metadata block
Date:   Sat,  7 Nov 2020 23:58:16 +0800
Message-Id: <1604764698-4269-6-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
References: <1604764698-4269-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

There is a need to check whether a block or a segment overlaps
with metadata, since information of system_zone is incomplete,
we need a more accurate function. Now we check whether it
overlaps with block bitmap, inode bitmap, and inode table.
Perhaps it is better to add a check of super_block and block
group descriptor and provide a helper function.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 fs/ext4/ext4.h    |  5 ++++-
 fs/ext4/mballoc.c | 57 +++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index bd88b4a..73d59cb 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2801,7 +2801,10 @@ extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
 				     unsigned int nr, int *cnt);
 extern void ext4_mb_prefetch_fini(struct super_block *sb, ext4_group_t group,
 				  unsigned int nr);
-
+extern int ext4_metadata_block_overlaps(struct super_block *sb,
+					ext4_group_t block_group,
+					ext4_fsblk_t block,
+					unsigned long count);
 extern void ext4_free_blocks(handle_t *handle, struct inode *inode,
 			     struct buffer_head *bh, ext4_fsblk_t block,
 			     unsigned long count, int flags);
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 29dfeb04..d8704fe 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5061,6 +5061,49 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 	kmem_cache_free(ext4_free_data_cachep, entry);
 }
 
+/*
+ * Returns 1 if the passed-in block region (block, block+count)
+ * overlaps with some other filesystem metadata blocks. Others,
+ * return 0.
+ */
+int ext4_metadata_block_overlaps(struct super_block *sb,
+				 ext4_group_t block_group,
+				 ext4_fsblk_t block,
+				 unsigned long count)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct ext4_group_desc *gdp;
+	int gd_first = ext4_group_first_block_no(sb, block_group);
+	int itable, gd_blk;
+	int ret = 0;
+
+	gdp = ext4_get_group_desc(sb, block_group, NULL);
+	// check block bitmap and inode bitmap
+	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
+	    in_range(ext4_inode_bitmap(sb, gdp), block, count))
+		ret = 1;
+
+	// check inode table
+	itable = ext4_inode_table(sb, gdp);
+	if (!(block >= itable + sbi->s_itb_per_group ||
+	      block + count - 1  < itable))
+		ret = 1;
+
+	/* check super_block and block group descriptor table, the
+	 * reserved space of the block group descriptor is managed
+	 * by resize_inode, it may not be processed now due to
+	 * performance.
+	 */
+	gd_blk = ext4_bg_has_super(sb, block_group) +
+		ext4_bg_num_gdb(sb, block_group);
+	if (gd_blk) {
+		if (!(block >= gd_first + gd_blk ||
+		      block + count - 1 < gd_first))
+			ret = 1;
+	}
+	return ret;
+}
+
 static noinline_for_stack int
 ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
 		      struct ext4_free_data *new_entry)
@@ -5360,13 +5403,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, gdp), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, gdp), block, count) ||
-	    in_range(block, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, gdp),
-		     sbi->s_itb_per_group)) {
-
+	if (ext4_metadata_block_overlaps(sb, block_group, block, count)) {
 		ext4_error(sb, "Freeing blocks in system zone - "
 			   "Block = %llu, count = %lu", block, count);
 		/* err = 0. ext4_std_error should be a no op */
@@ -5552,11 +5589,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
 		goto error_return;
 	}
 
-	if (in_range(ext4_block_bitmap(sb, desc), block, count) ||
-	    in_range(ext4_inode_bitmap(sb, desc), block, count) ||
-	    in_range(block, ext4_inode_table(sb, desc), sbi->s_itb_per_group) ||
-	    in_range(block + count - 1, ext4_inode_table(sb, desc),
-		     sbi->s_itb_per_group)) {
+	if (ext4_metadata_block_overlaps(sb, block_group, block, count)) {
 		ext4_error(sb, "Adding blocks in system zones - "
 			   "Block = %llu, count = %lu",
 			   block, count);
-- 
1.8.3.1

