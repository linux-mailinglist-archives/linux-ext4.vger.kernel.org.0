Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15659220DE3
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jul 2020 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbgGONSa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jul 2020 09:18:30 -0400
Received: from [195.135.220.15] ([195.135.220.15]:45948 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731529AbgGONS2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 Jul 2020 09:18:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 617B3B709;
        Wed, 15 Jul 2020 13:18:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E90EB1E12CB; Wed, 15 Jul 2020 15:18:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/4] ext4: Don't allow overlapping system zones
Date:   Wed, 15 Jul 2020 15:18:10 +0200
Message-Id: <20200715131812.7243-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200715131812.7243-1-jack@suse.cz>
References: <20200715131812.7243-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Currently, add_system_zone() just silently merges two added system zones
that overlap. However the overlap should not happen and it generally
suggests that some unrelated metadata overlap which indicates the fs is
corrupted. We should have caught such problems earlier (e.g. in
ext4_check_descriptors()) but add this check as another line of defense.
In later patch we also use this for stricter checking of journal inode
extent tree.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/block_validity.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 16e9b2fda03a..b394a50ebbe3 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -68,7 +68,7 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
 			   ext4_fsblk_t start_blk,
 			   unsigned int count)
 {
-	struct ext4_system_zone *new_entry = NULL, *entry;
+	struct ext4_system_zone *new_entry, *entry;
 	struct rb_node **n = &system_blks->root.rb_node, *node;
 	struct rb_node *parent = NULL, *new_node = NULL;
 
@@ -79,30 +79,20 @@ static int add_system_zone(struct ext4_system_blocks *system_blks,
 			n = &(*n)->rb_left;
 		else if (start_blk >= (entry->start_blk + entry->count))
 			n = &(*n)->rb_right;
-		else {
-			if (start_blk + count > (entry->start_blk +
-						 entry->count))
-				entry->count = (start_blk + count -
-						entry->start_blk);
-			new_node = *n;
-			new_entry = rb_entry(new_node, struct ext4_system_zone,
-					     node);
-			break;
-		}
+		else	/* Unexpected overlap of system zones. */
+			return -EFSCORRUPTED;
 	}
 
-	if (!new_entry) {
-		new_entry = kmem_cache_alloc(ext4_system_zone_cachep,
-					     GFP_KERNEL);
-		if (!new_entry)
-			return -ENOMEM;
-		new_entry->start_blk = start_blk;
-		new_entry->count = count;
-		new_node = &new_entry->node;
-
-		rb_link_node(new_node, parent, n);
-		rb_insert_color(new_node, &system_blks->root);
-	}
+	new_entry = kmem_cache_alloc(ext4_system_zone_cachep,
+				     GFP_KERNEL);
+	if (!new_entry)
+		return -ENOMEM;
+	new_entry->start_blk = start_blk;
+	new_entry->count = count;
+	new_node = &new_entry->node;
+
+	rb_link_node(new_node, parent, n);
+	rb_insert_color(new_node, &system_blks->root);
 
 	/* Can we merge to the left? */
 	node = rb_prev(new_node);
-- 
2.16.4

