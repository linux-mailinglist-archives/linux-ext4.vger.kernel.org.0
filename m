Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB83D230AEE
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 15:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbgG1NEu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jul 2020 09:04:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:42890 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgG1NEr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jul 2020 09:04:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9A7DB138;
        Tue, 28 Jul 2020 13:04:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7DD901E12CF; Tue, 28 Jul 2020 15:04:45 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4/6] ext4: Fold ext4_data_block_valid_rcu() into the caller
Date:   Tue, 28 Jul 2020 15:04:35 +0200
Message-Id: <20200728130437.7804-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200728130437.7804-1-jack@suse.cz>
References: <20200728130437.7804-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After the previous patch, ext4_data_block_valid_rcu() has a single
caller. Fold it into it.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c | 69 ++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index e830a9d4e10d..9c40214f31f9 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -144,40 +144,6 @@ static void debug_print_tree(struct ext4_sb_info *sbi)
 	printk(KERN_CONT "\n");
 }
 
-/*
- * Returns 1 if the passed-in block region (start_blk,
- * start_blk+count) is valid; 0 if some part of the block region
- * overlaps with filesystem metadata blocks.
- */
-static int ext4_data_block_valid_rcu(struct ext4_sb_info *sbi,
-				     struct ext4_system_blocks *system_blks,
-				     ext4_fsblk_t start_blk,
-				     unsigned int count, ino_t ino)
-{
-	struct ext4_system_zone *entry;
-	struct rb_node *n;
-
-	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
-	    (start_blk + count < start_blk) ||
-	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
-		return 0;
-
-	if (system_blks == NULL)
-		return 1;
-
-	n = system_blks->root.rb_node;
-	while (n) {
-		entry = rb_entry(n, struct ext4_system_zone, node);
-		if (start_blk + count - 1 < entry->start_blk)
-			n = n->rb_left;
-		else if (start_blk >= (entry->start_blk + entry->count))
-			n = n->rb_right;
-		else
-			return entry->ino == ino;
-	}
-	return 1;
-}
-
 static int ext4_protect_reserved_inode(struct super_block *sb,
 				       struct ext4_system_blocks *system_blks,
 				       u32 ino)
@@ -333,11 +299,24 @@ void ext4_release_system_zone(struct super_block *sb)
 		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
 }
 
+/*
+ * Returns 1 if the passed-in block region (start_blk,
+ * start_blk+count) is valid; 0 if some part of the block region
+ * overlaps with some other filesystem metadata blocks.
+ */
 int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 			  unsigned int count)
 {
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_system_blocks *system_blks;
-	int ret;
+	struct ext4_system_zone *entry;
+	struct rb_node *n;
+	int ret = 1;
+
+	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (start_blk + count < start_blk) ||
+	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
+		return 0;
 
 	/*
 	 * Lock the system zone to prevent it being released concurrently
@@ -345,9 +324,23 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 	 * mount option.
 	 */
 	rcu_read_lock();
-	system_blks = rcu_dereference(EXT4_SB(inode->i_sb)->system_blks);
-	ret = ext4_data_block_valid_rcu(EXT4_SB(inode->i_sb), system_blks,
-					start_blk, count, inode->i_ino);
+	system_blks = rcu_dereference(sbi->system_blks);
+	if (system_blks == NULL)
+		goto out_rcu;
+
+	n = system_blks->root.rb_node;
+	while (n) {
+		entry = rb_entry(n, struct ext4_system_zone, node);
+		if (start_blk + count - 1 < entry->start_blk)
+			n = n->rb_left;
+		else if (start_blk >= (entry->start_blk + entry->count))
+			n = n->rb_right;
+		else {
+			ret = (entry->ino == inode->i_ino);
+			break;
+		}
+	}
+out_rcu:
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.16.4

