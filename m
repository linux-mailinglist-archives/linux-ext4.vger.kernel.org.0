Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7722EB63
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgG0Lof (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:44:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45930 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgG0Loc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:44:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA76FB692;
        Mon, 27 Jul 2020 11:44:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5AEDB1E12CD; Mon, 27 Jul 2020 13:44:30 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4/6] ext4: Fold ext4_data_block_valid_rcu() into the caller
Date:   Mon, 27 Jul 2020 13:44:27 +0200
Message-Id: <20200727114429.1478-5-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200727114429.1478-1-jack@suse.cz>
References: <20200727114429.1478-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After the previous patch, ext4_data_block_valid_rcu() has a single
caller. Fold it into it.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c | 67 ++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 3602356cbf09..9c40214f31f9 100644
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
@@ -346,8 +325,22 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
 	 */
 	rcu_read_lock();
 	system_blks = rcu_dereference(sbi->system_blks);
-	ret = ext4_data_block_valid_rcu(EXT4_SB(inode->i_sb), system_blks,
-					start_blk, count, inode->i_ino);
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

