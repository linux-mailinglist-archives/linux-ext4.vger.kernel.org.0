Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026D3292434
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Oct 2020 11:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgJSJCt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Oct 2020 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgJSJCt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 19 Oct 2020 05:02:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE3AC0613CE
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id j8so5301345pjy.5
        for <linux-ext4@vger.kernel.org>; Mon, 19 Oct 2020 02:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DJWE+V6oYUUVNrPztdFbqBlbq/KadGB/t9tBIq7b4/4=;
        b=ANbeFq/ODGH8qElF1lX44XO2tXeTLwFzy25YQ44OVVKQeZJ1x65AE8taAvgJ8cZU5z
         5FW/cmvcLXUX+n96S/J2qzbc9E/oEetmKZkfVcTUalJZJdZ4+oukBScfbiX0MEkYZjhi
         O54j34I2LwNpYTabCNN7NVjLNPVXe8xRBfcBy9AaLUNhFFmRSucBvAh9GgNKN5E4WmPx
         Byo9lF+bb6HPqPDCLSkndKvVgcrzCEbeuZliz6JzBF5j6jLvfYwugh9HiQG4ulWFoaVS
         LDXvqfXliG9nZDM2KT3qs2JltLfVDUaOTi15jnAhCz4C4MbnXNMDSFGlZcULUFRMzhfk
         T1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DJWE+V6oYUUVNrPztdFbqBlbq/KadGB/t9tBIq7b4/4=;
        b=mrpAZimoM6o5vChK5frSKYxdhm/ue7OlYMTsqGObIff1VVSgOafGx6Gll+5U0k8ioB
         3OYcRBCL+Z7mPnp7hy8mwIBm7UAEVn266UqGl/2grfmsiNUDZ+E/JtYcUvEMa0PM7MBY
         B7w99tiyuW+MNmnE6jclp1tubkSuXZp895IRwDnOQxf+y5G4uG8gT5X2bFmqKbVWEgf0
         DNUnmdXrhCYJoQqMBuk2HJIm6U9UA8P8MIkA8RVBL2AE6WccN5Rw9//mvPtaK+zAwQSC
         Dlkcmn39i3V8XwFXjGZVg6N/zaoS41VVXZxgclqXHc8yig3niM+vADhRfJsS8ryj6pSQ
         9ZLA==
X-Gm-Message-State: AOAM5317PDJW1pFrVSC+afOjzY6rYezS/uoBBVhfe3BgU1uuOPEITTnp
        0trIyCuUiEi1grHqChjD3yqkjFB+LqY=
X-Google-Smtp-Source: ABdhPJzL1LlTb8eTeOw7C19qsPvIdXhyuruDGC9c4zNE24oZnxZmSJ0Ave4fbfMm2vrYU6inrFHgig==
X-Received: by 2002:a17:90a:b896:: with SMTP id o22mr16254844pjr.130.1603098168901;
        Mon, 19 Oct 2020 02:02:48 -0700 (PDT)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id 14sm11422880pjn.48.2020.10.19.02.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:02:48 -0700 (PDT)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org
Subject: [PATCH v2 6/8] ext4: add a helper function to validate metadata block
Date:   Mon, 19 Oct 2020 17:02:36 +0800
Message-Id: <1603098158-30406-6-git-send-email-brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
References: <1603098158-30406-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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
index 512f833..1ea700d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2701,7 +2701,10 @@ extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
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
index 56075ce..e0a4265 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5044,6 +5044,49 @@ static void ext4_try_merge_freed_extent(struct ext4_sb_info *sbi,
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
@@ -5170,13 +5213,7 @@ void ext4_free_blocks(handle_t *handle, struct inode *inode,
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
@@ -5362,11 +5399,7 @@ int ext4_group_add_blocks(handle_t *handle, struct super_block *sb,
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

