Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF987276AD5
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 09:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgIXHcx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 03:32:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727145AbgIXHcv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 24 Sep 2020 03:32:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66FBF3692371284CC3C3;
        Thu, 24 Sep 2020 15:32:47 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 15:32:39 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>
Subject: [PATCH v2 5/7] ext4: introduce ext4_sb_breadahead_unmovable() to replace sb_breadahead_unmovable()
Date:   Thu, 24 Sep 2020 15:33:35 +0800
Message-ID: <20200924073337.861472-6-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200924073337.861472-1-yi.zhang@huawei.com>
References: <20200924073337.861472-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If we readahead inode tables in __ext4_get_inode_loc(), it may bypass
buffer_write_io_error() check, so introduce ext4_sb_breadahead_unmovable()
to handle this special case.

This patch also replace sb_breadahead_unmovable() in ext4_fill_super()
for the sake of unification.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/inode.c |  2 +-
 fs/ext4/super.c | 12 +++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 75b46300a65c..6da1419f6ee7 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2829,6 +2829,7 @@ extern void ext4_read_bh_nowait(struct buffer_head *bh, int op_flags,
 extern int ext4_read_bh(struct buffer_head *bh, int op_flags,
 			bh_end_io_t *end_io);
 extern int ext4_read_bh_lock(struct buffer_head *bh, int op_flags, bool wait);
+extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
 extern int ext4_calculate_overhead(struct super_block *sb);
 extern void ext4_superblock_csum_set(struct super_block *sb);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 171df289ef7e..e106d03e4b77 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4358,7 +4358,7 @@ static int __ext4_get_inode_loc(struct inode *inode,
 			if (end > table)
 				end = table;
 			while (b <= end)
-				sb_breadahead_unmovable(sb, b++);
+				ext4_sb_breadahead_unmovable(sb, b++);
 		}
 
 		/*
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0adba4871f57..b24e68eff48d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -229,6 +229,16 @@ ext4_sb_bread(struct super_block *sb, sector_t block, int op_flags)
 	return bh;
 }
 
+void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
+{
+	struct buffer_head *bh = sb_getblk_gfp(sb, block, 0);
+
+	if (likely(bh)) {
+		ext4_read_bh_lock(bh, REQ_RAHEAD, false);
+		brelse(bh);
+	}
+}
+
 static int ext4_verify_csum_type(struct super_block *sb,
 				 struct ext4_super_block *es)
 {
@@ -4545,7 +4555,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	/* Pre-read the descriptors into the buffer cache */
 	for (i = 0; i < db_count; i++) {
 		block = descriptor_loc(sb, logical_sb_block, i);
-		sb_breadahead_unmovable(sb, block);
+		ext4_sb_breadahead_unmovable(sb, block);
 	}
 
 	for (i = 0; i < db_count; i++) {
-- 
2.25.4

