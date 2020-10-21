Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93983294A51
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Oct 2020 11:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437569AbgJUJQT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Oct 2020 05:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437538AbgJUJQS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Oct 2020 05:16:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC75EC0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gv6so825410pjb.4
        for <linux-ext4@vger.kernel.org>; Wed, 21 Oct 2020 02:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k32nD6EHoa9vKyvN08CV3SJ7B2KH77AbzW3Lidp0RO8=;
        b=XvFF4zuXFgCeosWabppgNjbUgQ9nGmPxtZwgejP0BZD8PMclmtM4qUnwUSPmEyjKtI
         +0N8WOUGwDt1kWxcZV9juZCh6sgdeoYUl62YXzZx6vlGP8VQkUIuSYnO17A2GDqdeNSz
         j5kcOM24y0pxOktCTOb5dyXUecs93ngLH8kmMmhYKvM7j03Dc6acrf0eENh9gw50HjRv
         2v2EXZLurvaKfgAW7igAOqIgMEW56mpZ8EQZKNWxq1UYVGJcxhhf63KFcaE45zlabKG6
         /OtavVZMnhnDEp6cyPwZc28wcM/5hWZs3oU0JU1Y1On3Ag7YedVMzblxDgymz0U5XSE/
         e+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k32nD6EHoa9vKyvN08CV3SJ7B2KH77AbzW3Lidp0RO8=;
        b=dWxALOi8LoOOVktFjsncdfGo0J9SeapkbF06LeWlfcCzN++PUKnRbG9YxvdgBcA71f
         a6MfgmRg+hLltM4h3YitabHgDXRGZcQrxp96mEK8Wczzc3xR/nt07qj4EtG8xid7oDBr
         Cv4tJGWOjDOlLDiKmnx9ce8SlpWEeuddzs0osCh1+YxEwLFN0hVmJ7kzMJ8gh4j5n0b6
         iYIZOEJsIX/Gq0/muwU+TRHTQ7o7PrkD2ru4iNSfocPGczDD0KSnVK12Ioj86YdmY1TN
         58tAkV1NofCW3BUTwJbcnyuCcJM0KJsGFYffQogHBc3gAyECF6zEq702tEToSLe7MdCS
         vX/w==
X-Gm-Message-State: AOAM533CKCI6rhEPanpXRamywnDZ29mmb3UyLWH5pTMzFglF/sjc+YZI
        7cfI7BJVfiAQA7B7F6uRUFB9kGn6lnc=
X-Google-Smtp-Source: ABdhPJxERrImnnN+262qV+HrUw0VOZPb+sgxAlfRAbDCtebmMWGF/HretdPqVSznSWhFl9DV/pMcdg==
X-Received: by 2002:a17:902:8545:b029:d5:dbd4:4ab5 with SMTP id d5-20020a1709028545b02900d5dbd44ab5mr2426203plo.31.1603271778376;
        Wed, 21 Oct 2020 02:16:18 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x16sm1573002pff.14.2020.10.21.02.16.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 02:16:17 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 6/8] ext4: add a helper function to validate metadata block
Date:   Wed, 21 Oct 2020 17:15:26 +0800
Message-Id: <1603271728-7198-6-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
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
index e7344ef..d3ff7d9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2784,7 +2784,10 @@ extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
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
index 2efb489..2b1bc6c 100644
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

