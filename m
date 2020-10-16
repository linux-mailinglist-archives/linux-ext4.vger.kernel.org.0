Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FACD28FD07
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Oct 2020 05:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394329AbgJPD4N (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 23:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394317AbgJPD4K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 23:56:10 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AD1C0613CF
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:09 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so696314pfc.7
        for <linux-ext4@vger.kernel.org>; Thu, 15 Oct 2020 20:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wCpVy1l/c8osGcMcMzgFckN+O6HB9uY3OQ0jjR99Zek=;
        b=Ba2JRSut+zVKp0kE2d05gcbCOecX1it0E/t6fbzj6grQT/28tWFRRyTF7opG+snG1c
         8chBfH/0VQiNdNuBOMW47zQzVnl/u7cH2OwT4uOdT6FNw9K6P+1ypC5BHPVEenCU/i0L
         2dCZE9D1IDvsM4wC42PkwakGJj+/geS3FezNuaXZlLajKp/0J8L9ohSI8lwXFZDumYZk
         I0MTuVNVRWArNbX6ouzqxg/dDXg6Th+RifUPbSrA+pUBnvmqR5Rck/YIXTcJ/j9yvvFi
         UUwwNXj1F2nW8yEOEquir/lY7bcg/V2e873MDTTfC6opaXPlom4uhHcCwjXcHJSJqO5F
         AnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wCpVy1l/c8osGcMcMzgFckN+O6HB9uY3OQ0jjR99Zek=;
        b=Y5R0FdYoJqf+PYwg+VDl243BHipBSZ9SFC1Bvk1XCPmUiBKsVaSJiA+Cxe4gkZSD4W
         PSvcEc1eB1IT5KWmUlY5QUCRNRqw7KhhBervCOTWq8hHcUp0EsTPBwfq+vYPBsN4Ri2Z
         a7rlGEqcBQd0sxOkQUiEwg9KfNRxcH64qErLOUgbv3096SM3lRGUnrQgyNA1iLU5uQfF
         XKAHcXvtLP4elitUYsfN+ZgiF22Kr3kBlWnwLCQuvxfovNcex88p+Dl1cgM9u5f1/d0l
         1jiSeFI+5EvLnPk2wK0nU+nPUcEBXdW2IoWPN6OLyrWVgPVf2p8gEfprxD27LdrBwj+Q
         LJ9w==
X-Gm-Message-State: AOAM5314716/tJgchKs/eSaPOxpA0qsTIrgyHxAyyW1CsOp+o3vP86vr
        GhYv6zcIJlBVXKOL2cNGUrU=
X-Google-Smtp-Source: ABdhPJyYzqlvo2TrDZXw+49nWODuc+zUkx6bNz7kLYw6wJwVSvWoLDxT2dVZxeShfccw2qCprBS9Hg==
X-Received: by 2002:a62:e70c:0:b029:155:dd3d:f349 with SMTP id s12-20020a62e70c0000b0290155dd3df349mr1981376pfh.32.1602820569225;
        Thu, 15 Oct 2020 20:56:09 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id v12sm861555pgr.4.2020.10.15.20.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Oct 2020 20:56:08 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH 7/8] ext4: add a helper function to validate metadata block
Date:   Fri, 16 Oct 2020 11:55:51 +0800
Message-Id: <1602820552-4082-7-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
References: <1602820552-4082-1-git-send-email-brookxu@tencent.com>
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
index 85d6900..42be90e 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2702,7 +2702,10 @@ extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
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
index 2eead37..e8df64d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5049,6 +5049,49 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
 	return 0;
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
 /**
  * ext4_free_blocks() -- Free given blocks and update quota
  * @handle:		handle for this transaction
@@ -5175,13 +5218,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
@@ -5367,11 +5404,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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

